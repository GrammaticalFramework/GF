--# -path=.:alltenses

concrete EngDescr of Eng = IrregEng ** open (R = ResEng) in {

lincat 
  Display, Word, Form = Str ;

lin
  DAll w = w ++ ":" ++ "all forms" ;

  DForm w f = w ++ ":" ++ f ;

-- names of forms displayed

  VInf = "Infinitive" ;
  VPres = "Present" ; 
  VPast = "Past" ;
  VPPart = "Past Participle" ;
  VPresPart = "Present Participle" ;

  WVerb v = v.s ! R.VInf ;  -- the dictionary form shown in word description

}
