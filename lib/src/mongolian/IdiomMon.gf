--# -path=.:../abstract:../common:../prelude

concrete IdiomMon of Idiom = CatMon ** open Prelude, ResMon, ParadigmsMon in {

 flags optimize=all_subs ;  coding=utf8 ;

lin
 ImpersCl vp = mkClause (\\_ => []) Sg vp.vt Nom vp ;
 GenericCl vp = mkClause (\\_ => []) Sg vp.vt Nom vp ; 
 
 CleftNP np rs = mkClause (\\_ => []) Sg (predV (auxToVerb auxBe)).vt Nom (insertEmbedCompl (rs.s ! ComplSubj) (insertObj (\\_ => np.s ! Nom) (predV (auxToVerb auxBe)))) ;
 
 CleftAdv adv s = mkClause (\\_ => []) Sg (predV (auxToVerb auxBe)).vt Nom (insertObj (\\_ => s.s ! (Part Subject)) (insertObj (\\_ => adv.s) (predV (auxToVerb auxBe)))) ; 

 ExistNP np = mkClause (\\_ => []) np.n (predV (auxToVerb auxBe)).vt Nom (insertObj (\\_ => np.s ! Nom) (predV (auxToVerb auxBe))) ;
 
 ExistIP ip = {
    s = \\t,ant,pol,_ => ip.s ! Nom ++ (mkClause (\\_ => []) Sg (predV (auxToVerb auxBe)).vt Nom (predV (auxToVerb auxBe))).s ! t ! ant ! pol ! Main
    } ;
 ExistNPAdv np adv = mkClause (\\_ => []) np.n (predV (auxToVerb auxBe)).vt Nom (insertObj (\\_ => np.s ! Nom ++ adv.s) (predV (auxToVerb auxBe))) ;

 ExistIPAdv ip adv = {
    s = \\t,ant,pol,_ => (mkClause (\\_ =>  ip.s ! Nom) Sg (predV (auxToVerb auxBe)).vt Nom (insertObj (\\_ => adv.s)(predV (auxToVerb auxBe)))).s ! t ! ant ! pol ! Main
    } ;
   
 ProgrVP vp = 
   let 
    progr = (vp.s ! VPCoord Simul).fin ;
    verb = predV (auxToVerb auxBe)
   in 
   insertObj (\\rc => vp.embedCompl ! rc ++ vp.adv ++ vp.compl ! rc ++ progr) (predV (auxToVerb auxBe)) ;

 ImpPl1 vp = 
   let 
    vps = vp.s ! VPImper Pos False
   in {
    s = vps.fin ;
    compl = vp.compl ;
    adv = vp.adv ;
    ext = vp.ext
    } ;
     
 ImpP3 np vp = 
   let 
    vps = vp.s ! VPPass Causative ClPres 
   in {
    s = np.s ! Acc ++ vps.fin
    } ;
   
}

