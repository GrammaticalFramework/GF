concrete TestEng of TestAbs = ResEng ** open Syntax in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = mkAdjDegr "big" "bigger" "biggest";
  Small = adjDegrReg "small" ;
  Old = adjDegrReg "old" ;
  Young = adjDegrReg "young" ;
  Man = cnHum (mkNoun "man" "men" "man's" "men's") ;
  Woman = cnHum (mkNoun "woman" "women" "woman's" "women's") ;
  Car = cnNoHum (nounReg "car") ;
  House = cnNoHum (nounReg "house") ;
  Light = cnNoHum (nounReg "light") ;
  Walk = verbNoPart (regVerbP3 "walk") ;
  Run = verbNoPart (regVerbP3 "run") ;
  Say = verbNoPart (regVerbP3 "say") ;
  Prove = verbNoPart (regVerbP3 "prove") ; 
  Send = mkTransVerbDir (regVerbP3 "send") ;
  Love = mkTransVerbDir (regVerbP3 "love") ;
  Wait = mkTransVerb (regVerbP3 "wait") "for" ;
  Mother = funOfReg "mother" Hum ;
  Uncle = funOfReg "uncle" Hum ;

  Always = advPre "always" ;
  Well = advPost "well" ;

  SwitchOn  = mkTransVerbPart (verbP3s "switch") "on" ;
  SwitchOff = mkTransVerbPart (verbP3s "switch") "off" ;

  John = nameReg "John" ;
  Mary = nameReg "Mary" ;

} ;
