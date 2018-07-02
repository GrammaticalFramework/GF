concrete SentenceEng of Sentence = CatEng ** open Prelude, ResEng in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = mkClause (np.s ! npNom) np.a vp ;

    PredSCVP sc vp = let a = agrP3 Sg in mkClause (sc.s ! a) a vp ;

    ImpVP vp = {
      s = \\pol,n => 
        let 
          agr   = AgP2 (numImp n) ;
          verb  = infVP VVAux vp False Simul CPos agr ;
          dont  = case pol of {
            CNeg True => "don't" ;
            CNeg False => "do" ++ "not" ;
            _ => []
            }
        in
        dont ++ verb
    } ;

    SlashVP np vp = 
      mkClause (np.s ! npNom) np.a vp ** {c2 = vp.c2} ;

    AdvSlash slash adv = {
      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = cl ** {c2 = prep.s} ;

    SlashVS np vs slash = 
      mkClause (np.s ! npNom) np.a 
        (insertObj (\\_ => conjThat ++ slash.s) (predV vs))  **
        {c2 = slash.c2} ;

    EmbedS  s  = {s = \\_ => conjThat ++ s.s} ;
    EmbedQS qs = {s = \\_ => qs.s ! QIndir} ;
    EmbedVP vp = {s = \\a => infVP VVInf vp False Simul CPos a} ;

    UseCl  t p cl = {
      s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! ctr p.p ! oDir
    } ;
    UseQCl t p cl = {
      s = \\q => t.s ++ p.s ++ cl.s ! t.t ! t.a ! ctr p.p ! q
    } ;
    UseRCl t p cl = {
      s = \\r => t.s ++ p.s ++ cl.s ! t.t ! t.a ! ctr p.p ! r ;
      c = cl.c
    } ;
    UseSlash t p cl = {
      s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! ctr p.p  ! oDir ;
      c2 = cl.c2
    } ;

    AdvS a s = {s = a.s ++ s.s} ;
    ExtAdvS a s = {s = a.s ++ frontComma ++ s.s} ;

    SSubjS a s b = {s = a.s ++ frontComma ++ s.s ++ b.s} ;

    RelS s r = {s = s.s ++ frontComma ++ r.s ! agrP3 Sg} ;

  oper
    ctr : CPolarity -> CPolarity = \x -> x ;
---    ctr = contrNeg True ;  -- contracted negations

}

