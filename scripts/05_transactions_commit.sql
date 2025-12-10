USE soundstream_db;

START TRANSACTION;

INSERT INTO albums (artist_id, title, release_date, genre_id, cover_url, is_published, created_by)
VALUES (1, 'Rock Lanzamiento 2025', '2025-02-01', 1, 'https://example.com/rock2025.jpg', 1, 'release_tx');

SET @new_album_id = LAST_INSERT_ID();

INSERT INTO songs (album_id, main_artist_id, genre_id, title, duration_seconds, track_number, is_public, created_by)
VALUES
(@new_album_id, 1, 1, 'Intro 2025', 120, 1, 1, 'release_tx'),
(@new_album_id, 1, 1, 'Rock 2025 - Parte I', 240, 2, 1, 'release_tx'),
(@new_album_id, 1, 1, 'Rock 2025 - Parte II', 260, 3, 1, 'release_tx');

COMMIT;
