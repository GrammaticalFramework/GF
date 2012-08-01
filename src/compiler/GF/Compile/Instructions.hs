module GF.Compile.Instructions where

import Data.IORef
import Data.Binary
import Data.Binary.Put
import Data.Binary.Get
import Data.Binary.IEEE754
import PGF.CId
import PGF.Binary

type IntRef = Int
type AConstant = CId
type AKind = CId

ppE = undefined
ppF = undefined
ppL = undefined
ppC = undefined
ppN = undefined
ppR = undefined
ppK = undefined
ppS = undefined
ppI = undefined
ppI1 = undefined
ppIT = undefined
ppCE = undefined
ppMT = undefined
ppHT = undefined
ppSEG = undefined
ppBVT = undefined

wordSize = 4 :: Int

rSize = 255 :: Int
eSize = 255 :: Int
nSize = 255 :: Int
i1Size = 255 :: Int
ceSize = 255 :: Int
segSize = 255 :: Int
cSize = 65535 :: Int
kSize = 65535 :: Int
sSize = 65535 :: Int
mtSize = 65535 :: Int
itSize = 65535 :: Int
htSize = 65535 :: Int
bvtSize = 65535 :: Int
opcodeSize = 255 :: Int


type Rtype = Int
type Etype = Int
type Ntype = Int
type I1type = Int
type CEtype = Int
type SEGtype = Int
type Ctype = AConstant
type Ktype = AKind
type Ltype = IntRef
type Itype = Int
type Ftype = Float
type Stype = Int
type MTtype = Int
type ITtype = Int
type HTtype = Int
type BVTtype = Int

putR  = putWord8 . fromIntegral
putE  = putWord8 . fromIntegral
putN  = putWord8 . fromIntegral
putI1  = putWord8 . fromIntegral
putCE  = putWord8 . fromIntegral
putSEG  = putWord8 . fromIntegral
putC  = put
putK  = put
putL  = putWord32be . fromIntegral
putI  = putWord32be . fromIntegral
putF  = putFloat32be
putS  = putWord16be . fromIntegral
putMT  = putWord16be . fromIntegral
putIT  = putWord16be . fromIntegral
putHT  = putWord16be . fromIntegral
putBVT  = putWord16be . fromIntegral
putopcode  = putWord8 . fromIntegral


getR  = fmap fromIntegral $ getWord8
getE  = fmap fromIntegral $ getWord8
getN  = fmap fromIntegral $ getWord8
getI1  = fmap fromIntegral $ getWord8
getCE  = fmap fromIntegral $ getWord8
getSEG  = fmap fromIntegral $ getWord8
getC  = get
getK  = get
getL  = fmap fromIntegral $ getWord32be
getI  = fmap fromIntegral $ getWord32be
getF  = getFloat32be
getS  = fmap fromIntegral $ getWord16be
getMT  = fmap fromIntegral $ getWord16be
getIT  = fmap fromIntegral $ getWord16be
getHT  = fmap fromIntegral $ getWord16be
getBVT  = fmap fromIntegral $ getWord16be
getopcode  = fmap fromIntegral $ getWord8


type InscatRX = (Rtype)
type InscatEX = (Etype)
type InscatI1X = (I1type)
type InscatCX = (Ctype)
type InscatKX = (Ktype)
type InscatIX = (Itype)
type InscatFX = (Ftype)
type InscatSX = (Stype)
type InscatMTX = (MTtype)
type InscatLX = (Ltype)
type InscatRRX = (Rtype, Rtype)
type InscatERX = (Etype, Rtype)
type InscatRCX = (Rtype, Ctype)
type InscatRIX = (Rtype, Itype)
type InscatRFX = (Rtype, Ftype)
type InscatRSX = (Rtype, Stype)
type InscatRI1X = (Rtype, I1type)
type InscatRCEX = (Rtype, CEtype)
type InscatECEX = (Etype, CEtype)
type InscatCLX = (Ctype, Ltype)
type InscatRKX = (Rtype, Ktype)
type InscatECX = (Etype, Ctype)
type InscatI1ITX = (I1type, ITtype)
type InscatI1LX = (I1type, Ltype)
type InscatSEGLX = (SEGtype, Ltype)
type InscatI1LWPX = (I1type, Ltype)
type InscatI1NX = (I1type, Ntype)
type InscatI1HTX = (I1type, HTtype)
type InscatI1BVTX = (I1type, BVTtype)
type InscatCWPX = (Ctype)
type InscatI1WPX = (I1type)
type InscatRRI1X = (Rtype, Rtype, I1type)
type InscatRCLX = (Rtype, Ctype, Ltype)
type InscatRCI1X = (Rtype, Ctype, I1type)
type InscatSEGI1LX = (SEGtype, I1type, Ltype)
type InscatI1LLX = (I1type, Ltype, Ltype)
type InscatNLLX = (Ntype, Ltype, Ltype)
type InscatLLLLX = (Ltype, Ltype, Ltype, Ltype)
type InscatI1CWPX = (I1type, Ctype)
type InscatI1I1WPX = (I1type, I1type)


putRX (arg1) = putR arg1
putEX (arg1) = putE arg1
putI1X (arg1) = putI1 arg1
putCX (arg1) = putC arg1
putKX (arg1) = putK arg1
putIX (arg1) = putI arg1
putFX (arg1) = putF arg1
putSX (arg1) = putS arg1
putMTX (arg1) = putMT arg1
putLX (arg1) = putL arg1
putRRX (arg1, arg2) = putR arg1 >> putR arg2
putERX (arg1, arg2) = putE arg1 >> putR arg2
putRCX (arg1, arg2) = putR arg1 >> putC arg2
putRIX (arg1, arg2) = putR arg1 >> putI arg2
putRFX (arg1, arg2) = putR arg1 >> putF arg2
putRSX (arg1, arg2) = putR arg1 >> putS arg2
putRI1X (arg1, arg2) = putR arg1 >> putI1 arg2
putRCEX (arg1, arg2) = putR arg1 >> putCE arg2
putECEX (arg1, arg2) = putE arg1 >> putCE arg2
putCLX (arg1, arg2) = putC arg1 >> putL arg2
putRKX (arg1, arg2) = putR arg1 >> putK arg2
putECX (arg1, arg2) = putE arg1 >> putC arg2
putI1ITX (arg1, arg2) = putI1 arg1 >> putIT arg2
putI1LX (arg1, arg2) = putI1 arg1 >> putL arg2
putSEGLX (arg1, arg2) = putSEG arg1 >> putL arg2
putI1LWPX (arg1, arg2) = putI1 arg1 >> putL arg2
putI1NX (arg1, arg2) = putI1 arg1 >> putN arg2
putI1HTX (arg1, arg2) = putI1 arg1 >> putHT arg2
putI1BVTX (arg1, arg2) = putI1 arg1 >> putBVT arg2
putCWPX (arg1) = putC arg1
putI1WPX (arg1) = putI1 arg1
putRRI1X (arg1, arg2, arg3) = putR arg1 >> putR arg2 >> putI1 arg3
putRCLX (arg1, arg2, arg3) = putR arg1 >> putC arg2 >> putL arg3
putRCI1X (arg1, arg2, arg3) = putR arg1 >> putC arg2 >> putI1 arg3
putSEGI1LX (arg1, arg2, arg3) = putSEG arg1 >> putI1 arg2 >> putL arg3
putI1LLX (arg1, arg2, arg3) = putI1 arg1 >> putL arg2 >> putL arg3
putNLLX (arg1, arg2, arg3) = putN arg1 >> putL arg2 >> putL arg3
putLLLLX (arg1, arg2, arg3, arg4) = putL arg1 >> putL arg2 >> putL arg3 >> putL arg4
putI1CWPX (arg1, arg2) = putI1 arg1 >> putC arg2
putI1I1WPX (arg1, arg2) = putI1 arg1 >> putI1 arg2

getRX  = do
  arg1 <- getR
  return (arg1)
getEX  = do
  arg1 <- getE
  return (arg1)
getI1X  = do
  arg1 <- getI1
  return (arg1)
getCX  = do
  arg1 <- getC
  return (arg1)
getKX  = do
  arg1 <- getK
  return (arg1)
getIX  = do
  arg1 <- getI
  return (arg1)
getFX  = do
  arg1 <- getF
  return (arg1)
getSX  = do
  arg1 <- getS
  return (arg1)
getMTX  = do
  arg1 <- getMT
  return (arg1)
getLX  = do
  arg1 <- getL
  return (arg1)
getRRX  = do
  arg1 <- getR
  arg2 <- getR
  return (arg1, arg2)
getERX  = do
  arg1 <- getE
  arg2 <- getR
  return (arg1, arg2)
getRCX  = do
  arg1 <- getR
  arg2 <- getC
  return (arg1, arg2)
getRIX  = do
  arg1 <- getR
  arg2 <- getI
  return (arg1, arg2)
getRFX  = do
  arg1 <- getR
  arg2 <- getF
  return (arg1, arg2)
getRSX  = do
  arg1 <- getR
  arg2 <- getS
  return (arg1, arg2)
getRI1X  = do
  arg1 <- getR
  arg2 <- getI1
  return (arg1, arg2)
getRCEX  = do
  arg1 <- getR
  arg2 <- getCE
  return (arg1, arg2)
getECEX  = do
  arg1 <- getE
  arg2 <- getCE
  return (arg1, arg2)
