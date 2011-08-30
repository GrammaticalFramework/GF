abstract NLG = Logic ** {

flags
  startcat = Utt;

cat
  N  (Ind -> Prop);
  A  (Ind -> Prop);
  CN (Ind -> Prop);
  Det ((Ind -> Prop) -> (Ind -> Prop) -> Prop);
  PN Ind;
  NP ((Ind -> Prop) -> Prop);
  AP (Ind -> Prop);
  VP (Ind -> Prop);
  V  (Ind -> Prop);
  V2 (Ind -> Ind -> Prop);
  Comp (Ind -> Prop);
  Pol (Prop -> Prop);
  Cl Prop;
  S Prop;
  Utt;

  Conj (Prop -> Prop -> Prop) ;
  ListNP ((Prop -> Prop -> Prop) -> (Ind -> Prop) -> Prop) ;
  ListS  ((Prop -> Prop -> Prop) -> Prop) ;

fun
  PredVP : ({np} : (Ind -> Prop) -> Prop) ->
           ({vp} : Ind -> Prop) ->
           NP np -> VP vp -> Cl (np vp) ;

  UseV : ({v} : Ind -> Prop) ->
         V v -> VP v ;

  ComplV2 : ({v2} : Ind -> Ind -> Prop) ->
            ({np} : (Ind -> Prop) -> Prop) ->
            V2 v2 -> NP np -> VP (\i -> np (v2 i)) ;
            
  UseComp : ({c} : Ind -> Prop) ->
            Comp c -> VP c ;

  CompAP : ({ap} : Ind -> Prop) ->
           AP ap -> Comp ap ;

  CompNP : ({np} : (Ind -> Prop) -> Prop) ->
           NP np -> Comp (\x -> np (\y -> eq x y)) ;

  UsePN : (i : Ind) -> PN i -> NP (\f -> f i) ;

  DetCN : ({det} : (Ind -> Prop) -> (Ind -> Prop) -> Prop) ->
          ({cn} : Ind -> Prop) ->            
          Det det -> CN cn -> NP (\f -> det cn f);

  AdjCN : ({ap,cn} : Ind -> Prop) ->
          AP ap -> CN cn -> CN (\x -> and (ap x) (cn x)) ;

  PositA : ({a} : Ind -> Prop) ->
           A a -> AP a ;

  UseN : ({n} : Ind -> Prop) -> N n -> CN n;
  
  BaseNP : ({np1,np2} : (Ind -> Prop) -> Prop) ->
           NP np1 -> NP np2 -> ListNP (\conj,f -> conj (np1 f) (np2 f)) ;
  ConsNP : ({np1} : (Ind -> Prop) -> Prop) ->
           ({lst} : (Prop -> Prop -> Prop) -> (Ind -> Prop) -> Prop) ->
           NP np1 -> ListNP lst -> ListNP (\conj,f -> conj (np1 f) (lst conj f)) ;
  ConjNP : ({cnj} : Prop -> Prop -> Prop) ->
           ({lst} : (Prop -> Prop -> Prop) -> (Ind -> Prop) -> Prop) ->
           Conj cnj -> ListNP lst -> NP (lst cnj) ;

  BaseS : ({s1,s2} : Prop) ->
          S s1 -> S s2 -> ListS (\conj -> conj s1 s2) ;
  ConsS : ({s1} : Prop) ->
          ({lst} : (Prop -> Prop -> Prop) -> Prop) ->
          S s1 -> ListS lst -> ListS (\conj -> conj s1 (lst conj)) ;
  ConjS : ({cnj} : Prop -> Prop -> Prop) ->
          ({lst} : (Prop -> Prop -> Prop) -> Prop) ->
          Conj cnj -> ListS lst -> S (lst cnj) ;

  john_PN : PN john;
  mary_PN : PN mary;
  boy_N : N boy;
  somebody_NP  : NP exists;
  everybody_NP : NP forall;
  love_V2 : V2 love ;
  leave_V : V leave ;
  smart_A : A smart ;
  a_Det : Det (\d,f -> exists (\x -> and (d x) (f x)));
  every_Det : Det (\d,f -> forall (\x -> impl (d x) (f x)));
  some_Det : Det (\d,f -> exists (\x -> and (d x) (f x)));
  PPos : Pol (\t -> t) ;
  PNeg : Pol (\t -> not t) ;
  and_Conj : Conj and ;
  or_Conj : Conj or ;
    
  UseCl : ({cl} : Prop) -> 
          ({p} : Prop -> Prop) ->
          Pol p -> Cl cl -> S (p cl);

  UttS : ({s} : Prop) -> S s -> Utt;

}
