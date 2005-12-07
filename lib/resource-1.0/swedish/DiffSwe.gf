instance DiffSwe of DiffScand = open ResScand, Prelude in {

-- Parameters.

  param
    Gender = Utr | Neutr ;

  oper
    utrum = Utr ; 
    neutrum = Neutr ;

    gennum : Gender -> Number -> GenNum = \g,n ->
      case <g,n> of {
        <Utr,Sg> => SgUtr ;
        <Neutr,Sg> => SgNeutr ;
        _  => Plg
        } ;

    detDef : Species = Def ;

-- Strings.

    conjThat = "att" ;
    conjThan = "än" ;
    infMark  = "att" ;

    artIndef : Gender => Str = table {
      Utr => "en" ;
      Neutr => "ett"
      } ;

    verbHave = 
      mkVerb "ha" "har" "ha" "hade" "haft" "havd" "havt" "havda" ;

    auxFut = "ska" ;      -- "skall" in ExtSwe
    auxCond = "skulle" ;

    negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "inte"
      } ;
}
