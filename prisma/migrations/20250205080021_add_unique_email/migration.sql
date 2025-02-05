-- CreateTable
CREATE TABLE `gruppetimer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `PersonligTrener_id` INTEGER NOT NULL,
    `time_navn` TEXT NULL,
    `time_dato` DATE NULL,
    `max_antall_medlemmer` INTEGER NULL,
    `antall_påmeldte` INTEGER NULL,
    `beskrivelse` TEXT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_Gruppetimer_PersonligTrener1_idx`(`PersonligTrener_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `medlemmer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fornavn` VARCHAR(255) NOT NULL,
    `etternavn` VARCHAR(255) NULL,
    `email` VARCHAR(255) NOT NULL,
    `telefonnummer` VARCHAR(8) NULL,
    `fødselsdato` DATE NULL,
    `medlemskap_type` ENUM('Basic', 'Mid', 'Pro', 'Athlete') NOT NULL,
    `registrerings_dato` DATE NULL,
    `aktiv` TINYINT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    UNIQUE INDEX `medlemmer_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `personlig_trener` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fornavn` VARCHAR(255) NULL,
    `etternavn` VARCHAR(255) NULL,
    `email` VARCHAR(255) NULL,
    `telefonnummer` VARCHAR(8) NULL,
    `spesialiseringer` VARCHAR(255) NULL,
    `erfaring_år` INTEGER NULL,
    `aktiv` TINYINT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pt_vurderinger` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `Medlemmer_id` INTEGER NOT NULL,
    `PersonligTrener_id` INTEGER NOT NULL,
    `vurdering` INTEGER NULL,
    `anmeldelse` TEXT NULL,
    `anmeldelse_dato` DATETIME(0) NULL,
    `Treningstimer_id` INTEGER NOT NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_PT_Vurderinger_Medlemmer1_idx`(`Medlemmer_id`),
    INDEX `fk_PT_Vurderinger_PersonligTrener1_idx`(`PersonligTrener_id`),
    INDEX `fk_PT_Vurderinger_Treningstimer1_idx`(`Treningstimer_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `påmeldte_gruppetimer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `Medlemmer_id` INTEGER NOT NULL,
    `Gruppetimer_id` INTEGER NOT NULL,
    `påmeldings_dato` DATE NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_Påmeldte_Gruppetimer_Gruppetimer1_idx`(`Gruppetimer_id`),
    INDEX `fk_Påmeldte_Gruppetimer_Medlemmer1_idx`(`Medlemmer_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `treningstimer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `Medlemmer_id` INTEGER NOT NULL,
    `PersonligTrener_id` INTEGER NOT NULL,
    `treningstime_dato` DATE NULL,
    `varighet_minutter` INTEGER NULL,
    `notater` TEXT NULL,
    `status` ENUM('Planlagt', 'Fullført', 'Avbrutt') NULL,

    INDEX `fk_Treningstimer_Medlemmer_idx`(`Medlemmer_id`),
    INDEX `fk_Treningstimer_PersonligTrener1_idx`(`PersonligTrener_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `gruppetimer` ADD CONSTRAINT `fk_Gruppetimer_PersonligTrener1` FOREIGN KEY (`PersonligTrener_id`) REFERENCES `personlig_trener`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pt_vurderinger` ADD CONSTRAINT `fk_PT_Vurderinger_Medlemmer1` FOREIGN KEY (`Medlemmer_id`) REFERENCES `medlemmer`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pt_vurderinger` ADD CONSTRAINT `fk_PT_Vurderinger_PersonligTrener1` FOREIGN KEY (`PersonligTrener_id`) REFERENCES `personlig_trener`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pt_vurderinger` ADD CONSTRAINT `fk_PT_Vurderinger_Treningstimer1` FOREIGN KEY (`Treningstimer_id`) REFERENCES `treningstimer`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `påmeldte_gruppetimer` ADD CONSTRAINT `fk_Påmeldte_Gruppetimer_Gruppetimer1` FOREIGN KEY (`Gruppetimer_id`) REFERENCES `gruppetimer`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `påmeldte_gruppetimer` ADD CONSTRAINT `fk_Påmeldte_Gruppetimer_Medlemmer1` FOREIGN KEY (`Medlemmer_id`) REFERENCES `medlemmer`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `treningstimer` ADD CONSTRAINT `fk_Treningstimer_Medlemmer` FOREIGN KEY (`Medlemmer_id`) REFERENCES `medlemmer`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `treningstimer` ADD CONSTRAINT `fk_Treningstimer_PersonligTrener1` FOREIGN KEY (`PersonligTrener_id`) REFERENCES `personlig_trener`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
