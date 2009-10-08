--# -path=.:alltenses

---- doesn't compile yet (AR 8/10/2009)

concrete SammieGer2 of Sammie = open

  SyntaxGer, ---- should be used

  GrammarGer,
  ExtraGer,
  SymbolGer,
  ParadigmsGer,
  IrregGer, 
  (R = ResGer), ----
  ConstructX,
  Prelude 
in {

flags startcat=Action;

param SetForm = Any | All ;

oper Set = { s : SetForm => NP } ;

oper mkSet : CN -> Set = \x -> { s = table {
       Any => variants {
         DetCN someSg_Det x ;
         DetCN (DetSg (SgQuant IndefArt) NoOrd) x
         } ;
       All => 
         PredetNP all_Predet (DetCN (DetPl (PlQuant all_art) NoNum NoOrd) x)   
       } 
     } ;

oper mkSetAdj : CN -> A -> Set = \x, adj -> 
  mkSet (AdjCN (PositA adj) x) ;

oper optional : Str -> Str = \s -> variants { []; s } ;

oper song = UseN (variants {song_N ; track_N}) ;
oper album = UseN (variants {album_N ; record_N ; cd_N}) ;

oper command : Utt -> Phr = \s -> variants {
    PhrUtt NoPConj s NoVoc ; 
    PhrUtt NoPConj s please_Voc ; 
    PhrUtt please_PConj s NoVoc
  } ; 

  withGenre : CN -> CN -> Set = \x,y -> 
    mkSet (typeWithGenre x y) ;

  withGenreBy : CN -> NP -> CN -> Set = \x,z,y -> 
    mkSet (AdvCN (typeWithGenre x y) (PrepNP artist_Prep z)) ;

----

lincat 
  Action = Phr ;

  Object, Playlist, Artist, Album, Song = NP ;

  PlaylistName, ArtistName, AlbumName, SongName = PN ;

  PlaylistSet, ArtistSet, AlbumSet, SongSet = Set ;

  ToIdentify = QS ;

  Genre = CN ;

  Number = Num ;

lin
  -- Action

  add_song_to_playlist l o = 
    command (imperative PPos (ImpVP (ComplV3 add_V3 o l))) ;

  create = 
    command 
      (imperative PPos (ImpVP (ComplV2 create_V2 
        (DetCN (DetSg (SgQuant IndefArt) NoOrd) 
          (AdjCN (PositA new_A) (UseN playlist_N)))))) ;

  dialog_pause = 
    command (imperative PPos (ImpVP shutup_VP)) ;
  
  go_back_in_display_history = 
    command (variants {
      UttAdv back_Adv ;
      imperative PPos (ImpVP goback_VP)
      }
    ) ;

  help = 
    command (imperative PPos (ImpVP goback_VP)) ;

  -- tell me
  identify x = 
    command (variants {
      UttQS x ;
      imperative PPos (ImpVP (AdvVP (ComplV2 tell_V2 (UsePron i_Pron)) 
        (AdvSC (EmbedQS x))))
      }
    ) ;

--  identify_songlist_of_album x = command (x.s) ;

  make_completion x = command (UttNP x) ;

  pause = 
    command (imperative PPos (ImpVP pause_VP)) ;

  play x = 
    command (imperative PPos (ImpVP (ComplV2 play_V2 x))) ;

  please_repeat = command what_say ;

  reject_any_constraint_determination = 
    command (whatever_Utt) ;

  remove l o = 
    command (imperative PPos (ImpVP (ComplV3 remove_V3 o l))) ;

  resume = 
    command (imperative PPos (ImpVP resume_VP)) ;

  -- show me

  show x = 
    command (
      imperative PPos (ImpVP (AdvVP (ComplV2 show_V2 (UsePron i_Pron)) 
        (AdvSC (EmbedQS x))))) ;

  show_main_menu = 
    command (variants { 
      imperative PPos (ImpVP (ComplV3 show_V3 (UsePron i_Pron) mainmenu_NP)) ;
      imperative PPos (ImpVP (ComplV2 return_V2 mainmenu_NP))
      }
    ) ;

  skip_backward = 
    command (variants {
      imperative PPos (ImpVP (ComplV2 play_V2 (previous song))) ;
      imperative PPos (ImpVP (ComplV2 goto_V2 (previous song)))
      }
    ) ;

  skip_forward = 
    command (variants {
      imperative PPos (ImpVP (ComplV2 play_V2 (next song))) ;
      imperative PPos (ImpVP (ComplV2 goto_V2 (next song)))
      }
    ) ;

  stop = command (imperative PPos (ImpVP (UseV stop_V))) ;

  -- ToIdentify

  artist_of_album album = 
    UseQCl past.p1 past.p2 PPos (QuestVP whoSg_IP
      (variants {ComplV2 record_V2 album ; ComplV2 make_V2 album})) ;
--- { s = "who" ++ variants {"made";"sings";"plays";"recorded"} ++ album.s } ;

  artist_of_song song = 
    UseQCl past.p1 past.p2 PPos (QuestVP whoSg_IP (ComplV2 record_V2 song)) ;

  currently_playing_object = 
    UseQCl TPres ASimul PPos (WhatName
      (this song)) ;

{- ---
    { s = variants {
	["what is this"] ++ optional song ++ ["called"];
	["what is the name of this"] ++ optional song;
	} } ;
-}

  resource_by_type x = ---T
    UseQCl TPres ASimul PPos (WhatName x) ; 

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

  playlists_all = mkSet (UseN playlist_N) ;
  playlists_by_genre = withGenre (UseN playlist_N) ;

  -- Playlist

  playlist_this = this (UseN playlist_N) ;
--    DetCN (DetSg (SgQuant this_Quant) NoOrd) (UseN playlist_N) ;
  playlist_number x = 
    CNNumNP (UseN playlist_N) x ;
  playlist_name x = 
    DetCN (DetSg (SgQuant DefArt) NoOrd) (ApposCN (UseN playlist_N) (UsePN x)) ;

  -- ArtistSet

  artists_all = mkSet (UseN artist_N) ;

  -- Artist

  artist_this = this (UseN artist_N) ;
  --  DetCN (DetSg (SgQuant this_Quant) NoOrd) (UseN artist_N) ;
  artist_name x =variants {
    UsePN x ; 
    DetCN (DetSg (SgQuant DefArt) NoOrd) (ApposCN (UseN artist_N) (UsePN x))
    } ;

  -- AlbumSet

  albums_all = mkSet album ;
  albums_by_artist artist = 
    mkSet (AdvCN album (PrepNP artist_Prep artist)) ;
  albums_by_genre = withGenre album ; 

  albums_by_artist_genre = withGenreBy album ;

  -- Album

  album_this =
    this album ; 

  album_number x = variants { 
    CNNumNP (ApposCN album (CNNumNP (UseN number_N) x)) NoNum ;
    CNNumNP album x
    } ;
  album_name x = variants {
    UsePN x ;
    DetCN (DetSg (SgQuant DefArt) NoOrd) (ApposCN album (UsePN x))
    } ;

  album_name_artist x y = AdvNP (variants {
    UsePN x ;
    DetCN (DetSg (SgQuant DefArt) NoOrd) (ApposCN album (UsePN x))
    }) (PrepNP artist_Prep y) ;

  -- SongSet

  songs_all = mkSet song ;
  songs_by_artist artist = 
    mkSet (AdvCN song (PrepNP artist_Prep artist)) ;
  songs_by_genre = withGenre song ; 
  songs_by_album album = 
    mkSet (AdvCN song (PrepNP from_Prep album)) ;

  songs_by_artist_genre = withGenreBy song ; 

  -- Song

  song_this = this song ; 
    -- DetCN (DetSg (SgQuant this_Quant) NoOrd) song ;
  song_name x = variants {
    UsePN x ;
    DetCN (DetSg (SgQuant DefArt) NoOrd) (ApposCN song (UsePN x))
    } ;
  song_name_artist x y = AdvNP (variants {
    UsePN x ;
    DetCN (DetSg (SgQuant DefArt) NoOrd) (ApposCN song (UsePN x))
    }) (PrepNP artist_Prep y) ;

  -- Ordinal

--  num_1 = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 pot01)))) ;
  num_2 = NumNumeral (num (pot2as3 (pot1as2 (pot0as1 (pot0 n2))))) ;
