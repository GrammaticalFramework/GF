incomplete concrete ClauseI of Clause = Cat ** open Grammar in {

lin 
  PredV np v = PredVP np (UseV v) ;
  PredV2 s v o = PredVP s (ComplSlash (SlashV2a v) o) ;
  PredAP s a = PredVP s (UseComp (CompAP a)) ;
  PredAdv s a = PredVP s (UseComp (CompAdv a)) ;

}
