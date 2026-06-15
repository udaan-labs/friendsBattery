const { PrismaClient } = require('@prisma/client');
const { logInfo, logError } = require('./logger');

const prisma = new PrismaClient({
  log: ['query', 'info', 'warn', 'error'],
});

const testConnection = async () => {
  try {
    await prisma.$connect();
    logInfo('Successfully connected to the database via Prisma.');
  } catch (err) {
    logError('Database connection failed:', err.message);
  }
};

module.exports = {
  prisma,
  testConnection
};
