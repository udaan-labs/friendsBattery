const fs = require('fs');
const path = require('path');
const { pool } = require('../config/db');

async function runMigrations() {
  try {
    const migrationPath = path.join(__dirname, 'migrations', '001_core_schema.sql');
    const sql = fs.readFileSync(migrationPath, 'utf8');

    console.log('Running migration: 001_core_schema.sql...');
    await pool.query(sql);
    console.log('Migration executed successfully.');

    const query = `
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
      AND table_type = 'BASE TABLE'
    `;
    const result = await pool.query(query);
    
    console.log('\nList of Created Tables:');
    const tables = result.rows.map(row => row.table_name);
    const expectedTables = ['users', 'shops', 'product_groups', 'product_subgroups', 'product_units', 'inventory_transactions', 'sales', 'stock_requests'];
    
    tables.forEach(table => {
      if (expectedTables.includes(table)) {
        console.log(`- ${table}`);
      }
    });

  } catch (error) {
    console.error('Error running migrations:', error);
  } finally {
    await pool.end();
  }
}

runMigrations();
