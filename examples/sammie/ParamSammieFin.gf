instance ParamSammieFin of ParamSammie = open 
  SyntaxFin,
  ExtraFin,
  SymbolicFin,
  (R = ResFin), ----
  ParadigmsFin,
  (C = ConstructX),
  Prelude 
in {

oper 

  song_N = mkN "laulu" ;
  track_N = mkN "kappale" ;
  album_N = mkN "albumi" ;
  record_N = mkN "levy" ;
  cd_N = mkN "cd-levy" ;
  playlist_N = mkN "soittolista" ;
  artist_N = mkN "artisti" ;
  number_N = mkN "numero" ;
  rock_N = mkN "rock" ;

  new_A = mkA (mkN "uusi" "uuden" "uusia") ;

  add_V3 = 
    dirV3 (mkV "lis‰t‰") illative ;
  remove_V3 = 
    dirV3 (mkV "poistaa") ablative ;
  show_V3 = mkV3 (mkV "n‰ytt‰‰") (casePrep allative) accPrep ;

  create_V2 = dirV2 (mkV "luoda") ;
  tell_V2Q = mkV2Q (mkV "sanoa") (casePrep allative) ;
  play_V2 = dirV2 (mkV "soittaa") ;
  show_V2Q = mkV2Q (mkV "n‰ytt‰‰") (casePrep allative) ;
  return_V2 = mkV2 (mkV "palata") to_Prep ;
  goto_V2 = mkV2 (mkV "menn‰") to_Prep ;
  record_V2 = dirV2 (mkV "levytt‰‰") ;
  make_V2 = dirV2 (mkV "tehd‰" "tekee" "teen" "tekev‰t" "tehk‰‰" "tehd‰‰n"
      "teki" "tein" "tekisi" "tehnyt" "tehty" "tehdyn") ; 

  stop_V = mkV "lopettaa" ;

  back_Adv = mkAdv "takaisin" ;

  what_IAdv = C.mkIAdv "mik‰" ;

  previous_A = mkA "edellinen" ; 
  next_A = mkA "seuraava" ; 
  please_PConj = C.mkPConj ["ole hyv‰"] ;

  mainmenu_NP = mkNP the_Art (mkN "p‰‰valikko") ;

  goback_VP = mkVP (mkVP (mkV "menn‰")) back_Adv ;
  shutup_VP = mkVP (mkAdv "hiljaa") ;
  pause_VP  = mkVP (dirV2 (mkV "pit‰‰")) (mkNP the_Art (mkN "tauko")) ;
  resume_VP = mkVP (mkVP (mkV "palata")) (mkAdv "asiaan") ;

  whatever_Utt = C.mkUtt ["mit‰ tahansa"] ;

  typeWithGenre x genre =
    mkCN x (mkRS (RelExistNP in_Prep which_RP (mkNP genre))) ;

  name = mkPN ;

  WhatName = mkQCl what_IAdv ;

  past = <TPres,AAnter> ;

  imperative vp = 
      mkUtt (mkImp vp)
    | mkUtt (mkQS (mkQCl (mkCl (mkNP youSg_Pron) can_VV vp)))
    | mkUtt (mkCl (mkNP i_Pron) want_VV vp)
    | mkUtt vp
    ;

  previous cn = mkNP the_Art (mkCN previous_A cn) ;
  next cn = mkNP the_Art (mkCN next_A cn) ;

  what_say = mkUtt whatPart_IP ;

  all_art = the_Art ;

  artist_Prep = casePrep ablative ;

  this cn = 
      mkNP this_Quant
    | mkNP the_Art (mkCN (mkA "t‰m‰nhetkinen") cn)
    ;

}
