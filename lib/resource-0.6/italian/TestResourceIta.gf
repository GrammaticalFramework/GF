--# -path=.:../romance:../abstract:../../prelude

concrete TestResourceIta of TestResource = 
  StructuralIta ** open Prelude, TypesIta, MorphoIta, SyntaxIta in {

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
  Walk = verbAmare "camminare" ;
  Run = verbCorrere "correre" "corso" ;
  Send = mkTransVerbDir (verbAmare "mandare") ;
  Love = mkTransVerbDir (verbAmare "amare") ;
  Wait = mkTransVerbCas (verbAmare "aspettare") dative ;
  Drink = mkTransVerbDir (mkVerbPres 
           "bev" "beve" "bev" "bevete" "bevono" "beva" "bevi" "bere" "bevuto") ;
  Give = mkDitransVerb (mkVerbPres 
           "d" "da" "d" "date" "danno" "dia" "dà" "dare" "dato") 
           [] dative [] accusative ;
  Prefer = mkDitransVerb (verbFinire "preferire") [] accusative [] dative ;
  Say = verbSent verbPresDire Ind Ind ;
  Prove = verbSent (verbAmare "dimostrare") Ind Ind ;
  SwitchOn = mkTransVerbDir (verbAmare "allumare") ; 
  SwitchOff = mkTransVerbDir verbPresSpegnere ;
  Mother = funGen (mkCNom (nomSale "madre") Fem) ;
  Uncle = funGen (mkCNom (nomVino "zio") Masc) ;
  Connection = mkCNom (nomSale "connessione") Fem ** 
               {s2 = [] ; c = CPrep P_da ; s3 = [] ; c3 = dative} ;

  Well = ss "bene" ;
  Always = ss "sempre" ;
  
  John = mkProperName "Giovanni" Masc ;
  Mary = mkProperName "Maria" Fem ;
}
