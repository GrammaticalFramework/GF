{-# OPTIONS_GHC -fglasgow-exts #-}
module Both where

import Control.Monad.Identity
import Data.Monoid
import PGF hiding (Tree)
import qualified PGF
----------------------------------------------------
-- automatic translation from GF to Haskell
----------------------------------------------------

class Gf a where
  gf :: a -> PGF.Tree
  fg :: PGF.Tree -> a

instance Gf GString where
  gf (GString x) = mkStr x
  fg t =
    case unStr t of
      Just x  ->  GString x
      Nothing -> error ("no GString " ++ show t)

instance Gf GInt where
  gf (GInt x) = mkInt x
  fg t =
    case unInt t of
      Just x  ->  GInt x
      Nothing -> error ("no GInt " ++ show t)

instance Gf GFloat where
  gf (GFloat x) = mkDouble x
  fg t =
    case unDouble t of
      Just x  ->  GFloat x
      Nothing -> error ("no GFloat " ++ show t)

----------------------------------------------------
-- below this line machine-generated
----------------------------------------------------

type GAP = Tree GAP_
data GAP_
type GAdA = Tree GAdA_
data GAdA_
type GAdN = Tree GAdN_
data GAdN_
type GAdV = Tree GAdV_
data GAdV_
type GAdv = Tree GAdv_
data GAdv_
type GAnt = Tree GAnt_
data GAnt_
type GCN = Tree GCN_
data GCN_
type GCard = Tree GCard_
data GCard_
type GCl = Tree GCl_
data GCl_
type GClC_none = Tree GClC_none_
data GClC_none_
type GClC_np = Tree GClC_np_
data GClC_np_
type GClSlash = Tree GClSlash_
data GClSlash_
type GComp = Tree GComp_
data GComp_
type GDet = Tree GDet_
data GDet_
type GIAdv = Tree GIAdv_
data GIAdv_
type GIComp = Tree GIComp_
data GIComp_
type GIDet = Tree GIDet_
data GIDet_
type GIP = Tree GIP_
data GIP_
type GImp = Tree GImp_
data GImp_
type GListAP = Tree GListAP_
data GListAP_
type GListAdV = Tree GListAdV_
data GListAdV_
type GListAdv = Tree GListAdv_
data GListAdv_
type GListCN = Tree GListCN_
data GListCN_
type GListIAdv = Tree GListIAdv_
data GListIAdv_
type GListNP = Tree GListNP_
data GListNP_
type GListRS = Tree GListRS_
data GListRS_
type GListS = Tree GListS_
data GListS_
type GListVPI = Tree GListVPI_
data GListVPI_
type GListVPS = Tree GListVPS_
data GListVPS_
type GN = Tree GN_
data GN_
type GN2 = Tree GN2_
data GN2_
type GNP = Tree GNP_
data GNP_
type GNum = Tree GNum_
data GNum_
type GOrd = Tree GOrd_
data GOrd_
type GPConj = Tree GPConj_
data GPConj_
type GPN = Tree GPN_
data GPN_
type GPhr = Tree GPhr_
data GPhr_
type GPol = Tree GPol_
data GPol_
type GPrAP_none = Tree GPrAP_none_
data GPrAP_none_
type GPrAP_np = Tree GPrAP_np_
data GPrAP_np_
type GPrAdv_none = Tree GPrAdv_none_
data GPrAdv_none_
type GPrAdv_np = Tree GPrAdv_np_
data GPrAdv_np_
type GPrCN_none = Tree GPrCN_none_
data GPrCN_none_
type GPrCN_np = Tree GPrCN_np_
data GPrCN_np_
type GPrCl_none = Tree GPrCl_none_
data GPrCl_none_
type GPrCl_np = Tree GPrCl_np_
data GPrCl_np_
type GPrQCl_none = Tree GPrQCl_none_
data GPrQCl_none_
type GPrQCl_np = Tree GPrQCl_np_
data GPrQCl_np_
type GPrS = Tree GPrS_
data GPrS_
type GPrVPI_none = Tree GPrVPI_none_
data GPrVPI_none_
type GPrVPI_np = Tree GPrVPI_np_
data GPrVPI_np_
type GPrVP_a = Tree GPrVP_a_
data GPrVP_a_
type GPrVP_n = Tree GPrVP_n_
data GPrVP_n_
type GPrVP_none = Tree GPrVP_none_
data GPrVP_none_
type GPrVP_np = Tree GPrVP_np_
data GPrVP_np_
type GPrVP_np_a = Tree GPrVP_np_a_
data GPrVP_np_a_
type GPrVP_np_n = Tree GPrVP_np_n_
data GPrVP_np_n_
type GPrVP_np_np = Tree GPrVP_np_np_
data GPrVP_np_np_
type GPrVP_np_q = Tree GPrVP_np_q_
data GPrVP_np_q_
type GPrVP_np_s = Tree GPrVP_np_s_
data GPrVP_np_s_
type GPrVP_np_v = Tree GPrVP_np_v_
data GPrVP_np_v_
type GPrVP_q = Tree GPrVP_q_
data GPrVP_q_
type GPrVP_s = Tree GPrVP_s_
data GPrVP_s_
type GPrVP_v = Tree GPrVP_v_
data GPrVP_v_
type GPrV_a = Tree GPrV_a_
data GPrV_a_
type GPrV_n = Tree GPrV_n_
data GPrV_n_
type GPrV_none = Tree GPrV_none_
data GPrV_none_
type GPrV_np = Tree GPrV_np_
data GPrV_np_
type GPrV_np_a = Tree GPrV_np_a_
data GPrV_np_a_
type GPrV_np_n = Tree GPrV_np_n_
data GPrV_np_n_
type GPrV_np_np = Tree GPrV_np_np_
data GPrV_np_np_
type GPrV_np_q = Tree GPrV_np_q_
data GPrV_np_q_
type GPrV_np_s = Tree GPrV_np_s_
data GPrV_np_s_
type GPrV_np_v = Tree GPrV_np_v_
data GPrV_np_v_
type GPrV_q = Tree GPrV_q_
data GPrV_q_
type GPrV_s = Tree GPrV_s_
data GPrV_s_
type GPrV_v = Tree GPrV_v_
data GPrV_v_
type GQCl = Tree GQCl_
data GQCl_
type GQS = Tree GQS_
data GQS_
type GQVP = Tree GQVP_
data GQVP_
type GQuant = Tree GQuant_
data GQuant_
type GRCl = Tree GRCl_
data GRCl_
type GRP = Tree GRP_
data GRP_
type GRS = Tree GRS_
data GRS_
type GS = Tree GS_
data GS_
type GSC = Tree GSC_
data GSC_
type GSSlash = Tree GSSlash_
data GSSlash_
type GSymb = Tree GSymb_
data GSymb_
type GTemp = Tree GTemp_
data GTemp_
type GTense = Tree GTense_
data GTense_
type GUtt = Tree GUtt_
data GUtt_
type GVP = Tree GVP_
data GVP_
type GVPC_none = Tree GVPC_none_
data GVPC_none_
type GVPC_np = Tree GVPC_np_
data GVPC_np_
type GVPI = Tree GVPI_
data GVPI_
type GVPS = Tree GVPS_
data GVPS_
type GVPSlash = Tree GVPSlash_
data GVPSlash_
type GVoc = Tree GVoc_
data GVoc_
type GA = Tree GA_
data GA_
type GA2 = Tree GA2_
data GA2_
type GCAdv = Tree GCAdv_
data GCAdv_
type GConj = Tree GConj_
data GConj_
type GDigits = Tree GDigits_
data GDigits_
type GIQuant = Tree GIQuant_
data GIQuant_
type GInterj = Tree GInterj_
data GInterj_
type GN3 = Tree GN3_
data GN3_
type GNumeral = Tree GNumeral_
data GNumeral_
type GPredet = Tree GPredet_
data GPredet_
type GPrep = Tree GPrep_
data GPrep_
type GPron = Tree GPron_
data GPron_
type GSubj = Tree GSubj_
data GSubj_
type GText = Tree GText_
data GText_
type GV = Tree GV_
data GV_
type GV2 = Tree GV2_
data GV2_
type GV2A = Tree GV2A_
data GV2A_
type GV2Q = Tree GV2Q_
data GV2Q_
type GV2S = Tree GV2S_
data GV2S_
type GV2V = Tree GV2V_
data GV2V_
type GV3 = Tree GV3_
data GV3_
type GVA = Tree GVA_
data GVA_
type GVQ = Tree GVQ_
data GVQ_
type GVS = Tree GVS_
data GVS_
type GVV = Tree GVV_
data GVV_
type GString = Tree GString_
data GString_
type GInt = Tree GInt_
data GInt_
type GFloat = Tree GFloat_
data GFloat_

data Tree :: * -> * where

  GEMeta :: Int -> [Tree a] -> Tree GPhr_

  GAdAP :: GAdA -> GAP -> Tree GAP_
  GAdjOrd :: GOrd -> Tree GAP_
  GAdvAP :: GAP -> GAdv -> Tree GAP_
  GCAdvAP :: GCAdv -> GAP -> GNP -> Tree GAP_
  GComparA :: GA -> GNP -> Tree GAP_
  GComplA2 :: GA2 -> GNP -> Tree GAP_
  GConjAP :: GConj -> GListAP -> Tree GAP_
  GGerundAP :: GV -> Tree GAP_
  GPastPartAP :: GV2 -> Tree GAP_
  GPositA :: GA -> Tree GAP_
  GReflA2 :: GA2 -> Tree GAP_
  GSentAP :: GAP -> GSC -> Tree GAP_
  GUseA2 :: GA2 -> Tree GAP_
  GUseComparA :: GA -> Tree GAP_
  GPositAdAAdj :: GA -> Tree GAdA_
  GAdnCAdv :: GCAdv -> Tree GAdN_
  GAdAdV :: GAdA -> GAdV -> Tree GAdV_
  GConjAdV :: GConj -> GListAdV -> Tree GAdV_
  GPositAdVAdj :: GA -> Tree GAdV_
  GAdAdv :: GAdA -> GAdv -> Tree GAdv_
  GComparAdvAdj :: GCAdv -> GA -> GNP -> Tree GAdv_
  GComparAdvAdjS :: GCAdv -> GA -> GS -> Tree GAdv_
  GConjAdv :: GConj -> GListAdv -> Tree GAdv_
  GPositAdvAdj :: GA -> Tree GAdv_
  GPrepNP :: GPrep -> GNP -> Tree GAdv_
  GSubjS :: GSubj -> GS -> Tree GAdv_
  GAAnter :: Tree GAnt_
  GASimul :: Tree GAnt_
  GAdjCN :: GAP -> GCN -> Tree GCN_
  GAdvCN :: GCN -> GAdv -> Tree GCN_
  GAppAPCN :: GPrAP_none -> GCN -> Tree GCN_
  GApposCN :: GCN -> GNP -> Tree GCN_
  GComplN2 :: GN2 -> GNP -> Tree GCN_
  GCompoundCN :: GNum -> GN -> GCN -> Tree GCN_
  GConjCN :: GConj -> GListCN -> Tree GCN_
  GPartNP :: GCN -> GNP -> Tree GCN_
  GPossNP :: GCN -> GNP -> Tree GCN_
  GRelCN :: GCN -> GRS -> Tree GCN_
  GSentCN :: GCN -> GSC -> Tree GCN_
  GUseN :: GN -> Tree GCN_
  GUseN2 :: GN2 -> Tree GCN_
  GAdNum :: GAdN -> GCard -> Tree GCard_
  GNumDigits :: GDigits -> Tree GCard_
  GNumNumeral :: GNumeral -> Tree GCard_
  GExistNP :: GNP -> Tree GCl_
  GPredSCVP :: GSC -> GVP -> Tree GCl_
  GPredVP :: GNP -> GVP -> Tree GCl_
  GPredVPosv :: GNP -> GVP -> Tree GCl_
  GPredVPovs :: GNP -> GVP -> Tree GCl_
  GContClC_none :: GPrCl_none -> GClC_none -> Tree GClC_none_
  GStartClC_none :: GConj -> GPrCl_none -> GPrCl_none -> Tree GClC_none_
  GContClC_np :: GPrCl_np -> GClC_np -> Tree GClC_np_
  GStartClC_np :: GConj -> GPrCl_np -> GPrCl_np -> Tree GClC_np_
  GAdvSlash :: GClSlash -> GAdv -> Tree GClSlash_
  GSlashPrep :: GCl -> GPrep -> Tree GClSlash_
  GSlashVP :: GNP -> GVPSlash -> Tree GClSlash_
  GSlashVS :: GNP -> GVS -> GSSlash -> Tree GClSlash_
  GCompAP :: GAP -> Tree GComp_
  GCompAdv :: GAdv -> Tree GComp_
  GCompCN :: GCN -> Tree GComp_
  GCompNP :: GNP -> Tree GComp_
  GCompQS :: GQS -> Tree GComp_
  GCompS :: GS -> Tree GComp_
  GCompVP :: GAnt -> GPol -> GVP -> Tree GComp_
  GDetQuant :: GQuant -> GNum -> Tree GDet_
  GDetQuantOrd :: GQuant -> GNum -> GOrd -> Tree GDet_
  GAdvIAdv :: GIAdv -> GAdv -> Tree GIAdv_
  GConjIAdv :: GConj -> GListIAdv -> Tree GIAdv_
  GPrepIP :: GPrep -> GIP -> Tree GIAdv_
  GCompIAdv :: GIAdv -> Tree GIComp_
  GCompIP :: GIP -> Tree GIComp_
  GIdetQuant :: GIQuant -> GNum -> Tree GIDet_
  GAdvIP :: GIP -> GAdv -> Tree GIP_
  GIdetCN :: GIDet -> GCN -> Tree GIP_
  GIdetIP :: GIDet -> Tree GIP_
  GImpVP :: GVP -> Tree GImp_
  GListAP :: [GAP] -> Tree GListAP_
  GListAdV :: [GAdV] -> Tree GListAdV_
  GListAdv :: [GAdv] -> Tree GListAdv_
  GListCN :: [GCN] -> Tree GListCN_
  GListIAdv :: [GIAdv] -> Tree GListIAdv_
  GListNP :: [GNP] -> Tree GListNP_
  GListRS :: [GRS] -> Tree GListRS_
  GListS :: [GS] -> Tree GListS_
  GListVPI :: [GVPI] -> Tree GListVPI_
  GListVPS :: [GVPS] -> Tree GListVPS_
  GDashCN :: GN -> GN -> Tree GN_
  GGerundN :: GV -> Tree GN_
  GComplN3 :: GN3 -> GNP -> Tree GN2_
  GUse2N3 :: GN3 -> Tree GN2_
  GUse3N3 :: GN3 -> Tree GN2_
  GAdvNP :: GNP -> GAdv -> Tree GNP_
  GApposNP :: GNP -> GNP -> Tree GNP_
  GCNNumNP :: GCN -> GCard -> Tree GNP_
  GConjNP :: GConj -> GListNP -> Tree GNP_
  GCountNP :: GDet -> GNP -> Tree GNP_
  GDetCN :: GDet -> GCN -> Tree GNP_
  GDetNP :: GDet -> Tree GNP_
  GExtAdvNP :: GNP -> GAdv -> Tree GNP_
  GMassNP :: GCN -> Tree GNP_
  GNomVPNP_none :: GPrVPI_none -> Tree GNP_
  GPPartNP :: GNP -> GV2 -> Tree GNP_
  GPredetNP :: GPredet -> GNP -> Tree GNP_
  GRelNP :: GNP -> GRS -> Tree GNP_
  GSelfNP :: GNP -> Tree GNP_
  GUsePN :: GPN -> Tree GNP_
  GUsePron :: GPron -> Tree GNP_
  GUseQuantPN :: GQuant -> GPN -> Tree GNP_
  Gherself_NP :: Tree GNP_
  Ghimself_NP :: Tree GNP_
  Gitself_NP :: Tree GNP_
  Gmyself_NP :: Tree GNP_
  Gourselves_NP :: Tree GNP_
  Gthemselves_NP :: Tree GNP_
  GyourselfPl_NP :: Tree GNP_
  GyourselfSg_NP :: Tree GNP_
  GNumCard :: GCard -> Tree GNum_
  GNumPl :: Tree GNum_
  GNumSg :: Tree GNum_
  GOrdCompar :: GA -> Tree GOrd_
  GOrdDigits :: GDigits -> Tree GOrd_
  GOrdNumeral :: GNumeral -> Tree GOrd_
  GOrdSuperl :: GA -> Tree GOrd_
  GNoPConj :: Tree GPConj_
  GPConjConj :: GConj -> Tree GPConj_
  GSymbPN :: GSymb -> Tree GPN_
  GPhrUtt :: GPConj -> GUtt -> GVoc -> Tree GPhr_
  GPNeg :: Tree GPol_
  GPPos :: Tree GPol_
  GAgentPastPartAP_none :: GPrV_np -> GNP -> Tree GPrAP_none_
  GLiftAP :: GAP -> Tree GPrAP_none_
  GPastPartAP_none :: GPrV_np -> Tree GPrAP_none_
  GPresPartAP_none :: GPrV_none -> Tree GPrAP_none_
  GLiftA2 :: GA2 -> Tree GPrAP_np_
  GPresPartAP_np :: GPrV_np -> Tree GPrAP_np_
  GComplAdv_none :: GPrAdv_np -> GNP -> Tree GPrAdv_none_
  GLiftAdV :: GAdV -> Tree GPrAdv_none_
  GLiftAdv :: GAdv -> Tree GPrAdv_none_
  GLiftPrep :: GPrep -> Tree GPrAdv_np_
  GLiftCN :: GCN -> Tree GPrCN_none_
  GLiftN2 :: GN2 -> Tree GPrCN_np_
  GAdvCl_none :: GPrAdv_none -> GPrCl_none -> Tree GPrCl_none_
  GPredVP_none :: GNP -> GPrVP_none -> Tree GPrCl_none_
  GSlashClNP_none :: GPrCl_np -> GNP -> Tree GPrCl_none_
  GUseClC_none :: GClC_none -> Tree GPrCl_none_
  GAdvCl_np :: GPrAdv_np -> GPrCl_none -> Tree GPrCl_np_
  GPredVP_np :: GNP -> GPrVP_np -> Tree GPrCl_np_
  GUseClC_np :: GClC_np -> Tree GPrCl_np_
  GAdvQCl_none :: GPrAdv_none -> GPrQCl_none -> Tree GPrQCl_none_
  GQuestCl_none :: GPrCl_none -> Tree GPrQCl_none_
  GQuestIAdv_none :: GIAdv -> GPrCl_none -> Tree GPrQCl_none_
  GQuestIComp_none :: GAnt -> GTense -> GPol -> GIComp -> GNP -> Tree GPrQCl_none_
  GQuestSlash_none :: GIP -> GPrQCl_np -> Tree GPrQCl_none_
  GQuestVP_none :: GIP -> GPrVP_none -> Tree GPrQCl_none_
  GAdvQCl_np :: GPrAdv_np -> GPrQCl_none -> Tree GPrQCl_np_
  GQuestCl_np :: GPrCl_np -> Tree GPrQCl_np_
  GUseAdvCl_none :: GPrAdv_none -> GPrCl_none -> Tree GPrS_
  GUseCl_none :: GPrCl_none -> Tree GPrS_
  GUseQCl_none :: GPrQCl_none -> Tree GPrS_
  GInfVP_none :: GPrVP_none -> Tree GPrVPI_none_
  GInfVP_np :: GPrVP_np -> Tree GPrVPI_np_
  GAgentPassUseV_a :: GAnt -> GTense -> GPol -> GPrV_np_a -> GNP -> Tree GPrVP_a_
  GPassUseV_a :: GAnt -> GTense -> GPol -> GPrV_np_a -> Tree GPrVP_a_
  GReflVP_a :: GPrVP_np_a -> Tree GPrVP_a_
  GUseV_a :: GAnt -> GTense -> GPol -> GPrV_a -> Tree GPrVP_a_
  GAgentPassUseV_n :: GAnt -> GTense -> GPol -> GPrV_np_n -> GNP -> Tree GPrVP_n_
  GPassUseV_n :: GAnt -> GTense -> GPol -> GPrV_np_n -> Tree GPrVP_n_
  GReflVP_n :: GPrVP_np_n -> Tree GPrVP_n_
  GUseV_n :: GAnt -> GTense -> GPol -> GPrV_v -> Tree GPrVP_n_
  GAfterVP_none :: GPrVP_none -> GPrVPI_none -> Tree GPrVP_none_
  GAgentPassUseV_none :: GAnt -> GTense -> GPol -> GPrV_np -> GNP -> Tree GPrVP_none_
  GBeforeVP_none :: GPrVP_none -> GPrVPI_none -> Tree GPrVP_none_
  GByVP_none :: GPrVP_none -> GPrVPI_none -> Tree GPrVP_none_
  GComplV2_none :: GPrVP_np -> GNP -> Tree GPrVP_none_
  GComplVA_none :: GPrVP_a -> GPrAP_none -> Tree GPrVP_none_
  GComplVN_none :: GPrVP_n -> GPrCN_none -> Tree GPrVP_none_
  GComplVQ_none :: GPrVP_q -> GPrQCl_none -> Tree GPrVP_none_
  GComplVS_none :: GPrVP_s -> GPrCl_none -> Tree GPrVP_none_
  GComplVV_none :: GPrVP_v -> GPrVPI_none -> Tree GPrVP_none_
  GInOrderVP_none :: GPrVP_none -> GPrVPI_none -> Tree GPrVP_none_
  GPassUseV_none :: GAnt -> GTense -> GPol -> GPrV_np -> Tree GPrVP_none_
  GReflVP_none :: GPrVP_np -> Tree GPrVP_none_
  GUseAP_none :: GAnt -> GTense -> GPol -> GPrAP_none -> Tree GPrVP_none_
  GUseAdv_none :: GAnt -> GTense -> GPol -> GPrAdv_none -> Tree GPrVP_none_
  GUseCN_none :: GAnt -> GTense -> GPol -> GPrCN_none -> Tree GPrVP_none_
  GUseNP_none :: GAnt -> GTense -> GPol -> GNP -> Tree GPrVP_none_
  GUseQ_none :: GAnt -> GTense -> GPol -> GPrQCl_none -> Tree GPrVP_none_
  GUseS_none :: GAnt -> GTense -> GPol -> GPrCl_none -> Tree GPrVP_none_
  GUseVPC_none :: GVPC_none -> Tree GPrVP_none_
  GUseVP_none :: GAnt -> GTense -> GPol -> GPrVPI_none -> Tree GPrVP_none_
  GUseV_none :: GAnt -> GTense -> GPol -> GPrV_none -> Tree GPrVP_none_
  GWhenVP_none :: GPrVP_none -> GPrVPI_none -> Tree GPrVP_none_
  GWithoutVP_none :: GPrVP_none -> GPrVPI_none -> Tree GPrVP_none_
  GAgentPassUseV_np :: GAnt -> GTense -> GPol -> GPrV_np_np -> GNP -> Tree GPrVP_np_
  GComplVS_np :: GPrVP_s -> GPrCl_np -> Tree GPrVP_np_
  GComplVV_np :: GPrVP_v -> GPrVPI_np -> Tree GPrVP_np_
  GPassUseV_np :: GAnt -> GTense -> GPol -> GPrV_np_np -> Tree GPrVP_np_
  GReflVP2_np :: GPrVP_np_np -> Tree GPrVP_np_
  GReflVP_np :: GPrVP_np_np -> Tree GPrVP_np_
  GSlashV2A_none :: GPrVP_np_a -> GPrAP_none -> Tree GPrVP_np_
  GSlashV2N_none :: GPrVP_np_n -> GPrCN_none -> Tree GPrVP_np_
  GSlashV2Q_none :: GPrVP_np_q -> GPrQCl_none -> Tree GPrVP_np_
  GSlashV2S_none :: GPrVP_np_s -> GPrCl_none -> Tree GPrVP_np_
  GSlashV2V_none :: GPrVP_np_v -> GPrVPI_none -> Tree GPrVP_np_
  GSlashV3_none :: GPrVP_np_np -> GNP -> Tree GPrVP_np_
  GUseAP_np :: GAnt -> GTense -> GPol -> GPrAP_np -> Tree GPrVP_np_
  GUseAdv_np :: GAnt -> GTense -> GPol -> GPrAdv_np -> Tree GPrVP_np_
  GUseCN_np :: GAnt -> GTense -> GPol -> GPrCN_np -> Tree GPrVP_np_
  GUseVPC_np :: GVPC_np -> Tree GPrVP_np_
  GUseV_np :: GAnt -> GTense -> GPol -> GPrV_np -> Tree GPrVP_np_
  GUseV_np_a :: GAnt -> GTense -> GPol -> GPrV_np_a -> Tree GPrVP_np_a_
  GUseV_np_n :: GAnt -> GTense -> GPol -> GPrV_np_n -> Tree GPrVP_np_n_
  GSlashV2V_np :: GPrVP_np_v -> GPrVPI_np -> Tree GPrVP_np_np_
  GUseV_np_np :: GAnt -> GTense -> GPol -> GPrV_np_np -> Tree GPrVP_np_np_
  GUseV_np_q :: GAnt -> GTense -> GPol -> GPrV_np_q -> Tree GPrVP_np_q_
  GUseV_np_s :: GAnt -> GTense -> GPol -> GPrV_np_s -> Tree GPrVP_np_s_
  GUseV_np_v :: GAnt -> GTense -> GPol -> GPrV_np_v -> Tree GPrVP_np_v_
  GAgentPassUseV_q :: GAnt -> GTense -> GPol -> GPrV_np_q -> GNP -> Tree GPrVP_q_
  GPassUseV_q :: GAnt -> GTense -> GPol -> GPrV_np_q -> Tree GPrVP_q_
  GReflVP_q :: GPrVP_np_q -> Tree GPrVP_q_
  GUseV_q :: GAnt -> GTense -> GPol -> GPrV_q -> Tree GPrVP_q_
  GAgentPassUseV_s :: GAnt -> GTense -> GPol -> GPrV_np_s -> GNP -> Tree GPrVP_s_
  GPassUseV_s :: GAnt -> GTense -> GPol -> GPrV_np_s -> Tree GPrVP_s_
  GReflVP_s :: GPrVP_np_s -> Tree GPrVP_s_
  GUseV_s :: GAnt -> GTense -> GPol -> GPrV_s -> Tree GPrVP_s_
  GAgentPassUseV_v :: GAnt -> GTense -> GPol -> GPrV_np_v -> GNP -> Tree GPrVP_v_
  GPassUseV_v :: GAnt -> GTense -> GPol -> GPrV_np_v -> Tree GPrVP_v_
  GReflVP_v :: GPrVP_np_v -> Tree GPrVP_v_
  GUseV_v :: GAnt -> GTense -> GPol -> GPrV_v -> Tree GPrVP_v_
  GLiftVA :: GVA -> Tree GPrV_a_
  GLiftVN :: GVA -> Tree GPrV_n_
  GLiftV :: GV -> Tree GPrV_none_
  GLiftV2 :: GV2 -> Tree GPrV_np_
  GLiftV2A :: GV2A -> Tree GPrV_np_a_
  GLiftV2N :: GV2A -> Tree GPrV_np_n_
  GLiftV3 :: GV3 -> Tree GPrV_np_np_
  GLiftV2Q :: GV2Q -> Tree GPrV_np_q_
  GLiftV2S :: GV2S -> Tree GPrV_np_s_
  GLiftV2V :: GV2V -> Tree GPrV_np_v_
  GLiftVQ :: GVQ -> Tree GPrV_q_
  GLiftVS :: GVS -> Tree GPrV_s_
  GLiftVV :: GVV -> Tree GPrV_v_
  GQuestCl :: GCl -> Tree GQCl_
  GQuestIAdv :: GIAdv -> GCl -> Tree GQCl_
  GQuestIComp :: GIComp -> GNP -> Tree GQCl_
  GQuestQVP :: GIP -> GQVP -> Tree GQCl_
  GQuestSlash :: GIP -> GClSlash -> Tree GQCl_
  GQuestVP :: GIP -> GVP -> Tree GQCl_
  GUseQCl :: GTemp -> GPol -> GQCl -> Tree GQS_
  GAddAdvQVP :: GQVP -> GIAdv -> Tree GQVP_
  GAdvQVP :: GVP -> GIAdv -> Tree GQVP_
  GComplSlashIP :: GVPSlash -> GIP -> Tree GQVP_
  GDefArt :: Tree GQuant_
  GGenNP :: GNP -> Tree GQuant_
  GIndefArt :: Tree GQuant_
  GPossPron :: GPron -> Tree GQuant_
  GEmptyRelSlash :: GClSlash -> Tree GRCl_
  GRelCl :: GCl -> Tree GRCl_
  GRelSlash :: GRP -> GClSlash -> Tree GRCl_
  GRelVP :: GRP -> GVP -> Tree GRCl_
  GFunRP :: GPrep -> GNP -> GRP -> Tree GRP_
  GGenRP :: GNum -> GCN -> Tree GRP_
  GIdRP :: Tree GRP_
  Gthat_RP :: Tree GRP_
  Gwho_RP :: Tree GRP_
  GConjRS :: GConj -> GListRS -> Tree GRS_
  GPastPartRS :: GAnt -> GPol -> GVPSlash -> Tree GRS_
  GPresPartRS :: GAnt -> GPol -> GVP -> Tree GRS_
  GRelCl_none :: GPrCl_none -> Tree GRS_
  GRelSlash_none :: GRP -> GPrCl_np -> Tree GRS_
  GRelVP_none :: GRP -> GPrVP_none -> Tree GRS_
  GUseRCl :: GTemp -> GPol -> GRCl -> Tree GRS_
  GAdvS :: GAdv -> GS -> Tree GS_
  GConjS :: GConj -> GListS -> Tree GS_
  GExtAdvS :: GAdv -> GS -> Tree GS_
  GPredVPS :: GNP -> GVPS -> Tree GS_
  GRelS :: GS -> GRS -> Tree GS_
  GSSubjS :: GS -> GSubj -> GS -> Tree GS_
  GUseCl :: GTemp -> GPol -> GCl -> Tree GS_
  GEmbedQS :: GQS -> Tree GSC_
  GEmbedS :: GS -> Tree GSC_
  GEmbedVP :: GVP -> Tree GSC_
  GUseSlash :: GTemp -> GPol -> GClSlash -> Tree GSSlash_
  GMkSymb :: GString -> Tree GSymb_
  GTTAnt :: GTense -> GAnt -> Tree GTemp_
  GTCond :: Tree GTense_
  GTFut :: Tree GTense_
  GTPast :: Tree GTense_
  GTPres :: Tree GTense_
  GPrImpPl :: GPrVP_none -> Tree GUtt_
  GPrImpSg :: GPrVP_none -> Tree GUtt_
  GUttAP :: GAP -> Tree GUtt_
  GUttAdV :: GAdV -> Tree GUtt_
  GUttAdv :: GAdv -> Tree GUtt_
  GUttCN :: GCN -> Tree GUtt_
  GUttCard :: GCard -> Tree GUtt_
  GUttIAdv :: GIAdv -> Tree GUtt_
  GUttIP :: GIP -> Tree GUtt_
  GUttImpPl :: GPol -> GImp -> Tree GUtt_
  GUttImpPol :: GPol -> GImp -> Tree GUtt_
  GUttImpSg :: GPol -> GImp -> Tree GUtt_
  GUttInterj :: GInterj -> Tree GUtt_
  GUttNP :: GNP -> Tree GUtt_
  GUttPrS :: GPrS -> Tree GUtt_
  GUttQS :: GQS -> Tree GUtt_
  GUttS :: GS -> Tree GUtt_
  GUttVP :: GVP -> Tree GUtt_
  GAdVVP :: GAdV -> GVP -> Tree GVP_
  GAdvVP :: GVP -> GAdv -> Tree GVP_
  GComplBareVS :: GVS -> GS -> Tree GVP_
  GComplSlash :: GVPSlash -> GNP -> Tree GVP_
  GComplSlashPartLast :: GVPSlash -> GNP -> Tree GVP_
  GComplVA :: GVA -> GAP -> Tree GVP_
  GComplVPIVV :: GVV -> GVPI -> Tree GVP_
  GComplVQ :: GVQ -> GQS -> Tree GVP_
  GComplVS :: GVS -> GS -> Tree GVP_
  GComplVV :: GVV -> GAnt -> GPol -> GVP -> Tree GVP_
  GExtAdvVP :: GVP -> GAdv -> Tree GVP_
  GPassAgentVPSlash :: GVPSlash -> GNP -> Tree GVP_
  GPassVPSlash :: GVPSlash -> Tree GVP_
  GProgrVP :: GVP -> Tree GVP_
  GReflVP :: GVPSlash -> Tree GVP_
  GSelfAdVVP :: GVP -> Tree GVP_
  GSelfAdvVP :: GVP -> Tree GVP_
  GUseComp :: GComp -> Tree GVP_
  GUseV :: GV -> Tree GVP_
  GContVPC_none :: GPrVP_none -> GVPC_none -> Tree GVPC_none_
  GStartVPC_none :: GConj -> GPrVP_none -> GPrVP_none -> Tree GVPC_none_
  GContVPC_np :: GPrVP_np -> GVPC_np -> Tree GVPC_np_
  GStartVPC_np :: GConj -> GPrVP_np -> GPrVP_np -> Tree GVPC_np_
  GConjVPI :: GConj -> GListVPI -> Tree GVPI_
  GMkVPI :: GVP -> Tree GVPI_
  GConjVPS :: GConj -> GListVPS -> Tree GVPS_
  GMkVPS :: GTemp -> GPol -> GVP -> Tree GVPS_
  GAdVVPSlash :: GAdV -> GVPSlash -> Tree GVPSlash_
  GAdvVPSlash :: GVPSlash -> GAdv -> Tree GVPSlash_
  GSlash2V3 :: GV3 -> GNP -> Tree GVPSlash_
  GSlash3V3 :: GV3 -> GNP -> Tree GVPSlash_
  GSlashBareV2S :: GV2S -> GS -> Tree GVPSlash_
  GSlashSlashV2V :: GV2V -> GAnt -> GPol -> GVPSlash -> Tree GVPSlash_
  GSlashV2A :: GV2A -> GAP -> Tree GVPSlash_
  GSlashV2Q :: GV2Q -> GQS -> Tree GVPSlash_
  GSlashV2S :: GV2S -> GS -> Tree GVPSlash_
  GSlashV2V :: GV2V -> GAnt -> GPol -> GVP -> Tree GVPSlash_
  GSlashV2VNP :: GV2V -> GNP -> GVPSlash -> Tree GVPSlash_
  GSlashV2a :: GV2 -> Tree GVPSlash_
  GSlashVPIV2V :: GV2V -> GPol -> GVPI -> Tree GVPSlash_
  GSlashVV :: GVV -> GVPSlash -> Tree GVPSlash_
  GVPSlashPrep :: GVP -> GPrep -> Tree GVPSlash_
  GVPSlashVS :: GVS -> GVP -> Tree GVPSlash_
  GNoVoc :: Tree GVoc_
  GVocNP :: GNP -> Tree GVoc_
  GString :: String -> Tree GString_
  GInt :: Int -> Tree GInt_
  GFloat :: Double -> Tree GFloat_

instance Eq (Tree a) where
  i == j = case (i,j) of
    (GAdAP x1 x2,GAdAP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAdjOrd x1,GAdjOrd y1) -> and [ x1 == y1 ]
    (GAdvAP x1 x2,GAdvAP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GCAdvAP x1 x2 x3,GCAdvAP y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GComparA x1 x2,GComparA y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplA2 x1 x2,GComplA2 y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GConjAP x1 x2,GConjAP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GGerundAP x1,GGerundAP y1) -> and [ x1 == y1 ]
    (GPastPartAP x1,GPastPartAP y1) -> and [ x1 == y1 ]
    (GPositA x1,GPositA y1) -> and [ x1 == y1 ]
    (GReflA2 x1,GReflA2 y1) -> and [ x1 == y1 ]
    (GSentAP x1 x2,GSentAP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUseA2 x1,GUseA2 y1) -> and [ x1 == y1 ]
    (GUseComparA x1,GUseComparA y1) -> and [ x1 == y1 ]
    (GPositAdAAdj x1,GPositAdAAdj y1) -> and [ x1 == y1 ]
    (GAdnCAdv x1,GAdnCAdv y1) -> and [ x1 == y1 ]
    (GAdAdV x1 x2,GAdAdV y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GConjAdV x1 x2,GConjAdV y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPositAdVAdj x1,GPositAdVAdj y1) -> and [ x1 == y1 ]
    (GAdAdv x1 x2,GAdAdv y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComparAdvAdj x1 x2 x3,GComparAdvAdj y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GComparAdvAdjS x1 x2 x3,GComparAdvAdjS y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GConjAdv x1 x2,GConjAdv y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPositAdvAdj x1,GPositAdvAdj y1) -> and [ x1 == y1 ]
    (GPrepNP x1 x2,GPrepNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSubjS x1 x2,GSubjS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAAnter,GAAnter) -> and [ ]
    (GASimul,GASimul) -> and [ ]
    (GAdjCN x1 x2,GAdjCN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAdvCN x1 x2,GAdvCN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAppAPCN x1 x2,GAppAPCN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GApposCN x1 x2,GApposCN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplN2 x1 x2,GComplN2 y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GCompoundCN x1 x2 x3,GCompoundCN y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GConjCN x1 x2,GConjCN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPartNP x1 x2,GPartNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPossNP x1 x2,GPossNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GRelCN x1 x2,GRelCN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSentCN x1 x2,GSentCN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUseN x1,GUseN y1) -> and [ x1 == y1 ]
    (GUseN2 x1,GUseN2 y1) -> and [ x1 == y1 ]
    (GAdNum x1 x2,GAdNum y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GNumDigits x1,GNumDigits y1) -> and [ x1 == y1 ]
    (GNumNumeral x1,GNumNumeral y1) -> and [ x1 == y1 ]
    (GExistNP x1,GExistNP y1) -> and [ x1 == y1 ]
    (GPredSCVP x1 x2,GPredSCVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPredVP x1 x2,GPredVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPredVPosv x1 x2,GPredVPosv y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPredVPovs x1 x2,GPredVPovs y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GContClC_none x1 x2,GContClC_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GStartClC_none x1 x2 x3,GStartClC_none y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GContClC_np x1 x2,GContClC_np y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GStartClC_np x1 x2 x3,GStartClC_np y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GAdvSlash x1 x2,GAdvSlash y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashPrep x1 x2,GSlashPrep y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashVP x1 x2,GSlashVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashVS x1 x2 x3,GSlashVS y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GCompAP x1,GCompAP y1) -> and [ x1 == y1 ]
    (GCompAdv x1,GCompAdv y1) -> and [ x1 == y1 ]
    (GCompCN x1,GCompCN y1) -> and [ x1 == y1 ]
    (GCompNP x1,GCompNP y1) -> and [ x1 == y1 ]
    (GCompQS x1,GCompQS y1) -> and [ x1 == y1 ]
    (GCompS x1,GCompS y1) -> and [ x1 == y1 ]
    (GCompVP x1 x2 x3,GCompVP y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GDetQuant x1 x2,GDetQuant y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GDetQuantOrd x1 x2 x3,GDetQuantOrd y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GAdvIAdv x1 x2,GAdvIAdv y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GConjIAdv x1 x2,GConjIAdv y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPrepIP x1 x2,GPrepIP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GCompIAdv x1,GCompIAdv y1) -> and [ x1 == y1 ]
    (GCompIP x1,GCompIP y1) -> and [ x1 == y1 ]
    (GIdetQuant x1 x2,GIdetQuant y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAdvIP x1 x2,GAdvIP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GIdetCN x1 x2,GIdetCN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GIdetIP x1,GIdetIP y1) -> and [ x1 == y1 ]
    (GImpVP x1,GImpVP y1) -> and [ x1 == y1 ]
    (GListAP x1,GListAP y1) -> and [x == y | (x,y) <- zip x1 y1]
    (GListAdV x1,GListAdV y1) -> and [x == y | (x,y) <- zip x1 y1]
    (GListAdv x1,GListAdv y1) -> and [x == y | (x,y) <- zip x1 y1]
    (GListCN x1,GListCN y1) -> and [x == y | (x,y) <- zip x1 y1]
    (GListIAdv x1,GListIAdv y1) -> and [x == y | (x,y) <- zip x1 y1]
    (GListNP x1,GListNP y1) -> and [x == y | (x,y) <- zip x1 y1]
    (GListRS x1,GListRS y1) -> and [x == y | (x,y) <- zip x1 y1]
    (GListS x1,GListS y1) -> and [x == y | (x,y) <- zip x1 y1]
    (GListVPI x1,GListVPI y1) -> and [x == y | (x,y) <- zip x1 y1]
    (GListVPS x1,GListVPS y1) -> and [x == y | (x,y) <- zip x1 y1]
    (GDashCN x1 x2,GDashCN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GGerundN x1,GGerundN y1) -> and [ x1 == y1 ]
    (GComplN3 x1 x2,GComplN3 y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUse2N3 x1,GUse2N3 y1) -> and [ x1 == y1 ]
    (GUse3N3 x1,GUse3N3 y1) -> and [ x1 == y1 ]
    (GAdvNP x1 x2,GAdvNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GApposNP x1 x2,GApposNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GCNNumNP x1 x2,GCNNumNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GConjNP x1 x2,GConjNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GCountNP x1 x2,GCountNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GDetCN x1 x2,GDetCN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GDetNP x1,GDetNP y1) -> and [ x1 == y1 ]
    (GExtAdvNP x1 x2,GExtAdvNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GMassNP x1,GMassNP y1) -> and [ x1 == y1 ]
    (GNomVPNP_none x1,GNomVPNP_none y1) -> and [ x1 == y1 ]
    (GPPartNP x1 x2,GPPartNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPredetNP x1 x2,GPredetNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GRelNP x1 x2,GRelNP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSelfNP x1,GSelfNP y1) -> and [ x1 == y1 ]
    (GUsePN x1,GUsePN y1) -> and [ x1 == y1 ]
    (GUsePron x1,GUsePron y1) -> and [ x1 == y1 ]
    (GUseQuantPN x1 x2,GUseQuantPN y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (Gherself_NP,Gherself_NP) -> and [ ]
    (Ghimself_NP,Ghimself_NP) -> and [ ]
    (Gitself_NP,Gitself_NP) -> and [ ]
    (Gmyself_NP,Gmyself_NP) -> and [ ]
    (Gourselves_NP,Gourselves_NP) -> and [ ]
    (Gthemselves_NP,Gthemselves_NP) -> and [ ]
    (GyourselfPl_NP,GyourselfPl_NP) -> and [ ]
    (GyourselfSg_NP,GyourselfSg_NP) -> and [ ]
    (GNumCard x1,GNumCard y1) -> and [ x1 == y1 ]
    (GNumPl,GNumPl) -> and [ ]
    (GNumSg,GNumSg) -> and [ ]
    (GOrdCompar x1,GOrdCompar y1) -> and [ x1 == y1 ]
    (GOrdDigits x1,GOrdDigits y1) -> and [ x1 == y1 ]
    (GOrdNumeral x1,GOrdNumeral y1) -> and [ x1 == y1 ]
    (GOrdSuperl x1,GOrdSuperl y1) -> and [ x1 == y1 ]
    (GNoPConj,GNoPConj) -> and [ ]
    (GPConjConj x1,GPConjConj y1) -> and [ x1 == y1 ]
    (GSymbPN x1,GSymbPN y1) -> and [ x1 == y1 ]
    (GPhrUtt x1 x2 x3,GPhrUtt y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GPNeg,GPNeg) -> and [ ]
    (GPPos,GPPos) -> and [ ]
    (GAgentPastPartAP_none x1 x2,GAgentPastPartAP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GLiftAP x1,GLiftAP y1) -> and [ x1 == y1 ]
    (GPastPartAP_none x1,GPastPartAP_none y1) -> and [ x1 == y1 ]
    (GPresPartAP_none x1,GPresPartAP_none y1) -> and [ x1 == y1 ]
    (GLiftA2 x1,GLiftA2 y1) -> and [ x1 == y1 ]
    (GPresPartAP_np x1,GPresPartAP_np y1) -> and [ x1 == y1 ]
    (GComplAdv_none x1 x2,GComplAdv_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GLiftAdV x1,GLiftAdV y1) -> and [ x1 == y1 ]
    (GLiftAdv x1,GLiftAdv y1) -> and [ x1 == y1 ]
    (GLiftPrep x1,GLiftPrep y1) -> and [ x1 == y1 ]
    (GLiftCN x1,GLiftCN y1) -> and [ x1 == y1 ]
    (GLiftN2 x1,GLiftN2 y1) -> and [ x1 == y1 ]
    (GAdvCl_none x1 x2,GAdvCl_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPredVP_none x1 x2,GPredVP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashClNP_none x1 x2,GSlashClNP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUseClC_none x1,GUseClC_none y1) -> and [ x1 == y1 ]
    (GAdvCl_np x1 x2,GAdvCl_np y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPredVP_np x1 x2,GPredVP_np y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUseClC_np x1,GUseClC_np y1) -> and [ x1 == y1 ]
    (GAdvQCl_none x1 x2,GAdvQCl_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GQuestCl_none x1,GQuestCl_none y1) -> and [ x1 == y1 ]
    (GQuestIAdv_none x1 x2,GQuestIAdv_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GQuestIComp_none x1 x2 x3 x4 x5,GQuestIComp_none y1 y2 y3 y4 y5) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 , x5 == y5 ]
    (GQuestSlash_none x1 x2,GQuestSlash_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GQuestVP_none x1 x2,GQuestVP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAdvQCl_np x1 x2,GAdvQCl_np y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GQuestCl_np x1,GQuestCl_np y1) -> and [ x1 == y1 ]
    (GUseAdvCl_none x1 x2,GUseAdvCl_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUseCl_none x1,GUseCl_none y1) -> and [ x1 == y1 ]
    (GUseQCl_none x1,GUseQCl_none y1) -> and [ x1 == y1 ]
    (GInfVP_none x1,GInfVP_none y1) -> and [ x1 == y1 ]
    (GInfVP_np x1,GInfVP_np y1) -> and [ x1 == y1 ]
    (GAgentPassUseV_a x1 x2 x3 x4 x5,GAgentPassUseV_a y1 y2 y3 y4 y5) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 , x5 == y5 ]
    (GPassUseV_a x1 x2 x3 x4,GPassUseV_a y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GReflVP_a x1,GReflVP_a y1) -> and [ x1 == y1 ]
    (GUseV_a x1 x2 x3 x4,GUseV_a y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GAgentPassUseV_n x1 x2 x3 x4 x5,GAgentPassUseV_n y1 y2 y3 y4 y5) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 , x5 == y5 ]
    (GPassUseV_n x1 x2 x3 x4,GPassUseV_n y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GReflVP_n x1,GReflVP_n y1) -> and [ x1 == y1 ]
    (GUseV_n x1 x2 x3 x4,GUseV_n y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GAfterVP_none x1 x2,GAfterVP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAgentPassUseV_none x1 x2 x3 x4 x5,GAgentPassUseV_none y1 y2 y3 y4 y5) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 , x5 == y5 ]
    (GBeforeVP_none x1 x2,GBeforeVP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GByVP_none x1 x2,GByVP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplV2_none x1 x2,GComplV2_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVA_none x1 x2,GComplVA_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVN_none x1 x2,GComplVN_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVQ_none x1 x2,GComplVQ_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVS_none x1 x2,GComplVS_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVV_none x1 x2,GComplVV_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GInOrderVP_none x1 x2,GInOrderVP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPassUseV_none x1 x2 x3 x4,GPassUseV_none y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GReflVP_none x1,GReflVP_none y1) -> and [ x1 == y1 ]
    (GUseAP_none x1 x2 x3 x4,GUseAP_none y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseAdv_none x1 x2 x3 x4,GUseAdv_none y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseCN_none x1 x2 x3 x4,GUseCN_none y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseNP_none x1 x2 x3 x4,GUseNP_none y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseQ_none x1 x2 x3 x4,GUseQ_none y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseS_none x1 x2 x3 x4,GUseS_none y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseVPC_none x1,GUseVPC_none y1) -> and [ x1 == y1 ]
    (GUseVP_none x1 x2 x3 x4,GUseVP_none y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseV_none x1 x2 x3 x4,GUseV_none y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GWhenVP_none x1 x2,GWhenVP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GWithoutVP_none x1 x2,GWithoutVP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAgentPassUseV_np x1 x2 x3 x4 x5,GAgentPassUseV_np y1 y2 y3 y4 y5) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 , x5 == y5 ]
    (GComplVS_np x1 x2,GComplVS_np y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVV_np x1 x2,GComplVV_np y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPassUseV_np x1 x2 x3 x4,GPassUseV_np y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GReflVP2_np x1,GReflVP2_np y1) -> and [ x1 == y1 ]
    (GReflVP_np x1,GReflVP_np y1) -> and [ x1 == y1 ]
    (GSlashV2A_none x1 x2,GSlashV2A_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashV2N_none x1 x2,GSlashV2N_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashV2Q_none x1 x2,GSlashV2Q_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashV2S_none x1 x2,GSlashV2S_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashV2V_none x1 x2,GSlashV2V_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashV3_none x1 x2,GSlashV3_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUseAP_np x1 x2 x3 x4,GUseAP_np y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseAdv_np x1 x2 x3 x4,GUseAdv_np y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseCN_np x1 x2 x3 x4,GUseCN_np y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseVPC_np x1,GUseVPC_np y1) -> and [ x1 == y1 ]
    (GUseV_np x1 x2 x3 x4,GUseV_np y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseV_np_a x1 x2 x3 x4,GUseV_np_a y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseV_np_n x1 x2 x3 x4,GUseV_np_n y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GSlashV2V_np x1 x2,GSlashV2V_np y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUseV_np_np x1 x2 x3 x4,GUseV_np_np y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseV_np_q x1 x2 x3 x4,GUseV_np_q y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseV_np_s x1 x2 x3 x4,GUseV_np_s y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GUseV_np_v x1 x2 x3 x4,GUseV_np_v y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GAgentPassUseV_q x1 x2 x3 x4 x5,GAgentPassUseV_q y1 y2 y3 y4 y5) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 , x5 == y5 ]
    (GPassUseV_q x1 x2 x3 x4,GPassUseV_q y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GReflVP_q x1,GReflVP_q y1) -> and [ x1 == y1 ]
    (GUseV_q x1 x2 x3 x4,GUseV_q y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GAgentPassUseV_s x1 x2 x3 x4 x5,GAgentPassUseV_s y1 y2 y3 y4 y5) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 , x5 == y5 ]
    (GPassUseV_s x1 x2 x3 x4,GPassUseV_s y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GReflVP_s x1,GReflVP_s y1) -> and [ x1 == y1 ]
    (GUseV_s x1 x2 x3 x4,GUseV_s y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GAgentPassUseV_v x1 x2 x3 x4 x5,GAgentPassUseV_v y1 y2 y3 y4 y5) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 , x5 == y5 ]
    (GPassUseV_v x1 x2 x3 x4,GPassUseV_v y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GReflVP_v x1,GReflVP_v y1) -> and [ x1 == y1 ]
    (GUseV_v x1 x2 x3 x4,GUseV_v y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GLiftVA x1,GLiftVA y1) -> and [ x1 == y1 ]
    (GLiftVN x1,GLiftVN y1) -> and [ x1 == y1 ]
    (GLiftV x1,GLiftV y1) -> and [ x1 == y1 ]
    (GLiftV2 x1,GLiftV2 y1) -> and [ x1 == y1 ]
    (GLiftV2A x1,GLiftV2A y1) -> and [ x1 == y1 ]
    (GLiftV2N x1,GLiftV2N y1) -> and [ x1 == y1 ]
    (GLiftV3 x1,GLiftV3 y1) -> and [ x1 == y1 ]
    (GLiftV2Q x1,GLiftV2Q y1) -> and [ x1 == y1 ]
    (GLiftV2S x1,GLiftV2S y1) -> and [ x1 == y1 ]
    (GLiftV2V x1,GLiftV2V y1) -> and [ x1 == y1 ]
    (GLiftVQ x1,GLiftVQ y1) -> and [ x1 == y1 ]
    (GLiftVS x1,GLiftVS y1) -> and [ x1 == y1 ]
    (GLiftVV x1,GLiftVV y1) -> and [ x1 == y1 ]
    (GQuestCl x1,GQuestCl y1) -> and [ x1 == y1 ]
    (GQuestIAdv x1 x2,GQuestIAdv y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GQuestIComp x1 x2,GQuestIComp y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GQuestQVP x1 x2,GQuestQVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GQuestSlash x1 x2,GQuestSlash y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GQuestVP x1 x2,GQuestVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUseQCl x1 x2 x3,GUseQCl y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GAddAdvQVP x1 x2,GAddAdvQVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAdvQVP x1 x2,GAdvQVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplSlashIP x1 x2,GComplSlashIP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GDefArt,GDefArt) -> and [ ]
    (GGenNP x1,GGenNP y1) -> and [ x1 == y1 ]
    (GIndefArt,GIndefArt) -> and [ ]
    (GPossPron x1,GPossPron y1) -> and [ x1 == y1 ]
    (GEmptyRelSlash x1,GEmptyRelSlash y1) -> and [ x1 == y1 ]
    (GRelCl x1,GRelCl y1) -> and [ x1 == y1 ]
    (GRelSlash x1 x2,GRelSlash y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GRelVP x1 x2,GRelVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GFunRP x1 x2 x3,GFunRP y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GGenRP x1 x2,GGenRP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GIdRP,GIdRP) -> and [ ]
    (Gthat_RP,Gthat_RP) -> and [ ]
    (Gwho_RP,Gwho_RP) -> and [ ]
    (GConjRS x1 x2,GConjRS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPastPartRS x1 x2 x3,GPastPartRS y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GPresPartRS x1 x2 x3,GPresPartRS y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GRelCl_none x1,GRelCl_none y1) -> and [ x1 == y1 ]
    (GRelSlash_none x1 x2,GRelSlash_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GRelVP_none x1 x2,GRelVP_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUseRCl x1 x2 x3,GUseRCl y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GAdvS x1 x2,GAdvS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GConjS x1 x2,GConjS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GExtAdvS x1 x2,GExtAdvS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPredVPS x1 x2,GPredVPS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GRelS x1 x2,GRelS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSSubjS x1 x2 x3,GSSubjS y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GUseCl x1 x2 x3,GUseCl y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GEmbedQS x1,GEmbedQS y1) -> and [ x1 == y1 ]
    (GEmbedS x1,GEmbedS y1) -> and [ x1 == y1 ]
    (GEmbedVP x1,GEmbedVP y1) -> and [ x1 == y1 ]
    (GUseSlash x1 x2 x3,GUseSlash y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GMkSymb x1,GMkSymb y1) -> and [ x1 == y1 ]
    (GTTAnt x1 x2,GTTAnt y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GTCond,GTCond) -> and [ ]
    (GTFut,GTFut) -> and [ ]
    (GTPast,GTPast) -> and [ ]
    (GTPres,GTPres) -> and [ ]
    (GPrImpPl x1,GPrImpPl y1) -> and [ x1 == y1 ]
    (GPrImpSg x1,GPrImpSg y1) -> and [ x1 == y1 ]
    (GUttAP x1,GUttAP y1) -> and [ x1 == y1 ]
    (GUttAdV x1,GUttAdV y1) -> and [ x1 == y1 ]
    (GUttAdv x1,GUttAdv y1) -> and [ x1 == y1 ]
    (GUttCN x1,GUttCN y1) -> and [ x1 == y1 ]
    (GUttCard x1,GUttCard y1) -> and [ x1 == y1 ]
    (GUttIAdv x1,GUttIAdv y1) -> and [ x1 == y1 ]
    (GUttIP x1,GUttIP y1) -> and [ x1 == y1 ]
    (GUttImpPl x1 x2,GUttImpPl y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUttImpPol x1 x2,GUttImpPol y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUttImpSg x1 x2,GUttImpSg y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GUttInterj x1,GUttInterj y1) -> and [ x1 == y1 ]
    (GUttNP x1,GUttNP y1) -> and [ x1 == y1 ]
    (GUttPrS x1,GUttPrS y1) -> and [ x1 == y1 ]
    (GUttQS x1,GUttQS y1) -> and [ x1 == y1 ]
    (GUttS x1,GUttS y1) -> and [ x1 == y1 ]
    (GUttVP x1,GUttVP y1) -> and [ x1 == y1 ]
    (GAdVVP x1 x2,GAdVVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAdvVP x1 x2,GAdvVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplBareVS x1 x2,GComplBareVS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplSlash x1 x2,GComplSlash y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplSlashPartLast x1 x2,GComplSlashPartLast y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVA x1 x2,GComplVA y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVPIVV x1 x2,GComplVPIVV y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVQ x1 x2,GComplVQ y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVS x1 x2,GComplVS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GComplVV x1 x2 x3 x4,GComplVV y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GExtAdvVP x1 x2,GExtAdvVP y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPassAgentVPSlash x1 x2,GPassAgentVPSlash y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GPassVPSlash x1,GPassVPSlash y1) -> and [ x1 == y1 ]
    (GProgrVP x1,GProgrVP y1) -> and [ x1 == y1 ]
    (GReflVP x1,GReflVP y1) -> and [ x1 == y1 ]
    (GSelfAdVVP x1,GSelfAdVVP y1) -> and [ x1 == y1 ]
    (GSelfAdvVP x1,GSelfAdvVP y1) -> and [ x1 == y1 ]
    (GUseComp x1,GUseComp y1) -> and [ x1 == y1 ]
    (GUseV x1,GUseV y1) -> and [ x1 == y1 ]
    (GContVPC_none x1 x2,GContVPC_none y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GStartVPC_none x1 x2 x3,GStartVPC_none y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GContVPC_np x1 x2,GContVPC_np y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GStartVPC_np x1 x2 x3,GStartVPC_np y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GConjVPI x1 x2,GConjVPI y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GMkVPI x1,GMkVPI y1) -> and [ x1 == y1 ]
    (GConjVPS x1 x2,GConjVPS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GMkVPS x1 x2 x3,GMkVPS y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GAdVVPSlash x1 x2,GAdVVPSlash y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GAdvVPSlash x1 x2,GAdvVPSlash y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlash2V3 x1 x2,GSlash2V3 y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlash3V3 x1 x2,GSlash3V3 y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashBareV2S x1 x2,GSlashBareV2S y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashSlashV2V x1 x2 x3 x4,GSlashSlashV2V y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GSlashV2A x1 x2,GSlashV2A y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashV2Q x1 x2,GSlashV2Q y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashV2S x1 x2,GSlashV2S y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GSlashV2V x1 x2 x3 x4,GSlashV2V y1 y2 y3 y4) -> and [ x1 == y1 , x2 == y2 , x3 == y3 , x4 == y4 ]
    (GSlashV2VNP x1 x2 x3,GSlashV2VNP y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GSlashV2a x1,GSlashV2a y1) -> and [ x1 == y1 ]
    (GSlashVPIV2V x1 x2 x3,GSlashVPIV2V y1 y2 y3) -> and [ x1 == y1 , x2 == y2 , x3 == y3 ]
    (GSlashVV x1 x2,GSlashVV y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GVPSlashPrep x1 x2,GVPSlashPrep y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GVPSlashVS x1 x2,GVPSlashVS y1 y2) -> and [ x1 == y1 , x2 == y2 ]
    (GNoVoc,GNoVoc) -> and [ ]
    (GVocNP x1,GVocNP y1) -> and [ x1 == y1 ]
    (GString x, GString y) -> x == y
    (GInt x, GInt y) -> x == y
    (GFloat x, GFloat y) -> x == y
    _ -> False

