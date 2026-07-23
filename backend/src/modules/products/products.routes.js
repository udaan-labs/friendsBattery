const express = require('express');
const productRouter = express.Router();
const productsController = require('./products.controller');
const {
  createProductNameSchema,
  createProductModelSchema,
  createProductSchema,
  getProductModelsRequest,
  getProductsRequest
} = require('./products.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdmin } = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

/**
 * @swagger
 * tags:
 *   name: Products
 *   description: Products management APIs
 */

/**
 * @swagger
 * /api/products/product-names:
 *   post:
 *     summary: Create a product name
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateProductNameRequest'
 *     responses:
 *       201:
 *         description: Product name created successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ProductNameResponse'
 *       409:
 *         description: Product name already exists
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *   get:
 *     summary: Return all product names
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Product names fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ProductNamesResponse'
 */
productRouter.post(
  '/product-names',
  authenticate,
  requireAdmin,
  validateRequest(createProductNameSchema),
  productsController.createProductName
);

productRouter.get(
  '/product-names',
  authenticate,
  productsController.getProductNames
);

/**
 * @swagger
 * /api/products/inventory-products:
 *   get:
 *     summary: Get products in the authenticated user's inventory
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Inventory products fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/InventoryProductsResponse'
 *       401:
 *         description: Unauthorized
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       500:
 *         description: Internal server error
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
productRouter.get(
  '/inventory-products',
  authenticate,
  productsController.getInventoryProducts
);

/**
 * @swagger
 * /api/products/product-models:
 *   post:
 *     summary: Create a product model
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateProductModelRequest'
 *     responses:
 *       201:
 *         description: Product model created successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ProductModelResponse'
 *       409:
 *         description: Product model already exists
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
productRouter.post(
  '/product-models',
  authenticate,
  requireAdmin,
  validateRequest(createProductModelSchema),
  productsController.createProductModel
);

/**
 * @swagger
 * /api/products/product-models/list:
 *   post:
 *     summary: Return all models belonging to a product name
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/ListProductModelsRequest'
 *     responses:
 *       200:
 *         description: Product models fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ProductModelsResponse'
 *       404:
 *         description: Product name not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
productRouter.post(
  '/product-models/list',
  authenticate,
  validateRequest(getProductModelsRequest),
  productsController.getProductModelsByProductName
);

/**
 * @swagger
 * /api/products:
 *   post:
 *     summary: Create a new product
 *     tags: [Products]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateProductRequest'
 *     responses:
 *       201:
 *         description: Product created successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/CreateProductResponse'
 */
productRouter.post(
  '/',
  authenticate,
  requireAdmin,
  validateRequest(createProductSchema),
  productsController.createProduct
);

/**
 * @swagger
 * /api/products/list:
 *   post:
 *     summary: Return all products matching filters
 *     tags: [Products]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               product_name_id:
 *                 type: integer
 *               product_model_id:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Products fetched successfully
 */
productRouter.post(
  '/list',
  authenticate,
  validateRequest(getProductsRequest),
  productsController.getProducts
);

module.exports = {
  productRouter
};
