module GF.Conversion.FTypes where

import qualified GF.Canon.GFCC.AbsGFCC as AbsGFCC (CId(..))

import GF.Formalism.FCFG
import GF.Formalism.Utilities
import GF.Infra.PrintClass
import GF.Data.Assoc

import Control.Monad (foldM)
import Data.Array

----------------------------------------------------------------------
-- * basic (leaf) types

-- ** input tokens

---- type Token = String ---- inlined in FGrammar and FRule


----------------------------------------------------------------------
-- * fast nonerasing MCFG

type FIndex   = Int
type FPath    = [FIndex]
type FName    = NameProfile AbsGFCC.CId
type FGrammar = FCFGrammar FCat FName String
type FRule    = FCFRule    FCat FName String
data FCat     = FCat  {-# UNPACK #-} !Int AbsGFCC.CId [FPath] [(FPath,FIndex)]

initialFCat :: AbsGFCC.CId -> FCat
initialFCat cat = FCat 0 cat [] []

fcatString = FCat (-1) (AbsGFCC.CId "String") [[0]] []
fcatInt    = FCat (-2) (AbsGFCC.CId "Int")    [[0]] []
fcatFloat  = FCat (-3) (AbsGFCC.CId "Float")  [[0]] []

fcat2cid :: FCat -> AbsGFCC.CId
fcat2cid (FCat _ c _ _) = c

instance Eq FCat where
  (FCat id1 _ _ _) == (FCat id2 _ _ _) = id1 == id2

instance Ord FCat where
  compare (FCat id1 _ _ _) (FCat id2 _ _ _) = compare id1 id2

instance Print AbsGFCC.CId where
  prt (AbsGFCC.CId s) = s

isCoercionF :: FName -> Bool
isCoercionF (Name fun [Unify [0]]) = fun == AbsGFCC.CId "_"
isCoercionF _ = False


----------------------------------------------------------------------
-- * pretty-printing

instance Print FCat where
    prt (FCat _ (AbsGFCC.CId cat) rcs tcs) = cat ++ "{" ++ 
			             prtSep ";" ([prt path                    |  path       <- rcs] ++
			                         [prt path ++ "=" ++ prt term | (path,term) <- tcs])
			                 ++ "}"

