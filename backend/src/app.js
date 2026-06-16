const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');

const authRoutes = require('./modules/auth/auth.routes');

// For acceptance check testing
const { authenticate } = require('./shared/middleware/auth.middleware');
const { requireRole } = require('./shared/middleware/role.middleware');
const { SUPER_ADMIN } = require('./shared/constants/roles');
const { successResponse } = require('./shared/utils/response');

const { globalErrorHandler, notFoundHandler } = require('./shared/middleware/error.middleware');

const app = express();

// Middleware
app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

// Routes
app.use('/auth', authRoutes);
const shopRoutes = require('./modules/shops/shops.routes');
app.use('/shops', shopRoutes);

const { productGroupRouter, productSubgroupRouter, productRouter } = require('./modules/products/products.routes');
app.use('/product-groups', productGroupRouter);
app.use('/product-subgroups', productSubgroupRouter);
app.use('/products', productRouter);

const productUnitRoutes = require('./modules/product-units/product-units.routes');
app.use('/product-units', productUnitRoutes);

const inventoryRoutes = require('./modules/inventory/inventory.routes');
app.use('/inventory', inventoryRoutes);

const customerRoutes = require('./modules/customers/customers.routes');
app.use('/customers', customerRoutes);

const salesRoutes = require('./modules/sales/sales.routes');
app.use('/sales', salesRoutes);

const returnsRoutes = require('./modules/returns/returns.routes');
app.use('/returns', returnsRoutes);

const stockRequestRoutes = require('./modules/stock-requests/stock-requests.routes');
app.use('/stock-requests', stockRequestRoutes);

const auditLogsRoutes = require('./modules/audit-logs/audit-logs.routes');
app.use('/audit-logs', auditLogsRoutes);

// Protected test route to verify Acceptance Check
app.get('/test-protected', authenticate, requireRole(SUPER_ADMIN), (req, res) => {
  return successResponse(res, 200, 'Access granted to SUPER_ADMIN', req.user);
});

// 404 handler
app.use(notFoundHandler);

// Global Error Handler
app.use(globalErrorHandler);

module.exports = app;
