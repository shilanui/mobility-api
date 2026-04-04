/*
  Warnings:

  - You are about to drop the `Amphure` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Appointment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Favourite` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Geographies` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Land_Type` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Notification` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Package` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Property_Post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Property_Type` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Province` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Role` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Status` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Sub_District` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Title_Deed` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Unit` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Amphure" DROP CONSTRAINT "Amphure_province_id_fkey";

-- DropForeignKey
ALTER TABLE "Appointment" DROP CONSTRAINT "Appointment_user_id_fkey";

-- DropForeignKey
ALTER TABLE "Favourite" DROP CONSTRAINT "Favourite_property_id_fkey";

-- DropForeignKey
ALTER TABLE "Favourite" DROP CONSTRAINT "Favourite_user_id_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_property_id_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_user_id_fkey";

-- DropForeignKey
ALTER TABLE "Package" DROP CONSTRAINT "Package_unit_id_fkey";

-- DropForeignKey
ALTER TABLE "Property_Post" DROP CONSTRAINT "Property_Post_amphure_id_fkey";

-- DropForeignKey
ALTER TABLE "Property_Post" DROP CONSTRAINT "Property_Post_geographies_id_fkey";

-- DropForeignKey
ALTER TABLE "Property_Post" DROP CONSTRAINT "Property_Post_property_type_id_fkey";

-- DropForeignKey
ALTER TABLE "Property_Post" DROP CONSTRAINT "Property_Post_province_id_fkey";

-- DropForeignKey
ALTER TABLE "Property_Post" DROP CONSTRAINT "Property_Post_status_id_fkey";

-- DropForeignKey
ALTER TABLE "Property_Post" DROP CONSTRAINT "Property_Post_sub_district_id_fkey";

-- DropForeignKey
ALTER TABLE "Property_Post" DROP CONSTRAINT "Property_Post_title_deed_id_fkey";

-- DropForeignKey
ALTER TABLE "Property_Post" DROP CONSTRAINT "Property_Post_unit_id_fkey";

-- DropForeignKey
ALTER TABLE "Property_Post" DROP CONSTRAINT "Property_Post_user_id_fkey";

-- DropForeignKey
ALTER TABLE "Province" DROP CONSTRAINT "Province_geographies_id_fkey";

-- DropForeignKey
ALTER TABLE "Sub_District" DROP CONSTRAINT "Sub_District_amphure_id_fkey";

-- DropForeignKey
ALTER TABLE "Title_Deed" DROP CONSTRAINT "Title_Deed_land_type_id_fkey";

-- DropForeignKey
ALTER TABLE "Title_Deed" DROP CONSTRAINT "Title_Deed_unit_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_package_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_status_id_fkey";

-- DropTable
DROP TABLE "Amphure";

-- DropTable
DROP TABLE "Appointment";

-- DropTable
DROP TABLE "Favourite";

-- DropTable
DROP TABLE "Geographies";

-- DropTable
DROP TABLE "Land_Type";

-- DropTable
DROP TABLE "Notification";

-- DropTable
DROP TABLE "Package";

-- DropTable
DROP TABLE "Property_Post";

-- DropTable
DROP TABLE "Property_Type";

-- DropTable
DROP TABLE "Province";

-- DropTable
DROP TABLE "Role";

-- DropTable
DROP TABLE "Status";

-- DropTable
DROP TABLE "Sub_District";

-- DropTable
DROP TABLE "Title_Deed";

-- DropTable
DROP TABLE "Unit";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Vehicle" (
    "id" TEXT NOT NULL,
    "source" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Vehicle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VehicleTelemetry" (
    "vehicleId" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "lat" DOUBLE PRECISION,
    "lon" DOUBLE PRECISION,
    "speedKmh" DOUBLE PRECISION,
    "headingDeg" DOUBLE PRECISION,
    "engineOn" BOOLEAN,
    "odometerKm" DOUBLE PRECISION,
    "driverName" TEXT,

    CONSTRAINT "VehicleTelemetry_pkey" PRIMARY KEY ("vehicleId","timestamp")
);

-- CreateTable
CREATE TABLE "CanSignal" (
    "vehicleId" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "signalName" TEXT NOT NULL,
    "signalValue" DOUBLE PRECISION NOT NULL,
    "signalUnit" TEXT,

    CONSTRAINT "CanSignal_pkey" PRIMARY KEY ("vehicleId","timestamp","signalName")
);

-- CreateTable
CREATE TABLE "VehicleEvent" (
    "eventId" TEXT NOT NULL,
    "vehicleId" TEXT NOT NULL,
    "eventType" INTEGER NOT NULL,
    "eventName" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "lat" DOUBLE PRECISION,
    "lon" DOUBLE PRECISION,
    "speedKmh" DOUBLE PRECISION,
    "fuelInputLiters" DOUBLE PRECISION,
    "totalDistanceKm" DOUBLE PRECISION,
    "batteryVoltage" DOUBLE PRECISION,

    CONSTRAINT "VehicleEvent_pkey" PRIMARY KEY ("eventId")
);

-- CreateTable
CREATE TABLE "UnsafeEvent" (
    "id" SERIAL NOT NULL,
    "vehicleId" TEXT NOT NULL,
    "eventType" TEXT NOT NULL,
    "severity" DOUBLE PRECISION NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "meta" JSONB,

    CONSTRAINT "UnsafeEvent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DriverScore" (
    "vehicleId" TEXT NOT NULL,
    "scoreDate" TIMESTAMP(3) NOT NULL,
    "finalScore" DOUBLE PRECISION NOT NULL,
    "speedingScore" DOUBLE PRECISION NOT NULL,
    "brakingScore" DOUBLE PRECISION NOT NULL,
    "accelScore" DOUBLE PRECISION NOT NULL,
    "idleScore" DOUBLE PRECISION NOT NULL,
    "nightScore" DOUBLE PRECISION NOT NULL,
    "riskClass" TEXT NOT NULL,

    CONSTRAINT "DriverScore_pkey" PRIMARY KEY ("vehicleId","scoreDate")
);

-- CreateIndex
CREATE INDEX "VehicleTelemetry_timestamp_idx" ON "VehicleTelemetry"("timestamp");

-- CreateIndex
CREATE INDEX "VehicleTelemetry_vehicleId_timestamp_idx" ON "VehicleTelemetry"("vehicleId", "timestamp");

-- CreateIndex
CREATE INDEX "CanSignal_vehicleId_signalName_timestamp_idx" ON "CanSignal"("vehicleId", "signalName", "timestamp");

-- CreateIndex
CREATE INDEX "CanSignal_timestamp_idx" ON "CanSignal"("timestamp");

-- CreateIndex
CREATE INDEX "VehicleEvent_vehicleId_timestamp_idx" ON "VehicleEvent"("vehicleId", "timestamp");

-- CreateIndex
CREATE INDEX "VehicleEvent_eventType_idx" ON "VehicleEvent"("eventType");

-- CreateIndex
CREATE INDEX "UnsafeEvent_vehicleId_timestamp_idx" ON "UnsafeEvent"("vehicleId", "timestamp");

-- CreateIndex
CREATE INDEX "UnsafeEvent_eventType_idx" ON "UnsafeEvent"("eventType");

-- CreateIndex
CREATE INDEX "DriverScore_scoreDate_idx" ON "DriverScore"("scoreDate");

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
