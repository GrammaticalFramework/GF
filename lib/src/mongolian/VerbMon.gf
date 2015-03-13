--# -path=.:../abstract:../common:../prelude

concrete VerbMon of Verb = CatMon ** open ResMon, ParadigmsMon, Prelude in {

 flags optimize=all_subs ;  coding=utf8 ;

lin
 UseV = predV ;

 ComplVV v vp = insertObj (\\_ => infVP vp Nom) (predV (auxToVerb v)) ;

 ComplVS v s = insertEmbedCompl (s.s ! Main ++ "гэж") (predV v) ;
 
 ComplVQ v qs = insertEmbedCompl (qs.s ! QIndir) (predV v) ;

 ComplVA v ap = insertObj (\\_ => ap.s) (predV v) ;

 SlashV2a v = predV v ** {c2 = v.c2} ;
  
 Slash2V3 v np = insertObj (\\_ => appCompl v.c2 np.s) (predV v) ** {c2 = v.c3} ;
 
 Slash3V3 v np = insertObj (\\_ => appCompl v.c3 np.s) (predV v) ** {c2 = v.c2} ;
 
 SlashV2V v vp = insertObj (\\_ => infVP vp Gen) (predV v) ** {c2 = v.c2} ;
  
 SlashV2S v s = insertEmbedCompl (s.s ! Main ++ "гэж") (predV v) ** {c2 = v.c2} ;

 SlashV2Q v qs = insertEmbedCompl (qs.s ! QIndir) (predV v) ** {c2 = v.c2} ;
  
 SlashV2A v ap = insertObj (\\_ => ap.s) (predV v) ** {c2 = v.c2} ;

 ComplSlash v np = insertObj (\\_ => appCompl v.c2 np.s) v ; 
 
 SlashVV v vp = insertObj (\\_ => infVP vp Acc) (predV (auxToVerb v)) ** {c2 = vp.c2} ;

 SlashV2VNP v np vp = insertObj (\\_ => appCompl v.c2 np.s) (
                        insertObjPost (\\_ => (infVP vp Acc)) (predV v)) ** {c2 = vp.c2} ;

 VPSlashPrep vp prep = vp ** {c2 = prep} ;
 
 ReflVP vp = insertObj (\\_ => appCompl vp.c2 (reflPron ! Sg)) vp ; 
  
 UseComp comp = insertObj (\\_ => comp.s ! Nom) (predV (auxToVerb auxBe)) ;

 PassV2 v = 
   let 
    vp = predV v
    in {
    s = \\_ => vp.s ! VPPass Passive ClPres ;
    compl = \\_ => [] ;
    adv = [] ;
    embedCompl = \\_ => [] ;
	vt = v.vt
    } ;
    
 AdvVP vp adv = insertAdv adv.s vp ;
 AdVVP adv vp = insertAdv adv.s vp ;
 AdvVPSlash vp adv = insertAdv adv.s vp ** {c2 = vp.c2} ;
 AdVVPSlash adv vp = insertAdv adv.s vp ** {c2 = vp.c2} ;
   
-- Complements of copula

 CompAP ap = {s = \\_ => ap.s} ;
 CompNP np = {s = \\_ => np.s ! Nom} ;
 CompAdv adv = {s = \\_ => adv.s} ;
 CompCN cn = {s = \\_ => cn.s ! Sg ! (toNCase Nom Definite)} ;
 UseCopula = predV (auxToVerb auxBe) ;
 
}

