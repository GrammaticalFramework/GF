abstract Database = {

flags startcat=Query ;

cat 
  Query ; Phras ; Statement ; Question ;
  Noun ; Subject ; Value ; Property ; Relation ; Comparison ; Name ;
  Feature ;

fun 
  LongForm  : Phras -> Query ;
  ShortForm : Phras -> Query ;

  WhichAre  : Noun -> Property    -> Phras ;
  IsThere   : Noun                -> Phras ;
  AreThere  : Noun                -> Phras ;
  IsIt      : Subject -> Property -> Phras ; 
  WhatIs    : Value               -> Phras ;

  MoreThan   : Comparison -> Subject -> Property ;
  TheMost    : Comparison -> Noun -> Value ;
  Relatively : Comparison -> Noun -> Property ;

  RelatedTo  : Relation -> Subject -> Property ;

  Individual : Name -> Subject ;
  AllN       : Noun -> Subject ;
  Any        : Noun -> Subject ;
  MostN      : Noun -> Subject ;
  EveryN     : Noun -> Subject ;

  FeatureOf  : Feature -> Subject -> Subject ;
  ValueOf    : Feature -> Name -> Value ;

  WithProperty : Noun -> Property -> Noun ;
} ;
