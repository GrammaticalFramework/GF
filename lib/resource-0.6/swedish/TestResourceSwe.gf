--# -path=.:../abstract:../../prelude

concrete TestResourceSwe of TestResource = StructuralSwe ** open SyntaxSwe, ParadigmsSwe in {

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
  Man = extCommNoun masculine man_1144 ;
  Bar = extCommNoun nonmasculine (sSak "bar") ;
  Bottle = extCommNoun nonmasculine (sApa "flask") ;
  Woman = extCommNoun nonmasculine (sApa "kvinn") ;
  Car = extCommNoun nonmasculine (sBil "bil") ;
  House = extCommNoun nonmasculine (sHus "hus") ;
  Light = extCommNoun nonmasculine (sHus "ljus") ;
  Wine = extCommNoun nonmasculine (sParti "vin") ;
  Walk = extVerb active gå_1174 ;
  Run = extVerb active (vFinna "spring" "sprang" "sprung") ;
  Drink = extTransVerb (vFinna "drick" "drack" "druck") [] ;
  Love = extTransVerb (vTala "älsk") [] ;
  Send = extTransVerb (vTala "skick") [] ;
  Wait = extTransVerb (vTala "vänt") "på" ;
  Give = extTransVerb (vFinna "giv" "gav" "giv") [] ** {s3 = "till"} ; --- ge
  Prefer = extTransVerb (vFinna "föredrag" "föredrog" "föredrag") [] ** 
           {s3 = "framför"} ; --- föredra

  Say = extVerb active (vLeka "säg") ; --- works in present tense...
  Prove = extVerb active (vTala "bevis") ;
  SwitchOn = mkDirectVerb (extVerbPart active (vFinna "sätt" "satte" "satt") "på") ;
  SwitchOff = mkDirectVerb (extVerbPart active (vLeka "stäng") "av") ;

  Mother = mkFun (extCommNoun nonmasculine mor_1**{lock_N = <>}) "till" ;
  Uncle = mkFun (extCommNoun masculine farbror_8 **{lock_N = <>}) "till" ;
  Connection = mkFun (extCommNoun nonmasculine (sVarelse "förbindelse")**{lock_N = <>}) "från" ** 
               {s3 = "till"} ;

  Always = advPre "alltid" ;
  Well = advPost "bra" ;

  John = mkProperName "Johan" utrum masculine ;
  Mary = mkProperName "Maria" utrum nonmasculine ;
} ;
