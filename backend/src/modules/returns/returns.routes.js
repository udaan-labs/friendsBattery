const express = require('express');
const router = express.Router();
const returnsController = require('./returns.controller');
const { processReturnSchema } = require('./returns.validation');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const { requireAdminOrSeller } = require('../../shared/middleware/role.middleware');
const { validateRequest } = require('../../shared/middleware/validation.middleware');

/**
 * @swagger
 * /api/returns:
 *   post:
 *     summary: Process a product return (seller or admin)
 *     description: |
 *       Restocks the unit as AVAILABLE (default, sellable) or DEFECTIVE.
 *       Shop seller/admin may return sales by shop staff (including employees), not only self.
 *     tags: [Returns]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CreateReturnRequest'
 *     responses:
 *       201:
 *         description: Return processed successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/CreateReturnResponse'
 *       400:
 *         description: Invalid return
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 *       403:
 *         description: Sale not in actor shop scope
 *       409:
 *         description: Unit no longer SOLD (race)
 */
router.post(
  '/',
  authenticate,
  requireAdminOrSeller,
  validateRequest(processReturnSchema),
  returnsController.processReturn
);

/**
 * @swagger
 * /api/returns:
 *   get:
 *     summary: List product returns (seller own, admin shop/all)
 *     tags: [Returns]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Returns fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/ReturnsListResponse'
 *       401:
 *         description: Unauthorized
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Error'
 */
router.get('/', authenticate, requireAdminOrSeller, returnsController.getReturns);

module.exports = router;
