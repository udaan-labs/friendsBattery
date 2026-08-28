-- Latest GPS while checked in (foreground pings only)
ALTER TABLE "employee_attendance"
ADD COLUMN "last_lat" DECIMAL(10,7),
ADD COLUMN "last_lng" DECIMAL(10,7),
ADD COLUMN "last_seen_at" TIMESTAMP;

UPDATE "employee_attendance"
SET "last_lat" = "check_in_lat",
    "last_lng" = "check_in_lng",
    "last_seen_at" = "check_in_time"
WHERE "status" = 'CHECKED_IN' AND "check_out_time" IS NULL;
