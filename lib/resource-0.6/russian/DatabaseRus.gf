concrete DatabaseRus of Database = open Prelude,SyntaxRus,ResourceEng,PredicationRus,ParadigmsRus in {

flags lexer=text ; unlexer=text ; coding=utf8 ;

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

oper
  mkSent : SS -> SS -> SS1 Bool = \long, short -> 
    {s = table {b => if_then_else Str b long.s short.s}} ;

  mkSentPrel : Str -> SS -> SS1 Bool = \prel, matter -> 
    mkSent (ss (prel ++ matter.s)) matter ;

  mkSentSame : SS -> SS1 Bool = \s -> 
    mkSent s s ;

lin
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

  Any = detNounPhrase anyPlDet ; --- in the sense "some", not "all"

  IsThere A  = mkSentPrel ["есть ли"]  (defaultNounPhrase (IndefOneNP A)) ;
  AreThere A = mkSentPrel ["есть ли"] (defaultNounPhrase (IndefManyNP A)) ;

  WhatIs V   = mkSentPrel ["какой"] (defaultNounPhrase V) ;
};
