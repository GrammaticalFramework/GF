--# -path=.:../romance:../abstract:../common:prelude

instance DiffPor of DiffRomance - [partAgr,vpAgrSubj,vpAgrClits] = open CommonRomance, PhonoPor, BeschPor, Prelude in {

  flags optimize=noexpand ;
        coding=utf8 ;

---- exceptions ----------------
  oper
    partAgr : VType -> Bool = \vtyp -> False ;
    vpAgrSubj : Verb -> VPAgrType = \v -> <verbDefaultPart v, False> ;
    vpAgrClits : Verb -> AAgr -> VPAgrType = \v,a -> <verbDefaultPart v, False> ;

--------------------------------

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


    artDef : Bool -> Gender -> Number -> Case -> Str = \isNP,g,n,c ->
      case isNP of {
       True => case <g,n,c> of {
        <Masc,Sg, _>          => prepCase c ++ "o" ;
	<Fem, Sg, _> => prepCase c ++ "a" ; ----- ??
        <Masc,Pl, _> => prepCase c ++ "os" ;
        <Fem ,Pl, _> => prepCase c ++ "as"
        } ;
       False => case <g,n,c> of {
        <Masc,Sg, CPrep P_de> => "do" ;
        <Masc,Sg, CPrep P_a>  => "ao" ;
        <Masc,Sg, _>          => prepCase c ++ "o" ;
        <Fem ,Sg, CPrep P_de> => "da" ;
        <Fem ,Sg, CPrep P_a>  => "à" ;
	<Fem, Sg, _> => prepCase c ++ "a" ;
        <Masc,Pl, _> => prepCase c ++ "os" ;
        <Fem ,Pl, _> => prepCase c ++ "as"
        }
      } ;

    artIndef = \isNP,g,n,c -> case isNP of {
      True => case n of {
        Sg  => prepCase c ++ genForms "um"  "uma" ! g ;
        _   => prepCase c ++ genForms "uns" "umas" ! g
        } ;
      _ => case n of {
        Sg  => prepCase c ++ genForms "um"   "uma" ! g ;
        _   => prepCase c
        }
      } ;

    possCase = \_,_,c -> prepCase c ;

    partitive = \_,c -> prepCase c ;

{-
    partitive = \g,c -> case c of {
      CPrep P_de => "de" ;
      _ => prepCase c ++ artDef g Sg (CPrep P_de)
      } ;
-}

    conjunctCase : Case -> Case = \c -> case c of {
      Nom => Nom ;
      _ => Acc
      } ;

    auxVerb : VType -> (VF => Str) = \_ -> haver_V.s ;

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
          } ;
        peither = case acc of {
          CRefl | CPron _ _ _ => True ;
          _ => case dat of {
            CPron _ _ _ => True ;
            _ => False
            }
          } ;
        defaultPronArg = <pdatp.p1 ++ paccp.p1, [], peither>
----        defaultPronArg = <pdatp.p1 ++ paccp.p1, [], orB paccp.p3 pdatp.p3>
      in
      ----  case <<paccp.p2, pdatp.p2> : Person * Person> of {
      ----     <P3,P3> => <"se" ++ paccp.p1, [], True> ;
      ----     _ => defaultPronArg
      ---     } ;
      ---- 8/6/2008 efficiency problem in pgf generation: replace the case expr with
      ---- a constant produces an error in V3 predication with two pronouns
         defaultPronArg ;

    infForm _ _ _ _  = True ;

    mkImperative b p vp =
      \\pol,g,n =>
        let
          pe    = case b of {True => P3 ; _ => p} ;
          agr   = {g = g ; n = n ; p = pe} ;
          refl  = case vp.s.vtyp of {
            VRefl => <reflPron n pe Acc,True> ;
            _ => <[],False>
            } ;

          clpr  =  <vp.clit1 ++ vp.clit2, [],vp.clit3.hasClit> ;
----          clpr  = <[],[],False> ; ----e pronArg agr.n agr.p vp.clAcc vp.clDat ;
----e          verb  = case <aag.n, pol,pe> of {
----e            <Sg,Neg,P2> => (vp.s ! VPInfinit Simul clpr.p3).inf ! aag ;
----e            _ => (vp.s ! VPImperat).fin ! agr
----e            } ;
          verb  = vp.s.s ! vImper n pe ;
          neg   = vp.neg ! pol ;
          compl = neg.p2 ++ clpr.p2 ++ vp.comp ! agr ++ vp.ext ! pol
        in
        neg.p1 ++ verb ++ bindIf refl.p2 ++ refl.p1 ++ bindIf clpr.p3 ++ clpr.p1 ++ compl ;

    CopulaType = Bool ;
    selectCopula = \isEstar -> case isEstar of {True => estar_V ; False => copula} ;
    serCopula = False ;
    estarCopula = True ;

    negation : RPolarity => (Str * Str) = table {
      RPos => <[],[]> ;
      RNeg _ => <"no",[]>
      } ;

    conjThan = "que" ;
    conjThat = "que" ;
    subjIf = "si" ;


    clitInf b cli inf = inf ++ bindIf b ++ cli ;

    relPron : Bool => AAgr => Case => Str = \\b,a,c =>
      case c of {
        Nom | Acc => "que" ;
        CPrep P_a => "cujo" ;
        _ => prepCase c ++ "cujo"
        } ;

    pronSuch : AAgr => Str = aagrForms "tal" "tal" "tais" "tais" ;

    quelPron : AAgr => Str = aagrForms "qual" "qual" "quais" "quais" ;

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
      \g,n,p -> case <<g,n,p> : Gender * Number * Person> of {
        <_,Sg,P1> => cases "me" "mí" ;
        <_,Sg,P2> => cases "te" "tí" ;
        <_,Pl,P1> => cases "nos" "nosotras" ; --- nosotros
        <_,Pl,P2> => cases "vos" "vosotras" ; --- vosotros
        <Fem,Sg,P3> => cases3 "la" "le" "ella" ;
        <_,  Sg,P3> => cases3 "lo" "le" "èl" ;
        <Fem,Pl,P3> => cases3 "las" "les" "ellas" ;
        <_,  Pl,P3> => cases3 "los" "les" "ellos"
        } ;

    vRefl _ = VRefl ;
    isVRefl : VType -> Bool = \ty -> case ty of {
      VRefl => True ;
      _ => False
      } ;

    auxPassive : Verb = copula ;

    copula : Verb = verbBeschH (ser_3 "ser") ;

    estar_V : Verb = verbBeschH (estar_10 "estar") ;

    haver_V : Verb = verbBeschH (haver_2 "haver") ;

    ficar_V : Verb = verbBeschH (ficar_12 "ficar") ;

    verbBeschH : Verbum -> Verb = \v -> verbBesch v ** {vtyp = VHabere ; p = []} ;

    subjPron = \_ -> [] ;

    polNegDirSubj = RPos ;

}
