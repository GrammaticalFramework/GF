--# -path=.:../scandinavian:../abstract:../../prelude

concrete TestResourceSwe of TestResource = RulesSwe, StructuralSwe ** 
  open Prelude, MorphoSwe, SyntaxSwe in {

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
  Man = extCommNounMasc man_1144 ;
  Bar = extCommNoun (sSak "bar") ;
  Bottle = extCommNoun (sApa "flask") ;
  Woman = extCommNoun (sApa "kvinn") ;
  Car = extCommNoun (sBil "bil") ;
  House = extCommNoun (sHus "hus") ;
  Light = extCommNoun (sHus "ljus") ;
  Wine = extCommNoun (sParti "vin") ;
  Walk = vNopart gå_1174 ;
  Run = vNopart (vFinna "spring" "sprang" "sprung") ;
  Drink = extTransVerb (vFinna "drick" "drack" "druck") [] ;
  Love = extTransVerb (vNopart (vTala "älsk")) [] ;
  Send = extTransVerb (vNopart (vTala "skick")) [] ;
  Wait = extTransVerb (vNopart (vTala "vänt")) "på" ;
  Give = extTransVerb (vNopart (vFinna "giv" "gav" "giv")) [] ** {s3 = "till"} ; --- ge
  Prefer = extTransVerb (vNopart (vFinna "föredrag" "föredrog" "föredrag")) [] ** 
           {s3 = "framför"} ; --- föredra

  Say = vNopart (vLeka "säg") ; --- works in present tense...
  Prove = vNopart (vTala "bevis") ;
  SwitchOn = mkDirectVerb (vFinna "sätt" "satte" "satt" ** {s1 = "på"}) ;
  SwitchOff = mkDirectVerb (vLeka "stäng" ** {s1 = "av"}) ;

  Mother = mkFun (extCommNoun mor_1) "till" ;
  Uncle = mkFun (extCommNounMasc farbror_8) "till" ;
  Connection = mkFun (extCommNoun (sVarelse "förbindelse")) "från" ** 
               {s3 = "till"} ;

  Always = advPre "alltid" ;
  Well = advPost "bra" ;

  John = mkProperName "Johan" (NUtr Masc) ;
  Mary = mkProperName "Maria" (NUtr NoMasc) ;

--- next
   AlreadyAdv = advPre "redan" ;
   NowAdv = advPre "nu" ;

   Paint = extTransVerb (vNopart (vTala "mål")) [] ;
   Green = aFin "grön" ;
   Beg = extTransVerb (mkVerbPart "be" "ber" "be" "bad" "bett" "bedd" []) [] ** {s3 = "att"} ;
   Promise = extTransVerb (vNopart (vTala "lov")) [] ** {s3 = "att"} ;
   Wonder = extTransVerb (vNopart (vTala "undr")) [] ;
   Ask = extTransVerb (vNopart (vTala "fråg")) [] ;
   Tell = extTransVerb (vNopart (vTala "berätt")) [] ;
   Look = extTransVerb (mkVerbPart "se" "ser" "se" "såg" "sett" "sedd" "ut") [] ;

   Try = extTransVerb (vNopart (vLeka "försök")) [] ** {s3 = "att"} ;
   Important = extAdjective (aFin "viktig") ** {s2 = "för"} ;
   Probable = extAdjective (aFin "sannolik") ;
   Easy = extAdjective (aAbstrakt "lätt") ** {s2 = "för"} ;
   Rain = extTransVerb (vNopart (vTala "regn")) [] ;


} ;
