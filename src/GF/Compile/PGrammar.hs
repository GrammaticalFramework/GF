----------------------------------------------------------------------
-- |
-- Module      : PGrammar
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:43 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.7 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Compile.PGrammar (pTerm, pTrm, pTrms,
		 pMeta, pzIdent, 
		 string2ident
		) where

---import LexGF
import GF.Source.ParGF
import GF.Source.SourceToGrammar
import GF.Grammar.Grammar
import GF.Infra.Ident
import qualified GF.Canon.AbsGFC as A
import qualified GF.Canon.GFC as G
import GF.Compile.GetGrammar
import GF.Grammar.Macros
import GF.Grammar.MMacros

import GF.Data.Operations

pTerm :: String -> Err Term
pTerm s = do
  e <- {- err2err $ -} pExp $ myLexer s
  transExp e

pTrm :: String -> Term
pTrm = errVal (vr (zIdent "x")) . pTerm ---

pTrms :: String -> [Term]
pTrms = map pTrm . sep [] where
  sep t cs = case cs of
    ',' : cs2 -> reverse t : sep [] cs2
    c   : cs2 -> sep (c:t) cs2
    _         -> [reverse t]

pTrm' :: String -> [Term]
pTrm' = err (const []) singleton . pTerm

pMeta :: String -> Integer
pMeta _ = 0 ---

pzIdent :: String -> Ident
pzIdent = zIdent

{-
string2formsAndTerm :: String -> ([Term],Term)
string2formsAndTerm s = case s of
    '[':_:_ -> case span (/=']') s of  
      (x,_:y) -> (pTrms (tail x), pTrm y)
      _ -> ([],pTrm s)
    _ -> ([], pTrm s)
-}

string2ident :: String -> Err Ident
string2ident s = return $ string2var s

{-
-- reads the Haskell datatype
readGrammar :: String -> Err GrammarST
readGrammar s =  case [x | (x,t) <- reads s, ("","") <- lex t] of
  [x] -> return x
  []  -> Bad "no parse of Grammar"
  _   -> Bad "ambiguous parse of Grammar"
-}
