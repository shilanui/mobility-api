/*
  Warnings:

  - You are about to drop the column `lon` on the `VehicleEvent` table. All the data in the column will be lost.
  - You are about to drop the column `lon` on the `VehicleTelemetry` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "VehicleEvent" DROP COLUMN "lon",
ADD COLUMN     "long" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "VehicleTelemetry" DROP COLUMN "lon",
ADD COLUMN     "long" DOUBLE PRECISION;
