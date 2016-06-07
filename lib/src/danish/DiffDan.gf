instance DiffDan of DiffScand = open CommonScand, Prelude in {
  flags coding=utf8 ;

-- Parameters.

  oper
    NGender = Gender ; 
    ngen2gen g = g ;
    utrum = Utr ; 
    neutrum = Neutr ;

    detDef : Species = Indef ;

    Verb : Type = {
      s : VForm => Str ;
      part : Str ;
      vtype : VType ;
      isVaere : Bool
      } ;

    hasAuxBe v = v.isVaere ;

-- Strings.

    conjThat = "at" ;
    conjThan = "end" ;
    conjAnd = "og" ;
    infMark  = "at" ;
    compMore = "mere" ;

    subjIf = "hvis" ;

    artIndef : NGender => Str = table {
      Utr   => "en" ;
      Neutr => "et"
      } ;
    detIndefPl = "nogle" ;

    verbHave = 
      mkVerb9 "have" "har" "hav" "havde" "haft" "haven" "havet" "havne" "havende" **
      {part = [] ; isVaere = False} ;
    verbBe = 
      mkVerb9 "være" "er" "var" "var" "været" "væren" "været" "værne" "værende" **
      {part = [] ; isVaere = False} ;
    verbBecome = 
      mkVerb9 "blive" "bliver" "bliv" "blev" "blevet" 
        "bliven" "blivet" "blivne" "blivende" **
      {part = [] ; isVaere = True} ;

    auxFut = "vil" ;      -- "skal" in ExtDan
    auxFutKommer    = "vil" ;
    auxFutPart = "" ;
    auxCond = "ville" ;

    negation : Polarity => Str = table {
      Pos => [] ;
      Neg => "ikke"
      } ;

    genderForms : (x1,x2 : Str) -> NGender => Str = \all,allt -> 
      table {
        Utr  => all ;
        Neutr => allt
        } ;

    relPron : Gender => Number => RCase => Str = \\g,n,c => case c of {
      RNom => "der" ; --- could be som as well
      RAcc | RPrep False => "som" ;
      RGen  => "hvis" ;
      RPrep _ => gennumForms "hvilken" "hvilket" "hvilke" ! gennum g n
      } ;

    pronSuch = gennumForms "sådan" "sådant" "sådanne" ;

    reflPron : Agr -> Str = \a -> case <a.n,a.p> of {
      <Pl,P1> => "os" ;
      <Pl,P2> => "jer" ;
      <Sg,P1> => "mig" ;
      <Sg,P2> => "dig" ;
      <_, P3> => "sig"
      } ;

    hur_IAdv = {s = "hvor"} ;

    av_Prep = "af" ;

    possPron : Number -> Person -> Number -> Gender -> Str = \sn,sb,on,og -> case <sn,sb,on,og> of {
       <Sg,P1,Sg,Utr>   => "min" ;
       <Sg,P1,Sg,Neutr> => "mit" ;
       <Sg,P1,Pl,_>     => "mine" ;
       <Sg,P2,Sg,Utr>   => "din" ;
       <Sg,P2,Sg,Neutr> => "dit" ;
       <Sg,P2,Pl,_>     => "dine" ;
       <Pl,P1,_,_>      => "vores" ;
       <Pl,P2,_,_>      => "jeres" ;
       <_,_,Sg,Utr>     => "sin" ;
       <_,_,Sg,Neutr>   => "sit" ;
       <_,_,Pl,_>       => "sine"
       } ;

}
