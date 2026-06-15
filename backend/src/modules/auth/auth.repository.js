const { pool } = require('../../config/db');

const findUserByEmail = async (email) => {
  const query = 'SELECT * FROM users WHERE email = $1 LIMIT 1';
  const result = await pool.query(query, [email]);
  return result.rows[0];
};

module.exports = { findUserByEmail };
