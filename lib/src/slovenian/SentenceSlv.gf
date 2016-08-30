concrete SentenceSlv of Sentence = CatSlv ** open Prelude, ResSlv in {

lin
    PredVP np vp = mkClause (np.s ! Nom) np.a np.isPron vp ;

    ImpVP vp = {
      s = \\pol,g,n => vp.s ! VImper2 n ++ vp.s2 ! {g=g; n=n; p=P2} ;
    } ;

    UseCl  t p cl = {
      s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p
    } ;
    UseQCl t p cl = {
      s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p
    } ;

}

