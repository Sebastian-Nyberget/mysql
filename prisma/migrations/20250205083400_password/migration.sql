/*
  Warnings:

  - Added the required column `password` to the `medlemmer` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `medlemmer` ADD COLUMN `password` VARCHAR(255) NOT NULL;
