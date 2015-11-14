--# -path=.:../abstract:../common

concrete TerminologyEst of Terminology = CatEst ** open 
  ResEst,
  ParadigmsEst,
  (G = GrammarEst),
  (S = SyntaxEst),
  (L = LexiconEst),
  Prelude,
  HTML
in {
flags coding=utf8 ;


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  Modifier = G.A ;
  
  Heading = {s : Str} ;
  

lin
  noun_Category = mkN "käändsõna" ;
  adjective_Category = mkN "omadussõna" ;
  verb_Category = mkN "pöördsõna" ;
  adverb_Category = mkN "määrsõna" ;
  preposition_Category = mkN "eessõna" ;

  finite_form_ParameterType = mkN "pöördvorm" ; ---- ???
  nominal_form_ParameterType = mkN "käändeline vorm" ;

  singular_Parameter = mkN "ainsus" ;
  plural_Parameter = mkN "mitmus" ;

  masculine_Parameter = mkN "maskuliin" ; ----
  feminine_Parameter = mkN "feminiin" ; ----
  neuter_Parameter = mkN "neutri" ; ----

  nominative_Parameter = mkN "nimetav" ;
  genitive_Parameter = mkN "omastav" ;
  dative_Parameter = mkN "daativ" ;
  accusative_Parameter = mkN "akusatiiv" | mkN "sihitav" ;

  partitive_Parameter = mkN "osastav" ;
  translative_Parameter = mkN "saav" ;
  essive_Parameter = mkN "olev" ;
  inessive_Parameter = mkN "seesütlev" ;
  elative_Parameter = mkN "seestütlev" ;
  illative_Parameter = mkN "sisseütlev" ;
  adessive_Parameter = mkN "alalütlev" ;
  ablative_Parameter = mkN "alaltütlev" ;
  allative_Parameter = mkN "alaleütlev" ;
  abessive_Parameter = mkN "ilmaütlev" ;
  comitative_Parameter = mkN "kaasaütlev" ;
  instructive_Parameter = mkN "viisiütlev" ;
  terminative_Parameter = mkN "rajav" ;

  active_Parameter = mkN "isikuline tegumood" ;
  passive_Parameter = mkN "umbsikuline tegumood" ;
  
  imperative_Parameter = mkN "käskiv kõneviis" "käskiva kõneviisi";
  indicative_Parameter = mkN "kindel kõneviis" "kindla kõneviisi";
  conjunctive_Parameter = mkN "konjunktiiv" ;
  infinitive_Parameter = mkN "infinitiiv" ;

  present_Parameter = mkN "olevik" ;
  past_Parameter = mkN "lihtminevik" ;
  future_Parameter = mkN "futuur" ; ---- ??? 
  conditional_Parameter = mkN "tingiv kõneviis" "tingiva kõneviisi";
  perfect_Parameter = mkN "täisminevik" ;
  quotative_Parameter = mkN "kaudne kõneviis" "kaudse kõneviisi";

  participle_Parameter = mkN "kesksõna" ;
  aux_verb_Parameter = mkN "abi" (mkN "verb") ;
  agent_Parameter = mkN "tegevussubjekt" ;

  positive_Parameter = mkN "algvõrre" | mkN "positiiv" ;
  comparative_Parameter = mkN "keskvõrre" | mkN "komparatiiv" ;
  superlative_Parameter = mkN "ülivõrre" | mkN "superlatiiv" ;
  predicative_Parameter = mkN "öeldistäide" | mkN "predikatiiv" ;
  negative_Parameter = mkN "eitav kõne" ;
  positivePol_Parameter = mkN "jaatav kõne" ;

  long_Parameter = mkN "pikk" ;
  short_Parameter = mkN "lühike" ;

  finite_Modifier = mkA "finiitne" ;

  nounHeading n = ss (n.s ! NCase Sg Nom) ;
  nounPluralHeading n = ss (n.s ! NCase Pl Nom) ;

  formGF_N = mkN "vorm" ;
  exampleGr_N = mkN "näide" ;

}
