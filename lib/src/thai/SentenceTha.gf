concrete SentenceTha of Sentence = CatTha ** 
  open Prelude, StringsTha, ResTha in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = mkClause np vp ;

    PredSCVP sc vp = mkClause sc vp ;

    ImpVP vp = {
      s = table {
        Pos => thbind (vp.s ! Pos) vp.e si_s ;
        Neg => thbind yaa_s (vp.s ! Pos) vp.e
        }
      } ;

    SlashVP np vp = mkPolClause np vp ** {c2 = vp.c2} ;

    SlashVS np vs slash = 
      mkPolClause np (insertObj (mkNP <thbind conjThat slash.s : Str>) (predV vs))  ** {c2 = slash.c2} ;

    AdvSlash slash adv = {
      s  = \\p => thbind (slash.s ! p) adv.s ;
      c2 = slash.c2
      } ;
  
    SlashPrep cl prep = {s = cl.s ! ClDecl ; c2 = prep.s} ;
  
    EmbedS  s  = {s = thbind conjThat s.s} ;
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = infVP vp} ;

    UseCl  t p cl = {s = t.s ++ p.s ++ (cl.s ! ClDecl ! p.p)} ; --- no bIND here, to prevent spurious &+ tokens
    UseQCl t p cl = {
      s = \\q => t.s ++ p.s ++
                 (case q of {QIndir => waa_s ; _ => []}) ++bIND++ (cl.s ! p.p)
      } ;
    UseRCl t p cl = {
      s = t.s ++ p.s ++ (cl.s ! p.p) ;
      } ;
    UseSlash  t p cl = {s = t.s ++ p.s ++ (cl.s ! p.p) ; c2 = cl.c2} ;

    AdvS a s = thbind a s ;

    RelS s r = thbind s r ;

    ExtAdvS a s = thbind a s ;
    SSubjS a c b = thbind a c b ;
}
