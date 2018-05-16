concrete RelativeChi of Relative = CatChi ** open ResChi, Prelude in {

  lin
    RelCl cl = {s = \\p,a => cl.s ! p ! a ++ relative_s} ; ---- ??
    RelVP rp vp = {
       s = \\p,a => case vp.isAdj of {
         True => vp.prePart ++ vp.compl ++ rp.s ! True ; ---- FunRP also ?
         _ => vp.prePart ++ useVerb vp.verb ! p ! a ++ vp.compl ++ rp.s ! False
	 } ;
       } ; ---- ??
    RelSlash rp slash = {s = \\p,a => slash.s ! p ! a ++ appPrep slash.c2 (rp.s ! False)} ;
    FunRP p np rp = {s = \\a => appPrep p np.s ++ rp.s ! a} ; ---- ??
    IdRP = {s = table {True => [] ; False => relative_s}} ;

}
