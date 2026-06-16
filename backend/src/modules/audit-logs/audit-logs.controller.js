const repo = require('./audit-logs.repository');
const { successResponse } = require('../../shared/utils/response');

const getAuditLogs = async (req, res, next) => {
  try {
    const filters = {
      entityName: req.query.entityName,
      entityId: req.query.entityId,
      action: req.query.action,
      userId: req.query.userId
    };
    
    // Remove undefined
    Object.keys(filters).forEach(key => filters[key] === undefined && delete filters[key]);

    const logs = await repo.getAuditLogs(filters);
    return successResponse(res, 200, 'Audit logs fetched', logs);
  } catch (error) { next(error); }
};

module.exports = {
  getAuditLogs
};
