const express = require('express');
const router = express.Router();

/**
 * @swagger
 * /api/health:
 *   get:
 *     summary: Health check
 *     tags: [Health]
 *     security: []
 *     responses:
 *       200:
 *         description: API is healthy
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/HealthStatus'
 */
router.get('/', (req, res) => {
  res.status(200).json({
    status: 'ok',
    message: 'API is up and running via Cloudflare Tunnel',
    timestamp: new Date().toISOString(),
  });
});

module.exports = router;
