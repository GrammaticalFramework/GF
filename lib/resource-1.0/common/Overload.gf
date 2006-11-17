incomplete resource Overload = open Grammar in {

  oper
    pred = {
      pred : V  -> NP -> Cl
        = \v,np -> PredVP np (UseV v) ;
      pred : V2 -> NP -> NP -> Cl
        = \v,np,ob -> PredVP np (ComplV2 v ob) ;
      pred : V3 -> NP -> NP -> NP -> Cl 
        = \v,np,ob,ob2 -> PredVP np (ComplV3 v ob ob2) ;
      pred : A  -> NP -> Cl 
        = \a,np -> PredVP np (UseComp (CompAP (PositA a)))
      } ;

    mod = {
      mod : A -> N -> CN
        = \a,n -> AdjCN (PositA a) (UseN n) ;
      mod : AP -> N -> CN
        = \a,n -> AdjCN a (UseN n) ;
      mod : AdA -> A -> AP
        = \m,a -> AdAP m (PositA a) ;
      mod : Quant -> N -> NP
        = \q,n -> DetCN (DetSg (SgQuant q) NoOrd) (UseN n) ;
      mod : Quant -> CN -> NP
        = \q,n -> DetCN (DetSg (SgQuant q) NoOrd) n ;
      mod : Predet -> N -> NP 
        = \q,n -> PredetNP q (DetCN (DetPl (PlQuant IndefArt) NoNum NoOrd) (UseN n)) ;
      mod : Num -> N -> NP
        = \nu,n -> DetCN (DetPl (PlQuant IndefArt) nu NoOrd) n

      } ;

    coord = {
      coord : Conj -> Adv -> Adv -> Adv
        = \c,x,y -> ConjAdv and_Conj (BaseAdv x y) ;
      coord : Conj -> AP -> AP -> AP
        = \c,x,y -> ConjAP and_Conj (BaseAP x y) ;
      coord : Conj -> NP -> NP -> NP
        = \c,x,y -> ConjNP and_Conj (BaseNP x y) ;
      coord : Conj -> S  -> S  -> S  
        = \c,x,y -> ConjS and_Conj (BaseS x y)
      } ;


    mkNP = {
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
