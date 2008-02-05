concrete PhraseBul of Phrase = CatBul ** open Prelude, ResBul in {

  lin
    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg  pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Sg False} ;
    UttImpPl  pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Pl False} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Sg True } ;
}
