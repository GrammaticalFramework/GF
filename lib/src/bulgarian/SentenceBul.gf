--# -coding=cp1251
concrete SentenceBul of Sentence = CatBul ** open Prelude, ResBul in {
  flags coding=cp1251 ;


  flags optimize=all_subs ;

  lin
    PredVP np vp = mkClause (case vp.vtype of {
                                VNormal    => np.s ! RSubj ;
                                VMedial  _ => np.s ! RSubj ;
                                VPhrasal c => linCase c (personPol np.p) ++ np.s ! RObj CPrep}) np.gn np.p vp ;

    PredSCVP sc vp = mkClause (sc.s ! {gn=GSg Masc; p=P3}) (GSg Masc) (NounP3 Pos) vp ;

    ImpVP vp = {
      s = \\p,gn => 
        let agr    = {gn = gn ; p = P2} ;
            verb   : Aspect -> Str
                   = \asp -> vp.s ! asp ! VImperative (numGenNum gn) ;
            compl  = vp.compl ! agr ;
            clitic = case vp.vtype of {
                       VNormal      => vp.clitics;
                       VMedial c    => vp.clitics++reflClitics ! c;
                       VPhrasal Dat => personalClitics agr ! Dat++vp.clitics;
                       VPhrasal c   => vp.clitics++personalClitics agr ! c
                     }
        in case orPol p vp.p of {
             Pos => vp.ad.s ++ verb Perf ++ clitic ;
             Neg => "не" ++ vp.ad.s ++ clitic ++ verb Imperf
           } ++ compl ;
    } ;

    SlashVP np slash =  {
      s = \\agr => (mkClause (np.s ! RSubj) np.gn np.p {s      = slash.s ;
                                                        ad     = slash.ad ;
                                                        clitics= slash.clitics ;
                                                        compl  = \\_ => slash.compl1 ! personAgr np.gn np.p ++ slash.compl2 ! agr ;
                                                        vtype  = slash.vtype ;
                                                        p      = Pos ;
                                                        isSimple = slash.isSimple}).s ;
      c2 = slash.c2
    } ;

    AdvSlash slash adv = {
      s  = \\agr,t,a,b,o => slash.s ! agr ! t ! a ! b ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = {s = \\_ => cl.s; c2 = prep} ;
    
    SlashVS np vs slash = {
      s = \\agr => (mkClause (np.s ! RSubj) np.gn np.p
                             (insertObj (\\_ => "че" ++ slash.s ! agr) Pos (predV vs))).s ;
      c2 = slash.c2
    } ;

    EmbedS  s  = {s = \\_ => "че" ++ s.s} ;
    EmbedQS qs = {s = \\_ => qs.s ! QIndir} ;
    EmbedVP vp = {s = \\agr => daComplex Simul vp.p vp ! Perf ! agr} ;

    UseCl t p cl = {
      s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! Main
    } ;
    UseQCl t p cl = {
      s = \\q => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! q
    } ;
    UseRCl t p cl = {
      s    = \\agr => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! agr ;
      role = cl.role
    } ;
    UseSlash t p cl = {
      s = \\agr => t.s ++ p.s ++ cl.s ! agr ! t.t ! t.a ! p.p ! Main ;
      c2 = cl.c2
    } ;

    ExtAdvS a s = {s = a.s ++ bindComma ++ s.s} ;
    AdvS a s = {s = a.s ++ s.s} ;

    SSubjS a s b = {s = a.s ++ bindComma ++ s.s ++ b.s} ;

    RelS s r = {s = s.s ++ bindComma ++ r.s ! {gn=gennum ANeut Sg; p=P3}} ;
}
