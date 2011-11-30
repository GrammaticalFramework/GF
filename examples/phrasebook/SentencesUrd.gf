concrete SentencesUrd of Sentences =  NumeralUrd **  SentencesI - [sing,IFemale,YouFamFemale,YouPolFemale,MMust] with 
  (Syntax = SyntaxUrd),
  (Symbolic = SymbolicUrd),
  (Lexicon = LexiconUrd) **
  open 
  (P=ParadigmsUrd),
  ParamX,
  CommonHindustani in {
  lin IFemale = mkPerson (P.personalPN myN mjh "" myra myry myrE myry Sg Fem Pers1) ;
      YouFamFemale = mkPerson (P.personalPN tw tw tw tyra tyry tyrE tyry Sg Fem Pers2_Casual) ;
      YouPolFemale = mkPerson (P.personalPN ap ap ap apka apky apkE apky Pl Fem Pers2_Respect);


flags coding = utf8 ;

oper
  myN = "میں" ;
  mjh = "مجھ" ;
  myra = "میرا" ;
  myry = "میری" ;
  myrE = "میرے" ;
  tw = "تو" ;
  tyra = "تیرا" ;
  tyry = "تیری" ;
  tyrE = "تیرے" ;
  ap = "آپ" ;
  apka = ["آپ كا"] ;
  apky = ["آپ كی"] ;
  apkE = ["آپ كے"] ;
  } ;
