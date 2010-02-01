instance ParamSammieFre of ParamSammie = open 
  GrammarFre,
  SyntaxFre,
  ExtraFre,
  SymbolFre,
  IrregFre,
  ParadigmsFre,
  (M = MorphoFre), ---
  ConstructX,
  Prelude 
in {

oper 

  song_N = regGenN "chanson" feminine ;
  track_N = regN "morceau" ;
  album_N = regN "album" ;
  record_N = regGenN "disque" masculine ;
  cd_N = regN "cd" ;
  playlist_N = compN (regN "liste") ["de lecture"] ;
  artist_N = regGenN "artiste" masculine ;
  number_N = regN "numéro" ;
  rock_N = regN "rock" ;

  new_A = 
    prefA (compADeg (mkA "nouveau" "nouvelle" "nouveaux" "nouvellement")) ;

  add_V3 = 
    dirdirV3 (regV "ajouter") ;
  remove_V3 = 
    mkV3 (regV "supprimer") accusative genitive ;
  show_V3 = mkV3 (regV "montrer") dative accusative ;

  create_V2 = dirV2 (regV "créer") ;
  tell_V2 = dire_V2 ;
  play_V2 = dirV2 (regV "jouer") ;
  show_V2 = mkV2 (regV "montrer") to_Prep ;
  return_V2 = mkV2 (regV "retourner") to_Prep ;
  goto_V2 = mkV2 aller_V to_Prep ;
  record_V2 = dirV2 (regV "enregistrer") ;
  make_V2 = faire_V2 ;

  stop_V = regV "arrêter" ;

  back_Adv = mkAdv ["au retour"] ; ----

  what_IAdv = mkIAdv "quel" ; ----

  previous_Ord : Ord = 
    {s = \\ag => (regA "précédent").s ! M.Posit ! M.AF ag.g ag.n ; lock_Ord = <>} ;
  next_Ord : Ord = 
    {s = \\ag => (regA "prochain").s ! M.Posit ! M.AF ag.g ag.n ; lock_Ord = <>} ;
  please_PConj = mkPConj ["s'il vous plaît"] ;

  next_A = mkA "prochain" ;
  previous_A = mkA "précédent" ;
  show_V2Q = mkV2Q (mkV "montrer") dative ;
  tell_V2Q = mkV2Q (mkV "raconter") dative ;

  mainmenu_NP = 
    mkNP the_Quant
      (AdjCN (PositA (regA "principal")) (UseN (regN "menu"))) ;

  goback_VP = UseV (regV "retourner") ;
  shutup_VP = UseV (reflV taire_V2) ;
  pause_VP  = 
    ComplV2 faire_V2 
     (mkNP a_Quant (UseN (regN "pause"))) ;
  resume_VP = UseV (regV "résumer") ;

  whatever_Utt = mkUtt ["n'importe quoi"] ;

  typeWithGenre x genre =
---- CompoundCN genre x ;
    AdvCN x (PrepNP with_Prep 
        (mkNP genre)) ;

  name = regPN ;

  WhatName x = QuestIAdv how_IAdv (PredVP x (UseV (reflV (regV "appeler")))) ;

  past = <presentTense,anteriorAnt> ;

  imperative vp = variants { 
----      UttImpPol PPos (ImpVP vp) ; 
--      UttImpSg PPos (ImpVP vp) ;
--      UttQS (UseQCl TPres ASimul PPos (QuestCl (PredVP 
--         (UsePron youSg_Pron) (ComplVV can_VV vp)))) ;
      SyntaxFre.mkUtt (mkQS (QuestCl (PredVP 
         (UsePron youPol_Pron) (ComplVV can_VV vp)))) ;
      SyntaxFre.mkUtt (mkQS (mkQCl (PredVP (UsePron i_Pron)
         (ComplVV want_VV vp)))) ;
      UttVP vp
      } ;

  previous cn = 
    mkNP the_Quant 
      (AdjCN (PositA (regA "précédent")) cn) ;

  next = mkNP the_Quant next_Ord ;

  what_say = UttIAdv how_IAdv ;

  all_art = DefArt ;

  artist_Prep = variants {by8agent_Prep ; with_Prep} ;

  this cn = variants {
    mkNP this_Quant cn ;
    mkNP the_Quant (mkCN (regA "courant") cn)
    } ;

}
