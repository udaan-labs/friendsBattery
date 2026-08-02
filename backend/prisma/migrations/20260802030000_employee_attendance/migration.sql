-- CreateTable
CREATE TABLE "employee_attendance" (
    "id" BIGSERIAL NOT NULL,
    "employee_id" BIGINT NOT NULL,
    "assigned_location_id" BIGINT NOT NULL,
    "check_in_time" TIMESTAMP NOT NULL,

    CONSTRAINT "employee_attendance_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "employee_attendance_employee_id_idx" ON "employee_attendance"("employee_id");

-- CreateIndex
CREATE INDEX "employee_attendance_assigned_location_id_idx" ON "employee_attendance"("assigned_location_id");

-- CreateIndex
CREATE INDEX "employee_attendance_check_in_time_idx" ON "employee_attendance"("check_in_time");

-- AddForeignKey
ALTER TABLE "employee_attendance" ADD CONSTRAINT "employee_attendance_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee_attendance" ADD CONSTRAINT "employee_attendance_assigned_location_id_fkey" FOREIGN KEY ("assigned_location_id") REFERENCES "locations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
