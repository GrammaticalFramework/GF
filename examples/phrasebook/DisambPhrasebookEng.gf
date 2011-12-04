--# -path=.:present

concrete DisambPhrasebookEng of Phrasebook = PhrasebookEng - 
   [
    PGreetingMale, PGreetingFemale,
    IMale, IFemale,
    YouFamMale, YouFamFemale, 
    YouPolMale, YouPolFemale, 
    LangNat, -- CitiNat,
    GExcuse, GExcusePol, 
    GSorry, GSorryPol, 
    GPleaseGive, GPleaseGivePol,
    GNiceToMeetYou, -- GNiceToMeetYouPol,
    PYes, PYesToNo, ObjMass,
    MKnow,
    WeMale, WeFemale,
    YouPlurFamMale, YouPlurFamFemale,
    YouPlurPolMale, YouPlurPolFemale,
    TheyMale, TheyFemale,
    PImperativeFamPos, 
    PImperativeFamNeg, 
    PImperativePolPos, 
    PImperativePolNeg,
    PImperativePlurPos,
    PImperativePlurNeg 
   ] 
  ** open SyntaxEng, ParadigmsEng, IrregEng, Prelude in {
lin
  PGreetingMale g   = mkText (lin Text g) (lin Text (ss "(by male)")) ;
  PGreetingFemale g = mkText (lin Text g) (lin Text (ss "(by female)")) ;
  IMale = mkP i_Pron "(male)" ;
  IFemale = mkP i_Pron "(female)" ;
  WeMale = mkP we_Pron "(male)" ;
  WeFemale = mkP we_Pron "(female)" ;
  YouFamMale = mkP youSg_Pron "(singular,familiar,male)" ;
  YouFamFemale = mkP youSg_Pron "(singular,familiar,female)" ;
  YouPolMale = mkP youPol_Pron "(singular,polite,male)" ;
  YouPolFemale = mkP youPol_Pron "(singular,polite,female)" ;
  YouPlurFamMale = mkP youSg_Pron "(plural,familiar,male)" ;
  YouPlurFamFemale = mkP youSg_Pron "(plural,familiar,female)" ;
  YouPlurPolMale = mkP youPol_Pron "(plural,polite,male)" ;
  YouPlurPolFemale = mkP youPol_Pron "(plural,polite,female)" ;
  TheyMale = mkP they_Pron "(male)" ;
  TheyFemale = mkP they_Pron "(female)" ;

  MKnow = mkVV (partV know_V "how") ; ---

  LangNat nat = mkNP nat.lang (ParadigmsEng.mkAdv "(language)") ;
--  CitiNat nat = nat.prop ;

  GExcuse = fam "excuse me" ;
  GExcusePol = pol "excuse me" ;
  GSorry = fam "sorry" ;
  GSorryPol = pol "sorry" ;
  GPleaseGive = fam "please" ;
  GPleaseGivePol = pol "please" ;
  GNiceToMeetYou = fam "nice to meet you" ;
--  GNiceToMeetYouPol = pol "nice to meet you" ;

  PYes = mkPhrase (lin Utt (ss "yes (answer to positive question)")) ;
  PYesToNo = mkPhrase (lin Utt (ss "yes (answer to negative question)")) ;

  ObjMass x = mkNP (mkNP x) (ParadigmsEng.mkAdv "(a portion of)") ;

    PImperativeFamPos  v = phrasePlease (mkUtt (mkImp (addAdv ("singular,familiar") v))) ;
    PImperativeFamNeg  v = phrasePlease (mkUtt negativePol (mkImp (addAdv ("singular,familiar") v))) ;
    PImperativePolPos  v = phrasePlease (mkUtt politeImpForm (mkImp (addAdv ("singular,polite") v))) ;
    PImperativePolNeg  v = phrasePlease (mkUtt politeImpForm negativePol (mkImp (addAdv ("singular,polite") v))) ;
    PImperativePlurPos v = phrasePlease (mkUtt pluralImpForm (mkImp (addAdv ("plural,familiar") v))) ;
    PImperativePlurNeg v = phrasePlease (mkUtt pluralImpForm negativePol (mkImp (addAdv ("plural,familiar") v))) ;


oper
  fam : Str -> SS = \s -> postfixSS "(familiar)" (ss s) ;
  pol : Str -> SS = \s -> postfixSS "(polite)" (ss s) ;

  mkP : Pron -> Str -> {name : NP ; isPron : Bool ; poss : Quant} = \p,s ->
    {name = mkNP (mkNP p) (ParadigmsEng.mkAdv s) ;
     isPron = False ; -- to show the disambiguation 
     poss = SyntaxEng.mkQuant youSg_Pron 
    } ;

  addAdv : Str -> VP -> VP = \s,vp -> mkVP vp (ParadigmsEng.mkAdv ("("+s+")")) ;
}
