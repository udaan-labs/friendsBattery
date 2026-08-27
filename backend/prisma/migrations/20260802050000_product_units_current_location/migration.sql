-- AlterTable
ALTER TABLE "product_units" ADD COLUMN "current_location_id" BIGINT;

-- CreateIndex
CREATE INDEX "product_units_current_location_id_idx" ON "product_units"("current_location_id");

-- AddForeignKey
ALTER TABLE "product_units" ADD CONSTRAINT "product_units_current_location_id_fkey" FOREIGN KEY ("current_location_id") REFERENCES "locations"("id") ON DELETE SET NULL ON UPDATE CASCADE;
