--количество исполнителей в каждом жанре
  SELECT genre_id, COUNT(*) 
    FROM GenreArtist 
GROUP BY genre_id;

-- количество треков, вошедших в альбомы 2019-2020 годов
  SELECT album_id, COUNT(*) 
    FROM Album 
    JOIN Track ON Album.id = Track.album_id
   WHERE release_date BETWEEN 2019 and 2020
GROUP BY  album_id;

-- средняя продолжительность треков по каждому альбому
  SELECT album_id, AVG(track_duration) 
    FROM Album JOIN Track ON Album.id = Track.album_id
GROUP BY album_id; 

-- все исполнители, которые не выпустили альбомы в 2020 году;
SELECT artist_name, release_date
  FROM Artist JOIN ArtistAlbum 
    ON Artist.id = ArtistAlbum.artist_id
  JOIN Album
    ON ArtistAlbum.album_id = Album.id
 WHERE release_date != 2020;

-- названия сборников, в которых присутствует конкретный исполнитель (ABBA)
SELECT collection_name
  FROM Сollection JOIN CollectionArtist
    ON Collection.id = CollectionArtist.collection_id
  JOIN Artist
    ON CollectionArtist.artist_id = Artist.id
 WHERE artist_name = 'ABBA';

-- название альбомов, в которых присутствуют исполнители более 1 жанра
SELECT album_name
    FROM Album join ArtistAlbum
      ON Album.id = ArtistAlbum.album_id 
    JOIN Artist 
      ON ArtistAlbum.artist_id = Artist.id 
    JOIN GenreArtist 
      ON Artist.id = GenreArtist.artist_id 
    JOIN Genre 
      ON GenreArtist.genre_id = Genre.id 
GROUP BY album_name
  HAVING count(distinct genre_name) > 1
order by album_name;



--наименование треков, которые не входят в сборники
SELECT Track_name 
  FROM Track join CollectionTrack 
    ON Track.id = CollectionTrack.track_id 
 WHERE CollectionTrack.track_id is null;

--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)
SELECT track_name, track_duration 
  FROM Artist join ArtistAlbum
    ON Artist.id = ArtistAlbum.artist_id
  JOIN Album on ArtistAlbum.album_id = Album.id 
  JOIN Track on Album.id = Track.album_id
 WHERE track_duration = (select min(track_duration) from Track)

-- название альбомов, содержащих наименьшее количество треков
SELECT album_name 
  FROM Album 
  JOIN Track 
    ON Album.id = Track.album_id 
 WHERE Track.album_id in (
     SELECT album_id from Track 
     group by album_id
     HAVING count(id) = (
           SELECT count(id)
           FROM track 
           group by album_id order by count
           LIMIT 1
           )
     )  
