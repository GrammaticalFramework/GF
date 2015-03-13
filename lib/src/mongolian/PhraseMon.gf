--# -path=.:../abstract:../common:../prelude

concrete PhraseMon of Phrase = CatMon ** open Prelude, ResMon in {

 flags coding=utf8 ;

lin
 PhrUtt pconj utt voc = {
    s = pconj.s ++ utt.s ++ voc.s
    } ;

 UttS s = {s = s.s ! Main} ;
 
 UttQS qs = {
    s = qs.s ! QDir
    } ;
    
 UttImpSg pol imp = {
    s = pol.s ++ imp.s ! pol.p ! ImpF Sg False
    } ;
    
 UttImpPl pol imp = {
    s = pol.s ++ imp.s ! pol.p ! ImpF Pl False
    } ;
    
 UttImpPol pol imp = {
    s = pol.s ++ imp.s ! pol.p ! ImpF Sg True
    } ;

 UttIP ip = {
    s = ip.s ! Nom
    } ; 
    
 UttIAdv iadv = iadv ;
 
 UttNP np = {
    s = np.s ! Nom
    } ;
    
 UttVP vp = {
    s = infVP vp Nom
    } ;
    
 UttAdv adv = adv ;
 UttCN cn = {
    s = cn.s ! Sg ! NNom
    } ;
    
 UttCard card = card ;
 
 UttAP ap = ap ;
 
 UttInterj i = i ;
 
 NoPConj = {s = []} ;
 
 PConjConj conj = ss conj.s2 ;
 
 NoVoc = {s = []} ;
 
 VocNP np = {
    s = "," ++ np.s ! Nom
    } ;

}
