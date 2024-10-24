-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_agency_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_package_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_role_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_status_id_fkey";

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "agency_id" DROP NOT NULL,
ALTER COLUMN "package_id" DROP NOT NULL,
ALTER COLUMN "role_id" DROP NOT NULL,
ALTER COLUMN "status_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "Role"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_package_id_fkey" FOREIGN KEY ("package_id") REFERENCES "Package"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "Status"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_agency_id_fkey" FOREIGN KEY ("agency_id") REFERENCES "Agency"("id") ON DELETE SET NULL ON UPDATE CASCADE;
