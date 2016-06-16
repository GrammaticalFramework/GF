instance DiffNor of DiffScand = open CommonScand, Prelude in {
  flags coding=utf8 ;

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
      mkVerb9 "ha" "har" "ha" "hadde" "hatt" "haven" "havet" "havne" "havende"
      **       {part = [] ; isVaere = False} ;
    verbBe = 
      mkVerb9 "være" "er" "var" "var" "vært" "væren" "været" "værne" "værende"
      **       {part = [] ; isVaere = False} ;
    verbBecome = 
      mkVerb9 "bli" "blir" "bli" "ble" "blitt" "bliven" "blivet" "blivne" "blivende" 
      **       {part = [] ; isVaere = True} ;

    -- auxiliary
    noPart = {part = []} ;

    auxFut = "vil" ;      -- "skal" in ExtNor
    auxFutKommer = "kommer" ; 
    auxFutPart = "til" ; 
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
      RNom | RAcc | RPrep False => "som" ;
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

    av_Prep = "av" ;

    possPron : Number -> Person -> Number -> Gender -> Str = \sn,sb,on,og -> case <sn,sb,on,og> of {
       <Sg,P1,Sg,Utr>   => "min" ;
       <Sg,P1,Sg,Neutr> => "mitt" ;
       <Sg,P1,Pl,_>     => "mine" ;
       <Sg,P2,Sg,Utr>   => "din" ;
       <Sg,P2,Sg,Neutr> => "ditt" ;
       <Sg,P2,Pl,_>     => "dine" ;
       <Pl,P1,Sg,Utr>   => "vår" ;
       <Pl,P1,Sg,Neutr> => "vårt" ;
       <Pl,P1,Pl,_>     => "våre" ;
       <Pl,P2,_,_>      => "deres" ;
       <_,_,Sg,Utr>     => "sin" ;
       <_,_,Sg,Neutr>   => "sitt" ;
       <_,_,Pl,_>       => "sine"
       } ;
}
