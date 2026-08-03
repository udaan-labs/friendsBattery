const express = require('express');
const router = express.Router();
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdminOrSeller } = require('../../shared/middleware/role.middleware');

/**
 * @swagger
 * /api/customers:
 *   get:
 *     summary: Retrieve a list of customers
 *     tags: [Customers]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: A list of customers
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Customer'
 *       401:
 *         description: Unauthorized
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
// Stub — auth required so the path is not a public probe
router.get('/', authenticate, requireAdminOrSeller, (req, res) => {
  res.status(200).json([]);
});

module.exports = router;
