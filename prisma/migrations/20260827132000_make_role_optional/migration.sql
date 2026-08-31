-- DropForeignKey
ALTER TABLE `User` DROP FOREIGN KEY `fk_user_role`;

-- AlterTable
ALTER TABLE `User` MODIFY `role_id` INTEGER NULL;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `Role`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
