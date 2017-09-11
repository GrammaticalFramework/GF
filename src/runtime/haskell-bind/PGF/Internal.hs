module PGF.Internal(CId(..),Language,PGF(..),
                    PGF2.Concr,lookConcr,
                    PGF2.FId,isPredefFId,
                    PGF2.FunId,PGF2.SeqId,PGF2.Token,
                    PGF2.Production(..),PGF2.PArg(..),PGF2.Symbol(..),PGF2.Literal(..),
                    globalFlags, abstrFlags, concrFlags,
                    concrTotalCats, concrCategories, concrProductions,
                    concrTotalFuns, concrFunction,
                    concrTotalSeqs, concrSequence) where

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

globalFlags (PGF pgf _) = Map.fromAscList [(CId name,value) | (name,value) <- Map.toAscList (PGF2.globalFlags pgf)]
abstrFlags  (PGF pgf _) = Map.fromAscList [(CId name,value) | (name,value) <- Map.toAscList (PGF2.abstrFlags pgf)]
concrFlags concr = Map.fromAscList [(CId name,value) | (name,value) <- Map.toAscList (PGF2.concrFlags concr)]

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
