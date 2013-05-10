--# -path=.:../abstract:../common:../prelude

concrete AdverbLav of Adverb = CatLav ** open
  ResLav,
  Prelude
  in {

flags
  coding = utf8 ;

lin
  PositAdvAdj a = { s = a.s ! (AAdv Posit) } ;

  -- TODO: vajag arī 'ātrāks par Jāni' un 'ātrāks nekā Jānis' pie more_CAdv
  -- TODO: vai te tiešām veido 'ātrāk par Jāni'? kurš ir pareizais adverbs? nevis 'ātrāks par Jāni'?
  ComparAdvAdj cadv a np = { s = cadv.s ++ a.s ! (AAdv cadv.deg) ++ cadv.prep ++ np.s ! Nom } ;

  ComparAdvAdjS cadv a s = { s = cadv.s ++ a.s ! (AAdv cadv.deg) ++ cadv.prep ++ s.s } ;

  -- FIXME: postpozīcijas prievārdi
  PrepNP prep np = { s = prep.s ++ np.s ! (prep.c ! (fromAgr np.agr).num) } ;

  AdAdv = cc2 ;

  SubjS = cc2 ;

  AdnCAdv cadv = {
    s = case cadv.deg of {
      Posit => cadv.s ++ cadv.prep ;
      _     => NON_EXISTENT
    }
  } ;

}
