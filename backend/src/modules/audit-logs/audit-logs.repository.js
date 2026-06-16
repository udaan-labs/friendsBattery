const prisma = require('../../config/db');

/**
 * Creates an audit log record. Can participate in an existing Prisma transaction.
 * @param {Object} tx - The Prisma client or transaction instance
 * @param {Object} data - The audit log data
 * @param {string} data.userId
 * @param {string} data.entityName
 * @param {string} data.entityId
 * @param {string} data.action
 * @param {Object} [data.oldData]
 * @param {Object} [data.newData]
 */
const createAuditLog = async (tx, data) => {
  const db = tx || prisma;
  return await db.auditLog.create({
    data: {
      user_id: data.userId,
      entity_name: data.entityName,
      entity_id: data.entityId,
      action: data.action,
      old_data: data.oldData || null,
      new_data: data.newData || null
    }
  });
};

const getAuditLogs = async (filters) => {
  const where = {};
  if (filters.entityName) where.entity_name = filters.entityName;
  if (filters.entityId) where.entity_id = filters.entityId;
  if (filters.action) where.action = filters.action;
  if (filters.userId) where.user_id = filters.userId;

  return await prisma.auditLog.findMany({
    where,
    include: {
      user: { select: { id: true, name: true, role: true } }
    },
    orderBy: { created_at: 'desc' }
  });
};

module.exports = {
  createAuditLog,
  getAuditLogs
};