getCLX  = do
  arg1 <- getC
  arg2 <- getL
  return (arg1, arg2)
getRKX  = do
  arg1 <- getR
  arg2 <- getK
  return (arg1, arg2)
getECX  = do
  arg1 <- getE
  arg2 <- getC
  return (arg1, arg2)
getI1ITX  = do
  arg1 <- getI1
  arg2 <- getIT
  return (arg1, arg2)
getI1LX  = do
  arg1 <- getI1
  arg2 <- getL
  return (arg1, arg2)
getSEGLX  = do
  arg1 <- getSEG
  arg2 <- getL
  return (arg1, arg2)
getI1LWPX  = do
  arg1 <- getI1
  arg2 <- getL
  return (arg1, arg2)
getI1NX  = do
  arg1 <- getI1
  arg2 <- getN
  return (arg1, arg2)
getI1HTX  = do
  arg1 <- getI1
  arg2 <- getHT
  return (arg1, arg2)
getI1BVTX  = do
  arg1 <- getI1
  arg2 <- getBVT
  return (arg1, arg2)
getCWPX  = do
  arg1 <- getC
  return (arg1)
getI1WPX  = do
  arg1 <- getI1
  return (arg1)
getRRI1X  = do
  arg1 <- getR
  arg2 <- getR
  arg3 <- getI1
  return (arg1, arg2, arg3)
getRCLX  = do
  arg1 <- getR
  arg2 <- getC
  arg3 <- getL
  return (arg1, arg2, arg3)
getRCI1X  = do
  arg1 <- getR
  arg2 <- getC
  arg3 <- getI1
  return (arg1, arg2, arg3)
getSEGI1LX  = do
  arg1 <- getSEG
  arg2 <- getI1
  arg3 <- getL
  return (arg1, arg2, arg3)
getI1LLX  = do
  arg1 <- getI1
  arg2 <- getL
  arg3 <- getL
  return (arg1, arg2, arg3)
getNLLX  = do
  arg1 <- getN
  arg2 <- getL
  arg3 <- getL
  return (arg1, arg2, arg3)
getLLLLX  = do
  arg1 <- getL
  arg2 <- getL
  arg3 <- getL
  arg4 <- getL
  return (arg1, arg2, arg3, arg4)
getI1CWPX  = do
  arg1 <- getI1
  arg2 <- getC
  return (arg1, arg2)
getI1I1WPX  = do
  arg1 <- getI1
  arg2 <- getI1
  return (arg1, arg2)

displayRX (arg1) = ppR arg1
displayEX (arg1) = ppE arg1
displayI1X (arg1) = ppI1 arg1
displayCX (arg1) = ppC arg1
displayKX (arg1) = ppK arg1
displayIX (arg1) = ppI arg1
displayFX (arg1) = ppF arg1
displaySX (arg1) = ppS arg1
displayMTX (arg1) = ppMT arg1
displayLX (arg1) = ppL arg1
displayRRX (arg1, arg2) = (ppR arg1) ++ ", " ++ (ppR arg2)
displayERX (arg1, arg2) = (ppE arg1) ++ ", " ++ (ppR arg2)
displayRCX (arg1, arg2) = (ppR arg1) ++ ", " ++ (ppC arg2)
displayRIX (arg1, arg2) = (ppR arg1) ++ ", " ++ (ppI arg2)
displayRFX (arg1, arg2) = (ppR arg1) ++ ", " ++ (ppF arg2)
displayRSX (arg1, arg2) = (ppR arg1) ++ ", " ++ (ppS arg2)
displayRI1X (arg1, arg2) = (ppR arg1) ++ ", " ++ (ppI1 arg2)
displayRCEX (arg1, arg2) = (ppR arg1) ++ ", " ++ (ppCE arg2)
displayECEX (arg1, arg2) = (ppE arg1) ++ ", " ++ (ppCE arg2)
displayCLX (arg1, arg2) = (ppC arg1) ++ ", " ++ (ppL arg2)
displayRKX (arg1, arg2) = (ppR arg1) ++ ", " ++ (ppK arg2)
displayECX (arg1, arg2) = (ppE arg1) ++ ", " ++ (ppC arg2)
displayI1ITX (arg1, arg2) = (ppI1 arg1) ++ ", " ++ (ppIT arg2)
displayI1LX (arg1, arg2) = (ppI1 arg1) ++ ", " ++ (ppL arg2)
displaySEGLX (arg1, arg2) = (ppSEG arg1) ++ ", " ++ (ppL arg2)
displayI1LWPX (arg1, arg2) = (ppI1 arg1) ++ ", " ++ (ppL arg2)
displayI1NX (arg1, arg2) = (ppI1 arg1) ++ ", " ++ (ppN arg2)
displayI1HTX (arg1, arg2) = (ppI1 arg1) ++ ", " ++ (ppHT arg2)
displayI1BVTX (arg1, arg2) = (ppI1 arg1) ++ ", " ++ (ppBVT arg2)
displayCWPX (arg1) = ppC arg1
displayI1WPX (arg1) = ppI1 arg1
displayRRI1X (arg1, arg2, arg3) = ((ppR arg1) ++ ", " ++ (ppR arg2)) ++ ", " ++ (ppI1 arg3)
displayRCLX (arg1, arg2, arg3) = ((ppR arg1) ++ ", " ++ (ppC arg2)) ++ ", " ++ (ppL arg3)
displayRCI1X (arg1, arg2, arg3) = ((ppR arg1) ++ ", " ++ (ppC arg2)) ++ ", " ++ (ppI1 arg3)
displaySEGI1LX (arg1, arg2, arg3) = ((ppSEG arg1) ++ ", " ++ (ppI1 arg2)) ++ ", " ++ (ppL arg3)
displayI1LLX (arg1, arg2, arg3) = ((ppI1 arg1) ++ ", " ++ (ppL arg2)) ++ ", " ++ (ppL arg3)
displayNLLX (arg1, arg2, arg3) = ((ppN arg1) ++ ", " ++ (ppL arg2)) ++ ", " ++ (ppL arg3)
displayLLLLX (arg1, arg2, arg3, arg4) = (((ppL arg1) ++ ", " ++ (ppL arg2)) ++ ", " ++ (ppL arg3)) ++ ", " ++ (ppL arg4)
displayI1CWPX (arg1, arg2) = (ppI1 arg1) ++ ", " ++ (ppC arg2)
displayI1I1WPX (arg1, arg2) = (ppI1 arg1) ++ ", " ++ (ppI1 arg2)

inscatX_LEN = 4 :: Int
inscatRX_LEN = 4 :: Int
inscatEX_LEN = 4 :: Int
inscatI1X_LEN = 4 :: Int
inscatCX_LEN = 4 :: Int
inscatKX_LEN = 4 :: Int
inscatIX_LEN = 8 :: Int
inscatFX_LEN = 8 :: Int
inscatSX_LEN = 8 :: Int
inscatMTX_LEN = 8 :: Int
inscatLX_LEN = 8 :: Int
inscatRRX_LEN = 4 :: Int
inscatERX_LEN = 4 :: Int
inscatRCX_LEN = 4 :: Int
inscatRIX_LEN = 8 :: Int
inscatRFX_LEN = 8 :: Int
inscatRSX_LEN = 8 :: Int
inscatRI1X_LEN = 4 :: Int
inscatRCEX_LEN = 4 :: Int
inscatECEX_LEN = 4 :: Int
inscatCLX_LEN = 8 :: Int
inscatRKX_LEN = 4 :: Int
inscatECX_LEN = 4 :: Int
inscatI1ITX_LEN = 8 :: Int
inscatI1LX_LEN = 8 :: Int
inscatSEGLX_LEN = 8 :: Int
inscatI1LWPX_LEN = 12 :: Int
inscatI1NX_LEN = 4 :: Int
inscatI1HTX_LEN = 8 :: Int
inscatI1BVTX_LEN = 8 :: Int
inscatCWPX_LEN = 8 :: Int
inscatI1WPX_LEN = 8 :: Int
inscatRRI1X_LEN = 4 :: Int
inscatRCLX_LEN = 8 :: Int
inscatRCI1X_LEN = 8 :: Int
inscatSEGI1LX_LEN = 8 :: Int
inscatI1LLX_LEN = 12 :: Int
inscatNLLX_LEN = 12 :: Int
inscatLLLLX_LEN = 20 :: Int
inscatI1CWPX_LEN = 8 :: Int
inscatI1I1WPX_LEN = 8 :: Int



