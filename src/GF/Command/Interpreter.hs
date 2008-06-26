module GF.Command.Interpreter (
  CommandEnv (..),
  mkCommandEnv,
  emptyCommandEnv,
  interpretCommandLine,
  interpretPipe,
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
import GF.Text.UTF8

import qualified Data.Map as Map

data CommandEnv = CommandEnv {
  multigrammar  :: PGF,
  commands      :: Map.Map String CommandInfo,
  commandmacros :: Map.Map String CommandLine,
  expmacros     :: Map.Map String Tree
  }

mkCommandEnv :: (String -> String) -> PGF -> CommandEnv
mkCommandEnv enc pgf = CommandEnv pgf (allCommands enc pgf) Map.empty Map.empty

emptyCommandEnv :: CommandEnv
emptyCommandEnv = mkCommandEnv encodeUTF8 emptyPGF

interpretCommandLine :: (String -> String) -> CommandEnv -> String -> IO ()
interpretCommandLine enc env line =
  case readCommandLine line of
    Just []    -> return ()
    Just pipes -> do res <- runInterruptibly (mapM_ (interpretPipe enc env) pipes)
                     case res of
                       Left ex -> putStrLnFlush $ enc (show ex)
                       Right x -> return x
    Nothing    -> putStrLnFlush "command not parsed"

interpretPipe enc env cs = do
     v@(_,s) <- intercs ([],"") cs
     putStrLnFlush $ enc s
     return v
  where
   intercs treess [] = return treess
   intercs (trees,_) (c:cs) = do
     treess2 <- interc trees c
     intercs treess2 cs
   interc es comm@(Command co _ arg) = case co of
     '%':f -> case Map.lookup f (commandmacros env) of
       Just css -> do
         mapM_ (interpretPipe enc env) (appLine (getCommandArg env arg es) css) 
         return ([],[]) ---- return ?
       _ -> do
         putStrLn $ "command macro " ++ co ++ " not interpreted"
         return ([],[])
     _ -> interpret enc env es comm
   appLine es = map (map (appCommand es))

-- macro definition applications: replace ?i by (exps !! i)
appCommand :: [Tree] -> Command -> Command
appCommand xs c@(Command i os arg) = case arg of
  ATree e -> Command i os (ATree (app e))
  _       -> c
 where
  app e = case e of
    Meta i   -> xs !! i
    Fun f as -> Fun f (map app as)
    Abs x b  -> Abs x (app b)

-- return the trees to be sent in pipe, and the output possibly printed
interpret :: (String -> String) -> CommandEnv -> [Tree] -> Command -> IO CommandOutput
interpret enc env trees0 comm = case lookCommand co comms of
    Just info -> do
      checkOpts info
      tss@(_,s) <- exec info opts trees
      optTrace $ enc s
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
getCommand :: CommandEnv -> Command -> [Tree] -> (String,[Option],[Tree])
getCommand env co@(Command c opts arg) ts = 
  (getCommandOp c,opts,getCommandArg env arg ts) 

getCommandArg :: CommandEnv -> Argument -> [Tree] -> [Tree]
getCommandArg env a ts = case a of
  AMacro m -> case Map.lookup m (expmacros env) of
    Just t -> [t]
    _ -> [] 
  ATree t -> [t] -- ignore piped
  ANoArg  -> ts  -- use piped

-- abbreviation convention from gf commands
getCommandOp s = case break (=='_') s of
     (a:_,_:b:_) -> [a,b]  -- axx_byy --> ab
     _ -> case s of
       [a,b] -> s          -- ab  --> ab
       a:_ -> [a]          -- axx --> a

