const express = require('express');
const productRouter = express.Router();
const productsController = require('./products.controller');
const {
  createCategorySchema,
  createProductNameSchema,
  createProductModelSchema,
  createProductSchema
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
 * /api/products/categories:
 *   post:
 *     summary: Create a new product category
 *     tags: [Products]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *     responses:
 *       201:
 *         description: Category created successfully
 */
productRouter.post(
  '/categories',
  authenticate,
  requireAdmin,
  validateRequest(createCategorySchema),
  productsController.createCategory
);

/**
 * @swagger
 * /api/products/categories:
 *   get:
 *     summary: Return all categories
 *     tags: [Products]
 *     responses:
 *       200:
 *         description: Categories fetched successfully
 */
productRouter.get(
  '/categories',
  authenticate,
  productsController.getCategories
);

/**
 * @swagger
 * /api/products/product-names:
 *   post:
 *     summary: Create a product name under a category
 *     tags: [Products]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               category_id:
 *                 type: integer
 *               name:
 *                 type: string
 *     responses:
 *       201:
 *         description: Product name created successfully
 */
productRouter.post(
  '/product-names',
  authenticate,
  requireAdmin,
  validateRequest(createProductNameSchema),
  productsController.createProductName
);

/**
 * @swagger
 * /api/products/categories/{categoryId}/product-names:
 *   get:
 *     summary: Return all product names belonging to a category
 *     tags: [Products]
 *     parameters:
 *       - in: path
 *         name: categoryId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Product names fetched successfully
 */
productRouter.get(
  '/categories/:categoryId/product-names',
  authenticate,
  productsController.getProductNamesByCategory
);

/**
 * @swagger
 * /api/products/product-models:
 *   post:
 *     summary: Create a product model
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
 *               name:
 *                 type: string
 *     responses:
 *       201:
 *         description: Product model created successfully
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
 * /api/products/product-names/{productNameId}/product-models:
 *   get:
 *     summary: Return all models belonging to a product name
 *     tags: [Products]
 *     parameters:
 *       - in: path
 *         name: productNameId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Product models fetched successfully
 */
productRouter.get(
  '/product-names/:productNameId/product-models',
  authenticate,
  productsController.getProductModelsByProductName
);

/**
 * @swagger
 * /api/products:
 *   post:
 *     summary: Create a new product
 *     tags: [Products]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               category_id:
 *                 type: integer
 *               product_name_id:
 *                 type: integer
 *               product_model_id:
 *                 type: integer
 *               min_price:
 *                 type: number
 *               on_sale:
 *                 type: boolean
 *               offer_price:
 *                 type: number
 *               min_quantity:
 *                 type: integer
 *     responses:
 *       201:
 *         description: Product created successfully
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
 * /api/products:
 *   get:
 *     summary: Return all products
 *     tags: [Products]
 *     responses:
 *       200:
 *         description: Products fetched successfully
 */
productRouter.get(
  '/',
  authenticate,
  productsController.getProducts
);

module.exports = {
  productRouter
};
