--# -path=.:../abstract:../common

incomplete concrete DocumentationGrcFunctor of Documentation = CatGrc ** open 
  Terminology,  -- the interface that generates different documentation languages
  ResGrc,
  ParadigmsGrc,
  (G = GrammarGrc),
  (S = SyntaxGrc),
  (L = LexiconGrc),
  Prelude,
  HTML
in {
flags coding=utf8 ;


lincat
  Inflection = {t : Str; s1,s2 : Str} ;
  Definition = {s : Str} ;
  Document = {s : Str} ;
  Tag = {s : Str} ;

-- partial, stolen from DocumentationGerFunctor.gf, HL
}