data Instruction
  = Ins_put_variable_t InscatRRX
  | Ins_put_variable_p InscatERX
  | Ins_put_value_t InscatRRX
  | Ins_put_value_p InscatERX
  | Ins_put_unsafe_value InscatERX
  | Ins_copy_value InscatERX
  | Ins_put_m_const InscatRCX
  | Ins_put_p_const InscatRCX
  | Ins_put_nil InscatRX
  | Ins_put_integer InscatRIX
  | Ins_put_float InscatRFX
  | Ins_put_string InscatRSX
  | Ins_put_index InscatRI1X
  | Ins_put_app InscatRRI1X
  | Ins_put_list InscatRX
  | Ins_put_lambda InscatRRI1X
  | Ins_set_variable_t InscatRX
  | Ins_set_variable_te InscatRX
  | Ins_set_variable_p InscatEX
  | Ins_set_value_t InscatRX
  | Ins_set_value_p InscatEX
  | Ins_globalize_pt InscatERX
  | Ins_globalize_t InscatRX
  | Ins_set_m_const InscatCX
  | Ins_set_p_const InscatCX
  | Ins_set_nil
  | Ins_set_integer InscatIX
  | Ins_set_float InscatFX
  | Ins_set_string InscatSX
  | Ins_set_index InscatI1X
  | Ins_set_void InscatI1X
  | Ins_deref InscatRX
  | Ins_set_lambda InscatRI1X
  | Ins_get_variable_t InscatRRX
  | Ins_get_variable_p InscatERX
  | Ins_init_variable_t InscatRCEX
  | Ins_init_variable_p InscatECEX
  | Ins_get_m_constant InscatRCX
  | Ins_get_p_constant InscatRCLX
  | Ins_get_integer InscatRIX
  | Ins_get_float InscatRFX
  | Ins_get_string InscatRSX
  | Ins_get_nil InscatRX
  | Ins_get_m_structure InscatRCI1X
  | Ins_get_p_structure InscatRCI1X
  | Ins_get_list InscatRX
  | Ins_unify_variable_t InscatRX
  | Ins_unify_variable_p InscatEX
  | Ins_unify_value_t InscatRX
  | Ins_unify_value_p InscatEX
  | Ins_unify_local_value_t InscatRX
  | Ins_unify_local_value_p InscatEX
  | Ins_unify_m_constant InscatCX
  | Ins_unify_p_constant InscatCLX
  | Ins_unify_integer InscatIX
  | Ins_unify_float InscatFX
  | Ins_unify_string InscatSX
  | Ins_unify_nil
  | Ins_unify_void InscatI1X
  | Ins_put_type_variable_t InscatRRX
  | Ins_put_type_variable_p InscatERX
  | Ins_put_type_value_t InscatRRX
  | Ins_put_type_value_p InscatERX
  | Ins_put_type_unsafe_value InscatERX
  | Ins_put_type_const InscatRKX
  | Ins_put_type_structure InscatRKX
  | Ins_put_type_arrow InscatRX
  | Ins_set_type_variable_t InscatRX
  | Ins_set_type_variable_p InscatEX
  | Ins_set_type_value_t InscatRX
  | Ins_set_type_value_p InscatEX
  | Ins_set_type_local_value_t InscatRX
  | Ins_set_type_local_value_p InscatEX
  | Ins_set_type_constant InscatKX
  | Ins_get_type_variable_t InscatRRX
  | Ins_get_type_variable_p InscatERX
  | Ins_init_type_variable_t InscatRCEX
  | Ins_init_type_variable_p InscatECEX
  | Ins_get_type_value_t InscatRRX
  | Ins_get_type_value_p InscatERX
  | Ins_get_type_constant InscatRKX
  | Ins_get_type_structure InscatRKX
  | Ins_get_type_arrow InscatRX
  | Ins_unify_type_variable_t InscatRX
  | Ins_unify_type_variable_p InscatEX
  | Ins_unify_type_value_t InscatRX
  | Ins_unify_type_value_p InscatEX
  | Ins_unify_envty_value_t InscatRX
  | Ins_unify_envty_value_p InscatEX
  | Ins_unify_type_local_value_t InscatRX
  | Ins_unify_type_local_value_p InscatEX
  | Ins_unify_envty_local_value_t InscatRX
  | Ins_unify_envty_local_value_p InscatEX
  | Ins_unify_type_constant InscatKX
  | Ins_pattern_unify_t InscatRRX
  | Ins_pattern_unify_p InscatERX
  | Ins_finish_unify
  | Ins_head_normalize_t InscatRX
  | Ins_head_normalize_p InscatEX
  | Ins_incr_universe
  | Ins_decr_universe
  | Ins_set_univ_tag InscatECX
  | Ins_tag_exists_t InscatRX
  | Ins_tag_exists_p InscatEX
  | Ins_tag_variable InscatEX
  | Ins_push_impl_point InscatI1ITX
  | Ins_pop_impl_point
  | Ins_add_imports InscatSEGI1LX
  | Ins_remove_imports InscatSEGLX
  | Ins_push_import InscatMTX
  | Ins_pop_imports InscatI1X
  | Ins_allocate InscatI1X
  | Ins_deallocate
  | Ins_call InscatI1LX
  | Ins_call_name InscatI1CWPX
  | Ins_execute InscatLX
  | Ins_execute_name InscatCWPX
  | Ins_proceed
  | Ins_try_me_else InscatI1LX
  | Ins_retry_me_else InscatI1LX
  | Ins_trust_me InscatI1WPX
  | Ins_try InscatI1LX
  | Ins_retry InscatI1LX
  | Ins_trust InscatI1LWPX
  | Ins_trust_ext InscatI1NX
  | Ins_try_else InscatI1LLX
  | Ins_retry_else InscatI1LLX
  | Ins_branch InscatLX
  | Ins_switch_on_term InscatLLLLX
  | Ins_switch_on_constant InscatI1HTX
  | Ins_switch_on_bvar InscatI1BVTX
  | Ins_switch_on_reg InscatNLLX
  | Ins_neck_cut
  | Ins_get_level InscatEX
  | Ins_put_level InscatEX
  | Ins_cut InscatEX
  | Ins_call_builtin InscatI1I1WPX
  | Ins_builtin InscatI1X
  | Ins_stop
  | Ins_halt
  | Ins_fail
  | Ins_create_type_variable InscatEX
  | Ins_execute_link_only InscatCWPX
  | Ins_call_link_only InscatI1CWPX
  | Ins_put_variable_te InscatRRX

