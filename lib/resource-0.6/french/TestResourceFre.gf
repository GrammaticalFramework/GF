--# -path=.:../romance:../abstract:../../prelude

concrete TestResourceFre of TestResource = StructuralFre ** open Prelude, TypesFre, MorphoFre, SyntaxFre in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lin
  Big = mkAdjDegrReg "grand" adjPre ;
  Small = mkAdjDegrReg "petit" adjPre ;
  Old = mkAdjDegrLong (mkAdj "vieux" "vieux" "vieille") adjPre ;
  Young = mkAdjDegrLong (adjJeune "jeune") adjPre ;
  Man = mkCNomReg "homme" Masc ;
  Woman = mkCNomReg "femme" Fem ;
  Car = mkCNomReg "voiture" Fem ;
  Light = mkCNomReg "lumière" Fem ;
  House = mkCNomReg "maison" Fem ;
  Walk = verbPres (conj1aimer "marcher") ;
  Run = verbPres (conj3courir "courir") ;
  Send = mkTransVerbDir (verbPres (conj1envoyer "envoyer")) ;
  Love = mkTransVerbDir (verbPres (conj1aimer "aimer")) ;
  Wait = mkTransVerbDir (verbPres (conj3rendre "attendre")) ;
  Say = verbSent (verbPres (conj3dire "dire")) Ind Ind ;
  Prove = verbSent (verbPres (conj1aimer "démontrer")) Ind Ind ;
  SwitchOn = mkTransVerbDir (verbPres (conj1aimer "allumer")) ; 
  SwitchOff = mkTransVerbDir (verbPres (conj3peindre "éteindre")) ;
  Mother = funDe (mkCNomReg "mère" Fem) ;
  Uncle = funDe (mkCNomReg "oncle" Masc) ;

  Well = ss "bien" ;
  Always = ss "toujours" ;
  
  John = mkProperName "Jean" Masc ;
  Mary = mkProperName "Marie" Fem ;
}
