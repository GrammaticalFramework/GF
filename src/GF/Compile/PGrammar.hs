module PGrammar where

---import LexGF
import ParGF
import SourceToGrammar
import Grammar
import Ident
import qualified AbsGFC as A
import qualified GFC as G
import GetGrammar
import Macros

import Operations

pTerm :: String -> Err Term
pTerm s = do
  e <- err2err $ pExp $ myLexer s
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
string2ident s = return $ case s of
  c:'_':i -> identV (readIntArg i,[c]) ---
  _ -> zIdent s

{-
-- reads the Haskell datatype
readGrammar :: String -> Err GrammarST
readGrammar s =  case [x | (x,t) <- reads s, ("","") <- lex t] of
  [x] -> return x
  []  -> Bad "no parse of Grammar"
  _   -> Bad "ambiguous parse of Grammar"
-}
