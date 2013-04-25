concrete PhraseGre of Phrase = CatGre ** open Prelude, CommonGre, ResGre,ParadigmsGre in {


flags coding=utf8 ;

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = {s = s.s ! Ind} ;
    UttQS qs = {s = qs.s ! QDir} ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! Sg ! Perf} ;  -----Imperf in Extra
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p !  Pl !Perf} ; ----- Imperf in Extra
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! Pl ! Perf} ;

    UttIP ip = {s = ip.s ! Masc !  Nom} ; 
    UttIAdv iadv = iadv ;
    UttNP np = {s = (np.s ! Nom).comp } ;  
----    UttNP np = {s = ((np.s ! Nom).comp | [] ) } ;  -- AR removed empty string variant                                          
    UttVP vp = {s = (predVP [] (Ag Masc Sg P3) vp).s ! Main !  TPres ! Simul ! Pos !Con} ;
    UttAdv adv = adv ;
    UttCN n = {s = n.s ! Sg ! Nom} ;

    UttCard n = {s = n.s ! Neut ! Nom } ;
    UttInterj i = i ;
    UttAP ap = {s = ap.s ! Posit ! Masc ! Sg ! Nom } ;


    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s2} ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ (np.s ! Vocative).comp } ;

}

