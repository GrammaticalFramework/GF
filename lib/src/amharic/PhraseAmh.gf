concrete PhraseAmh of Phrase = CatAmh ** open 
  ParamX, 
  Prelude, 
  CommonX,
  ResAmh in {
    	 
	 
 	flags optimize=all_subs ;
 	coding = utf8;
	lin
	PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;    	
	NoPConj = {s = []} ;
	NoVoc = {s = []} ;
	UttS s = s;
	UttAdv adv = adv ;
        UttNP np = {s = np.s ! Nom } ;
	UttAP ap = {s = ap.s ! Masc!Sg!Indef!Nom } ;
	UttCN n = {s = n.s ! Sg ! Indef! Nom} ;
	UttCard n = {s = n.s ! Masc!Sg!Indef!Nom } ;
	VocNP np = {s = "፤" ++ np.s ! Nom} ;
	UttQS qs = {s = qs.s } ;
	UttIP ip = ip ; --- Acc also
	UttVP vp = {s = vp.obj.s ++ vp.inf} ;
	UttIAdv iadv = iadv ;
	UttCN n = {s = n.s ! Sg ! Indef!Nom} ;
    	UttCard n = {s = n.s ! Masc!Sg!Indef!Nom} ;
	UttImpSg pol imp = {s = pol.s ++ imp.s!pol.p!Masc!Sg};
	UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p! Masc! Pl} ; --- TO DO 
	UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! Masc!Pl} ; -- TO DO --- 
	UttQS qs = {s = qs.s } ; -- TO DO 
    {-  
    
    PConjConj conj = {s = conj.s2} ; ---

    -}

}
