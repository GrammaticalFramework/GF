----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- Creating and using lock fields in reused resource grammars.
-----------------------------------------------------------------------------

module Lockfield where

import Grammar
import Ident
import Macros
import PrGrammar

import Operations

-- AR 8/2/2005 detached from compile/MkResource

lockRecType :: Ident -> Type -> Err Type
lockRecType c t = plusRecType t $ RecType [(lockLabel c,  RecType [])]

unlockRecord :: Ident -> Term -> Err Term
unlockRecord c ft = do
  let (xs,t) = termFormCnc ft
  t' <- plusRecord t $ R [(lockLabel c,  (Just (RecType []),R []))]
  return $ mkAbs xs t'

lockLabel :: Ident -> Label
lockLabel c = LIdent $ "lock_" ++ prt c ----

