const healthService = require('./health.service');

const getHealth = async (req, res, next) => {
  try {
    const healthStatus = await healthService.checkHealth();
    res.status(200).json(healthStatus);
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getHealth
};