getSize_put_variable_t = inscatRRX_LEN :: Int
getSize_put_variable_p = inscatERX_LEN :: Int
getSize_put_value_t = inscatRRX_LEN :: Int
getSize_put_value_p = inscatERX_LEN :: Int
getSize_put_unsafe_value = inscatERX_LEN :: Int
getSize_copy_value = inscatERX_LEN :: Int
getSize_put_m_const = inscatRCX_LEN :: Int
getSize_put_p_const = inscatRCX_LEN :: Int
getSize_put_nil = inscatRX_LEN :: Int
getSize_put_integer = inscatRIX_LEN :: Int
getSize_put_float = inscatRFX_LEN :: Int
getSize_put_string = inscatRSX_LEN :: Int
getSize_put_index = inscatRI1X_LEN :: Int
getSize_put_app = inscatRRI1X_LEN :: Int
getSize_put_list = inscatRX_LEN :: Int
getSize_put_lambda = inscatRRI1X_LEN :: Int
getSize_set_variable_t = inscatRX_LEN :: Int
getSize_set_variable_te = inscatRX_LEN :: Int
getSize_set_variable_p = inscatEX_LEN :: Int
getSize_set_value_t = inscatRX_LEN :: Int
getSize_set_value_p = inscatEX_LEN :: Int
getSize_globalize_pt = inscatERX_LEN :: Int
getSize_globalize_t = inscatRX_LEN :: Int
getSize_set_m_const = inscatCX_LEN :: Int
getSize_set_p_const = inscatCX_LEN :: Int
getSize_set_nil = inscatX_LEN :: Int
getSize_set_integer = inscatIX_LEN :: Int
getSize_set_float = inscatFX_LEN :: Int
getSize_set_string = inscatSX_LEN :: Int
getSize_set_index = inscatI1X_LEN :: Int
getSize_set_void = inscatI1X_LEN :: Int
getSize_deref = inscatRX_LEN :: Int
getSize_set_lambda = inscatRI1X_LEN :: Int
getSize_get_variable_t = inscatRRX_LEN :: Int
getSize_get_variable_p = inscatERX_LEN :: Int
getSize_init_variable_t = inscatRCEX_LEN :: Int
getSize_init_variable_p = inscatECEX_LEN :: Int
getSize_get_m_constant = inscatRCX_LEN :: Int
getSize_get_p_constant = inscatRCLX_LEN :: Int
getSize_get_integer = inscatRIX_LEN :: Int
getSize_get_float = inscatRFX_LEN :: Int
getSize_get_string = inscatRSX_LEN :: Int
getSize_get_nil = inscatRX_LEN :: Int
getSize_get_m_structure = inscatRCI1X_LEN :: Int
getSize_get_p_structure = inscatRCI1X_LEN :: Int
getSize_get_list = inscatRX_LEN :: Int
getSize_unify_variable_t = inscatRX_LEN :: Int
getSize_unify_variable_p = inscatEX_LEN :: Int
getSize_unify_value_t = inscatRX_LEN :: Int
getSize_unify_value_p = inscatEX_LEN :: Int
getSize_unify_local_value_t = inscatRX_LEN :: Int
getSize_unify_local_value_p = inscatEX_LEN :: Int
getSize_unify_m_constant = inscatCX_LEN :: Int
getSize_unify_p_constant = inscatCLX_LEN :: Int
getSize_unify_integer = inscatIX_LEN :: Int
getSize_unify_float = inscatFX_LEN :: Int
getSize_unify_string = inscatSX_LEN :: Int
getSize_unify_nil = inscatX_LEN :: Int
getSize_unify_void = inscatI1X_LEN :: Int
getSize_put_type_variable_t = inscatRRX_LEN :: Int
getSize_put_type_variable_p = inscatERX_LEN :: Int
getSize_put_type_value_t = inscatRRX_LEN :: Int
getSize_put_type_value_p = inscatERX_LEN :: Int
getSize_put_type_unsafe_value = inscatERX_LEN :: Int
getSize_put_type_const = inscatRKX_LEN :: Int
getSize_put_type_structure = inscatRKX_LEN :: Int
getSize_put_type_arrow = inscatRX_LEN :: Int
getSize_set_type_variable_t = inscatRX_LEN :: Int
getSize_set_type_variable_p = inscatEX_LEN :: Int
getSize_set_type_value_t = inscatRX_LEN :: Int
getSize_set_type_value_p = inscatEX_LEN :: Int
getSize_set_type_local_value_t = inscatRX_LEN :: Int
getSize_set_type_local_value_p = inscatEX_LEN :: Int
getSize_set_type_constant = inscatKX_LEN :: Int
getSize_get_type_variable_t = inscatRRX_LEN :: Int
getSize_get_type_variable_p = inscatERX_LEN :: Int
getSize_init_type_variable_t = inscatRCEX_LEN :: Int
getSize_init_type_variable_p = inscatECEX_LEN :: Int
getSize_get_type_value_t = inscatRRX_LEN :: Int
getSize_get_type_value_p = inscatERX_LEN :: Int
getSize_get_type_constant = inscatRKX_LEN :: Int
getSize_get_type_structure = inscatRKX_LEN :: Int
getSize_get_type_arrow = inscatRX_LEN :: Int
getSize_unify_type_variable_t = inscatRX_LEN :: Int
getSize_unify_type_variable_p = inscatEX_LEN :: Int
getSize_unify_type_value_t = inscatRX_LEN :: Int
getSize_unify_type_value_p = inscatEX_LEN :: Int
getSize_unify_envty_value_t = inscatRX_LEN :: Int
getSize_unify_envty_value_p = inscatEX_LEN :: Int
getSize_unify_type_local_value_t = inscatRX_LEN :: Int
getSize_unify_type_local_value_p = inscatEX_LEN :: Int
getSize_unify_envty_local_value_t = inscatRX_LEN :: Int
getSize_unify_envty_local_value_p = inscatEX_LEN :: Int
getSize_unify_type_constant = inscatKX_LEN :: Int
getSize_pattern_unify_t = inscatRRX_LEN :: Int
getSize_pattern_unify_p = inscatERX_LEN :: Int
getSize_finish_unify = inscatX_LEN :: Int
getSize_head_normalize_t = inscatRX_LEN :: Int
getSize_head_normalize_p = inscatEX_LEN :: Int
getSize_incr_universe = inscatX_LEN :: Int
getSize_decr_universe = inscatX_LEN :: Int
getSize_set_univ_tag = inscatECX_LEN :: Int
getSize_tag_exists_t = inscatRX_LEN :: Int
getSize_tag_exists_p = inscatEX_LEN :: Int
getSize_tag_variable = inscatEX_LEN :: Int
getSize_push_impl_point = inscatI1ITX_LEN :: Int
getSize_pop_impl_point = inscatX_LEN :: Int
getSize_add_imports = inscatSEGI1LX_LEN :: Int
getSize_remove_imports = inscatSEGLX_LEN :: Int
getSize_push_import = inscatMTX_LEN :: Int
getSize_pop_imports = inscatI1X_LEN :: Int
getSize_allocate = inscatI1X_LEN :: Int
getSize_deallocate = inscatX_LEN :: Int
getSize_call = inscatI1LX_LEN :: Int
getSize_call_name = inscatI1CWPX_LEN :: Int
getSize_execute = inscatLX_LEN :: Int
getSize_execute_name = inscatCWPX_LEN :: Int
getSize_proceed = inscatX_LEN :: Int
getSize_try_me_else = inscatI1LX_LEN :: Int
getSize_retry_me_else = inscatI1LX_LEN :: Int
getSize_trust_me = inscatI1WPX_LEN :: Int
getSize_try = inscatI1LX_LEN :: Int
getSize_retry = inscatI1LX_LEN :: Int
getSize_trust = inscatI1LWPX_LEN :: Int
getSize_trust_ext = inscatI1NX_LEN :: Int
getSize_try_else = inscatI1LLX_LEN :: Int
getSize_retry_else = inscatI1LLX_LEN :: Int
getSize_branch = inscatLX_LEN :: Int
getSize_switch_on_term = inscatLLLLX_LEN :: Int
getSize_switch_on_constant = inscatI1HTX_LEN :: Int
getSize_switch_on_bvar = inscatI1BVTX_LEN :: Int
getSize_switch_on_reg = inscatNLLX_LEN :: Int
getSize_neck_cut = inscatX_LEN :: Int
getSize_get_level = inscatEX_LEN :: Int
getSize_put_level = inscatEX_LEN :: Int
getSize_cut = inscatEX_LEN :: Int
getSize_call_builtin = inscatI1I1WPX_LEN :: Int
getSize_builtin = inscatI1X_LEN :: Int
getSize_stop = inscatX_LEN :: Int
getSize_halt = inscatX_LEN :: Int
getSize_fail = inscatX_LEN :: Int
getSize_create_type_variable = inscatEX_LEN :: Int
getSize_execute_link_only = inscatCWPX_LEN :: Int
getSize_call_link_only = inscatI1CWPX_LEN :: Int
getSize_put_variable_te = inscatRRX_LEN :: Int

