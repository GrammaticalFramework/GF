--# -path=.:../newresource/abstract:../prelude

incomplete concrete DatabaseI of Database = open Prelude, Resource in {

flags lexer=text ; unlexer=text ; startcat=Query ;

lincat 
  Query      = Phr ;
  Subject    = NP ;
  Category   = CN ;  
  Property   = AP ;
  Comparison = AdjDeg ;
  Relation   = Adj2 ;
  Feature    = Fun ;
  Value      = NP ;
  Name       = PN ;

lin
  WhichAre A B = QuestPhrase (IntVP (NounIPMany A) (PosVG (PredAP B))) ;
  IsThere A = QuestPhrase (IsThereNP (IndefOneNP A)) ;
  AreThere A = QuestPhrase (IsThereNP (IndefNumNP NoNum A)) ;
  WhatIs val = QuestPhrase (IntVP WhatOne (PosVG (PredNP val))) ;
  IsIt Q A = QuestPhrase (QuestVP Q (PosVG (PredAP A))) ;

  MoreThan   = ComparAdjP ;
  TheMost    = SuperlNP ;
  Relatively C _ = PositAdjP C ; 

  RelatedTo  = ComplAdj ;

  FeatureOf f x = DefOneNP (AppFun f x) ;
  ValueOf f x = DefOneNP (AppFun f (UsePN x)) ;

  WithProperty A B = ModAdj B A ;

  Individual = UsePN ;

  AllN = DetNP (AllNumDet NoNum) ;
  MostN = DetNP MostsDet ;
  EveryN = DetNP EveryDet ;
  Any = DetNP (AnyNumDet NoNum) ;

} ;