--  num_3 = { s = "three" } ;



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
  Rock = UseN rock_N ;

  -- AlbumName
  
  HowToDismantleAnAtomicBomb = name ["how_to_dismantle_an_atomic_bomb"];

  -- SongName

--  AHardDaysNight = { s = ["a hard day's night"] };
--  LetItBe = { s = ["let it be"] };
  Vertigo = name ["vertigo"] ;

-- }
-- instance ParamSammieGer of ParamSammie = open 

oper 

  song_N = variants {
    reg2N "lied" "lieder" neuter ; 
    reg2N "song" "songs" masculine
    } ;
  track_N = reg2N "stück" "stücke" neuter ; 
  album_N = mkN "album" "album" "album" "albums" "alben" "alben" neuter ;
  record_N = regN "platte" ;
  cd_N = reg2N "cd" "cds" feminine ;
  playlist_N = variants {
    reg2N "playlist" "playlisten" feminine ;
    regN "wiedergabeliste"
    } ;
  artist_N = regN "künstler" ;
  number_N = reg2N "nummer" "nummern" feminine ;
  rock_N = regN "rock" ;

  new_A = regA "neu" ;

  add_V3 = 
    mkV3 (prefixV "hinzu" (regV "fügen")) accPrep zu_Prep ;
  remove_V3 = 
    mkV3 (prefixV "aus" nehmen_V) accPrep (mkPrep "aus" dative) ;
  show_V3 = mkV3 (regV "zeigen") datPrep accPrep ;

  create_V2 = dirV2 (no_geV (regV (variants {"erzeugen" ; "erstellen"}))) ;
  tell_V2 = mkV2 (regV "sagen") datPrep ;
  play_V2 = dirV2 (regV "spielen") ;
  show_V2 = mkV2 (regV "zeigen") datPrep ;
  return_V2 = mkV2 (prefixV "zurück" gehen_V) zu_Prep ;
  goto_V2 = mkV2 gehen_V to_Prep ;
  record_V2 = dirV2 (no_geV (regV "interpretieren")) ; 
    --prefixV "ein" (regV "spielen")) ;
  make_V2 = dirV2 (regV "machen") ;

  stop_V = halten_V ;

  back_Adv = mkAdv "zurück" ;

  what_IAdv = mkIAdv "was" ;



  previous_Ord = 
    {s = variants {
      (regA "vorig").s ! R.Posit ; 
      (regA "vorhergehend").s ! R.Posit 
      } ;
     lock_Ord = <>
    } ;
  next_Ord = 
    {s = variants {
      (regA "nächst").s ! R.Posit ; 
      (regA "nachfolgend").s ! R.Posit 
      } ;
     lock_Ord = <>
    } ;

  please_PConj = mkPConj "bitte" ;

  mainmenu_NP = 
    DetCN (DetSg (SgQuant DefArt) NoOrd) 
      (UseN (reg2N "hauptmenü" "hauptmenüs" neuter)) ;

  goback_VP = AdvVP (UseV gehen_V) back_Adv ;
  shutup_VP = UseV (schweigen_V) ;
  pause_VP  = UseV (regV "pausieren") ;
  resume_VP = UseV (regV "wiederholen") ; ----

  whatever_Utt = mkUtt ["irgendwas"] ;

  typeWithGenre x genre =
