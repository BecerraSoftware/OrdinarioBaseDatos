USE soundstream_db;

-- 1) Países
CREATE TABLE countries (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  iso_code CHAR(2) NOT NULL UNIQUE,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1
);

-- 2) Usuarios de la plataforma
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  birth_date DATE NULL,
  country_id INT NOT NULL,
  signup_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_users_country FOREIGN KEY (country_id) REFERENCES countries(id)
);

-- 3) Planes de suscripción (free, premium, familiar, estudiantil)
CREATE TABLE subscription_plans (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  plan_type ENUM('free','premium','family','student') NOT NULL,
  monthly_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  max_family_members INT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1
);

-- 4) Suscripciones de usuarios a planes
CREATE TABLE subscriptions (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  plan_id INT NOT NULL,
  is_primary_account TINYINT(1) NOT NULL DEFAULT 1,
  start_date DATETIME NOT NULL,
  end_date DATETIME NULL,
  status ENUM('active','cancelled','expired','pending') NOT NULL DEFAULT 'active',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_subscriptions_user FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_subscriptions_plan FOREIGN KEY (plan_id) REFERENCES subscription_plans(id)
);

-- 5) Pagos de suscripción
CREATE TABLE subscription_payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  subscription_id INT NOT NULL,
  payment_date DATETIME NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  currency CHAR(3) NOT NULL DEFAULT 'MXN',
  external_reference VARCHAR(150) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_payments_subscription FOREIGN KEY (subscription_id) REFERENCES subscriptions(id)
);

-- 6) Géneros musicales
CREATE TABLE genres (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  normalized_name VARCHAR(100) NOT NULL,
  parent_genre_id INT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_genres_parent FOREIGN KEY (parent_genre_id) REFERENCES genres(id)
);

-- 7) Artistas
CREATE TABLE artists (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  is_independent TINYINT(1) NOT NULL DEFAULT 0,
  country_id INT NULL,
  main_genre_id INT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_artists_country FOREIGN KEY (country_id) REFERENCES countries(id),
  CONSTRAINT fk_artists_genre FOREIGN KEY (main_genre_id) REFERENCES genres(id)
);

-- 8) Álbumes
CREATE TABLE albums (
  id INT AUTO_INCREMENT PRIMARY KEY,
  artist_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  release_date DATE NULL,
  genre_id INT NULL,
  cover_url VARCHAR(255) NULL,
  is_published TINYINT(1) NOT NULL DEFAULT 1,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_albums_artist FOREIGN KEY (artist_id) REFERENCES artists(id),
  CONSTRAINT fk_albums_genre FOREIGN KEY (genre_id) REFERENCES genres(id)
);

-- 9) Canciones
CREATE TABLE songs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  album_id INT NOT NULL,
  main_artist_id INT NOT NULL,
  genre_id INT NULL,
  title VARCHAR(200) NOT NULL,
  duration_seconds INT NOT NULL,
  track_number INT NULL,
  is_explicit TINYINT(1) NOT NULL DEFAULT 0,
  is_public TINYINT(1) NOT NULL DEFAULT 1,
  original_song_id INT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT chk_song_duration CHECK (duration_seconds BETWEEN 30 AND 1800),
  CONSTRAINT fk_songs_album FOREIGN KEY (album_id) REFERENCES albums(id),
  CONSTRAINT fk_songs_artist FOREIGN KEY (main_artist_id) REFERENCES artists(id),
  CONSTRAINT fk_songs_genre FOREIGN KEY (genre_id) REFERENCES genres(id),
  CONSTRAINT fk_songs_original FOREIGN KEY (original_song_id) REFERENCES songs(id)
);

-- 10) Playlists
CREATE TABLE playlists (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  name VARCHAR(200) NOT NULL,
  description TEXT NULL,
  is_public TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_playlists_user FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 11) Canciones dentro de playlists
CREATE TABLE playlist_songs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  playlist_id INT NOT NULL,
  song_id INT NOT NULL,
  position INT NULL,
  added_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_ps_playlist FOREIGN KEY (playlist_id) REFERENCES playlists(id),
  CONSTRAINT fk_ps_song FOREIGN KEY (song_id) REFERENCES songs(id),
  CONSTRAINT uc_playlist_song UNIQUE (playlist_id, song_id)
);

-- 12) Logs de escuchas
CREATE TABLE listening_logs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  song_id INT NOT NULL,
  played_at DATETIME NOT NULL,
  seconds_played INT NOT NULL,
  device VARCHAR(100) NULL,
  source VARCHAR(100) NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by VARCHAR(100) NOT NULL DEFAULT 'system',
  updated_at DATETIME NULL,
  updated_by VARCHAR(100) NULL,
  active TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_logs_user FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_logs_song FOREIGN KEY (song_id) REFERENCES songs(id),
  CONSTRAINT chk_logs_seconds CHECK (seconds_played >= 0 AND seconds_played <= 36000),
  CONSTRAINT chk_logs_year CHECK (YEAR(played_at) BETWEEN 2000 AND 2100)
);

-- Índices básicos
CREATE INDEX idx_logs_user_song ON listening_logs(user_id, song_id, played_at);
CREATE INDEX idx_songs_title ON songs(title);
CREATE INDEX idx_playlists_user ON playlists(user_id);
CREATE INDEX idx_subscriptions_user ON subscriptions(user_id);
