-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_agency_id_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_user_id_fkey";

-- AlterTable
ALTER TABLE "Notification" ALTER COLUMN "property_id" DROP NOT NULL,
ALTER COLUMN "user_id" DROP NOT NULL,
ALTER COLUMN "agency_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_agency_id_fkey" FOREIGN KEY ("agency_id") REFERENCES "Agency"("id") ON DELETE SET NULL ON UPDATE CASCADE;
