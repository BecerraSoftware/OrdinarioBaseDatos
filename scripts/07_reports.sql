USE soundstream_db;

-- Usuario que más minutos ha escuchado en 2025
SELECT 
  u.id,
  u.full_name,
  SUM(l.seconds_played) / 60 AS total_minutos_escuchados
FROM listening_logs l
JOIN users u ON u.id = l.user_id
WHERE YEAR(l.played_at) = 2025
GROUP BY u.id, u.full_name
ORDER BY total_minutos_escuchados DESC
LIMIT 1;

-- Detección de posibles fraudes: usuarios con más de 3000 segundos en el mismo minuto
SELECT 
  u.id,
  u.full_name,
  DATE_FORMAT(l.played_at, '%Y-%m-%d %H:%i') AS minuto,
  SUM(l.seconds_played) AS total_segundos_en_minuto
FROM listening_logs l
JOIN users u ON u.id = l.user_id
GROUP BY u.id, u.full_name, DATE_FORMAT(l.played_at, '%Y-%m-%d %H:%i')
HAVING total_segundos_en_minuto > 3000
ORDER BY total_segundos_en_minuto DESC;

-- Total recaudado por mes
SELECT 
  DATE_FORMAT(payment_date, '%Y-%m') AS mes,
  SUM(amount) AS total_recaudado,
  currency
FROM subscription_payments
GROUP BY DATE_FORMAT(payment_date, '%Y-%m'), currency
ORDER BY mes;

-- posibles playlists duplicadas por usuario
SELECT 
  u.id,
  u.full_name,
  p.name,
  COUNT(p.id) AS cantidad_con_mismo_nombre
FROM playlists p
JOIN users u ON u.id = p.user_id
GROUP BY u.id, u.full_name, p.name
ORDER BY cantidad_con_mismo_nombre DESC, u.full_name;
