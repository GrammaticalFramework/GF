--1 Construction rules for latin verb phrases
concrete VerbLat of Verb = CatLat ** open (S=StructuralLat),ResLat,IrregLat in {

  flags optimize=all_subs ;

  lin
--2 Complementization rules

--  UseV : V -> VP
    UseV = predV ; -- dormire

--  ComplVV : VV -> VP -> VP ;  -- want to run        
    ComplVV v vp =
      {
	fin = vp.fin ;
	inf = v.inf ;
	obj = vp.obj ;
	adj = vp.adj
      };

--  ComplVS : VS -> S -> VP ;  -- say that she runs
    ComplVS v s  = insertObj (S.that_Subj.s ++ s.s) (predV v) ;

--  ComplVQ : VQ -> QS -> VP ;  -- wonder who runs
    ComplVQ v q  = insertObj ( q.s ! QIndir) (predV v) ;
    
--  ComplVA : VA -> AP -> VP ;  -- they become red
    ComplVA v ap = (predV v) ** { adj = ap.s } ;

--  SlashV2a : V2 -> VPSlash ;  -- love (it)
    SlashV2a v = lin VP (predV2 v) ;

--    Slash2V3 v np = 
    --      insertObjc (\\_ => v.c2 ++ np.s ! Acc) (predV v ** {c2 = v.c3}) ;
    
--  Slash3V3 : V3  -> NP -> VPSlash ;  -- give (it) to her
    Slash3V3 v np =
      lin VP ( insertObjc ( v.c2.s ++ np.s ! v.c2.c ) ( predV3 v ) ) ;

--    SlashV2V v vp = insertObjc (\\a => infVP v.isAux vp a) (predVc v) ;

--    SlashV2S v s  = insertObjc (\\_ => conjThat ++ s.s) (predVc v) ;

--  SlashV2Q : V2Q -> QS -> VPSlash ;  -- ask (him) who came
    SlashV2Q v q  = lin VP (insertObjc (q.s ! QIndir) (predV2 v) ) ;

--  SlashV2A : V2A -> AP -> VPSlash ;  -- paint (it) red
    SlashV2A v ap = lin VP ( (predV2 v) ** { adj = ap.s } ) ; 

--  ComplSlash : VPSlash -> NP -> VP ; -- love it
    ComplSlash vp np = -- VPSlash -> NP -> VP
      insertObj (appPrep vp.c2 np.s) vp ;

--    SlashVV vv vp = 
--      insertObj (\\a => infVP vv.isAux vp a) (predVV vv) **
--        {c2 = vp.c2} ;

--    SlashV2VNP vv np vp = 
--      insertObjPre (\\_ => vv.c2 ++ np.s ! Acc)
--        (insertObjc (\\a => infVP vv.isAux vp a) (predVc vv)) **
--          {c2 = vp.c2} ;

--2 Other ways of forming verb phrases
    
--    ReflVP v = insertObjPre (\\a => v.c2 ++ reflPron ! a) v ;    

--  UseComp : Comp -> VP
    UseComp comp = 
      insertAdj comp.s (predV be_V) ;

--    PassV2 v = insertObj (\\_ => v.s ! VPPart) (predAux auxBe) ;

--  AdvVP    : VP -> Adv -> VP ;        -- sleep here
    AdvVP vp adv = insertObj adv.s vp ;

--    ExtAdvVP vp adv = vp

--    AdVVP adv vp = insertObj adv.s vp ;

--    AdvVPSlash : VPSlash -> Adv -> VPSlash ;  -- use (it) here

--    AdVVPSlash : AdV -> VPSlash -> VPSlash ;  -- always use (it)
   
--    VPSlashPrep : VP -> Prep -> VPSlash ;  -- live in (it)

    --2 Complements to copula

--  CompAP : AP -> Comp
    CompAP ap = ap ;

--    CompNP np = {s = \\_ => np.s ! Acc} ;

--    CompAdv a = {s = \\_ => a.s} ;

--    CompCN

--    UseCopula v = v
}
