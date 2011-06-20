concrete PhraseNep of Phrase = CatNep ** open Prelude, ResNep in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;
    
    -- be a man -> (मन्छे हउ)
    UttImpSg pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Sg False ++ "hf"} ;
    
    UttImpPl pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Pl False ++ "hA"} ;
    
    UttImpPol pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Sg True ++ "hf"} ;

    UttIP ip = {s = ip.s ! Nom} ; --- Acc also
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! NPC Nom} ;
        
    UttVP vp = {s = vp.ad ++ vp.obj.s  ++ vp.comp ! (agrP3 Masc Sg) ++ (vp.s ! Inf).inf ++ vp. embComp} ;
    
    UttAdv adv = {s = adv.s } ;
	UttCN cn = {s = cn.s ! Sg ! Nom};
    UttCard n = n ;
    UttAP ap = {s = ap.s ! Sg ! Masc } ;

    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s2} ; 

    NoVoc = {s = []} ;
    VocNP np = {s = np.s ! NPC Nom} ;

}
