const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient({
  log: ['query', 'info', 'warn', 'error'],
});

const testConnection = async () => {
  try {
    await prisma.$connect();
    console.info(`[INFO] ${new Date().toISOString()} - Successfully connected to the database via Prisma.`);
  } catch (err) {
    console.error(`[ERROR] ${new Date().toISOString()} - Database connection failed:`, err.message);
  }
};

module.exports = {
  prisma,
  testConnection
};
