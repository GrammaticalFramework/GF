concrete RelativeChi of Relative = CatChi ** open ResChi, Prelude in {

  lin
    RelCl cl = {s = \\p,a => cl.s ! p ! a ++ relative_s} ; ---- ??
    RelVP rp vp = {
       s = \\p,a => vp.prePart ++ useVerb vp.verb ! p ! a ++ vp.compl ++ rp.s
       } ; ---- ??
    RelSlash rp slash = {s = \\p,a => slash.s ! p ! a ++ appPrep slash.c2 rp.s} ;
    FunRP p np rp = ss (appPrep p np.s ++ rp.s) ; ---- ??
    IdRP = ss relative_s ;

}
