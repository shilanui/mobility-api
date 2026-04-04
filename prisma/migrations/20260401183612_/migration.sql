/*
  Warnings:

  - A unique constraint covering the columns `[driver_name]` on the table `drivers` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "drivers_driver_name_key" ON "drivers"("driver_name");
