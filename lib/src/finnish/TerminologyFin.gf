--# -path=.:../abstract:../common

concrete TerminologyFin of Terminology = CatFin ** open 
  ResFin,
  StemFin,
  ParadigmsFin,
  (G = GrammarFin),
  (S = SyntaxFin),
  (L = LexiconFin),
  Prelude,
  HTML
in {


lincat
  Category = G.N ;
  ParameterType = G.N ;
  Parameter = G.N ;
  Modifier = G.A ;
  
  Heading = {s : Str} ;
  

lin
  noun_Category = mkN "substantiivi" ;
  adjective_Category = mkN "adjektiivi" ;
  verb_Category = mkN "verbi" ;
  adverb_Category = mkN "adverbi" ;
  preposition_Category = mkN "prepositio" ;

  finite_form_ParameterType = mkN "finiittimuoto" ;
  nominal_form_ParameterType = mkN "nominaalimuoto" ;

  singular_Parameter = mkN "yksikkö" ;
  plural_Parameter = mkN "monikko" ;

  masculine_Parameter = mkN "maskuliini" ;
  feminine_Parameter = mkN "feminiini" ;
  neuter_Parameter = mkN "neutri" ;

  nominative_Parameter = mkN "nominatiivi" ;
  genitive_Parameter = mkN "genetiivi" ;
  dative_Parameter = mkN "datiivi" ;
  accusative_Parameter = mkN "akkusatiivi" ;

  partitive_Parameter = mkN "partitiivi" ;
  translative_Parameter = mkN "translatiivi" ;
  essive_Parameter = mkN "essiivi" ;
  inessive_Parameter = mkN "inessiivi" ;
  elative_Parameter = mkN "elatiivi" ;
  illative_Parameter = mkN "illatiivi" ;
  adessive_Parameter = mkN "adessiivi" ;
  ablative_Parameter = mkN "ablatiivi" ;
  allative_Parameter = mkN "allatiivi" ;
  abessive_Parameter = mkN "abessiivi" ;
  comitative_Parameter = mkN "komitatiivi" ;
  instructive_Parameter = mkN "instruktiivi" ;

  active_Parameter = mkN "aktiivi" ;
  passive_Parameter = mkN "passiivi" ;
  
  imperative_Parameter = mkN "imperatiivi" ;
  indicative_Parameter = mkN "indikatiivi" ;
  conjunctive_Parameter = mkN "konjunktiivi" ;
  infinitive_Parameter = mkN "infinitiivi" ;

  present_Parameter = mkN "preesens" ;
  past_Parameter = mkN "imperfekti" ;
  future_Parameter = mkN "futuuri" ;
  conditional_Parameter = mkN "konditionaali" ;
  perfect_Parameter = mkN "perfekti" ;
  potential_Parameter = mkN "potentiaali" ;

  participle_Parameter = mkN "partisiippi" ;
  aux_verb_Parameter = mkN "apu" (mkN "verbi") ;
  agent_Parameter = mkN "agentti" ;

  positive_Parameter = mkN "positiivi" ;
  comparative_Parameter = mkN "komparatiivi" ;
  superlative_Parameter = mkN "superlatiivi" ;
  predicative_Parameter = mkN "predikatiivi" ;
  negative_Parameter = mkN "kielteinen" ;
  positivePol_Parameter = mkN "myönteinen" ;

  long_Parameter = mkN "pitkä" ;
  short_Parameter = mkN "lyhyt" ;

  finite_Modifier = mkA "finiittinen" ;

  nounHeading n = ss ((snoun2nounSep n).s ! NCase Sg Nom) ;
  nounPluralHeading n = ss ((snoun2nounSep n).s ! NCase Pl Nom) ;

  formGF_N = mkN "muoto" ;
  exampleGr_N = mkN "esimerkki" ;

}
