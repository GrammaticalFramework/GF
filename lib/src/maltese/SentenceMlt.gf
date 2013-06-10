-- SentenceMlt.gf: clauses and sentences
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Angelo Zammit 2012
-- Licensed under LGPL

--# -path=.:abstract:common:prelude

concrete SentenceMlt of Sentence = CatMlt ** open
  Prelude,
  ResMlt,
  ParamX in {

  flags optimize=all_subs ;

  lin
    -- NP -> VP -> Cl
    -- John walks
    PredVP np vp =
      let
        subj : Str = case np.isPron of {
          True => [] ; -- omit subject pronouns
          False => np.s ! NPNom
          } ;
      in
      mkClause subj np.a vp ;

    -- SC -> VP -> Cl
    -- that she goes is good
    PredSCVP sc vp = mkClause sc.s (agrP3 Sg Masc) vp ;

    -- VP -> Imp
    ImpVP vp = {
      -- s = \\pol,n => joinVP vp (VPImperat n) Simul pol ;
      s = \\pol,n => case pol of {
        Pos => (vp.v.s ! VImp n).s1 ++ vp.s2 ! agrP3 n Masc ;
        Neg => (vp.v.s ! VImp n).s2 ++ BIND ++ "x" ++ vp.s2 ! agrP3 n Masc
        } ;
    } ;

    -- NP -> VPSlash -> ClSlash
    -- (whom) he sees
    SlashVP np vp =
      mkClause (np.s ! npNom) np.a vp ** {c2 = vp.c2} ;

    -- ClSlash -> Adv -> ClSlash
    -- (whom) he sees today
    AdvSlash slash adv = {
      s  = \\t,a,p,o => slash.s ! t ! a ! p ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    -- Cl -> Prep -> ClSlash
    -- (with whom) he  walks
    -- SlashPrep cl prep = cl ** {c2 = prep} ;
    SlashPrep cl prep = cl ** {c2 = {
                                 s = prep.s ;
                                 enclitic = prep.enclitic ;
                                 takesDet = prep.takesDet ;
                                 joinsVerb = prep.joinsVerb ;
                                 isPresent = True ;
                                 }
      } ;

    -- NP -> VS -> SSlash -> ClSlash
    -- (whom) she says that he loves
    SlashVS np vs slash =
      mkClause (np.s ! npNom) np.a
        (insertObj (\\_ => conjLi ++ slash.s) (predV vs))  **
        {c2 = slash.c2} ;

    -- S -> SC
    -- that she goes
    EmbedS s = {
      s = conjLi ++ s.s
      } ;

    -- QS -> SC
    -- who goes
    EmbedQS qs = {
      s = qs.s ! QIndir
      } ;

    -- VP -> SC
    -- to go
    EmbedVP vp = {
      s = infVP vp Simul Pos (agrP3 Sg Masc)
      } ;

    -- Temp -> Pol -> Cl -> S
    UseCl t p cl = {
      s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! ODir
      } ;

    -- Temp -> Pol -> QCl -> QS
    UseQCl t p qcl = {
      s = \\q => t.s ++ p.s ++ qcl.s ! t.t ! t.a ! p.p ! q
    } ;

    -- Temp -> Pol -> RCl -> RS
    UseRCl t p rcl = {
      s = \\r => t.s ++ p.s ++ rcl.s ! t.t ! t.a ! p.p ! r ;
      -- c = cl.c
    } ;

    -- Temp -> Pol -> ClSlash -> SSlash
    UseSlash t p clslash = {
      s = t.s ++ p.s ++ clslash.s ! t.t ! t.a ! p.p ! ODir ;
      c2 = clslash.c2
    } ;

    -- Adv -> S -> S
    -- then I will go home
    AdvS a s = {
      s = a.s ++ s.s
      } ;

    -- Adv -> S -> S
    -- next week, I will go home
    ExtAdvS a s = {
      s = a.s ++ "," ++ s.s
      } ;

    -- S -> Subj -> S -> S
    -- I go home if she comes
    SSubjS a s b = {
      s = a.s ++ "," ++ s.s ++ b.s
      } ;

    -- S -> RS -> S
    -- she sleeps, which is good
    RelS s r = {
      s = s.s ++ "," ++ r.s ! agrP3 Sg Masc
      } ;

}
