concrete DatabaseEng of Database = open Prelude,Syntax,English,Predication,Paradigms,DatabaseRes in {

flags lexer=text ; unlexer=text ;

lincat 
  Phras      = SS1 Bool ;            -- long or short form
  Subject    = NP ;
  Noun       = CN ;  
  Property   = AP ;
  Comparison = AdjDeg ;
  Relation   = Adj2 ;
  Feature    = Fun ;
  Value      = NP ;
  Name       = ProperName ;

lin
  LongForm  sent = ss (sent.s ! True ++ "?") ;
  ShortForm sent = ss (sent.s ! False ++ "?") ;

  WhichAre A B = mkSent (defaultQuestion (IntVP (NounIPMany A) (PosA B)))
                        (defaultNounPhrase (IndefManyNP (ModAdj B A))) ;

  IsIt Q A   = mkSentSame (defaultQuestion (QuestVP Q (PosA A))) ;

  MoreThan   = ComparAdjP ;
  TheMost    = SuperlNP ;
  Relatively C _  = PositAdjP C ; 

  RelatedTo  = ComplAdj ;

  FeatureOf = appFun1 ;
  ValueOf F V = appFun1 F (UsePN V) ;

  WithProperty A B = ModAdj B A ;

  Individual = UsePN ;

  AllN = DetNP AllDet ;
  MostN = DetNP MostDet ;
  EveryN = DetNP EveryDet ;

-- only these are language-dependent

  Any = detNounPhrase anyPlDet ; ---

  IsThere A  = mkSentPrel ["is there"]  (defaultNounPhrase (IndefOneNP A)) ;
  AreThere A = mkSentPrel ["are there"] (defaultNounPhrase (IndefManyNP A)) ;

  WhatIs V   = mkSentPrel ["what is"] (defaultNounPhrase V) ;

} ;
