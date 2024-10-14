--TOP 3 ARTISTS AND SONGS--
SELECT 
  DISTINCT artist,
  track
FROM most_streamed_spotify_songs_2024
ORDER BY spotify_streams DESC
LIMIT 3;

SELECT 
  track,
  spotify_streams,
  artist
FROM most_streamed_spotify_songs_2024
ORDER BY spotify_streams DESC
LIMIT 3

  
--Streaming on Spotify, Tiktok, Youtube, Shazam and Soundcloud--
SELECT 
  'spotify' as platform,
  coalesce(SUM(toInt64(spotify_streams)),0) AS total_streams
FROM most_streamed_spotify_songs_2024
WHERE spotify_streams IS NOT NULL
UNION ALL
SELECT 
  'youtube' AS platform,
  COALESCE(SUM(toInt64(youtube_views)),0) AS total_streams
FROM most_streamed_spotify_songs_2024
WHERE youtube_views IS NOT NULL
UNION ALL
SELECT 
  'tiktok' as platform,
  COALESCE(SUM(toInt64(tiktok_views)),0) AS total_streams
FROM most_streamed_spotify_songs_2024
WHERE tiktok_views IS NOT NULL
UNION ALL
SELECT 
  'soundcloud' as platform,
  COALESCE(SUM(toInt64(soundcloud_streams)),0) AS total_streams
FROM most_streamed_spotify_songs_2024
WHERE soundcloud_streams IS NOT NULL

ORDER BY 
    total_streams DESC
LIMIT 10;



--Platform-wise Streaming count--
SELECT 
    SUM(toInt32OrNull(replaceRegexpAll(spotify_streams, '[^0-9]', ''))) AS total_spotify_streams, 
    SUM(toInt32OrNull(replaceRegexpAll(youtube_views, '[^0-9]', ''))) AS total_youtube_views,
    SUM(toInt32OrNull(replaceRegexpAll(tiktok_views, '[^0-9]', ''))) AS total_tiktok_streams,
    SUM(toInt32OrNull(replaceRegexpAll(soundcloud_streams, '[^0-9]', ''))) AS total_soundcloud_streams,
    SUM(toInt32OrNull(replaceRegexpAll(shazam_counts, '[^0-9]', ''))) AS total_shazam_streams, 
    SUM(toInt32OrNull(replaceRegexpAll(pandora_streams, '[^0-9]', ''))) AS total_pandora_streams
FROM 
    most_streamed_spotify_songs_2024
WHERE 
    spotify_streams IS NOT NULL 
    AND youtube_views IS NOT NULL;



--Most-listened top 5 songs released in 2024 on Spotify--
SELECT 
      track,
      artist,
      spotify_streams,
      youtube_views,
      track_score
FROM most_streamed_spotify_songs_2024
WHERE release_date LIKE '%2024'
ORDER BY spotify_streams DESC
LIMIT 5;
