--# -path=.:../romance:../abstract:../../prelude

concrete TestResourceIta of TestResource = 
  RulesIta, StructuralIta ** open Prelude, TypesIta, MorphoIta, SyntaxIta in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lin
  Big = mkAdjDegrTale "grande" adjPre ;
  Small = mkAdjDegrSolo "piccolo" adjPre ;
  Old = mkAdjDegrLong (mkAdj "vecchio" "vecchia" "vecchi" "vecchie" "vecchiamente") 
          adjPre ;
  Young = mkAdjDegrTale "giovane" adjPre ;
  Happy = mkAdjDegrTale "felice" adjPost ;
  American = mkAdjective (adjSolo "americano") adjPost ;
  Finnish = mkAdjective (adjTale "finlandese") adjPost ;
  Married =  mkAdjCompl (adjSolo "sposato") adjPost {s2 = [] ; c = dative} ;
  Man = mkCNom (numForms "uomo" "uomini") Masc ;
  Woman = mkCNom (nomRana "donna") Fem ;
  Car = mkCNom (nomRana "macchina") Fem ;
  Light = mkCNom (nomSale "luce") Fem ;
  House = mkCNom (nomRana "casa") Fem ;
  Wine = mkCNom (nomVino "vino") Masc ;
  Bottle = mkCNom (nomRana "bottiglia") Fem ;
  Bar = mkCNom (nomTram "bar") Masc ;
  Walk = verbPres (amare_7 "camminare") AHabere ;
  Run = (verbPres (correre_41 "correre") AHabere) ;
  Send = mkTransVerbDir (verbPres (amare_7 "mandare") AHabere) ;
  Love = mkTransVerbDir (verbPres (amare_7 "amare") AHabere) ;
  Wait = mkTransVerbCas (verbPres (amare_7 "aspettare") AHabere) dative ;
  Drink = mkTransVerbDir (verbPres (bere_29 "bere") AHabere) ;
  Give = mkDitransVerb  (verbPres (dare_17 "dare") AHabere)  [] dative [] accusative ;
  Prefer = mkDitransVerb (verbPres (finire_103 "preferire") AHabere) [] accusative [] dative ;
  Say = verbSent (verbPres (dire_44 "dire") AHabere) Ind Ind ;
  Prove = verbSent  (verbPres (amare_7 "dimostrare") AHabere) Ind Ind ;
  SwitchOn = mkTransVerbDir  (verbPres (amare_7 "allumare") AHabere) ; 
  SwitchOff = mkTransVerbDir  (verbPres (spegnere_89 "spegnere") AHabere) ;
  Mother = funGen (mkCNom (nomSale "madre") Fem) ;
  Uncle = funGen (mkCNom (nomVino "zio") Masc) ;
  Connection = mkCNom (nomSale "connessione") Fem ** 
               {s2 = [] ; c = CPrep P_da ; s3 = [] ; c3 = dative} ;

  Well = ss "bene" ;
  Always = ss "sempre" ;
  
  John = mkProperName "Giovanni" Masc ;
  Mary = mkProperName "Maria" Fem ;
}
