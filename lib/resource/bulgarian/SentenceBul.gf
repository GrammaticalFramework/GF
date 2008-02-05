concrete SentenceBul of Sentence = CatBul ** open Prelude, ResBul in {

  flags optimize=all_subs ;

  lin
    PredVP np vp = mkClause (np.s ! Nom) np.a vp ;

    ImpVP vp = {
      s = \\p,i => 
        let gn : GenNum =
              case i of {
                ImpF _  True => GPl ;
                ImpF Sg _    => GSg (variants {Masc; Fem; Neut}) ;
	        ImpF Pl _    => GPl
	      } ;
            agr = {gn = gn ; p = P2} ;
            verb = vp.imp ! p ! numImp i ;
            compl = vp.s2 ! agr
        in
        verb ++ compl
    } ;

    UseCl t a p cl = {
      s = t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! ODir
    } ;
    UseQCl t a p cl = {
      s = \\q => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! q
    } ;
}