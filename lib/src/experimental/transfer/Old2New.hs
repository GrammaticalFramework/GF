module Old2New where

import Both


onUtt :: Tree a -> Tree a ----GUtt_ -> Tree GUtt_
onUtt t = case t of
  GUttS s -> GUttPrS (onS s)
  GUttQS qs -> GUttPrS (GUseQCl_none (onQS2QCl qs))
  GUttImpPl pol (GImpVP vp) -> GPrImpPl (onVP GTPres GASimul pol vp)
  GUttImpPol pol (GImpVP vp) -> GPrImpSg (onVP GTPres GASimul pol vp) ----
  GUttImpSg pol (GImpVP vp) -> GPrImpSg (onVP GTPres GASimul pol vp)
  GUttNP np -> GUttNP (onNP np)
  GUttCN cn -> GUttCN (onCN cn)

  _ -> t ---- composOp onUtt t

onS :: Tree GS_ -> Tree GPrS_
onS s = case s of
  GUseCl (GTTAnt t a) p cl -> GUseCl_none (onCl t a p cl) 
  GAdvS adv s -> error "AdvS"
  GExtAdvS adv s -> error "ExtAdvS"
  GRelS s rs -> error "RelS"
  GSSubjS s subj s2 -> error "SSubjS"
  GConjS conj lists -> error "ConjS"
  GPredVPS np vps -> error "PredVPS"

onCl :: GTense -> GAnt -> GPol -> Tree GCl_ -> Tree GPrCl_none_
onCl t a p cl = case cl of
  GPredVP np vp -> let (advs,vp0) = getAdvs vp in appAdvCl advs (GPredVP_none np (onVP t a p vp0)) ---
  ---- ExistNP : NP -> Cl ;
  ---- PredSCVP : SC -> VP -> Cl ;
  ---- PredVPosv : NP -> VP -> Cl ;
  ---- PredVPovs : NP -> VP -> Cl ;

-- adverbs in New are attached to Cl, in Old to VP. New makes no distinction between Adv and AdV
getAdvs :: GVP -> ([GPrAdv_none],GVP)
getAdvs vp = case vp of
  GAdvVP vp1 adv -> let (advs,vp2) = getAdvs vp1 in (advs ++ [GLiftAdv adv],vp2)
  GAdVVP adv vp1 -> let (advs,vp2) = getAdvs vp1 in (advs ++ [GLiftAdV adv],vp2)

appAdvCl :: [GPrAdv_none] -> GPrCl_none -> GPrCl_none
appAdvCl advs cl = foldr GAdvCl_none cl advs

onQCl :: GTense -> GAnt -> GPol -> Tree GQCl_ -> Tree GPrQCl_none_
onQCl t a p qcl = case qcl of
  GQuestVP ip vp -> GQuestVP_none ip (onVP t a p vp)
  GQuestSlash ip cls -> GQuestSlash_none ip (GQuestCl_np (onClSlash t a p cls))
  GQuestCl cl -> GQuestCl_none (onCl t a p cl)
  GQuestIAdv iadv cl -> GQuestIAdv_none iadv (onCl t a p cl)
  GQuestIComp icomp np -> GQuestIComp_none a t p icomp np
  GQuestQVP ip qvp -> error "QuestQVP"

onVP :: GTense -> GAnt -> GPol -> Tree GVP_ -> Tree GPrVP_none_
onVP t a p vp = case vp of
  GUseV v -> GUseV_none a t p (GLiftV v)
  GComplVS vs s -> GComplVS_none (GUseV_s a t p (GLiftVS vs)) (onS2Cl s)
  GComplVQ vq q -> GComplVQ_none (GUseV_q a t p (GLiftVQ vq)) (onQS2QCl q)
  GComplVA va ap -> GComplVA_none (GUseV_a a t p (GLiftVA va)) (GLiftAP ap)
  GComplVV vv ant pol vp -> GComplVV_none (GUseV_v a t p (GLiftVV vv)) (GInfVP_none (onVP GTPres ant pol vp)) -- !!
  GComplSlash vps np -> GComplV2_none (onVPSlash t a p vps) np
  GUseComp comp -> case comp of
    GCompAP  ap  -> GUseAP_none a t p (GLiftAP ap)
    GCompAdv adv -> GUseAdv_none a t p (GLiftAdv adv)
    GCompCN  cn  -> GUseCN_none a t p (GLiftCN cn)
    GCompNP  np  -> GUseNP_none a t p np
    GCompS   s   -> GUseS_none a t p (onS2Cl s)
    GCompQS  qs  -> GUseQ_none a t p (onQS2QCl qs)
    GCompVP  ant pol vp  -> GUseVP_none a t p (GInfVP_none (onVP GTPres ant pol vp)) -- !!