---- CompoundCN genre x ;
    AdvCN x (PrepNP with_Prep 
        (DetCN (DetSg MassDet NoOrd) genre)) ;

  name = regPN ;

  WhatName x = QuestIAdv how_IAdv (PredVP x (UseV heißen_V)) ;

  past = <TPres,AAnter> ;

  imperative = variants { UttImpPol ; UttImpSg } ;

  previous = DetCN (DetSg (SgQuant DefArt) previous_Ord) ;
  next = DetCN (DetSg (SgQuant DefArt) next_Ord) ;

  what_say = UttIP whatSg_IP ;

  all_art = variants {IndefArt ; DefArt} ;

  artist_Prep = variants {by8agent_Prep ; with_Prep} ;

  this cn = variants {
    DetCN (DetSg (SgQuant this_Quant) NoOrd) cn ;
    DetCN (DetSg (SgQuant DefArt) NoOrd) 
      (AdjCN (PositA (regA "aktuell")) cn)
    } ;

-- interface ParamSammie = open Grammar in {

oper 
  song_N, track_N, album_N, record_N, cd_N, 
    playlist_N, artist_N, number_N, rock_N : N ;
  new_A : A ;

  add_V3, remove_V3, show_V3 : V3 ;
  create_V2, tell_V2, play_V2, show_V2, return_V2, goto_V2, 
    record_V2, make_V2 : V2 ;
  stop_V : V ;

  back_Adv : Adv ;

  what_IAdv : IAdv ;

  previous_Ord, next_Ord : Ord ;
  please_PConj : PConj ;

  mainmenu_NP : NP ;

  goback_VP : VP ;
  shutup_VP : VP ;
  pause_VP  : VP ;
  resume_VP : VP ;

  whatever_Utt : Utt ;

  typeWithGenre : CN -> CN -> CN ;

  name : Str -> PN ;

  WhatName : NP -> QCl ;

  past : Tense * Ant ;

  imperative : Pol -> Imp -> Utt ;

  previous, next : CN -> NP ;

  what_say : Utt ;
  all_art : Quant ;

  this : CN -> NP ;

}
