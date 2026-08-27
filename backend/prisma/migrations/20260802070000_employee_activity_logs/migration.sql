-- CreateTable
CREATE TABLE "employee_activity_logs" (
    "id" BIGSERIAL NOT NULL,
    "employee_id" BIGINT NOT NULL,
    "action" VARCHAR(100) NOT NULL,
    "reference_id" BIGINT,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "employee_activity_logs_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "employee_activity_logs_employee_id_idx" ON "employee_activity_logs"("employee_id");

-- CreateIndex
CREATE INDEX "employee_activity_logs_created_at_idx" ON "employee_activity_logs"("created_at");

-- CreateIndex
CREATE INDEX "employee_activity_logs_action_idx" ON "employee_activity_logs"("action");

-- AddForeignKey
ALTER TABLE "employee_activity_logs" ADD CONSTRAINT "employee_activity_logs_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
