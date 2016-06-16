instance DiffNno of DiffScand = open CommonScand, Prelude in {
  flags coding=utf8 ;

-- Parameters.

  oper
    NGender = NGenderNno ;

    ngen2gen g = case g of {NUtr _ => Utr ; NNeutr => Neutr} ;

  param
    NGenderNno = NUtr Sex | NNeutr ;
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
    compMore = "meir" ;
    infMark  = "å" ;

    subjIf = "viss" ;

--    artDef : GenNum -> Str = \gn -> gennumForms "den" "det" "dei" ! gn ;

    artIndef : NGender => Str = table {
      NUtr Masc => "ein" ;
      NUtr Fem  => "ei" ;
      NNeutr    => "eit"
      } ;
    detIndefPl = "noko" ;

    verbHave =
      mkVerb9 "ha" "har" "ha" "hadde" "hatt" "haven" "havet" "havne" "havande"
      **       {part = [] ; isVaere = False} ;
    verbBe =
      mkVerb9 "vere" "er" "var" "var" "vore" "veren" "veret" "verne" "verande"
      **       {part = [] ; isVaere = False} ;
    verbBecome =
      mkVerb9 "verte" "vert" "verte" "vart" "vorte" "vorte" "vorte" "vorte" "vertande"
      **       {part = [] ; isVaere = True} ;

    -- auxiliary
    noPart = {part = []} ;

    auxFut = "vil" ;      -- "skal" in ExtNno
    auxFutKommer = "kjem" ;
    auxFutPart = "til" ;
    auxCond = "ville" ;

    negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "ikkje"
      } ;

    genderForms : (x1,x2 : Str) -> NGender => Str = \all,allt ->
      table {
        NUtr _ => all ;
        NNeutr => allt
        } ;

    relPron : Gender => Number => RCase => Str = \\g,n,c => case c of {
      RNom | RAcc | RPrep False => "som" ;
      RGen  => "viss" ;
      RPrep _ => gennumForms "kva" "kva" "kva" ! gennum g n
      } ;

    pronSuch = gennumForms "slik" "slikt" "slike" ;

    reflPron : Agr -> Str = \a -> case <a.n,a.p> of {
      <Pl,P1> => "oss" ;
      <Pl,P2> => "dykk" ;
      <Sg,P1> => "meg" ;
      <Sg,P2> => "deg" ;
      <_, P3> => "seg"
      } ;

    hur_IAdv = {s = "kvar"} ;

    av_Prep = "av" ;

---- added by AR
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
       <Pl,P2,_,_>      => "dykkar" ;
       <_,_,Sg,Utr>     => "sin" ;
       <_,_,Sg,Neutr>   => "sitt" ;
       <_,_,Pl,_>       => "sine"
       } ;
}
