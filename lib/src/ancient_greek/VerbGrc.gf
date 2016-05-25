--# -path=.:../abstract:../prelude:../common:

concrete VerbGrc of Verb = CatGrc ** open Prelude, ResGrc, (M=MorphoGrc) in {

  flags optimize=all_subs ;

--2 Complementization rules

  lin
    UseV = predV ;

    SlashV2a v    = predV2 v ;
    Slash2V3 v np = insertObjc (\\a => v.c2.s ++ np.s ! v.c2.c) (predV v ** {c2 = v.c3}) ;
    Slash3V3 v np = insertObjc (\\a => v.c3.s ++ np.s ! v.c2.c) (predV2 v) ;

    ComplVV v vp  = insertObj (\\a => infVP vp a) (predV v) ;  -- predVV? Need this for the tablet sent. TODO
    ComplVS v s   = insertObj (\\_ => conjThat ++ s.s) (predV v) ;
    ComplVQ v q   = insertObj (\\_ => q.s ! QIndir) (predV v) ;
    ComplVA v ap  = insertObj (\\a => ap.s ! AF (genderAgr a) (numberAgr a) Nom) (predV v) ;  -- TODO check

    SlashV2V v vp = insertObjc (\\a => infVP vp a) (predV2 v) ;  
    SlashV2S v s  = insertObjc (\\_ => conjThat ++ s.s) (predV2 v) ;  
    SlashV2Q v q  = insertObjc (\\_ => q.s ! QIndir) (predV2 v) ;
--    SlashV2A v ap = insertObjc (\\a => ap.s ! AF (genderAgr a) (numberAgr a) Nom) (predV2 v) ;  -- TODO

    ComplSlash vp np = insertObj (\\a => appPrep vp.c2 np) vp ;   

--    SlashVV vv vp = 
--      insertObj (\\a => infVP vv.isAux vp a) (predVV vv) ** {c2 = vp.c2} ;

-- Need SlashV2V for the Greek school tablet example: advise the students to abstain from meat
-- abstract/Verb.gf: SlashV2V : V2V -> VP -> VPSlash ;  -- beg (her) to go
--                   SlashV2VNP : V2V -> NP -> VPSlash -> VPSlash ; -- beg me to buy

    SlashV2VNP vv np vp = 
      insertObjPre (\\_ => vv.c2.s ++ np.s ! vv.c2.c) 
        (insertObjc (\\a => infVP vp a) (predV2 vv)) ** {c2 = vp.c2} ;

--2 Other ways of forming verb phrases: 

    UseComp comp = insertObj comp.s (predV einai_V) ;

    ReflVP v = insertObjPre (\\a => v.c2.s ++ M.reflPron ! a ! v.c2.c) v ;

    -- experimental: Med/Pass
    PassV2 v = insertObjPre (\\a => case a of {Ag g n p => v.med ! Part GPres (AF g n Nom)})
--                           Irrefl => v.med ! Part GPres (AF Masc Sg Nom) })  -- default?? TODO
                         (predV M.eimi_V) ;

---    UseVS, UseVQ = \vv -> {s = vv.s ; c2 = [] ; isRefl = vv.isRefl} ; -- no "to"

    AdvVP vp adv = insertAdv adv.s vp ;

    AdVVP adv vp = insertObj (\\a => adv.s) vp ;

--2 Complements to copula

    CompAP ap = {s = \\agr => case agr of {Ag g n p => ap.s ! AF g n Nom} } ;
    CompNP np = {s = \\agr => np.s ! Nom} ;  -- TODO: How to drop defArt?
    CompAdv a = {s = \\agr => a.s} ;
    CompCN cn = {s = \\agr => let n = numberAgr agr 
                               in cn.s ! n ! Nom ++ cn.s2 ! n ! Nom} ;

-- Copula alone

    UseCopula = predV einai_V ;

  oper
    einai_V = (lin V M.eimi_V) ;
}
