concrete PhraseNep of Phrase = CatNep ** open Prelude, ResNep in {
  
  flags coding = utf8 ;

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;
    
    -- be a man -> (मन्छे हउ)
    -- issue in mkPhr-Imp-Phr
    --          mkPhr-PConj-Utt-Voc-Phr
    -- Need to diff between singularImpForm-ImpForm
    --                      pluralImpForm-ImpForm and above cases
    UttImpSg pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Sg False ++ "hof"} ;
    
    UttImpPl pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Pl False ++ "hW"} ;
    
    UttImpPol pol imp = {s = pol.s ++ imp.s ! contrNeg True pol.p ! ImpF Sg True ++ "hof"} ;

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
