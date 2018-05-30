--# -coding=cp1251
concrete PhraseBul of Phrase = CatBul ** open Prelude, ResBul in {
  flags coding=cp1251 ;


  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg  pol imp = {s = pol.s ++ imp.s ! pol.p ! GSg Masc} ;
    UttImpPl  pol imp = {s = pol.s ++ imp.s ! pol.p ! GPl} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! GPl} ;

    UttIP ip = {s = ip.s ! RSubj ! QDir} ;
    UttIAdv iadv = {s = iadv.s ! QDir} ;
    UttNP np = {s = np.s ! RSubj} ;
    UttVP vp = {s = daComplex Simul Pos vp ! Perf ! agrP3 (GSg Neut)} ;
    UttAdv adv = adv ;
    UttCN n = {s = n.s ! NF Sg Indef} ;
    UttCard n = {s = n.s ! CFNeut Indef} ;
    UttAP ap = {s = ap.s ! ASg Masc Indef ! P3} ;
    UttInterj i = i ;

    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s ++ linCoord!conj.conj} ;

    NoVoc = {s = []} ;
    VocNP np = {s = comma ++ np.s ! RVoc} ;
}
