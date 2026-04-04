/*
  Warnings:

  - You are about to drop the column `event_type` on the `unsafe_event` table. All the data in the column will be lost.
  - You are about to drop the column `meta` on the `unsafe_event` table. All the data in the column will be lost.
  - Added the required column `event_id` to the `unsafe_event` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `severity` on the `unsafe_event` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "Severity" AS ENUM ('LOW', 'MEDIUM', 'HIGH');

-- DropIndex
DROP INDEX "unsafe_event_event_type_idx";

-- AlterTable
ALTER TABLE "unsafe_event" DROP COLUMN "event_type",
DROP COLUMN "meta",
ADD COLUMN     "driver_id" INTEGER,
ADD COLUMN     "event_id" INTEGER NOT NULL,
ADD COLUMN     "telemetry_id" INTEGER,
ADD COLUMN     "threshold" DOUBLE PRECISION,
ADD COLUMN     "value" DOUBLE PRECISION,
DROP COLUMN "severity",
ADD COLUMN     "severity" "Severity" NOT NULL;

-- CreateTable
CREATE TABLE "event" (
    "id" SERIAL NOT NULL,
    "event_type" TEXT NOT NULL,
    "event_name" TEXT NOT NULL,

    CONSTRAINT "event_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "event_event_type_idx" ON "event"("event_type");

-- CreateIndex
CREATE INDEX "unsafe_event_event_id_idx" ON "unsafe_event"("event_id");

-- AddForeignKey
ALTER TABLE "unsafe_event" ADD CONSTRAINT "unsafe_event_event_id_fkey" FOREIGN KEY ("event_id") REFERENCES "event"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "unsafe_event" ADD CONSTRAINT "unsafe_event_driver_id_fkey" FOREIGN KEY ("driver_id") REFERENCES "drivers"("id") ON DELETE SET NULL ON UPDATE CASCADE;
