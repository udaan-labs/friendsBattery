-- Sale variants: scrap trade-in + mechanic B2B
CREATE TYPE "SaleType" AS ENUM ('NORMAL', 'SCRAP', 'MECHANIC');

ALTER TABLE "sales_transactions"
  ADD COLUMN IF NOT EXISTS "sale_type" "SaleType" NOT NULL DEFAULT 'NORMAL',
  ADD COLUMN IF NOT EXISTS "scrap_serial" VARCHAR(100);

CREATE INDEX IF NOT EXISTS "sales_transactions_sale_type_idx" ON "sales_transactions"("sale_type");
