--# -path=.:../romance:../abstract:../../prelude

concrete TestResourceSpa of TestResource = 
  RulesSpa, StructuralSpa ** open Prelude, TypesSpa, MorphoSpa, SyntaxSpa in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lin
  Big = mkAdjDegrUtil "grande" "grandes"adjPre ;
  Small = mkAdjDegrSolo "pequeño" adjPre ;
  Old = mkAdjDegrSolo "viejo" adjPre ;
  Young = mkAdjDegrUtil "joven" "jovenes"adjPre ;
  Happy = mkAdjDegrUtil "feliz" "felices" adjPost ;
  American = mkAdjective (adjSolo "americano") adjPost ;
  Finnish = mkAdjective (adjUtil "finlandes" "finlandeses") adjPost ;
  Married =  mkAdjCompl (adjSolo "casado") adjPost {s2 = "con" ; c = accusative} ;
  Man = mkCNom (nomVino "hombre") Masc ;
  Woman = mkCNom (nomPilar "mujer") Fem ;
  Car = mkCNom (nomVino "coche") Masc ;
  Light = mkCNom (numForms "luz" "luces") Fem ;
  Level = mkCNom (nomPilar "nivel") Masc ;
  House = mkCNom (nomVino "casa") Fem ;
  Wine = mkCNom (nomVino "vino") Masc ;
  Bottle = mkCNom (nomVino "botella") Fem ;
  Bar = mkCNom (nomTram "bar") Masc ;
  Walk = verbPres (zurrar_3 "pasear") AHabere ;
----  Run = (verbPres (correre_41 "correre") AHabere) ;
  Send = mkTransVerbDir (verbPres (zurrar_3 "mandar") AHabere) ;
  Love = mkTransVerbDir (verbPres (zurrar_3 "amar") AHabere) ;
  Wait = mkTransVerbCas (verbPres (zurrar_3 "esperar") AHabere) dative ;
----  Drink = mkTransVerbDir (verbPres (bere_29 "bere") AHabere) ;
----  Give = mkDitransVerb  (verbPres (dare_17 "dare") AHabere)  [] dative [] accusative ;
  Prefer = mkDitransVerb (verbPres (zurrir_5 "preferir") AHabere) [] accusative [] dative ;
----  Say = verbSent (verbPres (dire_44 "dire") AHabere) Ind Ind ;
  Prove = verbSent  (verbPres (zurrar_3 "demonstrar") AHabere) Ind Ind ;
  SwitchOn = mkTransVerbDir  (verbPres (vender_4 "enciender") AHabere) ; ----
  SwitchOff = mkTransVerbDir  (verbPres (zurrar_3 "apagar") AHabere) ;
  Mother = funGen (mkCNom (nomVino "madre") Fem) ;
  Uncle = funGen (mkCNom (nomVino "zio") Masc) ;
  Connection = mkCNom (nomPilar "connexión") Fem ** 
               {s2 = [] ; c = CPrep P_de ; s3 = [] ; c3 = dative} ;

  Well = ss "bien" ;
  Always = ss "siempre" ;
  
  John = mkProperName "Juan" Masc ;
  Mary = mkProperName "Maria" Fem ;
}
