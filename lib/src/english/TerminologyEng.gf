--# -path=.:../abstract:../common

concrete TerminologyEng of Terminology = CatEng ** open 
  ResEng,
  ParadigmsEng,
  (G = GrammarEng),
  (S = SyntaxEng),
  (L = LexiconEng),
  Prelude
in {


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  Modifier = G.A ;

lin
  noun_Category = mkN "noun" ;
  adjective_Category = mkN "adjective" ;
  verb_Category = mkN "verb" ;
  adverb_Category = mkN "adverb" ;
  preposition_Category = mkN "preposition" ;

  gender_ParameterType = mkN "Gender" ;
  finite_form_ParameterType = mkN "finite form" ;
  nominal_form_ParameterType = mkN "nominal form" ;

  singular_Parameter = mkN "singular" ;
  plural_Parameter = mkN "plural" ;

  masculine_Parameter = mkN "masculine" ;
  feminine_Parameter = mkN "feminine" ;
  neuter_Parameter = mkN "neuter" ;
  uter_Parameter = mkN "uter" ;

  nominative_Parameter = mkN "nominative" ;
  genitive_Parameter = mkN "genitive" ;
  dative_Parameter = mkN "dative" ;
  accusative_Parameter = mkN "accusative" ;

  partitive_Parameter = mkN "partitive" ;
  translative_Parameter = mkN "translative" ;
  essive_Parameter = mkN "essive" ;
  inessive_Parameter = mkN "inessive" ;
  elative_Parameter = mkN "elative" ;
  illative_Parameter = mkN "illative" ;
  adessive_Parameter = mkN "adessive" ;
  ablative_Parameter = mkN "ablative" ;
  allative_Parameter = mkN "allative" ;
  abessive_Parameter = mkN "abessive" ;
  comitative_Parameter = mkN "comitative" ;
  instructive_Parameter = mkN "instructive" ;

  active_Parameter = mkN "active" ;
  passive_Parameter = mkN "passive" ;
  
  imperative_Parameter = mkN "imperative" ;
  indicative_Parameter = mkN "indicative" ;
  conjunctive_Parameter = mkN "conjunctive" ;
  infinitive_Parameter = mkN "infinitive" ;

  definite_Parameter = mkN "definite" ;
  indefinite_Parameter = mkN "indefinite" ;

  present_Parameter = mkN "present" ;
  past_Parameter = mkN "past" ;
  future_Parameter = mkN "future" ;
  conditional_Parameter = mkN "conditional" ;
  potential_Parameter = mkN "potential" ;
  perfect_Parameter = mkN "perfect" ;
  imperfect_Parameter = mkN "imperfect" ;
  supine_Parameter = mkN "supine" ;
  agent_Parameter = mkN "agent" ;
  simple_past_Parameter = mkN "simple past" ;

  participle_Parameter = mkN "participle" ;
  aux_verb_Parameter = mkN "auxiliary" ;
  gerund_Parameter = mkN "Gerund" ;

  positive_Parameter = mkN "positive" ;
  comparative_Parameter = mkN "comparative" ;
  superlative_Parameter = mkN "superlative" ;
  predicative_Parameter = mkN "predicative" ;
  negative_Parameter = mkN "negative" ;

  short_Parameter = mkN "short" ;
  long_Parameter = mkN "long" ;

  nounHeading n = ss (n.s ! Sg ! Nom) ;
  nounPluralHeading n = ss (n.s ! Pl ! Nom) ;

  exampleGr_N = mkN "example" ;
  formGr_N = mkN "form" ;


}