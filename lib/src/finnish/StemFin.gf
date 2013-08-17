-- dummy opers implementing the API of stem-based morphology in finnish/stemmed

resource StemFin = open MorphoFin, Prelude in {

flags coding = utf8 ;

oper
  SNForm : Type = NForm ;
  SNoun : Type = Noun ;

  nforms2snoun : NForms -> SNoun = nForms2N ;

    snoun2nounBind : SNoun -> Noun = snoun2noun True ;
    snoun2nounSep  : SNoun -> Noun = snoun2noun False ;

    snoun2noun : Bool -> SNoun -> Noun = \b,sn -> sn ;


    snoun2np : Number -> SPN -> NPForm => Str = \n,sn ->
      \\c => sn.s ! (npform2case n c) ; 

    noun2snoun : Noun -> SNoun = \n -> n ;

    aHarmony : Str -> Harmony = \a -> case a of 
       {"a" => Back ; _   => Front} ;

    harmonyA : Harmony -> Str = harmonyV "a" "ä" ;

    harmonyV : Str -> Str -> Harmony -> Str = \u,y,h -> case h of 
       {Back => u ; Front => y} ;


  SPN : Type = {s : Case  => Str} ;

  snoun2spn : SNoun -> SPN = \n -> {s = \\c => n.s ! NCase Sg c} ;

  exceptNomSNoun : SNoun -> Str -> SNoun = \noun,nom -> {
      s = table {
        NCase Sg Nom => nom ;
        f => noun.s ! f
	} ;
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
      tuoree = init (tuore.s ! NCase Sg Gen) ;
      tuoreesti  = tuoree + "sti" ; 
      tuoreemmin =  init tuoree ;
    in {s = table {
         AN f => tuore.s ! f ;
         AAdv => if_then_Str isPos tuoreesti tuoreemmin
         } ;
        h = tuore.h
       } ;

   sAN : SNForm -> SAForm = \n -> AN n ;  ---- without eta exp gives internal error 6/8/2013
   sAAdv : SAForm = AAdv ;
   sANGen : (SAForm => Str) -> Str = \a -> a ! AN (NCase Sg Gen) ;

    mkAdj : (hyva,parempi,paras : SNoun) -> (hyvin,paremmin,parhaiten : Str) -> {s : Degree => SAForm => Str ; h : Harmony} = \h,p,ps,hn,pn,ph -> {
      s = table {
        Posit => table {
           AN nf => h.s ! nf ;
           AAdv  => hn
           } ; 
        Compar => table {
           AN nf => p.s ! nf ;
           AAdv  => pn
           } ; 
        Superl => table {
           AN nf => ps.s ! nf ;
           AAdv  => ph
           }
        } ;
      h = h.h
      } ;

  snoun2compar : SNoun -> Str = \n -> init (n.s ! NCase Sg Gen) + "mpi" ; ---- kivempi
  snoun2superl : SNoun -> Str = \n -> n.s ! NInstruct ; ---- kivin vs. kivoin

-- verbs

oper
  SVForm : Type = VForm ;
  SVerb : Type = {s : SVForm => Str ; h : Harmony} ;

  ollaSVerbForms : SVForm => Str = verbOlla.s ;

  -- used in Cat
  SVerb1 = {s : SVForm => Str ; sc : NPForm ; h : Harmony ; p : Str} ;

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
    {s = \\c => i ++ bindColonIfS (NCase Sg c) ++ defaultCaseEnding c} ;

  bindIfS : SNForm -> Str = \c -> case c of {
    NCase Sg Nom => [] ;
    _ => BIND
    } ;

  bindColonIfS : SNForm -> Str = \c -> case c of {
    NCase Sg Nom => [] ;
    _ => BIND ++ ":" ++ BIND
    } ;

-----------------------------------------------------------------------
---- a hack to make VerbFin compile accurately for library (here), 
---- and in a simplified way for ParseFin (in stemmed/)

  slashV2VNP : (SVerb1 ** {c2 : Compl ; vi : InfForm}) -> (NP ** {isNeg : Bool}) -> 
    (VP ** {c2 : Compl}) -> (VP ** {c2 : Compl}) 
    = \v, np, vp -> 
      insertObjPre np.isNeg
        (\fin,b,a ->  appCompl fin b v.c2 np ++ 
                      infVP v.sc b a vp v.vi) 
          (predSV v) ** {c2 = vp.c2} ;


}