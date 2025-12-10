USE soundstream_db;

-- Países
INSERT INTO countries (name, iso_code, created_by) VALUES
('México','MX','seed'),
('Argentina','AR','seed'),
('Colombia','CO','seed'),
('Chile','CL','seed'),
('Perú','PE','seed');

-- Planes
INSERT INTO subscription_plans (name, plan_type, monthly_price, max_family_members, created_by) VALUES
('Free', 'free', 0.00, NULL, 'seed'),
('Premium Individual', 'premium', 129.00, NULL, 'seed'),
('Familiar', 'family', 199.00, 6, 'seed'),
('Estudiantil', 'student', 69.00, NULL, 'seed');

-- Usuarios
INSERT INTO users (full_name, email, birth_date, country_id, created_by) VALUES
('Víctor Becerra', 'victor@example.com', '2004-05-10', 1, 'seed'),
('Ana López', 'ana@example.com', '1998-03-21', 1, 'seed'),
('Carlos Ruiz', 'carlos@example.com', '1995-07-11', 2, 'seed'),
('María Gómez', 'maria@example.com', '2000-01-30', 3, 'seed'),
('Luis Torres', 'luis@example.com', '1988-09-14', 4, 'seed');

-- Suscripciones
INSERT INTO subscriptions (user_id, plan_id, is_primary_account, start_date, end_date, status, created_by) VALUES
(1, 2, 1, '2025-01-01 10:00:00', NULL, 'active', 'seed'),
(2, 1, 1, '2025-01-05 08:00:00', NULL, 'active', 'seed'),
(3, 4, 1, '2025-01-10 09:00:00', NULL, 'active', 'seed'),
(4, 3, 1, '2025-01-15 12:00:00', NULL, 'active', 'seed'),
(5, 2, 1, '2025-01-20 18:00:00', NULL, 'active', 'seed');

-- Pagos
INSERT INTO subscription_payments (subscription_id, payment_date, amount, currency, external_reference, created_by) VALUES
(1, '2025-01-01 10:05:00', 129.00, 'MXN', 'PAY-AAA-001', 'seed'),
(3, '2025-01-10 09:05:00', 69.00, 'MXN', 'PAY-BBB-001', 'seed'),
(4, '2025-01-15 12:05:00', 199.00, 'MXN', 'PAY-CCC-001', 'seed'),
(5, '2025-01-20 18:05:00', 129.00, 'MXN', 'PAY-DDD-001', 'seed');

-- Géneros
INSERT INTO genres (name, normalized_name, created_by) VALUES
('Rock', 'rock', 'seed'),
('Pop', 'pop', 'seed'),
('Reggaeton', 'reggaeton', 'seed'),
('Indie', 'indie', 'seed'),
('Electronica', 'electronica', 'seed');

-- Artistas
INSERT INTO artists (name, is_independent, country_id, main_genre_id, created_by) VALUES
('Banda Rock MX', 0, 1, 1, 'seed'),
('Cantante Pop AR', 0, 2, 2, 'seed'),
('DJ Electronico CO', 1, 3, 5, 'seed'),
('Solista Indie CL', 1, 4, 4, 'seed'),
('Artista Urbano PE', 0, 5, 3, 'seed');

-- Álbumes
INSERT INTO albums (artist_id, title, release_date, genre_id, cover_url, created_by) VALUES
(1, 'Rock en Vivo', '2024-11-01', 1, 'https://example.com/rockenvivo.jpg', 'seed'),
(2, 'Pop Hits 2024', '2024-10-15', 2, 'https://example.com/pophits.jpg', 'seed'),
(3, 'Electronica Nights', '2024-09-20', 5, 'https://example.com/electro.jpg', 'seed'),
(4, 'Indie Dreams', '2024-08-10', 4, 'https://example.com/indie.jpg', 'seed'),
(5, 'Reggaeton Fire', '2024-07-05', 3, 'https://example.com/reggaeton.jpg', 'seed');

-- Canciones (duración entre 30 y 1800 segundos)
INSERT INTO songs (album_id, main_artist_id, genre_id, title, duration_seconds, track_number, is_public, created_by) VALUES
(1, 1, 1, 'Riff Inicial', 210, 1, 1, 'seed'),
(1, 1, 1, 'Solo de Medianoche', 245, 2, 1, 'seed'),
(2, 2, 2, 'Pop Sunrise', 200, 1, 1, 'seed'),
(3, 3, 5, 'Beat Intenso', 320, 1, 1, 'seed'),
(5, 5, 3, 'Party All Night', 230, 1, 1, 'seed');

-- Playlists
INSERT INTO playlists (user_id, name, description, is_public, created_by) VALUES
(1, 'Gym Power', 'Playlist para entrenar', 1, 'seed'),
(1, 'Chill Noches', 'Música tranquila de noche', 0, 'seed'),
(2, 'Pop Favs', 'Pop favorito', 1, 'seed'),
(3, 'Electronica Top', 'Beats electrónicos', 1, 'seed'),
(4, 'Indie Mood', 'Indie para concentrarse', 0, 'seed');

-- Canciones en playlists
INSERT INTO playlist_songs (playlist_id, song_id, position, created_by) VALUES
(1, 1, 1, 'seed'),
(1, 4, 2, 'seed'),
(2, 2, 1, 'seed'),
(3, 3, 1, 'seed'),
(4, 2, 1, 'seed');

-- Logs de escuchas coherentes
INSERT INTO listening_logs (user_id, song_id, played_at, seconds_played, device, source, created_by) VALUES
(1, 1, '2025-01-25 10:00:00', 210, 'mobile', 'playlist:Gym Power', 'seed'),
(1, 4, '2025-01-25 10:05:00', 320, 'mobile', 'playlist:Gym Power', 'seed'),
(2, 3, '2025-01-25 09:00:00', 200, 'desktop', 'playlist:Pop Favs', 'seed'),
(3, 4, '2025-01-24 22:00:00', 300, 'tablet', 'playlist:Electronica Top', 'seed'),
(4, 2, '2025-01-23 21:30:00', 245, 'mobile', 'playlist:Indie Mood', 'seed');
