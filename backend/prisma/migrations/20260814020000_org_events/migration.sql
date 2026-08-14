-- CreateTable
CREATE TABLE "org_events" (
    "id" BIGSERIAL NOT NULL,
    "action" VARCHAR(40) NOT NULL,
    "actor_id" BIGINT NOT NULL,
    "entity_type" VARCHAR(20) NOT NULL,
    "entity_id" BIGINT NOT NULL,
    "payload" JSONB NOT NULL,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "org_events_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "org_events_created_at_idx" ON "org_events"("created_at");

-- CreateIndex
CREATE INDEX "org_events_actor_id_created_at_idx" ON "org_events"("actor_id", "created_at");

-- AddForeignKey
ALTER TABLE "org_events" ADD CONSTRAINT "org_events_actor_id_fkey" FOREIGN KEY ("actor_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
