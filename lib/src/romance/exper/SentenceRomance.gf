incomplete concrete SentenceRomance of Sentence = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;
    coding=utf8 ;

  lin
    PredVP np vp = mknClause np vp ; 

    PredSCVP sc vp = mknClause (heavyNP {s = sc.s ; a = agrP3 Masc Sg}) vp ; 

    ImpVP vp = {
      s = \\p,i,g => case i of {
        ImpF n b => mkImperative b P2 vp ! p ! g ! n ---- AgPol ?
        }
      } ;

    SlashVP np vps = {np = np ; vp = vps ; c2 = vps.c2} ;

    AdvSlash slash adv = slash ** {vp = insertAdv adv.s slash.vp} ;

    SlashPrep cl prep = cl ** {c2 = {s = prep.s ; c = prep.c ; isDir = False}} ;

    SlashVS np vs slash = {
      np = np ; 
      vp = insertExtrapos (\\b => conjThat ++ slash.s ! {g = Masc ; n = Sg} ! (vs.m ! b)) (predV vs) ; ---- aag
      c2 = slash.c2
      } ;
{-
      {s = \\ag =>
        (mkClausePol np.isNeg
          (np.s ! Nom).comp False np.isPol np.a
          (insertExtrapos (\\b => conjThat ++ slash.s ! ag ! (vs.m ! b))
            (predV vs))
        ).s ;
       c2 = slash.c2
      } ;
-}
    EmbedS  s  = {s = \\_ => conjThat ++ s.s ! Indic} ; --- mood
    EmbedQS qs = {s = \\_ => qs.s ! QIndir} ;
    EmbedVP vp = {s = \\c => prepCase c ++ infVP vp (agrP3 Masc Sg)} ; --- agr ---- compl

    UseCl  t p ncl = let cl = oldClause ncl in {
      s = \\o => t.s ++ p.s ++ cl.s ! DDir ! t.t ! t.a ! p.p ! o
      } ;
    UseQCl t p qcl = let cl = oldQuestClause qcl in {
      s = \\q => t.s ++ p.s ++ cl.s ! q ! t.t ! t.a ! p.p ! Indic
    } ;
    UseRCl t p rcl = let cl = oldRelClause rcl in {
      s = \\r,ag => t.s ++ p.s ++ cl.s ! ag ! t.t ! t.a ! p.p ! r ; 
      c = cl.c
      } ;
    UseSlash t p ncl = let cl = oldClause ncl in {
      s = \\ag,mo => 
              t.s ++ p.s ++ cl.s !      DDir ! t.t ! t.a ! p.p ! mo ;
----          t.s ++ p.s ++ cl.s ! ag ! DDir ! t.t ! t.a ! p.p ! mo ;
      c2 = ncl.c2
    } ;

    AdvS a s = {s = \\o => a.s ++ s.s ! o} ;
    ExtAdvS a s = {s = \\o => a.s ++ "," ++ s.s ! o} ;

    SSubjS a s b = {s = \\m => a.s ! m ++ s.s ++ b.s ! s.m} ;

    RelS s r = {
      s = \\o => s.s ! o ++ "," ++ partQIndir ++ r.s ! Indic ! agrP3 Masc Sg
      } ;

}
