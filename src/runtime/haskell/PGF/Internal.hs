{-# OPTIONS_HADDOCK hide #-}
-------------------------------------------------
-- |
-- Stability   : unstable
--
-------------------------------------------------
module PGF.Internal(CId,
                    Concr,lookConcr,
                    FId,isPredefFId,
                    FunId,SeqId,LIndex,Token,
                    Production(..),PArg(..),Symbol(..),Literal(..),BindType(..),Sequence,
                    globalFlags, abstrFlags, concrFlags,
                    concrTotalCats, concrCategories, concrProductions,
                    concrTotalFuns, concrFunction,
                    concrTotalSeqs, concrSequence,

                    CodeLabel, Instr(..), IVal(..), TailInfo(..),

                    fidString, fidInt, fidFloat, fidVar, fidStart,
                    
                    ppFunId, ppSeqId, ppFId, ppMeta, ppLit, ppSeq
                    ) where

import PGF.Data
import PGF.Macros
import PGF.Printer
import PGF.ByteCode
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import qualified Data.Set as Set
import Data.Array.IArray


globalFlags pgf = gflags pgf
abstrFlags pgf = aflags (abstract pgf)
concrFlags concr = cflags concr

concrTotalCats = totalCats

concrCategories :: Concr -> [(CId,FId,FId,[String])]
concrCategories c = [(cat,start,end,elems lbls) | (cat,CncCat start end lbls) <- Map.toList (cnccats c)]

concrTotalFuns c =
  let (s,e) = bounds (cncfuns c)
  in e-s+1

concrFunction :: Concr -> FunId -> (CId,[SeqId])
concrFunction c funid = 
  let CncFun fun lins = cncfuns c ! funid
  in (fun,elems lins)

concrTotalSeqs :: Concr -> SeqId
concrTotalSeqs c =
  let (s,e) = bounds (sequences c)
  in e-s+1

concrSequence :: Concr -> SeqId -> [Symbol]
concrSequence c seqid = elems (sequences c ! seqid)

concrProductions :: Concr -> FId -> [Production]
concrProductions c fid = 
  case IntMap.lookup fid (productions c) of
    Just set -> Set.toList set
    Nothing  -> []
