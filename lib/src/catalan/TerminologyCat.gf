--# -path=.:../abstract:../common

concrete TerminologyCat of Terminology = CatCat ** open
  ResCat,
  CommonRomance,
  ParadigmsCat,
  (G = GrammarCat),
  (S = SyntaxCat),
  (L = LexiconCat),
  Prelude

in {
flags coding=utf8 ;


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;

  Heading = {s : Str} ;


lin
  noun_Category = mkN "substantiu" ;
  adjective_Category = mkN "adjectiu" ;
  verb_Category = mkN "verb" masculine ;

  gender_ParameterType = mkN "gènere" masculine ;

  singular_Parameter = mkN "singular" ;
  plural_Parameter = mkN "plural" ;

  masculine_Parameter = mkN "masculí" ;
  feminine_Parameter = mkN "femení" ;
  neuter_Parameter = mkN "neutre" ;

  nominative_Parameter = mkN "nominativo" ;
  genitive_Parameter = mkN "genitivo" ;
  dative_Parameter = mkN "dativo" ;
  accusative_Parameter = mkN "accusativo" ;
  
  imperative_Parameter = mkN "imperativo" ;
  indicative_Parameter = mkN "indicativo" ;
  conjunctive_Parameter = mkN "subjuntivo" ;
  infinitive_Parameter = mkN "infinitivo" ;

  present_Parameter = mkN "presente" ;
  past_Parameter = mkN "pretérito" ;
  future_Parameter = mkN "futuro" ;
  conditional_Parameter = mkN "condicional" ;
  perfect_Parameter = mkN "perfecto compuesto" ; ----
  imperfect_Parameter = mkN "imperfecto" ;
  simple_past_Parameter = mkN "perfecto simple" ; ----

  participle_Parameter = mkN "participi" ;
  aux_verb_Parameter = mkN "auxiliar" ; ----

  positive_Parameter = mkN "positivo" ;
  comparative_Parameter = mkN "comparativo" ;
  superlative_Parameter = mkN "superlativo" ;
  predicative_Parameter = mkN "predicativo" ;

  nounHeading n = ss (n.s ! Sg) ;

  exampleGr_N = mkN "exemple" masculine ;

}
