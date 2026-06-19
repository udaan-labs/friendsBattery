const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');

const { globalErrorHandler, notFoundHandler } = require('./shared/middleware/error.middleware');

const swaggerUi = require('swagger-ui-express');
const swaggerSpec = require('./config/swagger');

const app = express();

// Middleware
app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

// Swagger Documentation
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));
app.get('/swagger.json', (req, res) => {
  res.setHeader('Content-Type', 'application/json');
  res.send(swaggerSpec);
});

// Routes
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok', message: 'Server is running' });
});

// Module routes
const safeMount = (path, router) => {
  if (typeof router === 'function') {
    app.use(path, router);
  }
};

safeMount('/api/audit', require('./modules/audit/audit.routes'));
safeMount('/api/audit-logs', require('./modules/audit-logs/audit-logs.routes'));
safeMount('/api/auth', require('./modules/auth/auth.routes'));
safeMount('/api/customers', require('./modules/customers/customers.routes'));
safeMount('/api/inventory', require('./modules/inventory/inventory.routes'));
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
