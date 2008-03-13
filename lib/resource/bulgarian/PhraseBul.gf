concrete PhraseBul of Phrase = CatBul ** open Prelude, ResBul in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg  pol imp = {s = pol.s ++ imp.s ! pol.p ! GSg Masc} ;
    UttImpPl  pol imp = {s = pol.s ++ imp.s ! pol.p ! GPl} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! GPl} ;

    UttIP ip = {s = ip.s ! RSubj} ;
    UttIAdv iadv = {s = iadv.s1} ;
    UttNP np = {s = np.s ! RSubj} ;
    UttVP vp = {s = vp.ad ! False ++
                    "да" ++ 
                    vp.s ! Pres ! Simul ! Pos ! {gn=GSg Masc; p=P1} ! False ++ 
                    vp.s2 ! {gn=GSg Masc; p=P1}} ;
    UttAdv adv = adv ;

    NoPConj = {s = []} ;
    PConjConj conj = conj ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! RVoc} ;
}
