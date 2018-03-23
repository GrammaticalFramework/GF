
--# -path=.:../abstract:../common

concrete TerminologyPor of Terminology = CatPor ** open
  ResPor,
  CommonRomance,
  ParadigmsPor,
  (G = GrammarPor),
  (S = SyntaxPor),
  (L = LexiconPor),
  Prelude

in {
flags coding=utf8 ;


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;

  Heading = {s : Str} ;


lin
  noun_Category = mkN "substantivo" ;
  adjective_Category = mkN "adjetivo" ;
  verb_Category = mkN "verbo" masculine ;

  gender_ParameterType = mkN "gênero" masculine ;

  singular_Parameter = mkN "singular" ;
  plural_Parameter = mkN "plural" ;

  masculine_Parameter = mkN "masculino" ;
  feminine_Parameter = mkN "feminino" ;
  neuter_Parameter = mkN "neutro" ;

  nominative_Parameter = mkN "nominativo" ;
  genitive_Parameter = mkN "genitivo" ;
  dative_Parameter = mkN "dativo" ;
  accusative_Parameter = mkN "acusativo" ;

  imperative_Parameter = mkN "imperativo" ;
  indicative_Parameter = mkN "indicativo" ;
  conjunctive_Parameter = mkN "subjuntivo" ;
  infinitive_Parameter = mkN "infinitivo" ;

  present_Parameter = mkN "presente" ;
  past_Parameter = mkN "pretérito" ;
  future_Parameter = mkN "futuro" ;
  conditional_Parameter = mkN "condicional" ;
  perfect_Parameter = mkN "perfeito composto" ; ----
  imperfect_Parameter = mkN "imperfeito" ;
  simple_past_Parameter = mkN "perfeito simples" ; ----

  participle_Parameter = mkN "particípio" ;
  aux_verb_Parameter = mkN "auxiliar" ; ----

  positive_Parameter = mkN "positivo" ;
  comparative_Parameter = mkN "comparativo" ;
  superlative_Parameter = mkN "superlativo" ;
  predicative_Parameter = mkN "predicativo" ;

  nounHeading n = ss (n.s ! Sg) ;

  exampleGr_N = mkN "examplo" masculine ;

}