module GF.Compile.GenerateBC(generateByteCode) where

import GF.Grammar
import GF.Compile.Instructions
import PGF.Data

import Data.Maybe
import qualified Data.IntMap as IntMap
import qualified Data.ByteString as BSS
import qualified Data.ByteString.Lazy as BS
import Data.Binary

generateByteCode :: [(QIdent,Info)] -> ([(QIdent,Info,BCAddr)], BSS.ByteString)
generateByteCode = runGenM . mapM genFun

type BCLabel = (Int, BCAddr)

genFun (id,info@(AbsFun (Just (L _ ty)) ma pty _)) = do
  l1 <- newLabel
{-  emitLabel l1
  emit Ins_fail
  l2 <- newLabel
  l3 <- newLabel
  emit (Ins_switch_on_reg (1,addr l2,addr l3))
  emitLabel l2
  emit (Ins_try (1,addr l3))
  emit (Ins_trust_ext (1,1))
  emit (Ins_try_me_else (0,addr l1))
  emitLabel l3
  l4 <- newLabel
  l5 <- newLabel
  emit (Ins_switch_on_term (addr l4,addr l5,addr l1,addr l4))
  emitLabel l4
  emitLabel l5-}
  return (id,info,addr l1)
genFun (id,info@(AbsCat (Just (L _ cont)))) = do
  l1 <- newLabel
  return (id,info,addr l1)
genFun (id,info) = do
  l1 <- newLabel
  return (id,info,addr l1)

newtype GenM a = GenM {unGenM :: IntMap.IntMap BCAddr ->
                                 IntMap.IntMap BCAddr ->
                                 [Instruction] -> 
                                 (a,IntMap.IntMap BCAddr,[Instruction])}

instance Monad GenM where
  return x = GenM (\fm cm is -> (x,cm,is))
  f >>= g  = GenM (\fm cm is -> case unGenM f fm cm is of
                                  (x,cm,is) -> unGenM (g x) fm cm is)

runGenM :: GenM a -> (a, BSS.ByteString)
runGenM f = 
  let (x, cm, is) = unGenM f cm IntMap.empty []
  in (x, BSS.concat (BS.toChunks (encode (BC (reverse is)))))

emit :: Instruction -> GenM ()
emit i = GenM (\fm cm is -> ((), cm, i:is))

newLabel :: GenM BCLabel
newLabel = GenM (\fm cm is -> 
  let lbl  = IntMap.size cm
      addr = fromMaybe (error "newLabel") (IntMap.lookup lbl fm)
  in ((lbl,addr), IntMap.insert lbl 0 cm, is))

emitLabel :: BCLabel -> GenM ()
emitLabel (lbl,addr) = GenM (\fm cm is ->
  ((), IntMap.insert lbl (length is) cm, is))

addr :: BCLabel -> BCAddr
addr (lbl,addr) = addr

data ByteCode = BC [Instruction]

instance Binary ByteCode where
  put (BC is) = mapM_ putInstruction is
  get = error "get ByteCode"
