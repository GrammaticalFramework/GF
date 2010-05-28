--# -path=.:../romance:../abstract:../common:prelude

instance DiffCat of DiffRomance = open CommonRomance, PhonoCat, BeschCat, Prelude in {

  flags optimize=noexpand ;

  param 
    Prepos = P_de | P_a ;
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
        <Masc,Sg, CPrep P_de> => pre {"del" ; ["de l'"] / vocalForta} ;
        <Masc,Sg, CPrep P_a>  => pre {"al" ; ["a l'"]  / vocalForta} ;
        <Masc,Sg, _>    => elisEl ;
        <Fem, Sg, _>    => prepCase c ++ elisLa ;
        <_,   Pl, CPrep P_de> => "dels" ;
        <_,   Pl, CPrep P_a>  => "als" ;
        <Masc,   Pl, _ >   => "els" ;
        <Fem,   Pl, _ >   => "les"
        } ;

        

    artIndef = \g,n,c -> case <n,c> of {
      <Sg,CPrep P_de>   => genForms ["d' un"] ["d' una"] ! g ;
      <Sg,_> => prepCase c ++ genForms "un" "una" ! g ;
                           ---      <Pl,CPrep P_de> => genForms ["d' uns"] ["d' unes"] ! g ;
      <Pl,_> => prepCase c --- ++ genForms "uns" "unes" ! g --- take this as a determiner
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

    auxVerb : VType -> (VF => Str) = \_ -> haver_V.s ;

    partAgr : VType -> VPAgr = \vtyp -> vpAgrNone ;

    vpAgrClit : Agr -> VPAgr = \a ->
      vpAgrNone ;

  pronArg = \n,p,acc,dat ->
      let 
        paccp = case acc of {
          CRefl   => <reflPron n p Acc, p,True> ;
          CPron ag an ap => <argPron ag an ap Acc, ap,True> ;
          _ => <[],P2,False>
          } ;
        pdatp = case dat of {
          CPron ag an ap => <argPron ag an ap dative, ap,True> ;
          _ => <[],P2,False>
          }
       in case <paccp.p2, pdatp.p2> of {
         ---- AR 8/6/2008 efficiency problem in pgf generation: 
         ---- replace the case expr with
         ---- a constant produces an error in V3 predication with two pronouns
         ---- <P3,P3> => <"se" ++ paccp.p1, [],True> ;
         _       => <pdatp.p1 ++ paccp.p1, [],orB paccp.p3 pdatp.p3>
         } ;
         
    --case <p,acc,dat> of {
    --    <Sg,P2,CRefl,CPron {n = Sg ; p = P1}> => <"te" ++ "me", []> ;
    --    <_,_,CPron {n = Sg ; p = P2},CPron {n = Sg ; p = P1}> => <"te" ++ "me", []> ;

   infForm _ _ _ _  = True ;
 
   mkImperative b p vp =
      \\pol,g,n => 
        let 
          pe    = case b of {True => P3 ; _ => p} ;
          agr   = {g = g ; n = n ; p = pe} ;
          clpr  = <[],[],False> ; ----e pronArg agr.n agr.p vp.clAcc vp.clDat ;
----e          verb  = case <aag.n, pol,pe> of {
----e            <Sg,Neg,P2> => (vp.s ! VPInfinit Simul clpr.p3).inf ! aag ;
----e            _ => (vp.s ! VPImperat).fin ! agr
----e            } ;
          verb  = vp.s.s ! vImper n pe ; ----e
          neg   = vp.neg ! pol ;
          compl = neg.p2 ++ clpr.p2 ++ vp.comp ! agr ++ vp.ext ! pol
        in
        neg.p1 ++ verb ++ bindIf clpr.p3 ++ clpr.p1 ++ compl ;

    negation : Polarity => (Str * Str) = table {
      Pos => <[],[]> ;
      Neg => <"no",[]>
      } ;

    conjThan = "que" ;
    conjThat = "que" ;
    subjIf = "si" ;


   
    clitInf b cli inf = inf ++ bindIf b ++ cli ; --- JS copied from DiffSpa

    relPron : Bool => AAgr => Case => Str = \\b,a,c => 
      case c of {
        Nom | Acc => "que" ;
        CPrep P_a => "cuyo" ;
        _ => prepCase c ++ "cuyo"
        } ;

    pronSuch : AAgr => Str = aagrForms "tal" "tal" "tals" "tals" ;

    quelPron : AAgr => Str = aagrForms "qual" "qual" "quals" "quals" ;

    partQIndir = [] ; ---- ?

    reflPron : Number -> Person -> Case -> Str = \n,p,c -> 
        let pro = argPron Fem n p c 
        in
        case p of { 
        P3 => case c of {
          Acc | CPrep P_a => "se" ;
          _ => "sÌ"
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
        <_,Sg,P1> => cases "em" "mí" ;
        <_,Sg,P2> => cases "et" "tú" ;
        <_,Pl,P1> => cases "ens" "nosaltres" ; --- nosotros
        <_,Pl,P2> => cases "us" "vosaltres" ; --- vosotros
        <Fem,Sg,P3> => cases3 "la" "li" "ella" ;
        <Masc,  Sg,P3> => cases3 "el" "li" "ell" ;
        <Fem,Pl,P3> => cases3 "les" "les" "elles" ;
        <Masc,  Pl,P3> => cases3 "els" "els" "ells"
        } ;

    vRefl   : VType = VRefl ;
    isVRefl : VType -> Bool = \ty -> case ty of {
      VRefl => True ;
      _ => False
      } ;

    auxPassive : Verb = copula ;

    copula = verbBeschH (ser_52 "ser") ;

    haver_V : Verb = verbBeschH (haver_59 "haver" True) ;

    verbBeschH : Verbum -> Verb = \v -> verbBesch v ** {vtyp = VHabere} ;

}
