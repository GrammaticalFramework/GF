----------------------------------------------------------------------
-- |
-- Module      : MkConcrete
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 
-- > CVS $Author: 
-- > CVS $Revision: 
--
-- Compile a gfl file into a concrete syntax by using the parser on a resource grammar.
-----------------------------------------------------------------------------

module GF.Compile.MkConcrete (mkConcrete) where

import GF.Grammar.Values (Tree,tree2exp)
import GF.Grammar.PrGrammar (prt_)
import GF.Compile.ShellState (absId,stateGrammarWords)
import GF.API

import GF.Data.Operations
import GF.Infra.UseIO

import Data.Char
import Control.Monad

-- translate strings into lin rules by parsing in a resource
-- grammar. AR 2/6/2005

-- Format of rule (on one line):
--    lin F x y = in C "ssss" ;
-- Format of resource path (on first line):
--    --# -resource=PATH
-- Other lines are copied verbatim.


mkConcrete :: FilePath -> IO ()
mkConcrete file = do
  cont <- liftM lines $ readFileIf file
  let res = getResPath cont
  gr   <- file2grammar res
  let abs = prt_ $ absId gr
  let parser cat = parse gr (string2GFCat abs cat)
  let mor = \w -> isInBinTree w $ sorted2tree [(w,()) | w <- stateGrammarWords gr]
  writeFile (suffixFile "gf" (justModuleName file)) $ unlines $ 
    map (mkCnc parser mor) cont

getResPath :: [String] -> String
getResPath s = case head (dropWhile (all isSpace) s) of
  '-':'-':'#':path -> reverse (takeWhile (not . (=='=')) (reverse path))
  _ -> error "first line must be --# -resource=<PATH>" 

mkCnc :: (String -> String -> [Tree]) -> (String -> Bool) -> String -> String
mkCnc parser morph line = case words line of
  "lin" : rest -> mkLinRule rest
  _ -> line
 where
   mkLinRule s = 
    let
       (pre,str)  = span (/= "in") s
       ([cat],rest) = splitAt 1 $ tail str
       lin        = init (tail (unwords (init rest))) -- unquote
       def = case parser cat lin of 
         [t] -> prt_ $ tree2exp t 
         t:_ -> prt_ (tree2exp t) +++ "{- AMBIGUOUS -}"
         []  -> ""
    in
     if null def
       then "-- NO PARSE " ++ line
       else "lin " ++ unwords pre +++ def +++ ";"
