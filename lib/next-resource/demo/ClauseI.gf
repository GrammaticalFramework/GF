incomplete concrete ClauseI of Clause = Cat ** open Grammar in {

lin 
  PredV np v = PredVP np (UseV v) ;
  PredV2 s v o = PredVP s (ComplSlash (SlashV2a v) o) ;
  PredAP s a = PredVP s (UseComp (CompAP a)) ;
  PredAdv s a = PredVP s (UseComp (CompAdv a)) ;

  UseCl = Grammar.UseCl ;

  QuestV np v = QuestVP np (UseV v) ;
  QuestV2 s v o = QuestVP s (ComplSlash (SlashV2a v) o) ;
--  QuestV2Slash ip s v = QuestSlash ip (SlashVP s (SlashV2a v)) ;

  UseQCl = Grammar.UseQCl ;

  ImpV v = ImpVP (UseV v) ;
--  ImpV2 v o = ImpVP (ComplSlash (SlashV2a v) o) ;



}
