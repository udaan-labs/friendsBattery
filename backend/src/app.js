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

/**
 * @swagger
 * /api/health:
 *   get:
 *     summary: Health check
 *     tags: [Health]
 *     security: []
 *     responses:
 *       200:
 *         description: API is healthy
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/HealthStatus'
 */
app.get('/api/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    message: 'API is up and running via Cloudflare Tunnel',
    timestamp: new Date().toISOString(),
  });
});

// Module routes
app.use('/api/app', require('./modules/app/app.routes'));
app.use('/api/auth', require('./modules/auth/auth.routes'));
app.use('/api/dashboard', require('./modules/dashboard/dashboard.routes'));
app.use('/api/seller/dashboard', require('./modules/dashboard/seller-dashboard.routes'));
app.use('/api/inventory', require('./modules/inventory/inventory.routes'));

const shipmentsRoutes = require('./modules/shipments/shipments.routes');
app.use('/api/shipments', shipmentsRoutes.shipments);
app.use('/api/seller', shipmentsRoutes.seller);
if (shipmentsRoutes.employee) {
  app.use('/api/employee', shipmentsRoutes.employee);
}

app.use('/api/employee/attendance', require('./modules/attendance/attendance.routes'));
app.use('/api/product-units', require('./modules/product-units/product-units.routes'));

const productsRoutes = require('./modules/products/products.routes');
app.use('/api/products', productsRoutes.productRouter);

app.use('/api/returns', require('./modules/returns/returns.routes'));
app.use('/api/sales', require('./modules/sales/sales.routes'));
app.use('/api/shops', require('./modules/shops/shops.routes'));
app.use('/api/transfers', require('./modules/transfers/transfers.routes'));
app.use('/api/users', require('./modules/users/users.routes'));

// 404 handler
app.use(notFoundHandler);

// Global Error Handler
app.use(globalErrorHandler);

module.exports = app;
