-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude
concrete TestResourceRus of TestResource = StructuralRus ** open SyntaxRus in {

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
  Give = mkDitransVerb  (extVerb verbDavat Act Present) Acc Dat; 
  Prefer = mkDitransVerb (extVerb verbPredpochitat Act Present) Acc Dat ;
  Bar = bar ;
  Bottle = butyulka ;
  Wine = vino ;
  Drink = mkDirectVerb (extVerb verbPit Act Present ) ;
  Happy = schastlivyuj ;

  Man = muzhchina ;
  Woman = zhenchina ;
  Car = mashina ;
  House = dom ;
  Light = svet ;
  Walk = extVerb verbGulyat Act Present ;
  Run = extVerb verbBegat Act Present ;
  Love = mkDirectVerb (extVerb verbLubit Act Present ) ;
  Send = mkDirectVerb (extVerb verbOtpravlyat Act Present ) ;
  Wait = mkDirectVerb (extVerb verbZhdat Act Present );
  Say = extVerb verbGovorit Act Present ; --- works in present tense...
  Prove = extVerb verbDokazuvat Act Present ;
  SwitchOn = mkDirectVerb (extVerb verbVkluchat Act Present ) ;
  SwitchOff = mkDirectVerb (extVerb verbVukluchat Act Present ) ;

  Mother = funGen mama ;
  Uncle = funGen dyadya ;

  Always = vsegda ;
  Well = chorosho ;

  John = mkProperNameMasc "Иван" Animate ;
  Mary = mkProperNameFem "Маш" Animate ;
};
