--# -path=.:../romance:../abstract:../common:prelude

instance DiffSpa of DiffRomance = open CommonRomance, PhonoSpa, BeschSpa, Prelude in {

  param 
    Prep = P_de | P_a ;
    VType = VHabere | VRefl ;

  oper
    dative   : Case = CPrep P_a ;
    genitive : Case = CPrep P_de ;

    prepCase = \c -> case c of {
      Nom => [] ;
      Acc => [] ; 
      CPrep P_de => "de" ;
      CPrep P_a  => "a"
      } ;

    artDef : Gender -> Number -> Case -> Str = \g,n,c ->
      case <g,n,c> of {
        <Masc,Sg, CPrep P_de> => "del" ;
        <Masc,Sg, CPrep P_a>  => "al" ;
        <Masc,Sg, _>          => prepCase c ++ "el" ;
        <Fem ,Sg, _> => prepCase c ++ "la" ;
        <Masc,Pl, _> => prepCase c ++ "los" ;
        <Fem ,Pl, _> => prepCase c ++ "las"
        } ;

-- In these two, "de de/du/des" becomes "de".

    artIndef = \g,n,c -> case n of {
      Sg  => prepCase c ++ genForms "un"   "una" ! g ;
      _   => prepCase c ++ genForms "unos" "unas" ! g
      } ;

    partitive = \g,c -> case c of {
      CPrep P_de => "de" ;
      _ => prepCase c ++ artDef g Sg (CPrep P_de)
      } ;

    conjunctCase : NPForm -> NPForm = \c -> case c of {
      Ton Nom | Aton Nom => Ton Nom ;
      _ => Ton Acc 
      } ;

    auxVerb : VType -> (VF => Str) = \_ -> haber_V.s ;

    partAgr : VType -> VPAgr = \vtyp -> case vtyp of {
      VHabere => vpAgrNone ;
      _ => VPAgrSubj
      } ;

    vpAgrClit : Agr -> VPAgr = \a ->
      vpAgrNone ;

    negation : Polarity => (Str * Str) = table {
      Pos => <[],[]> ;
      Neg => <"no",[]>
      } ;

    conjThan = "que" ;
    conjThat = "que" ;

    clitInf cli inf = inf ++ cli ; --- contraction of inf

    relPron : Bool => AAgr => Case => Str = \\b,a,c => 
      case c of {
        Nom | Acc => "que" ;
        CPrep P_a => "cuyo" ;
        _ => prepCase c ++ "cuyo"
        } ;

    pronSuch : AAgr => Str = aagrForms "tál" "tál" "tales" "tales" ;

    quelPron : AAgr => Str = aagrForms "cuál" "cuál" "cuales" "cuales" ;

    partQIndir = [] ; ---- ?

    reflPron : Number => Person => Case => Str = 
      let 
        cases : (x,y : Str) -> (Case => Str) = \me,moi -> table {
          Acc | CPrep P_a => me ;
          _ => moi
          } ;
      in 
      \\n,p => case <n,p> of { 
        <Sg,P1> => cases "mi" "me" ;
        <Sg,P2> => cases "ti" "te" ;
        <Pl,P1> => cases "ci" "noi" ; -- unlike French with just one alt!
        <Pl,P2> => cases "vi" "voi" ;
        _ => cases "si" "se"
        } ;

    vRefl   : VType = VRefl ;
    isVRefl : VType -> Bool = \ty -> case ty of {
      VRefl => True ;
      _ => False
      } ;

    auxPassive : Verb = copula ;

    copula = verbBeschH (ser_1 []) ;

    haber_V : Verb = verbBeschH (haber_3 []) ;

    verbBeschH : Verbum -> Verb = \v -> verbBesch v ** {vtyp = VHabere} ;

}
