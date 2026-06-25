module.exports = {
  Error: {
    type: 'object',
    properties: {
      success: { type: 'boolean', example: false },
      message: { type: 'string', example: 'Error message' },
      errors: {
        type: 'array',
        items: { type: 'object' }
      }
    }
  },
  User: {
    type: 'object',
    properties: {
      id: { type: 'string', description: 'User ID in BigInt format converted to string' },
      userId: { type: 'string' },
      userName: { type: 'string' },
      role: { type: 'string', enum: ['ADMIN', 'SELLER'] },
      userNumber: { type: 'string', nullable: true },
      shopName: { type: 'string', nullable: true },
      isActive: { type: 'boolean' },
      isVerified: { type: 'boolean' },
      createdAt: { type: 'string', format: 'date-time' },
      updatedAt: { type: 'string', format: 'date-time' }
    }
  },
  Customer: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      name: { type: 'string' },
      phone: { type: 'string', nullable: true },
      createdAt: { type: 'string', format: 'date-time' }
    }
  },
  Category: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      name: { type: 'string' }
    }
  },
  ProductName: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      name: { type: 'string' }
    }
  },
  ProductModel: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      name: { type: 'string' }
    }
  },
  Product: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      categoryId: { type: 'string' },
      productNameId: { type: 'string' },
      productModelId: { type: 'string' },
      minPrice: { type: 'number', format: 'double' },
      onSale: { type: 'boolean' },
      offerPrice: { type: 'number', format: 'double', nullable: true },
      minUnitCountAdmin: { type: 'integer' },
      minUnitCountSeller: { type: 'integer' },
      createdAt: { type: 'string', format: 'date-time' },
      category: { $ref: '#/components/schemas/Category' },
      productName: { $ref: '#/components/schemas/ProductName' },
      productModel: { $ref: '#/components/schemas/ProductModel' }
    }
  },
  ProductUnit: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      productId: { type: 'string' },
      ownerId: { type: 'string' },
      serialNumber: { type: 'string' },
      status: { type: 'string', enum: ['IN_STOCK', 'IN_TRANSIT', 'SOLD', 'RETURNED', 'DEFECTIVE'] },
      createdAt: { type: 'string', format: 'date-time' },
      updatedAt: { type: 'string', format: 'date-time' }
    }
  },
  InventoryTransaction: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      productUnitId: { type: 'string' },
      fromUserId: { type: 'string', nullable: true },
      toUserId: { type: 'string' },
      action: { type: 'string', enum: ['RECEIVED', 'SHIPPED', 'SOLD', 'RETURNED', 'TRANSFERRED'] },
      timestamp: { type: 'string', format: 'date-time' }
    }
  },
  StockRequest: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      sellerId: { type: 'string' },
      requestTo: { type: 'string' },
      status: { type: 'string', enum: ['PENDING', 'APPROVED', 'REJECTED', 'SHIPPED', 'DELIVERED'] },
      createdAt: { type: 'string', format: 'date-time' },
      approvedAt: { type: 'string', format: 'date-time', nullable: true },
      items: {
        type: 'array',
        items: { $ref: '#/components/schemas/StockRequestItem' }
      }
    }
  },
  StockRequestItem: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      stockRequestId: { type: 'string' },
      productId: { type: 'string' },
      requestedQuantity: { type: 'integer' }
    }
  },
  Shipment: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      fromUserId: { type: 'string' },
      toUserId: { type: 'string' },
      totalProductsShipped: { type: 'integer' },
      shipmentPrice: { type: 'number', format: 'double' },
      status: { type: 'string', enum: ['PENDING', 'APPROVED', 'REJECTED', 'SHIPPED', 'DELIVERED'] },
      shippedOn: { type: 'string', format: 'date-time', nullable: true },
      deliveredOn: { type: 'string', format: 'date-time', nullable: true },
      createdAt: { type: 'string', format: 'date-time' },
      items: {
        type: 'array',
        items: { $ref: '#/components/schemas/ShipmentItem' }
      }
    }
  },
  ShipmentItem: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      shipmentId: { type: 'string' },
      productId: { type: 'string' },
      quantity: { type: 'integer' },
      pricePerPiece: { type: 'number', format: 'double', nullable: true },
      isShipmentRequested: { type: 'boolean' }
    }
  },
  SalesTransaction: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      productId: { type: 'string' },
      customerId: { type: 'string', nullable: true },
      sellerId: { type: 'string' },
      sellPrice: { type: 'number', format: 'double' },
      serialNumber: { type: 'string', nullable: true },
      productReplacedId: { type: 'string', nullable: true },
      soldAt: { type: 'string', format: 'date-time' }
    }
  },
  ReturnProduct: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      transactionId: { type: 'string', nullable: true },
      productId: { type: 'string', nullable: true },
      serialNumber: { type: 'string', nullable: true },
      reason: { type: 'string', nullable: true },
      returnType: { type: 'string', nullable: true },
      returnById: { type: 'string', nullable: true },
      returnToId: { type: 'string', nullable: true },
      createdAt: { type: 'string', format: 'date-time' }
    }
  }
};
