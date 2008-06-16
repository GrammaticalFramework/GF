--# -path=.:../abstract:../common:../../prelude

concrete PhraseRus of Phrase = CatRus ** open Prelude, ResRus in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! Masc! Sg} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! Masc!Pl} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! Masc! Sg} ; ---- ?? AR

    UttIP ip = {s = ip.s ! PF Nom No NonPoss} ; --- Acc also
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! PF Acc No NonPoss} ;
    UttVP vp = {s = vp.s ! ClInfinit ! ASg Masc! P3} ;
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = ss conj.s2 ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! PF Nom No NonPoss} ;

}
