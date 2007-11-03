module GF.Command.Interpreter where

import GF.Command.AbsGFShell
import GF.Command.ParGFShell
import GF.GFCC.API

import GF.Command.ErrM


interpretCommandLine :: MultiGrammar -> CommandLine -> IO ()
interpretCommandLine gr line = case line of
  CEmpty -> return ()
  CLine pipes -> mapM_ interPipe pipes
 where
   interPipe (PComm cs) = do
     ts <- intercs [] cs
     mapM_ (putStrLn . showTree) ts
   intercs trees [] = return trees
   intercs trees (c:cs) = do
     trees2 <- interc trees c
     intercs trees2 cs
   interc = interpret gr

interpret :: MultiGrammar -> [Tree] -> Command -> IO [Tree]
interpret gr trees comm = case (trees,command comm) of
  _ -> return trees ----  
