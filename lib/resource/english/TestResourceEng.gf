--# -path=.:../abstract:../../prelude

concrete TestResourceEng of TestResource = RulesEng, StructuralEng **
  open Prelude, SyntaxEng, ParadigmsEng in {

flags startcat=Phr ; lexer=textlit ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = adjDegrIrreg "big" "bigger" "biggest";
  Happy = adjDegrReg "happy" ;
  Small = adjDegrReg "small" ;
  Old = adjDegrReg "old" ;
  Young = adjDegrReg "young" ;
  American = regAdjective "American" ;
  Finnish = regAdjective "Finnish" ;
  Married = regAdjective "married" ** {s2 = "to"} ;
  Man = cnHum (mkNoun "man" "men" "man's" "men's") ;
  Woman = cnHum (mkNoun "woman" "women" "woman's" "women's") ;
  Car = cnNoHum (nounReg "car") ;
  House = cnNoHum (nounReg "house") ;
  Light = cnNoHum (nounReg "light") ;
  Bar = cnNoHum (nounReg "bar") ;
  Bottle = cnNoHum (nounReg "bottle") ;
  Wine = cnNoHum (nounReg "wine") ;
  Walk = verbNoPart (regVerbP3 "walk") ;
  Run = verbNoPart (mkVerb "run" "ran" "run") ;
  Say = verbNoPart (mkVerb "say" "said" "said") ;
  Prove = verbNoPart (verbP3e "prove") ; 
  Send = mkTransVerbDir (verbNoPart (mkVerb "send" "sent" "sent")) ;
  Love = mkTransVerbDir (verbNoPart (verbP3e "love")) ;
  Wait = mkTransVerb (verbNoPart (regVerbP3 "wait")) "for" ;
  Drink = mkTransVerbDir (verbNoPart (mkVerb "drink" "drank" "drunk")) ;
  Give = mkDitransVerb (verbNoPart (mkVerb "give" "gave" "given")) [] [] ;
  Prefer = mkDitransVerb 
    (verbNoPart (mkVerb "prefer" "preferred" "preferred")) [] "to" ;
  Mother = funOfReg "mother" human ;
  Uncle = funOfReg "uncle" human ;
  Connection = cnNoHum (nounReg "connection") ** {s2 = "from" ; s3 = "to"} ;

  Always = advPre "always" ;
  Well = advPost "well" ;

  SwitchOn  = mkTransVerbPart (verbP3s "switch") "on" ;
  SwitchOff = mkTransVerbPart (verbP3s "switch") "off" ;

  John = nameReg "John" Masc ;
  Mary = nameReg "Mary" Fem ;

--- next
   AlreadyAdv = advPre "already" ;
   NowAdv = advPre "now" ;

   Paint = mkTransVerbDir (verbNoPart (regVerbP3 "paint")) ;
   Green = adjDegrReg "green" ;
   Beg = mkTransVerbDir (verbNoPart (regVerbP3 "ask")) ** {s4 = "to"} ;
   Promise = mkTransVerbDir (verbNoPart (verbP3e "promise")) ** {s4 = "to"} ;
   Wonder = verbNoPart (regVerbP3 "wonder") ;
   Ask = mkTransVerbDir (verbNoPart (regVerbP3 "ask")) ;
   Tell = mkTransVerbDir (verbNoPart (mkVerb "tell" "told" "told")) ;
   Look = verbNoPart (regVerbP3 "look") ;

   Try = mkTransVerbDir (verbNoPart (verbP3y "tr")) ** {isAux = False} ;
   Important = regAdjective "important" ** {s2 = "for"} ;
   Probable = regAdjective "probable" ; ---- reg
   Easy = regAdjective "easy" ** {s2 = "for"} ;
   Rain = verbNoPart (regVerbP3 "rain") ;

} ;
