CREATE table if not exists Artist (
    id serial primary key,
    artist_name varchar(100) not null
);
 
CREATE table if not exists Album (
    id serial primary key,
    album_name varchar(100) not null,
    release_date integer not null
);

CREATE table if not exists Track (
    id serial primary key,
    track_name varchar(100) not null,
    track_duration time not null,
    album_id integer references Album(id)
);

CREATE table if not exists Genre (
    id serial primary key,
    genre_name varchar(100) not null
);

CREATE table if not exists Сollection (
    id serial primary key,
    collection_name varchar(100) not null,
    release_date integer not null
);  

CREATE table if not exists GenreArtist (
    id serial primary key,
    artist_id integer references Artist(id),
    genre_id integer references Genre(id)
);

CREATE table if not exists ArtistAlbum (
    id serial primary key,
    artist_id integer references Artist(id),
    album_id integer references Album(id)
);
   
CREATE table if not exists CollectionTrack (
    id serial primary key,
    collection_id integer references Сollection(id),
    track_id integer references Track(id)
);

CREATE table if not exists CollectionArtist (
    id serial primary key,
	collection_id integer references Сollection(id),
	artist_id integer references Artist(id)
);