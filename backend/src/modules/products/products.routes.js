const express = require('express');

const productGroupRouter = express.Router();
const productSubgroupRouter = express.Router();
const productRouter = express.Router();

/**
 * @swagger
 * /products:
 *   get:
 *     summary: Retrieve a list of products
 *     tags: [Products]
 *     responses:
 *       200:
 *         description: A list of products
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   id:
 *                     type: string
 *                   name:
 *                     type: string
 */
productRouter.get('/', (req, res) => {
  res.status(200).json([]);
});

module.exports = {
  productGroupRouter,
  productSubgroupRouter,
  productRouter
};
