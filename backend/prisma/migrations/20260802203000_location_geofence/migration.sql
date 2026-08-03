-- Geofence fields for employee attendance (shop / warehouse)
ALTER TABLE "locations"
  ADD COLUMN IF NOT EXISTS "latitude" DECIMAL(10,7),
  ADD COLUMN IF NOT EXISTS "longitude" DECIMAL(10,7),
  ADD COLUMN IF NOT EXISTS "allowed_radius" INTEGER NOT NULL DEFAULT 100;
