--# -path=.:../abstract:../../prelude

concrete TestResourceEng of TestResource = StructuralEng ** open SyntaxEng, ParadigmsEng in {

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
  Prove = verbNoPart (regVerbP3 "prove") ; 
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

  John = nameReg "John" ;
  Mary = nameReg "Mary" ;

} ;
