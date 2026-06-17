const express = require('express');
const router = express.Router();

/**
 * @swagger
 * /shops:
 *   get:
 *     summary: Retrieve a list of shops
 *     tags: [Shops]
 *     responses:
 *       200:
 *         description: A list of shops
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
router.get('/', (req, res) => {
  res.status(200).json([{ id: '1', name: 'Main Shop' }]);
});

module.exports = router;
