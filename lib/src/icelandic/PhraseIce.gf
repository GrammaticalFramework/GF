concrete PhraseIce of Phrase = CatIce ** open Prelude, ResIce in {
	lin
		PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

		UttS s = {s = s.s} ;

		UttImpSg pol imp = {s = imp.s ! pol.p ! Sg} ;

		UttImpPl pol imp = {s = imp.s ! pol.p ! Pl} ;

		UttImpPol pol imp = {s = imp.s ! pol.p ! Sg} ;

    		UttIP ip = {s = ip.s ! Masc ! Nom} ;

		UttQS qs = {s = qs.s ! QDir} ;

		UttIAdv adv = adv ;

		UttNP np = {s = np.s ! NCase Nom} ;

		UttAdv adv = adv ;

		UttVP vp = let verb = vp.s ! VPInf ! Pos ! {g = Masc ; n = Sg ; p = P3} 
			in {s = verb.fin ++ verb.a1.p1 ++ verb.inf ++ verb.a1.p2} ;

		UttCN cn = {s = cn.s ! Sg ! Free ! Strong ! Nom ++ cn.comp ! Sg ! Nom} ;

		UttCard card = {s = card.s ! Masc ! Nom };

		UttAP ap = {s = ap.s ! Sg ! Neutr ! Strong ! Nom} ;

		UttInterj i = i ;

		NoPConj = {s = []} ;

		PConjConj conj = {s = conj.s2} ;

		NoVoc = {s = []} ;

		VocNP np = {s = "," ++ np.s ! NCase Nom} ;
}
