module GF.CompilerAPI where

-- started by AR 28/1/2011 - STILL DUMMY

import GF.Compile
-- SHOULD IMPORT MUCH LESS

-- the main compiler passes
import GF.Compile.GetGrammar
import GF.Compile.Rename
import GF.Compile.CheckGrammar
import GF.Compile.Optimize
import GF.Compile.SubExOpt
import GF.Compile.GrammarToPGF
import GF.Compile.ReadFiles
import GF.Compile.Update
import GF.Compile.Refresh

import GF.Compile.Coding

import GF.Grammar.Grammar
import GF.Grammar.Lookup
import GF.Grammar.Printer
import GF.Grammar.Binary

import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.Modules
import GF.Infra.UseIO
import GF.Infra.CheckM

import GF.Data.Operations

import Control.Monad
import System.IO
import System.Directory
import System.FilePath
import qualified Data.Map as Map
import qualified Data.Set as Set
import Data.List(nub)
import Data.Maybe (isNothing)
import Data.Binary
import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint

import PGF.CId
import PGF.Data
import PGF.Macros
import PGF.Optimize
import PGF.Probabilistic

-- the main types

type GF  = GF.Grammar.SourceGrammar
type PGF = PGF.PGF

-- some API functions - should take Options and perhaps some Env; return error msgs

exBasedGF :: FilePath -> IO GF

multiGF   :: FilePath -> IO GF

getGF     :: FilePath -> IO GF

cfGF      :: FilePath -> IO GF

ebnfGF    :: FilePath -> IO GF

emitGFO   :: GF -> IO ()

readGFO   :: FilePath -> IO GF

gf2pgf    :: GF -> PGF

emitPGF   :: PGF -> IO ()

readPGF   :: FilePath -> IO PGF

emitJSGF  :: PGF -> IO ()

emitSLF   :: PGF -> IO ()



exBasedGF = error "no exBasedGF"

multiGF = error "no multiGF"

getGF = error "no getGF"

cfGF = error "no cfGF"

ebnfGF = error "no ebnfGF"

emitGFO = error "no emitGFO"

readGFO = error "no readGFO"

gf2pgf = error "no gf2pgf" 

emitPGF = error "no emitPGF"

readPGF = error "no readPGF"

emitJSGF = error "no emitJSGF"

emitSLF = error "no emitSLF"


