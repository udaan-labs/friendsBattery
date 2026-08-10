-- AlterEnum UnitStatus
ALTER TYPE "UnitStatus" ADD VALUE 'RENTED';

-- AlterEnum TransactionAction
ALTER TYPE "TransactionAction" ADD VALUE 'RENTED';
ALTER TYPE "TransactionAction" ADD VALUE 'RENT_RETURNED';

-- CreateEnum
CREATE TYPE "RentStatus" AS ENUM ('OUT', 'RETURNED');

-- CreateTable
CREATE TABLE "battery_rents" (
    "id" BIGSERIAL NOT NULL,
    "product_unit_id" BIGINT NOT NULL,
    "seller_id" BIGINT NOT NULL,
    "customer_id" BIGINT,
    "serial_number" VARCHAR(100) NOT NULL,
    "deposit" DECIMAL(12,2) NOT NULL,
    "rent_fee" DECIMAL(12,2),
    "refund_amount" DECIMAL(12,2),
    "status" "RentStatus" NOT NULL DEFAULT 'OUT',
    "rented_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "returned_at" TIMESTAMP,

    CONSTRAINT "battery_rents_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "battery_rents_seller_id_status_idx" ON "battery_rents"("seller_id", "status");

-- CreateIndex
CREATE INDEX "battery_rents_serial_number_idx" ON "battery_rents"("serial_number");

-- CreateIndex
CREATE INDEX "battery_rents_status_idx" ON "battery_rents"("status");

-- AddForeignKey
ALTER TABLE "battery_rents" ADD CONSTRAINT "battery_rents_product_unit_id_fkey" FOREIGN KEY ("product_unit_id") REFERENCES "product_units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "battery_rents" ADD CONSTRAINT "battery_rents_seller_id_fkey" FOREIGN KEY ("seller_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "battery_rents" ADD CONSTRAINT "battery_rents_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customers"("id") ON DELETE SET NULL ON UPDATE CASCADE;
