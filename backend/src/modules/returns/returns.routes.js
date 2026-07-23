const express = require('express');
const router = express.Router();
const returnsController = require('./returns.controller');
const { authenticate } = require('../../shared/middleware/auth.middleware');

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
// Route to submit/process a product return
router.post('/', authenticate, returnsController.processReturn);

// Route to list product returns
router.get('/', authenticate, returnsController.getReturns);

module.exports = router;
