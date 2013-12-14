--# -path=.:../abstract:../common

concrete TerminologySwe of Terminology = CatSwe ** open 
  ResSwe,
  CommonScand,
  ParadigmsSwe,
  (G = GrammarSwe),
  (S = SyntaxSwe),
  (L = LexiconSwe),
  Prelude,
  HTML
in {


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  
  Heading = {s : Str} ;
  

lin
  noun_Category = mkN "substantiv" ;
  adjective_Category = mkN "adjektiv" ;
  verb_Category = mkN "verb" ;
  adverb_Category = mkN "adverb" ;
  preposition_Category = mkN "preposition" ;

  gender_ParameterType = mkN "genus" ;

  singular_Parameter = mkN "singular" ;
  plural_Parameter = mkN "plural" ;

  definite_Parameter = mkN "bestämd" ;
  indefinite_Parameter = mkN "obestämd" ;

  masculine_Parameter = mkN "maskulin" ;
  feminine_Parameter = mkN "feminin" ;
  neuter_Parameter = mkN "neutrum" ;
  uter_Parameter = mkN "utrum" ;

  nominative_Parameter = mkN "nominativ" ;
  genitive_Parameter = mkN "genitiv" ;
  dative_Parameter = mkN "dativ" ;
  accusative_Parameter = mkN "akkusativ" ;
  
  imperative_Parameter = mkN "imperativ" ;
  indicative_Parameter = mkN "indikativ" ;
  conjunctive_Parameter = mkN "konjunktiv" ;
  infinitive_Parameter = mkN "infinitiv" ;

  active_Parameter = mkN "aktiv" ;
  passive_Parameter = mkN "passiv" ;

  present_Parameter = mkN "presens" ;
  past_Parameter = mkN "preteritum" ;
  future_Parameter = mkN "futur" ;
  conditional_Parameter = mkN "konditionalis" ;
  perfect_Parameter = mkN "perfekt" ;
  supine_Parameter = mkN "supinum" ;

  participle_Parameter = mkN "particip" ;
  aux_verb_Parameter = mkN "hjälpverb" ;

  positive_Parameter = mkN "positiv" ;
  comparative_Parameter = mkN "komparativ" ;
  superlative_Parameter = mkN "superlativ" ;
  predicative_Parameter = mkN "predikativ" ;

  nounHeading n = ss (n.s ! Sg ! Indef ! Nom) ;

  lin
    exampleGr_N = mkN "exempel" "exempel" ;

}