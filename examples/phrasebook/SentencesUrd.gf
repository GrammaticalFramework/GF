concrete SentencesUrd of Sentences =  NumeralUrd ** SentencesI - [sing,IFemale,YouFamFemale,YouPolFemale] with 
  (Syntax = SyntaxUrd),
  (Symbolic = SymbolicUrd),
  (Lexicon = LexiconUrd) **
  open 
  (P=ParadigmsUrd),
  ParamX,
  StringsUrdu,
  CommonHindustani in {
  lin IFemale = mkPerson (P.personalPN myN mjh "" myra myry myrE myry Sg Fem Pers1) ;
      YouFamFemale = mkPerson (P.personalPN tw tw tw tyra tyry tyrE tyry Sg Fem Pers2_Casual) ;
      YouPolFemale = mkPerson (P.personalPN ap ap ap apka apky apkE apky Pl Fem Pers2_Respect);

  } ;