---- ComplSlashPartLast : VPSlash -> NP -> VP ;
---- ComplVPIVV : VV -> VPI -> VP ;
---- ExtAdvVP : VP -> Adv -> VP ;
---- PassAgentVPSlash : VPSlash -> NP -> VP ;
---- PassVPSlash : VPSlash -> VP ;
---- ProgrVP : VP -> VP ;
---- ReflVP : VPSlash -> VP ;
---- SelfAdVVP : VP -> VP ;
---- SelfAdvVP : VP -> VP ;

onVPSlash :: GTense -> GAnt -> GPol -> Tree GVPSlash_ -> Tree GPrVP_np_
onVPSlash t a p vps = case vps of
  GSlashV2a v2 -> GUseV_np a t p (GLiftV2 v2)
  GSlashV2S v2s s -> GSlashV2S_none (GUseV_np_s a t p (GLiftV2S v2s)) (onS2Cl s)
  GSlashV2Q v2q q -> GSlashV2Q_none (GUseV_np_q a t p (GLiftV2Q v2q)) (onQS2QCl q)
  GSlashV2A v2a ap -> GSlashV2A_none (GUseV_np_a a t p (GLiftV2A v2a)) (GLiftAP ap)
  GSlashV2V v2v ant pol vp -> GSlashV2V_none (GUseV_np_v a t p (GLiftV2V v2v)) (GInfVP_none (onVP GTPres ant pol vp)) -- !!

  GSlashVV vv vps -> GComplVV_np (GUseV_v a t p (GLiftVV vv)) (GInfVP_np (onVPSlash GTPres GASimul GPPos vps)) -- !!

onClSlash :: GTense -> GAnt -> GPol -> Tree GClSlash_ -> Tree GPrCl_np_
onClSlash t a p cls = case cls of
  GSlashVP np vps -> GPredVP_np np (onVPSlash t a p vps)


onS2Cl :: Tree GS_ -> Tree GPrCl_none_
onS2Cl s = case s of
  GUseCl (GTTAnt t a) p cl -> onCl t a p cl 

onQS2QCl :: Tree GQS_ -> Tree GPrQCl_none_
onQS2QCl s = case s of
  GUseQCl (GTTAnt t a) p qcl -> onQCl t a p qcl 

onRS :: Tree GRS_ -> Tree GRS_
onRS rs = case rs of
  GUseRCl (GTTAnt t a) p (GRelVP rp vp) -> GRelVP_none rp (onVP t a p vp)
  GUseRCl (GTTAnt t a) p (GRelSlash rp cls) -> GRelSlash_none rp (onClSlash t a p cls)




onNP :: Tree GNP_ -> Tree GNP_
onNP np = case np of
  GRelNP np rs -> GRelNP (onNP np) (onRS rs)
  _ -> np ----composOp onNP np

onCN :: Tree GCN_ -> Tree GCN_
onCN cn = case cn of
  GRelCN cn rs -> GRelCN (onCN cn) (onRS rs)
  _ -> cn ----composOp onCN cn


old2new :: Tree a -> Tree a
old2new t = case t of
  GAdVVP gAdV gVP -> t
  GAdVVPSlash gAdV gVPSlash -> t
  GAdvS gAdv gS -> t
  GAdvSlash gClSlash gAdv -> t
  GAdvVP gVP gAdv -> t
  GAdvVPSlash gVPSlash gAdv -> t
