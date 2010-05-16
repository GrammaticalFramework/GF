-- GF C Bindings
-- Copyright (C) 2008-2010 Kevin Kofler
--
-- This library is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
--
-- This library is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library; if not, see <http://www.gnu.org/licenses/>.


module PGFFFI where

import PGF
import CString
import Foreign
import Foreign.C.Types
import Control.Exception
import IO
import Data.Maybe
-- import GF.Text.Lexing


-- Utility functions used in the implementation (not exported):

-- This is a kind of a hack, the FFI spec doesn't guarantee that this will work.
-- The alternative would be to use Ptr () instead of StablePtr a everywhere.
nullStablePtr :: StablePtr a
nullStablePtr = (castPtrToStablePtr nullPtr)

sizeOfStablePtr :: Int
sizeOfStablePtr = (sizeOf (nullStablePtr))

storeList :: [a] -> Ptr (StablePtr a) -> IO ()
storeList list buf = do
  case list of
    carlist:cdrlist -> do
      sptr <- (newStablePtr carlist)
      (poke buf sptr)
      (storeList cdrlist (plusPtr buf sizeOfStablePtr))
    [] -> (poke buf nullStablePtr)

listToArray :: [a] -> IO (Ptr (StablePtr a))
listToArray list = do
    buf <- (mallocBytes ((sizeOfStablePtr) * ((length list) + 1)))
    (storeList list buf)
    return buf


-- * PGF
foreign export ccall "gf_freePGF" freeStablePtr :: StablePtr PGF -> IO ()

foreign export ccall gf_readPGF :: CString -> IO (StablePtr PGF)
gf_readPGF path = do
  p <- (peekCString path)
  result <- (readPGF p)
  (newStablePtr result)

-- * Identifiers
foreign export ccall "gf_freeCId" freeStablePtr :: StablePtr CId -> IO ()

foreign export ccall gf_mkCId :: CString -> IO (StablePtr CId)
gf_mkCId str = do
  s <- (peekCString str)
  (newStablePtr (mkCId s))

foreign export ccall gf_wildCId :: IO (StablePtr CId)
gf_wildCId = do
  (newStablePtr (wildCId))

foreign export ccall gf_showCId :: StablePtr CId -> IO CString
gf_showCId cid = do
  c <- (deRefStablePtr cid)
  (newCString (showCId c))

foreign export ccall gf_readCId :: CString -> IO (StablePtr CId)
gf_readCId str = do
  s <- (peekCString str)
  case (readCId s) of
    Just x -> (newStablePtr x)
    Nothing -> (return (nullStablePtr))

-- TODO: So we can create, print and free a CId, but can we do anything useful with it?
--       We need some kind of C wrapper for the tree datastructures.

-- * Languages
foreign export ccall "gf_freeLanguage" freeStablePtr :: StablePtr Language -> IO ()

foreign export ccall gf_showLanguage :: StablePtr Language -> IO CString
gf_showLanguage lang = do
  l <- (deRefStablePtr lang)
  (newCString (showLanguage l))

foreign export ccall gf_readLanguage :: CString -> IO (StablePtr Language)
gf_readLanguage str = do
  s <- (peekCString str)
  case (readLanguage s) of
    Just x -> (newStablePtr x)
    Nothing -> (return (nullStablePtr))

foreign export ccall gf_languages :: StablePtr PGF -> IO (Ptr (StablePtr Language))
gf_languages pgf = do
  p <- (deRefStablePtr pgf)
  (listToArray (languages p))

foreign export ccall gf_abstractName :: StablePtr PGF -> IO (StablePtr Language)
gf_abstractName pgf = do
  p <- (deRefStablePtr pgf)
  (newStablePtr (abstractName p))

foreign export ccall gf_languageCode :: StablePtr PGF -> StablePtr Language -> IO CString
gf_languageCode pgf lang = do
  p <- (deRefStablePtr pgf)
  l <- (deRefStablePtr lang)
  case (languageCode p l) of
    Just s -> (newCString s)
    Nothing -> (return nullPtr)

