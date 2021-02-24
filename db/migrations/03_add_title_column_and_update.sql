ALTER TABLE bookmarks ADD title varchar(60);
UPDATE bookmarks SET title  = 'Jeeves' WHERE url = 'http://www.askjeeves.com';
UPDATE bookmarks SET title  = 'Makers' WHERE url = 'http://www.makersacademy.com';
UPDATE bookmarks SET title  = 'Google' WHERE url = 'http://www.google.com';