instance Gf GAP where
  gf (GAdAP x1 x2) = mkApp (mkCId "AdAP") [gf x1, gf x2]
  gf (GAdjOrd x1) = mkApp (mkCId "AdjOrd") [gf x1]
  gf (GAdvAP x1 x2) = mkApp (mkCId "AdvAP") [gf x1, gf x2]
  gf (GCAdvAP x1 x2 x3) = mkApp (mkCId "CAdvAP") [gf x1, gf x2, gf x3]
  gf (GComparA x1 x2) = mkApp (mkCId "ComparA") [gf x1, gf x2]
  gf (GComplA2 x1 x2) = mkApp (mkCId "ComplA2") [gf x1, gf x2]
  gf (GConjAP x1 x2) = mkApp (mkCId "ConjAP") [gf x1, gf x2]
  gf (GGerundAP x1) = mkApp (mkCId "GerundAP") [gf x1]
  gf (GPastPartAP x1) = mkApp (mkCId "PastPartAP") [gf x1]
  gf (GPositA x1) = mkApp (mkCId "PositA") [gf x1]
  gf (GReflA2 x1) = mkApp (mkCId "ReflA2") [gf x1]
  gf (GSentAP x1 x2) = mkApp (mkCId "SentAP") [gf x1, gf x2]
  gf (GUseA2 x1) = mkApp (mkCId "UseA2") [gf x1]
  gf (GUseComparA x1) = mkApp (mkCId "UseComparA") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdAP" -> GAdAP (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "AdjOrd" -> GAdjOrd (fg x1)
      Just (i,[x1,x2]) | i == mkCId "AdvAP" -> GAdvAP (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "CAdvAP" -> GCAdvAP (fg x1) (fg x2) (fg x3)
      Just (i,[x1,x2]) | i == mkCId "ComparA" -> GComparA (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplA2" -> GComplA2 (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ConjAP" -> GConjAP (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "GerundAP" -> GGerundAP (fg x1)
      Just (i,[x1]) | i == mkCId "PastPartAP" -> GPastPartAP (fg x1)
      Just (i,[x1]) | i == mkCId "PositA" -> GPositA (fg x1)
      Just (i,[x1]) | i == mkCId "ReflA2" -> GReflA2 (fg x1)
      Just (i,[x1,x2]) | i == mkCId "SentAP" -> GSentAP (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "UseA2" -> GUseA2 (fg x1)
      Just (i,[x1]) | i == mkCId "UseComparA" -> GUseComparA (fg x1)


      _ -> error ("no AP " ++ show t)

instance Gf GAdA where
  gf (GPositAdAAdj x1) = mkApp (mkCId "PositAdAAdj") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "PositAdAAdj" -> GPositAdAAdj (fg x1)


      _ -> error ("no AdA " ++ show t)

instance Gf GAdN where
  gf (GAdnCAdv x1) = mkApp (mkCId "AdnCAdv") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "AdnCAdv" -> GAdnCAdv (fg x1)


      _ -> error ("no AdN " ++ show t)

instance Gf GAdV where
  gf (GAdAdV x1 x2) = mkApp (mkCId "AdAdV") [gf x1, gf x2]
  gf (GConjAdV x1 x2) = mkApp (mkCId "ConjAdV") [gf x1, gf x2]
  gf (GPositAdVAdj x1) = mkApp (mkCId "PositAdVAdj") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdAdV" -> GAdAdV (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ConjAdV" -> GConjAdV (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "PositAdVAdj" -> GPositAdVAdj (fg x1)


      _ -> error ("no AdV " ++ show t)

instance Gf GAdv where
  gf (GAdAdv x1 x2) = mkApp (mkCId "AdAdv") [gf x1, gf x2]
  gf (GComparAdvAdj x1 x2 x3) = mkApp (mkCId "ComparAdvAdj") [gf x1, gf x2, gf x3]
  gf (GComparAdvAdjS x1 x2 x3) = mkApp (mkCId "ComparAdvAdjS") [gf x1, gf x2, gf x3]
  gf (GConjAdv x1 x2) = mkApp (mkCId "ConjAdv") [gf x1, gf x2]
  gf (GPositAdvAdj x1) = mkApp (mkCId "PositAdvAdj") [gf x1]
  gf (GPrepNP x1 x2) = mkApp (mkCId "PrepNP") [gf x1, gf x2]
  gf (GSubjS x1 x2) = mkApp (mkCId "SubjS") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdAdv" -> GAdAdv (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "ComparAdvAdj" -> GComparAdvAdj (fg x1) (fg x2) (fg x3)
      Just (i,[x1,x2,x3]) | i == mkCId "ComparAdvAdjS" -> GComparAdvAdjS (fg x1) (fg x2) (fg x3)
      Just (i,[x1,x2]) | i == mkCId "ConjAdv" -> GConjAdv (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "PositAdvAdj" -> GPositAdvAdj (fg x1)
      Just (i,[x1,x2]) | i == mkCId "PrepNP" -> GPrepNP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SubjS" -> GSubjS (fg x1) (fg x2)


      _ -> error ("no Adv " ++ show t)

instance Gf GAnt where
  gf GAAnter = mkApp (mkCId "AAnter") []
  gf GASimul = mkApp (mkCId "ASimul") []

  fg t =
    case unApp t of
      Just (i,[]) | i == mkCId "AAnter" -> GAAnter 
      Just (i,[]) | i == mkCId "ASimul" -> GASimul 


      _ -> error ("no Ant " ++ show t)

instance Gf GCN where
  gf (GAdjCN x1 x2) = mkApp (mkCId "AdjCN") [gf x1, gf x2]
  gf (GAdvCN x1 x2) = mkApp (mkCId "AdvCN") [gf x1, gf x2]
  gf (GAppAPCN x1 x2) = mkApp (mkCId "AppAPCN") [gf x1, gf x2]
  gf (GApposCN x1 x2) = mkApp (mkCId "ApposCN") [gf x1, gf x2]
  gf (GComplN2 x1 x2) = mkApp (mkCId "ComplN2") [gf x1, gf x2]
  gf (GCompoundCN x1 x2 x3) = mkApp (mkCId "CompoundCN") [gf x1, gf x2, gf x3]
  gf (GConjCN x1 x2) = mkApp (mkCId "ConjCN") [gf x1, gf x2]
  gf (GPartNP x1 x2) = mkApp (mkCId "PartNP") [gf x1, gf x2]
  gf (GPossNP x1 x2) = mkApp (mkCId "PossNP") [gf x1, gf x2]
  gf (GRelCN x1 x2) = mkApp (mkCId "RelCN") [gf x1, gf x2]
  gf (GSentCN x1 x2) = mkApp (mkCId "SentCN") [gf x1, gf x2]
  gf (GUseN x1) = mkApp (mkCId "UseN") [gf x1]
  gf (GUseN2 x1) = mkApp (mkCId "UseN2") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdjCN" -> GAdjCN (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "AdvCN" -> GAdvCN (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "AppAPCN" -> GAppAPCN (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ApposCN" -> GApposCN (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplN2" -> GComplN2 (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "CompoundCN" -> GCompoundCN (fg x1) (fg x2) (fg x3)
      Just (i,[x1,x2]) | i == mkCId "ConjCN" -> GConjCN (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PartNP" -> GPartNP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PossNP" -> GPossNP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "RelCN" -> GRelCN (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SentCN" -> GSentCN (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "UseN" -> GUseN (fg x1)
      Just (i,[x1]) | i == mkCId "UseN2" -> GUseN2 (fg x1)


      _ -> error ("no CN " ++ show t)

instance Gf GCard where
  gf (GAdNum x1 x2) = mkApp (mkCId "AdNum") [gf x1, gf x2]
  gf (GNumDigits x1) = mkApp (mkCId "NumDigits") [gf x1]
  gf (GNumNumeral x1) = mkApp (mkCId "NumNumeral") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdNum" -> GAdNum (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "NumDigits" -> GNumDigits (fg x1)
      Just (i,[x1]) | i == mkCId "NumNumeral" -> GNumNumeral (fg x1)


      _ -> error ("no Card " ++ show t)

instance Gf GCl where
  gf (GExistNP x1) = mkApp (mkCId "ExistNP") [gf x1]
  gf (GPredSCVP x1 x2) = mkApp (mkCId "PredSCVP") [gf x1, gf x2]
  gf (GPredVP x1 x2) = mkApp (mkCId "PredVP") [gf x1, gf x2]
  gf (GPredVPosv x1 x2) = mkApp (mkCId "PredVPosv") [gf x1, gf x2]
  gf (GPredVPovs x1 x2) = mkApp (mkCId "PredVPovs") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "ExistNP" -> GExistNP (fg x1)
      Just (i,[x1,x2]) | i == mkCId "PredSCVP" -> GPredSCVP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PredVP" -> GPredVP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PredVPosv" -> GPredVPosv (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PredVPovs" -> GPredVPovs (fg x1) (fg x2)


      _ -> error ("no Cl " ++ show t)

instance Gf GClC_none where
  gf (GContClC_none x1 x2) = mkApp (mkCId "ContClC_none") [gf x1, gf x2]
  gf (GStartClC_none x1 x2 x3) = mkApp (mkCId "StartClC_none") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "ContClC_none" -> GContClC_none (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "StartClC_none" -> GStartClC_none (fg x1) (fg x2) (fg x3)


      _ -> error ("no ClC_none " ++ show t)

instance Gf GClC_np where
  gf (GContClC_np x1 x2) = mkApp (mkCId "ContClC_np") [gf x1, gf x2]
  gf (GStartClC_np x1 x2 x3) = mkApp (mkCId "StartClC_np") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "ContClC_np" -> GContClC_np (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "StartClC_np" -> GStartClC_np (fg x1) (fg x2) (fg x3)


      _ -> error ("no ClC_np " ++ show t)

instance Gf GClSlash where
  gf (GAdvSlash x1 x2) = mkApp (mkCId "AdvSlash") [gf x1, gf x2]
  gf (GSlashPrep x1 x2) = mkApp (mkCId "SlashPrep") [gf x1, gf x2]
  gf (GSlashVP x1 x2) = mkApp (mkCId "SlashVP") [gf x1, gf x2]
  gf (GSlashVS x1 x2 x3) = mkApp (mkCId "SlashVS") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdvSlash" -> GAdvSlash (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashPrep" -> GSlashPrep (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashVP" -> GSlashVP (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "SlashVS" -> GSlashVS (fg x1) (fg x2) (fg x3)


      _ -> error ("no ClSlash " ++ show t)

instance Gf GComp where
  gf (GCompAP x1) = mkApp (mkCId "CompAP") [gf x1]
  gf (GCompAdv x1) = mkApp (mkCId "CompAdv") [gf x1]
  gf (GCompCN x1) = mkApp (mkCId "CompCN") [gf x1]
  gf (GCompNP x1) = mkApp (mkCId "CompNP") [gf x1]
  gf (GCompQS x1) = mkApp (mkCId "CompQS") [gf x1]
  gf (GCompS x1) = mkApp (mkCId "CompS") [gf x1]
  gf (GCompVP x1 x2 x3) = mkApp (mkCId "CompVP") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "CompAP" -> GCompAP (fg x1)
      Just (i,[x1]) | i == mkCId "CompAdv" -> GCompAdv (fg x1)
      Just (i,[x1]) | i == mkCId "CompCN" -> GCompCN (fg x1)
      Just (i,[x1]) | i == mkCId "CompNP" -> GCompNP (fg x1)
      Just (i,[x1]) | i == mkCId "CompQS" -> GCompQS (fg x1)
      Just (i,[x1]) | i == mkCId "CompS" -> GCompS (fg x1)
      Just (i,[x1,x2,x3]) | i == mkCId "CompVP" -> GCompVP (fg x1) (fg x2) (fg x3)


      _ -> error ("no Comp " ++ show t)

instance Gf GDet where
  gf (GDetQuant x1 x2) = mkApp (mkCId "DetQuant") [gf x1, gf x2]
  gf (GDetQuantOrd x1 x2 x3) = mkApp (mkCId "DetQuantOrd") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "DetQuant" -> GDetQuant (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "DetQuantOrd" -> GDetQuantOrd (fg x1) (fg x2) (fg x3)


      _ -> error ("no Det " ++ show t)

instance Gf GIAdv where
  gf (GAdvIAdv x1 x2) = mkApp (mkCId "AdvIAdv") [gf x1, gf x2]
  gf (GConjIAdv x1 x2) = mkApp (mkCId "ConjIAdv") [gf x1, gf x2]
  gf (GPrepIP x1 x2) = mkApp (mkCId "PrepIP") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdvIAdv" -> GAdvIAdv (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ConjIAdv" -> GConjIAdv (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PrepIP" -> GPrepIP (fg x1) (fg x2)


      _ -> error ("no IAdv " ++ show t)

instance Gf GIComp where
  gf (GCompIAdv x1) = mkApp (mkCId "CompIAdv") [gf x1]
  gf (GCompIP x1) = mkApp (mkCId "CompIP") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "CompIAdv" -> GCompIAdv (fg x1)
      Just (i,[x1]) | i == mkCId "CompIP" -> GCompIP (fg x1)


      _ -> error ("no IComp " ++ show t)

instance Gf GIDet where
  gf (GIdetQuant x1 x2) = mkApp (mkCId "IdetQuant") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "IdetQuant" -> GIdetQuant (fg x1) (fg x2)


      _ -> error ("no IDet " ++ show t)

instance Gf GIP where
  gf (GAdvIP x1 x2) = mkApp (mkCId "AdvIP") [gf x1, gf x2]
  gf (GIdetCN x1 x2) = mkApp (mkCId "IdetCN") [gf x1, gf x2]
  gf (GIdetIP x1) = mkApp (mkCId "IdetIP") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdvIP" -> GAdvIP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "IdetCN" -> GIdetCN (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "IdetIP" -> GIdetIP (fg x1)


      _ -> error ("no IP " ++ show t)

instance Gf GImp where
  gf (GImpVP x1) = mkApp (mkCId "ImpVP") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "ImpVP" -> GImpVP (fg x1)


      _ -> error ("no Imp " ++ show t)

instance Gf GListAP where
  gf (GListAP [x1,x2]) = mkApp (mkCId "BaseAP") [gf x1, gf x2]
  gf (GListAP (x:xs)) = mkApp (mkCId "ConsAP") [gf x, gf (GListAP xs)]
  fg t =
    GListAP (fgs t) where
     fgs t = case unApp t of
      Just (i,[x1,x2]) | i == mkCId "BaseAP" -> [fg x1, fg x2]
      Just (i,[x1,x2]) | i == mkCId "ConsAP" -> fg x1 : fgs x2


      _ -> error ("no ListAP " ++ show t)

instance Gf GListAdV where
  gf (GListAdV [x1,x2]) = mkApp (mkCId "BaseAdV") [gf x1, gf x2]
  gf (GListAdV (x:xs)) = mkApp (mkCId "ConsAdV") [gf x, gf (GListAdV xs)]
  fg t =
    GListAdV (fgs t) where
     fgs t = case unApp t of
      Just (i,[x1,x2]) | i == mkCId "BaseAdV" -> [fg x1, fg x2]
      Just (i,[x1,x2]) | i == mkCId "ConsAdV" -> fg x1 : fgs x2


      _ -> error ("no ListAdV " ++ show t)

instance Gf GListAdv where
  gf (GListAdv [x1,x2]) = mkApp (mkCId "BaseAdv") [gf x1, gf x2]
  gf (GListAdv (x:xs)) = mkApp (mkCId "ConsAdv") [gf x, gf (GListAdv xs)]
  fg t =
    GListAdv (fgs t) where
     fgs t = case unApp t of
      Just (i,[x1,x2]) | i == mkCId "BaseAdv" -> [fg x1, fg x2]
      Just (i,[x1,x2]) | i == mkCId "ConsAdv" -> fg x1 : fgs x2


      _ -> error ("no ListAdv " ++ show t)

instance Gf GListCN where
  gf (GListCN [x1,x2]) = mkApp (mkCId "BaseCN") [gf x1, gf x2]
  gf (GListCN (x:xs)) = mkApp (mkCId "ConsCN") [gf x, gf (GListCN xs)]
  fg t =
    GListCN (fgs t) where
     fgs t = case unApp t of
      Just (i,[x1,x2]) | i == mkCId "BaseCN" -> [fg x1, fg x2]
      Just (i,[x1,x2]) | i == mkCId "ConsCN" -> fg x1 : fgs x2


      _ -> error ("no ListCN " ++ show t)

instance Gf GListIAdv where
  gf (GListIAdv [x1,x2]) = mkApp (mkCId "BaseIAdv") [gf x1, gf x2]
  gf (GListIAdv (x:xs)) = mkApp (mkCId "ConsIAdv") [gf x, gf (GListIAdv xs)]
  fg t =
    GListIAdv (fgs t) where
     fgs t = case unApp t of
      Just (i,[x1,x2]) | i == mkCId "BaseIAdv" -> [fg x1, fg x2]
      Just (i,[x1,x2]) | i == mkCId "ConsIAdv" -> fg x1 : fgs x2


      _ -> error ("no ListIAdv " ++ show t)

instance Gf GListNP where
  gf (GListNP [x1,x2]) = mkApp (mkCId "BaseNP") [gf x1, gf x2]
  gf (GListNP (x:xs)) = mkApp (mkCId "ConsNP") [gf x, gf (GListNP xs)]
  fg t =
    GListNP (fgs t) where
     fgs t = case unApp t of
      Just (i,[x1,x2]) | i == mkCId "BaseNP" -> [fg x1, fg x2]
      Just (i,[x1,x2]) | i == mkCId "ConsNP" -> fg x1 : fgs x2


      _ -> error ("no ListNP " ++ show t)

instance Gf GListRS where
  gf (GListRS [x1,x2]) = mkApp (mkCId "BaseRS") [gf x1, gf x2]
  gf (GListRS (x:xs)) = mkApp (mkCId "ConsRS") [gf x, gf (GListRS xs)]
  fg t =
    GListRS (fgs t) where
     fgs t = case unApp t of
      Just (i,[x1,x2]) | i == mkCId "BaseRS" -> [fg x1, fg x2]
      Just (i,[x1,x2]) | i == mkCId "ConsRS" -> fg x1 : fgs x2


      _ -> error ("no ListRS " ++ show t)

instance Gf GListS where
  gf (GListS [x1,x2]) = mkApp (mkCId "BaseS") [gf x1, gf x2]
  gf (GListS (x:xs)) = mkApp (mkCId "ConsS") [gf x, gf (GListS xs)]
  fg t =
    GListS (fgs t) where
     fgs t = case unApp t of
      Just (i,[x1,x2]) | i == mkCId "BaseS" -> [fg x1, fg x2]
      Just (i,[x1,x2]) | i == mkCId "ConsS" -> fg x1 : fgs x2


      _ -> error ("no ListS " ++ show t)

instance Gf GListVPI where
  gf (GListVPI [x1,x2]) = mkApp (mkCId "BaseVPI") [gf x1, gf x2]
  gf (GListVPI (x:xs)) = mkApp (mkCId "ConsVPI") [gf x, gf (GListVPI xs)]
  fg t =
    GListVPI (fgs t) where
     fgs t = case unApp t of
      Just (i,[x1,x2]) | i == mkCId "BaseVPI" -> [fg x1, fg x2]
      Just (i,[x1,x2]) | i == mkCId "ConsVPI" -> fg x1 : fgs x2


      _ -> error ("no ListVPI " ++ show t)

instance Gf GListVPS where
  gf (GListVPS [x1,x2]) = mkApp (mkCId "BaseVPS") [gf x1, gf x2]
  gf (GListVPS (x:xs)) = mkApp (mkCId "ConsVPS") [gf x, gf (GListVPS xs)]
  fg t =
    GListVPS (fgs t) where
     fgs t = case unApp t of
      Just (i,[x1,x2]) | i == mkCId "BaseVPS" -> [fg x1, fg x2]
      Just (i,[x1,x2]) | i == mkCId "ConsVPS" -> fg x1 : fgs x2


      _ -> error ("no ListVPS " ++ show t)

instance Gf GN where
  gf (GDashCN x1 x2) = mkApp (mkCId "DashCN") [gf x1, gf x2]
  gf (GGerundN x1) = mkApp (mkCId "GerundN") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "DashCN" -> GDashCN (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "GerundN" -> GGerundN (fg x1)


      _ -> error ("no N " ++ show t)

instance Gf GN2 where
  gf (GComplN3 x1 x2) = mkApp (mkCId "ComplN3") [gf x1, gf x2]
  gf (GUse2N3 x1) = mkApp (mkCId "Use2N3") [gf x1]
  gf (GUse3N3 x1) = mkApp (mkCId "Use3N3") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "ComplN3" -> GComplN3 (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "Use2N3" -> GUse2N3 (fg x1)
      Just (i,[x1]) | i == mkCId "Use3N3" -> GUse3N3 (fg x1)


      _ -> error ("no N2 " ++ show t)

instance Gf GNP where
  gf (GAdvNP x1 x2) = mkApp (mkCId "AdvNP") [gf x1, gf x2]
  gf (GApposNP x1 x2) = mkApp (mkCId "ApposNP") [gf x1, gf x2]
  gf (GCNNumNP x1 x2) = mkApp (mkCId "CNNumNP") [gf x1, gf x2]
  gf (GConjNP x1 x2) = mkApp (mkCId "ConjNP") [gf x1, gf x2]
  gf (GCountNP x1 x2) = mkApp (mkCId "CountNP") [gf x1, gf x2]
  gf (GDetCN x1 x2) = mkApp (mkCId "DetCN") [gf x1, gf x2]
  gf (GDetNP x1) = mkApp (mkCId "DetNP") [gf x1]
  gf (GExtAdvNP x1 x2) = mkApp (mkCId "ExtAdvNP") [gf x1, gf x2]
  gf (GMassNP x1) = mkApp (mkCId "MassNP") [gf x1]
  gf (GNomVPNP_none x1) = mkApp (mkCId "NomVPNP_none") [gf x1]
  gf (GPPartNP x1 x2) = mkApp (mkCId "PPartNP") [gf x1, gf x2]
  gf (GPredetNP x1 x2) = mkApp (mkCId "PredetNP") [gf x1, gf x2]
  gf (GRelNP x1 x2) = mkApp (mkCId "RelNP") [gf x1, gf x2]
  gf (GSelfNP x1) = mkApp (mkCId "SelfNP") [gf x1]
  gf (GUsePN x1) = mkApp (mkCId "UsePN") [gf x1]
  gf (GUsePron x1) = mkApp (mkCId "UsePron") [gf x1]
  gf (GUseQuantPN x1 x2) = mkApp (mkCId "UseQuantPN") [gf x1, gf x2]
  gf Gherself_NP = mkApp (mkCId "herself_NP") []
  gf Ghimself_NP = mkApp (mkCId "himself_NP") []
  gf Gitself_NP = mkApp (mkCId "itself_NP") []
  gf Gmyself_NP = mkApp (mkCId "myself_NP") []
  gf Gourselves_NP = mkApp (mkCId "ourselves_NP") []
  gf Gthemselves_NP = mkApp (mkCId "themselves_NP") []
  gf GyourselfPl_NP = mkApp (mkCId "yourselfPl_NP") []
  gf GyourselfSg_NP = mkApp (mkCId "yourselfSg_NP") []

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdvNP" -> GAdvNP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ApposNP" -> GApposNP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "CNNumNP" -> GCNNumNP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ConjNP" -> GConjNP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "CountNP" -> GCountNP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "DetCN" -> GDetCN (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "DetNP" -> GDetNP (fg x1)
      Just (i,[x1,x2]) | i == mkCId "ExtAdvNP" -> GExtAdvNP (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "MassNP" -> GMassNP (fg x1)
      Just (i,[x1]) | i == mkCId "NomVPNP_none" -> GNomVPNP_none (fg x1)
      Just (i,[x1,x2]) | i == mkCId "PPartNP" -> GPPartNP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PredetNP" -> GPredetNP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "RelNP" -> GRelNP (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "SelfNP" -> GSelfNP (fg x1)
      Just (i,[x1]) | i == mkCId "UsePN" -> GUsePN (fg x1)
      Just (i,[x1]) | i == mkCId "UsePron" -> GUsePron (fg x1)
      Just (i,[x1,x2]) | i == mkCId "UseQuantPN" -> GUseQuantPN (fg x1) (fg x2)
      Just (i,[]) | i == mkCId "herself_NP" -> Gherself_NP 
      Just (i,[]) | i == mkCId "himself_NP" -> Ghimself_NP 
      Just (i,[]) | i == mkCId "itself_NP" -> Gitself_NP 
      Just (i,[]) | i == mkCId "myself_NP" -> Gmyself_NP 
      Just (i,[]) | i == mkCId "ourselves_NP" -> Gourselves_NP 
      Just (i,[]) | i == mkCId "themselves_NP" -> Gthemselves_NP 
      Just (i,[]) | i == mkCId "yourselfPl_NP" -> GyourselfPl_NP 
      Just (i,[]) | i == mkCId "yourselfSg_NP" -> GyourselfSg_NP 


      _ -> error ("no NP " ++ show t)

instance Gf GNum where
  gf (GNumCard x1) = mkApp (mkCId "NumCard") [gf x1]
  gf GNumPl = mkApp (mkCId "NumPl") []
  gf GNumSg = mkApp (mkCId "NumSg") []

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "NumCard" -> GNumCard (fg x1)
      Just (i,[]) | i == mkCId "NumPl" -> GNumPl 
      Just (i,[]) | i == mkCId "NumSg" -> GNumSg 


      _ -> error ("no Num " ++ show t)

instance Gf GOrd where
  gf (GOrdCompar x1) = mkApp (mkCId "OrdCompar") [gf x1]
  gf (GOrdDigits x1) = mkApp (mkCId "OrdDigits") [gf x1]
  gf (GOrdNumeral x1) = mkApp (mkCId "OrdNumeral") [gf x1]
  gf (GOrdSuperl x1) = mkApp (mkCId "OrdSuperl") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "OrdCompar" -> GOrdCompar (fg x1)
      Just (i,[x1]) | i == mkCId "OrdDigits" -> GOrdDigits (fg x1)
      Just (i,[x1]) | i == mkCId "OrdNumeral" -> GOrdNumeral (fg x1)
      Just (i,[x1]) | i == mkCId "OrdSuperl" -> GOrdSuperl (fg x1)


      _ -> error ("no Ord " ++ show t)

instance Gf GPConj where
  gf GNoPConj = mkApp (mkCId "NoPConj") []
  gf (GPConjConj x1) = mkApp (mkCId "PConjConj") [gf x1]

  fg t =
    case unApp t of
      Just (i,[]) | i == mkCId "NoPConj" -> GNoPConj 
      Just (i,[x1]) | i == mkCId "PConjConj" -> GPConjConj (fg x1)


      _ -> error ("no PConj " ++ show t)

instance Gf GPN where
  gf (GSymbPN x1) = mkApp (mkCId "SymbPN") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "SymbPN" -> GSymbPN (fg x1)


      _ -> error ("no PN " ++ show t)

instance Gf GPhr where
  gf (GPhrUtt x1 x2 x3) = mkApp (mkCId "PhrUtt") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3]) | i == mkCId "PhrUtt" -> GPhrUtt (fg x1) (fg x2) (fg x3)


      _ -> error ("no Phr " ++ show t)

instance Gf GPol where
  gf GPNeg = mkApp (mkCId "PNeg") []
  gf GPPos = mkApp (mkCId "PPos") []

  fg t =
    case unApp t of
      Just (i,[]) | i == mkCId "PNeg" -> GPNeg 
      Just (i,[]) | i == mkCId "PPos" -> GPPos 


      _ -> error ("no Pol " ++ show t)

instance Gf GPrAP_none where
  gf (GAgentPastPartAP_none x1 x2) = mkApp (mkCId "AgentPastPartAP_none") [gf x1, gf x2]
  gf (GLiftAP x1) = mkApp (mkCId "LiftAP") [gf x1]
  gf (GPastPartAP_none x1) = mkApp (mkCId "PastPartAP_none") [gf x1]
  gf (GPresPartAP_none x1) = mkApp (mkCId "PresPartAP_none") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AgentPastPartAP_none" -> GAgentPastPartAP_none (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "LiftAP" -> GLiftAP (fg x1)
      Just (i,[x1]) | i == mkCId "PastPartAP_none" -> GPastPartAP_none (fg x1)
      Just (i,[x1]) | i == mkCId "PresPartAP_none" -> GPresPartAP_none (fg x1)


      _ -> error ("no PrAP_none " ++ show t)

instance Gf GPrAP_np where
  gf (GLiftA2 x1) = mkApp (mkCId "LiftA2") [gf x1]
  gf (GPresPartAP_np x1) = mkApp (mkCId "PresPartAP_np") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftA2" -> GLiftA2 (fg x1)
      Just (i,[x1]) | i == mkCId "PresPartAP_np" -> GPresPartAP_np (fg x1)


      _ -> error ("no PrAP_np " ++ show t)

instance Gf GPrAdv_none where
  gf (GComplAdv_none x1 x2) = mkApp (mkCId "ComplAdv_none") [gf x1, gf x2]
  gf (GLiftAdV x1) = mkApp (mkCId "LiftAdV") [gf x1]
  gf (GLiftAdv x1) = mkApp (mkCId "LiftAdv") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "ComplAdv_none" -> GComplAdv_none (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "LiftAdV" -> GLiftAdV (fg x1)
      Just (i,[x1]) | i == mkCId "LiftAdv" -> GLiftAdv (fg x1)


      _ -> error ("no PrAdv_none " ++ show t)

instance Gf GPrAdv_np where
  gf (GLiftPrep x1) = mkApp (mkCId "LiftPrep") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftPrep" -> GLiftPrep (fg x1)


      _ -> error ("no PrAdv_np " ++ show t)

instance Gf GPrCN_none where
  gf (GLiftCN x1) = mkApp (mkCId "LiftCN") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftCN" -> GLiftCN (fg x1)


      _ -> error ("no PrCN_none " ++ show t)

instance Gf GPrCN_np where
  gf (GLiftN2 x1) = mkApp (mkCId "LiftN2") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftN2" -> GLiftN2 (fg x1)


      _ -> error ("no PrCN_np " ++ show t)

instance Gf GPrCl_none where
  gf (GAdvCl_none x1 x2) = mkApp (mkCId "AdvCl_none") [gf x1, gf x2]
  gf (GPredVP_none x1 x2) = mkApp (mkCId "PredVP_none") [gf x1, gf x2]
  gf (GSlashClNP_none x1 x2) = mkApp (mkCId "SlashClNP_none") [gf x1, gf x2]
  gf (GUseClC_none x1) = mkApp (mkCId "UseClC_none") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdvCl_none" -> GAdvCl_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PredVP_none" -> GPredVP_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashClNP_none" -> GSlashClNP_none (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "UseClC_none" -> GUseClC_none (fg x1)


      _ -> error ("no PrCl_none " ++ show t)

instance Gf GPrCl_np where
  gf (GAdvCl_np x1 x2) = mkApp (mkCId "AdvCl_np") [gf x1, gf x2]
  gf (GPredVP_np x1 x2) = mkApp (mkCId "PredVP_np") [gf x1, gf x2]
  gf (GUseClC_np x1) = mkApp (mkCId "UseClC_np") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdvCl_np" -> GAdvCl_np (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PredVP_np" -> GPredVP_np (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "UseClC_np" -> GUseClC_np (fg x1)


      _ -> error ("no PrCl_np " ++ show t)

instance Gf GPrQCl_none where
  gf (GAdvQCl_none x1 x2) = mkApp (mkCId "AdvQCl_none") [gf x1, gf x2]
  gf (GQuestCl_none x1) = mkApp (mkCId "QuestCl_none") [gf x1]
  gf (GQuestIAdv_none x1 x2) = mkApp (mkCId "QuestIAdv_none") [gf x1, gf x2]
  gf (GQuestIComp_none x1 x2 x3 x4 x5) = mkApp (mkCId "QuestIComp_none") [gf x1, gf x2, gf x3, gf x4, gf x5]
  gf (GQuestSlash_none x1 x2) = mkApp (mkCId "QuestSlash_none") [gf x1, gf x2]
  gf (GQuestVP_none x1 x2) = mkApp (mkCId "QuestVP_none") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdvQCl_none" -> GAdvQCl_none (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "QuestCl_none" -> GQuestCl_none (fg x1)
      Just (i,[x1,x2]) | i == mkCId "QuestIAdv_none" -> GQuestIAdv_none (fg x1) (fg x2)
      Just (i,[x1,x2,x3,x4,x5]) | i == mkCId "QuestIComp_none" -> GQuestIComp_none (fg x1) (fg x2) (fg x3) (fg x4) (fg x5)
      Just (i,[x1,x2]) | i == mkCId "QuestSlash_none" -> GQuestSlash_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "QuestVP_none" -> GQuestVP_none (fg x1) (fg x2)


      _ -> error ("no PrQCl_none " ++ show t)

instance Gf GPrQCl_np where
  gf (GAdvQCl_np x1 x2) = mkApp (mkCId "AdvQCl_np") [gf x1, gf x2]
  gf (GQuestCl_np x1) = mkApp (mkCId "QuestCl_np") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdvQCl_np" -> GAdvQCl_np (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "QuestCl_np" -> GQuestCl_np (fg x1)


      _ -> error ("no PrQCl_np " ++ show t)

instance Gf GPrS where
  gf (GUseAdvCl_none x1 x2) = mkApp (mkCId "UseAdvCl_none") [gf x1, gf x2]
  gf (GUseCl_none x1) = mkApp (mkCId "UseCl_none") [gf x1]
  gf (GUseQCl_none x1) = mkApp (mkCId "UseQCl_none") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "UseAdvCl_none" -> GUseAdvCl_none (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "UseCl_none" -> GUseCl_none (fg x1)
      Just (i,[x1]) | i == mkCId "UseQCl_none" -> GUseQCl_none (fg x1)


      _ -> error ("no PrS " ++ show t)

instance Gf GPrVPI_none where
  gf (GInfVP_none x1) = mkApp (mkCId "InfVP_none") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "InfVP_none" -> GInfVP_none (fg x1)


      _ -> error ("no PrVPI_none " ++ show t)

instance Gf GPrVPI_np where
  gf (GInfVP_np x1) = mkApp (mkCId "InfVP_np") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "InfVP_np" -> GInfVP_np (fg x1)


      _ -> error ("no PrVPI_np " ++ show t)

instance Gf GPrVP_a where
  gf (GAgentPassUseV_a x1 x2 x3 x4 x5) = mkApp (mkCId "AgentPassUseV_a") [gf x1, gf x2, gf x3, gf x4, gf x5]
  gf (GPassUseV_a x1 x2 x3 x4) = mkApp (mkCId "PassUseV_a") [gf x1, gf x2, gf x3, gf x4]
  gf (GReflVP_a x1) = mkApp (mkCId "ReflVP_a") [gf x1]
  gf (GUseV_a x1 x2 x3 x4) = mkApp (mkCId "UseV_a") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4,x5]) | i == mkCId "AgentPassUseV_a" -> GAgentPassUseV_a (fg x1) (fg x2) (fg x3) (fg x4) (fg x5)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "PassUseV_a" -> GPassUseV_a (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1]) | i == mkCId "ReflVP_a" -> GReflVP_a (fg x1)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_a" -> GUseV_a (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_a " ++ show t)

instance Gf GPrVP_n where
  gf (GAgentPassUseV_n x1 x2 x3 x4 x5) = mkApp (mkCId "AgentPassUseV_n") [gf x1, gf x2, gf x3, gf x4, gf x5]
  gf (GPassUseV_n x1 x2 x3 x4) = mkApp (mkCId "PassUseV_n") [gf x1, gf x2, gf x3, gf x4]
  gf (GReflVP_n x1) = mkApp (mkCId "ReflVP_n") [gf x1]
  gf (GUseV_n x1 x2 x3 x4) = mkApp (mkCId "UseV_n") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4,x5]) | i == mkCId "AgentPassUseV_n" -> GAgentPassUseV_n (fg x1) (fg x2) (fg x3) (fg x4) (fg x5)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "PassUseV_n" -> GPassUseV_n (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1]) | i == mkCId "ReflVP_n" -> GReflVP_n (fg x1)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_n" -> GUseV_n (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_n " ++ show t)

instance Gf GPrVP_none where
  gf (GAfterVP_none x1 x2) = mkApp (mkCId "AfterVP_none") [gf x1, gf x2]
  gf (GAgentPassUseV_none x1 x2 x3 x4 x5) = mkApp (mkCId "AgentPassUseV_none") [gf x1, gf x2, gf x3, gf x4, gf x5]
  gf (GBeforeVP_none x1 x2) = mkApp (mkCId "BeforeVP_none") [gf x1, gf x2]
  gf (GByVP_none x1 x2) = mkApp (mkCId "ByVP_none") [gf x1, gf x2]
  gf (GComplV2_none x1 x2) = mkApp (mkCId "ComplV2_none") [gf x1, gf x2]
  gf (GComplVA_none x1 x2) = mkApp (mkCId "ComplVA_none") [gf x1, gf x2]
  gf (GComplVN_none x1 x2) = mkApp (mkCId "ComplVN_none") [gf x1, gf x2]
  gf (GComplVQ_none x1 x2) = mkApp (mkCId "ComplVQ_none") [gf x1, gf x2]
  gf (GComplVS_none x1 x2) = mkApp (mkCId "ComplVS_none") [gf x1, gf x2]
  gf (GComplVV_none x1 x2) = mkApp (mkCId "ComplVV_none") [gf x1, gf x2]
  gf (GInOrderVP_none x1 x2) = mkApp (mkCId "InOrderVP_none") [gf x1, gf x2]
  gf (GPassUseV_none x1 x2 x3 x4) = mkApp (mkCId "PassUseV_none") [gf x1, gf x2, gf x3, gf x4]
  gf (GReflVP_none x1) = mkApp (mkCId "ReflVP_none") [gf x1]
  gf (GUseAP_none x1 x2 x3 x4) = mkApp (mkCId "UseAP_none") [gf x1, gf x2, gf x3, gf x4]
  gf (GUseAdv_none x1 x2 x3 x4) = mkApp (mkCId "UseAdv_none") [gf x1, gf x2, gf x3, gf x4]
  gf (GUseCN_none x1 x2 x3 x4) = mkApp (mkCId "UseCN_none") [gf x1, gf x2, gf x3, gf x4]
  gf (GUseNP_none x1 x2 x3 x4) = mkApp (mkCId "UseNP_none") [gf x1, gf x2, gf x3, gf x4]
  gf (GUseQ_none x1 x2 x3 x4) = mkApp (mkCId "UseQ_none") [gf x1, gf x2, gf x3, gf x4]
  gf (GUseS_none x1 x2 x3 x4) = mkApp (mkCId "UseS_none") [gf x1, gf x2, gf x3, gf x4]
  gf (GUseVPC_none x1) = mkApp (mkCId "UseVPC_none") [gf x1]
  gf (GUseVP_none x1 x2 x3 x4) = mkApp (mkCId "UseVP_none") [gf x1, gf x2, gf x3, gf x4]
  gf (GUseV_none x1 x2 x3 x4) = mkApp (mkCId "UseV_none") [gf x1, gf x2, gf x3, gf x4]
  gf (GWhenVP_none x1 x2) = mkApp (mkCId "WhenVP_none") [gf x1, gf x2]
  gf (GWithoutVP_none x1 x2) = mkApp (mkCId "WithoutVP_none") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AfterVP_none" -> GAfterVP_none (fg x1) (fg x2)
      Just (i,[x1,x2,x3,x4,x5]) | i == mkCId "AgentPassUseV_none" -> GAgentPassUseV_none (fg x1) (fg x2) (fg x3) (fg x4) (fg x5)
      Just (i,[x1,x2]) | i == mkCId "BeforeVP_none" -> GBeforeVP_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ByVP_none" -> GByVP_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplV2_none" -> GComplV2_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplVA_none" -> GComplVA_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplVN_none" -> GComplVN_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplVQ_none" -> GComplVQ_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplVS_none" -> GComplVS_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplVV_none" -> GComplVV_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "InOrderVP_none" -> GInOrderVP_none (fg x1) (fg x2)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "PassUseV_none" -> GPassUseV_none (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1]) | i == mkCId "ReflVP_none" -> GReflVP_none (fg x1)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseAP_none" -> GUseAP_none (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseAdv_none" -> GUseAdv_none (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseCN_none" -> GUseCN_none (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseNP_none" -> GUseNP_none (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseQ_none" -> GUseQ_none (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseS_none" -> GUseS_none (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1]) | i == mkCId "UseVPC_none" -> GUseVPC_none (fg x1)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseVP_none" -> GUseVP_none (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_none" -> GUseV_none (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2]) | i == mkCId "WhenVP_none" -> GWhenVP_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "WithoutVP_none" -> GWithoutVP_none (fg x1) (fg x2)


      _ -> error ("no PrVP_none " ++ show t)

instance Gf GPrVP_np where
  gf (GAgentPassUseV_np x1 x2 x3 x4 x5) = mkApp (mkCId "AgentPassUseV_np") [gf x1, gf x2, gf x3, gf x4, gf x5]
  gf (GComplVS_np x1 x2) = mkApp (mkCId "ComplVS_np") [gf x1, gf x2]
  gf (GComplVV_np x1 x2) = mkApp (mkCId "ComplVV_np") [gf x1, gf x2]
  gf (GPassUseV_np x1 x2 x3 x4) = mkApp (mkCId "PassUseV_np") [gf x1, gf x2, gf x3, gf x4]
  gf (GReflVP2_np x1) = mkApp (mkCId "ReflVP2_np") [gf x1]
  gf (GReflVP_np x1) = mkApp (mkCId "ReflVP_np") [gf x1]
  gf (GSlashV2A_none x1 x2) = mkApp (mkCId "SlashV2A_none") [gf x1, gf x2]
  gf (GSlashV2N_none x1 x2) = mkApp (mkCId "SlashV2N_none") [gf x1, gf x2]
  gf (GSlashV2Q_none x1 x2) = mkApp (mkCId "SlashV2Q_none") [gf x1, gf x2]
  gf (GSlashV2S_none x1 x2) = mkApp (mkCId "SlashV2S_none") [gf x1, gf x2]
  gf (GSlashV2V_none x1 x2) = mkApp (mkCId "SlashV2V_none") [gf x1, gf x2]
  gf (GSlashV3_none x1 x2) = mkApp (mkCId "SlashV3_none") [gf x1, gf x2]
  gf (GUseAP_np x1 x2 x3 x4) = mkApp (mkCId "UseAP_np") [gf x1, gf x2, gf x3, gf x4]
  gf (GUseAdv_np x1 x2 x3 x4) = mkApp (mkCId "UseAdv_np") [gf x1, gf x2, gf x3, gf x4]
  gf (GUseCN_np x1 x2 x3 x4) = mkApp (mkCId "UseCN_np") [gf x1, gf x2, gf x3, gf x4]
  gf (GUseVPC_np x1) = mkApp (mkCId "UseVPC_np") [gf x1]
  gf (GUseV_np x1 x2 x3 x4) = mkApp (mkCId "UseV_np") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4,x5]) | i == mkCId "AgentPassUseV_np" -> GAgentPassUseV_np (fg x1) (fg x2) (fg x3) (fg x4) (fg x5)
      Just (i,[x1,x2]) | i == mkCId "ComplVS_np" -> GComplVS_np (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplVV_np" -> GComplVV_np (fg x1) (fg x2)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "PassUseV_np" -> GPassUseV_np (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1]) | i == mkCId "ReflVP2_np" -> GReflVP2_np (fg x1)
      Just (i,[x1]) | i == mkCId "ReflVP_np" -> GReflVP_np (fg x1)
      Just (i,[x1,x2]) | i == mkCId "SlashV2A_none" -> GSlashV2A_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashV2N_none" -> GSlashV2N_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashV2Q_none" -> GSlashV2Q_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashV2S_none" -> GSlashV2S_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashV2V_none" -> GSlashV2V_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashV3_none" -> GSlashV3_none (fg x1) (fg x2)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseAP_np" -> GUseAP_np (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseAdv_np" -> GUseAdv_np (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseCN_np" -> GUseCN_np (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1]) | i == mkCId "UseVPC_np" -> GUseVPC_np (fg x1)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_np" -> GUseV_np (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_np " ++ show t)

instance Gf GPrVP_np_a where
  gf (GUseV_np_a x1 x2 x3 x4) = mkApp (mkCId "UseV_np_a") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_np_a" -> GUseV_np_a (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_np_a " ++ show t)

instance Gf GPrVP_np_n where
  gf (GUseV_np_n x1 x2 x3 x4) = mkApp (mkCId "UseV_np_n") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_np_n" -> GUseV_np_n (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_np_n " ++ show t)

instance Gf GPrVP_np_np where
  gf (GSlashV2V_np x1 x2) = mkApp (mkCId "SlashV2V_np") [gf x1, gf x2]
  gf (GUseV_np_np x1 x2 x3 x4) = mkApp (mkCId "UseV_np_np") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "SlashV2V_np" -> GSlashV2V_np (fg x1) (fg x2)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_np_np" -> GUseV_np_np (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_np_np " ++ show t)

instance Gf GPrVP_np_q where
  gf (GUseV_np_q x1 x2 x3 x4) = mkApp (mkCId "UseV_np_q") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_np_q" -> GUseV_np_q (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_np_q " ++ show t)

instance Gf GPrVP_np_s where
  gf (GUseV_np_s x1 x2 x3 x4) = mkApp (mkCId "UseV_np_s") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_np_s" -> GUseV_np_s (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_np_s " ++ show t)

instance Gf GPrVP_np_v where
  gf (GUseV_np_v x1 x2 x3 x4) = mkApp (mkCId "UseV_np_v") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_np_v" -> GUseV_np_v (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_np_v " ++ show t)

instance Gf GPrVP_q where
  gf (GAgentPassUseV_q x1 x2 x3 x4 x5) = mkApp (mkCId "AgentPassUseV_q") [gf x1, gf x2, gf x3, gf x4, gf x5]
  gf (GPassUseV_q x1 x2 x3 x4) = mkApp (mkCId "PassUseV_q") [gf x1, gf x2, gf x3, gf x4]
  gf (GReflVP_q x1) = mkApp (mkCId "ReflVP_q") [gf x1]
  gf (GUseV_q x1 x2 x3 x4) = mkApp (mkCId "UseV_q") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4,x5]) | i == mkCId "AgentPassUseV_q" -> GAgentPassUseV_q (fg x1) (fg x2) (fg x3) (fg x4) (fg x5)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "PassUseV_q" -> GPassUseV_q (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1]) | i == mkCId "ReflVP_q" -> GReflVP_q (fg x1)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_q" -> GUseV_q (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_q " ++ show t)

instance Gf GPrVP_s where
  gf (GAgentPassUseV_s x1 x2 x3 x4 x5) = mkApp (mkCId "AgentPassUseV_s") [gf x1, gf x2, gf x3, gf x4, gf x5]
  gf (GPassUseV_s x1 x2 x3 x4) = mkApp (mkCId "PassUseV_s") [gf x1, gf x2, gf x3, gf x4]
  gf (GReflVP_s x1) = mkApp (mkCId "ReflVP_s") [gf x1]
  gf (GUseV_s x1 x2 x3 x4) = mkApp (mkCId "UseV_s") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4,x5]) | i == mkCId "AgentPassUseV_s" -> GAgentPassUseV_s (fg x1) (fg x2) (fg x3) (fg x4) (fg x5)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "PassUseV_s" -> GPassUseV_s (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1]) | i == mkCId "ReflVP_s" -> GReflVP_s (fg x1)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_s" -> GUseV_s (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_s " ++ show t)