putInstruction :: Instruction -> Put
putInstruction inst =
  case inst of
    Ins_put_variable_t arg -> putopcode 0 >> putRRX arg
    Ins_put_variable_p arg -> putopcode 1 >> putERX arg
    Ins_put_value_t arg -> putopcode 2 >> putRRX arg
    Ins_put_value_p arg -> putopcode 3 >> putERX arg
    Ins_put_unsafe_value arg -> putopcode 4 >> putERX arg
    Ins_copy_value arg -> putopcode 5 >> putERX arg
    Ins_put_m_const arg -> putopcode 6 >> putRCX arg
    Ins_put_p_const arg -> putopcode 7 >> putRCX arg
    Ins_put_nil arg -> putopcode 8 >> putRX arg
    Ins_put_integer arg -> putopcode 9 >> putRIX arg
    Ins_put_float arg -> putopcode 10 >> putRFX arg
    Ins_put_string arg -> putopcode 11 >> putRSX arg
    Ins_put_index arg -> putopcode 12 >> putRI1X arg
    Ins_put_app arg -> putopcode 13 >> putRRI1X arg
    Ins_put_list arg -> putopcode 14 >> putRX arg
    Ins_put_lambda arg -> putopcode 15 >> putRRI1X arg
    Ins_set_variable_t arg -> putopcode 16 >> putRX arg
    Ins_set_variable_te arg -> putopcode 17 >> putRX arg
    Ins_set_variable_p arg -> putopcode 18 >> putEX arg
    Ins_set_value_t arg -> putopcode 19 >> putRX arg
    Ins_set_value_p arg -> putopcode 20 >> putEX arg
    Ins_globalize_pt arg -> putopcode 21 >> putERX arg
    Ins_globalize_t arg -> putopcode 22 >> putRX arg
    Ins_set_m_const arg -> putopcode 23 >> putCX arg
    Ins_set_p_const arg -> putopcode 24 >> putCX arg
    Ins_set_nil -> putopcode 25
    Ins_set_integer arg -> putopcode 26 >> putIX arg
    Ins_set_float arg -> putopcode 27 >> putFX arg
    Ins_set_string arg -> putopcode 28 >> putSX arg
    Ins_set_index arg -> putopcode 29 >> putI1X arg
    Ins_set_void arg -> putopcode 30 >> putI1X arg
    Ins_deref arg -> putopcode 31 >> putRX arg
    Ins_set_lambda arg -> putopcode 32 >> putRI1X arg
    Ins_get_variable_t arg -> putopcode 33 >> putRRX arg
    Ins_get_variable_p arg -> putopcode 34 >> putERX arg
    Ins_init_variable_t arg -> putopcode 35 >> putRCEX arg
    Ins_init_variable_p arg -> putopcode 36 >> putECEX arg
    Ins_get_m_constant arg -> putopcode 37 >> putRCX arg
    Ins_get_p_constant arg -> putopcode 38 >> putRCLX arg
    Ins_get_integer arg -> putopcode 39 >> putRIX arg
    Ins_get_float arg -> putopcode 40 >> putRFX arg
    Ins_get_string arg -> putopcode 41 >> putRSX arg
    Ins_get_nil arg -> putopcode 42 >> putRX arg
    Ins_get_m_structure arg -> putopcode 43 >> putRCI1X arg
    Ins_get_p_structure arg -> putopcode 44 >> putRCI1X arg
    Ins_get_list arg -> putopcode 45 >> putRX arg
    Ins_unify_variable_t arg -> putopcode 46 >> putRX arg
    Ins_unify_variable_p arg -> putopcode 47 >> putEX arg
    Ins_unify_value_t arg -> putopcode 48 >> putRX arg
    Ins_unify_value_p arg -> putopcode 49 >> putEX arg
    Ins_unify_local_value_t arg -> putopcode 50 >> putRX arg
    Ins_unify_local_value_p arg -> putopcode 51 >> putEX arg
    Ins_unify_m_constant arg -> putopcode 52 >> putCX arg
    Ins_unify_p_constant arg -> putopcode 53 >> putCLX arg
    Ins_unify_integer arg -> putopcode 54 >> putIX arg
    Ins_unify_float arg -> putopcode 55 >> putFX arg
    Ins_unify_string arg -> putopcode 56 >> putSX arg
    Ins_unify_nil -> putopcode 57
    Ins_unify_void arg -> putopcode 58 >> putI1X arg
    Ins_put_type_variable_t arg -> putopcode 59 >> putRRX arg
    Ins_put_type_variable_p arg -> putopcode 60 >> putERX arg
    Ins_put_type_value_t arg -> putopcode 61 >> putRRX arg
    Ins_put_type_value_p arg -> putopcode 62 >> putERX arg
    Ins_put_type_unsafe_value arg -> putopcode 63 >> putERX arg
    Ins_put_type_const arg -> putopcode 64 >> putRKX arg
    Ins_put_type_structure arg -> putopcode 65 >> putRKX arg
    Ins_put_type_arrow arg -> putopcode 66 >> putRX arg
    Ins_set_type_variable_t arg -> putopcode 67 >> putRX arg
    Ins_set_type_variable_p arg -> putopcode 68 >> putEX arg
    Ins_set_type_value_t arg -> putopcode 69 >> putRX arg
    Ins_set_type_value_p arg -> putopcode 70 >> putEX arg
    Ins_set_type_local_value_t arg -> putopcode 71 >> putRX arg
    Ins_set_type_local_value_p arg -> putopcode 72 >> putEX arg
    Ins_set_type_constant arg -> putopcode 73 >> putKX arg
    Ins_get_type_variable_t arg -> putopcode 74 >> putRRX arg
    Ins_get_type_variable_p arg -> putopcode 75 >> putERX arg
    Ins_init_type_variable_t arg -> putopcode 76 >> putRCEX arg
    Ins_init_type_variable_p arg -> putopcode 77 >> putECEX arg
    Ins_get_type_value_t arg -> putopcode 78 >> putRRX arg
    Ins_get_type_value_p arg -> putopcode 79 >> putERX arg
    Ins_get_type_constant arg -> putopcode 80 >> putRKX arg
    Ins_get_type_structure arg -> putopcode 81 >> putRKX arg
    Ins_get_type_arrow arg -> putopcode 82 >> putRX arg
    Ins_unify_type_variable_t arg -> putopcode 83 >> putRX arg
    Ins_unify_type_variable_p arg -> putopcode 84 >> putEX arg
    Ins_unify_type_value_t arg -> putopcode 85 >> putRX arg
    Ins_unify_type_value_p arg -> putopcode 86 >> putEX arg
    Ins_unify_envty_value_t arg -> putopcode 87 >> putRX arg
    Ins_unify_envty_value_p arg -> putopcode 88 >> putEX arg
    Ins_unify_type_local_value_t arg -> putopcode 89 >> putRX arg
    Ins_unify_type_local_value_p arg -> putopcode 90 >> putEX arg
    Ins_unify_envty_local_value_t arg -> putopcode 91 >> putRX arg
    Ins_unify_envty_local_value_p arg -> putopcode 92 >> putEX arg
    Ins_unify_type_constant arg -> putopcode 93 >> putKX arg
    Ins_pattern_unify_t arg -> putopcode 94 >> putRRX arg
    Ins_pattern_unify_p arg -> putopcode 95 >> putERX arg
    Ins_finish_unify -> putopcode 96
    Ins_head_normalize_t arg -> putopcode 97 >> putRX arg
    Ins_head_normalize_p arg -> putopcode 98 >> putEX arg
    Ins_incr_universe -> putopcode 99
    Ins_decr_universe -> putopcode 100
    Ins_set_univ_tag arg -> putopcode 101 >> putECX arg
    Ins_tag_exists_t arg -> putopcode 102 >> putRX arg
    Ins_tag_exists_p arg -> putopcode 103 >> putEX arg
    Ins_tag_variable arg -> putopcode 104 >> putEX arg
    Ins_push_impl_point arg -> putopcode 105 >> putI1ITX arg
    Ins_pop_impl_point -> putopcode 106
    Ins_add_imports arg -> putopcode 107 >> putSEGI1LX arg
    Ins_remove_imports arg -> putopcode 108 >> putSEGLX arg
    Ins_push_import arg -> putopcode 109 >> putMTX arg
    Ins_pop_imports arg -> putopcode 110 >> putI1X arg
    Ins_allocate arg -> putopcode 111 >> putI1X arg
    Ins_deallocate -> putopcode 112
    Ins_call arg -> putopcode 113 >> putI1LX arg
    Ins_call_name arg -> putopcode 114 >> putI1CWPX arg
    Ins_execute arg -> putopcode 115 >> putLX arg
    Ins_execute_name arg -> putopcode 116 >> putCWPX arg
    Ins_proceed -> putopcode 117
    Ins_try_me_else arg -> putopcode 118 >> putI1LX arg
    Ins_retry_me_else arg -> putopcode 119 >> putI1LX arg
    Ins_trust_me arg -> putopcode 120 >> putI1WPX arg
    Ins_try arg -> putopcode 121 >> putI1LX arg
    Ins_retry arg -> putopcode 122 >> putI1LX arg
    Ins_trust arg -> putopcode 123 >> putI1LWPX arg
    Ins_trust_ext arg -> putopcode 124 >> putI1NX arg
    Ins_try_else arg -> putopcode 125 >> putI1LLX arg
    Ins_retry_else arg -> putopcode 126 >> putI1LLX arg
    Ins_branch arg -> putopcode 127 >> putLX arg
    Ins_switch_on_term arg -> putopcode 128 >> putLLLLX arg
    Ins_switch_on_constant arg -> putopcode 129 >> putI1HTX arg
    Ins_switch_on_bvar arg -> putopcode 130 >> putI1BVTX arg
    Ins_switch_on_reg arg -> putopcode 131 >> putNLLX arg
    Ins_neck_cut -> putopcode 132
    Ins_get_level arg -> putopcode 133 >> putEX arg
    Ins_put_level arg -> putopcode 134 >> putEX arg
    Ins_cut arg -> putopcode 135 >> putEX arg
    Ins_call_builtin arg -> putopcode 136 >> putI1I1WPX arg
    Ins_builtin arg -> putopcode 137 >> putI1X arg
    Ins_stop -> putopcode 138
    Ins_halt -> putopcode 139
    Ins_fail -> putopcode 140
    Ins_create_type_variable arg -> putopcode 141 >> putEX arg
    Ins_execute_link_only arg -> putopcode 142 >> putCWPX arg
    Ins_call_link_only arg -> putopcode 143 >> putI1CWPX arg
    Ins_put_variable_te arg -> putopcode 144 >> putRRX arg

