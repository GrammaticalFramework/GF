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


-- verbs

oper
  SVForm : Type = Predef.Ints 13 ;
  SVerb : Type = {s : SVForm => Str ; h : Harmony} ;

  -- used in Cat
  SVerb1 = {s : SVForm => Str ; sc : NPForm ; h : Harmony ; p : Str} ;

  sverb2verbBind : SVerb -> Verb = sverb2verb True ;
  sverb2verbSep  : SVerb -> Verb = sverb2verb False ;

  vforms2sverb : VForms -> SVerb = \vf -> {
    s = table {
      0  =>             (vf ! 0) ;  -- tulla
      1  => Predef.tk 1 (vf ! 1) ;  -- tule(n)
      2  =>             (vf ! 2) ;  -- tulee
      3  => Predef.tk 3 (vf ! 3) ;  -- tule(vat)
      4  => Predef.tk 2 (vf ! 4) ;  -- tulk(aa)
      5  => Predef.tk 2 (vf ! 5) ;  -- tulla(an)
      6  => Predef.tk 1 (vf ! 6) ;  -- tuli(n)
      7  =>             (vf ! 7) ;  -- tuli
      8  =>             (vf ! 8) ;  -- tulisi
      9  => Predef.tk 2 (vf ! 9) ;  -- tull(ut)
      10 => Predef.tk 1 (vf ! 10) ; -- tult(u)
      11 => weakGrade   (vf ! 10) ; -- tullu(n)
      12 => Predef.tk 1 (vf ! 11) ; -- tulle(e)
      13 => Predef.tk 3 (vf ! 3)    -- tule(va)
      } ;
    h = aHarmony (last (vf ! 0)) ;
    } ;

  sverb2verb : Bool -> SVerb -> Verb = \b,sverb -> 
    let
      plus = plusIf b ;
      vh   = sverb.s ;

      tulla   = vh ! 0 ; 
      tule_   = vh ! 1 ;    -- tule(n) 
      tulee   = vh ! 2 ; 
      tule__  = vh ! 3 ;    -- tule(vat)
      tulk_   = vh ! 4 ;    -- tulk(aa) 
      tulla_  = vh ! 5 ;    -- tulla(an) 
      tuli_   = vh ! 6 ;    -- tuli(n)
      tuli    = vh ! 7 ;
      tulisi  = vh ! 8 ;
      tull_   = vh ! 9 ;    -- tull(ut)
      tult_   = vh ! 10 ;
      tullu__ = vh ! 11 ;   -- tullu(n)
      tulle_  = vh ! 12 ;   -- tulle(e)
      tule___ = vh ! 13 ;   -- tule(va)

      a = harmonyA sverb.h ;
      o = harmonyV "o" "ö" sverb.h ;
      u = harmonyV "u" "y" sverb.h ;

      tulko   = plus tulk_ o ;
      tulkoo  = plus tulko o ;
      tullee  = plus tull_ "ee" ;
      tulle   = plus tull_ "e" ;
      tullu_  = plus tull_ u ;
      tullut  = plus tullu_ "t" ;
      tullun  = plus tullu_ "n" ; 
      tultu   = plus tult_ u ;

      tuleva  = plus tule___ ("v" + a) ;

      tullutN : Noun = snoun2noun b {
        s = table SNForm [
          tullut ;
          tullee ;
          plus tullut ("t" + a) ;
          plus tullee ("n" + a) ;
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
          plus tultu ("n" + a) ;
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


      tulema  = plus tule___ ("m" + a) ;
      vat     = "v" + a + "t"
    in
    {s = table {
      Inf Inf1 => tulla ;
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
      PastPartAct (AN n)  => tullutN.s ! n ;
      PastPartAct AAdv    => plus tullee "sti" ;
      PastPartPass (AN n) => tultuN.s ! n ;
      PastPartPass AAdv   => plus tullu__ "sti" ;
      Inf Inf3Iness => plus tulema ("ss" + a) ;
      Inf Inf3Elat  => plus tulema ("st" + a) ;
      Inf Inf3Illat => plus tulema (a + "n") ;
      Inf Inf3Adess => plus tulema ("ll" + a) ;
      Inf Inf3Abess => plus tulema ("tt" + a) ;
      Inf InfPresPart => plus tuleva "n" ;
      Inf InfPresPartAgr => tuleva
      } ;
    sc = NPCase Nom ;
    lock_V = <>
    } ;

  predSV : SVerb1 -> VP = \sv ->
    predV (sverb2verbSep sv ** {p = sv.p ; sc = sv.sc ; qp = case sv.h of {Back => True ; Front => False}}) ;
--    (Verb ** {sc : NPForm ; qp : Bool ; p : Str}) -> VP = \verb -> {


-- word formation functions

  sverb2snoun : SVerb1 -> SNoun = \v ->    -- syöminen
    let teke = v.s ! 13 in {
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
    let teke = v.s ! 13 in {
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
    nforms2snoun (dLava (partPlus (v.s ! 3) (partPlus "t" (partPlus a (partPlus "v" a))))) ;

  dLava : Str -> NForms = \s -> dUkko s (s + "n") ;
  
 --- to use these at run time in ParseFin
  partPlus = glue ;

-- auxiliary

    plusIf : Bool -> Str -> Str -> Str = \b,x,y -> case b of {
      True  => x + y ;
      False => glue x y 
      } ;

-- for Symbol

  defaultStemEnding : SNForm -> Str = \c -> case c of {
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
  bindIfS : SNForm -> Str = \c -> case c of {
    0 | 10 => [] ;
    _ => BIND
    } ;
  bindColonIfS : SNForm -> Str = \c -> case c of {
    0 | 10 => [] ;
    _ => BIND ++ ":" ++ BIND
    } ;

}