-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude

concrete TestRus of TestAbs = ResRus ** open Syntax in {

flags 
  coding=utf8 ;
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = bolshoj ;
  Small = malenkij ;
  Old = staruj ;
  Young = molodoj ;
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
