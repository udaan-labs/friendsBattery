const { prisma } = require('../../config/db');
const { successResponse, errorResponse } = require('../../shared/utils/response');

const verifyProduct = async (req, res, next) => {
  try {
    const { identifier } = req.body;
    if (!identifier) {
      return errorResponse(res, 400, 'Identifier is required');
    }

    const productUnit = await prisma.productUnit.findFirst({
      where: {
        OR: [
          { serialNumber: identifier },
          { qrCode: identifier }
        ]
      },
      include: {
        product: {
          include: {
            productName: true,
            productModel: true,
          }
        },
        owner: true,
        sales: {
          include: {
            seller: true,
            customer: true
          }
        },
        transactions: {
          orderBy: { timestamp: 'desc' },
          include: {
            fromUser: true,
            toUser: true
          }
        }
      }
    });

    if (!productUnit) {
      return errorResponse(res, 404, 'Product not found');
    }

    // Default deny. EMPLOYEE must not see customer/sale/ledger via verify.
    const role = req.user.role;
    let isAuthorized = false;
    if (role === 'ADMIN') {
      isAuthorized = true;
    } else if (role === 'SELLER') {
      if (String(productUnit.ownerId) === String(req.user.id)) {
        isAuthorized = true;
      } else {
        const saleByThisSeller = productUnit.sales.find(
          (s) => String(s.sellerId) === String(req.user.id)
        );
        if (saleByThisSeller) isAuthorized = true;
      }
    }

    if (!isAuthorized) {
      return errorResponse(res, 404, 'Product not found');
    }

    const sale = productUnit.sales && productUnit.sales.length > 0 ? productUnit.sales[productUnit.sales.length - 1] : null;

    // Calculate warranty expiry if sold
    let warrantyExpiry = null;
    if (sale && sale.soldAt) {
      // Assuming a standard 1 year warranty for now, could be dynamic later
      const d = new Date(sale.soldAt);
      d.setFullYear(d.getFullYear() + 1);
      warrantyExpiry = d.toISOString();
    }

    const response = {
      productUnit: {
        serialNumber: productUnit.serialNumber,
        status: productUnit.status,
        qrCode: productUnit.qrCode,
        manufactureDate: productUnit.createdAt,
        warrantyExpiry: warrantyExpiry
      },
      product: {
        name: productUnit.product.productName.name,
        group: "", 
        subgroup: "",
        model: productUnit.product.productModel.name
      },
      seller: sale ? {
        id: String(sale.seller.id),
        name: sale.seller.userName,
        shopName: sale.seller.shopName
      } : {
         id: String(productUnit.owner.id),
         name: productUnit.owner.userName,
         shopName: productUnit.owner.shopName
      },
      customer: sale && sale.customer ? {
        name: sale.customer.name,
        phone: sale.customer.phone
      } : null,
      sale: sale ? {
        saleDate: sale.soldAt,
        salePrice: sale.sellPrice,
        invoiceNumber: ""
      } : null,
      inventoryHistory: productUnit.transactions.map(t => ({
        type: t.action,
        date: t.timestamp,
        performedBy: t.fromUser ? t.fromUser.userName : 'System',
        receivedBy: t.toUser ? t.toUser.userName : 'System'
      }))
    };

    return successResponse(res, 200, 'Product details retrieved successfully', response);

  } catch (error) {
    next(error);
  }
};

module.exports = { verifyProduct };
