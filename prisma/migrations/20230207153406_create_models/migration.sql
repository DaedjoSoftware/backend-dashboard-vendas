/*
  Warnings:

  - Added the required column `amount` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `category_Id` to the `products` table without a default value. This is not possible if the table is not empty.
  - Made the column `due_date` on table `products` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "products" ADD COLUMN     "amount" INTEGER NOT NULL,
ADD COLUMN     "category_Id" TEXT NOT NULL,
ALTER COLUMN "due_date" SET NOT NULL;

-- CreateTable
CREATE TABLE "categories" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "stock_Id" TEXT NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stocks" (
    "id" TEXT NOT NULL,
    "entry_date" TEXT NOT NULL,
    "physical_location" TEXT NOT NULL,
    "sold_quantity" INTEGER NOT NULL,
    "suppliers" TEXT NOT NULL,

    CONSTRAINT "stocks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "cashflows" (
    "id" TEXT NOT NULL,
    "date" TEXT NOT NULL,
    "balance" INTEGER NOT NULL,
    "additional_informations" TEXT NOT NULL,
    "supplier" TEXT NOT NULL,
    "stock_Id" TEXT NOT NULL,

    CONSTRAINT "cashflows_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sellers" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "sale" INTEGER NOT NULL,
    "cashFlow_Id" TEXT,

    CONSTRAINT "sellers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "clients" (
    "id" TEXT NOT NULL,
    "kind_payment" TEXT NOT NULL,
    "transaction_description" TEXT NOT NULL,
    "date_sale" TEXT NOT NULL,
    "product_Id" TEXT NOT NULL,
    "sellers_Id" TEXT NOT NULL,

    CONSTRAINT "clients_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_category_Id_fkey" FOREIGN KEY ("category_Id") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "categories" ADD CONSTRAINT "categories_stock_Id_fkey" FOREIGN KEY ("stock_Id") REFERENCES "stocks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cashflows" ADD CONSTRAINT "cashflows_stock_Id_fkey" FOREIGN KEY ("stock_Id") REFERENCES "stocks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sellers" ADD CONSTRAINT "sellers_cashFlow_Id_fkey" FOREIGN KEY ("cashFlow_Id") REFERENCES "cashflows"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "clients" ADD CONSTRAINT "clients_product_Id_fkey" FOREIGN KEY ("product_Id") REFERENCES "products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "clients" ADD CONSTRAINT "clients_sellers_Id_fkey" FOREIGN KEY ("sellers_Id") REFERENCES "sellers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
