const express = require('express');
const router = express.Router();
const appController = require('./app.controller');

/**
 * @swagger
 * /api/app/status:
 *   get:
 *     summary: App version + maintenance gate status
 *     description: |
 *       Public endpoint for Flutter splash / app gate.
 *       Clients compare local version to `latest_version` and block on `maintenance`.
 *     tags: [App]
 *     security: []
 *     responses:
 *       200:
 *         description: Current app gate status
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AppStatusResponse'
 */
router.get('/status', appController.getStatus);

module.exports = router;
