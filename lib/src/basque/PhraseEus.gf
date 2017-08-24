concrete PhraseEus of Phrase = CatEus ** open Prelude, ResEus in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = { s = s.s.beforeAux ++ s.s.aux.indep ++ s.s.afterAux } ;
    UttQS qs = { s = let s = qs.s ! Qst 
                     in s.beforeAux ++ s.aux.indep ++ s.afterAux } ;

    UttImpSg pol imp = 
      let ez = case pol.p of { Pos => [] ; Neg => "ez" }
      in { s = ez ++ imp.s } ;
    UttImpPl = UttImpSg ;
    UttImpPol = UttImpSg ;

    UttIP ip = { s = ip.s ! Abs} ;
    UttIAdv iadv = iadv ;
    UttNP np = { s = np.s ! Abs} ;
    UttVP vp = { s = linVP vp } ;
    UttAdv adv = adv ;
    UttCN n = {s = n.s ! Hau ++ artDef ! Sg ! Abs ! n.ph } ;
    UttCard n = n ;
    UttAP ap = ap ;
    UttInterj i = i ;

    NoPConj = {s = []} ;
    PConjConj conj = { s = conj.s1 ++ conj.s2 } ;

    NoVoc = {s = []} ;
    VocNP np = { s = "," ++ np.s ! Abs } ;

}