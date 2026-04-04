/*
  Warnings:

  - You are about to drop the `CanSignal` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DriverScore` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `UnsafeEvent` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Vehicle` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `VehicleEvent` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `VehicleTelemetry` table. If the table is not empty, all the data it contains will be lost.

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

-- DropTable
DROP TABLE "CanSignal";

-- DropTable
DROP TABLE "DriverScore";

-- DropTable
DROP TABLE "UnsafeEvent";

-- DropTable
DROP TABLE "Vehicle";

-- DropTable
DROP TABLE "VehicleEvent";

-- DropTable
DROP TABLE "VehicleTelemetry";

-- CreateTable
CREATE TABLE "vehicle" (
    "id" SERIAL NOT NULL,
    "vehicle_name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "vehicle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vehicle_telemetry" (
    "id" SERIAL NOT NULL,
    "vehicle_id" INTEGER NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "lat" DOUBLE PRECISION,
    "long" DOUBLE PRECISION,
    "speed_kmh" DOUBLE PRECISION,
    "heading_deg" DOUBLE PRECISION,
    "engine_on" BOOLEAN,
    "odometer_km" DOUBLE PRECISION,
    "driver_name" TEXT,

    CONSTRAINT "vehicle_telemetry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "can_signal" (
    "id" SERIAL NOT NULL,
    "vehicle_id" INTEGER NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "signal_name" TEXT NOT NULL,
    "signal_value" DOUBLE PRECISION NOT NULL,
    "signal_unit" TEXT,

    CONSTRAINT "can_signal_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vehicle_event" (
    "id" SERIAL NOT NULL,
    "vehicle_id" INTEGER NOT NULL,
    "event_type" INTEGER NOT NULL,
    "event_name" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "lat" DOUBLE PRECISION,
    "long" DOUBLE PRECISION,
    "speed_kmh" DOUBLE PRECISION,
    "fuel_input_liters" DOUBLE PRECISION,
    "total_distance_Km" DOUBLE PRECISION,
    "battery_voltage" DOUBLE PRECISION,

    CONSTRAINT "vehicle_event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "unsafe_event" (
    "id" SERIAL NOT NULL,
    "vehicle_id" INTEGER NOT NULL,
    "event_type" TEXT NOT NULL,
    "severity" DOUBLE PRECISION NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "meta" JSONB,

    CONSTRAINT "unsafe_event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "driver_score" (
    "id" SERIAL NOT NULL,
    "vehicle_id" INTEGER NOT NULL,
    "score_date" TIMESTAMP(3) NOT NULL,
    "final_score" DOUBLE PRECISION NOT NULL,
    "speeding_score" DOUBLE PRECISION NOT NULL,
    "braking_score" DOUBLE PRECISION NOT NULL,
    "accel_score" DOUBLE PRECISION NOT NULL,
    "idle_score" DOUBLE PRECISION NOT NULL,
    "night_score" DOUBLE PRECISION NOT NULL,
    "riskClass" TEXT NOT NULL,

    CONSTRAINT "driver_score_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "vehicle_vehicle_name_key" ON "vehicle"("vehicle_name");

-- CreateIndex
CREATE INDEX "vehicle_telemetry_vehicle_id_timestamp_idx" ON "vehicle_telemetry"("vehicle_id", "timestamp");

-- CreateIndex
CREATE INDEX "vehicle_telemetry_timestamp_idx" ON "vehicle_telemetry"("timestamp");

-- CreateIndex
CREATE INDEX "can_signal_vehicle_id_timestamp_signal_name_idx" ON "can_signal"("vehicle_id", "timestamp", "signal_name");

-- CreateIndex
CREATE INDEX "can_signal_vehicle_id_signal_name_timestamp_idx" ON "can_signal"("vehicle_id", "signal_name", "timestamp");

-- CreateIndex
CREATE INDEX "can_signal_timestamp_idx" ON "can_signal"("timestamp");

-- CreateIndex
CREATE INDEX "vehicle_event_vehicle_id_timestamp_idx" ON "vehicle_event"("vehicle_id", "timestamp");

-- CreateIndex
CREATE INDEX "vehicle_event_event_type_idx" ON "vehicle_event"("event_type");

-- CreateIndex
CREATE INDEX "unsafe_event_vehicle_id_timestamp_idx" ON "unsafe_event"("vehicle_id", "timestamp");

-- CreateIndex
CREATE INDEX "unsafe_event_event_type_idx" ON "unsafe_event"("event_type");

-- CreateIndex
CREATE INDEX "driver_score_vehicle_id_score_date_idx" ON "driver_score"("vehicle_id", "score_date");

-- CreateIndex
CREATE INDEX "driver_score_score_date_idx" ON "driver_score"("score_date");

-- AddForeignKey
ALTER TABLE "vehicle_telemetry" ADD CONSTRAINT "vehicle_telemetry_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "can_signal" ADD CONSTRAINT "can_signal_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vehicle_event" ADD CONSTRAINT "vehicle_event_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "unsafe_event" ADD CONSTRAINT "unsafe_event_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driver_score" ADD CONSTRAINT "driver_score_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
