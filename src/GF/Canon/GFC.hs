----------------------------------------------------------------------
-- |
-- Module      : GFC
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/08 15:49:24 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.9 $
--
-- canonical GF. AR 10\/9\/2002 -- 9\/5\/2003 -- 21\/9
-----------------------------------------------------------------------------

module GFC (Context,
	    CanonGrammar,
	    CanonModInfo,
	    CanonModule,
	    CanonAbs,
	    Info(..),
	    Printname,
	    mapInfoTerms,
	    setFlag
--            , mapIdents
	   ) where

import AbsGFC
import PrintGFC
import qualified Abstract as A

import Ident
import Option
import Zipper
import Operations
import qualified Modules as M

import Char
import Control.Arrow (first)

type Context = [(Ident,Exp)]

type CanonGrammar = M.MGrammar Ident Flag Info

type CanonModInfo = M.ModInfo Ident Flag Info

type CanonModule = (Ident, CanonModInfo)

type CanonAbs = M.Module Ident Option Info

data Info =  
   AbsCat  A.Context [A.Fun]
 | AbsFun  A.Type A.Term
 | AbsTrans A.Term

 | ResPar  [ParDef]
 | ResOper CType Term     -- ^ global constant
 | CncCat  CType Term Printname
 | CncFun  CIdent [ArgVar] Term Printname
 | AnyInd Bool Ident
  deriving (Show)

type Printname = Term
	      
mapInfoTerms :: (Term -> Term) -> Info -> Info
mapInfoTerms f i = case i of 
         ResOper x a -> ResOper x (f a)
	 CncCat  x a y -> CncCat x (f a) y
	 CncFun  x y a z -> CncFun x y (f a) z
	 _ -> i

