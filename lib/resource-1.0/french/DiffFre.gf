--# -path=.:../romance:../abstract:../common:prelude

instance DiffFre of DiffRomance = open ResRomance, PhonoFre, Prelude in {

  param 
    Prep = P_de | P_a ;
    VAux = VHabere | VEsse ;

  oper
    dative : Case = CPrep P_a ;
    genitive : Case = CPrep P_de ;

    complAcc : Compl = {s = [] ; c = Acc} ;
    complGen : Compl = {s = [] ; c = genitive} ;
    complDat : Compl = {s = [] ; c = dative} ;

    prepCase : Case -> Str = \c -> case c of {
      Nom => [] ;
      Acc => [] ; 
      CPrep P_a => "à" ;
      CPrep P_de => elisDe
      } ;

    artDef : Gender -> Number -> Case -> Str = \g,n,c ->
      case <g,n,c> of {
        <Masc,Sg, CPrep P_de> => pre {"du" ; ["de l'"] / voyelle} ;
        <Masc,Sg, CPrep P_a>  => pre {"au" ; ["à l'"]  / voyelle} ;
        <Masc,Sg, _>    => elisLe ;
        <Fem, Sg, _>    => prepCase c ++ elisLa ;
        <_,   Pl, CPrep P_de> => "des" ;
        <_,   Pl, CPrep P_a>  => "aux" ;
        <_,   Pl, _ >   => "les"
        } ;

-- In these two, "de de/du/des" becomes "de".

    artIndef = \g,n,c -> case <n,c> of {
      <Sg,_>   => prepCase c ++ genForms "un" "une" ! g ;
      <Pl,CPrep P_de> => elisDe ;
      _        => prepCase c ++ "des"
      } ;

    partitive = \g,c -> case c of {
      CPrep P_de => elisDe ;
      _ => prepCase c ++ artDef g Sg (CPrep P_de)
      } ;

}
