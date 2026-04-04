/*
  Warnings:

  - You are about to drop the column `source` on the `Vehicle` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[vehicleId]` on the table `Vehicle` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `vehicleId` to the `Vehicle` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "CanSignal" DROP CONSTRAINT "CanSignal_vehicleId_fkey";

-- DropForeignKey
ALTER TABLE "DriverScore" DROP CONSTRAINT "DriverScore_vehicleId_fkey";

-- DropForeignKey
ALTER TABLE "UnsafeEvent" DROP CONSTRAINT "UnsafeEvent_vehicleId_fkey";

-- DropForeignKey
ALTER TABLE "VehicleEvent" DROP CONSTRAINT "VehicleEvent_vehicleId_fkey";

-- DropForeignKey
ALTER TABLE "VehicleTelemetry" DROP CONSTRAINT "VehicleTelemetry_vehicleId_fkey";

-- AlterTable
ALTER TABLE "CanSignal" ALTER COLUMN "vehicleId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "DriverScore" ALTER COLUMN "vehicleId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "UnsafeEvent" ALTER COLUMN "vehicleId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "Vehicle" DROP COLUMN "source",
ADD COLUMN     "vehicleId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "VehicleEvent" ALTER COLUMN "vehicleId" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "VehicleTelemetry" ALTER COLUMN "vehicleId" SET DATA TYPE TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "Vehicle_vehicleId_key" ON "Vehicle"("vehicleId");

-- AddForeignKey
ALTER TABLE "VehicleTelemetry" ADD CONSTRAINT "VehicleTelemetry_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("vehicleId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CanSignal" ADD CONSTRAINT "CanSignal_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("vehicleId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VehicleEvent" ADD CONSTRAINT "VehicleEvent_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("vehicleId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnsafeEvent" ADD CONSTRAINT "UnsafeEvent_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("vehicleId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DriverScore" ADD CONSTRAINT "DriverScore_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("vehicleId") ON DELETE RESTRICT ON UPDATE CASCADE;
