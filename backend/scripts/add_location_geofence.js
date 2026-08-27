/**
 * One-shot: add geofence columns to locations (migrate history drift-safe).
 * Run: node scripts/add_location_geofence.js
 */
require('dotenv').config();
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function main() {
  await prisma.$executeRawUnsafe(`
    ALTER TABLE locations
      ADD COLUMN IF NOT EXISTS latitude DECIMAL(10,7),
      ADD COLUMN IF NOT EXISTS longitude DECIMAL(10,7),
      ADD COLUMN IF NOT EXISTS allowed_radius INTEGER NOT NULL DEFAULT 100
  `);

  await prisma.$executeRawUnsafe(`
    UPDATE locations
    SET latitude = 23.0225,
        longitude = 72.5714,
        allowed_radius = COALESCE(allowed_radius, 100)
    WHERE latitude IS NULL OR longitude IS NULL
  `);

  console.log('locations geofence columns ready');
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
