/*
  Warnings:

  - You are about to drop the column `amName` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `emailVerified` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `image` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Account` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Session` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `VerificationToken` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `accountManagerId` to the `MetricMonthly` table without a default value. This is not possible if the table is not empty.
  - Made the column `name` on table `User` required. This step will fail if there are existing NULL values in that column.
  - Made the column `email` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Account" DROP CONSTRAINT "Account_userId_fkey";

-- DropForeignKey
ALTER TABLE "Session" DROP CONSTRAINT "Session_userId_fkey";

-- DropIndex
DROP INDEX "MetricMonthly_amName_month_idx";

-- AlterTable
ALTER TABLE "MetricMonthly" ADD COLUMN     "accountManagerId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "amName",
DROP COLUMN "createdAt",
DROP COLUMN "emailVerified",
DROP COLUMN "image",
DROP COLUMN "updatedAt",
ADD COLUMN     "amId" INTEGER,
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "email" SET NOT NULL;

-- DropTable
DROP TABLE "Account";

-- DropTable
DROP TABLE "Session";

-- DropTable
DROP TABLE "VerificationToken";

-- CreateTable
CREATE TABLE "AccountManager" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AccountManager_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "AccountManager_email_key" ON "AccountManager"("email");

-- CreateIndex
CREATE INDEX "MetricMonthly_accountManagerId_idx" ON "MetricMonthly"("accountManagerId");

-- CreateIndex
CREATE INDEX "MetricMonthly_month_idx" ON "MetricMonthly"("month");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_amId_fkey" FOREIGN KEY ("amId") REFERENCES "AccountManager"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MetricMonthly" ADD CONSTRAINT "MetricMonthly_accountManagerId_fkey" FOREIGN KEY ("accountManagerId") REFERENCES "AccountManager"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
