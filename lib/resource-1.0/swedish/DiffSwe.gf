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

    subjIf = "om" ;

    artIndef : Gender => Str = table {
      Utr => "en" ;
      Neutr => "ett"
      } ;

    verbHave = 
      mkVerb "ha" "har" "ha" "hade" "haft" "havd" "havt" "havda" ;
    verbBe = 
      mkVerb "vara" "är" "var" "var" "varit" "varen" "varet" "varna" ;

    auxFut = "ska" ;      -- "skall" in ExtSwe
    auxCond = "skulle" ;

    negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "inte"
      } ;

    genderForms : (x1,x2 : Str) -> Gender => Str = \all,allt -> 
      table {
        Utr => all ;
        Neutr => allt
        } ;

}
