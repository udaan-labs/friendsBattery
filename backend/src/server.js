const app = require('./app');
const { PORT } = require('./config/env');
const { testConnection } = require('./config/db');

const startServer = async () => {
  await testConnection();
  
  app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
  });
};

startServer();