instance Gf GPrVP_v where
  gf (GAgentPassUseV_v x1 x2 x3 x4 x5) = mkApp (mkCId "AgentPassUseV_v") [gf x1, gf x2, gf x3, gf x4, gf x5]
  gf (GPassUseV_v x1 x2 x3 x4) = mkApp (mkCId "PassUseV_v") [gf x1, gf x2, gf x3, gf x4]
  gf (GReflVP_v x1) = mkApp (mkCId "ReflVP_v") [gf x1]
  gf (GUseV_v x1 x2 x3 x4) = mkApp (mkCId "UseV_v") [gf x1, gf x2, gf x3, gf x4]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3,x4,x5]) | i == mkCId "AgentPassUseV_v" -> GAgentPassUseV_v (fg x1) (fg x2) (fg x3) (fg x4) (fg x5)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "PassUseV_v" -> GPassUseV_v (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1]) | i == mkCId "ReflVP_v" -> GReflVP_v (fg x1)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "UseV_v" -> GUseV_v (fg x1) (fg x2) (fg x3) (fg x4)


      _ -> error ("no PrVP_v " ++ show t)

instance Gf GPrV_a where
  gf (GLiftVA x1) = mkApp (mkCId "LiftVA") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftVA" -> GLiftVA (fg x1)


      _ -> error ("no PrV_a " ++ show t)

