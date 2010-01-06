instance DiffSwe of DiffScand = open CommonScand, Prelude in {

-- Parameters.

  oper
    NGender = Gender ; 
    ngen2gen g = g ;
    utrum = Utr ; 
    neutrum = Neutr ;

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

    artIndef : NGender => Str = table {
      Utr => "en" ;
      Neutr => "ett"
      } ;
    detIndefPl = "några" ;

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

    genderForms : (x1,x2 : Str) -> NGender => Str = \all,allt -> 
      table {
        Utr => all ;
        Neutr => allt
        } ;

    relPron : Gender => Number => RCase => Str = \\g,n,c => case c of {
      RNom | RPrep False => "som" ;
      RGen  => "vars" ;
      RPrep True => gennumForms "vilken" "vilket" "vilka" ! gennum g n
      } ;

    pronSuch = gennumForms "sådan" "sådant" "sådana" ;

    reflPron : Agr -> Str = \a -> case <a.n,a.p> of {
      <Pl,P1> => "oss" ;
      <Pl,P2> => "er" ;
      <Sg,P1> => "mig" ;
      <Sg,P2> => "dig" ;
      <_, P3> => "sig"
      } ;

}
