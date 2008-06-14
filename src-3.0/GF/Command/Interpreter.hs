module GF.Command.Interpreter (
  CommandEnv (..),
  mkCommandEnv,
  interpretCommandLine
  ) where

import GF.Command.Commands
import GF.Command.Abstract
import GF.Command.Parse
import PGF
import PGF.Data
import PGF.Macros
import GF.System.Signal
import GF.Infra.UseIO

import GF.Data.ErrM ----

import qualified Data.Map as Map

data CommandEnv = CommandEnv {
  multigrammar :: PGF,
  commands     :: Map.Map String CommandInfo
  }

mkCommandEnv :: PGF -> CommandEnv
mkCommandEnv pgf = CommandEnv pgf (allCommands pgf)

interpretCommandLine :: CommandEnv -> String -> IO ()
interpretCommandLine env line =
  case readCommandLine line of
    Just []    -> return ()
    Just pipes -> do res <- runInterruptibly (mapM_ interPipe pipes)
                     case res of
                       Left ex -> putStrLnFlush (show ex)
                       Right x -> return x
    Nothing    -> putStrLnFlush "command not parsed"
 where
   interPipe cs = do
     (_,s) <- intercs ([],"") cs
     putStrLnFlush s
   intercs treess [] = return treess
   intercs (trees,_) (c:cs) = do
     treess2 <- interc trees c
     intercs treess2 cs
   interc = interpret env

-- return the trees to be sent in pipe, and the output possibly printed
interpret :: CommandEnv -> [Exp] -> Command -> IO CommandOutput
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
       [o | OOpt  o   <- opts, notElem o ("tr" : map fst (options info))] ++
       [o | OFlag o _ <- opts, notElem o (map fst (flags info))]
      of
        []  -> return () 
        [o] -> putStrLn $ "option not interpreted: " ++ o
        os  -> putStrLn $ "options not interpreted: " ++ unwords os

-- analyse command parse tree to a uniform datastructure, normalizing comm name
getCommand :: Command -> [Exp] -> (String,[Option],[Exp])
getCommand co ts = case co of
  Command c opts (AExp t) -> (getOp c,opts,[t]) -- ignore piped
  Command c opts ANoArg   -> (getOp c,opts,ts)  -- use piped
 where
   -- abbreviation convention from gf
   getOp s = case break (=='_') s of
     (a:_,_:b:_) -> [a,b]  -- axx_byy --> ab
     _ -> case s of
       [a,b] -> s          -- ab  --> ab
       a:_ -> [a]          -- axx --> a

