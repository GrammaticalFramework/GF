
concrete SammieEng1 of Sammie = {

flags startcat=Action;

param SetForm = Any | All;

oper Set = { s : SetForm => Str } ;

oper mkSet : Str -> Set = \x -> { s = table {
       Any => variants { "a"; "some"; "any" } ++ x ;
       All => variants { "all"; ["all the"] } ++ (x + "s")
       } } ;

oper mkSetAdj : Str -> Str -> Set = \x -> \adj -> { s = table {
       Any => variants { "a"; "some"; "any" } ++ adj ++ x ;
       All => variants { "all"; ["all the"] } ++ adj ++ (x + "s")
       } } ;

oper optional : Str -> Str = \s -> variants { []; s } ;

oper song = variants {"song"; "track"} ;
oper album = variants {"album";"record";"cd"} ;

oper command : Str -> { s : Str } = 
       \s -> { s = variants {s; "please" ++ s; s ++ "please" } } ;


lincat 
  PlaylistSet, ArtistSet, AlbumSet, SongSet = Set ;


lin
  -- Action

  add_song_to_playlist l o = 
    command ("add" ++ o.s ++ "to" ++ l.s) ;

  -- create a new playlist
  create = 
    command ["create a new playlist"] ;

  dialog_pause = 
    command (variants {
	       ["pause the dialog"]; 
	       ["be"] ++ variants { "quiet";"silent" };
	       ["shut"] ++ variants {[]; ["the hell"]; ["the fuck"]} ++ "up";
	       ["shut your mouth"];
	       ["put a sock in it"];
	       });
  
  go_back_in_display_history = 
    command (variants { ["back"]; ["go back"] }) ;

  help = 
    command (variants { ["help"]; ["help me"]; ["give me help"] }) ;

  -- tell me
  identify x = 
    command (optional ["tell me"] ++ x.s) ;

--  identify_songlist_of_album x = command (x.s) ;

  make_completion x = command (x.s) ;

  pause = 
    command "pause" ;

  play x = 
    command ("play" ++ x.s) ;

  please_repeat = 
    command (variants {
	       ["repeat that"];
	       ["what"];
	       ["pardon"];
	       ["pardon me"];
	       ["what did you say"];
	       ["what was that"]
	       }) ;

  -- I don't care
  reject_any_constraint_determination = 
    command (variants {
	       ["whatever"];
	       variants {["do i look like i"];["i don't"]}
		 ++ variants {["give a"] ++ variants {"shit";"fuck";["rat's ass"]};
			      ["care"]}
		 ++ optional ["about that"];
	       ["i couldn't care less"];
	       ["see if i care"]
	       }) ;

  remove l o = 
    command ("remove" ++ o.s ++ "from" ++ l.s) ;

  resume = 
    command ("resume") ;

  -- show me

  show x = 
    command (["show me"] ++ x.s) ;

  show_main_menu = 
    command (variants { 
	       ["show me the main menu"]; 
	       ["go to the main menu"];
	       ["back to the main menu"];
	       }) ;

  skip_backward = 
    command (variants {"play"; ["go to"]} ++ ["the previous"] ++ song) ;

  skip_forward = 
    command (variants {"play"; ["go to"]} ++ ["the next"] ++ song) ;

  stop = command (variants { "stop" }) ;

  -- ToIdentify

  artist_of_album album = 
    { s = "who" ++ variants {"made";"sings";"plays";"recorded"} ++ album.s } ;

  artist_of_song song = 
    { s = "who" ++ variants {"made";"sings";"plays";"recorded"} ++ song.s } ;

  currently_playing_object = 
    { s = variants {
	["what is this"] ++ optional song ++ ["called"];
	["what is the name of this"] ++ optional song;
	} } ;

  resource_by_type x = { s = x.s } ;

  -- Object

  one_song x = { s = x.s } ;
  any_song x = { s = x.s ! Any} ;
  all_songs x = { s = x.s ! All } ;

  one_album x = { s = x.s } ;
  any_album x = { s = x.s ! Any} ;
  all_albums x = { s = x.s ! All } ;

  one_playlist x = { s = x.s } ;
  any_playlist x = { s = x.s ! Any} ;
  all_playlists x = { s = x.s ! All } ;


  -- PlaylistSet

  playlists_all = mkSet "playlist" ;
  playlists_by_genre genre = mkSetAdj "playlist" (genre.s) ;

  -- Playlist

  playlist_this = { s = ["this playlist"] } ;
  playlist_number x = { s = "playlist" ++ x.s } ;
  playlist_name x = { s = variants { ["the playlist"] ++ x.s; "the" ++ x.s ++ "playlist" }};

  -- ArtistSet

  artists_all = mkSet "artist" ;

  -- Artist

  artist_this = { s = ["this artist"] } ;
  artist_name x = { s = optional ["the artist"] ++ x.s } ;

  -- AlbumSet

  albums_all = mkSet album ;
  albums_by_artist artist = { s = \\n => (mkSet album).s ! n ++ "by" ++ artist.s };
  albums_by_genre genre = mkSetAdj album (genre.s) ;
  albums_by_artist_genre artist genre = { s = \\n => (mkSetAdj album (genre.s)).s ! n ++ "by" ++ artist.s };

  -- Album

  album_this = { s = ["this"] ++ album } ;
  album_number n = { s = album ++ ["number"] ++ n.s } ;
  album_name name = { s = optional (["the"] ++ album) ++ name.s } ;
  album_name_artist name artist = { s = optional (["the"] ++ album) ++ name.s ++ "by" ++ artist.s } ;

  -- SongSet

  songs_all = mkSet song ;
  songs_by_artist artist = { s = \\n => (mkSet song).s ! n ++ "by" ++ artist.s };
  songs_by_genre genre = mkSetAdj song (genre.s) ;
  songs_by_album album = { s = \\n => (mkSet song).s ! n ++ "from" ++ album.s } ;
  songs_by_artist_genre artist genre = { s = \\n => (mkSetAdj song (genre.s)).s ! n ++ "by" ++ artist.s };

  -- Song

  song_this = { s = "this" ++ song } ;
  song_name x = { s = optional ("the" ++ song) ++ x.s } ;
  song_name_artist name artist = { s =  optional ("the" ++ song) ++ name.s ++ "by" ++ artist.s } ;

  -- Ordinal

--  num_1 = { s = "one" } ;
  num_2 = { s = "two" } ;
--  num_3 = { s = "three" } ;



  -- Music database

  -- PlaylistName

  CoolHits = { s = ["cool hits"] };
--  Romantik = { s = ["romance"] };

  -- Artist

--  Falco = { s = ["Falco"] };
--  TheBeatles = { s = ["The Beatles"] };
  U2 = { s = "u2" } ;

  -- Genre

--  Pop = { s = ["pop"] };
  Rock = { s = ["rock"] };

  -- AlbumName
  
  HowToDismantleAnAtomicBomb = { s = ["how to dismantle an atomic bomb"] };

  -- SongName

--  AHardDaysNight = { s = ["a hard day's night"] };
--  LetItBe = { s = ["let it be"] };
  Vertigo = { s = "vertigo" } ;

}