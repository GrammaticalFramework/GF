module GF.Command.Interpreter (
  CommandEnv (..),
  mkCommandEnv,
  emptyCommandEnv,
  interpretCommandLine,
  getCommandOp
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
  multigrammar  :: PGF,
  commands      :: Map.Map String CommandInfo,
  commandmacros :: Map.Map String CommandLine,
  expmacros     :: Map.Map String Exp
  }

mkCommandEnv :: PGF -> CommandEnv
mkCommandEnv pgf = CommandEnv pgf (allCommands pgf) Map.empty Map.empty

emptyCommandEnv :: CommandEnv
emptyCommandEnv = mkCommandEnv emptyPGF

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
   interc es comm@(Command co _ arg) = case co of
     '%':f -> case Map.lookup f (commandmacros env) of
       Just css -> do
         mapM_ interPipe (appLine (getCommandArg env arg es) css) 
         return ([],[]) ---- return ?
       _ -> do
         putStrLn $ "command macro " ++ co ++ " not interpreted"
         return ([],[])
     _ -> interpret env es comm
   appLine es = map (map (appCommand es))

-- macro definition applications: replace ?i by (exps !! i)
appCommand :: [Exp] -> Command -> Command
appCommand xs c@(Command i os arg) = case arg of
  AExp e -> Command i os (AExp (app e))
  _ -> c
 where
  app e = case e of
    EMeta i -> xs !! i
    EApp f as -> EApp f (map app as)
    EAbs x b  -> EAbs x (app b)

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
   (co,opts,trees) = getCommand env comm trees0
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
--- the env is needed for macro lookup
getCommand :: CommandEnv -> Command -> [Exp] -> (String,[Option],[Exp])
getCommand env co@(Command c opts arg) ts = 
  (getCommandOp c,opts,getCommandArg env arg ts) 

getCommandArg :: CommandEnv -> Argument -> [Exp] -> [Exp]
getCommandArg env a ts = case a of
  AMacro m -> case Map.lookup m (expmacros env) of
    Just t -> [t]
    _ -> [] 
  AExp t -> [t] -- ignore piped
  ANoArg -> ts  -- use piped

-- abbreviation convention from gf commands
getCommandOp s = case break (=='_') s of
     (a:_,_:b:_) -> [a,b]  -- axx_byy --> ab
     _ -> case s of
       [a,b] -> s          -- ab  --> ab
       a:_ -> [a]          -- axx --> a

