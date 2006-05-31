instance DiffSwe of DiffScand = open CommonScand, Prelude in {

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

    Verb : Type = {
      s : VForm => Str ;
      part : Str ;
      vtype : VType
      } ;

    hasAuxBe _ = False ;


-- Strings.

    conjThat = "att" ;
    conjThan = "än" ;
    conjAnd = "och" ;
    infMark  = "att" ;
    compMore = "mera" ;

    subjIf = "om" ;

    artIndef : Gender => Str = table {
      Utr => "en" ;
      Neutr => "ett"
      } ;

    verbHave = 
      mkVerb "ha" "har" "ha" "hade" "haft" "havd" "havt" "havda" ** noPart ;
    verbBe = 
      mkVerb "vara" "är" "var" "var" "varit" "varen" "varet" "varna" 
      ** noPart ;
    verbBecome = 
      mkVerb "bli" "blir" "bli" "blev" "blivit" "bliven" "blivet" "blivna"
      ** noPart ;

    -- auxiliary
    noPart = {part = []} ;

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

    relPron : GenNum => RCase => Str = \\gn,c => case c of {
      RNom  => "som" ;
      RGen  => "vars" ;
      RPrep => gennumForms "vilken" "vilket" "vilka" ! gn
      } ;

    pronSuch = gennumForms "sådan" "sådant" "sådana" ;

    reflPron : Agr -> Str = \a -> case a of {
      {gn = Plg ; p = P1} => "oss" ;
      {gn = Plg ; p = P2} => "er" ;
      {p = P1} => "mig" ;
      {p = P2} => "dig" ;
      {p = P3} => "sig"
      } ;

}
