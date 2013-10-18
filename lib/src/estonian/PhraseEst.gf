concrete PhraseEst of Phrase = CatEst ** open ResEst, (P = Prelude) in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s} ;
    UttImpSg  pol imp = {s = pol.s ++ imp.s ! pol.p ! Ag Sg P2} ;
    UttImpPl  pol imp = {s = pol.s ++ imp.s ! pol.p ! Ag Pl P2} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! AgPol} ;

    UttIP ip = {s = ip.s ! NPCase Nom} ;
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! NPCase Nom} ;
    UttVP vp = {s = infVP (NPCase Nom) Pos (agrP3 Sg) vp InfDa} ;
    UttAdv adv = adv ;
    UttCN np = {s = np.s ! NCase Sg Nom} ;
    UttAP np = {s = np.s ! P.False ! NCase Sg Nom} ;
    UttCard n = {s = n.s ! Sg ! Nom} ;

    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s2} ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! NPCase Nom} ;

}
