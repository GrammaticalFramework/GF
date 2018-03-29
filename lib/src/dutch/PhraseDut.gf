concrete PhraseDut of Phrase = CatDut ** open Prelude, ResDut in 
{


  flags optimize=all_subs ;

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = {s = s.s ! Main} ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Sg False} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Pl False} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Sg True} ;

    UttIP ip = {s = ip.s ! NPNom} ; --- Acc also
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! NPNom} ;
    UttVP vp = {s = useInfVP True vp} ;  -- without zu
    UttAdv adv = adv ;
    UttCN n = {s = n.s ! Strong ! NF Sg Nom} ;
    UttCard n = {s = n.s ! Utr ! Nom} ;
    UttAP ap = {s = ap.s ! agrP3 Sg ! APred} ;

    UttInterj i = i ;
    UttAdV a = a ;

    NoPConj = {s = []} ;
    PConjConj conj = ss (conj.s2) ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! NPNom} ;

}
