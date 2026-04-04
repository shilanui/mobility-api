/*
  Warnings:

  - You are about to drop the column `event_name` on the `vehicle_event` table. All the data in the column will be lost.
  - You are about to drop the column `event_type` on the `vehicle_event` table. All the data in the column will be lost.
  - Changed the type of `event_type` on the `event` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `event_id` to the `vehicle_event` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "vehicle_event_event_type_idx";

-- AlterTable
ALTER TABLE "event" DROP COLUMN "event_type",
ADD COLUMN     "event_type" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "vehicle_event" DROP COLUMN "event_name",
DROP COLUMN "event_type",
ADD COLUMN     "event_id" INTEGER NOT NULL;

-- CreateIndex
CREATE INDEX "event_event_type_idx" ON "event"("event_type");

-- CreateIndex
CREATE INDEX "vehicle_event_event_id_idx" ON "vehicle_event"("event_id");

-- AddForeignKey
ALTER TABLE "vehicle_event" ADD CONSTRAINT "vehicle_event_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "event"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
