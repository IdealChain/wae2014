-- Setup wae07_* test data
-- (don't modify the schema)

INSERT INTO `wae07_pages` (`id`, `parent_id`, `title`, `content`)
VALUES
  (1, NULL, 'Welcome', '<p>Hi there!</p>
   
   <p>
   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean et sem odio. Proin tincidunt
   mattis vestibulum. Pellentesque tincidunt lectus nunc, eget eleifend lorem iaculis et. Donec
   mauris erat, malesuada ac enim ac, pharetra cursus dui. Ut iaculis fringilla nulla. Fusce
   lobortis massa id odio semper vulputate. Praesent vehicula rhoncus nibh sed ornare. Integer
   at nibh quis augue iaculis tristique id ac lacus. Donec eu ipsum ex. Phasellus sed dignissim
   risus.
   </p>
   <p>
   Proin sit amet euismod leo. Morbi iaculis odio ut convallis dignissim. Aenean lacinia tortor
   vitae leo varius, in rutrum magna gravida. Integer porttitor neque posuere, facilisis nibh
   vitae, posuere mi. Mauris luctus dolor erat, non scelerisque nisi facilisis quis. Nunc suscipit,
   felis ut suscipit hendrerit, ligula purus maximus nisi, eget porttitor nisl orci sed ipsum.
   Suspendisse lorem est, pharetra ut tristique ac, feugiat ac lacus. Pellentesque hendrerit turpis
   metus, et interdum ligula tempor in. Maecenas cursus sollicitudin enim, vel pellentesque neque
   elementum sed.
   </p>
   <p>
   Aenean ut nunc a leo tempus ultrices sit amet at orci. In iaculis lacus at aliquet pharetra. Lorem
   ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel cursus nibh. Suspendisse dignissim
   nec libero ac eleifend. Vivamus sem quam, venenatis a ante eu, rutrum fringilla ipsum. Pellentesque
   eleifend orci ac urna bibendum, quis sollicitudin nisl tincidunt. Sed ipsum nibh, mattis quis ante
   ut, dignissim congue dolor. Integer enim arcu, tincidunt vel suscipit ac, pulvinar aliquet arcu.
   Aenean sit amet turpis enim. Suspendisse sollicitudin tincidunt arcu, a luctus quam tincidunt at.
   Curabitur venenatis nunc ante, vitae posuere nulla pulvinar a. Curabitur ligula nibh,
   rutrum et dolor vel, accumsan molestie massa.
   </p>
   <p>
   Phasellus dictum lorem suscipit augue congue pellentesque ac ac turpis. Quisque venenatis nisl vel
   lacus sollicitudin maximus. Donec consequat, risus at iaculis dapibus, arcu velit elementum felis,
   tincidunt egestas risus turpis ut mauris. Vivamus posuere posuere rutrum. Suspendisse scelerisque
   sit amet velit vel ullamcorper. Curabitur mollis neque augue, a pharetra nulla tincidunt quis.
   Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec quis enim quis nulla ullamcorper
   sodales. Nullam vitae velit sagittis, mattis sapien quis, facilisis eros.
   </p>
   <p>
   Aenean porttitor, nunc in feugiat elementum, dui purus cursus odio, vel fringilla nunc magna in
   mauris. Ut finibus porttitor porttitor. Sed lacus diam, tincidunt ac sem ut, aliquam consequat
   est. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.
   Praesent in urna ultricies, mollis sem non, cursus mi. Vivamus efficitur neque ut arcu hendrerit,
   in tincidunt risus consectetur. In felis nisi, laoreet quis dolor tincidunt, dictum eleifend urna.
   In lobortis dapibus rutrum. Sed vitae facilisis justo.
   </p>
   '),
    (2, 1, 'Subpage', 'Hi there! This page has a parent.'),
    (3, 1, 'Subpage2', 'Hi there! This page has a parent.'),
    (4, 1, 'Subpage3', 'Hi there! This page has a parent.'),
  (5, NULL, 'test', 'test.'),
  (6, NULL, 'test2', 'test2.'),
  (7, NULL, 'test3', 'test3.'),
    (8, 7, 'test3-1', 'test3-1.'),
      (9, 8, 'test3-1-1', 'test3-1-1.'),
      (10, 8, 'test3-1-2', 'test3-1-2.');
