-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude
concrete TestResourceRus of TestResource = RulesRus, StructuralRus ** open SyntaxRus in {

flags 
  coding=utf8 ;
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = bolshoj ;
  Small = malenkij ;
  Old = staruj ;
  Young = molodoj ;

 Connection =  (noun2CommNounPhrase (doroga) )** {s2 = "из" ; c = Gen; s3 = "в"; c2=Acc} ;  
 American = ij_EndK_G_KH_Decl "американск" ; -- adj1Malenkij from Paradigms 
 Finnish = ij_EndK_G_KH_Decl "финск" ; -- adj1Malenkij from Paradigms 
  Married = adjInvar "замужем" ** {s2 = "за"; c = Inst} ; -- adjinvar from Paradigms
  Give = mkDitransVerb  verbDavat  Acc Dat; 
  Prefer = mkDitransVerb verbPredpochitat Acc Dat ;
  Bar = bar ;
  Bottle = butyulka ;
  Wine = vino ;
  Drink = mkDirectVerb verbPit ;
  Happy = schastlivyuj ;

  Man = muzhchina ;
  Woman = zhenchina ;
  Car = mashina ;
  House = dom ;
  Level = uroven ;
  Light = svet ;
  Walk =  verbGulyat ;
  Run = verbBegat ;
  Love = mkDirectVerb verbLubit ;
  Send = mkDirectVerb verbOtpravlyat ;
  Wait = mkDirectVerb verbZhdat ;
  Say = verbGovorit ; --- works in present tense...
  Prove = verbDokazuvat ;
  SwitchOn = mkDirectVerb verbVkluchat ;
  SwitchOff = mkDirectVerb verbVukluchat ;

  Mother = funGen mama ;
  Uncle = funGen dyadya ;

  Always = vsegda ;
  Well = chorosho ;

  John = mkProperNameMasc "Иван" Animate ;
  Mary = mkProperNameFem "Маш" Animate ;
};
