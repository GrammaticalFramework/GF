--# -path=.:../scandinavian:../abstract:../../prelude

concrete TestResourceDan of TestResource = RulesDan, StructuralDan ** 
  open Prelude, MorphoDan, SyntaxDan in {

flags startcat=Phr ; lexer=text ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = mkAdjective "stor" "stort" "store" "større" "størst" ;
  Small = mkAdjective "lille" "lille" "små" "mindre" "mindst" ;
  Old = mkAdjective "gammel" "gammelt" "gamle" "ældre" "ældst" ;
  Young = mkAdjective "ung" "ungt" "unge" "yngre" "yngst" ;
  American = extAdjective (aRod "amerikansk") ;
  Finnish = extAdjective (aRod "finsk") ;
  Happy = aRod "lykkelig" ;
  Married = extAdjective (aAbstrakt "gift") ** {s2 = "med"} ;
  Man = extCommNoun (mkSubstantive "mand" "manden" "mænd" "mænden" ** {h1 = Utr}) ;
  Bar = extCommNoun (nBil "bar") ; ---- ?
  Bottle = extCommNoun (nUge "flaske") ;
  Woman = extCommNoun (nUge "kvinde") ;
  Car = extCommNoun (nBil "bil") ;
  House = extCommNoun (nHus "hus") ;
  Light = extCommNoun (nHus "lys") ;
  Wine = extCommNoun (nHus "vin") ; ---- ?
  Walk = mkVerb "gå" "går" "gås" "gik" "gået" "gå" ** {s1 = []} ; 
  Run = mkVerb "springe" "springer" "springes" "sprang" "sprunget" "spring" ** {s1 = []} ; 
  Drink = extTransVerb (mkVerb "drikke" "drikker" "drikkes" "drak" "drukket" "drikk" ** {s1 = []}) [] ;
  Love = extTransVerb (vNopart (vHusk "ælsk")) [] ;
  Send = extTransVerb (vNopart (vSpis "send")) [] ; ---- ?
  Wait = extTransVerb (vNopart (vSpis "vent")) "på" ;
  Give = extTransVerb (vNopart (mkVerb "give" "giver" "gives" "gav" "givet" "giv")) [] ** {s3 = "til"} ;
  Prefer = extTransVerb (vNopart (vSpis "foretrækk")) [] ** {s3 = "for"} ;

  Say = vNopart (mkVerb "sige" "siger" "siges" "sagde" "sagt" "sig") ;
  Prove = vNopart (vSpis "bevis") ;
  SwitchOn = mkDirectVerb (vHusk "lukk" ** {s1 = "op"}) ;
  SwitchOff = mkDirectVerb (vHusk "slukk" ** {s1 = []}) ;

  Mother = mkFun (extCommNoun (mkSubstantive "moder" "moderen" "mødre"
  "mødrene" ** {h1 = Utr})) "til" ; ---- ?
  Uncle = mkFun (extCommNoun (mkSubstantive "onkel" "onkelen" "onkler" "onklene" ** {h1 = Utr})) "til" ; ---- ? 
  Connection = mkFun (extCommNoun (nUge "forbindelse")) "fra" ** {s3 = "til"} ;

  Always = advPre "altid" ;
  Well = advPost "godt" ;

  John = mkProperName "Johan" NUtr ;
  Mary = mkProperName "Maria" NUtr ;

--- next
   AlreadyAdv = advPre "allerede" ;
   NowAdv = advPre "nu" ;

   Paint = extTransVerb (vNopart (vHusk "mål")) [] ;
   Green = mkAdjective "grøn" "grønt" "grøne" "grønnere" "grønnest" ;

   Beg = extTransVerb (mkVerb "bede" "beder" "bedes" "bad" "bedt" "bed") [] ** {s3 = "at"} ;
   Promise  = extTransVerb (vNopart (vSpis "lov")) [] ** {isAux = False} ;
   Promise2 = extTransVerb (vNopart (vSpis "lov")) [] ** {s3 = "att"} ;
   Wonder = extTransVerb (vNopart (vHusk "undr")) [] ;
   Ask = extTransVerb (mkVerb "spørge" "spørger""spørges""spurgte""spurgt""spørg") [] ;
   Tell = extTransVerb (mkVerb "fortælle" "fortæller" "fortælles"
   "fortalte" "fortalt" "fortæll") [] ;
   Look = extTransVerb (mkVerb "se" "ser" "ses" "så" "set" "sedd") []
   ; ---- ut

} ;
