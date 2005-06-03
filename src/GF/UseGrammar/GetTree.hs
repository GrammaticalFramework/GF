----------------------------------------------------------------------
-- |
-- Module      : GetTree
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/03 21:51:59 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.8 $
--
-- how to form linearizable trees from strings and from terms of different levels
--
-- 'String' --> raw 'Term' --> annot, qualif 'Term' --> 'Tree'
-----------------------------------------------------------------------------

module GF.UseGrammar.GetTree where

import GF.Canon.GFC
import GF.Grammar.Values
import qualified GF.Grammar.Grammar as G
import GF.Infra.Ident
import GF.Grammar.MMacros
import GF.Grammar.Macros
import GF.Compile.Rename
import GF.Grammar.TypeCheck
import GF.Compile.PGrammar
import GF.Compile.ShellState

import GF.Data.Operations

import Data.Char

-- how to form linearizable trees from strings and from terms of different levels
--
-- String --> raw Term --> annot, qualif Term --> Tree

string2tree :: StateGrammar -> String -> Tree
string2tree gr = errVal uTree . string2treeErr gr

string2treeErr :: StateGrammar -> String -> Err Tree
string2treeErr _ "" = Bad "empty string"
string2treeErr gr s = do
  t <- pTerm s
  let t1 = refreshMetas [] t
  let t2 = qualifTerm abstr t1
  annotate grc t2
 where
   abstr = absId gr
   grc = grammar gr

string2Cat, string2Fun :: StateGrammar -> String -> (Ident,Ident)
string2Cat gr c = (absId gr,identC c)
string2Fun = string2Cat

strings2Cat, strings2Fun :: String -> (Ident,Ident)
strings2Cat s = (identC m, identC (drop 1 c)) where (m,c) = span (/= '.') s
strings2Fun = strings2Cat

string2ref :: StateGrammar -> String -> Err G.Term
string2ref gr s = case s of 
  'x':'_':ds -> return $ freshAsTerm ds --- hack for generated vars
  '"':_:_ -> return $ G.K $ init $ tail s
  _:_ | all isDigit s -> return $ G.EInt $ read s
  _ | elem '.' s -> return $ uncurry G.Q $ strings2Fun s
  _ -> return $ G.Vr $ identC s

string2cat :: StateGrammar -> String -> Err G.Cat
string2cat gr s = 
  if elem '.' s 
    then return $ strings2Fun s
    else return $ curry id (absId gr) (identC s)
