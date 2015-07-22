-- stem-based morphology, with just the minimum number of concatenative stems

resource StemFin = open MorphoFin, Prelude in {

flags coding = utf8 ;

oper
  SNForm : Type = Predef.Ints 10 ;
  SNoun : Type = {s : SNForm => Str ; h : Harmony} ;

  nforms2snoun : NForms -> SNoun = \nf -> {
    s = table {
      0 => nf ! 0 ;                -- ukko
      1 => Predef.tk 1 (nf ! 1) ;  -- uko(n)
      2 => nf ! 2 ;                -- ukkoa
      3 => Predef.tk 2 (nf ! 3) ;  -- ukkona
      4 => Predef.tk 1 (nf ! 4) ;  -- ukkoo(n)
      5 => Predef.tk 1 (nf ! 5) ;  -- ukkoje(n)
      6 => nf ! 6 ;                -- ukkoja
      7 => Predef.tk 2 (nf ! 7) ;  -- ukkoi(na)
      8 => Predef.tk 3 (nf ! 8) ;  -- ukoi(ssa)
      9 => Predef.tk 1 (nf ! 9) ;  -- ukkoihi(n)
     10 => nf ! 10                 -- ukko(-)
      } ;
    h = aHarmony (last (nf ! 2)) ;
    } ;

    snoun2nounBind : SNoun -> Noun = snoun2noun True ;
    snoun2nounSep  : SNoun -> Noun = snoun2noun False ;

    snoun2noun : Bool -> SNoun -> Noun = \b,sn -> 
      let
        plus = plusIf b ;
        f = sn.s ;

        ukko    = f ! 0 ;
        uko     = f ! 1 ;
        ukkoa   = f ! 2 ;
        ukko_   = f ! 3 ;
        ukkoo   = f ! 4 ;
        ukkoje  = f ! 5 ;
        ukkoja  = f ! 6 ;
        ukkoi   = f ! 7 ;
        ukoi    = f ! 8 ;
        ukkoihi = f ! 9 ;
        ukkos_  = f ! 10 ;
        a       = harmonyA sn.h ;
      in 

    {s = table {
      NCase Sg Nom    => ukko ;
      NCase Sg Gen    => plus uko "n" ;
      NCase Sg Part   => ukkoa ;
      NCase Sg Transl => plus uko "ksi" ;
      NCase Sg Ess    => plus ukko_ ("n" + a) ;
      NCase Sg Iness  => plus uko ("ss" + a) ;
      NCase Sg Elat   => plus uko ("st" + a) ;
      NCase Sg Illat  => plus ukkoo "n" ;
      NCase Sg Adess  => plus uko ("ll" + a) ;
      NCase Sg Ablat  => plus uko ("lt" + a) ;
      NCase Sg Allat  => plus uko "lle" ;
      NCase Sg Abess  => plus uko ("tt" + a) ;

      NCase Pl Nom    => plus uko "t" ;
      NCase Pl Gen    => plus ukkoje "n" ;
      NCase Pl Part   => ukkoja ;
      NCase Pl Transl => plus ukoi "ksi" ;
      NCase Pl Ess    => plus ukkoi ("n" + a) ;
      NCase Pl Iness  => plus ukoi ("ss" + a) ;
      NCase Pl Elat   => plus ukoi ("st" + a) ;
      NCase Pl Illat  => plus ukkoihi "n" ;
      NCase Pl Adess  => plus ukoi ("ll" + a) ;
      NCase Pl Ablat  => plus ukoi ("lt" + a) ;
      NCase Pl Allat  => plus ukoi "lle" ;
      NCase Pl Abess  => plus ukoi ("tt" + a) ;

      NComit    => plus ukkoi "ne" ;
      NInstruct => plus ukoi "n" ;

      NPossNom _     => ukko_ ;
      NPossGen Sg    => ukko_ ;
      NPossGen Pl    => ukkoje ;
      NPossTransl Sg => plus uko "kse" ;
      NPossTransl Pl => plus ukoi "kse" ;
      NPossIllat Sg  => ukkoo ;
      NPossIllat Pl  => ukkoihi ;

      NCompound      => ukkos_
      } ;
    h = sn.h ;
    lock_N = <>
    } ;


    snoun2np : Number -> SNoun -> NPForm => Str = \n,sn ->
      \\c => (snoun2nounSep sn).s ! NCase n (npform2case n c) ; 

    noun2snoun : Noun -> SNoun = \n -> nforms2snoun (n2nforms n) ;

    aHarmony : Str -> Harmony = \a -> case a of 
       {"a" => Back ; _   => Front} ;

    harmonyA : Harmony -> Str = harmonyV "a" "ä" ;

    harmonyV : Str -> Str -> Harmony -> Str = \u,y,h -> case h of 
       {Back => u ; Front => y} ;

    SPN : Type = SNoun ;

    snoun2spn : SNoun -> SPN = \n -> n ;

    exceptNomSNoun : SNoun -> Str -> SNoun = \noun,nom -> {
      s = table {
        0 => nom ;
        f => noun.s ! f
	} ;
      h = noun.h
      } ;


-- Adjectives --- could be made more compact by pressing comparison forms down to a few

param 
  SAForm = SAN SNForm | SAAdv ;

oper
  SAdj = {s : SAForm => Str ; h : Harmony} ;

  snoun2sadj : SNoun -> SAdj = snoun2sadjComp True ;

  snoun2sadjComp : Bool -> SNoun -> SAdj = \isPos,tuore ->
    let 
      tuoree = tuore.s ! 1 ;
      tuoreesti  = tuoree + "sti" ; 
      tuoreemmin =  init tuoree ;
    in {s = table {
         SAN f => tuore.s ! f ;
         SAAdv => if_then_Str isPos tuoreesti tuoreemmin
         } ;
        h = tuore.h
       } ;

  sAN : SNForm -> SAForm = \n -> SAN n ;
  sAAdv : SAForm = SAAdv ;

  sANGen : (SAForm => Str) -> Str = \a -> glue (a ! SAN 1) "n" ;

    mkAdj : (hyva,parempi,paras : SNoun) -> (hyvin,paremmin,parhaiten : Str) -> {s : Degree => SAForm => Str ; h : Harmony} = \h,p,ps,hn,pn,ph -> {
      s = table {
        Posit => table {
           SAN nf => h.s ! nf ;
           SAAdv  => hn
           } ; 
        Compar => table {
           SAN nf => p.s ! nf ;
           SAAdv  => pn
           } ; 
        Superl => table {
           SAN nf => ps.s ! nf ;
           SAAdv  => ph
           }
        } ;
      h = h.h
      } ;

  snoun2compar : SNoun -> Str = \n -> (n.s ! 1 + "mpi")  ; ---- to check
  snoun2superl : SNoun -> Str = \n -> (n.s ! 8 + "n") ; ----
    


-- verbs


--  SVForm : Type = Predef.Ints 13 ;

-- easier to understand, better error msgs
param 
  SVForm = SVInf | SVps1 | SVps3 | SVpp3 | SVip2 | SVpas | SVis1 | SVis3 | SVcon | SVppa | SVppp | SVppg | SVpot | SVpac ;

oper
  SVerb : Type = {s : SVForm => Str ; h : Harmony} ;

  ollaSVerbForms : SVForm => Str = table SVForm ["oll";"ole";"on";"o";"olk";"olla";"oli";"oli";"olisi";"oll";"olt";"ollu";"liene";"ole"] ;

  -- used in Cat
  SVerb1 = {s : SVForm => Str ; sc : SubjCase ; h : Harmony ; p : Str} ;

  sverb2verbBind : SVerb -> Verb = sverb2verb True ;
  sverb2verbSep  : SVerb -> Verb = sverb2verb False ;

  vforms2sverb : VForms -> SVerb = \vf -> {
    s = table {
      SVInf  => Predef.tk 1 (vf ! 0) ;  -- tull(a)
      SVps1  => Predef.tk 1 (vf ! 1) ;  -- tule(n)
      SVps3  =>             (vf ! 2) ;  -- tulee
      SVpp3  => Predef.tk 3 (vf ! 3) ;  -- tule(vat)
      SVip2  => Predef.tk 2 (vf ! 4) ;  -- tulk(aa)
      SVpas  => Predef.tk 2 (vf ! 5) ;  -- tulla(an)
      SVis1  => Predef.tk 1 (vf ! 6) ;  -- tuli(n)
      SVis3  =>             (vf ! 7) ;  -- tuli
      SVcon  =>             (vf ! 8) ;  -- tulisi
      SVppa  => Predef.tk 2 (vf ! 9) ;  -- tull(ut)
      SVppp  => Predef.tk 1 (vf ! 10) ; -- tult(u)
      SVppg  => weakGrade   (vf ! 10) ; -- tullu(n)
      SVpot  => Predef.tk 1 (vf ! 11) ; -- tulle(e)
      SVpac  => Predef.tk 3 (vf ! 3)    -- tule(va)
      } ;
    h = aHarmony (last (vf ! 0)) ;
    } ;

  sverb2verb : Bool -> SVerb -> Verb = \b,sverb -> 
    let
      plus = plusIf b ;
      vh   = sverb.s ;

      tull    = vh ! SVInf ;    -- tull(a) 
      tule_   = vh ! SVps1 ;    -- tule(n) 
      tulee   = vh ! SVps3 ; 
      tule__  = vh ! SVpp3 ;    -- tule(vat)
      tulk_   = vh ! SVip2 ;    -- tulk(aa) 
      tulla_  = vh ! SVpas ;    -- tulla(an) 
      tuli_   = vh ! SVis1 ;    -- tuli(n)
      tuli    = vh ! SVis3 ;
      tulisi  = vh ! SVcon ;
      tull_   = vh ! SVppa ;    -- tull(ut)
      tult_   = vh ! SVppp ;
      tullu__ = vh ! SVppg ;   -- tullu(n)
      tulle_  = vh ! SVpot ;   -- tulle(e)
      tule___ = vh ! SVpac ;   -- tule(va)

      a = harmonyA sverb.h ;
      o = harmonyV "o" "ö" sverb.h ;
      u = harmonyV "u" "y" sverb.h ;

      tulla   = plus tull a ;
      tulko   = plus tulk_ o ;
      tulkoo  = plus tulko o ;
      tullee  = plus tull_ "ee" ;
      tulle   = plus tull_ "e" ;
      tullu_  = plus tull_ u ;
      tullut  = plus tullu_ "t" ;
      tullun  = plus tullu_ "n" ; 
      tultu   = plus tult_ u ;

      tulev    = plus tule___ "v" ;
      tuleva   = plus tule___ ("v" + a) ;
      tulem    = plus tule___ "m" ;
      tulema   = plus tule___ ("m" + a) ;
      tultav   = plus tult_ (a + "v") ;
      tultava  = plus tult_ (a + "v" + a) ;

      tullutN : Noun = snoun2noun b {
        s = table SNForm [
          tullut ;
          tullee ;
          plus tullut ("t" + a) ;
          tullee ; -- essive stem; ("n" + a)  is added in snoun2noun
          plus tullee "see" ;
          plus tulle "ide" ;
          plus tulle ("it" + a) ;
          plus tulle "i" ;
          plus tulle "i" ;
          plus tulle "isii" ;
          tullut 
        ] ;
        h = sverb.h
        } ;

      tultuN  : Noun = snoun2noun b {
        s = table SNForm [
          tultu ;
          tullu__ ;
          plus tultu a ;
          tultu ; -- essive stem; ("n" + a)  is added in snoun2noun
          plus tultu u ;
          plus tultu "je" ;
          plus tultu ("j" + a) ;
          plus tultu "i" ;
          plus tullu__ "i" ;
          plus tultu "ihi" ;
          tultu
        ] ;
        h = sverb.h
        } ;

      tulevaN : Noun = snoun2noun b {
        s = table SNForm [
          tuleva ;
          tuleva ;
          plus tuleva a ;
          tuleva  ; -- essive stem; ("n" + a) is added in snoun2noun
          plus tuleva a ;
          plus tulev "ie" ;
          plus tulev ("i" + a) ;
          plus tulev "i" ;
          plus tulev "i" ;
          plus tulev "ii" ;
          tuleva
        ] ;
        h = sverb.h
        } ;

      tultavaN : Noun = snoun2noun b {
        s = table SNForm [
          tultava ;
          tultava ;
          plus tultava a ;
          tultava ; -- essive stem ; ("n" + a) is added in snoun2noun
          plus tultava a ;
          plus tultav "ie" ;
          plus tultav ("i" + a) ;
          plus tultav "i" ;
          plus tultav "i" ;
          plus tultav "ii" ;
          tuleva
        ] ;
        h = sverb.h
        } ;

      tulemaN : Noun = snoun2noun b {
        s = table SNForm [
          tulema ;
          tulema ;
          plus tulema a ;
          tulema ;
          plus tulema a ;
          plus tulem "ie" ;
          plus tulem ("i" + a) ;
          plus tulem "i" ;
          plus tulem "i" ;
          plus tulem "ii" ;
          tulema
        ] ;
        h = sverb.h
        } ;


      vat     = "v" + a + "t"
    in
    {s = table {
      Inf Inf1 => tulla ;
      Inf Inf1Long  => plus tulla "kse" ;
      Inf Inf2Iness => plus tull ("ess" + a) ;
      Inf Inf2Instr => plus tull "en" ;
      Inf Inf2InessPass => plus tult_ (a + "ess" + a) ;
      Inf Inf3Iness => plus tulema ("ss" + a) ;
      Inf Inf3Elat  => plus tulema ("st" + a) ;
      Inf Inf3Illat => plus tulema (a + "n") ;
      Inf Inf3Adess => plus tulema ("ll" + a) ;
      Inf Inf3Abess => plus tulema ("tt" + a) ;
      Inf Inf3Instr => plus tulema "n" ;
      Inf Inf3InstrPass => plus tult_ (a + "m" + a + "n") ;
      Inf Inf4Nom   => plus tule__ "minen" ;
      Inf Inf4Part  => plus tule__ ("mist" + a) ; 
      Inf Inf5      => plus tulema ("isill" + a) ;
      Inf InfPresPart => plus tuleva "n" ;
      Inf InfPresPartAgr => tuleva ;

      Presn Sg P1  => plus tule_ "n" ;
      Presn Sg P2  => plus tule_ "t" ;
      Presn Sg P3  => tulee ;
      Presn Pl P1  => plus tule_ "mme" ;
      Presn Pl P2  => plus tule_ "tte" ;
      Presn Pl P3  => plus tule__ vat ;
      Impf Sg P1   => plus tuli_ "n" ;    --# notpresent
      Impf Sg P2   => plus tuli_ "t" ;    --# notpresent
      Impf Sg P3   => tuli ;              --# notpresent
      Impf Pl P1   => plus tuli_ "mme" ;  --# notpresent
      Impf Pl P2   => plus tuli_ "tte" ;  --# notpresent
      Impf Pl P3   => plus tuli vat ;     --# notpresent
      Condit Sg P1 => plus tulisi "n" ;   --# notpresent
      Condit Sg P2 => plus tulisi "t" ;   --# notpresent
      Condit Sg P3 => tulisi ;            --# notpresent
      Condit Pl P1 => plus tulisi "mme" ; --# notpresent
      Condit Pl P2 => plus tulisi "tte" ; --# notpresent
      Condit Pl P3 => plus tulisi vat ;   --# notpresent
      Potent Sg P1 => plus tulle_ "n" ;   --# notpresent
      Potent Sg P2 => plus tulle_ "t" ;   --# notpresent
      Potent Sg P3 => plus tulle_ "e" ;   --# notpresent
      Potent Pl P1 => plus tulle_ "mme" ; --# notpresent
      Potent Pl P2 => plus tulle_ "tte" ; --# notpresent
      Potent Pl P3 => plus tulle_ vat ;   --# notpresent
      PotentNeg    => tulle_ ;   --# notpresent
      Imper Sg     => tule_ ;
      Imper Pl     => plus tulk_ (a + a) ;
      ImperP3 Sg   => plus tulkoo "n" ;
      ImperP3 Pl   => plus tulkoo "t" ;
      ImperP1Pl    => plus tulk_ (a + a + "mme") ;
      ImpNegPl     => tulko ;
      PassPresn True    => plus tulla_ (a + "n") ;
      PassPresn False   => tulla_ ;
      PassImpf True     => plus tult_ ("iin") ;       --# notpresent
      PassImpf False    => tultu ;                    --# notpresent
      PassCondit True   => plus tult_ (a + "isiin") ; --# notpresent
      PassCondit False  => plus tult_ (a + "isi") ;   --# notpresent
      PassPotent True   => plus tult_ (a + "neen") ; --# notpresent
      PassPotent False  => plus tult_ (a + "ne") ; --# notpresent
      PassImper True    => plus tult_ (a + "k" + o + o + "n") ;
      PassImper False   => plus tult_ (a + "k" + o) ;

      PresPartAct (AN n)  => tulevaN.s ! n ;
      PresPartAct AAdv    => plus tuleva "sti" ;
      PresPartPass (AN n)  => tultavaN.s ! n ;
      PresPartPass AAdv    => plus tultava "sti" ;

      PastPartAct (AN n)  => tullutN.s ! n ;
      PastPartAct AAdv    => plus tullee "sti" ;
      PastPartPass (AN n) => tultuN.s ! n ;
      PastPartPass AAdv   => plus tullu__ "sti" ;

      AgentPart (AN n)  => tulemaN.s ! n ;
      AgentPart AAdv    => plus tulema "sti" 

      } ;
    sc = SCNom ;
    lock_V = <>
    } ;

  predSV : SVerb1 -> VP = predV ; 


-- word formation functions

  sverb2snoun : SVerb1 -> SNoun = \v ->    -- syöminen
    let teke = v.s ! SVpac in {
    s = table {
      0 => partPlus teke "minen" ;
      1 => partPlus teke "mise" ;
      2 => partPlus teke "mista" ;  ---- vh
      3 => partPlus teke "mise" ; 
      4 => partPlus teke "misee" ;
      5 => partPlus teke "miste" ; 
      6 => partPlus teke "misia" ; ---- vh
      7 => partPlus teke "misi" ; 
      8 => partPlus teke "misi" ; 
      9 => partPlus teke "misii" ;
     10 => partPlus teke "mis" 
      } ; 
    h = v.h
    } ;

  sverb2nounPresPartAct : SVerb1 -> SNoun = \v ->  -- syövä
    let teke = v.s ! SVpac in {
    s = table {
      0 => partPlus teke "va" ;
      1 => partPlus teke "va" ;
      2 => partPlus teke "vaa" ;  ---- vh
      3 => partPlus teke "va" ;   ---- vh
      4 => partPlus teke "vaa" ;
      5 => partPlus teke "vie" ; 
      6 => partPlus teke "via" ; ---- vh
      7 => partPlus teke "vi" ; 
      8 => partPlus teke "vi" ; 
      9 => partPlus teke "vii" ;
     10 => partPlus teke "va" 
      } ; 
    h = v.h
    } ;

  sverb2nounPresPartPass : SVerb1 -> SNoun = \v ->  -- syötävä
    let a = harmonyA v.h in
    nforms2snoun (dLava (partPlus (v.s ! SVppp) (partPlus "t" (partPlus a (partPlus "v" a))))) ;

  dLava : Str -> NForms = \s -> dUkko s (s + "n") ;
  
 --- to use these at run time in ParseFin
  partPlus = glue ;

-- auxiliary

    plusIf : Bool -> Str -> Str -> Str = \b,x,y -> case b of {
      True  => x + y ;
      False => glue x y 
      } ;

-- for Symbol

  addStemEnding : Str -> SPN = \i -> {
    s = \\c => i ++ bindColonIfS c ++ case c of {
      0 => "" ;
      1 => "i" ;
      2 => "ia" ;
      3 => "i" ;
      4 => "ii" ;
      5 => "ie" ;
      6 => "ia" ;
      7 => "i" ;
      8 => "i" ;
      9 => "ihi" ;
     10 => "" 
     } ;
    h = Back ----
    } ;
 
  bindIfS : SNForm -> Str = \c -> case c of {
    0 | 10 => [] ;
    _ => BIND
    } ;
  bindColonIfS : SNForm -> Str = \c -> case c of {
    0 | 10 => [] ;
    _ => BIND ++ ":" ++ BIND
    } ;


-----------------------------------------------------------------------
---- a hack to make VerbFin compile accurately for library (in ../), 
---- and in a simplified way for ParseFin (here)

  slashV2VNP : (SVerb1 ** {c2 : Compl ; vi : VVType}) -> (NP ** {isNeg : Bool}) -> 
    (VP ** {c2 : Compl}) -> (VP ** {c2 : Compl}) = 
    \v, np, vp -> {
      s  = v ;
      s2 = \\fin,b,a =>  appCompl fin b v.c2 np ++ v.s ! SVInf ;
                         ---- infVP v.sc b a vp v.vi ;
                         -- ignoring Acc variation and pre/postposition and proper inf form
      ext = [] ;
      adv = \\_ => v.p ;
      vptyp = vp.vptyp ; -- ignoring np.isNeg
      c2 = vp.c2
      } ;

--------------------------------

---- VP now stemming-dependent. AR 7/12/2013

  VP = {
    s   : SVerb1 ;
    s2  : Bool => Polarity => Agr => Str ; -- talo/talon/taloa
    adv : Polarity => Str ; -- ainakin/ainakaan
    ext : Str ;
    vptyp : {isNeg : Bool ; isPass : Bool} ;-- True if some complement is negative, and if the verb is rendered in the passive
    } ;

  defaultVPTyp = {isNeg = False ; isPass = False} ;
 
  predV : SVerb1 -> VP = \verb -> {
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
     verb = sverb2verbSep vp.s ;
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
    sc = vp.s.sc ;
    h = vp.s.h ;
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
    s = {s = vp.s.s ; h = vp.s.h ; p = vp.s.p ; sc = npform2subjcase pr.c} ; -- minusta pidetään 
    s2 = \\b,p,a => pr.s.p1 ++ vp.s2 ! b ! p ! a ++ pr.s.p2 ;  ---- possessive suffix
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
            Neg => <(vp2old_vp (predV vpVerbOlla)).s ! VIInf vi ! Simul ! Pos ! agr,
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

  vpVerbOlla : SVerb1 = {
    s = ollaSVerbForms ;
    sc = SCNom ; h = Back ; lock_V = <> ; p = []
    } ;
}