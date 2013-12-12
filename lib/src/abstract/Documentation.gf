abstract Documentation = Cat ** {

-- Generating documentation for the library, for instance, inflection tables
-- AR 12/12/2013 under LGPL/BSD

cat
  Category ;       -- name of category e.g. "noun"
  ParameterType ;  -- name of parameter type e.g. "number"
  Parameter ;      -- name of parameter e.g. "plural"

  Heading ;        -- grammatical term used as heading e.g. "Noun" ---- TODO capitalization
  Inflection ;     -- inflection table
  Modifier ;       -- e.g. finite, transitive

fun
  noun_Category      : Category ;
  adjective_Category : Category ;
  verb_Category      : Category ;
  adverb_Category    : Category ;

  number_ParameterType : ParameterType ;
  gender_ParameterType : ParameterType ;
  case_ParameterType   : ParameterType ;
  person_ParameterType : ParameterType ;
  tense_ParameterType  : ParameterType ;
  degree_ParameterType : ParameterType ;

  singular_Parameter : Parameter ;
  plural_Parameter : Parameter ;

  masculine_Parameter : Parameter ;
  feminine_Parameter : Parameter ;
  neuter_Parameter : Parameter ;

  nominative_Parameter : Parameter ;
  accusative_Parameter : Parameter ;
  genitive_Parameter : Parameter ;
  dative_Parameter : Parameter ;

  partitive_Parameter : Parameter ; -- Fin N
  translative_Parameter : Parameter ;
  essive_Parameter : Parameter ;
  inessive_Parameter : Parameter ;
  elative_Parameter : Parameter ;
  illative_Parameter : Parameter ;
  adessive_Parameter : Parameter ;
  ablative_Parameter : Parameter ;
  allative_Parameter : Parameter ;
  abessive_Parameter : Parameter ;
  comitative_Parameter : Parameter ;
  instructive_Parameter : Parameter ;

  imperative_Parameter : Parameter ;
  indicative_Parameter : Parameter ;
  conjunctive_Parameter : Parameter ;
  infinitive_Parameter : Parameter ;

  present_Parameter : Parameter ;
  past_Parameter : Parameter ;
  future_Parameter : Parameter ;
  conditional_Parameter : Parameter ;
  perfect_Parameter : Parameter ;
  potential_Parameter : Parameter ; -- Fin V

  participle_Parameter : Parameter ;
  aux_verb_Parameter : Parameter ;

  positive_Parameter : Parameter ;
  comparative_Parameter : Parameter ;
  superlative_Parameter : Parameter ;
  predicative_Parameter : Parameter ;

  person1_Parameter : Parameter ;
  person2_Parameter : Parameter ;
  person3_Parameter : Parameter ;

  finite_Modifier : Modifier ;
  transitive_Modifier : Modifier ;

  nounHeading : N -> Heading ;

  InflectionN  : N -> Inflection ;
  InflectionA  : A -> Inflection ;
  InflectionV  : V -> Inflection ;
  InflectionV2 : V2 -> Inflection ;

-- generic lexicon

  formGr_N : N ;  -- inflectional form

}