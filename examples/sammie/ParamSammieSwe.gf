instance ParamSammieSwe of ParamSammie = open 
  SyntaxSwe,
  GrammarSwe,
  ExtraSwe,
  SymbolSwe,
  ParadigmsSwe,
  IrregSwe, 
  ConstructX,
  Prelude 
in {

oper 

  song_N = mk1N "sångerna" ;
  track_N = mk1N "låtarna" ;
  album_N = mk1N "albumen" ;
  record_N = regN "platta" ;
  cd_N = regN "cd-skiva" ;
  playlist_N = regN "spellista" ;
  artist_N = mk1N "artisterna" ;
  number_N = mkN "nummer" "numret" "nummer" "numren"  ;
  rock_N = regN "rock" ;

  new_A = regA "ny" ;

  add_V3 = 
    mkV3 (partV lägga_V "till") noPrep (mkPrep "till") ;
  remove_V3 = 
    mkV3 (partV taga_V "bort") noPrep (mkPrep "från") ;
  show_V3 = dirdirV3 (regV "visa") ;

  create_V2 = dirV2 (regV "skapa") ;
  tell_V2 = dirV2 säga_V ;
  play_V2 = dirV2 (regV "spela") ;
  show_V2 = dirV2 (regV "visa") ;
  return_V2 = mkV2 (regV "återvänder") to_Prep ;
  goto_V2 = mkV2 gå_V to_Prep ;
  record_V2 = dirV2 (partV (regV "spela") "in") ;
  make_V2 = dirV2 göra_V ;

  stop_V = regV "stanna" ;

  back_Adv = mkAdv "tillbaka" ;

  what_IAdv = mkIAdv "vad" ;

  previous_Ord = {s = "föregående" ; isDet = False ; lock_Ord = <>} ;
  next_Ord = {s = "nästa" ; isDet = False ; lock_Ord = <>} ;
  please_PConj = mkPConj "snälla" ;

  next_A = mkA "näst" ; --- not used
  previous_A = mkA "föregående" ; --- not used
  show_V2Q = mkV2Q (mkV "visa") noPrep ;
  tell_V2Q = mkV2Q (mkV "berätta") noPrep ;

  mainmenu_NP = 
    mkNP the_Quant 
      (UseN (mk2N "huvudmeny" "huvudmenyer")) ;

  goback_VP = AdvVP (UseV gå_V) back_Adv ;
  shutup_VP = UseV (tiga_V) ;
  pause_VP  = UseV (regV "pausa") ;
  resume_VP = UseV (irregV "återupptaga" "återupptog" "återupptagit") ;

  whatever_Utt = mkUtt ["vad som helst"] ;

  typeWithGenre x genre =
---- CompoundCN genre x ;
    AdvCN x (PrepNP with_Prep 
        (mkNP genre)) ;

  name = regPN ;

  WhatName x = mkQCl whatSg_IP x (dirV2 (mk2V "heta" "hette")) ;
  past = <TPres,AAnter> ;

  imperative = SyntaxSwe.mkUtt ;

  previous cn = mkNP the_Art cn ; --previous_Ord cn ;
  next cn = mkNP the_Art cn ; --next_Ord cn ;
 
  what_say = UttIP whatSg_IP ;

  all_art = variants {IndefArt ; DefArt} ;

  artist_Prep = variants {by8agent_Prep ; with_Prep} ;

  this cn = variants {
    mkNP this_Quant cn ;
    mkNP the_Quant
      (AdjCN (PositA (regA "nuvarande")) cn)
    } ;
}
