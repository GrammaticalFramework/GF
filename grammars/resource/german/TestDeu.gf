concrete TestDeu of TestAbs = ResDeu ** open Syntax in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = adjCompReg3 "gross" "grösser" "grösst";
  Small = adjCompReg "klein" ;
  Old = adjCompReg3 "alt" "älter" "ältest";
  Young = adjCompReg3 "jung" "jünger" "jüngst";
  Man = declN2u "Mann" "Männer" ;
  Woman = declN1 "Frau" ;
  Car = declNs "Auto" ;
  House = declN3uS "Haus" "Häuser" ;
  Light = declN3 "Licht" ;
  Walk = mkVerbSimple (verbLaufen "gehen" "geht" "gegangen") ;
  Run = mkVerbSimple (verbLaufen "laufen" "läuft" "gelaufen") ; 
  Say = mkVerbSimple (regVerb "sagen") ;
  Prove = mkVerbSimple (regVerb "beweisen") ;
  Send = mkTransVerb (mkVerbSimple (verbLaufen "senden" "sendet" "gesandt")) [] Acc;
  Love = mkTransVerb (mkVerbSimple (regVerb "lieben")) [] Acc ;
  Wait =  mkTransVerb (mkVerbSimple (verbWarten "warten")) "auf" Acc ;
  Mother = mkFunC (n2n (declN2uF "Mutter" "Mütter")) "von" Dat ;
  Uncle = mkFunC (n2n (declN2i "Onkel")) "von" Dat ;
  Connection = mkFunC (n2n (declN1 "Verbindung")) "von" Dat ** 
                                     {s3 = "nach" ; c2 = Dat} ;

  Always = mkAdverb "immer" ;
  Well = mkAdverb "gut" ;

  SwitchOn  = mkTransVerb (mkVerb (verbWarten "schalten") "auf") [] Acc  ;
  SwitchOff = mkTransVerb (mkVerb (verbWarten "schalten") "aus") [] Acc  ;

  John = mkProperName "Johann" ;
  Mary = mkProperName "Maria" ;

} ;

