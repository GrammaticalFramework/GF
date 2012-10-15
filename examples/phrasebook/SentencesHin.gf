concrete SentencesHin of Sentences =  NumeralHin **  SentencesI - 
    [sing,IFemale,YouFamFemale,YouPolFemale,MMust,YouPlurFamFemale,YouPlurPolFemale,YouFamMale,mkGreeting] with 
  (Syntax = SyntaxHin),
  (Symbolic = SymbolicHin),
  (Lexicon = LexiconHin) **
  open 
  (P=ParadigmsHin),
  ParamX,
  CommonHindustani in {
  lin IFemale = mkPerson (P.personalPN myN mjh "" myra myry myrE myry Sg Fem Pers1) ;
      YouFamMale = mkPerson (P.personalPN tum tum tum tumhara tumhary tumharay tumhary Pl Masc Pers2_Familiar) ;
      YouFamFemale = mkPerson (P.personalPN tw tw tw tyra tyry tyrE tyry Sg Fem Pers2_Casual) ;
      YouPolFemale = mkPerson (P.personalPN ap ap ap apka apky apkE apky Pl Fem Pers2_Respect);
      YouPlurFamFemale = mkPerson (P.personalPN tum tum tum tumhara tumhary tumharay tumhary Pl Fem Pers2_Familiar) ;
      YouPlurPolFemale = mkPerson (P.personalPN ap ap ap apka apky apkE apky Pl Fem Pers2_Respect) ;



flags coding = utf8 ;

oper
  mkGreeting = ss ;

oper
  myN = "मैं" ;
  mjh = "मुझ" ;
  myra = "मेरा" ;
  myry = "मेरी" ;
  myrE = "मेरे" ;
  tw = "तू" ;
  tum = "तुम" ;
  tyra = "तेरा" ;
  tyry = "तेरी" ;
  tyrE = "तेरे" ;
  tumhara = "तुम्हारा" ;  
  tumhary = "तुम्हारी" ; 
  tumharay = "तुम्हारे" ; 
  ap = "आप" ;
  apka = ["आप का"] ;
  apky = ["आप की"] ;
  apkE = ["आप के"] ;
  } ;
