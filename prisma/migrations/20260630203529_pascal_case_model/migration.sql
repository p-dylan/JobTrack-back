/*
  Warnings:

  - You are about to drop the `application` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `application_document` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `comment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `company` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `company_follower` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `connection` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `contact` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `document` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `employment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `interview` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `job_offering` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `message` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `notification` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `publication` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `role` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `skill` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_skill` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `application` DROP FOREIGN KEY `fk_application_job`;

-- DropForeignKey
ALTER TABLE `application` DROP FOREIGN KEY `fk_application_user`;

-- DropForeignKey
ALTER TABLE `application_document` DROP FOREIGN KEY `fk_ad_application`;

-- DropForeignKey
ALTER TABLE `application_document` DROP FOREIGN KEY `fk_ad_document`;

-- DropForeignKey
ALTER TABLE `comment` DROP FOREIGN KEY `fk_comment_parent`;

-- DropForeignKey
ALTER TABLE `comment` DROP FOREIGN KEY `fk_comment_publication`;

-- DropForeignKey
ALTER TABLE `comment` DROP FOREIGN KEY `fk_comment_user`;

-- DropForeignKey
ALTER TABLE `company_follower` DROP FOREIGN KEY `fk_cf_company`;

-- DropForeignKey
ALTER TABLE `company_follower` DROP FOREIGN KEY `fk_cf_user`;

-- DropForeignKey
ALTER TABLE `connection` DROP FOREIGN KEY `fk_conn_action`;

-- DropForeignKey
ALTER TABLE `connection` DROP FOREIGN KEY `fk_conn_receiver`;

-- DropForeignKey
ALTER TABLE `contact` DROP FOREIGN KEY `fk_contact_company`;

-- DropForeignKey
ALTER TABLE `employment` DROP FOREIGN KEY `fk_emp_company`;

-- DropForeignKey
ALTER TABLE `employment` DROP FOREIGN KEY `fk_emp_user`;

-- DropForeignKey
ALTER TABLE `interview` DROP FOREIGN KEY `fk_interview_application`;

-- DropForeignKey
ALTER TABLE `job_offering` DROP FOREIGN KEY `fk_job_company`;

-- DropForeignKey
ALTER TABLE `message` DROP FOREIGN KEY `fk_message_application`;

-- DropForeignKey
ALTER TABLE `message` DROP FOREIGN KEY `fk_message_job`;

-- DropForeignKey
ALTER TABLE `message` DROP FOREIGN KEY `fk_message_recipient`;

-- DropForeignKey
ALTER TABLE `message` DROP FOREIGN KEY `fk_message_sender`;

-- DropForeignKey
ALTER TABLE `notification` DROP FOREIGN KEY `fk_notification_target`;

-- DropForeignKey
ALTER TABLE `publication` DROP FOREIGN KEY `fk_publication_user`;

-- DropForeignKey
ALTER TABLE `user` DROP FOREIGN KEY `fk_user_role`;

-- DropForeignKey
ALTER TABLE `user_skill` DROP FOREIGN KEY `fk_uc_competence`;

-- DropForeignKey
ALTER TABLE `user_skill` DROP FOREIGN KEY `fk_uc_user`;

-- DropTable
DROP TABLE `application`;

-- DropTable
DROP TABLE `application_document`;

-- DropTable
DROP TABLE `comment`;

-- DropTable
DROP TABLE `company`;

-- DropTable
DROP TABLE `company_follower`;

-- DropTable
DROP TABLE `connection`;

-- DropTable
DROP TABLE `contact`;

-- DropTable
DROP TABLE `document`;

-- DropTable
DROP TABLE `employment`;

-- DropTable
DROP TABLE `interview`;

-- DropTable
DROP TABLE `job_offering`;

-- DropTable
DROP TABLE `message`;

-- DropTable
DROP TABLE `notification`;

-- DropTable
DROP TABLE `publication`;

-- DropTable
DROP TABLE `role`;

-- DropTable
DROP TABLE `skill`;

-- DropTable
DROP TABLE `user`;

-- DropTable
DROP TABLE `user_skill`;

-- CreateTable
CREATE TABLE `Application` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `job_offering_id` INTEGER NOT NULL,
    `status` ENUM('PENDING', 'ACCEPTED', 'REJECTED', 'WITHDRAWN') NOT NULL DEFAULT 'PENDING',
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_application_job`(`job_offering_id`),
    INDEX `fk_application_user`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Application_document` (
    `application_id` INTEGER NOT NULL,
    `document_id` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_ad_document`(`document_id`),
    PRIMARY KEY (`application_id`, `document_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Comment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `publication_id` INTEGER NOT NULL,
    `user_id` INTEGER NOT NULL,
    `parent_comment_id` INTEGER NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_comment_parent`(`parent_comment_id`),
    INDEX `fk_comment_publication`(`publication_id`),
    INDEX `fk_comment_user`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Company` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `business_sector` VARCHAR(150) NOT NULL,
    `website` VARCHAR(255) NULL,
    `address` TEXT NULL,
    `is_public` BOOLEAN NOT NULL DEFAULT true,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id_UNIQUE`(`id`),
    UNIQUE INDEX `company_name_UNIQUE`(`name`),
    INDEX `business_sector`(`business_sector`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Company_follower` (
    `user_id` INTEGER NOT NULL,
    `company_id` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_cf_company`(`company_id`),
    PRIMARY KEY (`user_id`, `company_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Connection` (
    `user_action_id` INTEGER NOT NULL,
    `user_receiver_id` INTEGER NOT NULL,
    `status` ENUM('PENDING', 'ACCEPTED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_connection_receiver`(`user_receiver_id`),
    PRIMARY KEY (`user_action_id`, `user_receiver_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Contact` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `company_id` INTEGER NOT NULL,
    `contact_name` VARCHAR(255) NOT NULL,
    `job_title` VARCHAR(150) NOT NULL,
    `contact_email` VARCHAR(255) NOT NULL,
    `phone_number` VARCHAR(50) NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id_UNIQUE`(`id`),
    UNIQUE INDEX `contact_email_UNIQUE`(`contact_email`),
    INDEX `fk_contact_company`(`company_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Document` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `type` ENUM('CV', 'LETTRE', 'DIPLOME') NOT NULL,
    `file_url` VARCHAR(500) NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id_UNIQUE`(`id`),
    UNIQUE INDEX `file_url_UNIQUE`(`file_url`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Employment` (
    `user_id` INTEGER NOT NULL,
    `company_id` INTEGER NOT NULL,
    `job_title` VARCHAR(255) NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NULL,
    `is_current` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_emp_company`(`company_id`),
    PRIMARY KEY (`user_id`, `company_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Interview` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `application_id` INTEGER NOT NULL,
    `interview_type` ENUM('TELEPHONE', 'VISIO', 'PRESENTIEL') NOT NULL,
    `scheduled_at` TIMESTAMP(0) NOT NULL,
    `notes` TEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_interview_application`(`application_id`),
    INDEX `fk_interview_schedule`(`scheduled_at`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Job_offering` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `company_id` INTEGER NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `contract_type` ENUM('CDI', 'CDD', 'Freelance', 'Stage') NOT NULL,
    `description` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_job_company`(`company_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Message` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `recipient_id` INTEGER NOT NULL,
    `sender_id` INTEGER NOT NULL,
    `application_context_id` INTEGER NULL,
    `job_context_id` INTEGER NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_message_application`(`application_context_id`),
    INDEX `fk_message_job`(`job_context_id`),
    INDEX `fk_message_recipient`(`recipient_id`),
    INDEX `fk_message_sender`(`sender_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notification` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `target_user_id` INTEGER NOT NULL,
    `trigger_id` INTEGER NOT NULL,
    `source_id` INTEGER NULL,
    `event_type` ENUM('NEW_APPLICATION', 'APPLICATION_ACCEPTED', 'APPLICATION_REJECTED', 'NEW_MESSAGE', 'INTERVIEW_INVITATION', 'INTERVIEW_REMINDER') NOT NULL,
    `is_read` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_notification_target`(`target_user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Publication` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `type` ENUM('ARTICLE', 'ANNONCE', 'ACTU') NOT NULL,
    `is_public` BOOLEAN NOT NULL DEFAULT true,
    `likes_count` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_publication_user`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Role` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id_UNIQUE`(`id`),
    UNIQUE INDEX `name_UNIQUE`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Skill` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(150) NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `id_UNIQUE`(`id`),
    UNIQUE INDEX `name_UNIQUE`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `role_id` INTEGER NOT NULL,
    `first_name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `email`(`email`),
    INDEX `fk_user_role`(`role_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User_skill` (
    `user_id` INTEGER NOT NULL,
    `skill_id` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_uc_competence`(`skill_id`),
    PRIMARY KEY (`user_id`, `skill_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Application` ADD CONSTRAINT `fk_application_job` FOREIGN KEY (`job_offering_id`) REFERENCES `Job_offering`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Application` ADD CONSTRAINT `fk_application_user` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Application_document` ADD CONSTRAINT `fk_ad_application` FOREIGN KEY (`application_id`) REFERENCES `Application`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Application_document` ADD CONSTRAINT `fk_ad_document` FOREIGN KEY (`document_id`) REFERENCES `Document`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `fk_comment_parent` FOREIGN KEY (`parent_comment_id`) REFERENCES `Comment`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `fk_comment_publication` FOREIGN KEY (`publication_id`) REFERENCES `Publication`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `fk_comment_user` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Company_follower` ADD CONSTRAINT `fk_cf_company` FOREIGN KEY (`company_id`) REFERENCES `Company`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Company_follower` ADD CONSTRAINT `fk_cf_user` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Connection` ADD CONSTRAINT `fk_conn_action` FOREIGN KEY (`user_action_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Connection` ADD CONSTRAINT `fk_conn_receiver` FOREIGN KEY (`user_receiver_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Contact` ADD CONSTRAINT `fk_contact_company` FOREIGN KEY (`company_id`) REFERENCES `Company`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Employment` ADD CONSTRAINT `fk_emp_company` FOREIGN KEY (`company_id`) REFERENCES `Company`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Employment` ADD CONSTRAINT `fk_emp_user` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Interview` ADD CONSTRAINT `fk_interview_application` FOREIGN KEY (`application_id`) REFERENCES `Application`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Job_offering` ADD CONSTRAINT `fk_job_company` FOREIGN KEY (`company_id`) REFERENCES `Company`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Message` ADD CONSTRAINT `fk_message_application` FOREIGN KEY (`application_context_id`) REFERENCES `Application`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Message` ADD CONSTRAINT `fk_message_job` FOREIGN KEY (`job_context_id`) REFERENCES `Job_offering`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Message` ADD CONSTRAINT `fk_message_recipient` FOREIGN KEY (`recipient_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Message` ADD CONSTRAINT `fk_message_sender` FOREIGN KEY (`sender_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `fk_notification_target` FOREIGN KEY (`target_user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Publication` ADD CONSTRAINT `fk_publication_user` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `fk_user_role` FOREIGN KEY (`role_id`) REFERENCES `Role`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User_skill` ADD CONSTRAINT `fk_uc_competence` FOREIGN KEY (`skill_id`) REFERENCES `Skill`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User_skill` ADD CONSTRAINT `fk_uc_user` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
