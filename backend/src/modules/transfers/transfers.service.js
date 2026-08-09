const transfersRepository = require('./transfers.repository');
const { httpError } = require('../../shared/utils/http-error');

/**
 * Transfers Service
 *
 * Contains all business logic for the transfers (shipments) module.
 * Orchestrates validation, authorization checks, and repository calls.
 */
class TransfersService {
  /**
   * Create a new shipment from Admin to Seller
   *
   * Business Logic:
   * - Validate seller exists
   * - Validate every product exists
   * - Validate admin has sufficient AVAILABLE inventory for each product
   * - Calculate total quantity and total price
   * - Create shipment record with PENDING status
   * - No inventory changes at creation time
   *
   * Input: data (request body), adminId (authenticated admin user ID)
   * Output: Created shipment summary
   */
  async createTransfer(data, adminId) {
    // 1. Validate seller exists
    const seller = await transfersRepository.findSellerById(data.seller_id);
    if (!seller) {
      throw httpError(404, 'Seller not found');
    }

    // 2. Validate each product and check admin inventory
    // Use Promise.all() for parallel execution of independent product validations
    let totalQuantity = 0;
    let totalAmount = 0;

    await Promise.all(
      data.items.map(async (item) => {
        // Validate product exists
        const product = await transfersRepository.findProductById(item.product_id);
        if (!product) {
          throw httpError(404, `Product with ID ${item.product_id} not found`);
        }

        // Validate admin has sufficient inventory
        const availableCount = await transfersRepository.countAvailableUnits(adminId, item.product_id);
        if (availableCount < item.quantity) {
          throw httpError(400, 
            `Insufficient inventory for product ID ${item.product_id}. Available: ${availableCount}, Requested: ${item.quantity}`
          );
        }
      })
    );

    // 3. Calculate totals
    for (const item of data.items) {
      totalQuantity += item.quantity;
      totalAmount += item.quantity * item.price_per_piece;
    }

    // 4. Create shipment with items
    const shipment = await transfersRepository.createShipment({
      fromUserId: adminId,
      toUserId: BigInt(data.seller_id),
      totalProductsShipped: totalQuantity,
      shipmentPrice: totalAmount,
      items: data.items.map(item => ({
        productId: BigInt(item.product_id),
        quantity: item.quantity,
        pricePerPiece: item.price_per_piece
      }))
    });

    return {
      shipment_id: Number(shipment.id),
      seller_name: seller.userName,
      shop_name: seller.shopName,
      total_products: totalQuantity,
      total_amount: totalAmount,
      status: shipment.status,
      created_at: shipment.createdAt
    };
  }

  /**
   * Get shipments list based on user role
   *
   * Admin: Gets all shipments
   * Seller: Gets only shipments where toUserId matches their ID
   *
   * Input: user object from req.user (populated by auth middleware)
   * Output: Array of formatted shipment summaries
   */
  async getTransfers(user) {
    let shipments;

    if (user.role === 'ADMIN') {
      shipments = await transfersRepository.getAllShipments();
    } else if (user.role === 'SELLER') {
      shipments = await transfersRepository.getShipmentsBySeller(user.id);
    } else {
      // EMPLOYEE / unknown — no legacy transfer list (use /api/employee/shipments)
      return [];
    }

    return shipments.map(s => ({
      shipment_id: Number(s.id),
      seller_name: s.toUser.userName,
      shop_name: s.toUser.shopName,
      status: s.status,
      total_products: s.totalProductsShipped,
      total_amount: s.shipmentPrice,
      created_at: s.createdAt
    }));
  }

