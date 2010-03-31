--# -path=.:present

concrete DisambPhrasebookEng of Phrasebook = PhrasebookEng - 
   [YouFam, YouPol, 
    GExcuse, GExcusePol, 
    GSorry, GSorryPol, 
    GPleaseGive, GPleaseGivePol,
    GWhatsYourName, GWhatsYourNamePol
   ] 
  ** open SyntaxEng, ParadigmsEng, Prelude in {
lin
  YouFam = mkNP (mkNP youSg_Pron) (ParadigmsEng.mkAdv "(familiar)") ;
  YouPol = mkNP (mkNP youPol_Pron) (ParadigmsEng.mkAdv "(polite)") ;

  GExcuse = fam "excuse me" ;
  GExcusePol = pol "excuse me" ;
  GSorry = fam "sorry" ;
  GSorryPol = pol "sorry" ;
  GPleaseGive = fam "please" ;
  GPleaseGivePol = pol "please" ;
  GWhatsYourName = ss "what's your name (familiar)" ;
  GWhatsYourNamePol = ss "what's your name (polite)" ;

oper
  fam : Str -> SS = \s -> postfixSS "(familiar)" (ss s) ;
  pol : Str -> SS = \s -> postfixSS "(polite)" (ss s) ;

}
