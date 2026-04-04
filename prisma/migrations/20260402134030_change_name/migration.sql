/*
  Warnings:

  - You are about to drop the column `total_distance_Km` on the `vehicle_event` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "vehicle_event" DROP COLUMN "total_distance_Km",
ADD COLUMN     "total_distance_km" DOUBLE PRECISION;
