-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude

concrete TestFin of TestAbs = ResFin ** open Prelude, Syntax in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

-- a random sample from the lexicon

lin
  Big = regAdjDegr (sTalo "iso") "isompaa" "isointa" ;
  Small = regAdjDegr (sSusi "pieni" "pienen" "pienen‰") "pienemp‰‰" "pienint‰" ;
  Old = regAdjDegr (sKukko "vanha" "vanhan" "vanhoja") "vanhempaa" "vanhinta" ;
  Young = regAdjDegr (sSusi "nuori" "nuoren" "nuorena") "nuorempaa" "nuorinta" ;

  Man = cnHum (mkNoun "mies" "miehen" "miehen‰" "miest‰" "mieheen" "miehin‰" 
                "miehiss‰" "miesten" "miehi‰" "miehiin") ;
  Woman = cnHum (sNainen "naista") ;
  Car = cnNoHum (sTalo "auto") ;
  House = cnNoHum (sTalo "talo") ;
  Light = cnNoHum (sTalo "valo") ;

  Walk = vJuosta "k‰vell‰" "k‰velen" ;
  Run = vJuosta "juosta" "juoksen" ;
  Say = vSanoa "sanoa" ;
  Prove = vPoistaa "todistaa" ;
  Send = mkTransVerbDir (vOttaa "l‰hett‰‰" "l‰het‰n") ;
  Love = mkTransVerbCase (vPoistaa "rakastaa") Part ;
  Wait = mkTransVerbCase (vOttaa "odottaa" "odotan") Part ;

  Mother = funGen (n2n (cnHum (sKukko "‰iti" "‰idin" "‰itej‰"))) ;
  Uncle = funGen (n2n (cnHum (sKukko "set‰" "sed‰n" "seti‰"))) ; --- eno!

  Always = ss "aina" ;
  Well = ss "hyvin" ;

  SwitchOn  = mkTransVerbDir (vOttaa "sytytt‰‰" "sytyt‰n") ;
  SwitchOff = mkTransVerbDir (vOttaa "sammuttaa" "sammutan") ;

  John = mkProperName (sKukko "Jussi" "Jussin" "Jusseja") ;
  Mary = mkProperName (sKukko "Mari" "Marin" "Mareja") ;

} ;
