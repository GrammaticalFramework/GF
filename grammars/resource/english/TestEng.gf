concrete TestEng of TestAbs = ResEng ** open Syntax in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = mkAdjDegr "big" "bigger" "biggest";
  Small = adjDegrReg "small" ;
  Old = adjDegrReg "old" ;
  Young = adjDegrReg "young" ;
  American = simpleAdj "American" ;
  Finnish = simpleAdj "Finnish" ;
  Married = simpleAdj "married" ** {s2 = "to"} ;
  Man = cnHum (mkNoun "man" "men" "man's" "men's") ;
  Woman = cnHum (mkNoun "woman" "women" "woman's" "women's") ;
  Car = cnNoHum (nounReg "car") ;
  House = cnNoHum (nounReg "house") ;
  Light = cnNoHum (nounReg "light") ;
  Walk = verbNoPart (regVerbP3 "walk") ;
  Run = verbNoPart (mkVerb "run" "ran" "run") ;
  Say = verbNoPart (mkVerb "say" "said" "said") ;
  Prove = verbNoPart (regVerbP3 "prove") ; 
  Send = mkTransVerbDir (verbNoPart (mkVerb "send" "sent" "sent")) ;
  Love = mkTransVerbDir (verbNoPart (verbP3e "love")) ;
  Wait = mkTransVerb (verbNoPart (regVerbP3 "wait")) "for" ;
  Give = mkDitransVerb (verbNoPart (mkVerb "give" "gave" "given")) [] [] ;
  Prefer = mkDitransVerb 
    (verbNoPart (mkVerb "prefer" "preferred" "preferred")) [] "to" ;
  Mother = funOfReg "mother" Hum ;
  Uncle = funOfReg "uncle" Hum ;
  Connection = cnNoHum (nounReg "connection") ** {s2 = "from" ; s3 = "to"} ;

  Always = advPre "always" ;
  Well = advPost "well" ;

  SwitchOn  = mkTransVerbPart (verbP3s "switch") "on" ;
  SwitchOff = mkTransVerbPart (verbP3s "switch") "off" ;

  John = nameReg "John" ;
  Mary = nameReg "Mary" ;

} ;
