const { prisma } = require('../config/db');

class OrgEventsRepository {
  async create({ action, actorId, entityType, entityId, payload }) {
    if (actorId == null) return null;
    return prisma.orgEvent.create({
      data: {
        action,
        actorId: BigInt(actorId),
        entityType,
        entityId: BigInt(entityId),
        payload,
      },
    });
  }
}

module.exports = new OrgEventsRepository();
