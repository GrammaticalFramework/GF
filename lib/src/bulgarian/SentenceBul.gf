--# -coding=cp1251
concrete SentenceBul of Sentence = CatBul ** open Prelude, ResBul in {
  flags coding=cp1251 ;


  flags optimize=all_subs ;

  lin
    PredVP np vp = mkClause (np.s ! (case vp.vtype of {
                                       VNormal    => RSubj ;
                                       VMedial  _ => RSubj ;
                                       VPhrasal c => RObj c})) np.a np.p vp ;

    PredSCVP sc vp = let agr = {gn=GSg Masc; p=P3} in mkClause (sc.s ! agr) agr Pos vp ;

    ImpVP vp = {
      s = \\p,gn => 
        let agr    = {gn = gn ; p = P2} ;
            verb   : Aspect -> Str
                   = \asp -> vp.s ! asp ! VImperative (numGenNum gn) ;
            compl  = vp.compl ! agr ;
            clitic = case vp.vtype of {
	                   VNormal    => [] ;
	                   VMedial c  => reflClitics ! c ;
	                   VPhrasal c => personalClitics ! c ! agr.gn ! agr.p
	                 } ;
        in case p of {Pos => vp.ad.s ++ verb Perf ++ clitic ;
                      Neg => "не" ++ vp.ad.s ++ clitic ++ verb Imperf} ++ compl ;
    } ;

    SlashVP np slash =  {
      s = \\agr => (mkClause (np.s ! RSubj) np.a np.p {s      = slash.s ;
                                                       ad     = slash.ad ;
                                                       compl  = \\_ => slash.compl1 ! np.a ++ slash.compl2 ! agr ;
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
      s = \\agr => (mkClause (np.s ! RSubj) np.a np.p
                             (insertObj (\\_ => "че" ++ slash.s ! agr) Pos (predV vs))).s ;
      c2 = slash.c2
    } ;

    EmbedS  s  = {s = \\_ => "че" ++ s.s} ;
    EmbedQS qs = {s = \\_ => qs.s ! QIndir} ;
    EmbedVP vp = {s = \\agr => daComplex Simul Pos vp ! Perf ! agr} ;

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

    ExtAdvS a s = {s = a.s ++ comma ++ s.s} ;
    AdvS a s = {s = a.s ++ s.s} ;

    SSubjS a s b = {s = a.s ++ comma ++ s.s ++ b.s} ;

    RelS s r = {s = s.s ++ comma ++ r.s ! {gn=gennum ANeut Sg; p=P3}} ;
}
