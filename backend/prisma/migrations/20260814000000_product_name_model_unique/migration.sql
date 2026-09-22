-- Keep the oldest row per name+model; drop unused duplicates.
DELETE FROM products p
WHERE p.id NOT IN (
  SELECT keep_id FROM (
    SELECT MIN(id) AS keep_id FROM products GROUP BY product_name_id, product_model_id
  ) kept
)
AND NOT EXISTS (SELECT 1 FROM product_units u WHERE u.product_id = p.id)
AND NOT EXISTS (SELECT 1 FROM stock_request_items sri WHERE sri.product_id = p.id)
AND NOT EXISTS (SELECT 1 FROM sales_transactions st WHERE st.product_id = p.id)
AND NOT EXISTS (SELECT 1 FROM sales_transactions st WHERE st.product_replaced_id = p.id)
AND NOT EXISTS (SELECT 1 FROM return_products rp WHERE rp.product_id = p.id)
AND NOT EXISTS (SELECT 1 FROM shipment_items si WHERE si.product_id = p.id);

CREATE UNIQUE INDEX "products_product_name_id_product_model_id_key"
  ON "products"("product_name_id", "product_model_id");
