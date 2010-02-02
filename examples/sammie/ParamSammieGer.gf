instance ParamSammieGer of ParamSammie = open 
  SyntaxGer,
  ExtraGer,
  SymbolicGer,
  ParadigmsGer,
  IrregGer, 
  (ConstructX = ConstructX),
  Prelude 
in {

oper 

  song_N = mkN "song" "songs" masculine ;

  track_N = variants {
    mkN "lied" "lieder" neuter ;
    mkN "stück" "stücke" neuter
    } ;

  album_N = mkN "album" "album" "album" "albums" "alben" "alben" neuter ;
  record_N = mkN "platte" ;
  cd_N = mkN "cd" "cds" feminine ;
  playlist_N = variants {
    mkN "playlist" "playlisten" feminine ;
    mkN "wiedergabeliste"
    } ;
  artist_N = mkN "künstler" ;
  number_N = mkN "nummer" "nummern" feminine ;
  rock_N = mkN "rock" ;

  new_A = mkA "neu" ;

  add_V3 = 
    mkV3 (prefixV "hinzu" (mkV "fügen")) accPrep zu_Prep ;
  remove_V3 = 
    mkV3 (prefixV "aus" nehmen_V) accPrep (mkPrep "aus" dative) ;
  show_V3 = mkV3 (mkV "zeigen") datPrep accPrep ;

  create_V2 = dirV2 (no_geV (mkV (variants {"erzeugen" ; "erstellen"}))) ;
  tell_V2Q = mkV2Q (mkV "sagen") datPrep ;
  play_V2 = dirV2 (mkV "spielen") ;
  show_V2Q = mkV2Q (mkV "zeigen") datPrep ;
  return_V2 = mkV2 (prefixV "zurück" gehen_V) zu_Prep ;
  goto_V2 = mkV2 gehen_V to_Prep ;
  record_V2 = dirV2 (no_geV (mkV "interpretieren")) ; 
    --prefixV "ein" (mkV "spielen")) ;
  make_V2 = dirV2 (mkV "machen") ;

  stop_V = halten_V ;

  back_Adv = mkAdv "zurück" ;

  what_IAdv = ConstructX.mkIAdv "was" ;



  previous_A = mkA "vorig" | mkA "vorhergehend" ;

  next_A = mkA "nächst" | mkA "nachfolgend" | mkA "folgend" ;

  please_PConj = ConstructX.mkPConj "bitte" ;

  mainmenu_NP = 
    mkNP the_Art 
      (mkCN (mkN "hauptmenü" "hauptmenüs" neuter)) ;

  goback_VP = mkVP (mkVP gehen_V) back_Adv ;
  shutup_VP = mkVP (schweigen_V) ;
  pause_VP  = mkVP (mkV "pausieren") ;
  resume_VP = mkVP (mkV "wiederholen") ; ----

  whatever_Utt = ConstructX.mkUtt ["irgendwas"] ;

  typeWithGenre x genre =
    mkCN x (SyntaxGer.mkAdv with_Prep (mkNP genre)) ;

  name = regPN ;

  WhatName x = mkQCl how_IAdv (mkCl x heißen_V) ;

  past = <presentTense,anteriorAnt> ;

  imperative vp = 
      mkUtt (mkImp (bitteVP vp)) 
    | mkUtt (mkImp vp)
    | mkUtt (mkQS (mkQCl (mkCl (mkNP youSg_Pron) can_VV vp)))
    | mkUtt (mkQS (mkQCl (mkCl (mkNP youPol_Pron) can_VV vp)))
    | mkUtt (mkS (mkCl (mkNP i_Pron) want_VV vp))
    | mkUtt (mkS TImpfSubj (mkCl (mkNP i_Pron) moegen_VV vp))
    | mkUtt vp
    ;

  bitteVP : VP -> VP = \vp -> variants {
    vp ;
    mkVP (ConstructX.mkAdV "bitte") vp
    } ;

  previous cn = 
      mkNP the_Art (mkCN previous_A cn)
    | mkNP (mkCN previous_A cn)
    ;
  next cn = 
      mkNP the_Art (mkCN next_A cn)
    | mkNP (mkCN next_A cn)
    ;

  what_say = mkUtt whatSg_IP ;

  all_art = a_Art | the_Art ;

  artist_Prep = by8agent_Prep ; ---- | with_Prep ;

  this cn =
      mkNP this_Quant cn
    | mkNP the_Art (mkCN (mkA "aktuell") cn)
    ;

}