instance Gf GPrV_n where
  gf (GLiftVN x1) = mkApp (mkCId "LiftVN") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftVN" -> GLiftVN (fg x1)


      _ -> error ("no PrV_n " ++ show t)

instance Gf GPrV_none where
  gf (GLiftV x1) = mkApp (mkCId "LiftV") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftV" -> GLiftV (fg x1)


      _ -> error ("no PrV_none " ++ show t)

instance Gf GPrV_np where
  gf (GLiftV2 x1) = mkApp (mkCId "LiftV2") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftV2" -> GLiftV2 (fg x1)


      _ -> error ("no PrV_np " ++ show t)

instance Gf GPrV_np_a where
  gf (GLiftV2A x1) = mkApp (mkCId "LiftV2A") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftV2A" -> GLiftV2A (fg x1)


      _ -> error ("no PrV_np_a " ++ show t)

instance Gf GPrV_np_n where
  gf (GLiftV2N x1) = mkApp (mkCId "LiftV2N") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftV2N" -> GLiftV2N (fg x1)


      _ -> error ("no PrV_np_n " ++ show t)

instance Gf GPrV_np_np where
  gf (GLiftV3 x1) = mkApp (mkCId "LiftV3") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftV3" -> GLiftV3 (fg x1)


      _ -> error ("no PrV_np_np " ++ show t)

