-- One open check-in per employee (prevents double CHECKED_IN race)
CREATE UNIQUE INDEX IF NOT EXISTS "employee_attendance_one_open_per_employee"
ON "employee_attendance" ("employee_id")
WHERE "status" = 'CHECKED_IN' AND "check_out_time" IS NULL;
