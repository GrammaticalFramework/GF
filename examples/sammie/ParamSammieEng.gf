instance ParamSammieEng of ParamSammie = open 
  SyntaxEng,
  ExtraEng,
  SymbolicEng,
  ParadigmsEng,
  IrregEng, 
  (C = ConstructX),
  Prelude 
in {

oper 

  song_N = mkN "song" ;
  track_N = mkN "track" ;
  album_N = mkN "album" ;
  record_N = mkN "record" ;
  cd_N = mkN "CD" ;
  playlist_N = mkN "playlist" ;
  artist_N = mkN "artist" ;
  number_N = mkN "number" ;
  rock_N = mkN "rock" ;

  new_A = regA "new" ;

  add_V3 = dirV3 (mkV "add") to_Prep ;
  remove_V3 = dirV3 (mkV "remove") from_Prep ;
  show_V3 = dirdirV3 (mkV "show") ;

  create_V2 = dirV2 (mkV "create") ;
  show_V2Q = mkV2Q (dirV2 (mkV "show")) (mkPrep []) ;
  tell_V2Q = mkV2Q (dirV2 tell_V) (mkPrep []) ;
  play_V2 = dirV2 (mkV "play") ;
  return_V2 = mkV2 (mkV "return") to_Prep ;
  goto_V2 = mkV2 go_V to_Prep ;
  record_V2 = dirV2 (mkV "record") ;
  make_V2 = dirV2 make_V ;

  stop_V = regDuplV "stop" ;

  back_Adv = mkAdv "back" ;

  what_IAdv = C.mkIAdv "what" ;

  previous_A = mkA "previous" ;
  next_A = mkA "next" ;
  please_PConj = C.mkPConj "please" ;

  mainmenu_NP = 
    mkNP the_Art (mkCN (mkA "main") (mkN "menu")) ;

  goback_VP = mkVP (mkVP go_V) back_Adv ;
  shutup_VP = mkVP (partV shut_V "up") ;
  pause_VP  = mkVP (mkV "pause") ;
  resume_VP = mkVP (mkV "resume") ;

  whatever_Utt = C.mkUtt "whatever" ;

  typeWithGenre x genre = mkCN genre (mkNP x) ;

  name = regPN ;

  WhatName = mkQCl what_IAdv ;

  past = <TPast,ASimul> ;

  imperative vp = 
      mkUtt (mkImp vp)
    | mkUtt (mkQS (mkQCl (mkCl (mkNP youSg_Pron) can_VV vp)))
    | mkUtt (mkCl (mkNP i_Pron) want_VV vp)
    | mkUtt vp
    ;


  previous cn = mkNP the_Art (mkCN previous_A cn) ;
  next cn = mkNP the_Art (mkCN next_A cn) ;

  what_say = mkUtt whatSg_IP ;

  all_art = a_Art | the_Art ;

  artist_Prep = by8agent_Prep | with_Prep ;

  this cn = 
      mkNP this_Quant
    | mkNP the_Art (mkCN (mkA "current") cn)
    ;
}
