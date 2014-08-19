--# -path=.:../abstract:../common

concrete TerminologyGer of Terminology = CatGer ** open 
  ResGer,
  ParadigmsGer,
  (G = GrammarGer),
  (S = SyntaxGer),
  (L = LexiconGer),
  Prelude
in {
flags coding=utf8 ;


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  
  Heading = {s : Str} ;
  

lin
  noun_Category = mkN "Substantiv" ;
  adjective_Category = mkN "Adjektiv" ;
  verb_Category = mkN "Verb" ;
  preposition_Category = mkN "Präposition" ;

  gender_ParameterType = mkN "Geschlecht" ;

  singular_Parameter = mkN "Singular" ;
  plural_Parameter = mkN "Plural" ;

  masculine_Parameter = mkN "Maskulinum" ;
  feminine_Parameter = mkN "Femininum" ;
  neuter_Parameter = mkN "Neutrum" ;

  nominative_Parameter = mkN "Nominativ" ;
  genitive_Parameter = mkN "Genitiv" ;
  dative_Parameter = mkN "Dativ" ;
  accusative_Parameter = mkN "Akkusativ" ;
  
  imperative_Parameter = mkN "Imperativ" ;
  indicative_Parameter = mkN "Indikativ" ;
  conjunctive_Parameter = mkN "Konjunktiv" ;
  infinitive_Parameter = mkN "Infinitiv" ;

  present_Parameter = mkN "Präsens" ;
  past_Parameter = mkN "Präteritum" ;
  future_Parameter = mkN "Futur" ;
  conditional_Parameter = mkN "Konditional" ;
  perfect_Parameter = mkN "Perfekt" ;

  participle_Parameter = mkN "Partizip" ;
  aux_verb_Parameter = mkN "Hilfsverb" ;

  positive_Parameter = mkN "Positiv" ;
  comparative_Parameter = mkN "Komparativ" ;
  superlative_Parameter = mkN "Superlativ" ;
  predicative_Parameter = mkN "Prädikativ" ;

  nounHeading n = ss (n.s ! Sg ! Nom) ;

  exampleGr_N = mkN "Beispiel" "Beispiele" neuter ;

}