abstract Sammie = {

flags 
  startcat = Action ;

cat 
  Action; 
  ToIdentify;
  Object;
  PlaylistSet; Playlist;
  ArtistSet; Artist;
  AlbumSet; Album;
  SongSet; Song;
  Number;

  PlaylistName;
  Genre;
  ArtistName;
  AlbumName;
  SongName;

fun 

  -- Action

  add_song_to_playlist : Playlist -> Object -> Action ;

  -- create a new playlist
  create : Action ;

  dialog_pause : Action ;

  go_back_in_display_history : Action ;

  help : Action ;

  -- tell me
  identify : ToIdentify -> Action ;

-- what is this?
--  identify_songlist_of_album : Album -> Action ;

  -- gives just an object as a response to a question
  make_completion : Object -> Action ;

  pause : Action ;

  play : Object -> Action ;

  please_repeat : Action ;

  -- I don't care
  reject_any_constraint_determination : Action ;

  remove : Playlist -> Object -> Action ;

  resume : Action ;

  -- show me
  show : ToIdentify -> Action ;

  show_main_menu : Action ;

  skip_backward : Action ;

  skip_forward : Action ;

  stop : Action ;

  -- ToIdentify

  artist_of_album : Album -> ToIdentify ;
  artist_of_song : Song -> ToIdentify ;
  currently_playing_object : ToIdentify ;
  resource_by_type : Object -> ToIdentify ;

  -- Object

  one_song : Song -> Object ;
  any_song : SongSet -> Object ;
  all_songs : SongSet -> Object ;

  one_album : Album -> Object ;
  any_album : AlbumSet -> Object ;
  all_albums : AlbumSet -> Object ;

  one_playlist : Playlist -> Object ;
  any_playlist : PlaylistSet -> Object ;
  all_playlists : PlaylistSet -> Object ;

  -- PlaylistSet

  playlists_all : PlaylistSet ;
  playlists_by_genre : Genre -> PlaylistSet ;

  -- Playlist

  playlist_this : Playlist ;
  playlist_number : Number -> Playlist ;  
  playlist_name : PlaylistName -> Playlist ;

  -- ArtistSet

  artists_all : ArtistSet ;

  -- Artist

  artist_this : Artist ;
  artist_name : ArtistName -> Artist ;  

  -- AlbumSet

  albums_all : AlbumSet ;
  albums_by_artist : Artist -> AlbumSet ;
  albums_by_genre : Genre -> AlbumSet ;
  albums_by_artist_genre : Artist -> Genre -> AlbumSet ;

  -- Album

  album_this : Album ;
  album_number : Number -> Album ;
  album_name : AlbumName -> Album ;
  album_name_artist : AlbumName -> Artist -> Album ;

  -- SongSet

  songs_all : SongSet ;
  songs_by_artist : Artist -> SongSet ;
  songs_by_genre : Genre -> SongSet ;
  songs_by_album : Album -> SongSet ;
  songs_by_artist_genre : Artist -> Genre -> SongSet ;

  -- Song

  song_this : Song ;
  song_name : SongName -> Song ;
  song_name_artist : SongName -> Artist -> Song ;

  -- Ordinal

  num_1 : Number ;
  num_2 : Number ;
  num_3 : Number ;


  -- Music database

  -- PlaylistName

  CoolHits : PlaylistName ;
--  Romantik : PlaylistName ;

  -- Artist

--  Falco : ArtistName ;
--  TheBeatles : ArtistName ;
  U2 : ArtistName ;

  -- Genre

--  Pop : Genre ;
  Rock : Genre ;

  -- AlbumName
  
  HowToDismantleAnAtomicBomb : AlbumName ;

  -- SongName

--  AHardDaysNight : SongName ;
--  LetItBe : SongName ;
  Vertigo : SongName ;

}
