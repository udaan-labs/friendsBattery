const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');

const authRoutes = require('./modules/auth/auth.routes');

// For acceptance check testing
const { authenticate } = require('./shared/middleware/auth.middleware');
const { requireRole } = require('./shared/middleware/role.middleware');
const { SUPER_ADMIN } = require('./shared/constants/roles');
const { successResponse } = require('./shared/utils/response');

const app = express();

// Middleware
app.use(helmet());
app.use(cors());
app.use(morgan('dev'));
app.use(express.json());

// Routes
app.use('/auth', authRoutes);

// Protected test route to verify Acceptance Check
app.get('/test-protected', authenticate, requireRole(SUPER_ADMIN), (req, res) => {
  return successResponse(res, 200, 'Access granted to SUPER_ADMIN', req.user);
});

module.exports = app;
