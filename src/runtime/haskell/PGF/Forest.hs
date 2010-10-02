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
                 , foldForest
                 ) where

import PGF.CId
import PGF.Data
import PGF.Macros
import PGF.TypeCheck
import Data.List
import Data.Array.IArray
import qualified Data.Set as Set
import qualified Data.Map as Map
import qualified Data.IntSet as IntSet
import qualified Data.IntMap as IntMap
import Control.Monad
import GF.Data.SortedList

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

linearizeWithBrackets :: Forest -> BracketedString
linearizeWithBrackets = head . snd . untokn "" . bracketedTokn

---------------------------------------------------------------
-- Internally we have to do everything with Tokn first because
-- we must handle the pre {...} construction.
--

bracketedTokn :: Forest -> BracketedTokn
bracketedTokn f@(Forest abs cnc forest root) =
  case [computeSeq isTrusted seq (map (render forest) args) | (seq,args) <- root] of
    ([bs@(Bracket_ _ _ _ _ _)]:_) -> bs
    (bss:_)                       -> Bracket_ wildCId 0 0 [] bss
    []                            -> Bracket_ wildCId 0 0 [] []
  where
    isTrusted (_,fid) = IntSet.member fid trusted

    trusted = foldl1 IntSet.intersection [IntSet.unions (map (trustedSpots IntSet.empty) args) | (_,args) <- root]

    render forest arg@(PArg hypos fid) =
      case IntMap.lookup fid forest >>= Set.maxView of
        Just (p,set) -> let (ct,es,(_,lin)) = descend (if Set.null set then forest else IntMap.insert fid set forest) p
                        in (ct,es,(map getVar hypos,lin))
        Nothing      -> error ("wrong forest id " ++ show fid)
      where
        descend forest (PApply funid args) = let (CncFun fun lins) = cncfuns cnc ! funid
                                                 cat = case isLindefCId fun of
                                                         Just cat -> cat
                                                         Nothing  -> case Map.lookup fun (funs abs) of
                                                                       Just (DTyp _ cat _,_,_,_) -> cat
                                                 largs  = map (render forest) args
                                                 ltable = mkLinTable cnc isTrusted [] funid largs
                                             in ((cat,fid),either (const []) id $ getAbsTrees f arg Nothing,ltable)
        descend forest (PCoerce fid)       = render forest (PArg [] fid)
        descend forest (PConst cat e ts)   = ((cat,fid),[e],([],listArray (0,0) [[LeafKS ts]]))

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
getAbsTrees :: Forest -> PArg -> Maybe Type -> Either [(FId,TcError)] [Expr]
getAbsTrees (Forest abs cnc forest root) arg@(PArg _ fid) ty =
  let (res,err) = unTcFM (do e <- go Set.empty emptyScope arg (fmap (TTyp []) ty)
                             e <- runTcM abs fid (refineExpr e)
                             runTcM abs fid (checkResolvedMetaStore emptyScope e)
                             return e) IntMap.empty
  in if null res
       then Left  (nub err)
       else Right (nubsort (map snd res))
  where
    go rec_ scope_ (PArg hypos fid) mb_tty_
      | fid < totalCats cnc = case mb_tty of
                                Just tty -> do i <- runTcM abs fid (newMeta scope tty)
                                               return (mkAbs (EMeta i))
                                Nothing  -> mzero
      | Set.member fid rec_ = mzero
      | otherwise           = foldForest (\funid args trees ->
                                                  do let CncFun fn lins = cncfuns cnc ! funid
                                                     case isLindefCId fn of
                                                       Just _  -> do arg <- go (Set.insert fid rec_) scope (head args) mb_tty
                                                                     return (mkAbs arg)
                                                       Nothing -> do tty_fn <- runTcM abs fid (lookupFunType fn)
                                                                     (e,tty0) <- foldM (\(e1,tty) arg -> goArg (Set.insert fid rec_) scope fid e1 arg tty)
                                                                                       (EFun fn,tty_fn) args
                                                                     case mb_tty of
                                                                       Just tty -> runTcM abs fid $ do
                                                                                     i <- newGuardedMeta e
                                                                                     eqType scope (scopeSize scope) i tty tty0
                                                                       Nothing  -> return ()
                                                                     return (mkAbs e)
                                                  `mplus`
                                                  trees)
                                         (\const _ trees -> do
                                                  const <- runTcM abs fid $
                                                             case mb_tty of
                                                               Just tty ->            tcExpr  scope const tty
                                                               Nothing  -> fmap fst $ infExpr scope const
                                                  return (mkAbs const)
                                                  `mplus`
                                                  trees)
                                         mzero fid forest
      where
        (scope,mkAbs,mb_tty) = updateScope hypos scope_ id mb_tty_

    goArg rec_ scope fid e1 arg (TTyp delta (DTyp ((bt,x,ty):hs) c es)) = do
      e2' <- go rec_ scope arg (Just (TTyp delta ty))
      let e2 = case bt of
                 Explicit -> e2'
                 Implicit -> EImplArg e2'
      if x == wildCId
        then return (EApp e1 e2,TTyp delta (DTyp hs c es))
        else do v2 <- runTcM abs fid (eval (scopeEnv scope) e2')
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


newtype TcFM a = TcFM {unTcFM :: MetaStore -> ([(MetaStore,a)],[(FId,TcError)])}

instance Functor TcFM where
  fmap f g = TcFM (\ms -> let (res_g,err_g) = unTcFM g ms
                          in ([(ms,f x) | (ms,x) <- res_g],err_g))

instance Monad TcFM where
  return x = TcFM (\ms -> ([(ms,x)],[]))
  f >>= g  = TcFM (\ms -> case unTcFM f ms of
                            (res,err) -> let (res',err') = unzip [unTcFM (g x) ms | (ms,x) <- res]
                                         in (concat res',concat (err:err')))

instance MonadPlus TcFM where
  mzero = TcFM (\ms -> ([],[]))
  mplus f g = TcFM (\ms -> let (res_f,err_f) = unTcFM f ms
                               (res_g,err_g) = unTcFM g ms
                           in (res_f++res_g,err_f++err_g))

runTcM :: Abstr -> FId -> TcM a -> TcFM a
runTcM abstr fid f = TcFM (\ms -> case unTcM f abstr ms of
                                    Ok ms x  -> ([(ms,x)],[]         )
                                    Fail err -> ([],      [(fid,err)]))

foldForest :: (FunId -> [PArg] -> b -> b) -> (Expr -> [String] -> b -> b) -> b -> FId -> IntMap.IntMap (Set.Set Production) -> b
foldForest f g b fcat forest =
  case IntMap.lookup fcat forest of
    Nothing  -> b
    Just set -> Set.fold foldProd b set
  where
    foldProd (PCoerce fcat)        b = foldForest f g b fcat forest
    foldProd (PApply funid args)   b = f funid args b
    foldProd (PConst _ const toks) b = g const toks b
