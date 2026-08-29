-- Cash / online / credit (unpaid) on all bill tables
CREATE TYPE "PaymentMode" AS ENUM ('CASH', 'ONLINE', 'CREDIT');

ALTER TABLE "sales_transactions"
  ADD COLUMN IF NOT EXISTS "payment_mode" "PaymentMode" NOT NULL DEFAULT 'CASH';

ALTER TABLE "service_bills"
  ADD COLUMN IF NOT EXISTS "payment_mode" "PaymentMode" NOT NULL DEFAULT 'CASH';

ALTER TABLE "battery_rents"
  ADD COLUMN IF NOT EXISTS "payment_mode" "PaymentMode" NOT NULL DEFAULT 'CASH';
