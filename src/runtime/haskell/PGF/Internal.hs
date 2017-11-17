{-# OPTIONS_HADDOCK hide #-}
{-# LANGUAGE ImplicitParams, RankNTypes #-}
-------------------------------------------------
-- |
-- Stability   : unstable
--
-------------------------------------------------
module PGF.Internal(CId,Language,PGF,
                    Concr,lookConcr,
                    FId,isPredefFId,
                    FunId,SeqId,LIndex,Token,
                    Production(..),PArg(..),Symbol(..),Literal(..),BindType(..),PGF.Internal.Sequence,
                    globalFlags, abstrFlags, concrFlags,
                    concrTotalCats, concrCategories, concrProductions,
                    concrTotalFuns, concrFunction,
                    concrTotalSeqs, concrSequence,

                    CodeLabel, Instr(..), IVal(..), TailInfo(..),

                    Builder, B, build,
                    eAbs, eApp, eMeta, eFun, eVar, eLit, eTyped, eImplArg, dTyp, hypo,
                    AbstrInfo, newAbstr, ConcrInfo, newConcr, newPGF,
                    dTyp, hypo,

                    fidString, fidInt, fidFloat, fidVar, fidStart,
                    
                    ppFunId, ppSeqId, ppFId, ppMeta, ppLit, PGF.Internal.ppSeq
                    ) where

import PGF.Data
import PGF.Macros
import PGF.Printer
import PGF.ByteCode
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import qualified Data.Set as Set
import Data.Array.IArray
import Text.PrettyPrint

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

type Sequence = [Symbol]

concrSequence :: Concr -> SeqId -> [Symbol]
concrSequence c seqid = elems (sequences c ! seqid)

concrProductions :: Concr -> FId -> [Production]
concrProductions c fid = 
  case IntMap.lookup fid (productions c) of
    Just set -> Set.toList set
    Nothing  -> []


data Builder s
newtype B s a = B a

build :: (forall s . (?builder :: Builder s) => B s a) -> a
build x = let ?builder = undefined 
          in case x of
               B x -> x

eAbs :: (?builder :: Builder s) => BindType -> CId -> B s Expr -> B s Expr
eAbs bind_type var (B body) = B (EAbs bind_type var body)

eApp :: (?builder :: Builder s) => B s Expr -> B s Expr -> B s Expr
eApp (B f) (B x) = B (EApp f x)

eMeta :: (?builder :: Builder s) => Int -> B s Expr
eMeta i = B (EMeta i)

eFun :: (?builder :: Builder s) => CId -> B s Expr
eFun f = B (EFun f)

eVar :: (?builder :: Builder s) => Int -> B s Expr
eVar i = B (EVar i)

eLit :: (?builder :: Builder s) => Literal -> B s Expr
eLit l = B (ELit l)

eTyped :: (?builder :: Builder s) => B s Expr -> B s Type -> B s Expr
eTyped (B e) (B ty) = B (ETyped e ty)

eImplArg :: (?builder :: Builder s) => B s Expr -> B s Expr
eImplArg (B e) = B (EImplArg e)

hypo :: BindType -> CId -> B s Type -> (B s Hypo)
hypo bind_type var (B ty) = B (bind_type,var,ty)

dTyp :: (?builder :: Builder s) => [B s Hypo] -> CId -> [B s Expr] -> B s Type
dTyp hypos cat es = B (DTyp [hypo | B hypo <- hypos] cat [e | B e <- es])


type AbstrInfo = Abstr

newAbstr :: (?builder :: Builder s) => [(CId,Literal)] ->
                                       [(CId,[B s Hypo],Float)] ->
                                       [(CId,B s Type,Int,Float)] ->
                                       B s AbstrInfo
newAbstr aflags cats funs = B (Abstr (Map.fromList aflags)
                                     (Map.fromList [(fun,(ty,arity,Nothing,realToFrac prob)) | (fun,B ty,arity,prob) <- funs])
                                     (Map.fromList [(cat,([hypo | B hypo <- hypos],[],realToFrac prob)) | (cat,hypos,prob) <- cats]))

type ConcrInfo = Concr

newConcr :: (?builder :: Builder s) => B s AbstrInfo ->
                                       [(CId,Literal)] ->       -- ^ Concrete syntax flags
                                       [(CId,String)] ->        -- ^ Printnames
                                       [(FId,[FunId])] ->          -- ^ Lindefs
                                       [(FId,[FunId])] ->          -- ^ Linrefs
                                       [(FId,[Production])] ->     -- ^ Productions
                                       [(CId,[SeqId])] ->          -- ^ Concrete functions   (must be sorted by Fun)
                                       [[Symbol]] ->               -- ^ Sequences            (must be sorted)
                                       [(CId,FId,FId,[String])] -> -- ^ Concrete categories
                                       FId ->                      -- ^ The total count of the categories
                                       B s ConcrInfo
newConcr _ cflags printnames lindefs linrefs productions cncfuns sequences cnccats totalCats =
  B (Concr {cflags = Map.fromList cflags
           ,printnames = Map.fromList printnames
           ,lindefs = IntMap.fromList lindefs
           ,linrefs = IntMap.fromList linrefs
           ,productions = IntMap.fromList [(fid,Set.fromList prods) | (fid,prods) <- productions]
           ,cncfuns = mkArray [CncFun fun (mkArray lins) | (fun,lins) <- cncfuns]
           ,sequences = mkArray (map mkArray sequences)
           ,cnccats = Map.fromList [(cat,CncCat s e (mkArray lbls)) | (cat,s,e,lbls) <- cnccats]
           ,totalCats = totalCats
           })
 {-
  pproductions :: IntMap.IntMap (Set.Set Production),                -- productions needed for parsing
  lproductions :: Map.Map CId (IntMap.IntMap (Set.Set Production)),  -- productions needed for linearization
  lexicon      :: IntMap.IntMap (IntMap.IntMap (TMap.TrieMap Token IntSet.IntSet)),
-}

newPGF :: (?builder :: Builder s) => [(CId,Literal)] ->
                                     CId ->
                                     B s AbstrInfo ->
                                     [(CId,B s ConcrInfo)] ->
                                     B s PGF
newPGF gflags absname (B abstract) concretes =
  B (PGF {gflags    = Map.fromList gflags
         ,absname   = absname
         ,abstract  = abstract
         ,concretes = Map.fromList [(cname,concr) | (cname,B concr) <- concretes]
         })


ppSeq (seqid,seq) = PGF.Printer.ppSeq (seqid,mkArray seq)

mkArray l = listArray (0,length l-1) l
