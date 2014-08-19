--# -path=.:../abstract:../common

concrete TerminologyIta of Terminology = CatIta ** open 
  ResIta,
  CommonRomance,
  ParadigmsIta,
  (G = GrammarIta),
  (S = SyntaxIta),
  (L = LexiconIta),
  Prelude

in {
flags coding=utf8 ;


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  
  Heading = {s : Str} ;
  

lin
  noun_Category = mkN "nome" ;
  adjective_Category = mkN "addiettivo" ;
  verb_Category = mkN "verbe" masculine ;

  gender_ParameterType = mkN "genere" masculine ;

  singular_Parameter = mkN "singolare" ;
  plural_Parameter = mkN "plurale" ;

  masculine_Parameter = mkN "maschio" ;
  feminine_Parameter = mkN "femminile" ;
  neuter_Parameter = mkN "neutro" ;

  nominative_Parameter = mkN "nominativo" ;
  genitive_Parameter = mkN "genitivo" ;
  dative_Parameter = mkN "dativo" ;
  accusative_Parameter = mkN "accusativi" ;
  
  imperative_Parameter = mkN "imperativo" ;
  indicative_Parameter = mkN "indicativo" ;
  conjunctive_Parameter = mkN "congiuntivo" ;
  infinitive_Parameter = mkN "infinitivo" ;

  present_Parameter = mkN "presente" ;
  past_Parameter = mkN "passato" ;
  future_Parameter = mkN "futuro" ;
  conditional_Parameter = mkN "condizionale" ;
  perfect_Parameter = mkN "passato prossimo" ; ----
  imperfect_Parameter = mkN "imperfetto" ;
  simple_past_Parameter = mkN "passato remoto" ; ----

  participle_Parameter = mkN "participio" ;
  aux_verb_Parameter = mkN "ausiliare" ;

  positive_Parameter = mkN "positivo" ;
  comparative_Parameter = mkN "comparativo" ;
  superlative_Parameter = mkN "superlativo" ;
  predicative_Parameter = mkN "prédicativo" ;

  nounHeading n = ss (n.s ! Sg) ;

  exampleGr_N = mkN "esempio" masculine ;

}