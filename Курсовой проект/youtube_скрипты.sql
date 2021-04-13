
----------------------------------------- Создание таблиц ------------------------------------------------------------------------------

DROP TABLE IF EXISTS channels;
CREATE TABLE channels (
  id SERIAL COMMENT 'Идентификатор строки',
  name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Имя канала',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id, name)
)  COMMENT='Каналы'
;

DROP TABLE IF EXISTS profile_channel;
CREATE TABLE profile_channel (
  channel_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на канал',
  picture_id int unsigned COMMENT  'Ссылка на фото канала',
  country VARCHAR(100) COMMENT 'Страна',
  email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Электронная почта',
  links VARCHAR(255) COMMENT 'Ссылки на соцсети',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
)  COMMENT='Профили каналов'
;
DROP TABLE IF EXISTS profile_channels;

DROP TABLE IF EXISTS videos;
CREATE TABLE videos (
  id SERIAL PRIMARY KEY COMMENT 'Идентификатор строки',
  channel_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на канал',
  name VARCHAR(100) NOT NULL COMMENT 'Название видео',
  size INT NOT NULL COMMENT 'Размер файла',
  metadata JSON COMMENT 'Метаданные файла',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT='Видео'
;

DROP TABLE IF EXISTS subscribers;
CREATE TABLE subscribers (
  channel_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на канал',
  subscriber_id INT UNSIGNED COMMENT 'Канал подписчика',
  subscription_start_time DATETIME DEFAULT NOW() COMMENT 'Время начала подписки',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT='Подписчики'
;

DROP TABLE IF EXISTS playlists;
CREATE TABLE playlists (
  id SERIAL PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(100) NOT NULL COMMENT 'Имя плейлиста',
  channel_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на канал',
  video_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на видео',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT='Плейлисты'
;

DROP TABLE IF EXISTS pictures;
CREATE TABLE pictures (
  id SERIAL PRIMARY KEY COMMENT 'Идентификатор строки',
  channel_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на канал',
  filename VARCHAR(255) NOT NULL COMMENT 'Путь к файлу',
  size INT NOT NULL COMMENT 'Размер файла',
  metadata JSON COMMENT 'Метаданные файла',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT='Изображения'
;

DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  channel_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на канал',
  head VARCHAR(255) COMMENT 'Заголовок поста',
  body TEXT NOT NULL COMMENT 'Текст поста',
  video_id INT UNSIGNED COMMENT 'Ссылка на видео',
  picture_id INT UNSIGNED COMMENT 'Ссылка на изображение',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT='Посты'
;

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  channel_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на канал',
  target_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на объект',
  target_type_id INT UNSIGNED NOT NULL COMMENT 'Идентификатор типа объекта',
  body TEXT NOT NULL COMMENT 'Текст комментария',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT='Комментарии'
;

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  channel_id INT UNSIGNED NOT NULL COMMENT 'Идентификатор канала',
  target_id INT UNSIGNED NOT NULL COMMENT 'Идентификатор объекта',
  target_type_id INT UNSIGNED NOT NULL COMMENT 'Идентификатор типа объекта',
  like_type_id TINYINT UNSIGNED NOT NULL COMMENT 'Идентификатор типа лайка',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Лайки';

DROP TABLE IF EXISTS like_types;
CREATE TABLE like_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(255) NOT NULL UNIQUE COMMENT 'Тип лайка',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Типы лайков';

INSERT INTO like_types (name) VALUES 
  ('like'),
  ('dislike');
 
DROP TABLE IF EXISTS comment_target_types;
CREATE TABLE comment_target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(255) NOT NULL UNIQUE COMMENT 'Название типа',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Типы объектов комментирования';

INSERT INTO comment_target_types (name) VALUES 
  ('video'),
  ('post');
  
DROP TABLE IF EXISTS like_target_types;
CREATE TABLE like_target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки',
  name VARCHAR(255) NOT NULL UNIQUE COMMENT 'Название типа',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки'
) COMMENT 'Типы объектов для лайков';

INSERT INTO like_target_types (name) VALUES 
  ('video'),
  ('comment'),
  ('post');

ALTER TABLE profile_channel 
    ADD name VARCHAR(100) NOT NULL COMMENT 'Имя канала' AFTER channel_id;

SELECT * FROM profile_channel;

UPDATE profile_channel p
  SET
  p.name = (SELECT c.name FROM channels c WHERE c.id = p.channel_id);

SELECT FLOOR(RAND()*(1000-1+1)+1);
 
UPDATE comments co
  SET
  co.target_id = (SELECT FLOOR(RAND()*(1000-1+1)+1));
 
UPDATE  likes l
  SET
  l.target_id = (SELECT FLOOR(RAND()*(1000-1+1)+1));
 
UPDATE pictures pic
  SET
  pic.`size` =  (SELECT FLOOR(RAND()*(10000000-1+500)+500));
 
UPDATE videos v
  SET
  v.`size` = (SELECT FLOOR(RAND()*(1000000000-1+5000000)+5000000));

SELECT id FROM channels c ORDER BY RAND() LIMIT 1;

UPDATE subscribers sb
  SET
  sb.subscriber_id = (SELECT c.id FROM channels c WHERE c.id != sb.subscriber_id ORDER BY RAND() LIMIT 1);
 

-------------------------------------------- Внешние ключи -----------------------------------------------------------------------------

-- Добавляем внешние ключи и меняем типы данных по необходимости

ALTER TABLE comments 
  ADD CONSTRAINT comments_fk_target_type_id
    FOREIGN KEY (target_type_id) REFERENCES comment_target_types(id),
  change channel_id channel_id BIGINT UNSIGNED NOT NULL,
  ADD CONSTRAINT comments_fk_channel_id
    FOREIGN KEY (channel_id) REFERENCES channels(id);

   
ALTER TABLE likes 
  ADD CONSTRAINT likes_fk_target_type_id
    FOREIGN KEY (target_type_id) REFERENCES like_target_types(id),
  change like_type_id like_type_id INT UNSIGNED NOT NULL,
  ADD CONSTRAINT likes_fk_like_type_id
    FOREIGN KEY (like_type_id) REFERENCES like_types(id),
  change channel_id channel_id BIGINT UNSIGNED NOT NULL,
  ADD CONSTRAINT likes_fk_channel_id
    FOREIGN KEY (channel_id) REFERENCES channels(id); 
  
   
ALTER TABLE pictures 
  change channel_id channel_id BIGINT UNSIGNED NOT NULL,
  ADD CONSTRAINT pictures_fk_channel_id
    FOREIGN KEY (channel_id) REFERENCES channels(id) 
      ON DELETE CASCADE
      ON UPDATE CASCADE;  
 
 
ALTER TABLE playlists 
  change channel_id channel_id BIGINT UNSIGNED NOT NULL,
  ADD CONSTRAINT playlists_fk_channel_id
    FOREIGN KEY (channel_id) REFERENCES channels(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  change video_id video_id BIGINT UNSIGNED,
  ADD CONSTRAINT playlists_fk_video_id
    FOREIGN KEY (video_id) REFERENCES videos(id)
      ON DELETE SET NULL
      ON UPDATE CASCADE;
  
ALTER TABLE posts 
  change channel_id channel_id BIGINT UNSIGNED NOT NULL,
  ADD CONSTRAINT posts_fk_channel_id
    FOREIGN KEY (channel_id) REFERENCES channels(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  change video_id video_id BIGINT UNSIGNED,
  ADD CONSTRAINT posts_fk_video_id
    FOREIGN KEY (video_id) REFERENCES videos(id)
      ON DELETE SET NULL
      ON UPDATE CASCADE,
  change picture_id picture_id BIGINT UNSIGNED,
  ADD CONSTRAINT posts_fk_picture_id
    FOREIGN KEY (picture_id) REFERENCES pictures(id)
      ON DELETE SET NULL
      ON UPDATE CASCADE;
   
ALTER TABLE subscribers 
  change channel_id channel_id BIGINT UNSIGNED NOT NULL,
  ADD CONSTRAINT subscribers_fk_channel_id
    FOREIGN KEY (channel_id) REFERENCES channels(id),
  change subscriber_id subscriber_id BIGINT UNSIGNED NOT NULL,
  ADD CONSTRAINT subscribers_fk_subscriber_id
    FOREIGN KEY (subscriber_id) REFERENCES channels(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE;
   
ALTER TABLE videos 
  change channel_id channel_id BIGINT UNSIGNED NOT NULL,
  ADD CONSTRAINT videos_fk_channel_id
    FOREIGN KEY (channel_id) REFERENCES channels(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE; 
   
ALTER TABLE profile_channel 
  change channel_id channel_id BIGINT UNSIGNED NOT NULL,
  ADD CONSTRAINT profile_fk_channel_channel_id
    FOREIGN KEY (channel_id) REFERENCES channels(id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  change picture_id picture_id BIGINT UNSIGNED,
  ADD CONSTRAINT profile_fk_channel_picture_id
    FOREIGN KEY (picture_id) REFERENCES pictures(id)
      ON UPDATE CASCADE,
  ADD CONSTRAINT profile_fk_channel_name
    FOREIGN KEY (name) REFERENCES channels(name)
      ON UPDATE CASCADE;
 
  
 
--------------------------------------------------------- Добавление лайков --------------------------------------------------------------

 -- Лайки видеозаписям
INSERT INTO likes (channel_id, target_id , target_type_id , like_type_id) 
  SELECT
    (SELECT id FROM channels ORDER BY rand() LIMIT 1),
    (SELECT id FROM videos ORDER BY rand() LIMIT 1),
    (SELECT id FROM like_target_types WHERE name = 'video'),
    (SELECT id FROM like_types ORDER BY rand() LIMIT 1)
  FROM comments
LIMIT 50;

-- Лайки комментариям
INSERT INTO likes (channel_id, target_id, target_type_id , like_type_id) 
  SELECT
    (SELECT id FROM channels ORDER BY rand() LIMIT 1),
    (SELECT id FROM comments ORDER BY rand() LIMIT 1),
    (SELECT id FROM like_target_types WHERE name = 'comment'),
    (SELECT id FROM like_types ORDER BY rand() LIMIT 1)
  FROM comments
LIMIT 20;

-- Лайки постам
INSERT INTO likes (channel_id, target_id, target_type_id , like_type_id) 
  SELECT
    (SELECT id FROM channels ORDER BY rand() LIMIT 1),
    (SELECT id FROM posts ORDER BY rand() LIMIT 1),
    (SELECT id FROM like_target_types WHERE name = 'post'),
    (SELECT id FROM like_types ORDER BY rand() LIMIT 1)
  FROM comments
LIMIT 20;

------------------------------------------------------------- Функции -------------------------------------------------------------------

-- Создадим функцию для проверки существования строки
-- с идентификатором target_id в соответствующей таблице

DROP FUNCTION IF EXISTS row_exists;
DELIMITER //

CREATE FUNCTION row_exists(target_id INT, target_type_id INT)
RETURNS BOOLEAN READS SQL DATA
BEGIN
  DECLARE table_name VARCHAR(50);
  SELECT name INTO table_name FROM like_target_types ltt WHERE id = target_type_id;
  CASE table_name
    WHEN 'video' THEN
      RETURN EXISTS(SELECT 1 FROM videos WHERE id = target_id);
    WHEN 'comment' THEN 
      RETURN EXISTS(SELECT 1 FROM comments WHERE id = target_id);
    WHEN 'post' THEN
      RETURN EXISTS(SELECT 1 FROM posts WHERE id = target_id);
    ELSE 
      RETURN FALSE;
  END CASE;
END//

DELIMITER ;

-- Проверим работу функции
SELECT * FROM like_target_types;
SELECT * FROM videos;
SELECT * FROM comments;
SELECT * FROM posts;

SELECT row_exists(1, 1);    -- Видео с id=1
SELECT row_exists(500, 2);  -- Коммент с id=500
SELECT row_exists(1000, 3);  -- Пост id=1000
SELECT row_exists(1001, 3);  -- Пост id=1001
SELECT row_exists(2, 4);    -- Отсутствует target_type с id=4  


-------------------------------------------------- Триггеры ------------------------------------------------------------------------------

-- Создадим триггер для проверки валидности target_id и target_type_id в таблице likes при вставке новых значений
DROP TRIGGER IF EXISTS likes_validation_insert;
DELIMITER //

CREATE TRIGGER likes_validation_insert BEFORE INSERT ON likes FOR EACH ROW
BEGIN
  IF !row_exists(NEW.target_id, NEW.target_type_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding like! Target table doesn't contain row id provided!";
  END IF;
END//

SHOW triggers;

-- Проверим работу триггера
INSERT INTO likes (channel_id, target_id, target_type_id, like_type_id) VALUES (50, 50, 2, 1);
INSERT INTO likes (channel_id, target_id, target_type_id, like_type_id) VALUES (35, 50, 4, 1);
INSERT INTO likes (channel_id, target_id, target_type_id, like_type_id) VALUES (35, 1001, 1, 1);


-- Создадим триггер для проверки валидности target_id и target_type_id при обновлении значений в таблице likes 
DROP TRIGGER IF EXISTS likes_validation_update;
DELIMITER //

CREATE TRIGGER likes_validation_update BEFORE UPDATE ON likes FOR EACH ROW
BEGIN
  IF !row_exists(NEW.target_id, NEW.target_type_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding like! Target table doesn't contain row id provided!";
  END IF;
END//

SHOW triggers;

-- Проверим работу триггера
SELECT * FROM likes WHERE target_id = 315 AND channel_id = 1;
UPDATE likes SET target_id = 500 WHERE target_id = 315 AND channel_id = 1;
SELECT * FROM likes WHERE target_id = 500 AND channel_id = 1;
UPDATE likes SET target_id = 1001 WHERE target_id = 500 AND channel_id = 1;
UPDATE likes SET target_type_id = 4 WHERE target_id = 500 AND channel_id = 1;


-- Создадим триггер для проверки валидности target_id и target_type_id в таблице comments при вставке новых значений
DROP TRIGGER IF EXISTS comments_validation_insert;
DELIMITER //

CREATE TRIGGER comments_validation_insert BEFORE INSERT ON comments FOR EACH ROW
BEGIN
  IF !row_exists(NEW.target_id, NEW.target_type_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding comment! Target table doesn't contain row id provided!";
  END IF;
END//

SHOW triggers;

-- Проверим работу триггера
INSERT INTO comments (channel_id , target_id , target_type_id, body) VALUES (35, 50, 2, 'Круто');
SELECT * FROM comments WHERE channel_id = 35;
INSERT INTO comments (channel_id, target_id, target_type_id, body) VALUES (35, 50, 4, 'Некруто');
INSERT INTO comments (channel_id, target_id, target_type_id, body) VALUES (35, 1001, 1, 'Бла-бла-бла');


-- Создадим триггер для проверки валидности target_id и target_type_id при обновлении значений в таблице comments 
DROP TRIGGER IF EXISTS comments_validation_update;
DELIMITER //

CREATE TRIGGER comments_validation_update BEFORE UPDATE ON comments FOR EACH ROW
BEGIN
  IF !row_exists(NEW.target_id, NEW.target_type_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding like! Target table doesn't contain row id provided!";
  END IF;
END//

SHOW triggers;

-- Проверим работу триггера
SELECT * FROM comments WHERE target_id = 484 AND channel_id = 1;
UPDATE comments SET target_id = 500 WHERE target_id = 484 AND channel_id = 1;
SELECT * FROM comments WHERE target_id = 500 AND channel_id = 1;
UPDATE comments SET target_id = 1001 WHERE target_id = 500 AND channel_id = 1;
UPDATE comments SET target_type_id = 3 WHERE target_id = 500 AND channel_id = 1;


-- Просмотр функций и процедур
SHOW FUNCTION STATUS LIKE '%';
SHOW FUNCTION STATUS LIKE 'row_exists';
SHOW CREATE FUNCTION row_exists;

SHOW PROCEDURE STATUS LIKE '%';
SHOW CREATE PROCEDURE sys.ps_truncate_all_tables;

--------------------------------------------------- ИНДЕКСЫ ---------------------------------------------------------------------------

-- Создадим индекс на таблице videos(name) и проверим план запроса
CREATE INDEX videos_name_idx ON videos(name);
EXPLAIN ANALYZE
SELECT * FROM videos WHERE name = 'Quisquam a molestiae odit ut.';


-- Создадим индекс на таблице playlists(name) и проверим план запроса
CREATE INDEX playlists_name_idx ON playlists(name);
EXPLAIN ANALYZE
SELECT * FROM playlists WHERE name = 'Sunt repellat quae facilis.';

-- Создадим индекс на таблице posts(head) и проверим план запроса
CREATE INDEX posts_head_idx ON posts(head);
EXPLAIN ANALYZE
SELECT * FROM posts WHERE head = 'Quis beatae tempora eos qui.';


-- Создадим индекс на таблице profile_channel(name) и проверим план запроса
CREATE INDEX profile_channel_name_idx ON profile_channel(name);
EXPLAIN ANALYZE
SELECT * FROM profile_channel WHERE name = 'ex';

-- Создадим индекс на таблице likes(target_id) и проверим план запроса
CREATE INDEX likes_target_id_idx ON likes(target_id);
EXPLAIN ANALYZE
SELECT * FROM likes WHERE target_id = 3;

-- Создадим индекс на таблице comments(target_id) и проверим план запроса
CREATE INDEX comments_target_id_idx ON comments(target_id);
EXPLAIN ANALYZE
SELECT * FROM likes WHERE target_id = 3;

-- Создадим уникальный индекс на таблице like_target_types(name)
-- -
SELECT * FROM like_target_types;
DROP INDEX like_target_types_name_idx ON like_target_types;
CREATE UNIQUE INDEX like_target_types_name_idx ON like_target_types(name);
INSERT INTO like_target_types (id, name) VALUES
(4, 'video');

-- Создадим уникальный индекс на таблице comment_target_types(name)
-- -
SELECT * FROM comment_target_types;
DROP INDEX comment_target_types_name_idx ON comment_target_types;
CREATE UNIQUE INDEX comment_target_types_name_idx ON comment_target_types(name);
INSERT INTO comment_target_types (id, name) VALUES
(3, 'post');

-- Создадим уникальный составной индекс на таблице likes(channel_id, target_id, target_type_id)
ALTER TABLE likes DROP INDEX likes_ch_t_tt_idx;
CREATE UNIQUE INDEX likes_ch_t_tt_idx ON likes(channel_id, target_id, target_type_id);
-- Проверка работы уникальности индекса
-- Повторная вставка таких же значений вызовет ошибку
INSERT INTO likes (channel_id, target_id, target_type_id, like_type_id) VALUES (1, 938, 2, 1);
SELECT * FROM likes l ORDER BY channel_id;

-- Создадим индекс на таблице posts(body) для поиска по текстам постов
CREATE FULLTEXT INDEX posts_body_idx ON posts(body);

-- Пользователь захочет смотреть сначала свежие видео
CREATE INDEX videos_created_at_idx ON videos(created_at);

-- Пользователь захочет смотреть сначала свежие комментарии
CREATE INDEX comments_chid_tid_crat_idx ON comments(channel_id, target_id, created_at);


--------------------------------------------------- Представления --------------------------------------------------------------------------

CREATE OR REPLACE VIEW vlikes AS
SELECT  v.name AS video, c.name AS channel ,
(SELECT COUNT(*) FROM likes l WHERE like_type_id = 1 AND target_type_id = 1 AND v.id = l.target_id) AS likes,
(SELECT COUNT(*) FROM likes l WHERE like_type_id = 2 AND target_type_id = 1 AND v.id = l.target_id) AS dislikes,
(SELECT COUNT(*) FROM comments co WHERE target_type_id = 1 AND v.id = co.target_id) AS comments
FROM channels c 
LEFT JOIN videos v ON c.id = v.channel_id
ORDER BY likes DESC;
 
SELECT * FROM vlikes;


CREATE OR REPLACE VIEW last_comments AS
SELECT c.name AS channel, pl.name AS playlist, v.name AS video, co.body AS comment, co.created_at 
FROM channels c
LEFT JOIN playlists pl ON c.id = pl.channel_id 
LEFT JOIN videos v ON pl.video_id = v.id 
LEFT JOIN comments co ON  v.id = co.target_id AND co.target_type_id = 1
ORDER BY created_at DESC; 

SELECT * FROM last_comments;

--------------------------------------------------- Запросы ------------------------------------------------------------------------------

-- 10 каналов с наибольшим количеством подписчиков
SELECT DISTINCT c.name AS channel,
(SELECT COUNT(*) FROM subscribers s WHERE c.id = s.channel_id ) AS subscribers
FROM channels c
LEFT JOIN subscribers s ON c.id = s.channel_id 
ORDER BY subscribers
LIMIT 10;

-- 10 видео с наибольшим количеством лайков
SELECT * FROM vlikes LIMIT 10;

-- 10 видео с наибольшим количеством комментариев
SELECT * FROM vlikes ORDER BY comments DESC LIMIT 10;

-- Найдём кому принадлежат 10 самых больших видеофайлов
SELECT channel_id , name , size FROM videos v ORDER BY size DESC LIMIT 10;

-- Определяем пользователей, у которых общий размер видео превышает превышает 5ГБ
SELECT channel_id , SUM(size) AS total, count(*) FROM videos v 
  GROUP BY channel_id
  HAVING total > 5000000000
  ORDER BY total DESC;
  
-- Поиск видео по шаблонам имени
 SELECT id, name FROM videos v WHERE name LIKE 'Autem%';
 
-- Поиск видео по шаблонам имени, используем регулярные выражения
SELECT id, name FROM videos v WHERE name RLIKE '^(A|B).*mi';

-- Статистика по видео
SELECT 
  (SELECT COUNT(*) FROM videos v) AS count_video, 
  AVG(v.size),
  MIN(v.size), 
  MAX(v.size), 
  SUM(v.size) 
FROM videos v;

