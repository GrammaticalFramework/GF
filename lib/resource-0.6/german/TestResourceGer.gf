-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude

concrete TestResourceGer of TestResource = StructuralGer ** open SyntaxGer in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = adjCompReg3 "gross" "grösser" "grösst";
  Small = adjCompReg "klein" ;
  Happy = adjCompReg "glücklich" ;
  Old = adjCompReg3 "alt" "älter" "ältest";
  Young = adjCompReg3 "jung" "jünger" "jüngst";
  American = adjReg "Amerikanisch" ;
  Finnish = adjReg "Finnisch" ;
  Married = adjReg "verheiratet" ** {s2 = "mit" ; c = Dat} ;
  Man = declN2u "Mann" "Männer" ;
  Woman = declN1 "Frau" ;
  Bottle = declN1e "Flasche" ;
  Wine = declN2 "Wein" ;
  Car = declNs "Auto" ;
  House = declN3uS "Haus" "Häuser" ;
  Light = declN3 "Licht" ;
  Bar = declNs "Bar" ;
  Walk = mkVerbSimple (verbLaufen "gehen" "geht" "gegangen") ;
  Run = mkVerbSimple (verbLaufen "laufen" "läuft" "gelaufen") ; 
  Say = mkVerbSimple (regVerb "sagen") ;
  Prove = mkVerbSimple (regVerb "beweisen") ;
  Send = mkTransVerb (mkVerbSimple (verbLaufen "senden" "sendet" "gesandt")) [] Acc;
  Drink = transDir (mkVerbSimple (verbLaufen "trinken" "trinkt" "getrunken")) ;
  Love = mkTransVerb (mkVerbSimple (regVerb "lieben")) [] Acc ;
  Wait = mkTransVerb (mkVerbSimple (verbWarten "warten")) "auf" Acc ;
  Give = mkDitransVerb 
           (mkVerbSimple (verbLaufen "geben" "gibt" "gegeben")) [] Dat [] Acc ;
  Prefer = mkDitransVerb 
           (mkVerb (verbLaufen "ziehen" "zieht" "gezogen") "vor") [] Acc "vor" Dat ;
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

