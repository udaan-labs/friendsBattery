const { prisma } = require('../../config/db');

/**
 * UserRepository using Prisma (LINQ-like experience)
 */
const UserRepository = {
  // CREATE
  async create(userData) {
    return await prisma.user.create({
      data: {
        name: userData.name,
        email: userData.email,
        password_hash: userData.password_hash,
        role: userData.role,
        shop_id: userData.shop_id,
      },
    });
  },

  // READ (Find by Email)
  async findByEmail(email) {
    return await prisma.user.findUnique({
      where: { email },
    });
  },

  // READ (Get all with Shop details)
  async findAll() {
    return await prisma.user.findMany({
      include: {
        shop: true, // This is like .Include(u => u.Shop) in LINQ
      },
    });
  },

  // UPDATE
  async update(id, updateData) {
    return await prisma.user.update({
      where: { id },
      data: updateData,
    });
  },

  // DELETE
  async delete(id) {
    return await prisma.user.delete({
      where: { id },
    });
  }
};

module.exports = UserRepository;
