USE soundstream_db;

CREATE USER IF NOT EXISTS 'sound_admin'@'%' IDENTIFIED BY 'SoundAdmin123!';
CREATE USER IF NOT EXISTS 'sound_analytics'@'%' IDENTIFIED BY 'SoundAnalytics123!';
CREATE USER IF NOT EXISTS 'sound_readonly'@'%' IDENTIFIED BY 'SoundReadonly123!';

GRANT ALL PRIVILEGES ON soundstream_db.* TO 'sound_admin'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON soundstream_db.* TO 'sound_analytics'@'%';
GRANT SELECT ON soundstream_db.* TO 'sound_readonly'@'%';
FLUSH PRIVILEGES;
