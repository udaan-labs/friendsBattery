const { execSync } = require('child_process');
const path = require('path');
const dotenv = require('dotenv');

// Load environment variables from .env.prod
dotenv.config({ path: path.join(__dirname, '../.env.prod'), override: true });

const directUrl = process.env.DIRECT_URL || process.env.DATABASE_URL;

if (!directUrl) {
  console.error('Error: Neither DIRECT_URL nor DATABASE_URL found in backend/.env.prod');
  process.exit(1);
}

console.log('🚀 Running production database migrations against production DB...');
try {
  execSync('npx prisma migrate deploy', {
    cwd: path.join(__dirname, '..'),
    env: { ...process.env, DATABASE_URL: directUrl },
    stdio: 'inherit',
  });
  console.log('✅ Production migrations completed successfully!');
} catch (err) {
  console.error('❌ Migration failed:', err.message);
  process.exit(1);
}
