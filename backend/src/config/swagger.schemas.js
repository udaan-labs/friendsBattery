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
      role: { type: 'string', enum: ['ADMIN', 'SELLER', 'EMPLOYEE'] },
      userNumber: { type: 'string', nullable: true },
      shopName: { type: 'string', nullable: true },
      isActive: { type: 'boolean' },
      isVerified: { type: 'boolean' },
      createdAt: { type: 'string', format: 'date-time' },
      updatedAt: { type: 'string', format: 'date-time' }
    }
  },
  // Login payload user (snake_case — matches auth.service loginUser)
  LoginUser: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      username: { type: 'string' },
      user_number: { type: 'string', nullable: true },
      shop_name: { type: 'string', nullable: true },
      role: { type: 'string', enum: ['ADMIN', 'SELLER', 'EMPLOYEE'] },
      location_id: { type: 'integer', nullable: true },
      employee_role_id: { type: 'integer', nullable: true },
      location: {
        type: 'object',
        nullable: true,
        properties: {
          id: { type: 'integer' },
          code: { type: 'string' },
          name: { type: 'string' },
          type: { type: 'string', enum: ['WAREHOUSE', 'SHOP'] }
        }
      },
      employee_role: {
        type: 'object',
        nullable: true,
        properties: {
          id: { type: 'integer' },
          name: { type: 'string' },
          description: { type: 'string', nullable: true }
        }
      }
    }
  },
  LoginData: {
    type: 'object',
    properties: {
      auth_id: { type: 'string' },
      auth_key: { type: 'string' },
      session_id: { type: 'integer', nullable: true, description: 'Present for EMPLOYEE logins (employee_sessions)' },
      user: { $ref: '#/components/schemas/LoginUser' }
    }
  },
  LoginResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/LoginData' }
    }
  },
  RegisterData: {
    type: 'object',
    properties: {
      user_id: { type: 'string' },
      username: { type: 'string' },
      user_number: { type: 'string', nullable: true },
      shop_name: { type: 'string', nullable: true },
      role: { type: 'string' },
      is_active: { type: 'boolean' },
      is_verified: { type: 'boolean' },
      created_at: { type: 'string', format: 'date-time' }
    }
  },
  RegisterResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/RegisterData' }
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
      id: { type: 'integer' },
      name: { type: 'string' }
    }
  },
  ProductModel: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      name: { type: 'string' },
      product_name_id: { type: 'integer' }
    }
  },
  ProductNamesResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: {
        type: 'array',
        items: { $ref: '#/components/schemas/ProductName' }
      }
    }
  },
  ProductNameResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/ProductName' }
    }
  },
  ProductModelsResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: {
        type: 'array',
        items: { $ref: '#/components/schemas/ProductModel' }
      }
    }
  },
  ProductModelResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/ProductModel' }
    }
  },
  CreateProductNameRequest: {
    type: 'object',
    required: ['name'],
    properties: {
      name: { type: 'string' }
    }
  },
  CreateProductModelRequest: {
    type: 'object',
    required: ['product_name_id', 'name'],
    properties: {
      product_name_id: { type: 'integer' },
      name: { type: 'string' }
    }
  },
  ListProductModelsRequest: {
    type: 'object',
    required: ['product_name_id'],
    properties: {
      product_name_id: { type: 'integer' }
    }
  },
  CreateProductRequest: {
    type: 'object',
    required: ['product_name_id', 'product_model_id'],
    properties: {
      product_name_id: { type: 'integer' },
      product_model_id: { type: 'integer' },
      min_price: { type: 'number' },
      on_sale: { type: 'boolean' },
      offer_price: { type: 'number', nullable: true },
      min_unit_count_admin: { type: 'integer' },
      min_unit_count_seller: { type: 'integer' }
    }
  },
  ProductCreated: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      product_name_id: { type: 'integer' },
      product_model_id: { type: 'integer' },
      min_price: { type: 'number' },
      on_sale: { type: 'boolean' },
      offer_price: { type: 'number', nullable: true },
      min_unit_count_admin: { type: 'integer' },
      min_unit_count_seller: { type: 'integer' },
      created_at: { type: 'string', format: 'date-time' }
    }
  },
  CreateProductResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/ProductCreated' }
    }
  },
  ProductStockDetails: {
    type: 'object',
    properties: {
      currentStock: { type: 'integer' },
      minSellPrice: { type: 'number' }
    }
  },
  ProductStockDetailsResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/ProductStockDetails' }
    }
  },
  AdminDashboardStats: {
    type: 'object',
    properties: {
      totalStock: { type: 'integer' },
      todaySales: { type: 'integer' },
      todaySalesAmount: { type: 'number' },
      pendingRequests: { type: 'integer' },
      totalSellers: { type: 'integer' },
      pendingShipments: { type: 'integer' }
    }
  },
  AdminDashboardStatsResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/AdminDashboardStats' }
    }
  },
  SellerRecentSale: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      customerName: { type: 'string' },
      productName: { type: 'string' },
      productModel: { type: 'string' },
      serialNumber: { type: 'string' },
      sellPrice: { type: 'number' },
      soldAt: { type: 'string', format: 'date-time' }
    }
  },
  SellerDashboardStats: {
    type: 'object',
    properties: {
      totalStock: { type: 'integer' },
      todaySales: { type: 'integer' },
      todaySalesAmount: { type: 'number' },
      pendingShipments: { type: 'integer' },
      recentSales: {
        type: 'array',
        items: { $ref: '#/components/schemas/SellerRecentSale' }
      }
    }
  },
  SellerDashboardStatsResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/SellerDashboardStats' }
    }
  },
  ActivityItem: {
    type: 'object',
    properties: {
      title: { type: 'string' },
      subtitle: { type: 'string' },
      time: { type: 'string', format: 'date-time' },
      icon: { type: 'string' }
    }
  },
  RecentActivityResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: {
        type: 'array',
        items: { $ref: '#/components/schemas/ActivityItem' }
      }
    }
  },
  ActivityHistoryPagination: {
    type: 'object',
    properties: {
      page: { type: 'integer' },
      limit: { type: 'integer' },
      totalItems: { type: 'integer' },
      totalPages: { type: 'integer' },
      hasNextPage: { type: 'boolean' }
    }
  },
  ActivityHistoryResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      data: {
        type: 'array',
        items: { $ref: '#/components/schemas/ActivityItem' }
      },
      pagination: { $ref: '#/components/schemas/ActivityHistoryPagination' }
    }
  },
  CreateSaleRequest: {
    type: 'object',
    required: [
      'product_name_id',
      'product_model_id',
      'serial_number',
      'customer_name',
      'customer_number',
      'sell_price'
    ],
    properties: {
      product_name_id: { type: 'integer' },
      product_model_id: { type: 'integer' },
      serial_number: { type: 'string' },
      customer_name: { type: 'string' },
      customer_number: { type: 'string' },
      vehicle_number: { type: 'string', nullable: true },
      sell_price: { type: 'number' }
    }
  },
  CreateSaleResult: {
    type: 'object',
    properties: {
      transaction_id: { type: 'integer' }
    }
  },
  CreateSaleResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/CreateSaleResult' }
    }
  },
  SaleCustomer: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      name: { type: 'string' },
      phone: { type: 'string' }
    }
  },
  SaleSeller: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      user_name: { type: 'string' },
      shop_name: { type: 'string' }
    }
  },
  SaleProduct: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      product_name: { type: 'string' },
      product_model: { type: 'string' }
    }
  },
  SaleRecord: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      product_id: { type: 'integer' },
      product_unit_id: { type: 'integer' },
      sell_price: { type: 'number' },
      serial_number: { type: 'string' },
      vehicle_number: { type: 'string', nullable: true },
      sold_at: { type: 'string', format: 'date-time' },
      quantity: { type: 'integer' },
      customer: { $ref: '#/components/schemas/SaleCustomer' },
      seller: { $ref: '#/components/schemas/SaleSeller' },
      product: { $ref: '#/components/schemas/SaleProduct' }
    }
  },
  SaleHistoryPage: {
    type: 'object',
    properties: {
      data: {
        type: 'array',
        items: { $ref: '#/components/schemas/SaleRecord' }
      },
      total: { type: 'integer' },
      page: { type: 'integer' },
      limit: { type: 'integer' },
      total_pages: { type: 'integer' }
    }
  },
  SaleHistoryResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/SaleHistoryPage' }
    }
  },
  SaleDetailResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/SaleRecord' }
    }
  },
  AdminSaleShipment: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      shipment_number: { type: 'string' },
      shipment_date: { type: 'string', format: 'date-time', nullable: true },
      arrival_date: { type: 'string', format: 'date-time', nullable: true },
      status: { type: 'string' }
    }
  },
  AdminSaleRecord: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      sold_at: { type: 'string', format: 'date-time' },
      quantity: { type: 'integer' },
      sell_price: { type: 'number' },
      serial_number: { type: 'string' },
      vehicle_number: { type: 'string', nullable: true },
      seller: { $ref: '#/components/schemas/SaleSeller' },
      customer: { $ref: '#/components/schemas/SaleCustomer' },
      product: { $ref: '#/components/schemas/SaleProduct' },
      shipment: { $ref: '#/components/schemas/AdminSaleShipment', nullable: true }
    }
  },
  AdminSaleHistoryPage: {
    type: 'object',
    properties: {
      data: {
        type: 'array',
        items: { $ref: '#/components/schemas/AdminSaleRecord' }
      },
      total: { type: 'integer' },
      page: { type: 'integer' },
      limit: { type: 'integer' },
      total_pages: { type: 'integer' }
    }
  },
  AdminSaleHistoryResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/AdminSaleHistoryPage' }
    }
  },
  ScanForSaleResult: {
    type: 'object',
    properties: {
      productId: { type: 'integer' },
      productNameId: { type: 'integer' },
      productModelId: { type: 'integer' },
      productName: { type: 'string' },
      productModel: { type: 'string' },
      minSellPrice: { type: 'number' }
    }
  },
  ScanForSaleResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/ScanForSaleResult' }
    }
  },
  SellerStatistics: {
    type: 'object',
    properties: {
      stock: { type: 'integer' },
      products: { type: 'integer' },
      sales: { type: 'integer' },
      returns: { type: 'integer' }
    }
  },
  SellerDetail: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      user_name: { type: 'string' },
      shop_name: { type: 'string' },
      user_number: { type: 'string' },
      is_active: { type: 'boolean' },
      is_verified: { type: 'boolean' },
      statistics: { $ref: '#/components/schemas/SellerStatistics' },
      inventory: {
        type: 'array',
        items: { $ref: '#/components/schemas/InventoryListItem' }
      },
      created_at: { type: 'string', format: 'date-time' }
    }
  },
  SellerDetailResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/SellerDetail' }
    }
  },
  HealthStatus: {
    type: 'object',
    properties: {
      status: { type: 'string' },
      message: { type: 'string' },
      timestamp: { type: 'string', format: 'date-time' }
    }
  },
  VerifyProductRequest: {
    type: 'object',
    required: ['identifier'],
    properties: {
      identifier: { type: 'string' }
    }
  },
  VerifyProductUnit: {
    type: 'object',
    properties: {
      serialNumber: { type: 'string' },
      status: { type: 'string' },
      qrCode: { type: 'string', nullable: true },
      manufactureDate: { type: 'string', format: 'date-time' },
      warrantyExpiry: { type: 'string', format: 'date-time', nullable: true }
    }
  },
  VerifyProductInfo: {
    type: 'object',
    properties: {
      name: { type: 'string' },
      group: { type: 'string' },
      subgroup: { type: 'string' },
      model: { type: 'string' }
    }
  },
  VerifyProductPayload: {
    type: 'object',
    properties: {
      productUnit: { $ref: '#/components/schemas/VerifyProductUnit' },
      product: { $ref: '#/components/schemas/VerifyProductInfo' }
    }
  },
  VerifyProductResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/VerifyProductPayload' }
    }
  },
  CreateReturnRequest: {
    type: 'object',
    required: ['serial_number', 'reason'],
    properties: {
      serial_number: { type: 'string' },
      reason: { type: 'string' }
    }
  },
  CreateReturnResult: {
    type: 'object',
    properties: {
      message: { type: 'string' },
      returnRecordId: { type: 'string' },
      productUnitId: { type: 'string' },
      status: { type: 'string' }
    }
  },
  CreateReturnResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/CreateReturnResult' }
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
      status: { type: 'string', enum: ['AVAILABLE', 'IN_TRANSIT', 'SOLD', 'RETURNED', 'DEFECTIVE'] },
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
      productUnitId: { type: 'string' },
      customerId: { type: 'string', nullable: true },
      sellerId: { type: 'string' },
      sellPrice: { type: 'number', format: 'double' },
      serialNumber: { type: 'string', nullable: true },
      vehicleNumber: { type: 'string', nullable: true },
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
  },
  ReturnListProductName: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      name: { type: 'string' }
    }
  },
  ReturnListProductModel: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      name: { type: 'string' },
      productNameId: { type: 'string' }
    }
  },
  ReturnListProduct: {
    type: 'object',
    properties: {
      id: { type: 'string' },
      productNameId: { type: 'string' },
      productModelId: { type: 'string' },
      productName: { $ref: '#/components/schemas/ReturnListProductName' },
      productModel: { $ref: '#/components/schemas/ReturnListProductModel' }
    }
  },
  ReturnListItem: {
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
      createdAt: { type: 'string', format: 'date-time' },
      product: { $ref: '#/components/schemas/ReturnListProduct' }
    }
  },
  ReturnsListResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: {
        type: 'array',
        items: { $ref: '#/components/schemas/ReturnListItem' }
      }
    }
  },

  // ── Admin → Seller serial transfer (POST /api/shipments) ─────────────────
  CreateShipmentItem: {
    type: 'object',
    required: ['product_name_id', 'product_model_id', 'serial_numbers'],
    properties: {
      product_name_id: { type: 'integer', minimum: 1 },
      product_model_id: { type: 'integer', minimum: 1 },
      serial_numbers: {
        type: 'array',
        minItems: 1,
        items: { type: 'string', minLength: 1 }
      },
      price_per_piece: { type: 'number', minimum: 0 }
    }
  },
  CreateShipmentRequest: {
    type: 'object',
    required: ['sellerId', 'items'],
    properties: {
      sellerId: { type: 'integer', minimum: 1 },
      items: {
        type: 'array',
        minItems: 1,
        items: { $ref: '#/components/schemas/CreateShipmentItem' }
      }
    }
  },
  TransferInventoryCount: {
    type: 'object',
    properties: {
      productId: { type: 'integer' },
      productName: { type: 'string' },
      productModel: { type: 'string' },
      transferred: { type: 'integer' },
      adminAvailable: { type: 'integer' },
      sellerAvailable: { type: 'integer' }
    }
  },
  CreateShipmentResult: {
    type: 'object',
    properties: {
      shipmentId: { type: 'integer' },
      shipmentNumber: { type: 'string' },
      status: { type: 'string', enum: ['PENDING', 'ACCEPTED', 'REJECTED'] },
      transferredUnits: { type: 'integer' },
      sellerId: { type: 'integer' },
      inventory: {
        type: 'array',
        items: { $ref: '#/components/schemas/TransferInventoryCount' }
      }
    }
  },
  CreateShipmentResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean', example: true },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/CreateShipmentResult' }
    }
  },
  AvailableSerialsResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: {
        type: 'array',
        items: { type: 'string' },
        description: 'Serial numbers AVAILABLE for the authenticated user'
      }
    }
  },
  SellerShopSummary: {
    type: 'object',
    properties: {
      id: { type: 'integer' },
      user_id: { type: 'string' },
      user_name: { type: 'string' },
      shop_name: { type: 'string', nullable: true },
      user_number: { type: 'string', nullable: true },
      is_active: { type: 'boolean' },
      is_verified: { type: 'boolean' },
      totalStock: { type: 'integer' },
      todaySales: { type: 'integer' },
      pendingShipments: { type: 'integer' },
      hasLowStock: { type: 'boolean' }
    }
  },
  SellersListResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: {
        type: 'array',
        items: { $ref: '#/components/schemas/SellerShopSummary' }
      }
    }
  },
  InventoryProductModelOption: {
    type: 'object',
    properties: {
      id: { type: 'integer', description: 'Product id' },
      productModelId: { type: 'integer' },
      productModel: { type: 'string' },
      availableQuantity: { type: 'integer' },
      minSellPrice: { type: 'number' }
    }
  },
  InventoryProductNameGroup: {
    type: 'object',
    properties: {
      productName: { type: 'string' },
      productNameId: { type: 'integer' },
      models: {
        type: 'array',
        items: { $ref: '#/components/schemas/InventoryProductModelOption' }
      }
    }
  },
  InventoryProductsResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: {
        type: 'array',
        items: { $ref: '#/components/schemas/InventoryProductNameGroup' }
      }
    }
  },
  InventoryListItem: {
    type: 'object',
    properties: {
      product_id: { type: 'integer' },
      product_name_id: { type: 'integer' },
      product_model_id: { type: 'integer' },
      brand: { type: 'string' },
      model: { type: 'string' },
      quantity: { type: 'integer' },
      min_price: { type: 'number' },
      offer_price: { type: 'number', nullable: true },
      min_unit_count_seller: { type: 'integer' },
      min_unit_count_admin: { type: 'integer' },
      on_sale: { type: 'boolean' },
      is_low_stock: { type: 'boolean' }
    }
  },
  InventoryPagination: {
    type: 'object',
    properties: {
      total: { type: 'integer' },
      page: { type: 'integer' },
      limit: { type: 'integer' },
      total_pages: { type: 'integer' }
    }
  },
  InventoryListPayload: {
    type: 'object',
    properties: {
      data: {
        type: 'array',
        items: { $ref: '#/components/schemas/InventoryListItem' }
      },
      pagination: { $ref: '#/components/schemas/InventoryPagination' }
    }
  },
  InventoryListResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/InventoryListPayload' }
    }
  },
  InventoryItemDetail: {
    type: 'object',
    properties: {
      product_id: { type: 'integer' },
      product_name_id: { type: 'integer' },
      product_model_id: { type: 'integer' },
      brand: { type: 'string' },
      model: { type: 'string' },
      quantity: { type: 'integer' },
      min_price: { type: 'number' },
      offer_price: { type: 'number', nullable: true },
      min_unit_count_seller: { type: 'integer' },
      min_unit_count_admin: { type: 'integer' },
      on_sale: { type: 'boolean' },
      is_low_stock: { type: 'boolean' },
      serial_numbers: {
        type: 'array',
        items: { type: 'string' }
      }
    }
  },
  InventoryItemDetailResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/InventoryItemDetail' }
    }
  },
  UpdateStockRequest: {
    type: 'object',
    required: ['productNameId', 'productModelId'],
    properties: {
      productNameId: { type: 'integer' },
      productModelId: { type: 'integer' },
      quantity: { type: 'integer', description: 'Units to add; optional when only updating price/flags' },
      minSellPrice: { type: 'number' },
      minUnitCountAdmin: { type: 'integer' },
      minUnitCountSeller: { type: 'integer' },
      onSale: { type: 'boolean' }
    }
  },
  UpdateStockResult: {
    type: 'object',
    properties: {
      productNameId: { type: 'integer' },
      productModelId: { type: 'integer' },
      quantity: { type: 'integer' },
      minSellPrice: { type: 'number' },
      minUnitCountAdmin: { type: 'integer' },
      minUnitCountSeller: { type: 'integer' },
      onSale: { type: 'boolean' }
    }
  },
  UpdateStockResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/UpdateStockResult' }
    }
  },
  AdjustInventoryRequest: {
    type: 'object',
    required: ['product_id', 'user_id', 'adjustment_quantity'],
    properties: {
      product_id: { type: 'integer' },
      user_id: { type: 'integer' },
      adjustment_quantity: { type: 'integer', description: 'Positive to add, negative to remove' }
    }
  },
  AdjustInventoryResult: {
    type: 'object',
    properties: {
      adjusted: { type: 'boolean' },
      adjustment_quantity: { type: 'integer' }
    }
  },
  AdjustInventoryResponse: {
    type: 'object',
    properties: {
      success: { type: 'boolean' },
      message: { type: 'string' },
      data: { $ref: '#/components/schemas/AdjustInventoryResult' }
    }
  }
};
