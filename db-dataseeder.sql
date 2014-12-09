-- Setup wae07_* test data
-- (don't modify the schema)

INSERT INTO `wae07_pages` (`id`, `parent_id`, `title`, `content`)
VALUES
  (1, NULL, 'Welcome', 'Hi there!'),
  (2, 1, 'Subpage', 'Hi there! This page has a parent.');
