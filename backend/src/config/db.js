const { Pool } = require('pg');
const { DATABASE_URL } = require('./env');
const { logInfo, logError } = require('./logger');

const pool = new Pool({
  connectionString: DATABASE_URL,
});

const testConnection = async () => {
  try {
    const client = await pool.connect();
    await client.query('SELECT 1');
    client.release();
    logInfo('Successfully connected to the database.');
  } catch (err) {
    logError('Database connection failed:', err.message);
  }
};

module.exports = {
  pool,
  testConnection
};
