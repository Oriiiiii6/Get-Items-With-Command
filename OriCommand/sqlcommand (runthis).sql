CREATE TABLE IF NOT EXISTS `used_commands` (
    `identifier` VARCHAR(50) PRIMARY KEY,
    `has_used` BOOLEAN NOT NULL DEFAULT false
);
