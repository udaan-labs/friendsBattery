-- CreateEnum
CREATE TYPE "ServiceBillType" AS ENUM (
  'BATTERY_CHECK_2W',
  'BATTERY_CHECK_4W',
  'BATTERY_CHARGING',
  'JUMPSTART',
  'INVERTER_SERVICE'
);

-- CreateTable
CREATE TABLE "service_bills" (
    "id" BIGSERIAL NOT NULL,
    "seller_id" BIGINT NOT NULL,
    "customer_id" BIGINT,
    "service_type" "ServiceBillType" NOT NULL,
    "amount" DECIMAL(12,2) NOT NULL,
    "vehicle_number" VARCHAR(50),
    "place" VARCHAR(200),
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "service_bills_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "service_bills_seller_id_created_at_idx" ON "service_bills"("seller_id", "created_at");

-- CreateIndex
CREATE INDEX "service_bills_service_type_idx" ON "service_bills"("service_type");

-- AddForeignKey
ALTER TABLE "service_bills" ADD CONSTRAINT "service_bills_seller_id_fkey" FOREIGN KEY ("seller_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_bills" ADD CONSTRAINT "service_bills_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customers"("id") ON DELETE SET NULL ON UPDATE CASCADE;