instance Gf GPrV_np_q where
  gf (GLiftV2Q x1) = mkApp (mkCId "LiftV2Q") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftV2Q" -> GLiftV2Q (fg x1)


      _ -> error ("no PrV_np_q " ++ show t)

instance Gf GPrV_np_s where
  gf (GLiftV2S x1) = mkApp (mkCId "LiftV2S") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftV2S" -> GLiftV2S (fg x1)


      _ -> error ("no PrV_np_s " ++ show t)

instance Gf GPrV_np_v where
  gf (GLiftV2V x1) = mkApp (mkCId "LiftV2V") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftV2V" -> GLiftV2V (fg x1)


      _ -> error ("no PrV_np_v " ++ show t)

instance Gf GPrV_q where
  gf (GLiftVQ x1) = mkApp (mkCId "LiftVQ") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftVQ" -> GLiftVQ (fg x1)


      _ -> error ("no PrV_q " ++ show t)

instance Gf GPrV_s where
  gf (GLiftVS x1) = mkApp (mkCId "LiftVS") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftVS" -> GLiftVS (fg x1)


      _ -> error ("no PrV_s " ++ show t)

instance Gf GPrV_v where
  gf (GLiftVV x1) = mkApp (mkCId "LiftVV") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "LiftVV" -> GLiftVV (fg x1)


      _ -> error ("no PrV_v " ++ show t)