--  GBaseVPI gVPI gVPI_ -> t
--  GBaseVPS gVPS gVPS_ -> t
  GCompAP gAP -> t
  GCompAdv gAdv -> t
  GCompCN gCN -> t
  GCompNP gNP -> t
  GCompQS gQS -> t
  GCompS gS -> t
  GCompVP gAnt gPol gVP -> t
  GComplBareVS gVS gS -> t
  GComplSlash gVPSlash gNP -> t
  GComplSlashPartLast gVPSlash gNP -> t
  GComplVA gVA gAP -> t
  GComplVPIVV gVV gVPI -> t
  GComplVQ gVQ gQS -> t
  GComplVS gVS gS -> t
  GComplVV gVV gAnt gPol gVP -> t
  GCompoundCN gNum gN gCN -> t
  GConjVPI gConj gListVPI -> t
  GConjVPS gConj gListVPS -> t
--  GConsVPI gVPI gListVPI -> t
--  GConsVPS gVPS gListVPS -> t
  GDashCN gN gN_ -> t
  GEmbedQS gQS -> t
  GEmbedS gS -> t
  GEmbedVP gVP -> t
  GEmptyRelSlash gClSlash -> t
  GExtAdvS gAdv gS -> t
  GExtAdvVP gVP gAdv -> t
  GGenNP gNP -> t
  GGenRP gNum gCN -> t
  GGerundAP gV -> t
  GGerundN gV -> t
  GImpVP gVP -> t
  GMkVPI gVP -> t
  GMkVPS gTemp gPol gVP -> t
  GOrdCompar gA -> t
  GPassAgentVPSlash gVPSlash gNP -> t
  GPassVPSlash gVPSlash -> t
  GPastPartAP gV2 -> t
  GPastPartRS gAnt gPol gVPSlash -> t
  GPositAdVAdj gA -> t
  GPredSCVP gSC gVP -> t
  GPredVP gNP gVP -> t
  GPredVPS gNP gVPS -> t
  GPredVPosv gNP gVP -> t
  GPredVPovs gNP gVP -> t
  GPresPartRS gAnt gPol gVP -> t
  GQuestCl gCl -> t
  GQuestIAdv gIAdv gCl -> t
  GQuestIComp gIComp gNP -> t
  GQuestSlash gIP gClSlash -> t
  GQuestVP gIP gVP -> t
  GReflVP gVPSlash -> t
  GRelCl gCl -> t
  GRelS gS gRS -> t
  GRelSlash gRP gClSlash -> t
  GRelVP gRP gVP -> t
  GSSubjS gS gSubj gS_ -> t
  GSlash2V3 gV3 gNP -> t
  GSlash3V3 gV3 gNP -> t
  GSlashBareV2S gV2S gS -> t
  GSlashPrep gCl gPrep -> t
  GSlashSlashV2V gV2V gAnt gPol gVPSlash -> t
  GSlashV2A gV2A gAP -> t
  GSlashV2Q gV2Q gQS -> t
  GSlashV2S gV2S gS -> t
  GSlashV2V gV2V gAnt gPol gVP -> t
  GSlashV2VNP gV2V gNP gVPSlash -> t
  GSlashV2a gV2 -> t
  GSlashVP gNP gVPSlash -> t
  GSlashVPIV2V gV2V gPol gVPI -> t
  GSlashVS gNP gVS gSSlash -> t
  GSlashVV gVV gVPSlash -> t
  GTTAnt gTense gAnt -> t
  GUseCl gTemp gPol gCl -> t
  GUseComp gComp -> t
  GUseQCl gTemp gPol gQCl -> t
  GUseQuantPN gQuant gPN -> t
  GUseRCl gTemp gPol gRCl -> t
  GUseSlash gTemp gPol gClSlash -> t
  GUseV gV -> t
  GVPSlashPrep gVP gPrep -> t
  GVPSlashVS gVS gVP -> t
  Gherself_NP -> t
  Ghimself_NP -> t
  Gitself_NP -> t
  Gmyself_NP -> t
  Gourselves_NP -> t
  Gthat_RP -> t
  Gthemselves_NP -> t
  Gwho_RP -> t
  GyourselfPl_NP -> t
  GyourselfSg_NP -> t
