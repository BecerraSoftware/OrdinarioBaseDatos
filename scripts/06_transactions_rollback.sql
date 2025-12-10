USE soundstream_db;

START TRANSACTION;

-- Canción con duración inválida que viola el CHECK (10 segundos)
INSERT INTO songs (album_id, main_artist_id, genre_id, title, duration_seconds, track_number, is_public, created_by)
VALUES
(1, 1, 1, 'Cancion Invalida Duracion 1', 10, 99, 1, 'rollback_test');

ROLLBACK;
