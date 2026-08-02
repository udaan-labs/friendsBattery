-- CreateTable
CREATE TABLE "employee_roles" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,

    CONSTRAINT "employee_roles_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "employee_roles_name_key" ON "employee_roles"("name");

-- AlterTable
ALTER TABLE "users" ADD COLUMN "employee_role_id" BIGINT;

-- CreateIndex
CREATE INDEX "users_employee_role_id_idx" ON "users"("employee_role_id");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_employee_role_id_fkey" FOREIGN KEY ("employee_role_id") REFERENCES "employee_roles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- Seed example employee roles
INSERT INTO "employee_roles" ("name", "description") VALUES
  ('Manager', 'Shop or warehouse manager'),
  ('Cashier', 'Checkout and billing'),
  ('Warehouse Staff', 'Warehouse operations'),
  ('Delivery Boy', 'Deliveries'),
  ('Sales Executive', 'Sales floor');
