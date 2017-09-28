concrete PhraseTur of Phrase = CatTur ** open Prelude, ResTur in {
  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    -- The following are utterly untested.
    -- Currently, they should be treated as just implementation stubs.
    UttQS qs = {s = qs.s} ;
    UttImpSg pol imp = {s = imp.s} ;
    UttImpPl pol imp = {s = imp.s} ;
    UttImpPol pol imp = {s = imp.s} ;
    UttIP ip = {s = ip.s} ;
    UttIAdv iadv = iadv ;
    UttCard n = {s = n.s ! Sg ! Nom} ;
    UttInterj i = i ;

    -- The following have been somewhat tested and seem to be working fine
    -- to some extent.
    UttNP np = {s = np.s ! Nom} ;
    UttVP vp = {s = vp.s ! VInfinitive} ;
    UttAP ap = {s = ap.s ! Sg ! Nom} ;
    UttCN n = {s = n.s ! Sg ! Nom} ;
    UttS s = s ;
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s} ;

    NoVoc = {s = []} ;
    VocNP np = {s = np.s ! Nom} ;
}
