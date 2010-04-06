--# -path=.:present

concrete DisambPhrasebookEng of Phrasebook = PhrasebookEng - 
   [
    IMale, IFemale,
    YouFamMale, YouFamFemale, 
    YouPolMale, YouPolFemale, 
    LangNat, -- CitiNat,
    GExcuse, GExcusePol, 
    GSorry, GSorryPol, 
    GPleaseGive, GPleaseGivePol
   ] 
  ** open SyntaxEng, ParadigmsEng, Prelude in {
lin
  IMale = mkP i_Pron "(male)" ;
  IFemale = mkP i_Pron "(female)" ;
  YouFamMale = mkP youSg_Pron "(familiar,male)" ;
  YouFamFemale = mkP youSg_Pron "(familiar,female)" ;
  YouPolMale = mkP youPol_Pron "(polite,male)" ;
  YouPolFemale = mkP youPol_Pron "(polite,female)" ;

  LangNat nat = mkNP nat.lang (ParadigmsEng.mkAdv "(language)") ;
--  CitiNat nat = nat.prop ;

  GExcuse = fam "excuse me" ;
  GExcusePol = pol "excuse me" ;
  GSorry = fam "sorry" ;
  GSorryPol = pol "sorry" ;
  GPleaseGive = fam "please" ;
  GPleaseGivePol = pol "please" ;

oper
  fam : Str -> SS = \s -> postfixSS "(familiar)" (ss s) ;
  pol : Str -> SS = \s -> postfixSS "(polite)" (ss s) ;

  mkP : Pron -> Str -> {name : NP ; isPron : Bool ; poss : Det} = \p,s ->
    {name = mkNP (mkNP p) (ParadigmsEng.mkAdv s) ;
     isPron = False ; -- to show the disambiguation 
     poss = mkDet youSg_Pron 
    } ;
}
