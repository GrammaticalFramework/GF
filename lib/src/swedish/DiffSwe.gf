instance DiffSwe of DiffScand = open CommonScand, Prelude in {
  flags coding=utf8 ;

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
      mkVerb9 "ha" "har" "ha" "hade" "haft" "havd" "havt" "havda" "havande" ** noPart ;
    verbBe = 
      mkVerb9 "vara" "är" "var" "var" "varit" "varen" "varet" "varna" "varande"
      ** noPart ;
    verbBecome = 
      mkVerb9 "bli" "blir" "bli" "blev" "blivit" "bliven" "blivet" "blivna" "blivande"
      ** noPart ;

    -- auxiliary
    noPart = {part = []} ;

    auxFut = "ska" ;      -- "skall" in ExtSwe
    auxFutKommer = "kommer" ; 
    auxFutPart = "" ; 
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
      RNom | RAcc | RPrep False => "som" ;
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

    hur_IAdv = {s = "hur"} ;
    av_Prep = "av" ;

    possPron : Number -> Person -> Number -> Gender -> Str = \sn,sb,on,og -> case <sn,sb,on,og> of {
       <Sg,P1,Sg,Utr>   => "min" ;
       <Sg,P1,Sg,Neutr> => "mitt" ;
       <Sg,P1,Pl,_>     => "mina" ;
       <Sg,P2,Sg,Utr>   => "din" ;
       <Sg,P2,Sg,Neutr> => "ditt" ;
       <Sg,P2,Pl,_>     => "dina" ;
       <Pl,P1,Sg,Utr>   => "vår" ;
       <Pl,P1,Sg,Neutr> => "vårt" ;
       <Pl,P1,Pl,_>     => "våra" ;
       <Pl,P2,Sg,Utr>   => "er" ;
       <Pl,P2,Sg,Neutr> => "ert" ;
       <Pl,P2,Pl,_>     => "era" ;
       <_,_,Sg,Utr>     => "sin" ;
       <_,_,Sg,Neutr>   => "sitt" ;
       <_,_,Pl,_>       => "sina"
       } ;
       

}
