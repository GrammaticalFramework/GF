concrete ExtraPol of ExtraPolAbs = CatPol ** open ResPol in {

  lin ProDrop p = {
    nom = [] ;
    voc = p.voc ;
    dep = p.dep ;
    sp = p.sp ;
    n = p.n ;
    p = p.p ;
    g = p.g ;
 } ;
}
