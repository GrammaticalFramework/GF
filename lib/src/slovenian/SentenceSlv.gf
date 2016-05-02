concrete SentenceSlv of Sentence = CatSlv ** open Prelude, ResSlv in {

lin
    PredVP np vp = mkClause (np.s ! Nom) np.a vp ;

    UseCl  t p cl = {
      s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p
    } ;

}