  /**
   * Get complete shipment details by ID
   *
   * Authorization:
   * - Admin can view any shipment
   * - Seller can only view shipments assigned to them
   * - Employee/others: forbidden (legacy module; new path is /api/shipments)
   *
   * Input: shipmentId, user object from req.user
   * Output: Full shipment details including items with product info
   */
  async getTransferById(shipmentId, user) {
    const shipment = await transfersRepository.findShipmentById(shipmentId);

    if (!shipment) {
      throw httpError(404, 'Shipment not found');
    }

    if (user.role === 'ADMIN') {
      // ok
    } else if (user.role === 'SELLER' && Number(shipment.toUserId) === Number(user.id)) {
      // ok
    } else {
      throw httpError(403, 'Forbidden: You do not have access to this shipment');
    }

    return {
      shipment_id: Number(shipment.id),
      status: shipment.status,
      created_at: shipment.createdAt,
      delivered_on: shipment.deliveredOn,
      sender: {
        id: Number(shipment.fromUser.id),
        user_name: shipment.fromUser.userName,
        shop_name: shipment.fromUser.shopName
      },
      receiver: {
        id: Number(shipment.toUser.id),
        user_name: shipment.toUser.userName,
        shop_name: shipment.toUser.shopName
      },
      total_products: shipment.totalProductsShipped,
      total_amount: shipment.shipmentPrice,
      items: shipment.items.map(item => ({
        product_id: Number(item.productId),
        category: item.product.category.name,
        product_name: item.product.productName.name,
        product_model: item.product.productModel.name,
        quantity: item.quantity,
        price_per_piece: item.pricePerPiece,
        line_total: item.quantity * Number(item.pricePerPiece)
      }))
    };
  }

  /**
   * Receive a shipment (Seller only)
   *
   * Business Logic:
   * - Shipment must exist
   * - Shipment status must be PENDING
   * - Authenticated seller must match shipment receiver (toUserId)
   * - Atomically inside a Prisma $transaction:
   *   - Find admin's available units for each product
   *   - Transfer ownership from admin to seller
   *   - Create inventory_transactions ledger entries (immutable)
   *   - Mark shipment as DELIVERED with delivered_on timestamp
   *
   * Input: shipmentId, sellerId (from req.user.id)
   * Output: Updated shipment summary
   */
  async receiveTransfer(shipmentId, sellerId) {
    // 1. Fetch shipment with items
    const shipment = await transfersRepository.findShipmentById(shipmentId);

    if (!shipment) {
      throw httpError(404, 'Shipment not found');
    }

    // 2. Verify shipment is PENDING
    if (shipment.status !== 'PENDING') {
      throw httpError(400, `Shipment cannot be received. Current status: ${shipment.status}`);
    }

    // 3. Verify authenticated seller is the intended receiver
    if (Number(shipment.toUserId) !== Number(sellerId)) {
      throw httpError(403, 'Forbidden: This shipment is not assigned to you');
    }

    // 4. Execute atomic inventory transfer in repository
    const updatedShipment = await transfersRepository.receiveShipment(shipmentId, shipment);

    return {
      shipment_id: Number(updatedShipment.id),
      status: updatedShipment.status,
      delivered_on: updatedShipment.deliveredOn
    };
  }

  /**
   * Cancel a shipment (Admin only)
   *
   * Business Logic:
   * - Shipment must exist
   * - Only PENDING shipments can be cancelled
   * - No inventory changes needed
   *
   * Input: shipmentId
   * Output: Updated shipment summary
   */
  async cancelTransfer(shipmentId) {
    // 1. Fetch shipment to verify status
    const shipment = await transfersRepository.findShipmentById(shipmentId);

    if (!shipment) {
      throw httpError(404, 'Shipment not found');
    }

    // 2. Only PENDING shipments can be cancelled
    if (shipment.status !== 'PENDING') {
      throw httpError(400, `Shipment cannot be cancelled. Current status: ${shipment.status}`);
    }

    // 3. Cancel — no inventory changes
    const updatedShipment = await transfersRepository.cancelShipment(shipmentId);

    return {
      shipment_id: Number(updatedShipment.id),
      status: updatedShipment.status
    };
  }
}

module.exports = new TransfersService();