getInstruction :: Get (Instruction,Int)
getInstruction = do
  opcode <- getopcode
  case opcode of
     0 -> getRRX >>= \x -> return (Ins_put_variable_t x, inscatRRX_LEN)
     1 -> getERX >>= \x -> return (Ins_put_variable_p x, inscatERX_LEN)
     2 -> getRRX >>= \x -> return (Ins_put_value_t x, inscatRRX_LEN)
     3 -> getERX >>= \x -> return (Ins_put_value_p x, inscatERX_LEN)
     4 -> getERX >>= \x -> return (Ins_put_unsafe_value x, inscatERX_LEN)
     5 -> getERX >>= \x -> return (Ins_copy_value x, inscatERX_LEN)
     6 -> getRCX >>= \x -> return (Ins_put_m_const x, inscatRCX_LEN)
     7 -> getRCX >>= \x -> return (Ins_put_p_const x, inscatRCX_LEN)
     8 -> getRX >>= \x -> return (Ins_put_nil x, inscatRX_LEN)
     9 -> getRIX >>= \x -> return (Ins_put_integer x, inscatRIX_LEN)
     10 -> getRFX >>= \x -> return (Ins_put_float x, inscatRFX_LEN)
     11 -> getRSX >>= \x -> return (Ins_put_string x, inscatRSX_LEN)
     12 -> getRI1X >>= \x -> return (Ins_put_index x, inscatRI1X_LEN)
     13 -> getRRI1X >>= \x -> return (Ins_put_app x, inscatRRI1X_LEN)
     14 -> getRX >>= \x -> return (Ins_put_list x, inscatRX_LEN)
     15 -> getRRI1X >>= \x -> return (Ins_put_lambda x, inscatRRI1X_LEN)
     16 -> getRX >>= \x -> return (Ins_set_variable_t x, inscatRX_LEN)
     17 -> getRX >>= \x -> return (Ins_set_variable_te x, inscatRX_LEN)
     18 -> getEX >>= \x -> return (Ins_set_variable_p x, inscatEX_LEN)
     19 -> getRX >>= \x -> return (Ins_set_value_t x, inscatRX_LEN)
     20 -> getEX >>= \x -> return (Ins_set_value_p x, inscatEX_LEN)
     21 -> getERX >>= \x -> return (Ins_globalize_pt x, inscatERX_LEN)
     22 -> getRX >>= \x -> return (Ins_globalize_t x, inscatRX_LEN)
     23 -> getCX >>= \x -> return (Ins_set_m_const x, inscatCX_LEN)
     24 -> getCX >>= \x -> return (Ins_set_p_const x, inscatCX_LEN)
     25 -> return (Ins_set_nil, inscatX_LEN)
     26 -> getIX >>= \x -> return (Ins_set_integer x, inscatIX_LEN)
     27 -> getFX >>= \x -> return (Ins_set_float x, inscatFX_LEN)
     28 -> getSX >>= \x -> return (Ins_set_string x, inscatSX_LEN)
     29 -> getI1X >>= \x -> return (Ins_set_index x, inscatI1X_LEN)
     30 -> getI1X >>= \x -> return (Ins_set_void x, inscatI1X_LEN)
     31 -> getRX >>= \x -> return (Ins_deref x, inscatRX_LEN)
     32 -> getRI1X >>= \x -> return (Ins_set_lambda x, inscatRI1X_LEN)
     33 -> getRRX >>= \x -> return (Ins_get_variable_t x, inscatRRX_LEN)
     34 -> getERX >>= \x -> return (Ins_get_variable_p x, inscatERX_LEN)
     35 -> getRCEX >>= \x -> return (Ins_init_variable_t x, inscatRCEX_LEN)
     36 -> getECEX >>= \x -> return (Ins_init_variable_p x, inscatECEX_LEN)
     37 -> getRCX >>= \x -> return (Ins_get_m_constant x, inscatRCX_LEN)
     38 -> getRCLX >>= \x -> return (Ins_get_p_constant x, inscatRCLX_LEN)
     39 -> getRIX >>= \x -> return (Ins_get_integer x, inscatRIX_LEN)
     40 -> getRFX >>= \x -> return (Ins_get_float x, inscatRFX_LEN)
     41 -> getRSX >>= \x -> return (Ins_get_string x, inscatRSX_LEN)
     42 -> getRX >>= \x -> return (Ins_get_nil x, inscatRX_LEN)
     43 -> getRCI1X >>= \x -> return (Ins_get_m_structure x, inscatRCI1X_LEN)
     44 -> getRCI1X >>= \x -> return (Ins_get_p_structure x, inscatRCI1X_LEN)
     45 -> getRX >>= \x -> return (Ins_get_list x, inscatRX_LEN)
     46 -> getRX >>= \x -> return (Ins_unify_variable_t x, inscatRX_LEN)
     47 -> getEX >>= \x -> return (Ins_unify_variable_p x, inscatEX_LEN)
     48 -> getRX >>= \x -> return (Ins_unify_value_t x, inscatRX_LEN)
     49 -> getEX >>= \x -> return (Ins_unify_value_p x, inscatEX_LEN)
     50 -> getRX >>= \x -> return (Ins_unify_local_value_t x, inscatRX_LEN)
     51 -> getEX >>= \x -> return (Ins_unify_local_value_p x, inscatEX_LEN)
     52 -> getCX >>= \x -> return (Ins_unify_m_constant x, inscatCX_LEN)
     53 -> getCLX >>= \x -> return (Ins_unify_p_constant x, inscatCLX_LEN)
     54 -> getIX >>= \x -> return (Ins_unify_integer x, inscatIX_LEN)
     55 -> getFX >>= \x -> return (Ins_unify_float x, inscatFX_LEN)
     56 -> getSX >>= \x -> return (Ins_unify_string x, inscatSX_LEN)
     57 -> return (Ins_unify_nil, inscatX_LEN)
     58 -> getI1X >>= \x -> return (Ins_unify_void x, inscatI1X_LEN)
     59 -> getRRX >>= \x -> return (Ins_put_type_variable_t x, inscatRRX_LEN)
     60 -> getERX >>= \x -> return (Ins_put_type_variable_p x, inscatERX_LEN)
     61 -> getRRX >>= \x -> return (Ins_put_type_value_t x, inscatRRX_LEN)
     62 -> getERX >>= \x -> return (Ins_put_type_value_p x, inscatERX_LEN)
     63 -> getERX >>= \x -> return (Ins_put_type_unsafe_value x, inscatERX_LEN)
     64 -> getRKX >>= \x -> return (Ins_put_type_const x, inscatRKX_LEN)
     65 -> getRKX >>= \x -> return (Ins_put_type_structure x, inscatRKX_LEN)
     66 -> getRX >>= \x -> return (Ins_put_type_arrow x, inscatRX_LEN)
     67 -> getRX >>= \x -> return (Ins_set_type_variable_t x, inscatRX_LEN)
     68 -> getEX >>= \x -> return (Ins_set_type_variable_p x, inscatEX_LEN)
     69 -> getRX >>= \x -> return (Ins_set_type_value_t x, inscatRX_LEN)
     70 -> getEX >>= \x -> return (Ins_set_type_value_p x, inscatEX_LEN)
     71 -> getRX >>= \x -> return (Ins_set_type_local_value_t x, inscatRX_LEN)
     72 -> getEX >>= \x -> return (Ins_set_type_local_value_p x, inscatEX_LEN)
     73 -> getKX >>= \x -> return (Ins_set_type_constant x, inscatKX_LEN)
     74 -> getRRX >>= \x -> return (Ins_get_type_variable_t x, inscatRRX_LEN)
     75 -> getERX >>= \x -> return (Ins_get_type_variable_p x, inscatERX_LEN)
     76 -> getRCEX >>= \x -> return (Ins_init_type_variable_t x, inscatRCEX_LEN)
     77 -> getECEX >>= \x -> return (Ins_init_type_variable_p x, inscatECEX_LEN)
     78 -> getRRX >>= \x -> return (Ins_get_type_value_t x, inscatRRX_LEN)
     79 -> getERX >>= \x -> return (Ins_get_type_value_p x, inscatERX_LEN)
     80 -> getRKX >>= \x -> return (Ins_get_type_constant x, inscatRKX_LEN)
     81 -> getRKX >>= \x -> return (Ins_get_type_structure x, inscatRKX_LEN)
     82 -> getRX >>= \x -> return (Ins_get_type_arrow x, inscatRX_LEN)
     83 -> getRX >>= \x -> return (Ins_unify_type_variable_t x, inscatRX_LEN)
     84 -> getEX >>= \x -> return (Ins_unify_type_variable_p x, inscatEX_LEN)
     85 -> getRX >>= \x -> return (Ins_unify_type_value_t x, inscatRX_LEN)
     86 -> getEX >>= \x -> return (Ins_unify_type_value_p x, inscatEX_LEN)
     87 -> getRX >>= \x -> return (Ins_unify_envty_value_t x, inscatRX_LEN)
     88 -> getEX >>= \x -> return (Ins_unify_envty_value_p x, inscatEX_LEN)
     89 -> getRX >>= \x -> return (Ins_unify_type_local_value_t x, inscatRX_LEN)
     90 -> getEX >>= \x -> return (Ins_unify_type_local_value_p x, inscatEX_LEN)
     91 -> getRX >>= \x -> return (Ins_unify_envty_local_value_t x, inscatRX_LEN)
     92 -> getEX >>= \x -> return (Ins_unify_envty_local_value_p x, inscatEX_LEN)
     93 -> getKX >>= \x -> return (Ins_unify_type_constant x, inscatKX_LEN)
     94 -> getRRX >>= \x -> return (Ins_pattern_unify_t x, inscatRRX_LEN)
     95 -> getERX >>= \x -> return (Ins_pattern_unify_p x, inscatERX_LEN)
     96 -> return (Ins_finish_unify, inscatX_LEN)
     97 -> getRX >>= \x -> return (Ins_head_normalize_t x, inscatRX_LEN)
     98 -> getEX >>= \x -> return (Ins_head_normalize_p x, inscatEX_LEN)
     99 -> return (Ins_incr_universe, inscatX_LEN)
     100 -> return (Ins_decr_universe, inscatX_LEN)
     101 -> getECX >>= \x -> return (Ins_set_univ_tag x, inscatECX_LEN)
     102 -> getRX >>= \x -> return (Ins_tag_exists_t x, inscatRX_LEN)
     103 -> getEX >>= \x -> return (Ins_tag_exists_p x, inscatEX_LEN)
     104 -> getEX >>= \x -> return (Ins_tag_variable x, inscatEX_LEN)
     105 -> getI1ITX >>= \x -> return (Ins_push_impl_point x, inscatI1ITX_LEN)
     106 -> return (Ins_pop_impl_point, inscatX_LEN)
     107 -> getSEGI1LX >>= \x -> return (Ins_add_imports x, inscatSEGI1LX_LEN)
     108 -> getSEGLX >>= \x -> return (Ins_remove_imports x, inscatSEGLX_LEN)
     109 -> getMTX >>= \x -> return (Ins_push_import x, inscatMTX_LEN)
     110 -> getI1X >>= \x -> return (Ins_pop_imports x, inscatI1X_LEN)
     111 -> getI1X >>= \x -> return (Ins_allocate x, inscatI1X_LEN)
     112 -> return (Ins_deallocate, inscatX_LEN)
     113 -> getI1LX >>= \x -> return (Ins_call x, inscatI1LX_LEN)
     114 -> getI1CWPX >>= \x -> return (Ins_call_name x, inscatI1CWPX_LEN)
     115 -> getLX >>= \x -> return (Ins_execute x, inscatLX_LEN)
     116 -> getCWPX >>= \x -> return (Ins_execute_name x, inscatCWPX_LEN)
     117 -> return (Ins_proceed, inscatX_LEN)
     118 -> getI1LX >>= \x -> return (Ins_try_me_else x, inscatI1LX_LEN)
     119 -> getI1LX >>= \x -> return (Ins_retry_me_else x, inscatI1LX_LEN)
     120 -> getI1WPX >>= \x -> return (Ins_trust_me x, inscatI1WPX_LEN)
     121 -> getI1LX >>= \x -> return (Ins_try x, inscatI1LX_LEN)
     122 -> getI1LX >>= \x -> return (Ins_retry x, inscatI1LX_LEN)
     123 -> getI1LWPX >>= \x -> return (Ins_trust x, inscatI1LWPX_LEN)
     124 -> getI1NX >>= \x -> return (Ins_trust_ext x, inscatI1NX_LEN)
     125 -> getI1LLX >>= \x -> return (Ins_try_else x, inscatI1LLX_LEN)
     126 -> getI1LLX >>= \x -> return (Ins_retry_else x, inscatI1LLX_LEN)
     127 -> getLX >>= \x -> return (Ins_branch x, inscatLX_LEN)
     128 -> getLLLLX >>= \x -> return (Ins_switch_on_term x, inscatLLLLX_LEN)
     129 -> getI1HTX >>= \x -> return (Ins_switch_on_constant x, inscatI1HTX_LEN)
     130 -> getI1BVTX >>= \x -> return (Ins_switch_on_bvar x, inscatI1BVTX_LEN)
     131 -> getNLLX >>= \x -> return (Ins_switch_on_reg x, inscatNLLX_LEN)
     132 -> return (Ins_neck_cut, inscatX_LEN)
     133 -> getEX >>= \x -> return (Ins_get_level x, inscatEX_LEN)
     134 -> getEX >>= \x -> return (Ins_put_level x, inscatEX_LEN)
     135 -> getEX >>= \x -> return (Ins_cut x, inscatEX_LEN)
     136 -> getI1I1WPX >>= \x -> return (Ins_call_builtin x, inscatI1I1WPX_LEN)
     137 -> getI1X >>= \x -> return (Ins_builtin x, inscatI1X_LEN)
     138 -> return (Ins_stop, inscatX_LEN)
     139 -> return (Ins_halt, inscatX_LEN)
     140 -> return (Ins_fail, inscatX_LEN)
     141 -> getEX >>= \x -> return (Ins_create_type_variable x, inscatEX_LEN)
     142 -> getCWPX >>= \x -> return (Ins_execute_link_only x, inscatCWPX_LEN)
     143 -> getI1CWPX >>= \x -> return (Ins_call_link_only x, inscatI1CWPX_LEN)
     144 -> getRRX >>= \x -> return (Ins_put_variable_te x, inscatRRX_LEN)


