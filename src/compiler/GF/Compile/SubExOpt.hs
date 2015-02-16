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

{-# LANGUAGE FlexibleContexts #-}
module GF.Compile.SubExOpt (subexpModule,unsubexpModule) where 

import GF.Grammar.Grammar
import GF.Grammar.Lookup(lookupResDef)
import GF.Infra.Ident
import qualified GF.Grammar.Macros as C
import GF.Data.ErrM(fromErr)

import Control.Monad.State.Strict(State,evalState,get,put)
import Data.Map (Map)
import qualified Data.Map as Map


--subexpModule :: SourceModule -> SourceModule
subexpModule (n,mo) =
  let ljs = Map.toList (jments mo)
      tree = evalState (getSubtermsMod n ljs) (Map.empty,0)
      js2 = Map.fromList $ addSubexpConsts n tree $ ljs
  in (n,mo{jments=js2})

--unsubexpModule :: SourceModule -> SourceModule
unsubexpModule sm@(i,mo)
  | hasSub ljs = (i,mo{jments=rebuild (map unparInfo ljs)})
  | otherwise  = sm
  where
    ljs = Map.toList (jments mo) 

    -- perform this iff the module has opers
    hasSub ljs = not $ null [c | (c,ResOper _ _) <- ljs]
    unparInfo (c,info) = case info of
      CncFun xs (Just (L loc t)) m pf -> [(c, CncFun xs (Just (L loc (unparTerm t))) m pf)]
      ResOper (Just (L loc (EInt 8))) _ -> [] -- subexp-generated opers
      ResOper pty (Just (L loc t)) -> [(c, ResOper pty (Just (L loc (unparTerm t))))]
      _ -> [(c,info)]
    unparTerm t = case t of
      Q (m,c) | isOperIdent c -> --- name convention of subexp opers
        fromErr t $ fmap unparTerm $ lookupResDef gr (m,c)
      _ -> C.composSafeOp unparTerm t
    gr = mGrammar [sm]
    rebuild = Map.fromList . concat

-- implementation

type TermList = Map Term (Int,Int) -- number of occs, id
type TermM a = State (TermList,Int) a

addSubexpConsts :: 
  ModuleName -> Map Term (Int,Int) -> [(Ident,Info)] -> [(Ident,Info)]
addSubexpConsts mo tree lins = do
  let opers = [oper id trm | (trm,(_,id)) <- list]
  map mkOne $ opers ++ lins
 where
   mkOne (f,def) = case def of
     CncFun xs (Just (L loc trm)) pn pf ->
       let trm' = recomp f trm
       in (f,CncFun xs (Just (L loc trm')) pn pf)
     ResOper ty (Just (L loc trm)) ->
       let trm' = recomp f trm
       in (f,ResOper ty (Just (L loc trm')))
     _ -> (f,def)
   recomp f t = case Map.lookup t tree of
     Just (_,id) | operIdent id /= f -> Q (mo, operIdent id)
     _ -> C.composSafeOp (recomp f) t

   list = Map.toList tree

   oper id trm = (operIdent id, ResOper (Just (L NoLoc (EInt 8))) (Just (L NoLoc trm))) 
   --- impossible type encoding generated opers

getSubtermsMod :: ModuleName -> [(Ident,Info)] -> TermM (Map Term (Int,Int))
getSubtermsMod mo js = do
  mapM (getInfo (collectSubterms mo)) js
  (tree0,_) <- get
  return $ Map.filter (\ (nu,_) -> nu > 1) tree0
 where
   getInfo get fi@(f,i) = case i of
     CncFun xs (Just (L _ trm)) pn _ -> do
       get trm
       return $ fi
     ResOper ty (Just (L _ trm)) -> do
       get trm
       return $ fi
     _ -> return fi

collectSubterms :: ModuleName -> Term -> TermM Term
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
     (ts,i) <- get
     let 
       ((count,id),next) = case Map.lookup t ts of
         Just (nu,id) -> ((nu+1,id), i)
         _ ->            ((1,   i ), i+1)
     put (Map.insert t (count,id) ts, next)
     return t --- only because of composOp

operIdent :: Int -> Ident
operIdent i = identC (operPrefix `prefixRawIdent` (rawIdentS (show i))) ---

isOperIdent :: Ident -> Bool
isOperIdent id = isPrefixOf operPrefix (ident2raw id)

operPrefix = rawIdentS ("A''")
