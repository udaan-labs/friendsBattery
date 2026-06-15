const { prisma } = require('../../config/db');

const findUserByEmail = async (email) => {
  return await prisma.user.findUnique({
    where: { email },
  });
};

module.exports = { findUserByEmail };
