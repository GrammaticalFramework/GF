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

  gender_ParameterType = mkN "Gender" ;

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
  
  imperative_Parameter = mkN "imperative" ;
  indicative_Parameter = mkN "indicative" ;
  conjunctive_Parameter = mkN "konjunctive" ;
  infinitive_Parameter = mkN "infinitive" ;

  definite_Parameter = mkN "definite" ;
  indefinite_Parameter = mkN "indefinite" ;

  present_Parameter = mkN "present" ;
  past_Parameter = mkN "past" ;
  future_Parameter = mkN "future" ;
  conditional_Parameter = mkN "conditional" ;
  perfect_Parameter = mkN "perfect" ;
  supine_Parameter = mkN "supine" ;

  participle_Parameter = mkN "participle" ;
  aux_verb_Parameter = mkN "auxiliary" ;

  positive_Parameter = mkN "positive" ;
  comparative_Parameter = mkN "comparative" ;
  superlative_Parameter = mkN "superlative" ;
  predicative_Parameter = mkN "predicative" ;

  nounHeading n = ss (n.s ! Sg ! Nom) ;

  exampleGr_N = mkN "example" ;
  formGr_N = mkN "form" ;


}