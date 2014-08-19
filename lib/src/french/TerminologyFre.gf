--# -path=.:../abstract:../common

concrete TerminologyFre of Terminology = CatFre ** open 
  ResFre,
  CommonRomance,
  ParadigmsFre,
  (G = GrammarFre),
  (S = SyntaxFre),
  (L = LexiconFre),
  Prelude

in {
flags coding=utf8 ;


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  
  Heading = {s : Str} ;
  

lin
  noun_Category = mkN "nom" ;
  adjective_Category = mkN "adjectif" ;
  verb_Category = mkN "verbe" masculine ;

  gender_ParameterType = mkN "genre" masculine ;

  singular_Parameter = mkN "singulier" ;
  plural_Parameter = mkN "pluriel" ;

  masculine_Parameter = mkN "masculin" ;
  feminine_Parameter = mkN "féminin" ;
  neuter_Parameter = mkN "neutre" ;

  nominative_Parameter = mkN "nominatif" ;
  genitive_Parameter = mkN "génitif" ;
  dative_Parameter = mkN "datif" ;
  accusative_Parameter = mkN "accusativ" ;
  
  imperative_Parameter = mkN "impératif" ;
  indicative_Parameter = mkN "indicatif" ;
  conjunctive_Parameter = mkN "subjonctif" ;
  infinitive_Parameter = mkN "infinitif" ;

  present_Parameter = mkN "présent" ;
  past_Parameter = mkN "passé" ;
  future_Parameter = mkN "futur" ;
  conditional_Parameter = mkN "conditionnel" ;
  perfect_Parameter = mkN "passé composé" ; ----
  imperfect_Parameter = mkN "imparfait" ;
  simple_past_Parameter = mkN "passé simple" ; ----

  participle_Parameter = mkN "participe" ;
  aux_verb_Parameter = mkN "auxiliaire" ;

  positive_Parameter = mkN "positif" ;
  comparative_Parameter = mkN "comparatif" ;
  superlative_Parameter = mkN "superlatif" ;
  predicative_Parameter = mkN "prédicatif" ;

  nounHeading n = ss (n.s ! Sg) ;

  exampleGr_N = mkN "exemple" masculine ;

}