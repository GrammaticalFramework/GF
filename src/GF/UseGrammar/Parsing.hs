module Parsing where

import CheckM
import qualified AbsGFC as C
import GFC
import MkGFC (trExp) ----
import CMacros
import MMacros (refreshMetas)
import Linear
import Str
import CF
import CFIdent
import Ident
import TypeCheck
import Values
--import CFMethod
import Tokenize
import Profile
import Option
import Custom
import ShellState

import qualified ExportParser as N

import Operations

import List (nub)
import Monad (liftM)

-- AR 26/1/2000 -- 8/4 -- 28/1/2001 -- 9/12/2002

parseString :: Options -> StateGrammar -> CFCat -> String -> Err [Tree]
parseString os sg cat = liftM fst . parseStringMsg os sg cat

parseStringMsg :: Options -> StateGrammar -> CFCat -> String -> Err ([Tree],String)
parseStringMsg os sg cat s = do
  (ts,(_,ss)) <- checkStart $ parseStringC os sg cat s
  return (ts,unlines ss)

parseStringC :: Options -> StateGrammar -> CFCat -> String -> Check [Tree]
parseStringC opts0 sg cat s

---- to test peb's new parser 6/10/2003
 | oElem newParser opts0 = do  
  let pm = maybe "" id $ getOptVal opts0 useParser -- -parser=pm
      gr = grammar sg
      ct = cfCat2Cat cat
  ts <- checkErr $ N.newParser pm gr (cfCat2Cat cat) s
  mapM (checkErr . (annotate gr)) ts

 | otherwise = do
  let opts = unionOptions opts0 $ stateOptions sg
      cf  = stateCF sg
      gr  = stateGrammarST sg
      cn  = cncId sg
      tok = customOrDefault opts useTokenizer customTokenizer sg
      parser = customOrDefault opts useParser customParser sg cat
  tokens2trms opts sg cn parser (tok s)

tokens2trms :: Options ->StateGrammar ->Ident -> CFParser -> [CFTok] -> Check [Tree]
tokens2trms opts sg cn parser as = do
  let res@(trees,info) = parser as
  ts0 <- return $ cfParseResults res          -- removed nub, peb 25/5-04
  -- ts0 <- return $ nub (cfParseResults res) -- nub gives quadratic behaviour!
                                              -- SortedList.nubsort is O(n log n)
  ts  <- case () of
    _ | null ts0 -> checkWarn "No success in cf parsing" >> return []
    _ | raw      -> do
      ts1 <- return (map cf2trm0 ts0) ----- should not need annot
      mapM (checkErr . (annotate gr) . trExp) ts1 ---- complicated; often fails
    _ -> do
      (ts1,ss) <- checkErr $ mapErr postParse ts0
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
     then checkWarn $ " the token list" +++ show as ++++ unknown as +++++ info
     else return ()

  return $ optIntOrAll opts flagNumber $ nub ts
 where
   gr  = stateGrammarST sg

   raw     = oElem rawParse opts
   verb    = oElem beVerbose opts
   forgive = oElem forgiveParse opts

   unknown ts = case filter noMatch [t | t@(TS _) <- ts] of
     [] -> "where all words are known"
     us -> "with the unknown tokens" +++ show us --- needs to be fixed for literals
   terminals = map TS $ stateGrammarWords sg
   noMatch t = all (not . compatTok t) terminals 
     

--- too much type checking in building term info? return FullTerm to save work?

-- raw parsing: so simple it is for a context-free CF grammar
cf2trm0 :: CFTree -> C.Exp
cf2trm0 (CFTree (fun, (_, trees))) = mkAppAtom (cffun2trm fun) (map cf2trm0 trees)
 where
   cffun2trm (CFFun (fun,_)) = fun
   mkApp = foldl C.EApp
   mkAppAtom a = mkApp (C.EAtom a)
