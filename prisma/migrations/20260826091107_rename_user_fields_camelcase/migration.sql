/*
  Warnings:

  - You are about to drop the column `notificationsEnabled` on the `User` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `User` DROP COLUMN `notificationsEnabled`,
    ADD COLUMN `notifications_enabled` BOOLEAN NOT NULL DEFAULT true;
