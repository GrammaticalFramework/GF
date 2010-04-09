instance DiffNor of DiffScand = open CommonScand, Prelude in {

-- Parameters.

  oper
    NGender = NGenderNor ;

    ngen2gen g = case g of {NUtr _ => Utr ; NNeutr => Neutr} ;

  param
    NGenderNor = NUtr Sex | NNeutr ;
    Sex    = Masc | Fem ;

  oper
    utrum = NUtr Masc ; 
    neutrum = NNeutr ;

    detDef : Species = Def ;

    Verb : Type = {
      s : VForm => Str ;
      part : Str ;
      vtype : VType ;
      isVaere : Bool
      } ;

    hasAuxBe v = v.isVaere ;

-- Strings.

    conjThat = "at" ;
    conjThan = "enn" ;
    conjAnd = "og" ;
    compMore = "mere" ;
    infMark  = "å" ;

    subjIf = "hvis" ;

    artIndef : NGender => Str = table {
      NUtr Masc => "en" ;
      NUtr Fem  => "ei" ;
      NNeutr    => "et"
      } ;
    detIndefPl = "noen" ;

    verbHave = 
      mkVerb "ha" "har" "ha" "hadde" "hatt" "haven" "havet" "havne"
      **       {part = [] ; isVaere = False} ;
    verbBe = 
      mkVerb "være" "er" "var" "var" "vært" "væren" "været" "værne" 
      **       {part = [] ; isVaere = False} ;
    verbBecome = 
      mkVerb "bli" "blir" "bli" "ble" "blitt" "bliven" "blivet" "blivne" 
      **       {part = [] ; isVaere = True} ;

    -- auxiliary
    noPart = {part = []} ;

    auxFut = "vil" ;      -- "skal" in ExtNor
    auxCond = "ville" ;

    negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "ikke"
      } ;

    genderForms : (x1,x2 : Str) -> NGender => Str = \all,allt -> 
      table {
        NUtr _ => all ;
        NNeutr => allt
        } ;

    relPron : Gender => Number => RCase => Str = \\g,n,c => case c of {
      RNom | RPrep False => "som" ;
      RGen  => "hvis" ;
      RPrep _ => gennumForms "hvilken" "hvilket" "hvilke" ! gennum g n
      } ;

    pronSuch = gennumForms "sådan" "sådant" "sådanne" ;

    reflPron : Agr -> Str = \a -> case <a.n,a.p> of {
      <Pl,P1> => "oss" ;
      <Pl,P2> => "jer" ;
      <Sg,P1> => "meg" ;
      <Sg,P2> => "deg" ;
      <_, P3> => "seg"
      } ;

    hur_IAdv = {s = "hvor"} ;

}
