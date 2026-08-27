-- CreateTable
CREATE TABLE "product_catalog_events" (
    "id" BIGSERIAL NOT NULL,
    "action" VARCHAR(40) NOT NULL,
    "actor_id" BIGINT NOT NULL,
    "product_name_id" BIGINT,
    "product_model_id" BIGINT,
    "product_id" BIGINT,
    "payload" JSONB NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "product_catalog_events_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "product_catalog_events_created_at_idx" ON "product_catalog_events"("created_at");

-- CreateIndex
CREATE INDEX "product_catalog_events_product_name_id_created_at_idx" ON "product_catalog_events"("product_name_id", "created_at");

-- CreateIndex
CREATE INDEX "product_catalog_events_actor_id_created_at_idx" ON "product_catalog_events"("actor_id", "created_at");

-- AddForeignKey
ALTER TABLE "product_catalog_events" ADD CONSTRAINT "product_catalog_events_actor_id_fkey" FOREIGN KEY ("actor_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_catalog_events" ADD CONSTRAINT "product_catalog_events_product_name_id_fkey" FOREIGN KEY ("product_name_id") REFERENCES "product_names"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_catalog_events" ADD CONSTRAINT "product_catalog_events_product_model_id_fkey" FOREIGN KEY ("product_model_id") REFERENCES "product_models"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_catalog_events" ADD CONSTRAINT "product_catalog_events_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE SET NULL ON UPDATE CASCADE;
