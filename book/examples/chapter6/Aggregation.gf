abstract Aggregation = {
  cat S ; NP ; VP ;
  data 
    PredVP : NP -> VP -> S ;
    ConjS  : S -> S -> S ;
    ConjVP : VP -> VP -> VP ;
    ConjNP : NP -> NP -> NP ;
    Run, Walk : VP ;
    John, Mary : NP ;

  fun aggr : S -> S ; -- main aggregation function
  def aggr (ConjS (PredVP x X) (PredVP y Y)) = 
    ifS (eqNP x y) 
      (PredVP x (ConjVP X Y)) 
      (ifS (eqVP X Y) 
         (PredVP (ConjNP x y) X)
         (ConjS (PredVP x X) (PredVP y Y))) ;
  fun ifS : Bool -> S -> S -> S ; -- if b then x else y 
  def
    ifS True  x _ = x ;
    ifS False _ y = y ;
  fun eqNP : NP -> NP -> Bool ;  -- x == y
  def 
    eqNP John John = True ;
    eqNP Mary Mary = True ;
    eqNP _ _ = False ;
  fun eqVP : VP -> VP -> Bool ;  -- X == Y
  def 
    eqVP Run  Run  = True ;
    eqVP Walk Walk = True ;
    eqVP _ _ = False ;
  cat Bool ; data True, False : Bool ;
}
