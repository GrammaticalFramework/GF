{-# LANGUAGE ImplicitParams #-}
module PGF.Internal(CId(..),Language,PGF(..),
                    PGF2.Concr,lookConcr,
                    PGF2.FId,isPredefFId,
                    PGF2.FunId,PGF2.SeqId,PGF2.LIndex,PGF2.Token,
                    PGF2.Production(..),PGF2.PArg(..),PGF2.Symbol(..),PGF2.Literal(..),PGF2.BindType(..),Sequence(..),
                    globalFlags, abstrFlags, concrFlags,
                    concrTotalCats, concrCategories, concrProductions,
                    concrTotalFuns, concrFunction,
                    concrTotalSeqs, concrSequence,
                    
                    PGF2.Builder, PGF2.B, PGF2.build,
                    eAbs, eApp, eMeta, eFun, eVar, eTyped, eImplArg, dTyp, hypo,
                    PGF2.AbstrInfo, newAbstr, PGF2.ConcrInfo, newConcr, newPGF,
                     
                    -- * Write an in-memory PGF to a file
                    writePGF,
                     
                    PGF2.fidString, PGF2.fidInt, PGF2.fidFloat, PGF2.fidVar, PGF2.fidStart
) where

import qualified PGF2
import qualified PGF2.Internal as PGF2
import qualified Data.Map as Map
import Data.Array.IArray
import Data.Array.Unboxed

newtype CId = CId String deriving (Show,Read,Eq,Ord)

type Language = CId
data PGF = PGF PGF2.PGF (Map.Map String PGF2.Concr)

lookConcr (PGF _ langs) (CId lang) =
  case Map.lookup lang langs of
    Just cnc -> cnc
    Nothing  -> error "Unknown language"

globalFlags (PGF pgf _) = Map.fromAscList [(CId name,value) | (name,value) <- PGF2.globalFlags pgf]
abstrFlags  (PGF pgf _) = Map.fromAscList [(CId name,value) | (name,value) <- PGF2.abstrFlags pgf]
concrFlags concr = Map.fromAscList [(CId name,value) | (name,value) <- PGF2.concrFlags concr]

concrTotalCats = PGF2.concrTotalCats

concrCategories :: PGF2.Concr -> [(CId,PGF2.FId,PGF2.FId,[String])]
concrCategories c = [(CId cat,start,end,lbls) | (cat,start,end,lbls) <- PGF2.concrCategories c]

concrProductions :: PGF2.Concr -> PGF2.FId -> [PGF2.Production]
concrProductions = PGF2.concrProductions

concrTotalFuns = PGF2.concrTotalFuns

concrFunction :: PGF2.Concr -> PGF2.FunId -> (CId,[PGF2.SeqId])
concrFunction c funid =
  let (fun,seqids) = PGF2.concrFunction c funid
  in (CId fun,seqids)

concrTotalSeqs :: PGF2.Concr -> PGF2.SeqId
concrTotalSeqs = PGF2.concrTotalSeqs

concrSequence = PGF2.concrSequence

isPredefFId = PGF2.isPredefFId

type Sequence = Array Int PGF2.Symbol

eAbs :: (?builder :: PGF2.Builder s) => PGF2.BindType -> CId -> PGF2.B s PGF2.Expr -> PGF2.B s PGF2.Expr
eAbs bind_type (CId var) body = PGF2.eAbs bind_type var body

eApp :: (?builder :: PGF2.Builder s) => PGF2.B s PGF2.Expr -> PGF2.B s PGF2.Expr -> PGF2.B s PGF2.Expr
eApp = PGF2.eApp

eMeta :: (?builder :: PGF2.Builder s) => Int -> PGF2.B s PGF2.Expr
eMeta = PGF2.eMeta

eFun (CId fun) = PGF2.eFun fun

eVar :: (?builder :: PGF2.Builder s) => Int -> PGF2.B s PGF2.Expr
eVar = PGF2.eVar

eTyped :: (?builder :: PGF2.Builder s) => PGF2.B s PGF2.Expr -> PGF2.B s PGF2.Type -> PGF2.B s PGF2.Expr
eTyped = PGF2.eTyped

eImplArg :: (?builder :: PGF2.Builder s) => PGF2.B s PGF2.Expr -> PGF2.B s PGF2.Expr
eImplArg = PGF2.eImplArg

dTyp :: (?builder :: PGF2.Builder s) => [PGF2.B s (PGF2.BindType,String,PGF2.Type)] -> CId -> [PGF2.B s PGF2.Expr] -> PGF2.B s PGF2.Type
dTyp hypos (CId cat) es = PGF2.dTyp hypos cat es

hypo bind_type (CId var) ty = PGF2.hypo bind_type var ty

newAbstr flags cats funs = PGF2.newAbstr [(flag,lit) | (CId flag,lit) <- flags]
                                         [(cat,hypos,prob) | (CId cat,hypos,prob) <- cats]
                                         [(fun,ty,arity,prob) | (CId fun,ty,arity,prob) <- funs]

newConcr abs flags printnames lindefs linrefs prods cncfuns seqs cnccats total_ccats =
  PGF2.newConcr abs [(flag,lit) | (CId flag,lit) <- flags]
                    [(id,name) | (CId id,name) <- printnames]
                    lindefs linrefs
                    prods
                    [(fun,seq_ids) | (CId fun,seq_ids) <- cncfuns]
                    seqs
                    [(cat,start,end,labels) | (CId cat,start,end,labels) <- cnccats]
                    total_ccats

newPGF flags (CId name) abstr concrs = 
  fmap (\pgf -> PGF pgf (PGF2.languages pgf))
       (PGF2.newPGF [(flag,lit) | (CId flag,lit) <- flags]
                    name
                    abstr
                    [(name,concr) | (CId name,concr) <- concrs])

writePGF = PGF2.writePGF
