-- opers implementing the API of stem-based morphology in finnish/tagged for tagged Finnish

resource StemFin = open TagFin, MorphoFin, Prelude in {

flags coding = utf8 ;

oper
  SNForm : Type = Predef.Ints 0 ;
  SNoun : Type = {s : SNForm => Str ; h : Harmony } ;

  nforms2snoun : NForms -> SNoun = \nfs -> {s = nfs ; h = Back} ;

    snoun2nounBind : SNoun -> Noun = snoun2noun True ;
    snoun2nounSep  : SNoun -> Noun = snoun2noun False ;

    snoun2noun : Bool -> SNoun -> Noun = \b,sn -> {s = \\nf => sn.s ! 0++ mkTag "N" + tagNForm nf ; h = Back} ;



    snoun2np : Number -> SPN -> NPForm => Str = \n,sn ->
      \\c => sn.s ! (npform2case n c) ; 

--    noun2snoun : Noun -> SNoun = \n -> n ; not needed for anything

    aHarmony : Str -> Harmony = \a -> case a of 
       {"a" => Back ; _   => Front} ;

    harmonyA : Harmony -> Str = harmonyV "a" "ä" ;

    harmonyV : Str -> Str -> Harmony -> Str = \u,y,h -> case h of 
       {Back => u ; Front => y} ;


  SPN : Type = {s : Case  => Str} ;

  snoun2spn : SNoun -> SPN = \n -> {s = \\c => n.s ! 0 ++ tagCase c} ;

  exceptNomSNoun : SNoun -> Str -> SNoun = \noun,nom -> {
      s = \\_ => nom ;
      h = noun.h 
      } ;



-- Adjectives --- could be made more compact by pressing comparison forms down to a few

oper
  SAForm : Type = AForm ;

oper
  SAdj = {s : SAForm => Str ; h : Harmony} ;

  snoun2sadj : SNoun -> SAdj = snoun2sadjComp True ;

  snoun2sadjComp : Bool -> SNoun -> SAdj = \isPos,tuore ->
    let 
      tuoree = init (tuore.s ! 0) ;
      tuoreesti  = tuoree + "sti" ; 
      tuoreemmin =  init tuoree ;
    in {s = table {
         AN f => tuoree ;
         AAdv => if_then_Str isPos tuoreesti tuoreemmin
         } ;
        h = Back
       } ;

   sAN : SNForm -> SAForm = \n -> AN (NCase Sg Nom) ;  ---- without eta exp gives internal error 6/8/2013
   sAAdv : SAForm = AAdv ;
   sANGen : (SAForm => Str) -> Str = \a -> a ! AN (NCase Sg Gen) ;

    mkAdj : (hyva,parempi,paras : SNoun) -> (hyvin,paremmin,parhaiten : Str) -> {s : Degree => SAForm => Str ; h : Harmony} = \h,p,ps,hn,pn,ph -> {
      s = table {
        Posit => table {
           AN nf => h.s ! 0 ++ tagNForm nf ;
           AAdv  => hn
           } ; 
        Compar => table {
           AN nf => p.s ! 0 ++ tagNForm nf ;
           AAdv  => pn
           } ; 
        Superl => table {
           AN nf => ps.s ! 0 ++ tagNForm nf ;
           AAdv  => ph
           }
        } ;
      h = Back  ---- TODO: just get rid of h ?
      } ;

  snoun2compar : SNoun -> Str = \n -> n.s ! 0 + "Comp" ; ---- TODO
  snoun2superl : SNoun -> Str = \n -> n.s ! 0 + "Superl" ; ---- TODO

-- verbs

oper
  SVForm : Type = VForm ;
  SVerb : Type = {s : SVForm => Str ; h : Harmony} ;

  ollaSVerbForms : SVForm => Str = verbOlla.s ;

  -- used in Cat
  SVerb1 = {s : SVForm => Str ; sc : SubjCase ; h : Harmony ; p : Str} ;

  sverb2verbBind : SVerb -> Verb = sverb2verb True ;
  sverb2verbSep  : SVerb -> Verb = sverb2verb False ;

  vforms2sverb : VForms -> SVerb = \v -> 
    {s = (vforms2V v).s ; h = case (last (v ! 0)) of {"a" => Back ; _ => Front}} ;

  sverb2verb : Bool -> SVerb -> Verb = \b,sverb -> {s = sverb.s} ;

  predSV : SVerb1 -> VP = \sv ->
    predV sv ; 
    -- (sverb2verbSep sv ** {p = sv.p ; sc = sv.sc ; h = sv.h}) ;

-- word formation functions

  sverb2snoun : SVerb1 -> SNoun = \v ->    -- syöminen
    let tekem = Predef.tk 4 (v.s ! Inf Inf3Iness) in 
    nforms2snoun (dNainen (tekem + "inen")) ;

{-
  sverb2nounPresPartAct : SVerb1 -> SNoun = \v ->  -- syövä
    let teke = Predef.tk 5 (v.s ! Inf Inf3Iness) in 
    nforms2snoun (dLava (teke + "v" + last (v.s ! Inf1))) ;

  sverb2nounPresPartPass : SVerb1 -> SNoun = \v ->  -- syötävä
    let a = harmonyA v.h in
    nforms2snoun (dLava (partPlus (v.s ! 3) (partPlus "t" (partPlus a (partPlus "v" a))))) ;
-}

  dLava : Str -> NForms = \s -> dUkko s (s + "n") ;
  
 --- to use these at run time in ParseFin
  partPlus = glue ;

-- auxiliary

    plusIf : Bool -> Str -> Str -> Str = \b,x,y -> case b of {
      True  => x + y ;
      False => glue x y 
      } ;

-- for Symbol

  addStemEnding : Str -> SPN = \i -> 
    {s = \\c => i ++ BIND ++ defaultCaseEnding c} ;
--    {s = \\c => i ++ bindColonIfS (NCase Sg c) ++ defaultCaseEnding c} ;

  bindIfS : SNForm -> Str = \c -> case c of {
    --NCase Sg Nom => [] ;
    _ => BIND
    } ;

  bindColonIfS : SNForm -> Str = \c -> case c of {
    --NCase Sg Nom => [] ;
    _ => BIND ++ ":" ++ BIND
    } ;

-----------------------------------------------------------------------
---- a hack to make VerbFin compile accurately for library (here), 
---- and in a simplified way for ParseFin (in stemmed/)

  slashV2VNP : (SVerb1 ** {c2 : Compl ; vi : VVType}) -> (NP ** {isNeg : Bool}) -> 
    (VP ** {c2 : Compl}) -> (VP ** {c2 : Compl}) 
    = \v, np, vp -> 
      insertObjPre np.isNeg
        (\fin,b,a ->  appCompl fin b v.c2 np ++ 
                      infVP v.sc b a vp (vvtype2infform v.vi)) 
          (predSV v) ** {c2 = vp.c2} ;


---- VP now stemming-dependent. AR 7/12/2013

  VP = {
    s   : SVerb1 ;
    s2  : Bool => Polarity => Agr => Str ; -- talo/talon/taloa
    adv : Polarity => Str ; -- ainakin/ainakaan
    ext : Str ;
    vptyp : {isNeg : Bool ; isPass : Bool} ;-- True if some complement is negative, and if the verb is rendered in the passive
    } ;

  defaultVPTyp = {isNeg = False ; isPass = False} ;
    
  HVerb : Type = Verb ** {sc : SubjCase ; h : Harmony ; p : Str} ;
 
  predV : HVerb -> VP = \verb -> {
    s = verb ;
    s2 = \\_,_,_ => [] ;
    adv = \\_ => verb.p ; -- the particle of the verb
    ext = [] ;
    vptyp = defaultVPTyp ;
    } ;

  old_VP = {
    s   : VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} ; 
    s2  : Bool => Polarity => Agr => Str ; -- talo/talon/taloa
    adv : Polarity => Str ; -- ainakin/ainakaan
    ext : Str ;
    sc  : SubjCase ;
    isNeg : Bool ; -- True if some complement is negative
    h   : Harmony
    } ;

  vp2old_vp : VP -> old_VP = \vp -> 
    let 
     verb = vp.s ; 
     sverb :  VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} = \\vi,ant,b,agr0 => 
      let
        agr = verbAgr agr0 ;
        verbs = verb.s ;
        part  : Str = case vi of {
          VIPass _ => verbs ! PastPartPass (AN (NCase agr.n Nom)) ; 
          _        => verbs ! PastPartAct (AN (NCase agr.n Nom))
          } ; 

        eiv : Str = case agr of {
          {n = Sg ; p = P1} => "en" ;
          {n = Sg ; p = P2} => "et" ;
          {n = Sg ; p = P3} => "ei" ;
          {n = Pl ; p = P1} => "emme" ;
          {n = Pl ; p = P2} => "ette" ;
          {n = Pl ; p = P3} => "eivät"
          } ;

        einegole : Str * Str * Str = case <vi,agr.n> of {
          <VIFin Pres,        _>  => <eiv, verbs ! Imper Sg,     "ole"> ;
          <VIFin Fut,         _>  => <eiv, verbs ! Imper Sg,     "ole"> ;   --# notpresent
          <VIFin Cond,        _>  => <eiv, verbs ! Condit Sg P3, "olisi"> ;  --# notpresent
          <VIFin Past,        Sg> => <eiv, part,                 "ollut"> ;  --# notpresent
          <VIFin Past,        Pl> => <eiv, part,                 "olleet"> ;  --# notpresent
          <VIImper,           Sg> => <"älä", verbs ! Imper Sg,   "ole"> ;
          <VIImper,           Pl> => <"älkää", verbs ! ImpNegPl, "olko"> ;
          <VIPass Pres,       _>  => <"ei", verbs ! PassPresn False,  "ole"> ;
          <VIPass Fut,        _>  => <"ei", verbs ! PassPresn False,  "ole"> ; --# notpresent
          <VIPass Cond,       _>  => <"ei", verbs ! PassCondit False,  "olisi"> ; --# notpresent
          <VIPass Past,       _>  => <"ei", verbs ! PassImpf False,  "ollut"> ; --# notpresent
          <VIInf i,           _>  => <"ei", verbs ! Inf i, "olla"> ----
          } ;

        ei  : Str = einegole.p1 ;
        neg : Str = einegole.p2 ;
        ole : Str = einegole.p3 ;

        olla : VForm => Str = table {
           PassPresn  True => verbOlla.s ! Presn Sg P3 ;
           PassImpf   True => verbOlla.s ! Impf Sg P3 ;   --# notpresent
           PassCondit True => verbOlla.s ! Condit Sg P3 ; --# notpresent
           vf => verbOlla.s ! vf
           } ;

        vf : Str -> Str -> {fin, inf : Str} = \x,y -> 
          {fin = x ; inf = y} ;
        mkvf : VForm -> {fin, inf : Str} = \p -> case <ant,b> of {
          <Simul,Pos> => vf (verbs ! p) [] ;
          <Anter,Pos> => vf (olla ! p)  part ;    --# notpresent
          <Anter,Neg> => vf ei          (ole ++ part) ;   --# notpresent
          <Simul,Neg> => vf ei          neg
          } ;
        passPol = case b of {Pos => True ; Neg => False} ;
      in
      case vi of {
        VIFin Past => mkvf (Impf agr.n agr.p) ;     --# notpresent
        VIFin Cond => mkvf (Condit agr.n agr.p) ;  --# notpresent
        VIFin Fut  => mkvf (Presn agr.n agr.p) ;  --# notpresent
        VIFin Pres => mkvf (Presn agr.n agr.p) ;
        VIImper    => mkvf (Imper agr.n) ;
        VIPass Past    => mkvf (PassImpf passPol) ;  --# notpresent
        VIPass Cond    => mkvf (PassCondit passPol) ; --# notpresent
        VIPass Fut     => mkvf (PassPresn passPol) ;  --# notpresent
        VIPass Pres    => mkvf (PassPresn passPol) ;  
        VIInf i    => mkvf (Inf i)
        }
    in {
    s = case vp.vptyp.isPass of {
          True => \\vif,ant,pol,agr => case vif of {
            VIFin t  => sverb ! VIPass t ! ant ! pol ! agr ;
           _ => sverb ! vif ! ant ! pol ! agr 
           } ;
          _ => sverb
          } ;
    s2 = vp.s2 ;
    adv = vp.adv ; -- the particle of the verb
    ext = vp.ext ;
    sc = verb.sc ;
    h = verb.h ;
    isNeg = vp.vptyp.isNeg 
    } ;

  insertObj : (Bool => Polarity => Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    s2 = \\fin,b,a => vp.s2 ! fin ! b ! a  ++ obj ! fin ! b ! a ;
    adv = vp.adv ;
    ext = vp.ext ;
    sc = vp.sc ; 
    h = vp.h ;
    vptyp = vp.vptyp
    } ;

  insertObjPre : Bool -> (Bool -> Polarity -> Agr -> Str) -> VP -> VP = \isNeg, obj,vp -> {
    s = vp.s ;
    s2 = \\fin,b,a => obj fin b a ++ vp.s2 ! fin ! b ! a ;
    adv = vp.adv ;
    ext = vp.ext ;
    vptyp = {isNeg = orB vp.vptyp.isNeg isNeg ; isPass = vp.vptyp.isPass} ;
    } ;

  insertAdv : (Polarity => Str) -> VP -> VP = \adv,vp -> {
    s = vp.s ;
    s2 = vp.s2 ;
    ext = vp.ext ;
    adv = \\b => vp.adv ! b ++ adv ! b ;
    sc = vp.sc ; 
    h = vp.h ;
    vptyp = vp.vptyp --- missään
    } ;

  passVP : VP -> Compl -> VP = \vp,pr -> {
    s = {s = vp.s.s ; h = vp.s.h ; p = vp.s.p ; sc = npform2subjcase pr.c} ; -- minusta pidetään ---- TODO minun katsotaan päälle
    s2 = \\b,p,a => pr.s.p1 ++ vp.s2 ! b ! p ! a ++ pr.s.p2 ; ---- possessive suffix
    ext = vp.ext ;
    adv = vp.adv ;
    vptyp = {isNeg = vp.vptyp.isNeg ; isPass = True} ; 
    } ;

  insertExtrapos : Str -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    s2 = vp.s2 ;
    ext = vp.ext ++ obj ;
    adv = vp.adv ;
    sc = vp.sc ; 
    h = vp.h ;
    vptyp = vp.vptyp
    } ;

  mkClausePol : Bool -> (Polarity -> Str) -> Agr -> VP -> Clause = 
    \isNeg,sub,agr,vp -> {
      s = \\t,a,b => 
         let
           pol = case isNeg of {
            True => Neg ; 
            _ => b
            } ; 
           c = (mkClausePlus sub agr vp).s ! t ! a ! pol 
         in 
         table {
           SDecl  => c.subj ++ c.fin ++ c.inf ++ c.compl ++ c.adv ++ c.ext ;
           SQuest => c.fin ++ BIND ++ questPart c.h ++ c.subj ++ c.inf ++ c.compl ++ c.adv ++ c.ext
           }
      } ;
  mkClause : (Polarity -> Str) -> Agr -> VP -> Clause = 
    \sub,agr,vp -> {
      s = \\t,a,b => let c = (mkClausePlus sub agr vp).s ! t ! a ! b in 
         table {
           SDecl  => c.subj ++ c.fin ++ c.inf ++ c.compl ++ c.adv ++ c.ext ;
           SQuest => c.fin ++ BIND ++ questPart c.h ++ c.subj ++ c.inf ++ c.compl ++ c.adv ++ c.ext
           }
      } ;

  mkClausePlus : (Polarity -> Str) -> Agr -> VP -> ClausePlus =
    \sub,agr,vp0 -> let vp = vp2old_vp vp0 in {
      s = \\t,a,b => 
        let 
          agrfin = case vp.sc of {
                    SCNom => <agr,True> ;
                    _ => <agrP3 Sg,False>      -- minun täytyy, minulla on
                    } ;
          verb  = vp.s ! VIFin t ! a ! b ! agrfin.p1 ;
        in {subj = sub b ; 
            fin  = verb.fin ; 
            inf  = verb.inf ; 
            compl = vp.s2 ! agrfin.p2 ! b ! agr ;
            adv  = vp.adv ! b ; 
            ext  = vp.ext ; 
            h    = selectPart vp0 a b
            }
     } ;

  selectPart : VP -> Anteriority -> Polarity -> Harmony = \vp,a,p -> 
    case p of {
      Neg => Front ;  -- eikö tule
      _ => case a of {
        Anter => Back ; -- onko mennyt --# notpresent
        _ => vp.s.h  -- tuleeko, meneekö
        }
      } ;

