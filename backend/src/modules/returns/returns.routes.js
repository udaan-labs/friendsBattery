const express = require('express');
const router = express.Router();
const returnsController = require('./returns.controller');
const { authenticate } = require('../../shared/middleware/auth.middleware');
const {
  requireSeller,
  requireAdminOrSeller,
} = require('../../shared/middleware/role.middleware');

/**
 * @swagger
 * /api/returns:
 *   post:
 *     summary: Process a product return (seller)
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
 */
// Route to submit/process a product return (seller only — not employee)
router.post('/', authenticate, requireSeller, returnsController.processReturn);

/**
 * @swagger
 * /api/returns:
 *   get:
 *     summary: List product returns (seller own, admin all)
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
// Route to list product returns (admin all / seller own)
router.get('/', authenticate, requireAdminOrSeller, returnsController.getReturns);

module.exports = router;
