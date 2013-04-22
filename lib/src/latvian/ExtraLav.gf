--# -path=.:../abstract:../common:../prelude

concrete ExtraLav of ExtraLavAbs = CatLav ** open
  ParadigmsLav,
  ParadigmsPronounsLav,
  ResLav,
  Prelude
  in {

flags
  coding = utf8 ;

lin
  aiz_Prep = mkPrep "aiz" Gen Dat ;
  ap_Prep = mkPrep "ap" Acc Dat ;
  gar_Prep = mkPrep "gar" Acc Dat ;
  kopsh_Prep = mkPrep "kopš" Gen Dat ;
  liidz_Prep = mkPrep "līdz" Dat Dat ;
  pa_Prep = mkPrep "pa" Acc Dat ;
  par_Prep = mkPrep "par" Acc Dat ;
  paar_Prep = mkPrep "pār" Acc Dat ;
  pie_Prep = mkPrep "pie" Gen Dat ;
  pret_Prep = mkPrep "pret" Acc Dat ;
  
  i8fem_Pron = mkPronoun_I Fem ;
  we8fem_Pron = mkPronoun_We Fem ;

  youSg8fem_Pron = mkPronoun_You_Sg Fem ;
  youPol8fem_Pron = mkPronoun_You_Pol Fem ;
  youPl8fem_Pron = mkPronoun_You_Pl Fem ;

  they8fem_Pron = mkPronoun_They Fem ;
  it8fem_Pron = mkPronoun_It_Sg Fem ;

  {-empty_Det num def neg = \num,def,neg -> {
    s = \\_,_ => [] ;
    n = num ;
    d = def ;
    isNeg = neg
  } ;-}

  -- Zemāk esošās f-cijas nav ExtraLavAbs, tās ir abstract/Extra.gf

  GenNP np = {s = \\_,_,_ => np.s ! Gen ; d = Def ; isNeg = np.isNeg} ;

  --ICompAP ap = {s = \\g,n => "cik" ++ ap.s ! Indef ! g ! n ! Nom } ;

  IAdvAdv adv = {s = "cik" ++ adv.s} ;

  have_V3 = mkV3 (mkV "būt") nom_Prep dat_Prep Dat ;
}