-- the first Polarity is VP-internal, the second comes form the main verb:
-- ([main] tahdon | en tahdo) ([internal] nukkua | olla nukkumatta)
  infVPGen : Polarity -> SubjCase -> Polarity -> Agr -> VP -> InfForm -> Str =
    \ipol,sc,pol,agr,vp0,vi ->
        let 
          vp = vp2old_vp vp0 ;
          fin = case sc of {     -- subject case
            SCNom => True ; -- minä tahdon nähdä auton
            _ => False           -- minun täytyy nähdä auto
            } ;
          verb = case ipol of {
            Pos => <vp.s ! VIInf vi ! Simul ! Pos ! agr, []> ; -- nähdä/näkemään
            Neg => <(vp2old_vp (predV (verbOlla ** {sc = SCNom ; h = Back ; p = []}))).s ! VIInf vi ! Simul ! Pos ! agr,
                    (vp.s ! VIInf Inf3Abess ! Simul ! Pos ! agr).fin> -- olla/olemaan näkemättä
            } ;
          vph = vp.h ;
          poss = case vi of {
            InfPresPartAgr => possSuffixGen vph agr ; -- toivon nukkuva + ni
            _ => []
            } ;
          compl = vp.s2 ! fin ! pol ! agr ++ vp.adv ! pol ++ vp.ext     -- compl. case propagated
        in
        verb.p1.fin ++ verb.p1.inf ++ poss ++ verb.p2 ++ compl ;

  infVP : SubjCase -> Polarity -> Agr -> VP -> InfForm -> Str = infVPGen Pos ;

  vpVerbOlla : HVerb = verbOlla ** {sc = SCNom ; h = Back ; p = []} ;

}