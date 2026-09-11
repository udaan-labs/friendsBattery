-- Partial credit: running amount collected on unit sales.
ALTER TABLE "sales_transactions" ADD COLUMN "amount_paid" DECIMAL(12,2) NOT NULL DEFAULT 0;

UPDATE "sales_transactions"
SET "amount_paid" = "sell_price"
WHERE "payment_mode" <> 'CREDIT';
