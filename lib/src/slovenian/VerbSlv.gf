concrete VerbSlv of Verb = CatSlv ** open ResSlv, Prelude in {

  lin
    UseV v = predV v.s ;

    SlashV2a v = predV v.s ** {c2 = v.c2} ;

    ComplSlash vp np =
      insertObj (\\_ => vp.c2.s ++ np.s ! vp.c2.c) vp ;

}
