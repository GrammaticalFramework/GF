--# -path=.:../romance:../abstract:../common:prelude

instance DiffSpa of DiffRomance = open CommonRomance, PhonoSpa, BeschSpa, Prelude in {

  flags optimize=noexpand ;

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

    possCase = \_,_,c -> prepCase c ;

    partitive = \g,c -> case c of {
      CPrep P_de => "de" ;
      _ => prepCase c ++ artDef g Sg (CPrep P_de)
      } ;

    conjunctCase : NPForm -> NPForm = \c -> case c of {
      Ton Nom | Aton Nom => Ton Nom ;
      _ => Ton Acc 
      } ;

    auxVerb : VType -> (VF => Str) = \_ -> haber_V.s ;

    partAgr : VType -> VPAgr = \vtyp -> vpAgrNone ;

    vpAgrClit : Agr -> VPAgr = \a ->
      vpAgrNone ;

    pronArg = \n,p,acc,dat ->
      let 
        paccp = case acc of {
          CRefl   => <reflPron n p Acc, p> ;
          CPron a => <argPron a.g a.n a.p Acc, a.p> ;
          _ => <[],P2>
          } ;
        pdatp = case dat of {
          CPron a => <argPron a.g a.n a.p dative, a.p> ;
          _ => <[],P2>
          }
       in case <paccp.p2, pdatp.p2> of {
         <P3,P3> => <"se" ++ paccp.p1, []> ;
         _       => <pdatp.p1 ++ paccp.p1, []>
         } ;
--      case <p,acc,dat> of {
--        <Sg,P2,CRefl,CPron {n = Sg ; p = P1}> => <"te" ++ "me", []> ;
--        <_,_,CPron {n = Sg ; p = P2},CPron {n = Sg ; p = P1}> => <"te" ++ "me", []> ;

    mkImperative vp = {
      s = \\pol,aag => 
        let 
          agr   = aag ** {p = P2} ;
          verb  = case <aag.n, pol> of {
            <Sg,Neg> => (vp.s ! VPFinite (VPres Conjunct) Simul).fin ! agr ;
            _ => (vp.s ! VPImperat).fin ! agr
            } ;
          neg   = vp.neg ! pol ;
          clpr  = pronArg agr.n agr.p vp.clAcc vp.clDat ;
          compl = neg.p2 ++ clpr.p2 ++ vp.comp ! agr ++ vp.ext ! pol
        in
        neg.p1 ++ verb ++ clpr.p1 ++ compl ;
      } ;

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

    reflPron : Number -> Person -> Case -> Str = \n,p,c -> 
        let pro = argPron Fem n p c 
        in
        case p of { 
        P3 => case c of {
          Acc | CPrep P_a => "se" ;
          _ => "sí"
          } ;
        _ => pro
        } ; 

    argPron : Gender -> Number -> Person -> Case -> Str = 
      let 
        cases : (x,y : Str) -> Case -> Str = \me,moi,c -> case c of {
          Acc | CPrep P_a => me ;
          _ => moi
          } ;
        cases3 : (x,y,z : Str) -> Case -> Str = \les,leur,eux,c -> case c of {
          Acc => les ;
          CPrep P_a => leur ;
          _ => eux
          } ;
      in 
      \g,n,p -> case <g,n,p> of { 
        <_,Sg,P1> => cases "me" "mí" ;
        <_,Sg,P2> => cases "te" "tí" ;
        <_,Pl,P1> => cases "nos" "nosotras" ; --- nosotros
        <_,Pl,P2> => cases "vos" "vosotras" ; --- vosotros
        <Fem,Sg,P3> => cases3 "la" "le" "ella" ;
        <_,  Sg,P3> => cases3 "lo" "le" "èl" ;
        <Fem,Pl,P3> => cases3 "las" "les" "ellas" ;
        <_,  Pl,P3> => cases3 "los" "les" "ellos"
        } ;

    vRefl   : VType = VRefl ;
    isVRefl : VType -> Bool = \ty -> case ty of {
      VRefl => True ;
      _ => False
      } ;

    auxPassive : Verb = copula ;

    copula = verbBeschH (ser_1 "ser") ;

    haber_V : Verb = verbBeschH (haber_3 "haber") ;

    verbBeschH : Verbum -> Verb = \v -> verbBesch v ** {vtyp = VHabere} ;

}
