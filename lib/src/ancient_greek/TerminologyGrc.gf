--# -path=.:../abstract:../common

concrete TerminologyGrc of Terminology = CatGrc ** open 
  ResGrc,
  ParadigmsGrc,
  (G = GrammarGrc),
  (S = SyntaxGrc),
  (L = LexiconGrc),
  Prelude
in {
flags coding=utf8 ;


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  
  Heading = {s : Str} ;
  
-- stolen from Ger, incomplete
}
