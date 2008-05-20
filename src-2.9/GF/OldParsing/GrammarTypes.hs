----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:46 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- All possible instantiations of different grammar formats used for parsing
--
-- Plus some helper types and utilities
-----------------------------------------------------------------------------


module GF.OldParsing.GrammarTypes
    (-- * Main parser information
     PInfo(..),
     -- * Multiple context-free grammars
     MCFGrammar, MCFRule, MCFPInfo,
     MCFCat(..), MCFLabel,
     Constraint,
     -- * Context-free grammars
     CFGrammar, CFRule, CFPInfo,
     CFProfile, CFName(..), CFCat(..),
     -- * Assorted types
     Cat, Name, Constr, Label, Tokn,
     -- * Simplified terms
     STerm(..), (+.), (+!),
     -- * Record\/table paths
     Path(..), emptyPath,
     (++.), (++!)
    ) where

import GF.Infra.Ident (Ident(..))
import GF.Canon.AbsGFC
-- import qualified GF.OldParsing.FiniteTypes.Calc as Fin
import qualified GF.OldParsing.CFGrammar as CFG
import qualified GF.OldParsing.MCFGrammar as MCFG
import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm

import qualified GF.OldParsing.ConvertGFCtoSimple

----------------------------------------------------------------------

data PInfo = PInfo { mcfg :: MCFGrammar,
		     cfg :: CFGrammar,
		     mcfPInfo :: MCFPInfo,
		     cfPInfo :: CFPInfo }

type MCFGrammar  = MCFG.Grammar Name MCFCat MCFLabel Tokn
type MCFRule     = MCFG.Rule    Name MCFCat MCFLabel Tokn
type MCFPInfo    = MCFG.PInfo   Name MCFCat MCFLabel Tokn

data MCFCat      = MCFCat Cat [Constraint] deriving (Eq, Ord, Show)
type MCFLabel    = Path

type Constraint  = (Path, STerm)

type CFGrammar   = CFG.Grammar CFName CFCat Tokn
type CFRule      = CFG.Rule    CFName CFCat Tokn
type CFPInfo     = CFG.PInfo   CFName CFCat Tokn

type CFProfile   = [[Int]]
data CFName      = CFName Name   CFProfile deriving (Eq, Ord, Show)
data CFCat       = CFCat  MCFCat MCFLabel  deriving (Eq, Ord, Show)

----------------------------------------------------------------------

type Cat    = Ident
type Name   = Ident
type Constr = CIdent

data STerm    = SArg Int Cat Path     -- ^ argument variable, the 'Path' is a path 
				      -- pointing into the term 
	      | SCon Constr [STerm]   -- ^ constructor
	      | SRec [(Label, STerm)] -- ^ record
	      | STbl [(STerm, STerm)] -- ^ table of patterns\/terms
	      | SVariants [STerm]     -- ^ variants
	      | SConcat STerm STerm   -- ^ concatenation
	      | SToken Tokn           -- ^ single token
	      | SEmpty                -- ^ empty string
	      | SWildcard             -- ^ wildcard pattern variable

	      -- SRes CIdent        -- resource identifier
	      -- SVar Ident         -- bound pattern variable
	      -- SInt Integer       -- integer
		deriving (Eq, Ord, Show)

(+.) :: STerm -> Label -> STerm
SRec record +. lbl = maybe err id $ lookup lbl record
    where err = error $ "(+.), label not in record: " ++ show (SRec record) ++ " +. " ++ show lbl
SArg arg cat path +. lbl = SArg arg cat (path ++. lbl)
SVariants terms +. lbl = SVariants $ map (+. lbl) terms 
sterm +. lbl = error $ "(+.): " ++ show sterm ++ " +. " ++ show lbl

(+!) :: STerm -> STerm -> STerm
STbl table +! pat = maybe err id $ lookup pat table
    where err = error $ "(+!), pattern not in table: " ++ show (STbl table) ++ " +! " ++ show pat
SArg arg cat path +! pat = SArg arg cat (path ++! pat)
SVariants terms +! pat = SVariants $ map (+! pat) terms 
term +! SVariants pats = SVariants $ map (term +!) pats 
sterm +! pat = error $ "(+!): " ++ show sterm ++ " +! " ++ show pat

----------------------------------------------------------------------

newtype Path = Path [Either Label STerm] deriving (Eq, Ord, Show)

emptyPath :: Path
emptyPath = Path []

(++.) :: Path -> Label -> Path 
Path path ++. lbl = Path (Left lbl : path)

(++!) :: Path -> STerm -> Path 
Path path ++! sel = Path (Right sel : path)

------------------------------------------------------------

instance Print STerm where
    prt (SArg n c p) = prt c ++ "@" ++ prt n ++ prt p
    prt (SCon c [])  = prt c 
    prt (SCon c ts)  = prt c ++ prtList ts
    prt (SRec rec)   = "{" ++ concat [ prt l ++ "=" ++ prt t ++ ";" | (l,t) <- rec ] ++ "}"
    prt (STbl tbl)   = "[" ++ concat [ prt p ++ "=>" ++ prt t ++ ";" | (p,t) <- tbl ] ++ "}"
    prt (SVariants ts)  = "{| " ++ prtSep " | " ts ++ " |}"
    prt (SConcat t1 t2) = prt t1 ++ "++" ++ prt t2
    prt (SToken t)   = prt t
    prt (SEmpty)     = "[]"
    prt (SWildcard)  = "_"

instance Print MCFCat where
    prt (MCFCat cat params) 
	= prt cat ++ "{" ++ concat [ prt path ++ "=" ++ prt term ++ ";" |
				     (path, term) <- params ] ++ "}"

instance Print CFName where
    prt (CFName name profile) = prt name ++ prt profile

instance Print CFCat where
    prt (CFCat cat lbl) = prt cat ++ prt lbl

instance Print Path where
    prt (Path path) = concatMap prtEither (reverse path)
	where prtEither (Left  lbl)  = "." ++ prt lbl
	      prtEither (Right patt) = "!" ++ prt patt
