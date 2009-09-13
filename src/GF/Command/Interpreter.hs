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
import PGF.Morphology
import GF.System.Signal
import GF.Infra.UseIO
import GF.Infra.Option

import Text.PrettyPrint
import Control.Monad.Error
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
   interc es comm@(Command co opts arg) = case co of
     '%':f -> case Map.lookup f (commandmacros env) of
       Just css ->
         case getCommandTrees env False arg es of
           Right es -> do mapM_ (interpretPipe enc env) (appLine es css) 
                          return ([],[])
           Left msg -> do putStrLn ('\n':msg)
                          return ([],[])
       Nothing  -> do
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
    EFun x     -> EFun x

-- return the trees to be sent in pipe, and the output possibly printed
interpret :: (String -> String) -> CommandEnv -> [Expr] -> Command -> IO CommandOutput
interpret enc env trees comm = 
  case getCommand env trees comm of
    Left  msg               -> do putStrLn ('\n':msg)
                                  return ([],[])
    Right (info,opts,trees) -> do tss@(_,s) <- exec info opts trees
                                  if isOpt "tr" opts
                                    then putStrLn (enc s)
                                    else return ()
                                  return tss

-- analyse command parse tree to a uniform datastructure, normalizing comm name
--- the env is needed for macro lookup
getCommand :: CommandEnv -> [Expr] -> Command -> Either String (CommandInfo,[Option],[Expr])
getCommand env es co@(Command c opts arg) = do
  info <- getCommandInfo  env c
  checkOpts info opts
  es   <- getCommandTrees env (needsTypeCheck info) arg es
  return (info,opts,es)

getCommandInfo :: CommandEnv -> String -> Either String CommandInfo
getCommandInfo env cmd = 
  case lookCommand (getCommandOp cmd) (commands env) of
    Just info -> return info
    Nothing   -> fail $ "command " ++ cmd ++ " not interpreted"

checkOpts :: CommandInfo -> [Option] -> Either String ()
checkOpts info opts = 
  case
    [o | OOpt  o   <- opts, notElem o ("tr" : map fst (options info))] ++
    [o | OFlag o _ <- opts, notElem o (map fst (flags info))]
  of
    []  -> return () 
    [o] -> fail $ "option not interpreted: " ++ o
    os  -> fail $ "options not interpreted: " ++ unwords os

getCommandTrees :: CommandEnv -> Bool -> Argument -> [Expr] -> Either String [Expr]
getCommandTrees env needsTypeCheck a es =
  case a of
    AMacro m -> case Map.lookup m (expmacros env) of
                  Just e -> return [e]
                  _      -> return [] 
    AExpr e -> if needsTypeCheck
                 then case inferExpr (multigrammar env) e of
                        Left tcErr   -> fail $ render (ppTcError tcErr)
                        Right (e,ty) -> return [e] -- ignore piped
                 else return [e]
    ANoArg  -> return es  -- use piped

