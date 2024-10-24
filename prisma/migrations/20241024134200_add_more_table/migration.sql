-- DropIndex
DROP INDEX "User_agency_id_key";

-- DropIndex
DROP INDEX "User_package_id_key";

-- DropIndex
DROP INDEX "User_role_id_key";

-- DropIndex
DROP INDEX "User_status_id_key";

-- CreateTable
CREATE TABLE "User_Role" (
    "id" SERIAL NOT NULL,
    "role_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "User_Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User_Agent" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "agency_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_Agent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" SERIAL NOT NULL,
    "property_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "agency_id" INTEGER NOT NULL,
    "message" TEXT NOT NULL,
    "is_read" BOOLEAN NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Favourite" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "is_favourite" BOOLEAN NOT NULL,
    "buyer_id" INTEGER NOT NULL,
    "property_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Favourite_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Property_Type" (
    "property_type_id" SERIAL NOT NULL,
    "property_type" TEXT NOT NULL,

    CONSTRAINT "Property_Type_pkey" PRIMARY KEY ("property_type_id")
);

-- CreateTable
CREATE TABLE "Property" (
    "id" SERIAL NOT NULL,
    "title_deed_id" INTEGER NOT NULL,
    "status_id" INTEGER NOT NULL,
    "property_type_id" INTEGER NOT NULL,
    "seller_id" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "property_name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "land_area_rai" DECIMAL(10,2) NOT NULL,
    "land_area_ngan" DECIMAL(10,2) NOT NULL,
    "land_area_square_wa" DECIMAL(10,2) NOT NULL,
    "usable_size_square_m" DECIMAL(10,2) NOT NULL,
    "bedroom" INTEGER,
    "bathroom" INTEGER,
    "kitchen" INTEGER,
    "floors" INTEGER,
    "view_count" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Property_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Units" (
    "id" SERIAL NOT NULL,
    "unit_name" TEXT NOT NULL,
    "unit_type" TEXT NOT NULL,
    "conversion_factor" DECIMAL(10,2) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Units_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Appointment" (
    "id" SERIAL NOT NULL,
    "app_status" TEXT NOT NULL,
    "app_date" TIMESTAMP(3) NOT NULL,
    "start_time" TIMESTAMP(3) NOT NULL,
    "end_time" TIMESTAMP(3) NOT NULL,
    "location" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Appointment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User_Appointment" (
    "id" SERIAL NOT NULL,
    "appointment_id" INTEGER NOT NULL,
    "buyer_id" INTEGER NOT NULL,
    "seller_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_Appointment_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "User_Role" ADD CONSTRAINT "User_Role_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User_Role" ADD CONSTRAINT "User_Role_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User_Agent" ADD CONSTRAINT "User_Agent_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User_Agent" ADD CONSTRAINT "User_Agent_agency_id_fkey" FOREIGN KEY ("agency_id") REFERENCES "Agency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_agency_id_fkey" FOREIGN KEY ("agency_id") REFERENCES "Agency"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Favourite" ADD CONSTRAINT "Favourite_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "Status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_seller_id_fkey" FOREIGN KEY ("seller_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "Units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
