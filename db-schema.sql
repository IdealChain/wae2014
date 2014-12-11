-- Setup wae07_* tables
-- (don't drop any tables from other groups)

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `wae07_users`;
DROP TABLE IF EXISTS `wae07_pages`;

CREATE TABLE `wae07_users` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `username` varchar(32) NOT NULL UNIQUE KEY,
  `password_hash` varchar(255) NOT NULL,
  `password_salt` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `wae07_pages` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `title` TINYTEXT NOT NULL,
  `content` TEXT NOT NULL,
  `author_user_id` int NULL,
  CONSTRAINT FOREIGN KEY (`parent_id`)
    REFERENCES `wae07_pages` (`id`)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT FOREIGN KEY (`author_user_id`)
    REFERENCES `wae07_users` (`id`)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
