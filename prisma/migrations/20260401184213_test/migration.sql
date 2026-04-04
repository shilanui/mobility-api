/*
  Warnings:

  - A unique constraint covering the columns `[vehicle_id,driver_id]` on the table `driver_vehicle` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "driver_vehicle_vehicle_id_driver_id_key" ON "driver_vehicle"("vehicle_id", "driver_id");
