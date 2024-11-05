/*
  Warnings:

  - You are about to drop the column `app_date` on the `Appointment` table. All the data in the column will be lost.
  - You are about to drop the column `buyer_id` on the `Favourite` table. All the data in the column will be lost.
  - You are about to drop the column `agency_id` on the `Notification` table. All the data in the column will be lost.
  - You are about to drop the column `agency_id` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `role_id` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Agency` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Property` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Units` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User_Agent` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User_Appointment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User_Role` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[role_name]` on the table `Role` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[status_name]` on the table `Status` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `user_id` to the `Appointment` table without a default value. This is not possible if the table is not empty.
  - Made the column `property_id` on table `Notification` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_agency_id_fkey";

-- DropForeignKey
ALTER TABLE "Property" DROP CONSTRAINT "Property_seller_id_fkey";

-- DropForeignKey
ALTER TABLE "Property" DROP CONSTRAINT "Property_status_id_fkey";

-- DropForeignKey
ALTER TABLE "Property" DROP CONSTRAINT "Property_unit_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_agency_id_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_role_id_fkey";

-- DropForeignKey
ALTER TABLE "User_Agent" DROP CONSTRAINT "User_Agent_agency_id_fkey";

-- DropForeignKey
ALTER TABLE "User_Agent" DROP CONSTRAINT "User_Agent_user_id_fkey";

-- DropForeignKey
ALTER TABLE "User_Role" DROP CONSTRAINT "User_Role_role_id_fkey";

-- DropForeignKey
ALTER TABLE "User_Role" DROP CONSTRAINT "User_Role_user_id_fkey";

-- AlterTable
ALTER TABLE "Appointment" DROP COLUMN "app_date",
ADD COLUMN     "user_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Favourite" DROP COLUMN "buyer_id";

-- AlterTable
ALTER TABLE "Notification" DROP COLUMN "agency_id",
ALTER COLUMN "property_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "Package" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "description" TEXT,
ADD COLUMN     "end_time" TIMESTAMP(3),
ADD COLUMN     "price" INTEGER,
ADD COLUMN     "start_time" TIMESTAMP(3),
ADD COLUMN     "unit_id" INTEGER,
ADD COLUMN     "updated_at" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "Role" ADD COLUMN     "description" TEXT;

-- AlterTable
ALTER TABLE "Status" ADD COLUMN     "description" TEXT;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "agency_id",
DROP COLUMN "role_id",
ADD COLUMN     "agency_address" TEXT,
ADD COLUMN     "agency_name" TEXT,
ADD COLUMN     "agency_phone_num" TEXT,
ADD COLUMN     "agency_tax_id_no" TEXT,
ALTER COLUMN "birth_date" DROP NOT NULL,
ALTER COLUMN "phone_number" DROP NOT NULL;

-- DropTable
DROP TABLE "Agency";

-- DropTable
DROP TABLE "Property";

-- DropTable
DROP TABLE "Units";

-- DropTable
DROP TABLE "User_Agent";

-- DropTable
DROP TABLE "User_Appointment";

-- DropTable
DROP TABLE "User_Role";

-- CreateTable
CREATE TABLE "Land_Type" (
    "id" SERIAL NOT NULL,
    "land_type" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "Land_Type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Property_Post" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "title_deed_id" INTEGER NOT NULL,
    "status_id" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "geographies_id" INTEGER NOT NULL,
    "province_id" INTEGER NOT NULL,
    "amphure_id" INTEGER NOT NULL,
    "sub_district_id" INTEGER NOT NULL,
    "property_type_id" INTEGER NOT NULL,
    "property_name" TEXT,
    "description" TEXT,
    "price" INTEGER,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "land_area_rai" DECIMAL(10,2),
    "land_area_ngan" DECIMAL(10,2),
    "land_area_square_wa" DECIMAL(10,2),
    "usable_size_square_m" DECIMAL(10,2),
    "bedroom_count" INTEGER,
    "bathroom_count" INTEGER,
    "kitchen_count" INTEGER,
    "floors_count" INTEGER,
    "view_count" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Property_Post_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Unit" (
    "id" SERIAL NOT NULL,
    "unit_name" TEXT NOT NULL,
    "unit_type" TEXT NOT NULL,
    "conversion_factor" DECIMAL(10,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Unit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Geographies" (
    "id" SERIAL NOT NULL,
    "geo_name" TEXT NOT NULL,

    CONSTRAINT "Geographies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Province" (
    "id" SERIAL NOT NULL,
    "geographies_id" INTEGER NOT NULL,
    "code" TEXT NOT NULL,
    "name_th" TEXT NOT NULL,
    "name_en" TEXT NOT NULL,

    CONSTRAINT "Province_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Amphure" (
    "id" SERIAL NOT NULL,
    "province_id" INTEGER NOT NULL,
    "code" TEXT NOT NULL,
    "name_th" TEXT NOT NULL,
    "name_en" TEXT NOT NULL,

    CONSTRAINT "Amphure_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Sub_District" (
    "id" SERIAL NOT NULL,
    "amphure_id" INTEGER NOT NULL,
    "zip_code" TEXT NOT NULL,
    "name_th" TEXT NOT NULL,
    "name_en" TEXT NOT NULL,

    CONSTRAINT "Sub_District_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Title_Deed" (
    "title_deed_id" SERIAL NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "land_type_id" INTEGER NOT NULL,
    "title_deed_no" TEXT NOT NULL,
    "issue_date" TIMESTAMP(3) NOT NULL,
    "land_officer" TEXT,
    "map_street" TEXT,
    "parcel_no" TEXT,
    "sub_district_no" TEXT,
    "sub_district_name" TEXT,
    "volume" TEXT,
    "package" TEXT,
    "unit_no" TEXT,
    "floor_no" TEXT,
    "condo_no" TEXT,
    "condo_title" TEXT,
    "condo_regist_no" TEXT,
    "owner_name_1" TEXT,
    "owner_name_2" TEXT,
    "owner_name_3" TEXT,

    CONSTRAINT "Title_Deed_pkey" PRIMARY KEY ("title_deed_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Role_role_name_key" ON "Role"("role_name");

-- CreateIndex
CREATE UNIQUE INDEX "Status_status_name_key" ON "Status"("status_name");

-- AddForeignKey
ALTER TABLE "Package" ADD CONSTRAINT "Package_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "Unit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_property_id_fkey" FOREIGN KEY ("property_id") REFERENCES "Property_Post"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favourite" ADD CONSTRAINT "Favourite_property_id_fkey" FOREIGN KEY ("property_id") REFERENCES "Property_Post"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_title_deed_id_fkey" FOREIGN KEY ("title_deed_id") REFERENCES "Title_Deed"("title_deed_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "Status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "Unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_geographies_id_fkey" FOREIGN KEY ("geographies_id") REFERENCES "Geographies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_province_id_fkey" FOREIGN KEY ("province_id") REFERENCES "Province"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_amphure_id_fkey" FOREIGN KEY ("amphure_id") REFERENCES "Amphure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_sub_district_id_fkey" FOREIGN KEY ("sub_district_id") REFERENCES "Sub_District"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_property_type_id_fkey" FOREIGN KEY ("property_type_id") REFERENCES "Property_Type"("property_type_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Appointment" ADD CONSTRAINT "Appointment_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Province" ADD CONSTRAINT "Province_geographies_id_fkey" FOREIGN KEY ("geographies_id") REFERENCES "Geographies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Amphure" ADD CONSTRAINT "Amphure_province_id_fkey" FOREIGN KEY ("province_id") REFERENCES "Province"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sub_District" ADD CONSTRAINT "Sub_District_amphure_id_fkey" FOREIGN KEY ("amphure_id") REFERENCES "Amphure"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Title_Deed" ADD CONSTRAINT "Title_Deed_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "Unit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Title_Deed" ADD CONSTRAINT "Title_Deed_land_type_id_fkey" FOREIGN KEY ("land_type_id") REFERENCES "Land_Type"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
