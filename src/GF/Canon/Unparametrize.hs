----------------------------------------------------------------------
-- |
-- Module      : Unparametrize
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/14 16:26:21 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.1 $
--
-- Taking away parameters from a canonical grammar. All param
-- types are replaced by {}, and only one branch is left in
-- all tables. AR 14\/9\/2005.
-----------------------------------------------------------------------------

module GF.Canon.Unparametrize (unparametrizeCanon) where

import GF.Canon.AbsGFC
import GF.Infra.Ident
import GF.Canon.GFC
import qualified GF.Canon.CMacros as C
import GF.Data.Operations
import qualified GF.Infra.Modules as M

unparametrizeCanon :: CanonGrammar -> CanonGrammar
unparametrizeCanon (M.MGrammar modules) = 
    M.MGrammar $ map unparModule modules where 

  unparModule (i,m) = case m of
    M.ModMod (M.Module mt@(M.MTConcrete _) st fs me ops js) ->
      let me' = [(unparIdent j,incl) | (j,incl) <- me] in 
      (unparIdent i, M.ModMod (M.Module mt st fs me' ops (mapTree unparInfo js)))
    _ -> (i,m)

  unparInfo (c,info) = case info of
    CncCat ty t m   -> (c, CncCat   (unparCType ty) (unparTerm t) m)
    CncFun k xs t m -> (c, CncFun k xs (unparTerm t) m)
    AnyInd b i      -> (c, AnyInd b (unparIdent i))
    _ -> (c,info)

  unparCType ty = case ty of
    RecType ls -> RecType [Lbg lab (unparCType t) | Lbg lab t <- ls]
    Table _ v  -> unparCType v --- Table unitType (unparCType v)
    Cn _       -> unitType
    _ -> ty

  unparTerm t = case t of
    Par _ _ -> unitTerm
    T _ cs  -> unparTerm (head [t | Cas _ t <- cs])
    V _ ts  -> unparTerm (head ts)
    S t _   -> unparTerm t
{-
    T _ cs  -> V unitType [unparTerm (head [t | Cas _ t <- cs])]
    V _ ts  -> V unitType [unparTerm (head ts)]
    S t _   -> S (unparTerm t) unitTerm
-}
    _ -> C.composSafeOp unparTerm t

  unitType = RecType []
  unitTerm = R []

  unparIdent (IC s) = IC $ "UP_" ++ s
