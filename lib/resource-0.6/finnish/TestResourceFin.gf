-- use this path to read the grammar from the same directory
--# -path=.:../abstract:../../prelude

concrete TestResourceFin of TestResource = 
  StructuralFin ** open Prelude, SyntaxFin in {

flags startcat=Phr ; lexer=unglue ; unlexer=glue ;

-- a random sample from the lexicon

lin
  Big = regAdjDegr (sTalo "iso") "isompaa" "isointa" ;
  Small = regAdjDegr (sSusi "pieni" "pienen" "pienen‰") "pienemp‰‰" "pienint‰" ;
  Old = regAdjDegr (sKukko "vanha" "vanhan" "vanhoja") "vanhempaa" "vanhinta" ;
  Young = regAdjDegr (sSusi "nuori" "nuoren" "nuorena") "nuorempaa" "nuorinta" ;
  American = noun2adj (sNainen "amerikkalaista") ;
  Finnish = noun2adj (sNainen "suomalaista") ;
  Happy = regAdjDegr (sNainen "onnellista") "onnellisempaa" "onnellisinta" ;

  Married = sKukko "vihitty" "vihityn" "vihittyj‰" ** {c = NPCase Illat} ; 
            --- naimisissa !

  Man = cnHum (mkNoun "mies" "miehen" "miehen‰" "miest‰" "mieheen" "miehin‰" 
                "miehiss‰" "miesten" "miehi‰" "miehiin") ;
  Woman = cnHum (sNainen "naista") ;
  Bottle = cnNoHum (sTalo "pullo") ;
  Car = cnNoHum (sTalo "auto") ;
  House = cnNoHum (sTalo "talo") ;
  Bar = cnNoHum (sBaari "baaria") ;
  Wine = cnNoHum (sBaari "viini‰") ;
  Light = cnNoHum (sTalo "valo") ;

  Walk = vJuosta "k‰vell‰" "k‰velen" ;
  Run = vJuosta "juosta" "juoksen" ;
  Say = vSanoa "sanoa" ;
  Prove = vPoistaa "todistaa" ;
  Send = mkTransVerbDir (vOttaa "l‰hett‰‰" "l‰het‰n") ;
  Drink = mkTransVerbDir (vJuoda "juoda") ;
  Love = mkTransVerbCase (vPoistaa "rakastaa") Part ;
  Wait = mkTransVerbCase (vOttaa "odottaa" "odotan") Part ;
  Give = mkTransVerbDir (vOttaa "antaa" "annan") ** 
         {s5 = [] ; s6 = [] ; c2 = CCase Allat} ;
  Prefer = mkTransVerbDir (vOttaa "asettaa" "asetan") ** 
           {s5 = [] ; s6 = "edelle" ; c2 = CCase Gen} ; --- pit‰‰ paremp(a/i)na

  Mother = funGen (n2n (cnHum (sKukko "‰iti" "‰idin" "‰itej‰"))) ;
  Uncle = funGen (n2n (cnHum (sKukko "set‰" "sed‰n" "seti‰"))) ; --- eno!
  Connection = n2n (cnNoHum (sRakkaus "yhteys")) **
               {c = NPCase Elat ; c2 = NPCase Illat} ; --- Tampereelle !

  Always = ss "aina" ;
  Well = ss "hyvin" ;

  SwitchOn  = mkTransVerbDir (vOttaa "sytytt‰‰" "sytyt‰n") ;
  SwitchOff = mkTransVerbDir (vOttaa "sammuttaa" "sammutan") ;

  John = mkProperName (sKukko "Jussi" "Jussin" "Jusseja") ;
  Mary = mkProperName (sKukko "Mari" "Marin" "Mareja") ;

} ;
