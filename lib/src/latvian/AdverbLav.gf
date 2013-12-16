--# -path=.:../abstract:../common:../prelude

concrete AdverbLav of Adverb = CatLav ** open
  ResLav,
  Prelude
  in {

flags
  coding = utf8 ;

lin
  -- A -> Adv
  -- e.g. "warmly"
  PositAdvAdj a = {s = a.s ! (AAdv Posit) ; isPron = False} ;

  -- Prep -> NP -> Adv
  -- e.g. "in the house"
  -- FIXME: postpozīcijas prievārdi
  PrepNP prep np = {s = prep.s ++ np.s ! (prep.c ! (fromAgr np.agr).num) ; isPron = np.isPron} ;

  -- CAdv -> A -> NP -> Adv
  -- e.g. "more warmly than John"
  -- TODO: vajag arī 'ātrāks par Jāni' un 'ātrāks nekā Jānis' pie more_CAdv
  -- TODO: vai te tiešām veido 'ātrāk par Jāni'? kurš ir pareizais adverbs? nevis 'ātrāks par Jāni'?
  ComparAdvAdj cadv a np = {s = cadv.s ++ a.s ! (AAdv cadv.deg) ++ cadv.prep ++ np.s ! Nom ; isPron = False} ;

  -- CAdv -> A -> S  -> Adv
  -- e.g. "more warmly than he runs"
  ComparAdvAdjS cadv a s = {s = cadv.s ++ a.s ! (AAdv cadv.deg) ++ cadv.prep ++ s.s ; isPron = False} ;

  -- AdA -> Adv -> Adv
  -- e.g. "very quickly"
  AdAdv ada adv = {s = ada.s ++ adv.s ; isPron = False} ;

  -- TODO: PositAdAAdj : A -> AdA

  -- Subj -> S -> Adv
  -- e.g. "when she sleeps"
  SubjS subj s = {s = subj.s ++ s.s ; isPron = False} ;

  -- CAdv -> AdN
  -- e.g. "less (than five)"
  AdnCAdv cadv = {
    s = case cadv.deg of {
      Posit => cadv.s ++ cadv.prep ;
      _     => NON_EXISTENT
    }
  } ;

}
