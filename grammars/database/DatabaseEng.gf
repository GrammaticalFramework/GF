--# -path=.:../resource/nabstract:../resource/nenglish:../prelude

concrete DatabaseEng of Database = open Prelude, ResEng in {

flags lexer=text ; unlexer=text ;

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
  WhichAre A B = QuestPhrase (IntVP (NounIPMany A) (PosA B)) ;
  IsThere A = QuestPhrase (IsThereCN A) ;
  AreThere A = QuestPhrase (AreThereCN A) ;
  WhatIs val = QuestPhrase (IntVP WhatOne (PosNP val)) ;
  IsIt Q A = QuestPhrase (QuestVP Q (PosA A)) ;

  MoreThan   = ComparAdjP ;
  TheMost    = SuperlNP ;
  Relatively C _ = PositAdjP C ; 

  RelatedTo  = ComplAdj ;

  FeatureOf f x = DefOneNP (AppFun f x) ;
  ValueOf f x = DefOneNP (AppFun f (UsePN x)) ;

  WithProperty A B = ModAdj B A ;

  Individual = UsePN ;

  AllN = DetNP AllDet ;
  MostN = DetNP MostDet ;
  EveryN = DetNP EveryDet ;
  Any = DetNP AnysDet ;

} ;
