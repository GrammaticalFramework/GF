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

  nominative_Parameter = mkN "nominatiu" ;
  genitive_Parameter = mkN "genitiu" ;
  dative_Parameter = mkN "datiu" ;
  accusative_Parameter = mkN "accusatiu" ;
  
  imperative_Parameter = mkN "imperatiu" ;
  indicative_Parameter = mkN "indicatiu" ;
  conjunctive_Parameter = mkN "subjuntiu" ;
  infinitive_Parameter = mkN "infinitiu" ;

  present_Parameter = mkN "present" ;
  past_Parameter = mkN "passat" ;
----  past_Parameter = mkN "pretèrit" ;
  future_Parameter = mkN "futur" ;
  future_Parameter = mkN "futur" ;

  conditional_Parameter = mkN "condicional" ;

  perfect_Parameter = mkN "perfecte compost" ; ----
  imperfect_Parameter = mkN "imperfecte" ;
  simple_past_Parameter = mkN "perfecte simple" ; ----

  participle_Parameter = mkN "participi" ;
  aux_verb_Parameter = mkN "auxiliar" ; ----

  positive_Parameter = mkN "positiu" ;
  comparative_Parameter = mkN "comparatiu" ;
  superlative_Parameter = mkN "superlatiu" ;
  predicative_Parameter = mkN "predicatiu" ;

  nounHeading n = ss (n.s ! Sg) ;

  exampleGr_N = mkN "exemple" masculine ;

}
