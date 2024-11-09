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

-- AlterTable
ALTER TABLE "Property_Post" ALTER COLUMN "title_deed_id" DROP NOT NULL,
ALTER COLUMN "status_id" DROP NOT NULL,
ALTER COLUMN "unit_id" DROP NOT NULL,
ALTER COLUMN "geographies_id" DROP NOT NULL,
ALTER COLUMN "province_id" DROP NOT NULL,
ALTER COLUMN "amphure_id" DROP NOT NULL,
ALTER COLUMN "sub_district_id" DROP NOT NULL,
ALTER COLUMN "property_type_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_title_deed_id_fkey" FOREIGN KEY ("title_deed_id") REFERENCES "Title_Deed"("title_deed_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "Status"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "Unit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_geographies_id_fkey" FOREIGN KEY ("geographies_id") REFERENCES "Geographies"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_province_id_fkey" FOREIGN KEY ("province_id") REFERENCES "Province"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_amphure_id_fkey" FOREIGN KEY ("amphure_id") REFERENCES "Amphure"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_sub_district_id_fkey" FOREIGN KEY ("sub_district_id") REFERENCES "Sub_District"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property_Post" ADD CONSTRAINT "Property_Post_property_type_id_fkey" FOREIGN KEY ("property_type_id") REFERENCES "Property_Type"("property_type_id") ON DELETE SET NULL ON UPDATE CASCADE;
