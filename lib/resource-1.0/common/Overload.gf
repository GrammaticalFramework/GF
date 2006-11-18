incomplete resource Overload = open Grammar in {

  oper

    pred = overload {
      pred : NP -> V -> Cl
                                       = \v,np -> PredVP np (UseV v) ;
      pred : NP -> V2 -> NP -> Cl
                                       = \v,np,ob -> PredVP np (ComplV2 v ob) ;
      pred : NP -> V3 -> NP -> NP -> Cl 
                                       = \v,np,ob,ob2 -> 
                                          PredVP np (ComplV3 v ob ob2) ;
      pred : NP -> A  -> Cl 
                                       = \a,np -> 
                                       PredVP np (UseComp (CompAP (PositA a)))
      } ;

    mod = overload {
      mod : A -> N -> CN
                                  = \a,n -> AdjCN (PositA a) (UseN n) ;
      mod : AP -> N -> CN
                                  = \a,n -> AdjCN a (UseN n) ;
      mod : AP -> CN -> CN
                                  = \a,n -> AdjCN a n ;
      mod : AdA -> A -> AP
                                  = \m,a -> AdAP m (PositA a) ;
      mod : Quant -> N -> NP
                                  = \q,n -> DetCN (DetSg (SgQuant q) NoOrd) 
                                              (UseN n) ;
      mod : Quant -> CN -> NP
                                  = \q,n -> DetCN (DetSg (SgQuant q) NoOrd) n ;
      mod : Predet -> N -> NP 
                                  = \q,n -> PredetNP q (DetCN (DetPl 
                                   (PlQuant IndefArt)  NoNum NoOrd) (UseN n)) ;
      mod : Num -> N -> NP
                                  = \nu,n -> DetCN (DetPl (PlQuant 
                                    IndefArt) nu NoOrd) (UseN n)

      } ;

    coord = overload {
      coord : Conj -> Adv -> Adv -> Adv
                                        = \c,x,y -> ConjAdv c (BaseAdv x y) ;
      coord : Conj -> AP -> AP -> AP
                                        = \c,x,y -> ConjAP c (BaseAP x y) ;
      coord : Conj -> NP -> NP -> NP
                                        = \c,x,y -> ConjNP c (BaseNP x y) ;
      coord : Conj -> S  -> S  -> S  
                                        = \c,x,y -> ConjS c (BaseS x y) ;
      coord : DConj -> Adv -> Adv -> Adv
                                        = \c,x,y -> DConjAdv c (BaseAdv x y) ;
      coord : DConj -> AP -> AP -> AP
                                        = \c,x,y -> DConjAP c (BaseAP x y) ;
      coord : DConj -> NP -> NP -> NP
                                        = \c,x,y -> DConjNP c (BaseNP x y) ;
      coord : DConj -> S  -> S  -> S  
                                        = \c,x,y -> DConjS c (BaseS x y) ;
      coord : Conj -> ListAdv -> Adv
                                        = \c,xy -> ConjAdv c xy ;
      coord : Conj -> ListAP -> AP
                                        = \c,xy -> ConjAP c xy ; 
      coord : Conj -> ListNP -> NP
                                        = \c,xy -> ConjNP c xy ;
      coord : Conj -> ListS  -> S  
                                        = \c,xy -> ConjS c xy ;
      coord : DConj -> ListAdv -> Adv
                                        = \c,xy -> DConjAdv c xy ;
      coord : DConj -> ListAP -> AP
                                        = \c,xy -> DConjAP c xy ; 
      coord : DConj -> ListNP -> NP
                                        = \c,xy -> DConjNP c xy ;
      coord : DConj -> ListS  -> S  
                                        = \c,xy -> DConjS c xy
      } ;

    mkCN = overload {
      mkCN : N -> CN
        = UseN ;
      mkCN : A -> N -> CN
        = \a,n -> AdjCN (PositA a) (UseN n) ;
      mkCN : AP -> N -> CN
        = \a,n -> AdjCN a (UseN n) ;
      mkCN : AP -> CN -> CN
        = \a,n -> AdjCN a n ;
      } ;

    mkNP = overload {
      mkNP : NP 
        = this_NP ;
      mkNP : Pron -> NP
        = UsePron ;
      mkNP : PN -> NP
        = UsePN ;
      mkNP : Quant -> N -> NP
        = \q,n -> DetCN (DetSg (SgQuant q) NoOrd) (UseN n) ;
      mkNP : Predet -> N -> NP 
        = \q,n -> PredetNP q (DetCN (DetPl (PlQuant IndefArt) NoNum NoOrd) (UseN n))
      } ;

}
