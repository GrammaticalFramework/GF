--# -path=.:../romance:../abstract:../../prelude

concrete TestIta of TestAbs = 
  ResIta ** open Prelude, TypesIta, MorphoIta, SyntaxIta in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lin
  Big = mkAdjDegrTale "grande" adjPre ;
  Small = mkAdjDegrSolo "piccolo" adjPre ;
  Old = mkAdjDegrLong (mkAdj "vecchio" "vecchia" "vecchi" "vecchie") adjPre ;
  Young = mkAdjDegrTale "giovane" adjPre ;
  Man = mkCNom (numForms "uomo" "uomini") Masc ;
  Woman = mkCNom (nomRana "donna") Fem ;
  Car = mkCNom (nomRana "macchina") Fem ;
  Light = mkCNom (nomSale "luce") Fem ;
  House = mkCNom (nomRana "casa") Fem ;
  Walk = verbAmare "camminare" ;
  Run = verbCorrere "correre";
  Send = mkTransVerbDir (verbAmare "mandare") ;
  Love = mkTransVerbDir (verbAmare "amare") ;
  Wait = mkTransVerbDir (verbAmare "aspettare") ;
  Say = verbSent verbPresDire Ind Ind ;
  Prove = verbSent (verbAmare "dimostrare") Ind Ind ;
  SwitchOn = mkTransVerbDir (verbAmare "allumare") ; 
  SwitchOff = mkTransVerbDir verbPresSpegnere ;
  Mother = funDi (mkCNom (nomSale "madre") Fem) ;
  Uncle = funDi (mkCNom (nomVino "zio") Masc) ;

  Well = ss "bene" ;
  Always = ss "sempre" ;
  
  John = mkProperName "Giovanni" Masc ;
  Mary = mkProperName "Maria" Fem ;
}
