abstract Database = {

flags startcat=Query ;

cat 
  Query ; 
  Category ; Subject ; Value ; Property ; Relation ; Comparison ; Name ;
  Feature ;

fun 
  WhichAre  : Category -> Property -> Query ;
  IsThere   : Category             -> Query ;
  AreThere  : Category             -> Query ;
  IsIt      : Subject -> Property  -> Query ; 
  WhatIs    : Value                -> Query ;

  MoreThan   : Comparison -> Subject  -> Property ;
  TheMost    : Comparison -> Category -> Value ;
  Relatively : Comparison -> Category -> Property ;

  RelatedTo  : Relation -> Subject -> Property ;

  Individual : Name -> Subject ;
  AllN       : Category -> Subject ;
  Any        : Category -> Subject ;
  MostN      : Category -> Subject ;
  EveryN     : Category -> Subject ;

  FeatureOf  : Feature -> Subject -> Subject ;
  ValueOf    : Feature -> Name -> Value ;

  WithProperty : Category -> Property -> Category ;
} ;
