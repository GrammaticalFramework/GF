instance ParamSammieSpa of ParamSammie = open 
  GrammarSpa,
  ExtraSpa,
  SymbolSpa,
  IrregSpa,
  (B = BeschSpa),
  ParadigmsSpa,
  (M = MorphoSpa), ---
  ConstructX,
  Prelude 
in {

oper 

  song_N = femN (regN "canción") ; 
  track_N = regN "pista" ;
  album_N = regN "album" ;
  record_N = regN "disco" ;
  cd_N = regN "cd" ;
  playlist_N = compN (regN "lista") ["de favoritos"] ; --- canciones, pistas
  artist_N = mascN (regN "artista") ; --- fem
  number_N = regN "número" ;
  rock_N = regN "rock" ;

  new_A = 
    prefA (regA "nuevo") ;

  add_V3 = 
    dirdirV3 (regV "agregar") ;
  remove_V3 = 
    mkV3 (regV "suprimir") accusative genitive ;
  show_V3 = mkV3 (regAltV "mostrar" "muestro") dative accusative ;

  create_V2 = dirV2 (regV "crear") ;
  tell_V2 = dirV2 (decir_V) ;
  play_V2 = dirV2 (regV "reproducir") ; --- tocar
  show_V2 = mkV2 (regAltV "mostrar" "muestro") to_Prep ;
  return_V2 = mkV2 volver_V to_Prep ;
  goto_V2 = mkV2 ir_V to_Prep ;
  record_V2 = dirV2 (regV "registrar") ;
  make_V2 = dirV2 (hacer_V) ;

  stop_V = regV "parar" ; --- detener

  back_Adv = mkAdv ["pista previa"] ; ----

---  what_IAdv = mkIAdv "cual" ; ----

  previous_Ord = 
    {s = \\ag => (regA "previo").s ! M.Posit ! M.AF ag.g ag.n ; lock_Ord = <>} ;
  next_Ord = 
    {s = \\ag => (regA "siguente").s ! M.Posit ! M.AF ag.g ag.n ; lock_Ord = <>} ;
  please_PConj = mkPConj ["por favor"] ;

  mainmenu_NP = 
    DetCN (DetSg (SgQuant DefArt) NoOrd) 
      (AdjCN (PositA (regA "principal")) (UseN (regN "menú"))) ;

  goback_VP = UseV (regV "volver") ;
  shutup_VP = UseV (reflV (dirV2 (regV "callar"))) ; ---- silencio
  pause_VP  = 
    ComplV2 (dirV2 (hacer_V))
      (DetCN (DetSg (SgQuant IndefArt) NoOrd) (UseN (regN "pausa"))) ; ---pausar
  resume_VP = UseV (regV "continuar") ; --- reproducir

  whatever_Utt = mkUtt ["no importa cual"] ; --- cualquiera

  typeWithGenre x genre =
---- CompoundCN genre x ;
    AdvCN x (PrepNP genitive 
        (DetCN (DetSg MassDet NoOrd) genre)) ;

  name = regPN ;

  WhatName x = 
    QuestIAdv how_IAdv (PredVP x (UseV (reflV (regV "llamar")))) ;

  past = <TPres,AAnter> ;

  imperative vp = variants { 
--      UttImpPol PPos (ImpVP vp) ;
      UttImpSg PPos (ImpVP vp) 
--      UttQS (UseQCl TPres ASimul PPos (QuestCl (PredVP 
--         (UsePron youSg_Pron) (ComplVV can_VV vp)))) ;
--      UttQS (UseQCl TPres ASimul PPos (QuestCl (PredVP 
--         (UsePron youPol_Pron) (ComplVV can_VV vp)))) ;
--      UttS (UseCl TPres ASimul PPos (PredVP (UsePron i_Pron)
--         (ComplVV want_VV vp))) ;
--      UttVP vp
      } ;

  previous cn = 
    DetCN (DetSg (SgQuant DefArt) NoOrd) 
      (AdjCN (PositA (regA "previo")) cn) ;

  next = DetCN (DetSg (SgQuant DefArt) next_Ord) ;

  what_say = UttIAdv how_IAdv ;

  all_art = DefArt ;

  artist_Prep = variants {by8agent_Prep ; genitive} ;

  this cn = variants {
    DetCN (DetSg (SgQuant this_Quant) NoOrd) cn ;
    DetCN (DetSg (SgQuant DefArt) NoOrd) 
      (AdjCN (PositA (regA "actual")) cn)
    } ;

}
