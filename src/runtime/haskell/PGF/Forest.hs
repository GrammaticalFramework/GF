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
                 , BracketedString, showBracketedString
                 , linearizeWithBrackets
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

data Forest
  = Forest
      { abstr  :: Abstr
      , concr  :: Concr
      , forest :: IntMap.IntMap (Set.Set Production)
      , root   :: {-# UNPACK #-} !FId
      , label  :: {-# UNPACK #-} !LIndex
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
bracketedTokn (Forest abs cnc forest root label) =
  let (fid,cat,lin) = render IntMap.empty root
  in Bracket_ fid label cat (lin ! label)
  where
    trusted = trustedSpots IntSet.empty root

    render parents fid =
      case (IntMap.lookup fid parents) `mplus` (fmap Set.toList $ IntMap.lookup fid forest) of
        Just (p:ps) -> descend (IntMap.insert fid ps parents) p
        Nothing     -> error ("wrong forest id " ++ show fid)
      where
        descend parents (PApply funid args) = let (CncFun fun lins) = cncfuns cnc ! funid
                                                  Just (DTyp _ cat _,_,_) = Map.lookup fun (funs abs)
                                                  largs = map (render parents) args
                                              in (fid,cat,listArray (bounds lins) [computeSeq seqid largs | seqid <- elems lins])
        descend parents (PCoerce fid)       = render parents fid
        descend parents (PConst cat _ ts)   = (fid,cat,listArray (0,0) [[LeafKS ts]])

    trustedSpots parents fid
      | IntSet.member fid parents
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

    computeSeq :: SeqId -> [(FId,CId,LinTable)] -> [BracketedTokn]
    computeSeq seqid args = concatMap compute (elems seq)
      where
        seq = sequences cnc ! seqid

        compute (SymCat d r)    = getArg d r
        compute (SymLit d r)    = getArg d r
        compute (SymKS ts)      = [LeafKS ts]
        compute (SymKP ts alts) = [LeafKP ts alts]

        getArg d r
          | not (null arg_lin) &&
            IntSet.member fid trusted
                        = [Bracket_ fid r cat arg_lin]
          | otherwise   = arg_lin
          where
            arg_lin       = lin ! r
            (fid,cat,lin) = args !! d
