----------------------------------------------------------------------
-- |
-- Module      : SubExOpt
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- This module implements a simple common subexpression elimination
-- for .gfo grammars, to factor out shared subterms in lin rules.
-- It works in three phases: 
-- 
--   (1) collectSubterms collects recursively all subterms of forms table and (P x..y)
--       from lin definitions (experience shows that only these forms
--       tend to get shared) and counts how many times they occur
--   (2) addSubexpConsts takes those subterms t that occur more than once
--       and creates definitions of form "oper A''n = t" where n is a
--       fresh number; notice that we assume no ids of this form are in
--       scope otherwise
--   (3) elimSubtermsMod goes through lins and the created opers by replacing largest
--       possible subterms by the newly created identifiers
-- 
-----------------------------------------------------------------------------

module GF.Compile.SubExOpt (subexpModule,unsubexpModule) where 

import GF.Grammar.Grammar
import GF.Grammar.Lookup
import GF.Infra.Ident
import qualified GF.Grammar.Macros as C
import qualified GF.Infra.Modules as M
import GF.Data.Operations

import Control.Monad
import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.ByteString.Char8 as BS
import Data.List

subexpModule :: SourceModule -> SourceModule
subexpModule (n,mo) = errVal (n,mo) $ do
  let ljs = tree2list (M.jments mo)
  (tree,_) <- appSTM (getSubtermsMod n ljs) (Map.empty,0)
  js2 <- liftM buildTree $ addSubexpConsts n tree $ ljs
  return (n,M.replaceJudgements mo js2)

unsubexpModule :: SourceModule -> SourceModule
unsubexpModule sm@(i,mo)
  | hasSub ljs = (i,M.replaceJudgements mo (rebuild (map unparInfo ljs)))
  | otherwise  = sm
  where
    ljs = tree2list (M.jments mo) 

    -- perform this iff the module has opers
    hasSub ljs = not $ null [c | (c,ResOper _ _) <- ljs]
    unparInfo (c,info) = case info of
      CncFun xs (Just (L loc t)) m -> [(c, CncFun xs (Just (L loc (unparTerm t))) m)]
      ResOper (Just (L loc (EInt 8))) _ -> [] -- subexp-generated opers
      ResOper pty (Just (L loc t)) -> [(c, ResOper pty (Just (L loc (unparTerm t))))]
      _ -> [(c,info)]
    unparTerm t = case t of
      Q m c | isOperIdent c -> --- name convention of subexp opers
        errVal t $ liftM unparTerm $ lookupResDef gr m c 
      _ -> C.composSafeOp unparTerm t
    gr = M.MGrammar [sm] 
    rebuild = buildTree . concat

-- implementation

type TermList = Map Term (Int,Int) -- number of occs, id
type TermM a = STM (TermList,Int) a

addSubexpConsts :: 
  Ident -> Map Term (Int,Int) -> [(Ident,Info)] -> Err [(Ident,Info)]
addSubexpConsts mo tree lins = do
  let opers = [oper id trm | (trm,(_,id)) <- list]
  mapM mkOne $ opers ++ lins
 where
   mkOne (f,def) = case def of
     CncFun xs (Just (L loc trm)) pn -> do
       trm' <- recomp f trm
       return (f,CncFun xs (Just (L loc trm')) pn)
     ResOper ty (Just (L loc trm)) -> do
       trm' <- recomp f trm
       return (f,ResOper ty (Just (L loc trm')))
     _ -> return (f,def)
   recomp f t = case Map.lookup t tree of
     Just (_,id) | operIdent id /= f -> return $ Q mo (operIdent id)
     _ -> C.composOp (recomp f) t

   list = Map.toList tree

   oper id trm = (operIdent id, ResOper (Just (L (0,0) (EInt 8))) (Just (L (0,0) trm))) 
   --- impossible type encoding generated opers

getSubtermsMod :: Ident -> [(Ident,Info)] -> TermM (Map Term (Int,Int))
getSubtermsMod mo js = do
  mapM (getInfo (collectSubterms mo)) js
  (tree0,_) <- readSTM
  return $ Map.filter (\ (nu,_) -> nu > 1) tree0
 where
   getInfo get fi@(f,i) = case i of
     CncFun xs (Just (L _ trm)) pn -> do
       get trm
       return $ fi
     ResOper ty (Just (L _ trm)) -> do
       get trm
       return $ fi
     _ -> return fi

collectSubterms :: Ident -> Term -> TermM Term
collectSubterms mo t = case t of
  App f a -> do
    collect f
    collect a
    add t 
  T ty cs -> do
    let (_,ts) = unzip cs
    mapM collect ts
    add t
  V ty ts -> do
    mapM collect ts
    add t
----  K (KP _ _)  -> add t
  _ -> C.composOp (collectSubterms mo) t
 where
   collect = collectSubterms mo
   add t = do
     (ts,i) <- readSTM
     let 
       ((count,id),next) = case Map.lookup t ts of
         Just (nu,id) -> ((nu+1,id), i)
         _ ->            ((1,   i ), i+1)
     writeSTM (Map.insert t (count,id) ts, next)
     return t --- only because of composOp

operIdent :: Int -> Ident
operIdent i = identC (operPrefix `BS.append` (BS.pack (show i))) ---

isOperIdent :: Ident -> Bool
isOperIdent id = BS.isPrefixOf operPrefix (ident2bs id)

operPrefix = BS.pack ("A''")
