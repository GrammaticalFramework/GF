concrete ExtraPol of ExtraPolAbs = CatPol ** open ResPol in {

  lin 

  QualifierCN adj cn = {
    s = \\n,c => (cn.s ! n ! c) ++ (adj.s ! AF (cast_gennum!<cn.g,n>) c);
    g = cn.g    
  };

  ProDrop p = {
    nom = [] ;
    voc = p.voc ;
    dep = p.dep ;
    sp = p.sp ;
    n = p.n ;
    p = p.p ;
    g = p.g ;
 } ;
}
