-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude

concrete TestSwe of TestAbs = ResSwe ** open Syntax in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = stor_25 ;
  Small = liten_1146 ;
  Old = gammal_16 ;
  Young = ung_29 ;
  Man = extCommNoun Masc man_1144 ;
  Woman = extCommNoun NoMasc (sApa "kvinn") ;
  Car = extCommNoun NoMasc (sBil "bil") ;
  House = extCommNoun NoMasc (sHus "hus") ;
  Light = extCommNoun NoMasc (sHus "ljus") ;
  Walk = extVerb Act gå_1174 ;
  Run = extVerb Act (vFinna "spring" "sprang" "sprung") ;
  Love = extTransVerb (vTala "älsk") [] ;
  Send = extTransVerb (vTala "skick") [] ;
  Wait = extTransVerb (vTala "vänt") "på" ;
  Say = extVerb Act (vLeka "säg") ; --- works in present tense...
  Prove = extVerb Act (vTala "bevis") ;
  SwitchOn = extTransVerb (vVända "tän") [] ;
  SwitchOff = extTransVerb (vLeka "släck") [] ;

  Mother = mkFun (extCommNoun NoMasc mor_1) "till" ;
  Uncle = mkFun (extCommNoun Masc farbror_8) "till" ;

  Always = advPre "alltid" ;
  Well = advPost "bra" ;

  John = mkProperName "Johan" Utr Masc ;
  Mary = mkProperName "Maria" Utr NoMasc ;
} ;
