concrete RelativeTha of Relative = CatTha ** open ResTha, Prelude in {

  lin
    RelCl cl = {s = \\p => thbind thii_s (cl.s ! ClDecl ! p)} ; ---- ??
    RelVP rp vp = mkPolClause rp vp ;
    RelSlash rp slash = {s = \\p => thbind slash.c2 rp.s (slash.s ! p)} ;
    FunRP p np rp = {s = thbind np.s p.s rp.s} ; ---- ??
    IdRP = ss thii_s ;

}
