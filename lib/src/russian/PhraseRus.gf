--# -path=.:../abstract:../common:../../prelude

concrete PhraseRus of Phrase = CatRus ** open Prelude, ResRus in {

  flags coding=utf8 ;
  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! Masc! Sg} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! Masc!Pl} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! Masc! Sg} ; ---- ?? AR

    UttIP ip = {s = ip.s ! PF Nom No NonPoss} ; --- Acc also
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! PF Nom No NonPoss} ; -- why was Acc instead of Nom here? (Liza Zimina 04/2018)
    UttVP vp = {s = vp.s ! ClInfinit ! GSg Masc ! P3} ;
    UttAdv adv = adv ;
    UttCN n = {s = n.nounpart ! NF Sg Nom nom ++ n.relcl ! Sg ! Nom} ;
    UttCard n = {s = n.s ! Neut ! Inanimate ! Nom} ;
    UttAP ap = {s = ap.s ! AF Nom Inanimate (GSg Neut)} ; ---- gennum ? (AR)
    UttInterj i = i ;

    NoPConj = {s = []} ;
    PConjConj conj = ss conj.s2 ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! PF Nom No NonPoss} ;

}
