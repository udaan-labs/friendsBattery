const express = require('express');
const router = express.Router();
const { verifyProduct } = require('./product-units.controller');
const { authenticate } = require('../../shared/middleware/auth.middleware');

/**
 * @swagger
 * /api/product-units/verify:
 *   post:
 *     summary: Verify a product unit by serial or QR
 *     tags: [ProductUnits]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/VerifyProductRequest'
 *     responses:
 *       200:
 *         description: Product details retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/VerifyProductResponse'
 *       404:
 *         description: Product not found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.post('/verify', authenticate, verifyProduct);

router.get('/', (req, res) => {
  res.status(200).json([]);
});

module.exports = router;
