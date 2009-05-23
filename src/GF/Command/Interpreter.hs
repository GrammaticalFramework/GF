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
import PGF.Morphology
import GF.System.Signal
import GF.Infra.UseIO
import GF.Infra.Option

import GF.Data.ErrM ----

import qualified Data.Map as Map

data CommandEnv = CommandEnv {
  multigrammar  :: PGF,
  morphos       :: Map.Map Language Morpho,
  commands      :: Map.Map String CommandInfo,
  commandmacros :: Map.Map String CommandLine,
  expmacros     :: Map.Map String Expr
  }

mkCommandEnv :: Encoding -> PGF -> CommandEnv
mkCommandEnv enc pgf = 
  let mos = Map.fromList [(la,buildMorpho pgf la) | la <- languages pgf] in
    CommandEnv pgf mos (allCommands enc (pgf, mos)) Map.empty Map.empty

emptyCommandEnv :: CommandEnv
emptyCommandEnv = mkCommandEnv UTF_8 emptyPGF

interpretCommandLine :: (String -> String) -> CommandEnv -> String -> IO ()
interpretCommandLine enc env line =
  case readCommandLine line of
    Just []    -> return ()
    Just pipes -> mapM_ (interpretPipe enc env) pipes
{-
    Just pipes -> do res <- runInterruptibly (mapM_ (interpretPipe enc env) pipes)
                     case res of
                       Left ex -> putStrLnFlush $ enc (show ex)
                       Right x -> return x
-}
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
appCommand :: [Expr] -> Command -> Command
appCommand xs c@(Command i os arg) = case arg of
  AExpr e -> Command i os (AExpr (app e))
  _       -> c
 where
  app e = case e of
    EAbs x e   -> EAbs x (app e)
    EApp e1 e2 -> EApp (app e1) (app e2)
    ELit l     -> ELit l
    EMeta i    -> xs !! i
    EVar x     -> EVar x

-- return the trees to be sent in pipe, and the output possibly printed
interpret :: (String -> String) -> CommandEnv -> [Expr] -> Command -> IO CommandOutput
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
getCommand :: CommandEnv -> Command -> [Expr] -> (String,[Option],[Expr])
getCommand env co@(Command c opts arg) ts = 
  (getCommandOp c,opts,getCommandArg env arg ts) 

getCommandArg :: CommandEnv -> Argument -> [Expr] -> [Expr]
getCommandArg env a ts = case a of
  AMacro m -> case Map.lookup m (expmacros env) of
    Just t -> [t]
    _ -> [] 
  AExpr t -> [t] -- ignore piped
  ANoArg  -> ts  -- use piped

