--# -path=.:../romance:../abstract:../../prelude

concrete TestResourceFre of TestResource = RulesFre, StructuralFre ** 
  open Prelude, TypesFre, MorphoFre, SyntaxFre in {

flags startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lin
  Big = mkAdjDegrReg "grand" adjPre ;
  American = mkAdjective (adjGrand "américain") adjPost ;
  Finnish = mkAdjective (adjGrand "finlandais") adjPost ;
  Married = mkAdjCompl (adjJoli "marié") adjPost (complementCas dative) ;
  Small = mkAdjDegrReg "petit" adjPre ;
  Old = mkAdjDegrLong (mkAdj "vieux" "vieux" "vieille" "vieillement") adjPre ;
  Young = mkAdjDegrLong (adjJeune "jeune") adjPre ;
  Happy = mkAdjDegrLong (adjHeureux "heureux") adjPre ;
  Wine = mkCNomReg "vin" Masc ;
  Bar = mkCNomReg "bar" Masc ;
  Man = mkCNomReg "homme" Masc ;
  Woman = mkCNomReg "femme" Fem ;
  Car = mkCNomReg "voiture" Fem ;
  Light = mkCNomReg "lumière" Fem ;
  House = mkCNomReg "maison" Fem ;
  Bottle = mkCNomReg "bouteille" Fem ;
  Walk = verbPres (conj1aimer "marcher") AHabere ;
  Run = verbPres (conj3courir "courir") AHabere ;
  Send = mkTransVerbDir (verbPres (conj1envoyer "envoyer")  AHabere) ;
  Love = mkTransVerbDir (verbPres (conj1aimer "aimer")  AHabere) ;
  Drink = mkTransVerbDir (verbPres (conj3boire "boire")  AHabere) ;
  Wait = mkTransVerbDir (verbPres (conj3rendre "attendre")  AHabere) ;
  Give = mkDitransVerb (verbPres (conj1aimer "donner")  AHabere) [] dative [] accusative ;
  Prefer = mkDitransVerb (verbPres (conj1céder "préférer")  AHabere) [] accusative [] dative ; 
  Say = verbSent (verbPres (conj3dire "dire")  AHabere) Ind Ind ;
  Prove = verbSent (verbPres (conj1aimer "démontrer")  AHabere) Ind Ind ;
  SwitchOn = mkTransVerbDir (verbPres (conj1aimer "allumer")  AHabere) ; 
  SwitchOff = mkTransVerbDir (verbPres (conj3peindre "éteindre")  AHabere) ;
  Mother = funDe (mkCNomReg "mère" Fem) ;
  Uncle = funDe (mkCNomReg "oncle" Masc) ;
  Connection = mkCNomReg "connection" Fem ** 
               {s2 = [] ; c = genitive ; s3 = [] ; c3 = dative} ;

  Well = ss "bien" ;
  Always = ss "toujours" ;
  
  John = mkProperName "Jean" Masc ;
  Mary = mkProperName "Marie" Fem ;
}
