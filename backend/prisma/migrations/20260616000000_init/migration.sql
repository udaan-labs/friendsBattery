-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('SUPER_ADMIN', 'SELLER');

-- CreateEnum
CREATE TYPE "ProductUnitStatus" AS ENUM ('IN_WAREHOUSE', 'AT_SHOP', 'SOLD', 'RETURNED', 'UNDER_INSPECTION', 'REPLACED', 'SCRAPPED');

-- CreateEnum
CREATE TYPE "OwnerType" AS ENUM ('WHOLESALER', 'SHOP', 'CUSTOMER');

-- CreateEnum
CREATE TYPE "TransactionType" AS ENUM ('RECEIVED', 'TRANSFERRED', 'SOLD', 'RETURNED', 'REPLACED', 'SCRAPPED');

-- CreateEnum
CREATE TYPE "StockRequestStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "ReturnStatus" AS ENUM ('PENDING', 'UNDER_INSPECTION', 'APPROVED', 'REJECTED', 'REPLACED', 'REPAIRED', 'SCRAPPED');

-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "shop_id" UUID,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shops" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shop_name" TEXT NOT NULL,
    "owner_name" TEXT NOT NULL,
    "mobile" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "shops_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_groups" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "product_groups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_subgroups" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "product_group_id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "product_subgroups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "products" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "product_subgroup_id" UUID NOT NULL,
    "brand_name" TEXT NOT NULL,
    "model_name" TEXT NOT NULL,
    "capacity" TEXT NOT NULL,
    "warranty_months" INTEGER NOT NULL,
    "minimum_selling_price" DECIMAL(10,2) NOT NULL,
    "is_serialized" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_units" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "serial_number" TEXT NOT NULL,
    "product_id" UUID NOT NULL,
    "manufacturing_date" DATE,
    "received_date" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "status" "ProductUnitStatus" NOT NULL DEFAULT 'IN_WAREHOUSE',
    "current_owner_type" "OwnerType" NOT NULL,
    "current_owner_id" UUID,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "product_units_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventory_transactions" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "product_unit_id" UUID,
    "product_id" UUID,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "transaction_type" "TransactionType" NOT NULL,
    "from_owner_type" "OwnerType" NOT NULL,
    "from_owner_id" UUID,
    "to_owner_type" "OwnerType" NOT NULL,
    "to_owner_id" UUID,
    "performed_by_user_id" UUID NOT NULL,
    "notes" TEXT,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "inventory_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sales" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "product_unit_id" UUID,
    "product_id" UUID,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "customer_id" UUID NOT NULL,
    "shop_id" UUID NOT NULL,
    "sold_by_user_id" UUID NOT NULL,
    "sale_price" DECIMAL NOT NULL,
    "sale_date" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "sales_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock_requests" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shop_id" UUID NOT NULL,
    "status" "StockRequestStatus" NOT NULL DEFAULT 'PENDING',
    "requested_by_user_id" UUID NOT NULL,
    "reviewed_by_user_id" UUID,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "stock_requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock_request_items" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "stock_request_id" UUID NOT NULL,
    "product_id" UUID NOT NULL,
    "requested_quantity" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "stock_request_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customers" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "full_name" TEXT NOT NULL,
    "mobile" TEXT NOT NULL,
    "vehicle_number" TEXT,
    "address" TEXT,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "customers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "audit_logs" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "user_id" UUID,
    "entity_name" TEXT NOT NULL,
    "entity_id" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "old_data" JSONB,
    "new_data" JSONB,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "shop_inventory_aggregates" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "shop_id" UUID NOT NULL,
    "product_id" UUID NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "updated_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "shop_inventory_aggregates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "returns" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "sale_id" UUID NOT NULL,
    "product_unit_id" UUID NOT NULL,
    "return_reason" TEXT NOT NULL,
    "status" "ReturnStatus" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "returns_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "replacements" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "return_id" UUID NOT NULL,
    "old_product_unit_id" UUID NOT NULL,
    "new_product_unit_id" UUID NOT NULL,
    "created_at" TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "replacements_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "product_units_serial_number_key" ON "product_units"("serial_number");

