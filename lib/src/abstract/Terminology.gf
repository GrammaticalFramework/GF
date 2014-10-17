abstract Terminology = Cat ** {

-- grammatical terminology for documenting for the library, for instance, inflection tables
-- AR 12/12/2013 under LGPL/BSD

cat
  Category ;       -- name of category e.g. "noun"
  ParameterType ;  -- name of parameter type e.g. "number"
  Parameter ;      -- name of parameter e.g. "plural"

  Heading ;        -- grammatical term used as heading e.g. "Noun" ---- TODO capitalization
  Modifier ;       -- e.g. finite, transitive

fun
  noun_Category        : Category ;
  adjective_Category   : Category ;
  verb_Category        : Category ;
  adverb_Category      : Category ;
  preposition_Category : Category ;

  number_ParameterType : ParameterType ;
  gender_ParameterType : ParameterType ;
  case_ParameterType   : ParameterType ;
  person_ParameterType : ParameterType ;
  tense_ParameterType  : ParameterType ;
  degree_ParameterType : ParameterType ;
  finite_form_ParameterType : ParameterType ;  -- needed in Fin V
  nominal_form_ParameterType : ParameterType ;

  singular_Parameter : Parameter ;
  plural_Parameter : Parameter ;

  definite_Parameter : Parameter ;
  indefinite_Parameter : Parameter ;

  masculine_Parameter : Parameter ;
  feminine_Parameter : Parameter ;
  neuter_Parameter : Parameter ;
  uter_Parameter : Parameter ;  -- the Swedish/Dutch non-neuter gender

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
  terminative_Parameter : Parameter ;

  imperative_Parameter : Parameter ;
  indicative_Parameter : Parameter ;
  conjunctive_Parameter : Parameter ;
  quotative_Parameter : Parameter ;
  infinitive_Parameter : Parameter ;

  active_Parameter : Parameter ;
  passive_Parameter : Parameter ;

  present_Parameter : Parameter ;
  past_Parameter : Parameter ;
  future_Parameter : Parameter ;
  conditional_Parameter : Parameter ;
  perfect_Parameter : Parameter ;
  imperfect_Parameter : Parameter ;
  potential_Parameter : Parameter ; -- Fin V
  supine_Parameter : Parameter ; -- Swe V
  simple_past_Parameter : Parameter ; -- Fre V

  participle_Parameter : Parameter ;
  aux_verb_Parameter : Parameter ;
  agent_Parameter : Parameter ;
  gerund_Parameter : Parameter ;

  positive_Parameter : Parameter ;  -- as degree of verbs
  comparative_Parameter : Parameter ;
  superlative_Parameter : Parameter ;
  predicative_Parameter : Parameter ;
  attributive_Parameter : Parameter ;
  negative_Parameter : Parameter ;
  positivePol_Parameter : Parameter ; -- as opposed to negative, e.g. for verbs

  subject_Parameter : Parameter ;
  object_Parameter : Parameter ;

  person1_Parameter : Parameter ;
  person2_Parameter : Parameter ;
  person3_Parameter : Parameter ;

  short_Parameter : Parameter ;   -- short form of e.g. a Fin infinitive
  long_Parameter : Parameter ;    

  finite_Modifier : Modifier ;
  transitive_Modifier : Modifier ;
  nominal_Modifier : Modifier ;

  nounHeading : N -> Heading ;            -- e.g. verb
  nounPluralHeading : N -> Heading ;      -- e.g. verbs
  modNounHeading : A -> N -> Heading ;    -- e.g. transitive verb


-- generic grammar terms

  exampleGr_N : N ; -- example of a rule, category, etc
  formGr_N : N ;    -- inflectional form

}