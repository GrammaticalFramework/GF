module GF.Command.Interpreter where

import GF.Command.AbsGFShell hiding (Tree)
import GF.Command.PPrTree
import GF.Command.ParGFShell
import GF.GFCC.API
import GF.GFCC.Macros
import GF.GFCC.AbsGFCC ----

import GF.Command.ErrM ----

interpretCommandLine :: MultiGrammar -> String -> IO ()
interpretCommandLine gr line = case (pCommandLine (myLexer line)) of
  Ok CEmpty -> return ()
  Ok (CLine pipes) -> mapM_ interPipe pipes
  _ -> putStrLn "command not parsed"
 where
   interPipe (PComm cs) = do
     (_,s) <- intercs ([],"") cs
     putStrLn s
   intercs treess [] = return treess
   intercs (trees,_) (c:cs) = do
     treess2 <- interc trees c
     intercs treess2 cs
   interc = interpret gr

-- return the trees to be sent in pipe, and the output possibly printed
interpret :: MultiGrammar -> [Tree] -> Command -> IO ([Tree],String)
interpret mgr trees0 comm = do
  tss@(_,s) <- exec co
  optTrace s
  return tss
 where
   exec co = case co of
     "l"  -> return $ fromStrings $ map lin $ trees
     "p"  -> return $ fromTrees   $ concatMap par $ toStrings $ trees
     "gr" -> do
       ts <- generateRandom mgr optCat
       return $ fromTrees $ take optNum ts 
     _ -> return (trees,"command not interpreted")

   (co,opts,trees) = getCommand comm trees0

   lin t = unlines [linearize mgr lang t    | lang <- optLangs]
   par s = concat  [parse mgr lang optCat s | lang <- optLangs]
 
   optLangs = case valIdOpts "lang" "" opts of
     "" -> languages mgr
     lang -> [lang] 
   optCat   = valIdOpts "cat" (lookAbsFlag gr (cid "startcat")) opts
   optNum   = valIntOpts "number" 1 opts
   optTrace = if isOpt "tr" opts then putStrLn else const (return ()) 
   gr       = gfcc mgr

   fromTrees ts = (ts,unlines (map showTree ts))
   fromStrings ss = (map tStr ss, unlines ss)
   toStrings ts = [s | DTr [] (AS s) [] <- ts] 
   tStr s = DTr [] (AS s) []

valIdOpts :: String -> String -> [Option] -> String
valIdOpts flag def opts = case valOpts flag (VId (Ident def)) opts of
  VId (Ident v) -> v
  _ -> def

valIntOpts :: String -> Integer -> [Option] -> Int
valIntOpts flag def opts = fromInteger $ case valOpts flag (VInt def) opts of
  VInt v -> v
  _ -> def

valOpts :: String -> Value -> [Option] -> Value
valOpts flag def opts = case lookup flag flags of
  Just v -> v
  _ -> def
 where
   flags = [(f,v) | OFlag (Ident f) v <- opts]

isOpt :: String -> [Option] -> Bool
isOpt o opts = elem o [x | OOpt (Ident x) <- opts]

-- analyse command parse tree to a uniform datastructure, normalizing comm name
getCommand :: Command -> [Tree] -> (String,[Option],[Tree])
getCommand co ts = case co of
  Comm   (Ident c) opts (ATree t) -> (getOp c,opts,[tree2exp t]) -- ignore piped
  CNoarg (Ident c) opts           -> (getOp c,opts,ts)           -- use piped
 where
   -- abbreviation convention from gf
   getOp s = case break (=='_') s of
     (a:_,_:b:_) -> [a,b]  -- axx_byy --> ab
     _ -> case s of
       [a,b] -> s          -- ab  --> ab
       a:_ -> [a]          -- axx --> a