-- * Types
foreign export ccall "gf_freeType" freeStablePtr :: StablePtr Type -> IO ()

-- TODO: Hypo

-- TODO: allow nonempty scope
foreign export ccall gf_showType :: StablePtr Type -> IO CString
gf_showType tp = do
  t <- (deRefStablePtr tp)
  (newCString (showType [] t))

foreign export ccall gf_readType :: CString -> IO (StablePtr Type)
gf_readType str = do
  s <- (peekCString str)
  case (readType s) of
    Just x -> (newStablePtr x)
    Nothing -> (return (nullStablePtr))

-- TODO: mkType, mkHypo, mkDepHypo, mkImplHypo

foreign export ccall gf_categories :: StablePtr PGF -> IO (Ptr (StablePtr CId))
gf_categories pgf = do
  p <- (deRefStablePtr pgf)
  (listToArray (categories p))

foreign export ccall gf_startCat :: StablePtr PGF -> IO (StablePtr Type)
gf_startCat pgf = do
  p <- (deRefStablePtr pgf)
  (newStablePtr (startCat p))

-- TODO: * Functions

-- * Expressions & Trees
-- ** Tree
foreign export ccall "gf_freeTree" freeStablePtr :: StablePtr Tree -> IO ()

-- ** Expr
foreign export ccall "gf_freeExpr" freeStablePtr :: StablePtr Expr -> IO ()

-- TODO: allow nonempty scope
foreign export ccall gf_showExpr :: StablePtr Expr -> IO CString
gf_showExpr expr = do
  e <- (deRefStablePtr expr)
  (newCString (showExpr [] e))

foreign export ccall gf_readExpr :: CString -> IO (StablePtr Expr)
gf_readExpr str = do
  s <- (peekCString str)
  case (readExpr s) of
    Just x -> (newStablePtr x)
    Nothing -> (return (nullStablePtr))

-- * Operations
-- ** Linearization
foreign export ccall gf_linearize :: StablePtr PGF -> StablePtr Language -> StablePtr Tree -> IO CString
gf_linearize pgf lang tree = do
  p <- (deRefStablePtr pgf)
  l <- (deRefStablePtr lang)
  t <- (deRefStablePtr tree)
  (newCString (linearize p l t))

-- TODO: linearizeAllLang, linearizeAll, bracketedLinearize, tabularLinearizes
-- TODO: groupResults

foreign export ccall gf_showPrintName :: StablePtr PGF -> StablePtr Language -> StablePtr CId -> IO CString
gf_showPrintName pgf lang cid = do
  p <- (deRefStablePtr pgf)
  l <- (deRefStablePtr lang)
  c <- (deRefStablePtr cid)
  (newCString (showPrintName p l c))

-- TODO: BracketedString(..), FId, LIndex, Forest.showBracketedString

-- ** Parsing
foreign export ccall gf_parse :: StablePtr PGF -> StablePtr Language -> StablePtr Type -> CString -> IO (Ptr (StablePtr Tree))
gf_parse pgf lang cat input = do
  p <- (deRefStablePtr pgf)
  l <- (deRefStablePtr lang)
  c <- (deRefStablePtr cat)
  i <- (peekCString input)
  (listToArray (parse p l c i))

-- TODO: parseAllLang, parseAll, parse_, parseWithRecovery

-- TODO: ** Evaluation
-- TODO: ** Type Checking
-- TODO: ** Low level parsing API
-- TODO: ** Generation
-- TODO: ** Morphological Analysis
-- TODO: ** Visualizations

-- TODO: * Browsing

-- GF.Text.Lexing:

-- foreign export ccall gf_stringOp :: CString -> CString -> IO CString
-- gf_stringOp op str = do
--   o <- (peekCString op)
--   s <- (peekCString str)
--   case (stringOp o) of
--     Just fn -> (newCString (fn s))
--     Nothing -> (return nullPtr)


-- Unused (exception handling):
--  (Control.Exception.catch (listToArray (parse p l c i)) (\(e::SomeException) -> do
--  (hPutStr stderr ("error: " ++ show e))
--  (return nullPtr)))
