--# -path=.:../romance:../abstract:../common:prelude

instance DiffIta of DiffRomance = open CommonRomance, PhonoIta, BeschIta, Prelude in {

  param 
    Prep = P_di | P_a | P_da | P_in | P_su | P_con ;
    VType = VHabere | VEsse | VRefl ;

  oper
    dative   : Case = CPrep P_a ;
    genitive : Case = CPrep P_di ;

    prepCase = \c -> case c of {
      Nom | Acc => [] ;
      CPrep p => case p of {
        P_di => "di" ;
        P_a  => "a" ;
        P_da => "da" ;
        P_in => "in" ;
        P_su => "su" ;
        P_con => "con"
        }
      } ;

    artDef : Gender -> Number -> Case -> Str = \g,n,c ->
      case <g,n,c> of {
        <_, _, CPrep P_di>  => prepArt "de" ;
        <_, _, CPrep P_da>  => prepArt "da" ;
        <_, _, CPrep P_a>   => prepArt "a" ;
        <_, _, CPrep P_in>  => prepArt "ne" ;
        <_, _, CPrep P_su>  => prepArt "su" ;
        <_, _, CPrep P_con> => prepArt "co" ;
        <Masc,Sg, Nom| Acc> => elision "il" "l'" "lo" ;
        <Fem ,Sg, _>        => elision "la" "l'" "la" ;
        <Masc,Pl, _>        => elision "i" "gli" "gli" ;
        <Fem ,Pl, _>        => "le"
        } 
       where {
         prepArt : Tok -> Tok = \de -> case <g,n> of {
           <Masc,Sg> => elision (de + "l")   (de + "ll'") (de + "llo") ;
           <Masc,Pl> => elision (de + "i")   (de + "gli") (de + "gli") ;
           <Fem, Sg> => elision (de + "lla") (de + "ll'") (de + "lla") ;
           <Fem, Pl> => de + "lle"
           }
         } ;


-- In these two, "de de/du/des" becomes "de".

    artIndef = \g,n,c -> case <n,c> of {
      <Sg,_>   => prepCase c ++ 
                  genForms (elision "un" "un" "uno") (elision "una" "un'" "una") ! g ;
      _        => prepCase c 
      } ;

    partitive = \g,c -> case c of {
      CPrep P_di => "di" ;
      _ => prepCase c ++ artDef g Sg (CPrep P_di)
      } ;

    conjunctCase : NPForm -> NPForm = \c -> case c of {
      Ton Nom | Aton Nom => Ton Nom ;
      _ => Ton Acc 
      } ;

    auxVerb : VType -> (VF => Str) = \vtyp -> case vtyp of {
      VHabere => avere_V.s ;
      _ => copula.s
      } ;

    partAgr : VType -> VPAgr = \vtyp -> case vtyp of {
      VHabere => vpAgrNone ;
      _ => VPAgrSubj
      } ;

    vpAgrClit : Agr -> VPAgr = \a ->
      vpAgrNone ;

    negation : Polarity => (Str * Str) = table {
      Pos => <[],[]> ;
      Neg => <"non",[]>
      } ;

    conjThan = "che" ; --- di
    conjThat = "che" ;

    clitInf cli inf = inf ++ cli ; --- contraction of inf

    relPron : Bool => AAgr => Case => Str = \\b,a,c => 
      case c of {
        Nom | Acc => "che" ;
        CPrep P_di => "cui" ;
        _ => prepCase c ++ "cui" --- ilquale
        } ;

    pronSuch : AAgr => Str = aagrForms "tale" "tale" "tali" "tali" ;

    quelPron : AAgr => Str = aagrForms "quale" "quale" "quali" "quali" ;

    partQIndir = "ciò" ;

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

    auxPassive : Verb = venire_V ;

    copula = verbBesch (essere_1 "essere") ** {vtyp = VEsse} ;
    avere_V = verbBesch (avere_2 "avere") ** {vtyp = VHabere} ;
    venire_V = verbBesch (venire_110 "venire") ** {vtyp = VEsse} ;
}
