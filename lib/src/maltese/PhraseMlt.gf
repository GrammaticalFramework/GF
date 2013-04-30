-- PhraseMlt.gf: suprasentential phrases
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Licensed under LGPL

concrete PhraseMlt of Phrase = CatMlt ** open ParamX, Prelude, ResMlt in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;
 
    UttS s = s ;
    UttQS qs = {s = qs.s ! QDir} ;

    -- Pol -> Imp -> Utt
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! Sg} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! Pl} ;
    UttImpPol = UttImpSg ; -- no polite form

    UttIP ip = {s = ip.s} ;
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! npNom} ;
    UttVP vp = {s = infVP vp Simul Pos (agrP3 Sg Masc)} ;
    UttAdv adv = adv ;
    UttCN n = {s = n.s ! (num2nounnum Sg)} ;
    UttCard n = {s = n.s ! NumNom} ;
    UttAP ap = {s = ap.s ! mkGenNum Sg Masc} ;
    UttInterj i = i ;

    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s2} ;

    NoVoc = {s = []} ;
    VocNP np = {s = "," ++ np.s ! npNom} ;

}
