-- AlterTable
ALTER TABLE "inventory_transactions"
ADD COLUMN "from_location_id" BIGINT,
ADD COLUMN "to_location_id" BIGINT;

-- CreateIndex
CREATE INDEX "inventory_transactions_from_location_id_idx" ON "inventory_transactions"("from_location_id");

-- CreateIndex
CREATE INDEX "inventory_transactions_to_location_id_idx" ON "inventory_transactions"("to_location_id");

-- AddForeignKey
ALTER TABLE "inventory_transactions" ADD CONSTRAINT "inventory_transactions_from_location_id_fkey" FOREIGN KEY ("from_location_id") REFERENCES "locations"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_transactions" ADD CONSTRAINT "inventory_transactions_to_location_id_fkey" FOREIGN KEY ("to_location_id") REFERENCES "locations"("id") ON DELETE SET NULL ON UPDATE CASCADE;
