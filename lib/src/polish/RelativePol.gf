--# -path=.:../abstract:../common:../prelude

-- Adam Slaski, 2009 <adam.slaski@gmail.com>

concrete RelativePol of Relative = CatPol ** open ResPol, VerbMorphoPol in {

 flags optimize=all_subs ; coding=utf8 ;

 lin

-- ASL
-- In my opinion this is terribly medley of two phenomena. One of them is connected with funs RelCl and RelS.
-- The other with rest of the funs. Why don't separate them?


--     RelCl    : Cl -> RCl ;            -- such that John loves her
    RelCl cl = {
      s = \\_,pol, ant, ten => ["tak, że"] ++ cl.s ! pol ! ant ! ten
    };

--     RelVP    : RP -> VP -> RCl ;      -- who loves John
-- enormous memory usage !!! 
    RelVP rp vp = {
      s = \\gn => case rp.mgn of { 
        NoGenNum=>
          \\pol, anter, tense => 
            "," ++ rp.s !AF gn Nom ++ vp.prefix !pol !gn ++
            ((indicative_form vp.verb vp.imienne pol) !<tense, anter, gn, P3>) ++ 
            vp.sufix !pol !gn ++ vp.postfix !pol !gn;
        JustGenNum x => 
          \\pol, anter, tense => 
            "," ++ rp.s !AF gn Nom ++ vp.prefix !pol !x ++
            ((indicative_form vp.verb vp.imienne pol) !<tense, anter, x, P3>) ++ 
            vp.sufix !pol !x ++ vp.postfix !pol !x
         }  
    };

--     RelSlash : RP -> ClSlash -> RCl ; -- whom John loves
    RelSlash rp clslash = {
      s = \\gn, pol, anter, tense => 
        "," ++ clslash.c.s ++ rp.s !AF gn (extract_case!(npcase!<pol,clslash.c.c>)) ++ clslash.s !pol !anter !tense;
    };

--     IdRP  : RP ;                      -- which
    IdRP = { s = ktory; mgn = NoGenNum };
    
--     FunRP : Prep -> NP -> RP -> RP ;  -- the mother of whom
-- i have bad feelings about that. terrible overgeneratnig
-- policjant, (za którym ksiądz) kocha ... - wrong tree
-- should be policjant, ((za którym) (ksiądz) kocha)
    FunRP p n rp = { s = table { 
        AF gn Nom  => p.s ++ rp.s!AF gn (extract_case!p.c) ++ n.nom;
        AF gn VocP => p.s ++ rp.s!AF gn (extract_case!p.c) ++ n.voc;
        AF gn c    => p.s ++ rp.s!AF gn (extract_case!p.c) ++ n.dep!
            (case c of { Gen => GenNoPrep; Dat => DatNoPrep; Instr => InstrNoPrep; Acc => AccNoPrep; _=>LocPrep })
      };
      mgn = JustGenNum n.gn
    };

}
