-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude
concrete TestResourceRus of TestResource = StructuralRus ** open SyntaxRus, ParadigmsRus in {

flags 
  coding=utf8 ;
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = bolshoj ;
  Small = malenkij ;
  Old = staruj ;
  Young = molodoj ;

 Connection =  (noun2CommNounPhrase (doroga) )** {s2 = "из" ; c = genitive; s3 = "в"; c2=accusative} ;  
 American = ij_EndK_G_KH_Decl "американск" ; -- adj1Malenkij from Paradigms 
 Finnish = ij_EndK_G_KH_Decl "финск" ; -- adj1Malenkij from Paradigms 
  Married = adjInvar "замужем" ** {s2 = "за"; c = instructive} ; -- adjinvar from Paradigms
  Give = mkDitransVerb  (extVerb verbDavat active present) accusative dative; 
  Prefer = mkDitransVerb (extVerb verbPredpochitat active present) accusative dative ;
  Bar = bar ;
  Bottle = butyulka ;
  Wine = vino ;
  Drink = mkDirectVerb (extVerb verbPit active present ) ;
  Happy = schastlivyuj ;

  Man = muzhchina ;
  Woman = zhenchina ;
  Car = mashina ;
  House = dom ;
  Light = svet ;
  Walk = extVerb verbGulyat active present ;
  Run = extVerb verbBegat active present ;
  Love = mkDirectVerb (extVerb verbLubit active present ) ;
  Send = mkDirectVerb (extVerb verbOtpravlyat active present ) ;
  Wait = mkDirectVerb (extVerb verbZhdat active present );
  Say = extVerb verbGovorit active present ; --- works in present tense...
  Prove = extVerb verbDokazuvat active present ;
  SwitchOn = mkDirectVerb (extVerb verbVkluchat active present ) ;
  SwitchOff = mkDirectVerb (extVerb verbVukluchat active present ) ;

--  Mother = funGen (mama **{lock_N =<>}) ;
 -- Uncle = funGen (dyadya **{lock_N =<>});

  Always = vsegda ;
  Well = chorosho ;

  John = mkProperNameMasc "Иван" animate ;
  Mary = mkProperNameFem "Маш" animate ;
};
