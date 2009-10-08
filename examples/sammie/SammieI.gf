--# -path=.:alltenses

incomplete concrete SammieI of Sammie = open 
  Syntax, 
  Symbolic,
  ParamSammie 
in {

flags startcat=Action;

param SetForm = Any | All ;

oper Set = { s : SetForm => NP } ;

oper mkSet : CN -> Set = \x -> { s = table {
       Any => variants {
         mkNP someSg_Det x ;
         mkNP a_Art x
         } ;
       All => 
         mkNP all_Predet (mkNP all_art plNum x)   
       } 
     } ;

oper mkSetAdj : CN -> A -> Set = \x, adj -> 
  mkSet (mkCN adj x) ;

oper optional : Str -> Str = \s -> [] | s ;

oper song = mkCN (song_N | track_N) ;
oper album = mkCN (album_N | record_N | cd_N) ;

oper command : Utt -> Phr = \s -> 
    mkPhr s 
  | mkPhr s please_Voc 
  | mkPhr please_PConj s ; 

  withGenre : CN -> CN -> Set = \x,y -> 
    mkSet (typeWithGenre x y) ;

  withGenreBy : CN -> NP -> CN -> Set = \x,z,y -> 
    mkSet (mkCN (typeWithGenre x y) (mkAdv artist_Prep z)) ;

----

lincat 
  Action = Phr ;

  Object, Playlist, Artist, Album, Song = NP ;

  PlaylistName, ArtistName, AlbumName, SongName = PN ;

  PlaylistSet, ArtistSet, AlbumSet, SongSet = Set ;

  ToIdentify = QS ;

  Genre = CN ;

  Number = Card ;

lin
  -- Action

  add_song_to_playlist l o = 
    command (imperative (mkVP add_V3 o l)) ;

  create = 
    command 
      (imperative (mkVP create_V2 
        (mkNP a_Art (mkCN new_A playlist_N)))) ;

  dialog_pause = 
    command (imperative ( shutup_VP)) ;
  
  go_back_in_display_history = 
    command (
      mkUtt back_Adv |
      imperative goback_VP
      ) ;

  help = 
    command (imperative goback_VP) ;

  -- tell me
  identify x = 
    command (
      mkUtt x |
      imperative (mkVP tell_V2Q (mkNP i_Pron) x)
      ) ;

--  identify_songlist_of_album x = command (x.s) ;

  make_completion x = command (mkUtt x) ;

  pause = 
    command (imperative pause_VP) ;

  play x = 
    command (imperative (mkVP play_V2 x)) ;

  please_repeat = command what_say ;

  reject_any_constraint_determination = 
    command (whatever_Utt) ;

  remove l o = 
    command (imperative (mkVP remove_V3 o l)) ;

  resume = 
    command (imperative resume_VP) ;

  -- show me

  show x = 
    command (
      imperative (mkVP show_V2Q (mkNP i_Pron) x)
      ) ;

  show_main_menu = 
    command (
        imperative (mkVP show_V3 (mkNP i_Pron) mainmenu_NP)
      | imperative (mkVP return_V2 mainmenu_NP)
      ) ;

  skip_backward = 
    command (
        imperative (mkVP play_V2 (previous song))
      | imperative (mkVP goto_V2 (previous song))
    ) ;

  skip_forward = 
    command (variants {
        imperative (mkVP play_V2 (next song))
      | imperative (mkVP goto_V2 (next song))
      }
    ) ;

  stop = command (imperative (mkVP stop_V)) ;

  -- ToIdentify

  artist_of_album album = 
    mkQS past.p1 past.p2 
      (mkQCl whoSg_IP (mkVP (record_V2 | make_V2) album)) ;

  artist_of_song song = 
    mkQS past.p1 past.p2 (mkQCl whoSg_IP (mkVP record_V2 song)) ;

  currently_playing_object = 
    mkQS (WhatName (this song)) ;

  resource_by_type x = 
    mkQS (WhatName x) ; 

  -- Object

  one_song x = x ;
  any_song x = x.s ! Any ;
  all_songs x = x.s ! All ;

  one_album x = x ;
  any_album x = x.s ! Any ;
  all_albums x = x.s ! All ;

  one_playlist x = x ;
  any_playlist x = x.s ! Any ;
  all_playlists x = x.s ! All ;


  -- PlaylistSet

  playlists_all = mkSet (mkCN playlist_N) ;
  playlists_by_genre = withGenre (mkCN playlist_N) ;

  -- Playlist

  playlist_this = this (mkCN playlist_N) ;

  playlist_number x = 
    symb (mkCN playlist_N) x ;
  playlist_name x = 
    mkNP the_Art (mkCN (mkCN playlist_N) (mkNP x)) ;

  -- ArtistSet

  artists_all = mkSet (mkCN artist_N) ;

  -- Artist

  artist_this = this (mkCN artist_N) ;

  artist_name x =
      mkNP x
    | mkNP the_Art (mkCN (mkCN artist_N) (mkNP x))
    ;

  -- AlbumSet

  albums_all = mkSet album ;
  albums_by_artist artist = 
    mkSet (mkCN album (mkAdv artist_Prep artist)) ;
  albums_by_genre = withGenre album ; 

  albums_by_artist_genre = withGenreBy album ;

  -- Album

  album_this =
    this album ; 

  album_number x = 
      mkNP the_Art (mkCN album (symb (mkCN number_N) x))
    | symb album x
    ;

  album_name x = 
      mkNP x
    | mkNP the_Art (mkCN album (mkNP x))
    ;

  album_name_artist x y = 
    mkNP 
      (mkNP x | mkNP the_Art (mkCN album (mkNP x)))
      (mkAdv artist_Prep y) ;

  -- SongSet

  songs_all = 
    mkSet song ;
  songs_by_artist artist = 
    mkSet (mkCN song (mkAdv artist_Prep artist)) ;
  songs_by_genre = 
    withGenre song ; 
  songs_by_album album = 
    mkSet (mkCN song (mkAdv from_Prep album)) ;
  songs_by_artist_genre = 
    withGenreBy song ; 

  -- Song

  song_this = this song ; 
  song_name x = 
      mkNP x
    | mkNP the_Art (mkCN song (mkNP x))
    ;
  song_name_artist x y = 
    mkNP 
      (mkNP x | mkNP the_Art (mkCN song (mkNP x)))
      (mkAdv artist_Prep y) ;

  -- Ordinal

  num_1 = mkCard n1_Numeral ;
  num_2 = mkCard n2_Numeral ;
  num_3 = mkCard n3_Numeral ;



  -- Music database

  -- PlaylistName

  CoolHits = name ["cool_hits"] ;
--  Romantik = { s = ["romance"] };

  -- Artist

--  Falco = { s = ["Falco"] };
--  TheBeatles = { s = ["The Beatles"] };
  U2 = name "u2" ;

  -- Genre

--  Pop = { s = ["pop"] };
  Rock = mkCN rock_N ;

  -- AlbumName
  
  HowToDismantleAnAtomicBomb = name ["how_to_dismantle_an_atomic_bomb"];

  -- SongName

--  AHardDaysNight = { s = ["a hard day's night"] };
--  LetItBe = { s = ["let it be"] };
  Vertigo = name ["vertigo"] ;

}
