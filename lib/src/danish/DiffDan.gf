instance DiffDan of DiffScand = open CommonScand, Prelude in {

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
      mkVerb "have" "har" "hav" "havde" "haft" "haven" "havet" "havne" **
      {part = [] ; isVaere = False} ;
    verbBe = 
      mkVerb "være" "er" "var" "var" "været" "væren" "været" "værne" **
      {part = [] ; isVaere = False} ;
    verbBecome = 
      mkVerb "blive" "bliver" "bliv" "blev" "blevet" 
        "bliven" "blivet" "blivne"  **
      {part = [] ; isVaere = True} ;

    auxFut = "vil" ;      -- "skal" in ExtDan
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
      RNom | RPrep False => "som" ;
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

}
