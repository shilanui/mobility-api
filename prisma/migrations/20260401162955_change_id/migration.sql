/*
  Warnings:

  - The primary key for the `CanSignal` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `DriverScore` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Vehicle` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The `id` column on the `Vehicle` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `source` column on the `Vehicle` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The primary key for the `VehicleEvent` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `eventId` on the `VehicleEvent` table. All the data in the column will be lost.
  - The primary key for the `VehicleTelemetry` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Changed the type of `vehicleId` on the `CanSignal` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `vehicleId` on the `DriverScore` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `vehicleId` on the `UnsafeEvent` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `vehicleId` on the `VehicleEvent` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `vehicleId` on the `VehicleTelemetry` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

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
ALTER TABLE "CanSignal" DROP CONSTRAINT "CanSignal_pkey",
ADD COLUMN     "id" SERIAL NOT NULL,
DROP COLUMN "vehicleId",
ADD COLUMN     "vehicleId" INTEGER NOT NULL,
ADD CONSTRAINT "CanSignal_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "DriverScore" DROP CONSTRAINT "DriverScore_pkey",
ADD COLUMN     "id" SERIAL NOT NULL,
DROP COLUMN "vehicleId",
ADD COLUMN     "vehicleId" INTEGER NOT NULL,
ADD CONSTRAINT "DriverScore_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "UnsafeEvent" DROP COLUMN "vehicleId",
ADD COLUMN     "vehicleId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Vehicle" DROP CONSTRAINT "Vehicle_pkey",
DROP COLUMN "id",
ADD COLUMN     "id" SERIAL NOT NULL,
DROP COLUMN "source",
ADD COLUMN     "source" INTEGER,
ADD CONSTRAINT "Vehicle_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "VehicleEvent" DROP CONSTRAINT "VehicleEvent_pkey",
DROP COLUMN "eventId",
ADD COLUMN     "id" SERIAL NOT NULL,
DROP COLUMN "vehicleId",
ADD COLUMN     "vehicleId" INTEGER NOT NULL,
ADD CONSTRAINT "VehicleEvent_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "VehicleTelemetry" DROP CONSTRAINT "VehicleTelemetry_pkey",
ADD COLUMN     "id" SERIAL NOT NULL,
DROP COLUMN "vehicleId",
ADD COLUMN     "vehicleId" INTEGER NOT NULL,
ADD CONSTRAINT "VehicleTelemetry_pkey" PRIMARY KEY ("id");

-- CreateIndex
CREATE INDEX "CanSignal_vehicleId_timestamp_signalName_idx" ON "CanSignal"("vehicleId", "timestamp", "signalName");

-- CreateIndex
CREATE INDEX "CanSignal_vehicleId_signalName_timestamp_idx" ON "CanSignal"("vehicleId", "signalName", "timestamp");

-- CreateIndex
CREATE INDEX "DriverScore_vehicleId_scoreDate_idx" ON "DriverScore"("vehicleId", "scoreDate");

-- CreateIndex
CREATE INDEX "UnsafeEvent_vehicleId_timestamp_idx" ON "UnsafeEvent"("vehicleId", "timestamp");

-- CreateIndex
CREATE INDEX "VehicleEvent_vehicleId_timestamp_idx" ON "VehicleEvent"("vehicleId", "timestamp");

-- CreateIndex
CREATE INDEX "VehicleTelemetry_vehicleId_timestamp_idx" ON "VehicleTelemetry"("vehicleId", "timestamp");

-- AddForeignKey
ALTER TABLE "VehicleTelemetry" ADD CONSTRAINT "VehicleTelemetry_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CanSignal" ADD CONSTRAINT "CanSignal_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VehicleEvent" ADD CONSTRAINT "VehicleEvent_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UnsafeEvent" ADD CONSTRAINT "UnsafeEvent_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DriverScore" ADD CONSTRAINT "DriverScore_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
