const app = require('./app');
const { PORT } = require('./config/env');
const { prisma, testConnection } = require('./config/db');

const startServer = async () => {
  const server = app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on port ${PORT} across all network interfaces (0.0.0.0)`);
  });

  // Verify DB connection asynchronously without blocking port listening
  testConnection().catch((err) => {
    console.error('Initial DB connection check error:', err.message);
  });

  const shutdown = async (signal) => {
    console.log(`${signal} received, shutting down...`);
    const forceTimer = setTimeout(() => {
      console.error('Forced exit after 10s');
      process.exit(1);
    }, 10000);
    forceTimer.unref();

    server.close(async () => {
      await prisma.$disconnect();
      process.exit(0);
    });
  };

  process.on('SIGTERM', () => shutdown('SIGTERM'));
  process.on('SIGINT', () => shutdown('SIGINT'));
};

startServer();
