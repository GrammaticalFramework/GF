incomplete resource Combinators = open Grammar in {

  oper

    pred = overload {
      pred : V  -> NP -> Cl
                                       = \v,np -> PredVP np (UseV v) ;
      pred : V2 -> NP -> NP -> Cl
                                       = \v,np,ob -> PredVP np (ComplV2 v ob) ;
      pred : V3 -> NP -> NP -> NP -> Cl 
                                       = \v,np,ob,ob2 -> 
                                          PredVP np (ComplV3 v ob ob2) ;
      pred : V  -> NP -> NP -> Cl
                                       = \v,x,y -> PredVP (ConjNP and_Conj (BaseNP x y)) (UseV v) ;
      pred : A  -> NP -> Cl 
                                       = \a,np -> PredVP np (UseComp (CompAP (PositA a))) ;
      pred : A2 -> NP -> NP -> Cl
                                       = \a,x,y -> PredVP x (UseComp (CompAP (ComplA2 a y))) ;
      pred : A  -> NP -> NP -> Cl      
                                       = \a,x,y -> PredVP (ConjNP and_Conj (BaseNP x y)) (UseComp (CompAP (PositA a))) ;
      pred : N -> NP -> Cl
                                       = \n,x -> PredVP x (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) (UseN n)))) ;
      pred : CN -> NP -> Cl
                                       = \n,x -> PredVP x (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) n))) ;
      pred : NP -> NP -> Cl
                                       = \n,x -> PredVP x (UseComp (CompNP n)) ;      pred : N2 -> NP -> NP -> Cl 
                                       = \n,x,y -> PredVP x (UseComp (CompNP (DetCN (DetSg (SgQuant IndefArt) NoOrd) (ComplN2 n y)))) ;
      pred : N -> NP -> NP -> Cl 
                                       = \n,x,y -> PredVP (ConjNP and_Conj (BaseNP x y)) (UseComp (CompNP (DetCN (DetPl (PlQuant IndefArt) NoNum NoOrd) (UseN n)))) ;
      pred : Adv -> NP -> Cl 
                                       = \a,x -> PredVP x (UseComp (CompAdv a)) ;
      pred : Prep -> NP -> NP -> Cl        
                                       = \p,x,y -> PredVP x (UseComp (CompAdv (PrepNP p y)))

      } ;

    app = overload {
      app : N  -> NP
                                       = \n -> DetCN (DetSg (SgQuant DefArt) NoOrd) (UseN n) ;
      app : N2 -> NP -> NP 
                                       = \n,x -> DetCN (DetSg (SgQuant DefArt) NoOrd) (ComplN2 n x) ;
      app : N3 -> NP -> NP -> NP
                                       = \n,x,y -> DetCN (DetSg (SgQuant DefArt) NoOrd) (ComplN2 (ComplN3 n x) y) ;
      app : N2 -> NP -> NP -> NP
                                       = \n,x,y -> DetCN (DetSg (SgQuant DefArt) NoOrd) (ComplN2 n (ConjNP and_Conj (BaseNP x y))) ;
      app : N2 -> N -> CN
                                       = \f,n -> ComplN2 f (DetCN (DetPl (PlQuant IndefArt) NoNum NoOrd) (UseN n))
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

    mod = overload {
      mod : A -> N -> CN
                                  = \a,n -> AdjCN (PositA a) (UseN n) ;
      mod : AP -> CN -> CN
                                  = \a,n -> AdjCN a n ;
      mod : AdA -> A -> AP
                                  = \m,a -> AdAP m (PositA a) ;
      mod : Quant -> N -> NP
                                  = \q,n -> DetCN (DetSg (SgQuant q) NoOrd) (UseN n) ;
      mod : Quant -> CN -> NP
                                  = \q,n -> DetCN (DetSg (SgQuant q) NoOrd) n ;
      mod : Predet -> N -> NP 
                                  = \q,n -> PredetNP q (DetCN (DetPl (PlQuant IndefArt)  NoNum NoOrd) (UseN n)) ;
      mod : Numeral -> N -> NP
                                  = \nu,n -> DetCN (DetPl (PlQuant IndefArt) (NumNumeral nu) NoOrd) (UseN n)

      } ;

-- This is not in ground API, because it would destroy parsing.

    appendText : Text -> Text -> Text 
                = \x,y -> {s = x.s ++ y.s ; lock_Text = <>} ;

}