instance Gf GQCl where
  gf (GQuestCl x1) = mkApp (mkCId "QuestCl") [gf x1]
  gf (GQuestIAdv x1 x2) = mkApp (mkCId "QuestIAdv") [gf x1, gf x2]
  gf (GQuestIComp x1 x2) = mkApp (mkCId "QuestIComp") [gf x1, gf x2]
  gf (GQuestQVP x1 x2) = mkApp (mkCId "QuestQVP") [gf x1, gf x2]
  gf (GQuestSlash x1 x2) = mkApp (mkCId "QuestSlash") [gf x1, gf x2]
  gf (GQuestVP x1 x2) = mkApp (mkCId "QuestVP") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "QuestCl" -> GQuestCl (fg x1)
      Just (i,[x1,x2]) | i == mkCId "QuestIAdv" -> GQuestIAdv (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "QuestIComp" -> GQuestIComp (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "QuestQVP" -> GQuestQVP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "QuestSlash" -> GQuestSlash (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "QuestVP" -> GQuestVP (fg x1) (fg x2)


      _ -> error ("no QCl " ++ show t)

instance Gf GQS where
  gf (GUseQCl x1 x2 x3) = mkApp (mkCId "UseQCl") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3]) | i == mkCId "UseQCl" -> GUseQCl (fg x1) (fg x2) (fg x3)


      _ -> error ("no QS " ++ show t)

instance Gf GQVP where
  gf (GAddAdvQVP x1 x2) = mkApp (mkCId "AddAdvQVP") [gf x1, gf x2]
  gf (GAdvQVP x1 x2) = mkApp (mkCId "AdvQVP") [gf x1, gf x2]
  gf (GComplSlashIP x1 x2) = mkApp (mkCId "ComplSlashIP") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AddAdvQVP" -> GAddAdvQVP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "AdvQVP" -> GAdvQVP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplSlashIP" -> GComplSlashIP (fg x1) (fg x2)


      _ -> error ("no QVP " ++ show t)

instance Gf GQuant where
  gf GDefArt = mkApp (mkCId "DefArt") []
  gf (GGenNP x1) = mkApp (mkCId "GenNP") [gf x1]
  gf GIndefArt = mkApp (mkCId "IndefArt") []
  gf (GPossPron x1) = mkApp (mkCId "PossPron") [gf x1]

  fg t =
    case unApp t of
      Just (i,[]) | i == mkCId "DefArt" -> GDefArt 
      Just (i,[x1]) | i == mkCId "GenNP" -> GGenNP (fg x1)
      Just (i,[]) | i == mkCId "IndefArt" -> GIndefArt 
      Just (i,[x1]) | i == mkCId "PossPron" -> GPossPron (fg x1)


      _ -> error ("no Quant " ++ show t)

instance Gf GRCl where
  gf (GEmptyRelSlash x1) = mkApp (mkCId "EmptyRelSlash") [gf x1]
  gf (GRelCl x1) = mkApp (mkCId "RelCl") [gf x1]
  gf (GRelSlash x1 x2) = mkApp (mkCId "RelSlash") [gf x1, gf x2]
  gf (GRelVP x1 x2) = mkApp (mkCId "RelVP") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "EmptyRelSlash" -> GEmptyRelSlash (fg x1)
      Just (i,[x1]) | i == mkCId "RelCl" -> GRelCl (fg x1)
      Just (i,[x1,x2]) | i == mkCId "RelSlash" -> GRelSlash (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "RelVP" -> GRelVP (fg x1) (fg x2)


      _ -> error ("no RCl " ++ show t)

instance Gf GRP where
  gf (GFunRP x1 x2 x3) = mkApp (mkCId "FunRP") [gf x1, gf x2, gf x3]
  gf (GGenRP x1 x2) = mkApp (mkCId "GenRP") [gf x1, gf x2]
  gf GIdRP = mkApp (mkCId "IdRP") []
  gf Gthat_RP = mkApp (mkCId "that_RP") []
  gf Gwho_RP = mkApp (mkCId "who_RP") []

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3]) | i == mkCId "FunRP" -> GFunRP (fg x1) (fg x2) (fg x3)
      Just (i,[x1,x2]) | i == mkCId "GenRP" -> GGenRP (fg x1) (fg x2)
      Just (i,[]) | i == mkCId "IdRP" -> GIdRP 
      Just (i,[]) | i == mkCId "that_RP" -> Gthat_RP 
      Just (i,[]) | i == mkCId "who_RP" -> Gwho_RP 


      _ -> error ("no RP " ++ show t)

