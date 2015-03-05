----------------------------------------------------------------------
-- |
-- Module      : Values
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:32 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.7 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Grammar.Values (-- ** Values used in TC type checking
	       Val(..), Env,
	       -- ** Annotated tree used in editing
               Binds, Constraints, MetaSubst,
	       -- ** For TC
	       valAbsInt, valAbsFloat, valAbsString, vType,
	       isPredefCat,
	       eType, 
	      ) where

import GF.Infra.Ident
import GF.Grammar.Grammar
import GF.Grammar.Predef

-- values used in TC type checking

data Val = VGen Int Ident | VApp Val Val | VCn QIdent | VRecType [(Label,Val)] | VType | VClos Env Term
  deriving (Eq,Show)

type Env = [(Ident,Val)]

type Binds = [(Ident,Val)]
type Constraints = [(Val,Val)]
type MetaSubst = [(MetaId,Val)]


-- for TC

valAbsInt :: Val
valAbsInt = VCn (cPredefAbs, cInt)

valAbsFloat :: Val
valAbsFloat = VCn (cPredefAbs, cFloat)

valAbsString :: Val
valAbsString = VCn (cPredefAbs, cString)

vType :: Val
vType = VType

eType :: Term
eType = Sort cType
