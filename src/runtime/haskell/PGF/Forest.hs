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
                 , foldForest
                 ) where

import PGF.CId
import PGF.Data
import PGF.Macros
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
      , root   :: [([Symbol],[FId])]
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
  case [computeSeq seq (map (render forest) args) | (seq,args) <- root] of
    ([bs@(Bracket_ _ _ _ _ _)]:_) -> bs
    (bss:_)                       -> Bracket_ wildCId 0 0 [] bss
    []                            -> Bracket_ wildCId 0 0 [] []
  where
    trusted = foldl1 IntSet.intersection [IntSet.unions (map (trustedSpots IntSet.empty) args) | (_,args) <- root]

    render forest fid =
      case IntMap.lookup fid forest >>= Set.maxView of
        Just (p,set) -> descend (if Set.null set then forest else IntMap.insert fid set forest) p
        Nothing      -> error ("wrong forest id " ++ show fid)
      where
        descend forest (PApply funid args) = let (CncFun fun lins) = cncfuns cnc ! funid
                                                 Just (DTyp _ cat _,_,_) = Map.lookup fun (funs abs)
                                                 largs = map (render forest) args
                                                 ltable = listArray (bounds lins)
                                                                    [computeSeq (elems (sequences cnc ! seqid)) largs |
                                                                                                         seqid <- elems lins]
                                             in (fid,cat,ltable)
        descend forest (PCoerce fid)       = render forest fid
        descend forest (PConst cat _ ts)   = (fid,cat,listArray (0,0) [[LeafKS ts]])

    trustedSpots parents fid
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
        descend (PCoerce fid)       = trustedSpots parents' fid
        descend (PConst c e _)      = IntSet.empty

    computeSeq :: [Symbol] -> [(FId,CId,LinTable)] -> [BracketedTokn]
    computeSeq seq args = concatMap compute seq
      where
        compute (SymCat d r)    = getArg d r
        compute (SymLit d r)    = getArg d r
        compute (SymKS ts)      = [LeafKS ts]
        compute (SymKP ts alts) = [LeafKP ts alts]

        getArg d r
          | not (null arg_lin) &&
            IntSet.member fid trusted
                        = [Bracket_ cat fid r es arg_lin]
          | otherwise   = arg_lin
          where
            arg_lin       = lin ! r
            (fid,cat,lin) = args !! d
            es            = getAbsTrees f fid

-- | This function extracts the list of all completed parse trees
-- that spans the whole input consumed so far. The trees are also
-- limited by the category specified, which is usually
-- the same as the startup category.
getAbsTrees :: Forest -> FId -> [Expr]
getAbsTrees (Forest abs cnc forest root) fid =
  nubsort $ do (fvs,e) <- go Set.empty 0 (0,fid)
               guard (Set.null fvs)
               return e
  where
    go rec_ fcat' (d,fcat)
      | fcat < totalCats cnc = return (Set.empty,EMeta (fcat'*10+d))   -- FIXME: here we assume that every rule has at most 10 arguments
      | Set.member fcat rec_  = mzero
      | otherwise            = foldForest (\funid args trees -> 
                                                  do let CncFun fn lins = cncfuns cnc ! funid
                                                     args <- mapM (go (Set.insert fcat rec_) fcat) (zip [0..] args)
                                                     check_ho_fun fn args
                                                  `mplus`
                                                  trees)
                                          (\const _ trees ->
                                                  return (freeVar const,const)
                                                  `mplus`
                                                  trees)
                                          [] fcat forest

    check_ho_fun fun args
      | fun == _V = return (head args)
      | fun == _B = return (foldl1 Set.difference (map fst args), foldr (\x e -> EAbs Explicit (mkVar (snd x)) e) (snd (head args)) (tail args))
      | otherwise = return (Set.unions (map fst args),foldl (\e x -> EApp e (snd x)) (EFun fun) args)
    
    mkVar (EFun  v) = v
    mkVar (EMeta _) = wildCId
    
    freeVar (EFun v) = Set.singleton v
    freeVar _        = Set.empty


foldForest :: (FunId -> [FId] -> b -> b) -> (Expr -> [String] -> b -> b) -> b -> FId -> IntMap.IntMap (Set.Set Production) -> b
foldForest f g b fcat forest =
  case IntMap.lookup fcat forest of
    Nothing  -> b
    Just set -> Set.fold foldProd b set
  where
    foldProd (PCoerce fcat)        b = foldForest f g b fcat forest
    foldProd (PApply funid args)   b = f funid args b
    foldProd (PConst _ const toks) b = g const toks b
