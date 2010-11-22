concrete AggregationEng of Aggregation = {

lincat S, NP, VP = Str ;

lin 
  PredVP x y = x ++ y ;
  ConjS  a b = a ++ "or" ++ b ;
  ConjVP a b = a ++ "or" ++ b ;
  ConjNP a b = a ++ "or" ++ b ;

  Run = "runs" ;
  Walk = "walks" ;
  John = "John" ;
  Mary = "Mary" ;

}

