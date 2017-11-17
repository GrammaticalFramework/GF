{-# LANGUAGE ImplicitParams #-}
module PGF.Internal(CId(..),Language,PGF2.PGF,
                    PGF2.Concr,lookConcr,
                    PGF2.FId,isPredefFId,
                    PGF2.FunId,PGF2.SeqId,PGF2.LIndex,PGF2.Token,
                    PGF2.Production(..),PGF2.PArg(..),PGF2.Symbol(..),PGF2.Literal(..),PGF2.BindType(..),Sequence,
                    globalFlags, abstrFlags, concrFlags,
                    concrTotalCats, concrCategories, concrProductions,
                    concrTotalFuns, concrFunction,
                    concrTotalSeqs, concrSequence,
                    
                    PGF2.CodeLabel, PGF2.Instr(..), PGF2.IVal(..), PGF2.TailInfo(..),

                    PGF2.Builder, PGF2.B, PGF2.build,
                    eAbs, eApp, eMeta, eFun, eVar, eLit, eTyped, eImplArg, dTyp, hypo,
                    PGF2.AbstrInfo, newAbstr, PGF2.ConcrInfo, newConcr, newPGF,
                     
                    -- * Write an in-memory PGF to a file
                    writePGF, writeConcr,
                     
                    PGF2.fidString, PGF2.fidInt, PGF2.fidFloat, PGF2.fidVar, PGF2.fidStart,
                    
                    ppFunId, ppSeqId, ppFId, ppMeta, ppLit, ppSeq,
                    
                    unionPGF
                   ) where

import qualified PGF2
import qualified PGF2.Internal as PGF2
import qualified Data.Map as Map
import PGF2.FFI(PGF(..))
import Data.Array.IArray
import Data.Array.Unboxed
import Text.PrettyPrint

newtype CId = CId String deriving (Show,Read,Eq,Ord)

type Language = CId

lookConcr (PGF _ langs _) (CId lang) =
  case Map.lookup lang langs of
    Just cnc -> cnc
    Nothing  -> error "Unknown language"

globalFlags pgf = Map.fromAscList [(CId name,value) | (name,value) <- PGF2.globalFlags pgf]
abstrFlags  pgf = Map.fromAscList [(CId name,value) | (name,value) <- PGF2.abstrFlags pgf]
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

type Sequence = [PGF2.Symbol]

eAbs :: (?builder :: PGF2.Builder s) => PGF2.BindType -> CId -> PGF2.B s PGF2.Expr -> PGF2.B s PGF2.Expr
eAbs bind_type (CId var) body = PGF2.eAbs bind_type var body

eApp :: (?builder :: PGF2.Builder s) => PGF2.B s PGF2.Expr -> PGF2.B s PGF2.Expr -> PGF2.B s PGF2.Expr
eApp = PGF2.eApp

eMeta :: (?builder :: PGF2.Builder s) => Int -> PGF2.B s PGF2.Expr
eMeta = PGF2.eMeta

eFun (CId fun) = PGF2.eFun fun

eVar :: (?builder :: PGF2.Builder s) => Int -> PGF2.B s PGF2.Expr
eVar = PGF2.eVar

eLit :: (?builder :: PGF2.Builder s) => PGF2.Literal -> PGF2.B s PGF2.Expr
eLit = PGF2.eLit

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
       PGF2.newPGF [(flag,lit) | (CId flag,lit) <- flags]
                   name
                   abstr
                   [(name,concr) | (CId name,concr) <- concrs]

writePGF = PGF2.writePGF
writeConcr fpath pgf lang = PGF2.writeConcr fpath (lookConcr pgf lang)


ppFunId funid = char 'F' <> int funid
ppSeqId seqid = char 'S' <> int seqid

ppFId fid
  | fid == PGF2.fidString = text "CString"
  | fid == PGF2.fidInt    = text "CInt"
  | fid == PGF2.fidFloat  = text "CFloat"
  | fid == PGF2.fidVar    = text "CVar"
  | fid == PGF2.fidStart  = text "CStart"
  | otherwise             = char 'C' <> int fid

ppMeta :: Int -> Doc
ppMeta n
  | n == 0    = char '?'
  | otherwise = char '?' <> int n

ppLit (PGF2.LStr s) = text (show s)
ppLit (PGF2.LInt n) = int n
ppLit (PGF2.LFlt d) = double d

ppSeq (seqid,seq) = 
  ppSeqId seqid <+> text ":=" <+> hsep (map ppSymbol seq)

ppSymbol (PGF2.SymCat d r) = char '<' <> int d <> comma <> int r <> char '>'
ppSymbol (PGF2.SymLit d r) = char '{' <> int d <> comma <> int r <> char '}'
ppSymbol (PGF2.SymVar d r) = char '<' <> int d <> comma <> char '$' <> int r <> char '>'
ppSymbol (PGF2.SymKS t)    = doubleQuotes (text t)
ppSymbol PGF2.SymNE        = text "nonExist"
ppSymbol PGF2.SymBIND      = text "BIND"
ppSymbol PGF2.SymSOFT_BIND = text "SOFT_BIND"
ppSymbol PGF2.SymSOFT_SPACE= text "SOFT_SPACE"
ppSymbol PGF2.SymCAPIT     = text "CAPIT"
ppSymbol PGF2.SymALL_CAPIT = text "ALL_CAPIT"
ppSymbol (PGF2.SymKP syms alts) = text "pre" <+> braces (hsep (punctuate semi (hsep (map ppSymbol syms) : map ppAlt alts)))

ppAlt (syms,ps) = hsep (map ppSymbol syms) <+> char '/' <+> hsep (map (doubleQuotes . text) ps)

unionPGF = PGF2.unionPGF

