const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const path = require('path');

const { globalErrorHandler, notFoundHandler } = require('./shared/middleware/error.middleware');

const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./config/swagger');

const app = express();

// Middleware
app.use(helmet());
const corsOptions = {
  origin: '*', // For development with Cloudflare Tunnel, allow all origins
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS'],
  // Mobile/Bruno use auth-id + auth-key (not only Bearer Authorization)
  allowedHeaders: ['Content-Type', 'Authorization', 'auth-id', 'auth-key', 'auth_id', 'auth_key', 'authid']
};
app.use(cors(corsOptions));
app.use(morgan('dev'));
app.use(express.json());
app.use(express.static(path.join(__dirname, '../public')));

// Swagger Documentation
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));
app.get('/swagger.json', (req, res) => {
  res.setHeader('Content-Type', 'application/json');
  res.send(swaggerSpec);
});

// Routes
// Health check moved to /api/health via clean architecture

// Module routes
const safeMount = (path, router) => {
  if (typeof router === 'function') {
    app.use(path, router);
  }
};

safeMount('/api/health', require('./modules/health/health.routes'));
safeMount('/api/audit', require('./modules/audit/audit.routes'));
safeMount('/api/audit-logs', require('./modules/audit-logs/audit-logs.routes'));
safeMount('/api/auth', require('./modules/auth/auth.routes'));
safeMount('/api/customers', require('./modules/customers/customers.routes'));
safeMount('/api/dashboard', require('./modules/dashboard/dashboard.routes'));
safeMount('/api/seller/dashboard', require('./modules/dashboard/seller-dashboard.routes'));
safeMount('/api/inventory', require('./modules/inventory/inventory.routes'));
const shipmentsRoutes = require('./modules/shipments/shipments.routes');
safeMount('/api/shipments', shipmentsRoutes.shipments);
safeMount('/api/seller', shipmentsRoutes.seller);
if (shipmentsRoutes.employee) safeMount('/api/employee', shipmentsRoutes.employee);
safeMount('/api/employee/attendance', require('./modules/attendance/attendance.routes'));
safeMount('/api/notifications', require('./modules/notifications/notifications.routes'));
safeMount('/api/product-units', require('./modules/product-units/product-units.routes'));

const productsRoutes = require('./modules/products/products.routes');
if (productsRoutes.productRouter) safeMount('/api/products', productsRoutes.productRouter);
if (productsRoutes.productGroupRouter) safeMount('/api/product-groups', productsRoutes.productGroupRouter);

safeMount('/api/reports', require('./modules/reports/reports.routes'));
safeMount('/api/returns', require('./modules/returns/returns.routes'));
safeMount('/api/sales', require('./modules/sales/sales.routes'));
safeMount('/api/shops', require('./modules/shops/shops.routes'));
safeMount('/api/stock-requests', require('./modules/stock-requests/stock-requests.routes'));
safeMount('/api/transfers', require('./modules/transfers/transfers.routes'));
safeMount('/api/users', require('./modules/users/users.routes'));

// 404 handler
app.use(notFoundHandler);

// Global Error Handler
app.use(globalErrorHandler);

module.exports = app;
