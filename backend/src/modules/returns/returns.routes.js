const express = require('express');
const router = express.Router();
const returnsController = require('./returns.controller');
const { authenticate } = require('../../shared/middleware/auth.middleware');

// In a YAGNI approach, we only need the POST route. 
// We add 'authenticate' middleware so we know which seller is making the request.
router.post('/', authenticate, returnsController.processReturn);

module.exports = router;
