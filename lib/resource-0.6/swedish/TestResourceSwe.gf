--# -path=.:../abstract:../../prelude

concrete TestResourceSwe of TestResource = StructuralSwe ** open SyntaxSwe in {

flags startcat=Phr ; lexer=text ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = stor_25 ;
  Small = liten_1146 ;
  Old = gammal_16 ;
  Young = ung_29 ;
  American = extAdjective (aFin "amerikansk") ;
  Finnish = extAdjective (aFin "finsk") ;
  Happy = aFin "lycklig" ;
  Married = extAdjective (aAbstrakt "gift") ** {s2 = "med"} ;
  Man = extCommNoun Masc man_1144 ;
  Bar = extCommNoun NoMasc (sSak "bar") ;
  Bottle = extCommNoun NoMasc (sApa "flask") ;
  Woman = extCommNoun NoMasc (sApa "kvinn") ;
  Car = extCommNoun NoMasc (sBil "bil") ;
  House = extCommNoun NoMasc (sHus "hus") ;
  Light = extCommNoun NoMasc (sHus "ljus") ;
  Wine = extCommNoun NoMasc (sParti "vin") ;
  Walk = extVerb Act gå_1174 ;
  Run = extVerb Act (vFinna "spring" "sprang" "sprung") ;
  Drink = extTransVerb (vFinna "drick" "drack" "druck") [] ;
  Love = extTransVerb (vTala "älsk") [] ;
  Send = extTransVerb (vTala "skick") [] ;
  Wait = extTransVerb (vTala "vänt") "på" ;
  Give = extTransVerb (vFinna "giv" "gav" "giv") [] ** {s3 = "till"} ; --- ge
  Prefer = extTransVerb (vFinna "föredrag" "föredrog" "föredrag") [] ** 
           {s3 = "framför"} ; --- föredra

  Say = extVerb Act (vLeka "säg") ; --- works in present tense...
  Prove = extVerb Act (vTala "bevis") ;
  SwitchOn = mkDirectVerb (extVerbPart Act (vFinna "sätt" "satte" "satt") "på") ;
  SwitchOff = mkDirectVerb (extVerbPart Act (vLeka "stäng") "av") ;

  Mother = mkFun (extCommNoun NoMasc mor_1) "till" ;
  Uncle = mkFun (extCommNoun Masc farbror_8) "till" ;
  Connection = mkFun (extCommNoun NoMasc (sVarelse "förbindelse")) "från" ** 
               {s3 = "till"} ;

  Always = advPre "alltid" ;
  Well = advPost "bra" ;

  John = mkProperName "Johan" Utr Masc ;
  Mary = mkProperName "Maria" Utr NoMasc ;
} ;
