----------------------------------------------------------------------
-- |
-- Module      : EmbedParsing
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 
-- > CVS $Author: 
-- > CVS $Revision: 
--
-- just one parse method, for use in embedded GF systems 
-----------------------------------------------------------------------------

module GF.Embed.EmbedParsing where

import GF.Infra.CheckM
import qualified GF.Canon.AbsGFC as C
import GF.Canon.GFC
import GF.Canon.MkGFC (trExp) ----
import GF.Canon.CMacros
import GF.Grammar.MMacros (refreshMetas)
import GF.UseGrammar.Linear
import GF.Data.Str
import GF.CF.CF
import GF.CF.CFIdent
import GF.Infra.Ident
import GF.Grammar.TypeCheck
import GF.Grammar.Values
import GF.UseGrammar.Tokenize
import GF.CF.Profile
import GF.Infra.Option
import GF.Compile.ShellState
import GF.Embed.EmbedCustom
import GF.CF.PPrCF (prCFTree)
import qualified GF.Parsing.GFC as New


-- import qualified GF.Parsing.GFC as New

import GF.Data.Operations

import Data.List (nub)
import Control.Monad (liftM)

-- AR 26/1/2000 -- 8/4 -- 28/1/2001 -- 9/12/2002

parseString :: Options -> StateGrammar -> CFCat -> String -> Err [Tree]
parseString os sg cat = liftM fst . parseStringMsg os sg cat

parseStringMsg :: Options -> StateGrammar -> CFCat -> String -> Err ([Tree],String)
parseStringMsg os sg cat s = do
  (ts,(_,ss)) <- checkStart $ parseStringC os sg cat s
  return (ts,unlines ss)

parseStringC :: Options -> StateGrammar -> CFCat -> String -> Check [Tree]
parseStringC opts0 sg cat s = do
  let opts      = unionOptions opts0 $ stateOptions sg
      algorithm = "f" -- default algorithm: FCFG
      strategy  = "bottomup" 
      tokenizer = customOrDefault opts useTokenizer customTokenizer sg
      toks = tokenizer s 
  ts  <- checkErr $ New.parse algorithm strategy (pInfo sg) (absId sg) cat toks
  checkErr $ allChecks $ map (annotate (stateGrammarST sg) . refreshMetas []) ts

