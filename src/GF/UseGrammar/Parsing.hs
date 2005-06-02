----------------------------------------------------------------------
-- |
-- Module      : Parsing
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/02 10:23:52 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.25 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.UseGrammar.Parsing where

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
--import CFMethod
import GF.UseGrammar.Tokenize
import GF.CF.Profile
import GF.Infra.Option
import GF.UseGrammar.Custom
import GF.Compile.ShellState

import GF.CF.PPrCF (prCFTree)
-- import qualified GF.OldParsing.ParseGFC as NewOld -- OBSOLETE
import qualified GF.Parsing.GFC as New

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

---- to test peb's new parser 6/10/2003
---- (obsoleted by "newer" below)
-- parseStringC opts0 sg cat s
--  | oElem newParser opts0 = do  
--   let pm = maybe "" id $ getOptVal opts0 useParser -- -parser=pm
--       ct = cfCat2Cat cat
--   ts <- checkErr $ NewOld.newParser pm sg ct s
--   mapM (checkErr . annotate (stateGrammarST sg) . refreshMetas []) ts

-- to use peb's newer parser 7/4-05 
parseStringC opts0 sg cat s
 | oElem newCParser opts0 || oElem newMParser opts0 || oElem newParser opts0 || oElem newerParser opts0 = do  
  let opts      = unionOptions opts0 $ stateOptions sg
      algorithm | oElem newCParser opts0 = "c"
		| oElem newMParser opts0 = "m"
		| otherwise              = "c" -- default algorithm
      strategy  = maybe "bottomup" id $ getOptVal opts useParser -- -parser=bottomup/topdown
      tokenizer = customOrDefault opts useTokenizer customTokenizer sg
  ts <- checkErr $ New.parse algorithm strategy (pInfo sg) (absId sg) cat (tokenizer s)
  ts' <- mapM (checkErr . annotate (stateGrammarST sg) . refreshMetas []) ts
  return $ optIntOrAll opts flagNumber ts'

parseStringC opts0 sg cat s = do
  let opts = unionOptions opts0 $ stateOptions sg
      cf  = stateCF sg
      gr  = stateGrammarST sg
      cn  = cncId sg
      tok = customOrDefault opts useTokenizer customTokenizer sg
      parser = customOrDefault opts useParser customParser sg cat
  tokens2trms opts sg cn parser (tok s)


tokens2trms :: Options ->StateGrammar ->Ident -> CFParser -> [CFTok] -> Check [Tree]
tokens2trms opts sg cn parser toks = trees2trms opts sg cn toks trees info
    where result = parser toks
	  info   = snd result
	  trees  = {- nub $ -} cfParseResults result -- peb 25/5-04: removed nub (O(n^2))

trees2trms :: Options -> StateGrammar -> Ident -> [CFTok] -> [CFTree] -> String -> Check [Tree]
trees2trms opts sg cn as ts0 info = do
  ts  <- case () of
    _ | null ts0 -> checkWarn "No success in cf parsing" >> return []
    _ | raw      -> do
      ts1 <- return (map cf2trm0 ts0) ----- should not need annot
      checks [
         mapM (checkErr . (annotate gr) . trExp) ts1 ---- complicated, often fails
        ,checkWarn (unlines ("Raw CF trees:":(map prCFTree ts0))) >> return []
        ]
    _ -> do
      let num = optIntOrN opts flagRawtrees 999999
      let (ts01,rest) = splitAt num ts0
      if null rest then return () 
         else raise ("Warning: only" +++ show num +++ "raw parses out of" +++ 
                          show (length ts0) +++ 
                          "considered; use -rawtrees=<Int> to see more"
                     )
      (ts1,ss) <- checkErr $ mapErrN 1 postParse ts01
      if null ts1 then raise ss else return ()
      ts2 <- mapM (checkErr . annotate gr . refreshMetas [] . trExp) ts1 ---- 
      if forgive then return ts2 else do
        let tsss = [(t, allLinsOfTree gr cn t) | t <- ts2]
            ps = [t | (t,ss) <- tsss, 
                      any (compatToks as) (map str2cftoks ss)]
        if null ps 
           then raise $ "Failure in morphology." ++
                  if verb 
                     then "\nPossible corrections: " +++++
                          unlines (nub (map sstr (concatMap snd tsss)))
                     else ""
           else return ps

  if verb 
     then checkWarn $ " the token list" +++ show as ++++ unknownWords sg as +++++ info
     else return ()

  return $ optIntOrAll opts flagNumber $ nub ts
 where
   gr  = stateGrammarST sg

   raw     = oElem rawParse opts
   verb    = oElem beVerbose opts
   forgive = oElem forgiveParse opts

unknownWords sg ts = case filter noMatch [t | t@(TS _) <- ts] of
     [] -> "where all words are known"
     us -> "with the unknown tokens" +++ show us --- needs to be fixed for literals
  where
   terminals = map TS $ stateGrammarWords sg
   noMatch t = all (not . compatTok t) terminals 
     

--- too much type checking in building term info? return FullTerm to save work?

-- | raw parsing: so simple it is for a context-free CF grammar
cf2trm0 :: CFTree -> C.Exp
cf2trm0 (CFTree (fun, (_, trees))) = mkAppAtom (cffun2trm fun) (map cf2trm0 trees)
 where
   cffun2trm (CFFun (fun,_)) = fun
   mkApp = foldl C.EApp
   mkAppAtom a = mkApp (C.EAtom a)
