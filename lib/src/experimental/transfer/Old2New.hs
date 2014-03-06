{-# OPTIONS_GHC -fglasgow-exts #-}

module Old2New (transfer) where
import PGF hiding (Tree)
import qualified PGF
import PGF.Data

import Both


transfer :: PGF.Tree -> PGF.Tree
transfer = gf . onPhr . fg

{-
transfer t = case unAppForm t of
  (EMeta m, es) -> foldl EApp (EMeta m) (map transfer es)
  _ -> gf $ on $ fg t
-}

onPhr :: Tree GPhr_ -> Tree GPhr_
onPhr = on

on :: forall a . Tree a -> Tree a
on t = case t of

----  GEMeta m ts -> GEMeta m (map on ts)

 
-- Utt
  GUttImpPl pol (GImpVP vp) -> GPrImpPl (onVP GTPres GASimul pol vp)
  GUttImpPol pol (GImpVP vp) -> GPrImpSg (onVP GTPres GASimul pol vp) ----
  GUttImpSg pol (GImpVP vp) -> GPrImpSg (onVP GTPres GASimul pol vp)
  GUttQS qs -> GUttPrS (GUseQCl_none (onQS2QCl qs))
  GUttS s -> GUttPrS (onS s)
  GUttVP s -> error "GUttPrVPI (GInfVP_none (onVP GTPres ant pol vp))"

-- RS
  GUseRCl (GTTAnt t a) p (GRelVP rp vp) -> GRelVP_none rp (onVP t a p vp)
  GUseRCl (GTTAnt t a) p (GRelSlash rp cls) -> GRelSlash_none rp (onClSlash t a p cls)
  GUseRCl (GTTAnt t a) p (GRelCl cl) -> GRelCl_none (onCl t a p cl)
  GPastPartRS _ _ _ -> error "PastPartRS : Ant -> Pol -> VPSlash -> RS"
  GPresPartRS _ _ _ -> error "PresPartRS : Ant -> Pol -> VPSlash -> RS"

-- NP

-- Adv
  GComparAdvAdjS cadv a s -> error "GComparAdvAdjS cadv a (onS s)"
  GSubjS subj s -> error "AdvSubjS subj s"

-- AP
---- SentAP : AP -> SC -> AP

  _ -> composOp on t


onS :: Tree GS_ -> Tree GPrS_
onS s = case s of
  GUseCl (GTTAnt t a) p cl -> GUseCl_none (onCl t a p cl) 
  GAdvS adv s -> error "AdvS"
  GExtAdvS adv s -> error "ExtAdvS"
  GRelS s rs -> error "RelS"
  GSSubjS s subj s2 -> error "SSubjS"
  GConjS conj (GListS lists) -> GUseCl_none (GUseClC_none (mkClC conj [onS2Cl s | s <- lists]))
  GPredVPS np vps -> GUseCl_none (GPredVP_none (on np) (onVPS2VP vps))

mkClC conj cls = foldr GContClC_none (GStartClC_none conj cl1 cl2) cls2
  where 
    (cls2,[cl1,cl2]) = splitAt (length cls - 2) cls

onVPS2VP :: Tree GVPS_ -> Tree GPrVP_none_
onVPS2VP vps = case vps of
  GMkVPS (GTTAnt t a) p vp -> onVP t a p vp
  GConjVPS conj (GListVPS vs) -> GUseVPC_none (mkVPC conj [onVPS2VP v | v <- vs])

mkVPC conj cls = foldr GContVPC_none (GStartVPC_none conj cl1 cl2) cls2
  where 
    (cls2,[cl1,cl2]) = splitAt (length cls - 2) cls


onCl :: GTense -> GAnt -> GPol -> Tree GCl_ -> Tree GPrCl_none_
onCl t a p cl = case cl of
  GPredVP np vp -> let (advs,vp0) = getAdvs vp in appAdvCl advs (GPredVP_none (on np) (onVP t a p vp0)) ---
  ---- ExistNP : NP -> Cl ;
  ---- PredSCVP : SC -> VP -> Cl ;
  ---- PredVPosv : NP -> VP -> Cl ;
  ---- PredVPovs : NP -> VP -> Cl ;

-- adverbs in New are attached to Cl, in Old to VP. New makes no distinction between Adv and AdV
getAdvs :: GVP -> ([GPrAdv_none],GVP)
getAdvs vp = case vp of
  GAdvVP vp1 adv -> let (advs,vp2) = getAdvs vp1 in (advs ++ [GLiftAdv adv],vp2)
  GAdVVP adv vp1 -> let (advs,vp2) = getAdvs vp1 in (advs ++ [GLiftAdV adv],vp2)
  GExtAdvVP vp1 adv -> let (advs,vp2) = getAdvs vp1 in (advs ++ [GLiftAdv adv],vp2) ---- as a variant

  _ -> ([],vp)

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
    GCompAP  ap  -> GUseAP_none a t p (GLiftAP (on ap))
    GCompAdv adv -> GUseAdv_none a t p (GLiftAdv (on adv))
    GCompCN  cn  -> GUseCN_none a t p (GLiftCN (on cn))
    GCompNP  np  -> GUseNP_none a t p (on np)
    GCompS   s   -> GUseS_none a t p (onS2Cl s)
    GCompQS  qs  -> GUseQ_none a t p (onQS2QCl qs)
    GCompVP  ant pol vp  -> GUseVP_none a t p (GInfVP_none (onVP GTPres ant pol vp)) -- !!
  GComplSlashPartLast vps np -> GComplV2_none (onVPSlash t a p vps) np ---- as a variant
  GComplVPIVV vv vpi -> GComplVV_none (GUseV_v a t p (GLiftVV vv)) (GInfVP_none (onVPI2VP vpi))
  GPassVPSlash vps -> onVPSlashPass t a p vps
  GPassAgentVPSlash vps np -> onVPSlashPassAgent t a p vps np
---- ProgrVP : VP -> VP ;
---- ReflVP : VPSlash -> VP ;
---- SelfAdVVP : VP -> VP ;
---- SelfAdvVP : VP -> VP ;

onVPI2VP :: Tree GVPI_ -> Tree GPrVP_none_
onVPI2VP vpi = case vpi of
  GMkVPI vp -> onVP GTPres GASimul GPPos vp
  GConjVPI conj (GListVPI vs) -> GUseVPC_none (mkVPC conj [onVPI2VP v | v <- vs])

onVPSlash :: GTense -> GAnt -> GPol -> Tree GVPSlash_ -> Tree GPrVP_np_
onVPSlash t a p vps = case vps of
  GSlashV2a v2 -> GUseV_np a t p (GLiftV2 v2)
  GSlashV2S v2s s -> GSlashV2S_none (GUseV_np_s a t p (GLiftV2S v2s)) (onS2Cl s)
  GSlashV2Q v2q q -> GSlashV2Q_none (GUseV_np_q a t p (GLiftV2Q v2q)) (onQS2QCl q)
  GSlashV2A v2a ap -> GSlashV2A_none (GUseV_np_a a t p (GLiftV2A v2a)) (GLiftAP ap)
  GSlashV2V v2v ant pol vp -> GSlashV2V_none (GUseV_np_v a t p (GLiftV2V v2v)) (GInfVP_none (onVP GTPres ant pol vp)) -- !!

  GSlashVV vv vps -> GComplVV_np (GUseV_v a t p (GLiftVV vv)) (GInfVP_np (onVPSlash GTPres GASimul GPPos vps)) -- !!
---  GSlashSlashV2V vv ant pol vps -> GComplVV_np (GUseV_np_v a t p (GLiftV2V vv)) (GInfVP_np (onVPSlash GTPres ant pol vps))
  GSlashVPIV2V v2v pol vpi -> GSlashV2V_none (GUseV_np_v a t p (GLiftV2V v2v)) (GInfVP_none (onVPI2VP vpi)) 

onVPSlashPass :: GTense -> GAnt -> GPol -> Tree GVPSlash_ -> Tree GPrVP_none_
onVPSlashPass t a p vps = case vps of
  GSlashV2a v2 -> GPassUseV_none a t p (GLiftV2 v2)
  GSlashV2S v2s s -> GComplVS_none (GPassUseV_s a t p (GLiftV2S v2s)) (onS2Cl s)
  GSlashV2Q v2q q -> GComplVQ_none (GPassUseV_q a t p (GLiftV2Q v2q)) (onQS2QCl q)
----  GSlashV2A v2a ap -> (GPassUseV_np_a a t p (GLiftV2A v2a)) (GLiftAP ap)
----  GSlashV2V v2v ant pol vp -> (GPassUseV_np_v a t p (GLiftV2V v2v)) (GInfVP_none (onVP GTPres ant pol vp)) -- !!

--  GSlashVV vv vps -> GComplVV_np (GUseV_v a t p (GLiftVV vv)) (GInfVP_np (onVPSlash GTPres GASimul GPPos vps)) -- !!

onVPSlashPassAgent :: GTense -> GAnt -> GPol -> Tree GVPSlash_ -> GNP -> Tree GPrVP_none_
onVPSlashPassAgent t a p vps np = case vps of
  GSlashV2a v2 -> GAgentPassUseV_none a t p (GLiftV2 v2) np
  GSlashV2S v2s s -> GComplVS_none (GAgentPassUseV_s a t p (GLiftV2S v2s) np) (onS2Cl s)

onClSlash :: GTense -> GAnt -> GPol -> Tree GClSlash_ -> Tree GPrCl_np_
onClSlash t a p cls = case cls of
  GSlashVP np vps -> GPredVP_np np (onVPSlash t a p vps)
  GSlashPrep cl prep -> GAdvCl_np (GLiftPrep prep) (onCl t a p cl)
---- GSlashVS np vs sslash -> 
---- GAdvSlash cls adv -> GAdvCl_none (GLiftAdv adv) (onClSlash t a p cls)

---- UseSlash : Temp -> Pol -> ClSlash -> SSlash ;

onS2Cl :: Tree GS_ -> Tree GPrCl_none_
onS2Cl s = case s of
  GUseCl (GTTAnt t a) p cl -> onCl t a p cl 

onQS2QCl :: Tree GQS_ -> Tree GPrQCl_none_
onQS2QCl s = case s of
  GUseQCl (GTTAnt t a) p qcl -> onQCl t a p qcl 

