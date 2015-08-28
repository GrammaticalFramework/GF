{-# LANGUAGE TypeSynonymInstances #-}

-------------------------------------------------
-- |
-- Module      : PGF
-- Maintainer  : Krasimir Angelov
-- Stability   : stable
-- Portability : portable
--
-- Forest is a compact representation of a set
-- of parse trees. This let us to efficiently
-- represent local ambiguities
--
-------------------------------------------------

module PGF.Forest( Forest(..)
                 , BracketedString, showBracketedString, lengthBracketedString
                 , linearizeWithBrackets
                 , getAbsTrees
                 ) where

import PGF.CId
import PGF.Data
import PGF.Macros
import PGF.TypeCheck
import PGF.Generate
import Data.List
import Data.Array.IArray
import qualified Data.Set as Set
import qualified Data.Map as Map
import qualified Data.IntSet as IntSet
import qualified Data.IntMap as IntMap
import Control.Monad
import Control.Monad.State
import PGF.Utilities (nub')

data Forest
  = Forest
      { abstr  :: Abstr
      , concr  :: Concr
      , forest :: IntMap.IntMap (Set.Set Production)
      , root   :: [([Symbol],[PArg])]
      }

--------------------------------------------------------------------
-- Rendering of bracketed strings
--------------------------------------------------------------------

linearizeWithBrackets :: Maybe Int -> Forest -> BracketedString
linearizeWithBrackets dp = head . snd . untokn Nothing . (:[]) .bracketedTokn dp

---------------------------------------------------------------
-- Internally we have to do everything with Tokn first because
-- we must handle the pre {...} construction.
--

bracketedTokn :: Maybe Int -> Forest -> BracketedTokn
bracketedTokn dp f@(Forest abs cnc forest root) =
  case [computeSeq isTrusted seq (map (render forest) args) | (seq,args) <- root] of
    ([bs@(Bracket_{})]:_) -> bs
    (bss:_)               -> Bracket_ wildCId 0 0 wildCId [] bss
    []                    -> Bracket_ wildCId 0 0 wildCId [] []
  where
    isTrusted (_,fid) = IntSet.member fid trusted

    trusted = foldl1 IntSet.intersection [IntSet.unions (map (trustedSpots IntSet.empty) args) | (_,args) <- root]

    render forest arg@(PArg hypos fid) =
      case IntMap.lookup fid forest >>= Set.maxView of
        Just (p,set) -> let (ct,fid',fun,es,(_,lin)) = descend (if Set.null set then forest else IntMap.insert fid set forest) p
                        in (ct,fid',fun,es,(map getVar hypos,lin))
        Nothing      -> error ("wrong forest id " ++ show fid)
      where
        descend forest (PApply funid args) = let (CncFun fun _lins) = cncfuns cnc ! funid
                                                 cat = case isLindefCId fun of
                                                         Just cat -> cat
                                                         Nothing  -> case Map.lookup fun (funs abs) of
                                                                       Just (DTyp _ cat _,_,_,_) -> cat
                                                 largs  = map (render forest) args
                                                 ltable = mkLinTable cnc isTrusted [] funid largs
                                             in ((cat,fid),0,wildCId,either (const []) id $ getAbsTrees f arg Nothing dp,ltable)
        descend forest (PCoerce fid)       = render forest (PArg [] fid)
        descend forest (PConst cat e ts)   = ((cat,fid),0,wildCId,[e],([],listArray (0,0) [map LeafKS ts]))

    getVar (fid,_)
      | fid == fidVar = wildCId
      | otherwise     = x
      where
        (x:_) = [x | PConst _ (EFun x) _ <- maybe [] Set.toList (IntMap.lookup fid forest)]

    trustedSpots parents (PArg _ fid)
      | fid < totalCats cnc ||                  -- forest ids from the grammar correspond to metavariables
        IntSet.member fid parents               -- this avoids loops in the grammar
                  = IntSet.empty
      | otherwise = IntSet.insert fid $
                      case IntMap.lookup fid forest of
                        Just prods -> foldl1 IntSet.intersection [descend prod | prod <- Set.toList prods]
                        Nothing    -> IntSet.empty
      where
        parents' = IntSet.insert fid parents

        descend (PApply funid args) = IntSet.unions (map (trustedSpots parents') args)
        descend (PCoerce fid)       = trustedSpots parents' (PArg [] fid)
        descend (PConst c e _)      = IntSet.empty

isLindefCId id 
  | take l s == lindef = Just (mkCId (drop l s))
  | otherwise          = Nothing
  where
    s      = showCId id
    lindef = "lindef "
    l      = length lindef

-- | This function extracts the list of all completed parse trees
-- that spans the whole input consumed so far. The trees are also
-- limited by the category specified, which is usually
-- the same as the startup category.
getAbsTrees :: Forest -> PArg -> Maybe Type -> Maybe Int -> Either [(FId,TcError)] [Expr]
getAbsTrees (Forest abs cnc forest root) arg@(PArg _ fid) ty dp =
  let (err,res) = runTcM abs (do e <- go Set.empty emptyScope (fmap (TTyp []) ty) arg
                                 generateForForest (prove dp) e) emptyMetaStore fid
  in if null res
       then Left  (nub err)
       else Right (nub' [e | (_,_,e) <- res])
  where
    go rec_ scope_ mb_tty_ (PArg hypos fid)
      | fid < totalCats cnc = case mb_tty of
                                Just tty -> do i <- newMeta scope tty
                                               return (mkAbs (EMeta i))
                                Nothing  -> mzero
      | Set.member fid rec_ = mzero
      | otherwise           = do fid0 <- get
                                 put fid
                                 x <- foldForest (\funid args trees ->
                                                  do let CncFun fn _lins = cncfuns cnc ! funid
                                                     case isLindefCId fn of
                                                       Just _  -> do arg <- go (Set.insert fid rec_) scope mb_tty (head args)
                                                                     return (mkAbs arg)
                                                       Nothing -> do ty_fn <- lookupFunType fn
                                                                     (e,tty0) <- foldM (\(e1,tty) arg -> goArg (Set.insert fid rec_) scope fid e1 arg tty)
                                                                                       (EFun fn,TTyp [] ty_fn) args
                                                                     case mb_tty of
                                                                       Just tty -> do i <- newGuardedMeta e
                                                                                      eqType scope (scopeSize scope) i tty tty0
                                                                       Nothing  -> return ()
                                                                     return (mkAbs e)
                                                  `mplus`
                                                  trees)
                                            (\const _ trees -> do
                                                  const <- case mb_tty of
                                                             Just tty ->            tcExpr  scope const tty
                                                             Nothing  -> fmap fst $ infExpr scope const
                                                  return (mkAbs const)
                                                  `mplus`
                                                  trees)
                                            mzero fid forest
                                 put fid0
                                 return x

      where
        (scope,mkAbs,mb_tty) = updateScope hypos scope_ id mb_tty_

    goArg rec_ scope fid e1 arg (TTyp delta (DTyp ((bt,x,ty):hs) c es)) = do
      e2' <- go rec_ scope (Just (TTyp delta ty)) arg
      let e2 = case bt of
                 Explicit -> e2'
                 Implicit -> EImplArg e2'
      if x == wildCId
        then return (EApp e1 e2,TTyp delta (DTyp hs c es))
        else do v2 <- eval (scopeEnv scope) e2'
                return (EApp e1 e2,TTyp (v2:delta) (DTyp hs c es))

    updateScope []              scope mkAbs mb_tty = (scope,mkAbs,mb_tty)
    updateScope ((fid,_):hypos) scope mkAbs mb_tty =
      case mb_tty of
        Just (TTyp delta (DTyp ((bt,y,ty):hs) c es)) -> 
           if y == wildCId
             then updateScope hypos (addScopedVar x (TTyp delta ty) scope)
                                    (mkAbs . EAbs bt x)
                                    (Just (TTyp delta (DTyp hs c es)))
             else updateScope hypos (addScopedVar x (TTyp delta ty) scope)
                                    (mkAbs . EAbs bt x)
                                    (Just (TTyp ((VGen (scopeSize scope) []):delta) (DTyp hs c es)))
        Nothing  -> (scope,mkAbs,Nothing)
      where
        (x:_) | fid == fidVar = [wildCId]
              | otherwise     = [x | PConst _ (EFun x) _ <- maybe [] Set.toList (IntMap.lookup fid forest)]

foldForest :: (FunId -> [PArg] -> b -> b) -> (Expr -> [String] -> b -> b) -> b -> FId -> IntMap.IntMap (Set.Set Production) -> b
foldForest f g b fcat forest =
  case IntMap.lookup fcat forest of
    Nothing  -> b
    Just set -> Set.fold foldProd b set
  where
    foldProd (PCoerce fcat)        b = foldForest f g b fcat forest
    foldProd (PApply funid args)   b = f funid args b
    foldProd (PConst _ const toks) b = g const toks b


------------------------------------------------------------------------------
-- Selectors

instance Selector FId where
  splitSelector s = (s,s)
  select cat scope dp = do
    gens <- typeGenerators scope cat
    TcM (\abstr k h -> iter k gens)
    where
      iter k []              ms s = id
      iter k ((_,e,tty):fns) ms s = k (e,tty) ms s . iter k fns ms s
