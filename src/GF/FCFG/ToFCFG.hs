----------------------------------------------------------------------
-- |
-- Maintainer  : Aarne Ranta
-- Stability   : (stable)
-- Portability : (portable)
--
-- mapping from GF-internal FGrammar to bnfc-defined FCFG
-----------------------------------------------------------------------------

module GF.FCFG.ToFCFG (printFGrammar) where

import GF.Formalism.FCFG
import GF.Formalism.SimpleGFC
import GF.Infra.Ident
import qualified GF.FCFG.AbsFCFG as F

import GF.FCFG.PrintFCFG (printTree)

import qualified GF.Canon.AbsGFC as C

import Control.Monad (liftM)
import Data.List (groupBy)
import Data.Array

import GF.Formalism.Utilities
import GF.Formalism.GCFG

import GF.Infra.Print

type FToken = String

-- this is the main function used
printFGrammar :: FGrammar -> String
printFGrammar = undefined {- printTree . fgrammar

fgrammar :: FCFGrammar FCat Name FToken -> F.FGrammar
fgrammar = F.FGr . map frule

frule :: FCFRule FCat Name FToken -> F.FRule
frule (FRule ab rhs) = 
  F.FR (abstract ab) [[fsymbol sym | (_,sym) <- assocs syms] | (_,syms) <- assocs rhs]

abstract :: Abstract FCat Name -> F.Abstract
abstract (Abs cat cats n) = F.Abs (fcat cat) (map fcat cats) (name n)

fsymbol :: FSymbol FCat FToken -> F.FSymbol
fsymbol fs = case fs of
  FSymCat fc i j -> F.FSymCat (fcat fc) (toInteger i) (toInteger j)
  FSymTok s -> F.FSymTok s

fcat :: FCat -> F.FCat
fcat (FCat i id ps pts) = 
  F.FC (toInteger i) (ident id) [map pathel p | Path p <- ps] 
    [F.PtT (map pathel p) (term t) | (Path p,t) <- pts]

name :: Name -> F.Name
name (Name id profs) = F.Nm (ident id) (map profile profs)

pathel :: Either C.Label (Term SCat FToken) -> F.PathEl
pathel lt = case lt of
  Left lab -> F.PLabel $ label lab
  Right trm -> F.PTerm $ term trm

path (Path p) = map pathel p

profile :: Profile (SyntaxForest Fun) -> F.Profile
profile p = case p of
  Unify is -> F.Unify (map toInteger is)
  Constant sf -> F.Const (forest sf)

forest :: SyntaxForest Fun -> F.Forest
forest f = case f of
  FMeta -> F.FMeta
  FNode id fss -> F.FNode (ident id) (map (map forest) fss)
  FString s -> F.FString s
  FInt i -> F.FInt i
  FFloat d -> F.FFloat d

term :: Term SCat FToken -> F.Term
term tr = case tr of
  Arg i id p -> F.Arg (toInteger i) (ident id) (path p)
  Rec rs -> F.Rec [F.Ass (label l) (term t) | (l,t) <- rs]
  Tbl cs -> F.Tbl [F.Cas (term p) (term v) | (p,v) <- cs]
  c :^ ts -> F.Constr (constr c) (map term ts)
  t :. l -> F.Proj (term t) (label l)
  t :++ u -> F.Concat (term t) (term u)
  t :! u -> F.Select (term t) (term u)
  Variants ts -> F.Vars $ map term ts
  Token s -> F.Tok s
  Empty -> F.Empty

label :: C.Label -> F.Label
label b = case b of
  C.L x -> F.L $ ident x
  C.LV i -> F.LV i

ident :: Ident -> F.Ident
ident = F.Ident . prIdent --- is information lost?

constr (C.CIQ m c) = F.CIQ (ident m) (ident c)
-}