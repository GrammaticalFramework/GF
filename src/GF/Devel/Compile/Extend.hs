----------------------------------------------------------------------
-- |
-- Module      : Extend
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 21:08:14 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.18 $
--
-- AR 14\/5\/2003 -- 11\/11
--
-- The top-level function 'extendModule'
-- extends a module symbol table by indirections to the module it extends
-----------------------------------------------------------------------------

module GF.Devel.Compile.Extend (
  extendModule
  ) where

import GF.Devel.Grammar.Modules
import GF.Devel.Grammar.Judgements
import GF.Devel.Grammar.MkJudgements
import GF.Devel.Grammar.PrGF
import GF.Devel.Grammar.Lookup
import GF.Devel.Grammar.Macros

import GF.Infra.Ident

--import GF.Compile.Update

import GF.Data.Operations

import Data.Map
import Control.Monad

extendModule :: GF -> SourceModule -> Err SourceModule
extendModule gf (name,mo) = case mtype mo of

  ---- Just to allow inheritance in incomplete concrete (which are not
  ---- compiled anyway), extensions are not built for them.
  ---- Should be replaced by real control. AR 4/2/2005
  MTConcrete _ | not (isCompleteModule mo) -> return (name,mo)
  _  -> do
    mo' <- foldM extOne mo (mextends mo) 
    return (name, mo') 
 where
   extOne mo (n,cond) = do
     (m0,isCompl) <- do
        m <- lookupModule gf n

        -- test that the module types match, and find out if the old is complete
        testErr (mtype mo == mtype m) 
                    ("illegal extension type to module" +++ prt name)
        return (m, isCompleteModule m)

     -- build extension in a way depending on whether the old module is complete
     js0 <- extendMod isCompl n (isInherited cond) name (mjments m0) (mjments mo)

     -- if incomplete, throw away extension information
     let me' = mextends mo ----if isCompl then es else (filter ((/=n) . fst) es) 
     return $ mo {mextends = me', mjments = js0}

-- | When extending a complete module: new information is inserted,
-- and the process is interrupted if unification fails.
-- If the extended module is incomplete, its judgements are just copied.
extendMod :: Bool -> Ident -> (Ident -> Bool) -> Ident -> 
             MapJudgement -> MapJudgement -> Err MapJudgement
extendMod isCompl name cond base old new = foldM try new $ assocs old where
  try t i@(c,_) | not (cond c) = return t
  try t i@(c,_) = errIn ("constant" +++ prt c) $
                  tryInsert (extendAnyInfo isCompl name base) indirIf t i
  indirIf = if isCompl then indirInfo name else id

indirInfo :: Ident -> JEntry -> JEntry
indirInfo n info = Right $ case info of
  Right (k,b) -> (k,b) -- original link is passed
  Left j      -> (n,isConstructor j)

extendAnyInfo :: Bool -> Ident -> Ident -> JEntry -> JEntry -> Err JEntry
extendAnyInfo isc n o i j = 
  errIn ("building extension for" +++ prt n +++ "in" +++ prt o) $ case (i,j) of
    (Left j1,Left j2) -> liftM Left $ unifyJudgement j1 j2
    (Right (m1,b1), Right (m2,b2)) -> do
      testErr (b1 == b2) "inconsistent indirection status"
      testErr (m1 == m2) $ 
        "different sources of inheritance:" +++ show m1 +++ show m2
      return i
    _ -> Bad $ "cannot unify information in"---- ++++ prt i ++++ "and" ++++ prt j

tryInsert :: Ord a => (b -> b -> Err b) -> (b -> b) ->
             Map a b -> (a,b) -> Err (Map a b)
tryInsert unif indir tree z@(x, info) = case Data.Map.lookup x tree of
  Just info0 -> do
    info1 <- unif info info0
    return $ insert x info1 tree 
  _ -> return $ insert x (indir info) tree
