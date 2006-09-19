----------------------------------------------------------------------
-- |
-- Maintainer  : Aarne Ranta
-- Stability   : (stable)
-- Portability : (portable)
--
-- mapping to GF-internal FGrammar from bnfc-defined FCFG
-----------------------------------------------------------------------------

module GF.FCFG.ToFCFG (getFGrammar) where

import GF.Formalism.FCFG
import GF.Formalism.SimpleGFC
import GF.Conversion.Types
import GF.Infra.Ident
import qualified GF.FCFG.AbsFCFG as F

import GF.FCFG.ParFCFG (pFGrammar, myLexer)

import qualified GF.Canon.AbsGFC as C

import Control.Monad (liftM)
import Data.List (groupBy)
import Data.Array

import GF.Formalism.Utilities
import GF.Formalism.GCFG

import GF.Data.Operations
import GF.Infra.Print


-- this is the main function used
getFGrammar :: FilePath -> IO (FCFGrammar FCat Name Token)
getFGrammar f = 
  readFile f >>= err error (return . fgrammar) . pFGrammar . myLexer

fgrammar :: F.FGrammar -> FCFGrammar FCat Name Token
fgrammar (F.FGr rs) = map frule rs

frule :: F.FRule -> FCFRule FCat Name Token 
frule (F.FR ab rhs) = 
  FRule (abstract ab) 
    (arr [arr [fsymbol sym | sym <- syms] | syms <- rhs])

arr xs = listArray (0,length xs - 1) xs

abstract :: F.Abstract -> Abstract FCat Name 
abstract (F.Abs cat cats n) = Abs (fcat cat) (map fcat cats) (name n)

fsymbol :: F.FSymbol -> FSymbol FCat Token 
fsymbol fs = case fs of
  F.FSymCat fc i j -> FSymCat (fcat fc) (fromInteger i) (fromInteger j)
  F.FSymTok s -> FSymTok s

fcat :: F.FCat -> FCat
fcat (F.FC i id ps pts) = 
  FCat (fromInteger i) (ident id) (map path ps)
    [ (path p, term t) | F.PtT p t <- pts]

name :: F.Name -> Name
name (F.Nm id profs) = Name (ident id) (map profile profs)

pathel :: F.PathEl -> Either C.Label (Term SCat Token)
pathel lt = case lt of
  F.PLabel lab -> Left $ label lab
  F.PTerm trm -> Right $ term trm

path = Path . map pathel

profile :: F.Profile -> Profile (SyntaxForest Fun)
profile p = case p of
  F.Unify is -> Unify (map fromInteger is)
  F.Const sf -> Constant (forest sf)

forest :: F.Forest -> SyntaxForest Fun
forest f = case f of
  F.FMeta -> FMeta
  F.FNode id fss -> FNode (ident id) (map (map forest) fss)
  F.FString s -> FString s
  F.FInt i -> FInt i
  F.FFloat d -> FFloat d

term :: F.Term -> Term SCat Token 
term tr = case tr of
  F.Arg i id p -> Arg (fromInteger i) (ident id) (path p)
  F.Rec rs -> Rec [(label l, term t) | F.Ass l t <- rs]
  F.Tbl cs -> Tbl [(term p, term v) | F.Cas p v <- cs]
  F.Constr c ts -> (constr c) :^ (map term ts)
  F.Proj t l -> (term t) :. (label l)
  F.Concat t u -> (term t) :++ (term u)
  F.Select t u -> (term t) :! (term u)
  F.Vars ts -> Variants $ map term ts
  F.Tok s -> Token s
  F.Empty -> Empty

label :: F.Label -> C.Label
label b = case b of
  F.L x -> C.L $ ident x
  F.LV i -> C.LV i

ident :: F.Ident -> Ident
ident (F.Ident x) = identC x --- should other constructors be used?

constr (F.CIQ m c) = C.CIQ (ident m) (ident c)
