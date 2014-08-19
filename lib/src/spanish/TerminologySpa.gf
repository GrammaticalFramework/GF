--# -path=.:../abstract:../common

concrete TerminologySpa of Terminology = CatSpa ** open 
  ResSpa,
  CommonRomance,
  ParadigmsSpa,
  (G = GrammarSpa),
  (S = SyntaxSpa),
  (L = LexiconSpa),
  Prelude

in {
flags coding=utf8 ;


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  
  Heading = {s : Str} ;
  

lin
  noun_Category = mkN "sustantivo" ;
  adjective_Category = mkN "adjetivo" ;
  verb_Category = mkN "verbo" masculine ;

  gender_ParameterType = mkN "género" masculine ;

  singular_Parameter = mkN "singular" ;
  plural_Parameter = mkN "plural" ;

  masculine_Parameter = mkN "masculino" ;
  feminine_Parameter = mkN "femenino" ;
  neuter_Parameter = mkN "neutro" ;

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

  participle_Parameter = mkN "participio" ;
  aux_verb_Parameter = mkN "auxiliar" ; ----

  positive_Parameter = mkN "positivo" ;
  comparative_Parameter = mkN "comparativo" ;
  superlative_Parameter = mkN "superlativo" ;
  predicative_Parameter = mkN "predicativo" ;

  nounHeading n = ss (n.s ! Sg) ;

  exampleGr_N = mkN "ejemplo" masculine ;

}