setFlag :: String -> String -> [Flag] -> [Flag]
setFlag n v fs = Flg (IC n) (IC v):[f | f@(Flg (IC n') _) <- fs, n' /= n]

{-
-- | Apply a function to all identifiers in a module
mapIdents :: (Ident -> Ident) -> M.ModInfo Ident Flag Info -> M.ModInfo Ident Flag Info
mapIdents f mi = case mi of
    M.ModMainGrammar mg -> M.ModMainGrammar (fmg mg)
    M.ModMod m -> M.ModMod (fm m)
    M.ModWith mt s i is oss -> M.ModWith (fmt mt) s (f i) (map f is) (map fos oss)
  where
  fmg :: M.MainGrammar Ident -> M.MainGrammar Ident
  fmg (M.MainGrammar i mcs) = M.MainGrammar (f i) (map fmc mcs)
  fmc :: M.MainConcreteSpec Ident -> M.MainConcreteSpec Ident
  fmc (M.MainConcreteSpec i1 i2 mos1 mos2) 
      = M.MainConcreteSpec (f i1) (f i2) (fmap fos mos1) (fmap fos mos2)
  fos :: M.OpenSpec Ident -> M.OpenSpec Ident
  fos os = case os of 
		   M.OSimple q i -> M.OSimple q (f i)
		   M.OQualif q i1 i2 -> M.OQualif q (f i1) (f i2)
  fm :: M.Module Ident Flag Info -> M.Module Ident Flag Info
  fm m@(M.Module{ M.mtype = mt, M.flags = fl, M.extends = ex, 
		  M.opens = os, M.jments = js}) =
      m { M.mtype = fmt mt, M.flags = map ffl fl, M.extends = map f ex, 
          M.opens = map fos os, 
	  M.jments = mapTree (\(i,t) -> (f i, fi t)) js }
  fmt :: M.ModuleType Ident -> M.ModuleType Ident
  fmt t = case t of
	       M.MTTransfer os1 os2 -> M.MTTransfer (fos os1) (fos os2)
	       M.MTConcrete i -> M.MTConcrete (f i)
               M.MTInstance i -> M.MTInstance (f i)
               M.MTReuse rt -> M.MTReuse (frt rt)
	       M.MTUnion mt ms -> M.MTUnion (fmt mt) [(f i, map f is) | (i,is) <- ms]
               _ -> t
  frt :: M.MReuseType Ident -> M.MReuseType Ident
  frt rt = case rt of 
		   M.MRInterface i -> M.MRInterface (f i)
		   M.MRInstance i1 i2 -> M.MRInstance (f i1) (f i2)
		   M.MRResource i -> M.MRResource (f i)
  ffl :: Flag -> Flag
  ffl (Flg i1 i2) = Flg (f i1) (f i2)
  fi :: Info -> Info
  fi info = case info of
                AbsCat ds fs -> AbsCat ds fs -- FIXME: convert idents here too
		AbsFun ty te -> AbsFun ty te -- FIXME: convert idents here too
		AbsTrans te -> AbsTrans te -- FIXME: convert idents here too
		ResPar ps -> ResPar [ParD (f i) (map fct cts) | ParD i cts <- ps]
		ResOper ct t -> ResOper (fct ct) (ft t)
		CncCat ct t pn -> CncCat (fct ct) (ft t) (ft pn)
		CncFun ci avs t pn -> CncFun (fc ci) (map fav avs) (ft t) (ft pn)
		AnyInd b i -> AnyInd b (f i)
  fqi :: A.QIdent -> A.QIdent
  fqi (i1,i2) = (f i1, f i2)
  fc :: CIdent -> CIdent
  fc (CIQ i1 i2) = CIQ (f i1) (f i2)
  fl :: Label -> Label
  fl l = case l of
               L i -> L (f i)
               _ -> l
  fct :: CType -> CType
  fct ct = case ct of 
                 RecType ls -> RecType [ Lbg (fl l) (fct ct) | Lbg l ct <- ls ]
                 Table t1 t2 -> Table (fct t1) (fct t2)
                 Cn ci -> Cn (fc ci)
                 _ -> ct
  fp :: Patt -> Patt
  fp p = case p of 
               PC ci ps -> PC (fc ci) (map fp ps)
               PV i -> PV (f i)
               PR ps -> PR [PAss (fl l) (fp p) | PAss l p <- ps]
	       _ -> p
  ft :: Term -> Term
  ft t = case t of
	     Arg av -> Arg (fav av)
	     I ci -> I (fc ci)
	     Con ci ts -> Con (fc ci) (map ft ts)
	     LI i -> LI (f i)
	     R as -> R [Ass (fl l) (ft t) | Ass l t <- as]
	     P t l -> P (ft t) (fl l)
	     T ct cs -> T (fct ct) [Cas (map fp ps) (ft t) | Cas ps t <- cs]
	     V ct ts -> V (fct ct) (map ft ts)
	     S t1 t2 -> S (ft t1) (ft t2)
	     C t1 t2 -> C (ft t1) (ft t2)
	     FV ts -> FV (map ft ts)
	     _ -> t
  fav :: ArgVar -> ArgVar
  fav av = case av of
		   A i x -> A (f i) x
		   AB i x y -> AB (f i) x y
-}
{-
  fat :: A.Term -> A.Term
  fat t = case t of
		 A.Vr i -> A.Vr (f i)
		 A.Cn i -> A.Cn (f i)
		 A.Con i -> A.Con (f i)
		 A.App t1 t2 -> A.App (fat t1) (fat t2)
		 A.Abs i t' -> A.Abs (f i) (fat t')
		 A.Prod i t1 t2 -> A.Prod (f i) (fat t1) (fat t2)
		 A.Eqs eqs -> A.Eqs [(, fat t) | (ps,t) <- eqs ] 
 | Eqs [([Patt],Term)]

                        -- only used in internal representation
 | Typed Term Term      -- ^ type-annotated term
--
-- /below this, the constructors are only for concrete syntax/
 | RecType [Labelling]  -- ^ record type: @{ p : A ; ...}@
 | R [Assign]           -- ^ record:      @{ p = a ; ...}@
 | P Term Label         -- ^ projection:  @r.p@
 | ExtR Term Term       -- ^ extension:   @R ** {x : A}@ (both types and terms)
 
 | Table Term Term      -- ^ table type:  @P => A@
 | T TInfo [Case]       -- ^ table:       @table {p => c ; ...}@
 | TSh TInfo [Cases]    -- ^ table with discjunctive patters (only back end opt)
 | V Type [Term]        -- ^ table given as course of values: @table T [c1 ; ... ; cn]@
 | S Term Term          -- ^ selection:   @t ! p@

 | Let LocalDef Term    -- ^ local definition: @let {t : T = a} in b@

 | Alias Ident Type Term  -- ^ constant and its definition, used in inlining

 | Q  Ident Ident        -- ^ qualified constant from a package
 | QC Ident Ident        -- ^ qualified constructor from a package

 | C Term Term    -- ^ concatenation: @s ++ t@
 | Glue Term Term -- ^ agglutination: @s + t@

 | FV [Term]      -- ^ alternatives in free variation: @variants { s ; ... }@

 | Alts (Term, [(Term, Term)]) -- ^ alternatives by prefix: @pre {t ; s\/c ; ...}@
 | Strs [Term]                 -- ^ conditioning prefix strings: @strs {s ; ...}@
-- 
-- /below this, the last three constructors are obsolete/
 | LiT Ident      -- ^ linearization type
 | Ready Str      -- ^ result of compiling; not to be parsed ...
 | Computed Term  -- ^ result of computing: not to be reopened nor parsed

        _ -> t

  fp :: A.Patt -> A.Patt
  fp p = case p of
	     A.PC Ident [Patt]
	     A.PP Ident Ident [Patt]
             A.PV Ident
             A.PR [(Label,Patt)]
             A.PT Type Patt
-}