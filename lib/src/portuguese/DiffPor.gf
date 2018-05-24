--# -path=.:../romance:../abstract:../common:prelude

instance DiffPor of DiffRomance - [partAgr,vpAgrSubj,vpAgrClits] = open CommonRomance, PhonoPor, BeschPor, Prelude in {

  flags optimize=noexpand ;
        coding=utf8 ;

  param
    Prepos = P_de | P_a ;

    VType = VHabere | VRefl ;

  oper
    partAgr : VType -> Bool ;
    -- exception
    partAgr _ = False ;

    vpAgrSubj : Verb -> VPAgrType ;
    -- exception
    vpAgrSubj v = <verbDefaultPart v, False> ;

  oper
    conjunctCase : Case -> Case = \c -> case c of {
      Nom => Nom ;
      _ => Acc
      } ;

  oper
    clitInf b cli inf = inf ++ bindIf b ++ cli ;

  oper
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
      in
  ---- 8/6/2008 efficiency problem in pgf generation: replace the case
  ---- expr with a constant produces an error in V3 predication with
  ---- two pronouns
      defaultPronArg ;

  oper
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
          verb  = vp.s.s ! vImper n pe ;
          neg   = vp.neg ! pol ;
          compl = neg.p2 ++ clpr.p2 ++ vp.comp ! agr ++ vp.ext ! pol
      in
      neg.p1 ++ verb ++ bindIf refl.p2 ++ refl.p1 ++ bindIf clpr.p3 ++ clpr.p1 ++ compl ;

  oper
    CopulaType = Bool ;
    selectCopula = \isEstar -> case isEstar of {True => estar_V ; False => copula} ;
    serCopula = False ;
    estarCopula = True ;

  oper
    dative   : Case = CPrep P_a ;
    genitive : Case = CPrep P_de ;

  oper
    vRefl _ = VRefl ;
    isVRefl : VType -> Bool = \ty -> case ty of {
      VRefl => True ;
      _ => False
      } ;

  oper
    prepCase = \c -> case c of {
      Nom => [] ;
      Acc => [] ;
      CPrep P_de => "de" ;
      CPrep P_a  => "a"
      } ;

  oper
    partitive = \_,c -> prepCase c ;

  oper
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

  oper
    possCase = \_,_,c -> prepCase c ;

  oper
    auxVerb : VType -> (VF => Str) = \_ -> haver_V.s ;

    negation : RPolarity => (Str * Str) = table {
      RPos => <[],[]> ;
      RNeg _ => <"não",[]>
      } ;

    copula : Verb = verboV (ser_Besch "ser") ;

  oper
    conjThan = "que" ;
    conjThat = "que" ;

  oper
    subjIf = "se" ;

  oper
    relPron : Bool => AAgr => Case => Str = \\b,a,c =>
      case c of {
        Nom | Acc => "que" ;
        CPrep P_a => "cujo" ;
        _ => prepCase c ++ "cujo"
      } ;

    pronSuch : AAgr => Str = aagrForms "tal" "tal" "tais" "tais" ;

  oper
    partQIndir = [] ;

  oper
    reflPron : Number -> Person -> Case -> Str = \n,p,c ->
      let pro = argPron Fem n p c
      in
      case p of {
        P3 => case c of {
          Acc | CPrep P_a => "se" ;
          _ => "si"
          } ;
        _ => pro
      } ;

  oper
    auxPassive : Verb = copula ;

  oper
    vpAgrClits : Verb -> AAgr -> VPAgrType ;
    -- exception
    vpAgrClits v a = <verbDefaultPart v, False> ;

  oper
    subjPron = \_ -> [] ;

  oper
    polNegDirSubj = RPos ;

  oper
    infForm _ _ _ _  = True ;

  oper
    vpAgrClit : Agr -> VPAgr = \a ->
      vpAgrNone ;

-- oper's opers
  oper
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
        <_,Sg,P1> => cases "me" "mim" ;
        <_,Sg,P2> => cases "te" "ti" ;
        <_,Pl,P1> => cases "nos" "nós" ; --- nosotros
        <_,Pl,P2> => cases "vos" "vós" ; --- vosotros
        <Fem,Sg,P3> => cases3 "a" "sua" "ela" ;
        <_,  Sg,P3> => cases3 "o" "seu" "ele" ;
        <Fem,Pl,P3> => cases3 "as" "suas" "elas" ;
        <_,  Pl,P3> => cases3 "os" "seus" "eles"
      } ;

    estar_V : Verb = verboV (estar_Besch "estar") ;

    haver_V : Verb = verboV (haver_Besch "haver") ;

    ficar_V : Verb = verboV (ficar_Besch "ficar") ;

    verboV : Verbum -> Verb ;
    -- make a verb of type haver
    verboV v = verbBesch v ** {vtyp = VHabere ; p = [] ; lock_V = <>} ;

}
