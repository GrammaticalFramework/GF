--# -path=.:../abstract:../common

concrete TerminologyDut of Terminology = CatDut ** open 
  ResDut,
  ParadigmsDut,
  (G = GrammarDut),
  (S = SyntaxDut),
  (L = LexiconDut),
  Prelude
in {


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  
  Heading = {s : Str} ;
  

lin
  noun_Category = mkN "zelfstandig naamwoord" ;
  adjective_Category = mkN "bijvoeglijk naamwoord" ;
  verb_Category = mkN "werkwoord" ;
  preposition_Category = mkN "voorzetsel" ;

  gender_ParameterType = mkN "geschlacht" ;

  singular_Parameter = mkN "enkelvoud" ;
  plural_Parameter = mkN "meervoud" ;

  masculine_Parameter = mkN "mannelijk" ;
  feminine_Parameter = mkN "vrouwelijk" ;
  neuter_Parameter = mkN "onzijdig" ;
  uter_Parameter = mkN "m/v" ; ----

  nominative_Parameter = mkN "nominatief" ;
  genitive_Parameter = mkN "genitief" ;
  dative_Parameter = mkN "datief" ;
  accusative_Parameter = mkN "accusatief" ;
  
  imperative_Parameter = mkN "imperatief" ;
  indicative_Parameter = mkN "indicatief" ;
  conjunctive_Parameter = mkN "conjunctief" ;
  infinitive_Parameter = mkN "infinitief" ;

  present_Parameter = mkN "tegenwoordige tijd" ;
  past_Parameter = mkN "verleden tijd" ;
  future_Parameter = mkN "toekomende tijd" ;
  conditional_Parameter = mkN "voorwaardelijke wijs" ;
  perfect_Parameter = mkN "voltooide tijd" ;

  participle_Parameter = mkN "deelwoord" ;
  aux_verb_Parameter = mkN "hulpwerkwoord" ;

  positive_Parameter = mkN "stellend" ;
  comparative_Parameter = mkN "vergrotend" ;
  superlative_Parameter = mkN "overtreffend" ;
  predicative_Parameter = mkN "predicatief" ;

  nounHeading n = ss (n.s ! NF Sg Nom) ;

  exampleGr_N = mkN "voorbeeld" ;

}