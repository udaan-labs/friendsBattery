const app = require('./app');
const { PORT } = require('./config/env');
const { testConnection } = require('./config/db');

const startServer = async () => {
  await testConnection();
  
  app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server is running on port ${PORT} across all network interfaces (0.0.0.0)`);
  });
};

startServer();