-- CreateIndex
CREATE INDEX "product_units_serial_number_idx" ON "product_units"("serial_number");

-- CreateIndex
CREATE INDEX "product_units_status_current_owner_id_idx" ON "product_units"("status", "current_owner_id");

-- CreateIndex
CREATE INDEX "inventory_transactions_product_unit_id_idx" ON "inventory_transactions"("product_unit_id");

-- CreateIndex
CREATE UNIQUE INDEX "sales_product_unit_id_key" ON "sales"("product_unit_id");

-- CreateIndex
CREATE INDEX "sales_shop_id_idx" ON "sales"("shop_id");

-- CreateIndex
CREATE UNIQUE INDEX "customers_mobile_key" ON "customers"("mobile");

-- CreateIndex
CREATE INDEX "audit_logs_entity_name_entity_id_idx" ON "audit_logs"("entity_name", "entity_id");

-- CreateIndex
CREATE INDEX "audit_logs_action_idx" ON "audit_logs"("action");

-- CreateIndex
CREATE UNIQUE INDEX "shop_inventory_aggregates_shop_id_product_id_key" ON "shop_inventory_aggregates"("shop_id", "product_id");

-- CreateIndex
CREATE UNIQUE INDEX "replacements_return_id_key" ON "replacements"("return_id");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_shop_id_fkey" FOREIGN KEY ("shop_id") REFERENCES "shops"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_subgroups" ADD CONSTRAINT "product_subgroups_product_group_id_fkey" FOREIGN KEY ("product_group_id") REFERENCES "product_groups"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_product_subgroup_id_fkey" FOREIGN KEY ("product_subgroup_id") REFERENCES "product_subgroups"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_units" ADD CONSTRAINT "product_units_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_transactions" ADD CONSTRAINT "inventory_transactions_product_unit_id_fkey" FOREIGN KEY ("product_unit_id") REFERENCES "product_units"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_transactions" ADD CONSTRAINT "inventory_transactions_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_transactions" ADD CONSTRAINT "inventory_transactions_performed_by_user_id_fkey" FOREIGN KEY ("performed_by_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_product_unit_id_fkey" FOREIGN KEY ("product_unit_id") REFERENCES "product_units"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_shop_id_fkey" FOREIGN KEY ("shop_id") REFERENCES "shops"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_sold_by_user_id_fkey" FOREIGN KEY ("sold_by_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_requests" ADD CONSTRAINT "stock_requests_shop_id_fkey" FOREIGN KEY ("shop_id") REFERENCES "shops"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_requests" ADD CONSTRAINT "stock_requests_requested_by_user_id_fkey" FOREIGN KEY ("requested_by_user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_requests" ADD CONSTRAINT "stock_requests_reviewed_by_user_id_fkey" FOREIGN KEY ("reviewed_by_user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_request_items" ADD CONSTRAINT "stock_request_items_stock_request_id_fkey" FOREIGN KEY ("stock_request_id") REFERENCES "stock_requests"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock_request_items" ADD CONSTRAINT "stock_request_items_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "audit_logs" ADD CONSTRAINT "audit_logs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shop_inventory_aggregates" ADD CONSTRAINT "shop_inventory_aggregates_shop_id_fkey" FOREIGN KEY ("shop_id") REFERENCES "shops"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "shop_inventory_aggregates" ADD CONSTRAINT "shop_inventory_aggregates_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "returns" ADD CONSTRAINT "returns_sale_id_fkey" FOREIGN KEY ("sale_id") REFERENCES "sales"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "returns" ADD CONSTRAINT "returns_product_unit_id_fkey" FOREIGN KEY ("product_unit_id") REFERENCES "product_units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "replacements" ADD CONSTRAINT "replacements_return_id_fkey" FOREIGN KEY ("return_id") REFERENCES "returns"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "replacements" ADD CONSTRAINT "replacements_old_product_unit_id_fkey" FOREIGN KEY ("old_product_unit_id") REFERENCES "product_units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "replacements" ADD CONSTRAINT "replacements_new_product_unit_id_fkey" FOREIGN KEY ("new_product_unit_id") REFERENCES "product_units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

