-- CreateEnum
CREATE TYPE "AttendanceStatus" AS ENUM ('CHECKED_IN', 'CHECKED_OUT');

-- AlterTable
ALTER TABLE "employee_attendance"
ADD COLUMN "check_out_time" TIMESTAMP,
ADD COLUMN "check_in_lat" DECIMAL(10,7),
ADD COLUMN "check_in_lng" DECIMAL(10,7),
ADD COLUMN "check_out_lat" DECIMAL(10,7),
ADD COLUMN "check_out_lng" DECIMAL(10,7),
ADD COLUMN "check_in_address" TEXT,
ADD COLUMN "check_out_address" TEXT,
ADD COLUMN "status" "AttendanceStatus" NOT NULL DEFAULT 'CHECKED_IN',
ADD COLUMN "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- CreateIndex
CREATE INDEX "employee_attendance_status_idx" ON "employee_attendance"("status");