showInstruction :: Instruction -> (String, Int)
showInstruction inst =
  case inst of
    Ins_put_variable_t arg -> ("put_variable_t           " ++ displayRRX arg, inscatRRX_LEN)
    Ins_put_variable_p arg -> ("put_variable_p           " ++ displayERX arg, inscatERX_LEN)
    Ins_put_value_t arg -> ("put_value_t              " ++ displayRRX arg, inscatRRX_LEN)
    Ins_put_value_p arg -> ("put_value_p              " ++ displayERX arg, inscatERX_LEN)
    Ins_put_unsafe_value arg -> ("put_unsafe_value         " ++ displayERX arg, inscatERX_LEN)
    Ins_copy_value arg -> ("copy_value               " ++ displayERX arg, inscatERX_LEN)
    Ins_put_m_const arg -> ("put_m_const              " ++ displayRCX arg, inscatRCX_LEN)
    Ins_put_p_const arg -> ("put_p_const              " ++ displayRCX arg, inscatRCX_LEN)
    Ins_put_nil arg -> ("put_nil                  " ++ displayRX arg, inscatRX_LEN)
    Ins_put_integer arg -> ("put_integer              " ++ displayRIX arg, inscatRIX_LEN)
    Ins_put_float arg -> ("put_float                " ++ displayRFX arg, inscatRFX_LEN)
    Ins_put_string arg -> ("put_string               " ++ displayRSX arg, inscatRSX_LEN)
    Ins_put_index arg -> ("put_index                " ++ displayRI1X arg, inscatRI1X_LEN)
    Ins_put_app arg -> ("put_app                  " ++ displayRRI1X arg, inscatRRI1X_LEN)
    Ins_put_list arg -> ("put_list                 " ++ displayRX arg, inscatRX_LEN)
    Ins_put_lambda arg -> ("put_lambda               " ++ displayRRI1X arg, inscatRRI1X_LEN)
    Ins_set_variable_t arg -> ("set_variable_t           " ++ displayRX arg, inscatRX_LEN)
    Ins_set_variable_te arg -> ("set_variable_te          " ++ displayRX arg, inscatRX_LEN)
    Ins_set_variable_p arg -> ("set_variable_p           " ++ displayEX arg, inscatEX_LEN)
    Ins_set_value_t arg -> ("set_value_t              " ++ displayRX arg, inscatRX_LEN)
    Ins_set_value_p arg -> ("set_value_p              " ++ displayEX arg, inscatEX_LEN)
    Ins_globalize_pt arg -> ("globalize_pt             " ++ displayERX arg, inscatERX_LEN)
    Ins_globalize_t arg -> ("globalize_t              " ++ displayRX arg, inscatRX_LEN)
    Ins_set_m_const arg -> ("set_m_const              " ++ displayCX arg, inscatCX_LEN)
    Ins_set_p_const arg -> ("set_p_const              " ++ displayCX arg, inscatCX_LEN)
    Ins_set_nil -> ("set_nil                  ", inscatX_LEN)
    Ins_set_integer arg -> ("set_integer              " ++ displayIX arg, inscatIX_LEN)
    Ins_set_float arg -> ("set_float                " ++ displayFX arg, inscatFX_LEN)
    Ins_set_string arg -> ("set_string               " ++ displaySX arg, inscatSX_LEN)
    Ins_set_index arg -> ("set_index                " ++ displayI1X arg, inscatI1X_LEN)
    Ins_set_void arg -> ("set_void                 " ++ displayI1X arg, inscatI1X_LEN)
    Ins_deref arg -> ("deref                    " ++ displayRX arg, inscatRX_LEN)
    Ins_set_lambda arg -> ("set_lambda               " ++ displayRI1X arg, inscatRI1X_LEN)
    Ins_get_variable_t arg -> ("get_variable_t           " ++ displayRRX arg, inscatRRX_LEN)
    Ins_get_variable_p arg -> ("get_variable_p           " ++ displayERX arg, inscatERX_LEN)
    Ins_init_variable_t arg -> ("init_variable_t          " ++ displayRCEX arg, inscatRCEX_LEN)
    Ins_init_variable_p arg -> ("init_variable_p          " ++ displayECEX arg, inscatECEX_LEN)
    Ins_get_m_constant arg -> ("get_m_constant           " ++ displayRCX arg, inscatRCX_LEN)
    Ins_get_p_constant arg -> ("get_p_constant           " ++ displayRCLX arg, inscatRCLX_LEN)
    Ins_get_integer arg -> ("get_integer              " ++ displayRIX arg, inscatRIX_LEN)
    Ins_get_float arg -> ("get_float                " ++ displayRFX arg, inscatRFX_LEN)
    Ins_get_string arg -> ("get_string               " ++ displayRSX arg, inscatRSX_LEN)
    Ins_get_nil arg -> ("get_nil                  " ++ displayRX arg, inscatRX_LEN)
    Ins_get_m_structure arg -> ("get_m_structure          " ++ displayRCI1X arg, inscatRCI1X_LEN)
    Ins_get_p_structure arg -> ("get_p_structure          " ++ displayRCI1X arg, inscatRCI1X_LEN)
    Ins_get_list arg -> ("get_list                 " ++ displayRX arg, inscatRX_LEN)
    Ins_unify_variable_t arg -> ("unify_variable_t         " ++ displayRX arg, inscatRX_LEN)
    Ins_unify_variable_p arg -> ("unify_variable_p         " ++ displayEX arg, inscatEX_LEN)
    Ins_unify_value_t arg -> ("unify_value_t            " ++ displayRX arg, inscatRX_LEN)
    Ins_unify_value_p arg -> ("unify_value_p            " ++ displayEX arg, inscatEX_LEN)
    Ins_unify_local_value_t arg -> ("unify_local_value_t      " ++ displayRX arg, inscatRX_LEN)
    Ins_unify_local_value_p arg -> ("unify_local_value_p      " ++ displayEX arg, inscatEX_LEN)
    Ins_unify_m_constant arg -> ("unify_m_constant         " ++ displayCX arg, inscatCX_LEN)
    Ins_unify_p_constant arg -> ("unify_p_constant         " ++ displayCLX arg, inscatCLX_LEN)
    Ins_unify_integer arg -> ("unify_integer            " ++ displayIX arg, inscatIX_LEN)
    Ins_unify_float arg -> ("unify_float              " ++ displayFX arg, inscatFX_LEN)
    Ins_unify_string arg -> ("unify_string             " ++ displaySX arg, inscatSX_LEN)
    Ins_unify_nil -> ("unify_nil                ", inscatX_LEN)
    Ins_unify_void arg -> ("unify_void               " ++ displayI1X arg, inscatI1X_LEN)
    Ins_put_type_variable_t arg -> ("put_type_variable_t      " ++ displayRRX arg, inscatRRX_LEN)
    Ins_put_type_variable_p arg -> ("put_type_variable_p      " ++ displayERX arg, inscatERX_LEN)
    Ins_put_type_value_t arg -> ("put_type_value_t         " ++ displayRRX arg, inscatRRX_LEN)
    Ins_put_type_value_p arg -> ("put_type_value_p         " ++ displayERX arg, inscatERX_LEN)
    Ins_put_type_unsafe_value arg -> ("put_type_unsafe_value    " ++ displayERX arg, inscatERX_LEN)
    Ins_put_type_const arg -> ("put_type_const           " ++ displayRKX arg, inscatRKX_LEN)
    Ins_put_type_structure arg -> ("put_type_structure       " ++ displayRKX arg, inscatRKX_LEN)
    Ins_put_type_arrow arg -> ("put_type_arrow           " ++ displayRX arg, inscatRX_LEN)
    Ins_set_type_variable_t arg -> ("set_type_variable_t      " ++ displayRX arg, inscatRX_LEN)
    Ins_set_type_variable_p arg -> ("set_type_variable_p      " ++ displayEX arg, inscatEX_LEN)
    Ins_set_type_value_t arg -> ("set_type_value_t         " ++ displayRX arg, inscatRX_LEN)
    Ins_set_type_value_p arg -> ("set_type_value_p         " ++ displayEX arg, inscatEX_LEN)
    Ins_set_type_local_value_t arg -> ("set_type_local_value_t   " ++ displayRX arg, inscatRX_LEN)
    Ins_set_type_local_value_p arg -> ("set_type_local_value_p   " ++ displayEX arg, inscatEX_LEN)
    Ins_set_type_constant arg -> ("set_type_constant        " ++ displayKX arg, inscatKX_LEN)
    Ins_get_type_variable_t arg -> ("get_type_variable_t      " ++ displayRRX arg, inscatRRX_LEN)
    Ins_get_type_variable_p arg -> ("get_type_variable_p      " ++ displayERX arg, inscatERX_LEN)
    Ins_init_type_variable_t arg -> ("init_type_variable_t     " ++ displayRCEX arg, inscatRCEX_LEN)
    Ins_init_type_variable_p arg -> ("init_type_variable_p     " ++ displayECEX arg, inscatECEX_LEN)
    Ins_get_type_value_t arg -> ("get_type_value_t         " ++ displayRRX arg, inscatRRX_LEN)
    Ins_get_type_value_p arg -> ("get_type_value_p         " ++ displayERX arg, inscatERX_LEN)
    Ins_get_type_constant arg -> ("get_type_constant        " ++ displayRKX arg, inscatRKX_LEN)
    Ins_get_type_structure arg -> ("get_type_structure       " ++ displayRKX arg, inscatRKX_LEN)
    Ins_get_type_arrow arg -> ("get_type_arrow           " ++ displayRX arg, inscatRX_LEN)
    Ins_unify_type_variable_t arg -> ("unify_type_variable_t    " ++ displayRX arg, inscatRX_LEN)
    Ins_unify_type_variable_p arg -> ("unify_type_variable_p    " ++ displayEX arg, inscatEX_LEN)
    Ins_unify_type_value_t arg -> ("unify_type_value_t       " ++ displayRX arg, inscatRX_LEN)
    Ins_unify_type_value_p arg -> ("unify_type_value_p       " ++ displayEX arg, inscatEX_LEN)
    Ins_unify_envty_value_t arg -> ("unify_envty_value_t      " ++ displayRX arg, inscatRX_LEN)
    Ins_unify_envty_value_p arg -> ("unify_envty_value_p      " ++ displayEX arg, inscatEX_LEN)
    Ins_unify_type_local_value_t arg -> ("unify_type_local_value_t " ++ displayRX arg, inscatRX_LEN)
    Ins_unify_type_local_value_p arg -> ("unify_type_local_value_p " ++ displayEX arg, inscatEX_LEN)
    Ins_unify_envty_local_value_t arg -> ("unify_envty_local_value_t " ++ displayRX arg, inscatRX_LEN)
    Ins_unify_envty_local_value_p arg -> ("unify_envty_local_value_p " ++ displayEX arg, inscatEX_LEN)
    Ins_unify_type_constant arg -> ("unify_type_constant      " ++ displayKX arg, inscatKX_LEN)
    Ins_pattern_unify_t arg -> ("pattern_unify_t          " ++ displayRRX arg, inscatRRX_LEN)
    Ins_pattern_unify_p arg -> ("pattern_unify_p          " ++ displayERX arg, inscatERX_LEN)
    Ins_finish_unify -> ("finish_unify             ", inscatX_LEN)
    Ins_head_normalize_t arg -> ("head_normalize_t         " ++ displayRX arg, inscatRX_LEN)
    Ins_head_normalize_p arg -> ("head_normalize_p         " ++ displayEX arg, inscatEX_LEN)
    Ins_incr_universe -> ("incr_universe            ", inscatX_LEN)
    Ins_decr_universe -> ("decr_universe            ", inscatX_LEN)
    Ins_set_univ_tag arg -> ("set_univ_tag             " ++ displayECX arg, inscatECX_LEN)
    Ins_tag_exists_t arg -> ("tag_exists_t             " ++ displayRX arg, inscatRX_LEN)
    Ins_tag_exists_p arg -> ("tag_exists_p             " ++ displayEX arg, inscatEX_LEN)
    Ins_tag_variable arg -> ("tag_variable             " ++ displayEX arg, inscatEX_LEN)
    Ins_push_impl_point arg -> ("push_impl_point          " ++ displayI1ITX arg, inscatI1ITX_LEN)
    Ins_pop_impl_point -> ("pop_impl_point           ", inscatX_LEN)
    Ins_add_imports arg -> ("add_imports              " ++ displaySEGI1LX arg, inscatSEGI1LX_LEN)
    Ins_remove_imports arg -> ("remove_imports           " ++ displaySEGLX arg, inscatSEGLX_LEN)
    Ins_push_import arg -> ("push_import              " ++ displayMTX arg, inscatMTX_LEN)
    Ins_pop_imports arg -> ("pop_imports              " ++ displayI1X arg, inscatI1X_LEN)
    Ins_allocate arg -> ("allocate                 " ++ displayI1X arg, inscatI1X_LEN)
    Ins_deallocate -> ("deallocate               ", inscatX_LEN)
    Ins_call arg -> ("call                     " ++ displayI1LX arg, inscatI1LX_LEN)
    Ins_call_name arg -> ("call_name                " ++ displayI1CWPX arg, inscatI1CWPX_LEN)
    Ins_execute arg -> ("execute                  " ++ displayLX arg, inscatLX_LEN)
    Ins_execute_name arg -> ("execute_name             " ++ displayCWPX arg, inscatCWPX_LEN)
    Ins_proceed -> ("proceed                  ", inscatX_LEN)
    Ins_try_me_else arg -> ("try_me_else              " ++ displayI1LX arg, inscatI1LX_LEN)
    Ins_retry_me_else arg -> ("retry_me_else            " ++ displayI1LX arg, inscatI1LX_LEN)
    Ins_trust_me arg -> ("trust_me                 " ++ displayI1WPX arg, inscatI1WPX_LEN)
    Ins_try arg -> ("try                      " ++ displayI1LX arg, inscatI1LX_LEN)
    Ins_retry arg -> ("retry                    " ++ displayI1LX arg, inscatI1LX_LEN)
    Ins_trust arg -> ("trust                    " ++ displayI1LWPX arg, inscatI1LWPX_LEN)
    Ins_trust_ext arg -> ("trust_ext                " ++ displayI1NX arg, inscatI1NX_LEN)
    Ins_try_else arg -> ("try_else                 " ++ displayI1LLX arg, inscatI1LLX_LEN)
    Ins_retry_else arg -> ("retry_else               " ++ displayI1LLX arg, inscatI1LLX_LEN)
    Ins_branch arg -> ("branch                   " ++ displayLX arg, inscatLX_LEN)
    Ins_switch_on_term arg -> ("switch_on_term           " ++ displayLLLLX arg, inscatLLLLX_LEN)
    Ins_switch_on_constant arg -> ("switch_on_constant       " ++ displayI1HTX arg, inscatI1HTX_LEN)
    Ins_switch_on_bvar arg -> ("switch_on_bvar           " ++ displayI1BVTX arg, inscatI1BVTX_LEN)
    Ins_switch_on_reg arg -> ("switch_on_reg            " ++ displayNLLX arg, inscatNLLX_LEN)
    Ins_neck_cut -> ("neck_cut                 ", inscatX_LEN)
    Ins_get_level arg -> ("get_level                " ++ displayEX arg, inscatEX_LEN)
    Ins_put_level arg -> ("put_level                " ++ displayEX arg, inscatEX_LEN)
    Ins_cut arg -> ("cut                      " ++ displayEX arg, inscatEX_LEN)
    Ins_call_builtin arg -> ("call_builtin             " ++ displayI1I1WPX arg, inscatI1I1WPX_LEN)
    Ins_builtin arg -> ("builtin                  " ++ displayI1X arg, inscatI1X_LEN)
    Ins_stop -> ("stop                     ", inscatX_LEN)
    Ins_halt -> ("halt                     ", inscatX_LEN)
    Ins_fail -> ("fail                     ", inscatX_LEN)
    Ins_create_type_variable arg -> ("create_type_variable     " ++ displayEX arg, inscatEX_LEN)
    Ins_execute_link_only arg -> ("execute_link_only        " ++ displayCWPX arg, inscatCWPX_LEN)
    Ins_call_link_only arg -> ("call_link_only           " ++ displayI1CWPX arg, inscatI1CWPX_LEN)
    Ins_put_variable_te arg -> ("put_variable_te          " ++ displayRRX arg, inscatRRX_LEN)