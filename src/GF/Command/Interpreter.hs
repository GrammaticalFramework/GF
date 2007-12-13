module GF.Command.Interpreter (
  CommandEnv (..),
  interpretCommandLine
  ) where

import GF.Command.Commands
import GF.Command.AbsGFShell hiding (Tree)
import GF.Command.PPrTree
import GF.Command.ParGFShell
import GF.GFCC.API
import GF.GFCC.Macros
import GF.GFCC.DataGFCC

import GF.Command.ErrM ----

import qualified Data.Map as Map

data CommandEnv = CommandEnv {
  multigrammar :: MultiGrammar,
  commands     :: Map.Map String CommandInfo
  }

interpretCommandLine :: CommandEnv -> String -> IO ()
interpretCommandLine env line = case (pCommandLine (myLexer line)) of
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
   interc = interpret env

-- return the trees to be sent in pipe, and the output possibly printed
interpret :: CommandEnv -> [Tree] -> Command -> IO CommandOutput
interpret env trees0 comm = case lookCommand co comms of
  Just info -> do
    checkOpts info
    tss@(_,s) <- exec info opts trees
    optTrace s
    return tss
  _ -> do
    putStrLn $ "command " ++ co ++ " not interpreted"
    return ([],[])
 where
   optTrace = if isOpt "tr" opts then putStrLn else const (return ()) 
   (co,opts,trees) = getCommand comm trees0
   comms = commands env
   checkOpts info = 
     case
       [o | OOpt  (Ident o)   <- opts, notElem o (options info)] ++
       [o | OFlag (Ident o) _ <- opts, notElem o (flags info)]
      of
        []  -> return () 
        [o] -> putStrLn $ "option not interpreted: " ++ o
        os  -> putStrLn $ "options not interpreted: " ++ unwords os

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

