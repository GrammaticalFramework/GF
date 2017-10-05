--# -path=.:../romance:../abstract:../common:prelude

instance DiffFre of DiffRomance - [
  imperClit,
  invertedClause,
  verbHyphen,
  iAdvQuestionInv
  ] 
  = open CommonRomance, PhonoFre, Prelude in {

  flags optimize=noexpand ; coding=utf8 ;
--  flags optimize=all ;

  param 
    Prepos = P_de | P_a | PNul ;
    VType = VTyp VAux VBool ;  -- True means that -t- is required as in va-t-il, alla-t-il
    VAux  = VHabere | VEsse | VRefl ;
    VBool = VFalse ;
    oper VTrue = VFalse ;
  oper
    dative   : Case = CPrep P_a ;
    genitive : Case = CPrep P_de ;

    prepCase : Case -> Str = \c -> case c of {
      Nom => [] ;
      Acc => [] ; 
      CPrep P_a => "à" ;
      CPrep P_de => elisDe ;
      CPrep PNul => []
      } ;

    artDef : Bool -> Gender -> Number -> Case -> Str = \isNP,g,n,c ->
      case <g,n,c> of {
        <Masc,Sg, CPrep P_de> => pre {"du" ; ("de l'" ++ Predef.BIND) / voyelle} ;
        <Masc,Sg, CPrep P_a>  => pre {"au" ; ("à l'"  ++ Predef.BIND)  / voyelle} ;
        <Masc,Sg, _>    => elisLe ;
        <Fem, Sg, _>    => prepCase c ++ elisLa ;
        <_,   Pl, CPrep P_de> => "des" ;
        <_,   Pl, CPrep P_a>  => "aux" ;
        <_,   Pl, _ >   => "les"
        } ;

-- In these two, "de de/du/des" becomes "de".

    artIndef = \isNP,g,n,c -> case <n,c> of {
      <Sg,_>   => prepCase c ++ genForms "un" "une" ! g ;
      <Pl,CPrep P_de> => if_then_else Str isNP (prepCase c ++ genForms "quelques-uns" "quelques-unes" ! g) elisDe ;
      _        => if_then_else Str isNP (prepCase c ++ genForms "quelques-uns" "quelques-unes" ! g) (prepCase c ++ "des")
      } ;

    possCase = \_,_,c -> prepCase c ;

    partitive = \g,c -> case c of {
      CPrep P_de => elisDe ;
      _ => prepCase c ++ artDef False g Sg (CPrep P_de)
      } ;

    conjunctCase : Case -> Case = \c -> c ;

    auxVerb : VType -> (VF => Str) = \vtyp -> case vtyp of {
      VTyp VHabere _ => avoir_V.s ;
      _ => copula.s
      } ;

    vpAgrClit : Agr -> VPAgr = \a0 ->
      let a = complAgr a0 in
      VPAgrClit a.g a.n ;

    partAgr   : VType -> Bool = \vtyp -> case vtyp of { -- works for all except Spa
      VTyp VHabere _ => False ;
      _ => True
      } ;

----    pronArg = pronArgGen Neg ; --- takes more space and time

    pronArg : Number -> Person -> CAgr -> CAgr -> Str * Str * Bool = 
      \n,p,acc,dat ->
      let 
        pacc = case acc of {
          CRefl => <case p of {
            P3 => elision "s" ;  --- use of reflPron incred. expensive
            _  => argPron Fem n p Acc
            },True> ;
          CPron ag an ap => <argPron ag an ap Acc,True> ;
          _ => <[],False>
          } ;
       in
       case dat of {
          CPron ag an ap => let pdat = argPron ag an ap dative in case ap of {
            P3 => <pacc.p1 ++ pdat,[],True> ;
            _  => <pdat ++ pacc.p1,[],True>
            } ;
          _ => <pacc.p1, [],pacc.p2>
          } ;

    infForm _ _ _ _  = True ;

-- Positive polarity is used in the imperative: stressed for 1st and
-- 2nd persons.

    pronArgGen : RPolarity -> Number -> Person -> CAgr -> CAgr -> Str * Str = 
      \b,n,p,acc,dat ->
      let 
        cas : Person -> Case -> Case = \pr,c -> case <pr,b> of {
          <P1 | P2, RPos> => CPrep P_de ; --- encoding in argPron
          _ => c
          } ;
        pacc = case acc of {
          CRefl => case p of {
            P3 => elision "s" ;  --- use of reflPron incred. expensive
            _  => argPron Fem n p (cas p Acc)
            } ;
          CPron ag an ap => argPron ag an ap (cas ap Acc) ;
          _ => []
          } ;
        pdat = case dat of {
          CPron ag an ap => argPron ag an ap (cas ap dative) ;
          _ => []
          } ;
       in
       case dat of {
          CPron _ _ P3 => <pacc ++ pdat,[]> ;
          _ => <pdat ++ pacc, []>
          } ;

    mkImperative b p vp = 
      \\pol,g,n => 
        let 
          agr   = Ag g n p ;
          num   = if_then_else Number b Pl n ;
          verb  = vp.s.s ! vImper num p ;
          neg   = vp.neg ! pol ;
          refl  = case vp.s.vtyp of {
            VTyp VRefl _ => case <n,b> of {
              <Sg,False> => <"toi",elision "t",True> ;
              _ => <"vous","vous",True>
              } ;
            _ => <[],[],False> 
            } ;
          clpr  = <vp.clit1 ++ vp.clit2, vp.clit3.hasClit> ;
          compl = vp.comp ! agr ++ vp.ext ! pol
        in
        case pol of {
          RPos => verb ++ if_then_Str refl.p3 bindHyphen [] ++ refl.p1 ++ 
                          if_then_Str clpr.p2 bindHyphen [] ++ vp.clit3.imp ++ 
                          compl ;
          RNeg _ => neg.p1 ++ refl.p2 ++ clpr.p1 ++ verb ++ neg.p2 ++ compl
          } ;

    imperClit : Agr -> Str -> Str -> Str = \a,c1,c2 -> case a of {
      {n = Sg ; p = P1 ; g = _} => "moi" ;
      {n = Sg ; p = P2 ; g = _} => "toi" ;
      _ => c1 ++ c2
      } ;

    iAdvQuestionInv : Direct = DDir ;

    bindHyphen : Str = BIND ++ "-" ++ BIND ;

    CopulaType = {} ;
    selectCopula = \isEstar -> copula ;
    serCopula = <> ;
    estarCopula = <> ;

    negation : RPolarity => (Str * Str) = table {
      RPos => <[],[]> ;
      RNeg True  => <elisNe,[]> ;
      RNeg False => <elisNe,"pas">
      } ;

    conjThan = elisQue ;
    conjThat = elisQue ;

    subjIf = "si" ; --- s'

    clitInf _ cli inf = cli ++ inf ;

    relPron : Bool => AAgr => Case => Str = \\b,a,c => 
      let
        lequel = case <a.g,a.n,c> of {
        <Masc,Sg, CPrep P_de> => "duquel" ;
        <Masc,Sg, CPrep P_a>  => "auquel" ;
        <Masc,Sg, _>    => prepCase c ++ "lequel" ;
        <Fem, Sg, _>    => prepCase c ++ "laquelle" ;
        <Fem, Pl, CPrep P_de> => "desquelles" ;
        <_,   Pl, CPrep P_de> => "desquels" ;
        <Fem, Pl, CPrep P_a>  => "auxquelles" ;
        <_,   Pl, CPrep P_a>  => "auxquels" ;
        <Fem, Pl, _ >   => "lesquelles" ;
        <_,   Pl, _ >   => "lesquels"
        } ;
      ---- artDef a.g a.n c ++ quelPron ! a  ---- doesn't compile properly AR 17/3/2014
      in
      case b of {
      False => case c of {
        Nom => "qui" ;
        Acc => elisQue ;
        CPrep P_de => "dont" ;
        _ => lequel
        } ;
      _   => lequel
      } ;

    pronSuch : AAgr => Str = aagrForms "tel" "telle" "tels" "telles" ;

    quelPron : AAgr => Str = aagrForms "quel" "quelle" "quels" "quelles" ;

    partQIndir = "ce" ; --- only for qui,que: elision "c" ;

    reflPron : Number -> Person -> Case -> Str = \n,p,c ->
      let pron = argPron Fem n p c in
      case <p,c> of {
        <P3,  Acc | CPrep P_a> => elision "s" ;
        <P3, _> => prepCase c ++ "soi" ;
        _ => pron
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
        <_,Sg,P1> => cases (elision "m") "moi" ;
        <_,Sg,P2> => cases (elision "t") "toi" ;
        <_,Pl,P1> => \_ -> "nous" ;
        <_,Pl,P2> => \_ -> "vous" ;
        <Fem,Sg,P3> => cases3 elisLa "lui" "elle" ;
        <_,Sg,P3> => cases3 (elision "l") "lui" "lui" ;
        <Fem,Pl,P3> => cases3 "les" "leur" "elles" ;
        <_,Pl,P3> => cases3 "les" "leur" "eux"
        } ;

    vRefl   : VType -> VType = \t -> VTyp VRefl VFalse ; ---- (getVTypT t) ;
    isVRefl : VType -> Bool = \ty -> case ty of {
      VTyp VRefl _ => True ;
      _ => False
      } ;

    getVTypT : VType -> VBool = \t -> case t of {VTyp _ b => b} ; -- only in Fre

    auxPassive : Verb = copula ;

    copula : Verb = {s = table VF ["être";bindHyphen;"suis";"es";"est";"sommes";"êtes";"sont";"sois";"sois"
;"soit";"soyons";"soyez";"soient";
"étais";"étais";"était";"étions";"étiez";"étaient";--# notpresent
"fusse";"fusses";"fût";"fussions";"fussiez";"fussent";--# notpresent
"fus";"fus";"fut";"fûmes";"fûtes";"furent";--# notpresent
"serai";"seras";"sera";"serons";"serez";"seront";--# notpresent
"serais";"serais";"serait";"serions";"seriez";"seraient";--# notpresent
"sois";"soyons";"soyez";"été";"étés";"étée";"étées";"étant";"étant"]; vtyp=VTyp VHabere VFalse ; p = []} ;

    avoir_V : Verb = {s=table VF ["avoir";bindHyphensT;"ai";"as";"a";"avons";"avez";"ont";"aie";"aies";"ait"
;"ayons";"ayez";"aient";
"avais";"avais";"avait";"avions";"aviez";"avaient"; --# notpresent
"eusse";"eusses";"eût";"eussions";"eussiez";"eussent";--# notpresent
"eus";"eus";"eut";"eûmes";"eûtes";"eurent";--# notpresent
"aurai";"auras";"aura";"aurons";"aurez";"auront";--# notpresent
"aurais";"aurais";"aurait";"aurions";"auriez";"auraient";--# notpresent
"aie";"ayons";"ayez";"eu";"eus";"eue";"eues";"ayant";"ayant"];vtyp=VTyp VHabere VTrue ; p = []} ; ---- a-t-il eut-il

  datClit = "y" ;
  genClit = "en" ;

  subjPron = \a -> case a of {
    {n = Sg ; p = P1} => "je" ;
    {n = Sg ; p = P2} => "tu" ;
    {n = Pl ; p = P1} => "nous" ;
    {n = Pl ; p = P2} => "vous" ;
    {n = Sg ; p = P3 ; g = Masc} => "il" ;
    {n = Sg ; p = P3 ; g = Fem}  => "elle" ;
    {n = Pl ; p = P3 ; g = Masc} => "ils" ;
    {n = Pl ; p = P3 ; g = Fem}  => "elles"
    } ;

  polNegDirSubj = RNeg True ;

  invertedClause : 
    VType -> (RTense * Anteriority * Number * Person) -> Bool -> (Str * Str) -> Str -> (clit,fin,inf,compl,subj,ext : Str) -> Str =
    \vtyp,vform,hasClit,neg,bindHyph,clit,fin,inf,compl,subj,ext -> case <vtyp,vform,hasClit> of {

      -- parle-t-il - some verbs
      <VTyp _ VTrue, <RPres,Simul,Sg,P3>, True> =>
           neg.p1 ++ clit ++ fin ++ bindHyph ++ subj ++ neg.p2 ++ inf ++ compl ++ ext ;

      -- parla-t-il - some verbs
      <VTyp _ VTrue, <RPasse,Simul,Sg,P3>, True> =>                                             --# notpresent
           neg.p1 ++ clit ++ fin ++ bindHyph ++ subj ++ neg.p2 ++ inf ++ compl ++ ext ;    --# notpresent

      -- fera-t-il, sera-t-il venu - all verbss
      <_,           <RFut,_,Sg,P3>, True> =>                                                   --# notpresent
           neg.p1 ++ clit ++ fin ++ bindHyphensT ++ subj ++ neg.p2 ++ inf ++ compl ++ ext ;    --# notpresent

      -- a-t-il fait - all "avoir" verbs
      <VTyp VHabere _,<RPres,Anter,Sg,P3>, True> =>                                            --# notpresent
           neg.p1 ++ clit ++ fin ++ bindHyphensT ++ subj ++ neg.p2 ++ inf ++ compl ++ ext ;    --# notpresent

      -- suis-je
      <_, _, True> =>
           neg.p1 ++ clit ++ fin ++ bindHyphen ++ subj ++ neg.p2 ++ inf ++ compl ++ ext ;

      -- est loin la ville
      _ => neg.p1 ++ clit ++ fin ++ neg.p2 ++ inf ++ compl ++ subj ++ ext
      } ;

  bindHyphensT : Str = bindHyphen ++ "t" ++ bindHyphen ;

  verbHyphen : Verb -> Str = \v -> v.s ! (VInfin True) ; --- kluge: use this field to store - or -t-

}
