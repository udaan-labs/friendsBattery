-- §0 Roles foundation: SUPER_ADMIN + parent_id hierarchy

-- AlterEnum
ALTER TYPE "Role" ADD VALUE 'SUPER_ADMIN';

-- AlterTable: org parent (SA null → ADMIN → SELLER/EMPLOYEE)
ALTER TABLE "users" ADD COLUMN "parent_id" BIGINT;

-- CreateIndex
CREATE INDEX "users_parent_id_idx" ON "users"("parent_id");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
