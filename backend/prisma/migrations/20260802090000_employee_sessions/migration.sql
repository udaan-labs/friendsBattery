-- CreateTable
CREATE TABLE "employee_sessions" (
    "id" BIGSERIAL NOT NULL,
    "employee_id" BIGINT NOT NULL,
    "login_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "logout_time" TIMESTAMP,
    "device_id" VARCHAR(255),
    "ip_address" VARCHAR(45),
    "app_version" VARCHAR(50),
    "firebase_token" TEXT,

    CONSTRAINT "employee_sessions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "employee_sessions_employee_id_idx" ON "employee_sessions"("employee_id");

-- CreateIndex
CREATE INDEX "employee_sessions_login_time_idx" ON "employee_sessions"("login_time");

-- AddForeignKey
ALTER TABLE "employee_sessions" ADD CONSTRAINT "employee_sessions_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
