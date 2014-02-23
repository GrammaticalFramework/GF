module Old2New where

import Both

onUtt :: Tree GUtt_ -> Tree GUtt_
onUtt t = case t of
  GUttS s -> GUttPrS (onS s)

onS s = case s of
  GUseCl (GTTAnt t a) p cl -> GUseCl_none (onCl t a p cl) 

onCl t a p cl = case cl of
  GPredVP np vp -> GPredVP_none np (onVP t a p vp)

onVP :: GTense -> GAnt -> GPol -> Tree GVP_ -> Tree GPrVP_none_
onVP t a p vp = case vp of
  GUseV v -> GUseV_none a t p (GLiftV v)
  GComplVS vs s -> GComplVS_none (GUseV_s a t p (GLiftVS vs)) (onS2Cl s)
  GComplSlash vps np -> GComplV2_none (onVPS t a p vps) np

onVPS :: GTense -> GAnt -> GPol -> Tree GVPSlash_ -> Tree GPrVP_np_
onVPS t a p vps = case vps of
  GSlashV2a v2 -> GUseV_np a t p (GLiftV2 v2)


onS2Cl :: Tree GS_ -> Tree GPrCl_none_
onS2Cl s = case s of
  GUseCl (GTTAnt t a) p cl -> onCl t a p cl 


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
