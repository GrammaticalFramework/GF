concrete IdiomTha of Idiom = CatTha ** open Prelude, ResTha in {

  lin
    ImpersCl vp = mkClause (mkNP []) vp ;
    GenericCl vp = mkClause (mkNP []) vp ; ---- ??

    CleftNP np rs = {s = \\q,p => thbind (case p of{      ---- ??
      Pos => thbind np.s pen_s rs.s ;
      Neg => thbind np.s may_s chay_s rs.s
      })  (case q of {ClQuest => m'ay_s ; _ => []})
    } ;

    CleftAdv ad s = {s = \\q,p => thbind (negation p) ad.s s.s (case q of {ClQuest => m'ay_s ; _ => []})} ; ---- ??

    ExistNP np = {
      s = \\q,p => thbind (case p of {
        Pos => thbind mii_s np.s ;
        Neg => thbind may_s mii_s np.s
      }) (case q of {ClQuest => m'ay_s ; _ => []})
    } ;

    ExistIP ip = mkPolClause ip (predV (regV [])) ; ----

    ProgrVP vp = {
      s = \\p => thbind kam_s lag2_s (vp.s ! p) ;
      e = vp.e
      } ;

    ImpPl1 vp = ss (infVP vp) ; ----

}


