/*
  Warnings:

  - You are about to drop the column `vehicle_id` on the `drivers` table. All the data in the column will be lost.
  - You are about to drop the column `driver_name` on the `vehicle_telemetry` table. All the data in the column will be lost.
  - Added the required column `driver_id` to the `vehicle_telemetry` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "drivers" DROP CONSTRAINT "drivers_vehicle_id_fkey";

-- DropIndex
DROP INDEX "drivers_vehicle_id_idx";

-- AlterTable
ALTER TABLE "drivers" DROP COLUMN "vehicle_id";

-- AlterTable
ALTER TABLE "vehicle_telemetry" DROP COLUMN "driver_name",
ADD COLUMN     "driver_id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "driver_vehicle" (
    "id" SERIAL NOT NULL,
    "vehicle_id" INTEGER NOT NULL,
    "driver_id" INTEGER NOT NULL,
    "start_at" TIMESTAMP(3),
    "end_at" TIMESTAMP(3),

    CONSTRAINT "driver_vehicle_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "driver_vehicle_vehicle_id_idx" ON "driver_vehicle"("vehicle_id");

-- CreateIndex
CREATE INDEX "driver_vehicle_driver_id_idx" ON "driver_vehicle"("driver_id");

-- AddForeignKey
ALTER TABLE "vehicle_telemetry" ADD CONSTRAINT "vehicle_telemetry_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "drivers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driver_vehicle" ADD CONSTRAINT "driver_vehicle_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "driver_vehicle" ADD CONSTRAINT "driver_vehicle_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "drivers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
