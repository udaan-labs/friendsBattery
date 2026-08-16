const { prisma } = require('../../config/db');

const accountSelect = {
  id: true,
  userId: true,
  userName: true,
  role: true,
  isActive: true,
  location: { select: { name: true } },
};

class UsersRepository {
  findAccounts(role) {
    return prisma.user.findMany({
      where: { role },
      select: accountSelect,
      orderBy: { createdAt: 'desc' },
    });
  }

  findById(id) {
    return prisma.user.findUnique({
      where: { id: BigInt(id) },
      select: { id: true, userId: true, role: true, isActive: true },
    });
  }

  setActive(id, isActive) {
    return prisma.user.update({
      where: { id: BigInt(id) },
      data: { isActive },
      select: {
        id: true,
        userId: true,
        role: true,
        isActive: true,
      },
    });
  }
}

module.exports = new UsersRepository();
