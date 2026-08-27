const swaggerJsdoc = require('swagger-jsdoc');
const { PORT } = require('./env');

const schemas = require('./swagger.schemas');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'FriendsBattery API',
      version: '1.1.4',
      description: 'API documentation for the FriendsBattery Inventory and Stock Management application',
      contact: {
        name: 'API Support',
      },
    },
    servers: [
      {
        url: `http://localhost:${PORT || 5000}`,
        description: 'Development Server',
      },
    ],
    components: {
      schemas: schemas,
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
          description: 'Enter JWT token. Format: Bearer <token>',
        },
      },
    },
    security: [
      {
        bearerAuth: [],
      },
    ],
  },
  // Paths to files containing OpenAPI annotations
  apis: ['./src/modules/**/*.js', './src/app.js', './src/modules/**/*.routes.js'],
};

const swaggerSpec = swaggerJsdoc(options);

module.exports = swaggerSpec;
