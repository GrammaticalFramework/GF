--# -path=.:../abstract:../common:../prelude

concrete ExtraLav of ExtraLavAbs = CatLav ** open 
  ParadigmsLav,
  ParadigmsPronounsLav,
  ResLav
  in {

flags
  coding = utf8 ;

lin
  to8uz_Prep = mkPrep "uz" Acc Dat ;

  i8fem_Pron = mkPronoun_I Fem ;
  we8fem_Pron = mkPronoun_We Fem ;

  youSg8fem_Pron = mkPronoun_You_Sg Fem ;
  youPol8fem_Pron = mkPronoun_You_Pol Fem ;
  youPl8fem_Pron = mkPronoun_You_Pl Fem ;

  they8fem_Pron = mkPronoun_They Fem ;
  it8fem_Pron = mkPronoun_It_Sg Fem ;
  
  -- Zemāk esošās f-cijas nav ExtraLavAbs, tās ir abstract/Extra.gf

  GenNP np = {s = \\_,_,_ => np.s ! Gen ; d = Def ; isNeg = np.isNeg} ;

  --ICompAP ap = {s = \\g,n => "cik" ++ ap.s ! Indef ! g ! n ! Nom } ;

  IAdvAdv adv = {s = "cik" ++ adv.s} ;

}
