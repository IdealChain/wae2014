-- Setup wae07_* test data
-- (don't modify the schema)

INSERT INTO `wae07_pages` (`id`, `parent_id`, `title`, `content`)
VALUES
  (1, NULL, 'Welcome', 'Hi there!'),
    (2, 1, 'Subpage', 'Hi there! This page has a parent.'),
    (3, 1, 'Subpage2', 'Hi there! This page has a parent.'),
    (4, 1, 'Subpage3', 'Hi there! This page has a parent.'),
  (5, NULL, 'test', 'test.'),
  (6, NULL, 'test2', 'test2.'),
  (7, NULL, 'test3', 'test3.'),
    (8, 7, 'test3-1', 'test3-1.'),
      (9, 8, 'test3-1-1', 'test3-1-1.'),
      (10, 8, 'test3-1-2', 'test3-1-2.');