instance Gf GRS where
  gf (GConjRS x1 x2) = mkApp (mkCId "ConjRS") [gf x1, gf x2]
  gf (GPastPartRS x1 x2 x3) = mkApp (mkCId "PastPartRS") [gf x1, gf x2, gf x3]
  gf (GPresPartRS x1 x2 x3) = mkApp (mkCId "PresPartRS") [gf x1, gf x2, gf x3]
  gf (GRelCl_none x1) = mkApp (mkCId "RelCl_none") [gf x1]
  gf (GRelSlash_none x1 x2) = mkApp (mkCId "RelSlash_none") [gf x1, gf x2]
  gf (GRelVP_none x1 x2) = mkApp (mkCId "RelVP_none") [gf x1, gf x2]
  gf (GUseRCl x1 x2 x3) = mkApp (mkCId "UseRCl") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "ConjRS" -> GConjRS (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "PastPartRS" -> GPastPartRS (fg x1) (fg x2) (fg x3)
      Just (i,[x1,x2,x3]) | i == mkCId "PresPartRS" -> GPresPartRS (fg x1) (fg x2) (fg x3)
      Just (i,[x1]) | i == mkCId "RelCl_none" -> GRelCl_none (fg x1)
      Just (i,[x1,x2]) | i == mkCId "RelSlash_none" -> GRelSlash_none (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "RelVP_none" -> GRelVP_none (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "UseRCl" -> GUseRCl (fg x1) (fg x2) (fg x3)


      _ -> error ("no RS " ++ show t)

instance Gf GS where
  gf (GAdvS x1 x2) = mkApp (mkCId "AdvS") [gf x1, gf x2]
  gf (GConjS x1 x2) = mkApp (mkCId "ConjS") [gf x1, gf x2]
  gf (GExtAdvS x1 x2) = mkApp (mkCId "ExtAdvS") [gf x1, gf x2]
  gf (GPredVPS x1 x2) = mkApp (mkCId "PredVPS") [gf x1, gf x2]
  gf (GRelS x1 x2) = mkApp (mkCId "RelS") [gf x1, gf x2]
  gf (GSSubjS x1 x2 x3) = mkApp (mkCId "SSubjS") [gf x1, gf x2, gf x3]
  gf (GUseCl x1 x2 x3) = mkApp (mkCId "UseCl") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdvS" -> GAdvS (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ConjS" -> GConjS (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ExtAdvS" -> GExtAdvS (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PredVPS" -> GPredVPS (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "RelS" -> GRelS (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "SSubjS" -> GSSubjS (fg x1) (fg x2) (fg x3)
      Just (i,[x1,x2,x3]) | i == mkCId "UseCl" -> GUseCl (fg x1) (fg x2) (fg x3)


      _ -> error ("no S " ++ show t)

instance Gf GSC where
  gf (GEmbedQS x1) = mkApp (mkCId "EmbedQS") [gf x1]
  gf (GEmbedS x1) = mkApp (mkCId "EmbedS") [gf x1]
  gf (GEmbedVP x1) = mkApp (mkCId "EmbedVP") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "EmbedQS" -> GEmbedQS (fg x1)
      Just (i,[x1]) | i == mkCId "EmbedS" -> GEmbedS (fg x1)
      Just (i,[x1]) | i == mkCId "EmbedVP" -> GEmbedVP (fg x1)


      _ -> error ("no SC " ++ show t)

instance Gf GSSlash where
  gf (GUseSlash x1 x2 x3) = mkApp (mkCId "UseSlash") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2,x3]) | i == mkCId "UseSlash" -> GUseSlash (fg x1) (fg x2) (fg x3)


      _ -> error ("no SSlash " ++ show t)

instance Gf GSymb where
  gf (GMkSymb x1) = mkApp (mkCId "MkSymb") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "MkSymb" -> GMkSymb (fg x1)


      _ -> error ("no Symb " ++ show t)

instance Gf GTemp where
  gf (GTTAnt x1 x2) = mkApp (mkCId "TTAnt") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "TTAnt" -> GTTAnt (fg x1) (fg x2)


      _ -> error ("no Temp " ++ show t)

instance Gf GTense where
  gf GTCond = mkApp (mkCId "TCond") []
  gf GTFut = mkApp (mkCId "TFut") []
  gf GTPast = mkApp (mkCId "TPast") []
  gf GTPres = mkApp (mkCId "TPres") []

  fg t =
    case unApp t of
      Just (i,[]) | i == mkCId "TCond" -> GTCond 
      Just (i,[]) | i == mkCId "TFut" -> GTFut 
      Just (i,[]) | i == mkCId "TPast" -> GTPast 
      Just (i,[]) | i == mkCId "TPres" -> GTPres 


      _ -> error ("no Tense " ++ show t)

instance Gf GUtt where
  gf (GPrImpPl x1) = mkApp (mkCId "PrImpPl") [gf x1]
  gf (GPrImpSg x1) = mkApp (mkCId "PrImpSg") [gf x1]
  gf (GUttAP x1) = mkApp (mkCId "UttAP") [gf x1]
  gf (GUttAdV x1) = mkApp (mkCId "UttAdV") [gf x1]
  gf (GUttAdv x1) = mkApp (mkCId "UttAdv") [gf x1]
  gf (GUttCN x1) = mkApp (mkCId "UttCN") [gf x1]
  gf (GUttCard x1) = mkApp (mkCId "UttCard") [gf x1]
  gf (GUttIAdv x1) = mkApp (mkCId "UttIAdv") [gf x1]
  gf (GUttIP x1) = mkApp (mkCId "UttIP") [gf x1]
  gf (GUttImpPl x1 x2) = mkApp (mkCId "UttImpPl") [gf x1, gf x2]
  gf (GUttImpPol x1 x2) = mkApp (mkCId "UttImpPol") [gf x1, gf x2]
  gf (GUttImpSg x1 x2) = mkApp (mkCId "UttImpSg") [gf x1, gf x2]
  gf (GUttInterj x1) = mkApp (mkCId "UttInterj") [gf x1]
  gf (GUttNP x1) = mkApp (mkCId "UttNP") [gf x1]
  gf (GUttPrS x1) = mkApp (mkCId "UttPrS") [gf x1]
  gf (GUttQS x1) = mkApp (mkCId "UttQS") [gf x1]
  gf (GUttS x1) = mkApp (mkCId "UttS") [gf x1]
  gf (GUttVP x1) = mkApp (mkCId "UttVP") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1]) | i == mkCId "PrImpPl" -> GPrImpPl (fg x1)
      Just (i,[x1]) | i == mkCId "PrImpSg" -> GPrImpSg (fg x1)
      Just (i,[x1]) | i == mkCId "UttAP" -> GUttAP (fg x1)
      Just (i,[x1]) | i == mkCId "UttAdV" -> GUttAdV (fg x1)
      Just (i,[x1]) | i == mkCId "UttAdv" -> GUttAdv (fg x1)
      Just (i,[x1]) | i == mkCId "UttCN" -> GUttCN (fg x1)
      Just (i,[x1]) | i == mkCId "UttCard" -> GUttCard (fg x1)
      Just (i,[x1]) | i == mkCId "UttIAdv" -> GUttIAdv (fg x1)
      Just (i,[x1]) | i == mkCId "UttIP" -> GUttIP (fg x1)
      Just (i,[x1,x2]) | i == mkCId "UttImpPl" -> GUttImpPl (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "UttImpPol" -> GUttImpPol (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "UttImpSg" -> GUttImpSg (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "UttInterj" -> GUttInterj (fg x1)
      Just (i,[x1]) | i == mkCId "UttNP" -> GUttNP (fg x1)
      Just (i,[x1]) | i == mkCId "UttPrS" -> GUttPrS (fg x1)
      Just (i,[x1]) | i == mkCId "UttQS" -> GUttQS (fg x1)
      Just (i,[x1]) | i == mkCId "UttS" -> GUttS (fg x1)
      Just (i,[x1]) | i == mkCId "UttVP" -> GUttVP (fg x1)


      _ -> error ("no Utt " ++ show t)

instance Gf GVP where
  gf (GAdVVP x1 x2) = mkApp (mkCId "AdVVP") [gf x1, gf x2]
  gf (GAdvVP x1 x2) = mkApp (mkCId "AdvVP") [gf x1, gf x2]
  gf (GComplBareVS x1 x2) = mkApp (mkCId "ComplBareVS") [gf x1, gf x2]
  gf (GComplSlash x1 x2) = mkApp (mkCId "ComplSlash") [gf x1, gf x2]
  gf (GComplSlashPartLast x1 x2) = mkApp (mkCId "ComplSlashPartLast") [gf x1, gf x2]
  gf (GComplVA x1 x2) = mkApp (mkCId "ComplVA") [gf x1, gf x2]
  gf (GComplVPIVV x1 x2) = mkApp (mkCId "ComplVPIVV") [gf x1, gf x2]
  gf (GComplVQ x1 x2) = mkApp (mkCId "ComplVQ") [gf x1, gf x2]
  gf (GComplVS x1 x2) = mkApp (mkCId "ComplVS") [gf x1, gf x2]
  gf (GComplVV x1 x2 x3 x4) = mkApp (mkCId "ComplVV") [gf x1, gf x2, gf x3, gf x4]
  gf (GExtAdvVP x1 x2) = mkApp (mkCId "ExtAdvVP") [gf x1, gf x2]
  gf (GPassAgentVPSlash x1 x2) = mkApp (mkCId "PassAgentVPSlash") [gf x1, gf x2]
  gf (GPassVPSlash x1) = mkApp (mkCId "PassVPSlash") [gf x1]
  gf (GProgrVP x1) = mkApp (mkCId "ProgrVP") [gf x1]
  gf (GReflVP x1) = mkApp (mkCId "ReflVP") [gf x1]
  gf (GSelfAdVVP x1) = mkApp (mkCId "SelfAdVVP") [gf x1]
  gf (GSelfAdvVP x1) = mkApp (mkCId "SelfAdvVP") [gf x1]
  gf (GUseComp x1) = mkApp (mkCId "UseComp") [gf x1]
  gf (GUseV x1) = mkApp (mkCId "UseV") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdVVP" -> GAdVVP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "AdvVP" -> GAdvVP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplBareVS" -> GComplBareVS (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplSlash" -> GComplSlash (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplSlashPartLast" -> GComplSlashPartLast (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplVA" -> GComplVA (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplVPIVV" -> GComplVPIVV (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplVQ" -> GComplVQ (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "ComplVS" -> GComplVS (fg x1) (fg x2)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "ComplVV" -> GComplVV (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2]) | i == mkCId "ExtAdvVP" -> GExtAdvVP (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "PassAgentVPSlash" -> GPassAgentVPSlash (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "PassVPSlash" -> GPassVPSlash (fg x1)
      Just (i,[x1]) | i == mkCId "ProgrVP" -> GProgrVP (fg x1)
      Just (i,[x1]) | i == mkCId "ReflVP" -> GReflVP (fg x1)
      Just (i,[x1]) | i == mkCId "SelfAdVVP" -> GSelfAdVVP (fg x1)
      Just (i,[x1]) | i == mkCId "SelfAdvVP" -> GSelfAdvVP (fg x1)
      Just (i,[x1]) | i == mkCId "UseComp" -> GUseComp (fg x1)
      Just (i,[x1]) | i == mkCId "UseV" -> GUseV (fg x1)


      _ -> error ("no VP " ++ show t)

instance Gf GVPC_none where
  gf (GContVPC_none x1 x2) = mkApp (mkCId "ContVPC_none") [gf x1, gf x2]
  gf (GStartVPC_none x1 x2 x3) = mkApp (mkCId "StartVPC_none") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "ContVPC_none" -> GContVPC_none (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "StartVPC_none" -> GStartVPC_none (fg x1) (fg x2) (fg x3)


      _ -> error ("no VPC_none " ++ show t)

instance Gf GVPC_np where
  gf (GContVPC_np x1 x2) = mkApp (mkCId "ContVPC_np") [gf x1, gf x2]
  gf (GStartVPC_np x1 x2 x3) = mkApp (mkCId "StartVPC_np") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "ContVPC_np" -> GContVPC_np (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "StartVPC_np" -> GStartVPC_np (fg x1) (fg x2) (fg x3)


      _ -> error ("no VPC_np " ++ show t)

instance Gf GVPI where
  gf (GConjVPI x1 x2) = mkApp (mkCId "ConjVPI") [gf x1, gf x2]
  gf (GMkVPI x1) = mkApp (mkCId "MkVPI") [gf x1]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "ConjVPI" -> GConjVPI (fg x1) (fg x2)
      Just (i,[x1]) | i == mkCId "MkVPI" -> GMkVPI (fg x1)


      _ -> error ("no VPI " ++ show t)

instance Gf GVPS where
  gf (GConjVPS x1 x2) = mkApp (mkCId "ConjVPS") [gf x1, gf x2]
  gf (GMkVPS x1 x2 x3) = mkApp (mkCId "MkVPS") [gf x1, gf x2, gf x3]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "ConjVPS" -> GConjVPS (fg x1) (fg x2)
      Just (i,[x1,x2,x3]) | i == mkCId "MkVPS" -> GMkVPS (fg x1) (fg x2) (fg x3)


      _ -> error ("no VPS " ++ show t)

instance Gf GVPSlash where
  gf (GAdVVPSlash x1 x2) = mkApp (mkCId "AdVVPSlash") [gf x1, gf x2]
  gf (GAdvVPSlash x1 x2) = mkApp (mkCId "AdvVPSlash") [gf x1, gf x2]
  gf (GSlash2V3 x1 x2) = mkApp (mkCId "Slash2V3") [gf x1, gf x2]
  gf (GSlash3V3 x1 x2) = mkApp (mkCId "Slash3V3") [gf x1, gf x2]
  gf (GSlashBareV2S x1 x2) = mkApp (mkCId "SlashBareV2S") [gf x1, gf x2]
  gf (GSlashSlashV2V x1 x2 x3 x4) = mkApp (mkCId "SlashSlashV2V") [gf x1, gf x2, gf x3, gf x4]
  gf (GSlashV2A x1 x2) = mkApp (mkCId "SlashV2A") [gf x1, gf x2]
  gf (GSlashV2Q x1 x2) = mkApp (mkCId "SlashV2Q") [gf x1, gf x2]
  gf (GSlashV2S x1 x2) = mkApp (mkCId "SlashV2S") [gf x1, gf x2]
  gf (GSlashV2V x1 x2 x3 x4) = mkApp (mkCId "SlashV2V") [gf x1, gf x2, gf x3, gf x4]
  gf (GSlashV2VNP x1 x2 x3) = mkApp (mkCId "SlashV2VNP") [gf x1, gf x2, gf x3]
  gf (GSlashV2a x1) = mkApp (mkCId "SlashV2a") [gf x1]
  gf (GSlashVPIV2V x1 x2 x3) = mkApp (mkCId "SlashVPIV2V") [gf x1, gf x2, gf x3]
  gf (GSlashVV x1 x2) = mkApp (mkCId "SlashVV") [gf x1, gf x2]
  gf (GVPSlashPrep x1 x2) = mkApp (mkCId "VPSlashPrep") [gf x1, gf x2]
  gf (GVPSlashVS x1 x2) = mkApp (mkCId "VPSlashVS") [gf x1, gf x2]

  fg t =
    case unApp t of
      Just (i,[x1,x2]) | i == mkCId "AdVVPSlash" -> GAdVVPSlash (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "AdvVPSlash" -> GAdvVPSlash (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "Slash2V3" -> GSlash2V3 (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "Slash3V3" -> GSlash3V3 (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashBareV2S" -> GSlashBareV2S (fg x1) (fg x2)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "SlashSlashV2V" -> GSlashSlashV2V (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2]) | i == mkCId "SlashV2A" -> GSlashV2A (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashV2Q" -> GSlashV2Q (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "SlashV2S" -> GSlashV2S (fg x1) (fg x2)
      Just (i,[x1,x2,x3,x4]) | i == mkCId "SlashV2V" -> GSlashV2V (fg x1) (fg x2) (fg x3) (fg x4)
      Just (i,[x1,x2,x3]) | i == mkCId "SlashV2VNP" -> GSlashV2VNP (fg x1) (fg x2) (fg x3)
      Just (i,[x1]) | i == mkCId "SlashV2a" -> GSlashV2a (fg x1)
      Just (i,[x1,x2,x3]) | i == mkCId "SlashVPIV2V" -> GSlashVPIV2V (fg x1) (fg x2) (fg x3)
      Just (i,[x1,x2]) | i == mkCId "SlashVV" -> GSlashVV (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "VPSlashPrep" -> GVPSlashPrep (fg x1) (fg x2)
      Just (i,[x1,x2]) | i == mkCId "VPSlashVS" -> GVPSlashVS (fg x1) (fg x2)


      _ -> error ("no VPSlash " ++ show t)

instance Gf GVoc where
  gf GNoVoc = mkApp (mkCId "NoVoc") []
  gf (GVocNP x1) = mkApp (mkCId "VocNP") [gf x1]

  fg t =
    case unApp t of
      Just (i,[]) | i == mkCId "NoVoc" -> GNoVoc 
      Just (i,[x1]) | i == mkCId "VocNP" -> GVocNP (fg x1)


      _ -> error ("no Voc " ++ show t)

instance Show GA

instance Gf GA where
  gf _ = undefined
  fg _ = undefined



instance Show GA2

instance Gf GA2 where
  gf _ = undefined
  fg _ = undefined



instance Show GCAdv

instance Gf GCAdv where
  gf _ = undefined
  fg _ = undefined



instance Show GConj

instance Gf GConj where
  gf _ = undefined
  fg _ = undefined



instance Show GDigits

instance Gf GDigits where
  gf _ = undefined
  fg _ = undefined



instance Show GIQuant

instance Gf GIQuant where
  gf _ = undefined
  fg _ = undefined



instance Show GInterj

instance Gf GInterj where
  gf _ = undefined
  fg _ = undefined



instance Show GN3

instance Gf GN3 where
  gf _ = undefined
  fg _ = undefined



instance Show GNumeral

instance Gf GNumeral where
  gf _ = undefined
  fg _ = undefined



instance Show GPredet

instance Gf GPredet where
  gf _ = undefined
  fg _ = undefined



instance Show GPrep

instance Gf GPrep where
  gf _ = undefined
  fg _ = undefined



instance Show GPron

instance Gf GPron where
  gf _ = undefined
  fg _ = undefined



instance Show GSubj

instance Gf GSubj where
  gf _ = undefined
  fg _ = undefined



instance Show GText

instance Gf GText where
  gf _ = undefined
  fg _ = undefined



instance Show GV

instance Gf GV where
  gf _ = undefined
  fg _ = undefined



instance Show GV2

instance Gf GV2 where
  gf _ = undefined
  fg _ = undefined



instance Show GV2A

instance Gf GV2A where
  gf _ = undefined
  fg _ = undefined



instance Show GV2Q

instance Gf GV2Q where
  gf _ = undefined
  fg _ = undefined



instance Show GV2S

instance Gf GV2S where
  gf _ = undefined
  fg _ = undefined



instance Show GV2V

instance Gf GV2V where
  gf _ = undefined
  fg _ = undefined



instance Show GV3

instance Gf GV3 where
  gf _ = undefined
  fg _ = undefined



instance Show GVA

instance Gf GVA where
  gf _ = undefined
  fg _ = undefined



instance Show GVQ

instance Gf GVQ where
  gf _ = undefined
  fg _ = undefined



instance Show GVS

instance Gf GVS where
  gf _ = undefined
  fg _ = undefined



instance Show GVV

instance Gf GVV where
  gf _ = undefined
  fg _ = undefined




instance Compos Tree where
  compos r a f t = case t of

    GEMeta m x1 -> r (GEMeta m) `a` foldr (a . a (r (:)) . f) (r []) x1

    GAdAP x1 x2 -> r GAdAP `a` f x1 `a` f x2
    GAdjOrd x1 -> r GAdjOrd `a` f x1
    GAdvAP x1 x2 -> r GAdvAP `a` f x1 `a` f x2
    GCAdvAP x1 x2 x3 -> r GCAdvAP `a` f x1 `a` f x2 `a` f x3
    GComparA x1 x2 -> r GComparA `a` f x1 `a` f x2
    GComplA2 x1 x2 -> r GComplA2 `a` f x1 `a` f x2
    GConjAP x1 x2 -> r GConjAP `a` f x1 `a` f x2
    GGerundAP x1 -> r GGerundAP `a` f x1
    GPastPartAP x1 -> r GPastPartAP `a` f x1
    GPositA x1 -> r GPositA `a` f x1
    GReflA2 x1 -> r GReflA2 `a` f x1
    GSentAP x1 x2 -> r GSentAP `a` f x1 `a` f x2
    GUseA2 x1 -> r GUseA2 `a` f x1
    GUseComparA x1 -> r GUseComparA `a` f x1
    GPositAdAAdj x1 -> r GPositAdAAdj `a` f x1
    GAdnCAdv x1 -> r GAdnCAdv `a` f x1
    GAdAdV x1 x2 -> r GAdAdV `a` f x1 `a` f x2
    GConjAdV x1 x2 -> r GConjAdV `a` f x1 `a` f x2
    GPositAdVAdj x1 -> r GPositAdVAdj `a` f x1
    GAdAdv x1 x2 -> r GAdAdv `a` f x1 `a` f x2
    GComparAdvAdj x1 x2 x3 -> r GComparAdvAdj `a` f x1 `a` f x2 `a` f x3
    GComparAdvAdjS x1 x2 x3 -> r GComparAdvAdjS `a` f x1 `a` f x2 `a` f x3
    GConjAdv x1 x2 -> r GConjAdv `a` f x1 `a` f x2
    GPositAdvAdj x1 -> r GPositAdvAdj `a` f x1
    GPrepNP x1 x2 -> r GPrepNP `a` f x1 `a` f x2
    GSubjS x1 x2 -> r GSubjS `a` f x1 `a` f x2
    GAdjCN x1 x2 -> r GAdjCN `a` f x1 `a` f x2
    GAdvCN x1 x2 -> r GAdvCN `a` f x1 `a` f x2
    GAppAPCN x1 x2 -> r GAppAPCN `a` f x1 `a` f x2
    GApposCN x1 x2 -> r GApposCN `a` f x1 `a` f x2
    GComplN2 x1 x2 -> r GComplN2 `a` f x1 `a` f x2
    GCompoundCN x1 x2 x3 -> r GCompoundCN `a` f x1 `a` f x2 `a` f x3
    GConjCN x1 x2 -> r GConjCN `a` f x1 `a` f x2
    GPartNP x1 x2 -> r GPartNP `a` f x1 `a` f x2
    GPossNP x1 x2 -> r GPossNP `a` f x1 `a` f x2
    GRelCN x1 x2 -> r GRelCN `a` f x1 `a` f x2
    GSentCN x1 x2 -> r GSentCN `a` f x1 `a` f x2
    GUseN x1 -> r GUseN `a` f x1
    GUseN2 x1 -> r GUseN2 `a` f x1
    GAdNum x1 x2 -> r GAdNum `a` f x1 `a` f x2
    GNumDigits x1 -> r GNumDigits `a` f x1
    GNumNumeral x1 -> r GNumNumeral `a` f x1
    GExistNP x1 -> r GExistNP `a` f x1
    GPredSCVP x1 x2 -> r GPredSCVP `a` f x1 `a` f x2
    GPredVP x1 x2 -> r GPredVP `a` f x1 `a` f x2
    GPredVPosv x1 x2 -> r GPredVPosv `a` f x1 `a` f x2
    GPredVPovs x1 x2 -> r GPredVPovs `a` f x1 `a` f x2
    GContClC_none x1 x2 -> r GContClC_none `a` f x1 `a` f x2
    GStartClC_none x1 x2 x3 -> r GStartClC_none `a` f x1 `a` f x2 `a` f x3
    GContClC_np x1 x2 -> r GContClC_np `a` f x1 `a` f x2
    GStartClC_np x1 x2 x3 -> r GStartClC_np `a` f x1 `a` f x2 `a` f x3
    GAdvSlash x1 x2 -> r GAdvSlash `a` f x1 `a` f x2
    GSlashPrep x1 x2 -> r GSlashPrep `a` f x1 `a` f x2
    GSlashVP x1 x2 -> r GSlashVP `a` f x1 `a` f x2
    GSlashVS x1 x2 x3 -> r GSlashVS `a` f x1 `a` f x2 `a` f x3
    GCompAP x1 -> r GCompAP `a` f x1
    GCompAdv x1 -> r GCompAdv `a` f x1
    GCompCN x1 -> r GCompCN `a` f x1
    GCompNP x1 -> r GCompNP `a` f x1
    GCompQS x1 -> r GCompQS `a` f x1
    GCompS x1 -> r GCompS `a` f x1
    GCompVP x1 x2 x3 -> r GCompVP `a` f x1 `a` f x2 `a` f x3
    GDetQuant x1 x2 -> r GDetQuant `a` f x1 `a` f x2
    GDetQuantOrd x1 x2 x3 -> r GDetQuantOrd `a` f x1 `a` f x2 `a` f x3
    GAdvIAdv x1 x2 -> r GAdvIAdv `a` f x1 `a` f x2
    GConjIAdv x1 x2 -> r GConjIAdv `a` f x1 `a` f x2
    GPrepIP x1 x2 -> r GPrepIP `a` f x1 `a` f x2
    GCompIAdv x1 -> r GCompIAdv `a` f x1
    GCompIP x1 -> r GCompIP `a` f x1
    GIdetQuant x1 x2 -> r GIdetQuant `a` f x1 `a` f x2
    GAdvIP x1 x2 -> r GAdvIP `a` f x1 `a` f x2
    GIdetCN x1 x2 -> r GIdetCN `a` f x1 `a` f x2
    GIdetIP x1 -> r GIdetIP `a` f x1
    GImpVP x1 -> r GImpVP `a` f x1
    GDashCN x1 x2 -> r GDashCN `a` f x1 `a` f x2
    GGerundN x1 -> r GGerundN `a` f x1
    GComplN3 x1 x2 -> r GComplN3 `a` f x1 `a` f x2
    GUse2N3 x1 -> r GUse2N3 `a` f x1
    GUse3N3 x1 -> r GUse3N3 `a` f x1
    GAdvNP x1 x2 -> r GAdvNP `a` f x1 `a` f x2
    GApposNP x1 x2 -> r GApposNP `a` f x1 `a` f x2
    GCNNumNP x1 x2 -> r GCNNumNP `a` f x1 `a` f x2
    GConjNP x1 x2 -> r GConjNP `a` f x1 `a` f x2
    GCountNP x1 x2 -> r GCountNP `a` f x1 `a` f x2
    GDetCN x1 x2 -> r GDetCN `a` f x1 `a` f x2
    GDetNP x1 -> r GDetNP `a` f x1
    GExtAdvNP x1 x2 -> r GExtAdvNP `a` f x1 `a` f x2
    GMassNP x1 -> r GMassNP `a` f x1
    GNomVPNP_none x1 -> r GNomVPNP_none `a` f x1
    GPPartNP x1 x2 -> r GPPartNP `a` f x1 `a` f x2
    GPredetNP x1 x2 -> r GPredetNP `a` f x1 `a` f x2
    GRelNP x1 x2 -> r GRelNP `a` f x1 `a` f x2
    GSelfNP x1 -> r GSelfNP `a` f x1
    GUsePN x1 -> r GUsePN `a` f x1
    GUsePron x1 -> r GUsePron `a` f x1
    GUseQuantPN x1 x2 -> r GUseQuantPN `a` f x1 `a` f x2
    GNumCard x1 -> r GNumCard `a` f x1
    GOrdCompar x1 -> r GOrdCompar `a` f x1
    GOrdDigits x1 -> r GOrdDigits `a` f x1
    GOrdNumeral x1 -> r GOrdNumeral `a` f x1
    GOrdSuperl x1 -> r GOrdSuperl `a` f x1
    GPConjConj x1 -> r GPConjConj `a` f x1
    GSymbPN x1 -> r GSymbPN `a` f x1
    GPhrUtt x1 x2 x3 -> r GPhrUtt `a` f x1 `a` f x2 `a` f x3
    GAgentPastPartAP_none x1 x2 -> r GAgentPastPartAP_none `a` f x1 `a` f x2
    GLiftAP x1 -> r GLiftAP `a` f x1
    GPastPartAP_none x1 -> r GPastPartAP_none `a` f x1
    GPresPartAP_none x1 -> r GPresPartAP_none `a` f x1
    GLiftA2 x1 -> r GLiftA2 `a` f x1
    GPresPartAP_np x1 -> r GPresPartAP_np `a` f x1
    GComplAdv_none x1 x2 -> r GComplAdv_none `a` f x1 `a` f x2
    GLiftAdV x1 -> r GLiftAdV `a` f x1
    GLiftAdv x1 -> r GLiftAdv `a` f x1
    GLiftPrep x1 -> r GLiftPrep `a` f x1
    GLiftCN x1 -> r GLiftCN `a` f x1
    GLiftN2 x1 -> r GLiftN2 `a` f x1
    GAdvCl_none x1 x2 -> r GAdvCl_none `a` f x1 `a` f x2
    GPredVP_none x1 x2 -> r GPredVP_none `a` f x1 `a` f x2
    GSlashClNP_none x1 x2 -> r GSlashClNP_none `a` f x1 `a` f x2
    GUseClC_none x1 -> r GUseClC_none `a` f x1
    GAdvCl_np x1 x2 -> r GAdvCl_np `a` f x1 `a` f x2
    GPredVP_np x1 x2 -> r GPredVP_np `a` f x1 `a` f x2
    GUseClC_np x1 -> r GUseClC_np `a` f x1
    GAdvQCl_none x1 x2 -> r GAdvQCl_none `a` f x1 `a` f x2
    GQuestCl_none x1 -> r GQuestCl_none `a` f x1
    GQuestIAdv_none x1 x2 -> r GQuestIAdv_none `a` f x1 `a` f x2
    GQuestIComp_none x1 x2 x3 x4 x5 -> r GQuestIComp_none `a` f x1 `a` f x2 `a` f x3 `a` f x4 `a` f x5
    GQuestSlash_none x1 x2 -> r GQuestSlash_none `a` f x1 `a` f x2
    GQuestVP_none x1 x2 -> r GQuestVP_none `a` f x1 `a` f x2
    GAdvQCl_np x1 x2 -> r GAdvQCl_np `a` f x1 `a` f x2
    GQuestCl_np x1 -> r GQuestCl_np `a` f x1
    GUseAdvCl_none x1 x2 -> r GUseAdvCl_none `a` f x1 `a` f x2
    GUseCl_none x1 -> r GUseCl_none `a` f x1
    GUseQCl_none x1 -> r GUseQCl_none `a` f x1
    GInfVP_none x1 -> r GInfVP_none `a` f x1
    GInfVP_np x1 -> r GInfVP_np `a` f x1
    GAgentPassUseV_a x1 x2 x3 x4 x5 -> r GAgentPassUseV_a `a` f x1 `a` f x2 `a` f x3 `a` f x4 `a` f x5
    GPassUseV_a x1 x2 x3 x4 -> r GPassUseV_a `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GReflVP_a x1 -> r GReflVP_a `a` f x1
    GUseV_a x1 x2 x3 x4 -> r GUseV_a `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GAgentPassUseV_n x1 x2 x3 x4 x5 -> r GAgentPassUseV_n `a` f x1 `a` f x2 `a` f x3 `a` f x4 `a` f x5
    GPassUseV_n x1 x2 x3 x4 -> r GPassUseV_n `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GReflVP_n x1 -> r GReflVP_n `a` f x1
    GUseV_n x1 x2 x3 x4 -> r GUseV_n `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GAfterVP_none x1 x2 -> r GAfterVP_none `a` f x1 `a` f x2
    GAgentPassUseV_none x1 x2 x3 x4 x5 -> r GAgentPassUseV_none `a` f x1 `a` f x2 `a` f x3 `a` f x4 `a` f x5
    GBeforeVP_none x1 x2 -> r GBeforeVP_none `a` f x1 `a` f x2
    GByVP_none x1 x2 -> r GByVP_none `a` f x1 `a` f x2
    GComplV2_none x1 x2 -> r GComplV2_none `a` f x1 `a` f x2
    GComplVA_none x1 x2 -> r GComplVA_none `a` f x1 `a` f x2
    GComplVN_none x1 x2 -> r GComplVN_none `a` f x1 `a` f x2
    GComplVQ_none x1 x2 -> r GComplVQ_none `a` f x1 `a` f x2
    GComplVS_none x1 x2 -> r GComplVS_none `a` f x1 `a` f x2
    GComplVV_none x1 x2 -> r GComplVV_none `a` f x1 `a` f x2
    GInOrderVP_none x1 x2 -> r GInOrderVP_none `a` f x1 `a` f x2
    GPassUseV_none x1 x2 x3 x4 -> r GPassUseV_none `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GReflVP_none x1 -> r GReflVP_none `a` f x1
    GUseAP_none x1 x2 x3 x4 -> r GUseAP_none `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseAdv_none x1 x2 x3 x4 -> r GUseAdv_none `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseCN_none x1 x2 x3 x4 -> r GUseCN_none `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseNP_none x1 x2 x3 x4 -> r GUseNP_none `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseQ_none x1 x2 x3 x4 -> r GUseQ_none `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseS_none x1 x2 x3 x4 -> r GUseS_none `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseVPC_none x1 -> r GUseVPC_none `a` f x1
    GUseVP_none x1 x2 x3 x4 -> r GUseVP_none `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseV_none x1 x2 x3 x4 -> r GUseV_none `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GWhenVP_none x1 x2 -> r GWhenVP_none `a` f x1 `a` f x2
    GWithoutVP_none x1 x2 -> r GWithoutVP_none `a` f x1 `a` f x2
    GAgentPassUseV_np x1 x2 x3 x4 x5 -> r GAgentPassUseV_np `a` f x1 `a` f x2 `a` f x3 `a` f x4 `a` f x5
    GComplVS_np x1 x2 -> r GComplVS_np `a` f x1 `a` f x2
    GComplVV_np x1 x2 -> r GComplVV_np `a` f x1 `a` f x2
    GPassUseV_np x1 x2 x3 x4 -> r GPassUseV_np `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GReflVP2_np x1 -> r GReflVP2_np `a` f x1
    GReflVP_np x1 -> r GReflVP_np `a` f x1
    GSlashV2A_none x1 x2 -> r GSlashV2A_none `a` f x1 `a` f x2
    GSlashV2N_none x1 x2 -> r GSlashV2N_none `a` f x1 `a` f x2
    GSlashV2Q_none x1 x2 -> r GSlashV2Q_none `a` f x1 `a` f x2
    GSlashV2S_none x1 x2 -> r GSlashV2S_none `a` f x1 `a` f x2
    GSlashV2V_none x1 x2 -> r GSlashV2V_none `a` f x1 `a` f x2
    GSlashV3_none x1 x2 -> r GSlashV3_none `a` f x1 `a` f x2
    GUseAP_np x1 x2 x3 x4 -> r GUseAP_np `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseAdv_np x1 x2 x3 x4 -> r GUseAdv_np `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseCN_np x1 x2 x3 x4 -> r GUseCN_np `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseVPC_np x1 -> r GUseVPC_np `a` f x1
    GUseV_np x1 x2 x3 x4 -> r GUseV_np `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseV_np_a x1 x2 x3 x4 -> r GUseV_np_a `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseV_np_n x1 x2 x3 x4 -> r GUseV_np_n `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GSlashV2V_np x1 x2 -> r GSlashV2V_np `a` f x1 `a` f x2
    GUseV_np_np x1 x2 x3 x4 -> r GUseV_np_np `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseV_np_q x1 x2 x3 x4 -> r GUseV_np_q `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseV_np_s x1 x2 x3 x4 -> r GUseV_np_s `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GUseV_np_v x1 x2 x3 x4 -> r GUseV_np_v `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GAgentPassUseV_q x1 x2 x3 x4 x5 -> r GAgentPassUseV_q `a` f x1 `a` f x2 `a` f x3 `a` f x4 `a` f x5
    GPassUseV_q x1 x2 x3 x4 -> r GPassUseV_q `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GReflVP_q x1 -> r GReflVP_q `a` f x1
    GUseV_q x1 x2 x3 x4 -> r GUseV_q `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GAgentPassUseV_s x1 x2 x3 x4 x5 -> r GAgentPassUseV_s `a` f x1 `a` f x2 `a` f x3 `a` f x4 `a` f x5
    GPassUseV_s x1 x2 x3 x4 -> r GPassUseV_s `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GReflVP_s x1 -> r GReflVP_s `a` f x1
    GUseV_s x1 x2 x3 x4 -> r GUseV_s `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GAgentPassUseV_v x1 x2 x3 x4 x5 -> r GAgentPassUseV_v `a` f x1 `a` f x2 `a` f x3 `a` f x4 `a` f x5
    GPassUseV_v x1 x2 x3 x4 -> r GPassUseV_v `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GReflVP_v x1 -> r GReflVP_v `a` f x1
    GUseV_v x1 x2 x3 x4 -> r GUseV_v `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GLiftVA x1 -> r GLiftVA `a` f x1
    GLiftVN x1 -> r GLiftVN `a` f x1
    GLiftV x1 -> r GLiftV `a` f x1
    GLiftV2 x1 -> r GLiftV2 `a` f x1
    GLiftV2A x1 -> r GLiftV2A `a` f x1
    GLiftV2N x1 -> r GLiftV2N `a` f x1
    GLiftV3 x1 -> r GLiftV3 `a` f x1
    GLiftV2Q x1 -> r GLiftV2Q `a` f x1
    GLiftV2S x1 -> r GLiftV2S `a` f x1
    GLiftV2V x1 -> r GLiftV2V `a` f x1
    GLiftVQ x1 -> r GLiftVQ `a` f x1
    GLiftVS x1 -> r GLiftVS `a` f x1
    GLiftVV x1 -> r GLiftVV `a` f x1
    GQuestCl x1 -> r GQuestCl `a` f x1
    GQuestIAdv x1 x2 -> r GQuestIAdv `a` f x1 `a` f x2
    GQuestIComp x1 x2 -> r GQuestIComp `a` f x1 `a` f x2
    GQuestQVP x1 x2 -> r GQuestQVP `a` f x1 `a` f x2
    GQuestSlash x1 x2 -> r GQuestSlash `a` f x1 `a` f x2
    GQuestVP x1 x2 -> r GQuestVP `a` f x1 `a` f x2
    GUseQCl x1 x2 x3 -> r GUseQCl `a` f x1 `a` f x2 `a` f x3
    GAddAdvQVP x1 x2 -> r GAddAdvQVP `a` f x1 `a` f x2
    GAdvQVP x1 x2 -> r GAdvQVP `a` f x1 `a` f x2
    GComplSlashIP x1 x2 -> r GComplSlashIP `a` f x1 `a` f x2
    GGenNP x1 -> r GGenNP `a` f x1
    GPossPron x1 -> r GPossPron `a` f x1
    GEmptyRelSlash x1 -> r GEmptyRelSlash `a` f x1
    GRelCl x1 -> r GRelCl `a` f x1
    GRelSlash x1 x2 -> r GRelSlash `a` f x1 `a` f x2
    GRelVP x1 x2 -> r GRelVP `a` f x1 `a` f x2
    GFunRP x1 x2 x3 -> r GFunRP `a` f x1 `a` f x2 `a` f x3
    GGenRP x1 x2 -> r GGenRP `a` f x1 `a` f x2
    GConjRS x1 x2 -> r GConjRS `a` f x1 `a` f x2
    GPastPartRS x1 x2 x3 -> r GPastPartRS `a` f x1 `a` f x2 `a` f x3
    GPresPartRS x1 x2 x3 -> r GPresPartRS `a` f x1 `a` f x2 `a` f x3
    GRelCl_none x1 -> r GRelCl_none `a` f x1
    GRelSlash_none x1 x2 -> r GRelSlash_none `a` f x1 `a` f x2
    GRelVP_none x1 x2 -> r GRelVP_none `a` f x1 `a` f x2
    GUseRCl x1 x2 x3 -> r GUseRCl `a` f x1 `a` f x2 `a` f x3
    GAdvS x1 x2 -> r GAdvS `a` f x1 `a` f x2
    GConjS x1 x2 -> r GConjS `a` f x1 `a` f x2
    GExtAdvS x1 x2 -> r GExtAdvS `a` f x1 `a` f x2
    GPredVPS x1 x2 -> r GPredVPS `a` f x1 `a` f x2
    GRelS x1 x2 -> r GRelS `a` f x1 `a` f x2
    GSSubjS x1 x2 x3 -> r GSSubjS `a` f x1 `a` f x2 `a` f x3
    GUseCl x1 x2 x3 -> r GUseCl `a` f x1 `a` f x2 `a` f x3
    GEmbedQS x1 -> r GEmbedQS `a` f x1
    GEmbedS x1 -> r GEmbedS `a` f x1
    GEmbedVP x1 -> r GEmbedVP `a` f x1
    GUseSlash x1 x2 x3 -> r GUseSlash `a` f x1 `a` f x2 `a` f x3
    GMkSymb x1 -> r GMkSymb `a` f x1
    GTTAnt x1 x2 -> r GTTAnt `a` f x1 `a` f x2
    GPrImpPl x1 -> r GPrImpPl `a` f x1
    GPrImpSg x1 -> r GPrImpSg `a` f x1
    GUttAP x1 -> r GUttAP `a` f x1
    GUttAdV x1 -> r GUttAdV `a` f x1
    GUttAdv x1 -> r GUttAdv `a` f x1
    GUttCN x1 -> r GUttCN `a` f x1
    GUttCard x1 -> r GUttCard `a` f x1
    GUttIAdv x1 -> r GUttIAdv `a` f x1
    GUttIP x1 -> r GUttIP `a` f x1
    GUttImpPl x1 x2 -> r GUttImpPl `a` f x1 `a` f x2
    GUttImpPol x1 x2 -> r GUttImpPol `a` f x1 `a` f x2
    GUttImpSg x1 x2 -> r GUttImpSg `a` f x1 `a` f x2
    GUttInterj x1 -> r GUttInterj `a` f x1
    GUttNP x1 -> r GUttNP `a` f x1
    GUttPrS x1 -> r GUttPrS `a` f x1
    GUttQS x1 -> r GUttQS `a` f x1
    GUttS x1 -> r GUttS `a` f x1
    GUttVP x1 -> r GUttVP `a` f x1
    GAdVVP x1 x2 -> r GAdVVP `a` f x1 `a` f x2
    GAdvVP x1 x2 -> r GAdvVP `a` f x1 `a` f x2
    GComplBareVS x1 x2 -> r GComplBareVS `a` f x1 `a` f x2
    GComplSlash x1 x2 -> r GComplSlash `a` f x1 `a` f x2
    GComplSlashPartLast x1 x2 -> r GComplSlashPartLast `a` f x1 `a` f x2
    GComplVA x1 x2 -> r GComplVA `a` f x1 `a` f x2
    GComplVPIVV x1 x2 -> r GComplVPIVV `a` f x1 `a` f x2
    GComplVQ x1 x2 -> r GComplVQ `a` f x1 `a` f x2
    GComplVS x1 x2 -> r GComplVS `a` f x1 `a` f x2
    GComplVV x1 x2 x3 x4 -> r GComplVV `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GExtAdvVP x1 x2 -> r GExtAdvVP `a` f x1 `a` f x2
    GPassAgentVPSlash x1 x2 -> r GPassAgentVPSlash `a` f x1 `a` f x2
    GPassVPSlash x1 -> r GPassVPSlash `a` f x1
    GProgrVP x1 -> r GProgrVP `a` f x1
    GReflVP x1 -> r GReflVP `a` f x1
    GSelfAdVVP x1 -> r GSelfAdVVP `a` f x1
    GSelfAdvVP x1 -> r GSelfAdvVP `a` f x1
    GUseComp x1 -> r GUseComp `a` f x1
    GUseV x1 -> r GUseV `a` f x1
    GContVPC_none x1 x2 -> r GContVPC_none `a` f x1 `a` f x2
    GStartVPC_none x1 x2 x3 -> r GStartVPC_none `a` f x1 `a` f x2 `a` f x3
    GContVPC_np x1 x2 -> r GContVPC_np `a` f x1 `a` f x2
    GStartVPC_np x1 x2 x3 -> r GStartVPC_np `a` f x1 `a` f x2 `a` f x3
    GConjVPI x1 x2 -> r GConjVPI `a` f x1 `a` f x2
    GMkVPI x1 -> r GMkVPI `a` f x1
    GConjVPS x1 x2 -> r GConjVPS `a` f x1 `a` f x2
    GMkVPS x1 x2 x3 -> r GMkVPS `a` f x1 `a` f x2 `a` f x3
    GAdVVPSlash x1 x2 -> r GAdVVPSlash `a` f x1 `a` f x2
    GAdvVPSlash x1 x2 -> r GAdvVPSlash `a` f x1 `a` f x2
    GSlash2V3 x1 x2 -> r GSlash2V3 `a` f x1 `a` f x2
    GSlash3V3 x1 x2 -> r GSlash3V3 `a` f x1 `a` f x2
    GSlashBareV2S x1 x2 -> r GSlashBareV2S `a` f x1 `a` f x2
    GSlashSlashV2V x1 x2 x3 x4 -> r GSlashSlashV2V `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GSlashV2A x1 x2 -> r GSlashV2A `a` f x1 `a` f x2
    GSlashV2Q x1 x2 -> r GSlashV2Q `a` f x1 `a` f x2
    GSlashV2S x1 x2 -> r GSlashV2S `a` f x1 `a` f x2
    GSlashV2V x1 x2 x3 x4 -> r GSlashV2V `a` f x1 `a` f x2 `a` f x3 `a` f x4
    GSlashV2VNP x1 x2 x3 -> r GSlashV2VNP `a` f x1 `a` f x2 `a` f x3
    GSlashV2a x1 -> r GSlashV2a `a` f x1
    GSlashVPIV2V x1 x2 x3 -> r GSlashVPIV2V `a` f x1 `a` f x2 `a` f x3
    GSlashVV x1 x2 -> r GSlashVV `a` f x1 `a` f x2
    GVPSlashPrep x1 x2 -> r GVPSlashPrep `a` f x1 `a` f x2
    GVPSlashVS x1 x2 -> r GVPSlashVS `a` f x1 `a` f x2
    GVocNP x1 -> r GVocNP `a` f x1
    GListAP x1 -> r GListAP `a` foldr (a . a (r (:)) . f) (r []) x1
    GListAdV x1 -> r GListAdV `a` foldr (a . a (r (:)) . f) (r []) x1
    GListAdv x1 -> r GListAdv `a` foldr (a . a (r (:)) . f) (r []) x1
    GListCN x1 -> r GListCN `a` foldr (a . a (r (:)) . f) (r []) x1
    GListIAdv x1 -> r GListIAdv `a` foldr (a . a (r (:)) . f) (r []) x1
    GListNP x1 -> r GListNP `a` foldr (a . a (r (:)) . f) (r []) x1
    GListRS x1 -> r GListRS `a` foldr (a . a (r (:)) . f) (r []) x1
    GListS x1 -> r GListS `a` foldr (a . a (r (:)) . f) (r []) x1
    GListVPI x1 -> r GListVPI `a` foldr (a . a (r (:)) . f) (r []) x1
    GListVPS x1 -> r GListVPS `a` foldr (a . a (r (:)) . f) (r []) x1
    _ -> r t

class Compos t where
  compos :: (forall a. a -> m a) -> (forall a b. m (a -> b) -> m a -> m b)
         -> (forall a. t a -> m (t a)) -> t c -> m (t c)

composOp :: Compos t => (forall a. t a -> t a) -> t c -> t c
composOp f = runIdentity . composOpM (Identity . f)

composOpM :: (Compos t, Monad m) => (forall a. t a -> m (t a)) -> t c -> m (t c)
composOpM = compos return ap

composOpM_ :: (Compos t, Monad m) => (forall a. t a -> m ()) -> t c -> m ()
composOpM_ = composOpFold (return ()) (>>)

composOpMonoid :: (Compos t, Monoid m) => (forall a. t a -> m) -> t c -> m
composOpMonoid = composOpFold mempty mappend

composOpMPlus :: (Compos t, MonadPlus m) => (forall a. t a -> m b) -> t c -> m b
composOpMPlus = composOpFold mzero mplus

composOpFold :: Compos t => b -> (b -> b -> b) -> (forall a. t a -> b) -> t c -> b
composOpFold z c f = unC . compos (\_ -> C z) (\(C x) (C y) -> C (c x y)) (C . f)

newtype C b a = C { unC :: b }
