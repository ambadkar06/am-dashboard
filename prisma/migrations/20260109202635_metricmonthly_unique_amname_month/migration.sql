/*
  Warnings:

  - A unique constraint covering the columns `[amName,month]` on the table `MetricMonthly` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "MetricMonthly_amName_month_key" ON "MetricMonthly"("amName", "month");
