module GF.Command.Interpreter (
  CommandEnv,pgfenv,commands,commandmacros,expmacros,
  mkCommandEnv,
--emptyCommandEnv,
  interpretCommandLine,
--interpretPipe,
  getCommandOp
  ) where
import Prelude hiding (putStrLn)

import GF.Command.CommandInfo
import GF.Command.Abstract
import GF.Command.Parse
--import PGF
import PGF.Internal(Expr(..))
--import PGF.Morphology
import GF.Infra.SIO(putStrLn,putStrLnFlush)

import GF.Text.Pretty(render)
import Control.Monad(when)
--import Control.Monad.Error()
import qualified Data.Map as Map

data CommandEnv env = CommandEnv {
  pgfenv        :: env,
  commands      :: Map.Map String (CommandInfo env),
  commandmacros :: Map.Map String CommandLine,
  expmacros     :: Map.Map String Expr
  }

--mkCommandEnv :: PGFEnv -> CommandEnv
mkCommandEnv env cmds = CommandEnv env cmds Map.empty Map.empty

--interpretCommandLine :: CommandEnv -> String -> SIO ()
interpretCommandLine env line =
  case readCommandLine line of
    Just []    -> return ()
    Just pipes -> mapM_ (interpretPipe env) pipes
    Nothing    -> putStrLnFlush "command not parsed"

interpretPipe env cs = do
     Piped v@(_,s) <- intercs void cs
     putStrLnFlush s
     return ()
  where
   intercs treess [] = return treess
   intercs (Piped (trees,_)) (c:cs) = do
     treess2 <- interc trees c
     intercs treess2 cs
   interc es comm@(Command co opts arg) = case co of
     '%':f -> case Map.lookup f (commandmacros env) of
       Just css ->
         case getCommandTrees env False arg es of
           Right es -> do mapM_ (interpretPipe env) (appLine es css) 
                          return void
           Left msg -> do putStrLn ('\n':msg)
                          return void
       Nothing  -> do
         putStrLn $ "command macro " ++ co ++ " not interpreted"
         return void
     _ -> interpret env es comm
   appLine es = map (map (appCommand es))

-- macro definition applications: replace ?i by (exps !! i)
appCommand :: [Expr] -> Command -> Command
appCommand xs c@(Command i os arg) = case arg of
  AExpr e -> Command i os (AExpr (app e))
  _       -> c
 where
  app e = case e of
    EAbs b x e -> EAbs b x (app e)
    EApp e1 e2 -> EApp (app e1) (app e2)
    ELit l     -> ELit l
    EMeta i    -> xs !! i
    EFun x     -> EFun x

-- return the trees to be sent in pipe, and the output possibly printed
--interpret :: CommandEnv -> [Expr] -> Command -> SIO CommandOutput
interpret env trees comm = 
  case getCommand env trees comm of
    Left  msg               -> do putStrLn ('\n':msg)
                                  return void
    Right (info,opts,trees) -> do let cmdenv = pgfenv env
                                  tss@(Piped (_,s)) <- exec info cmdenv opts trees
                                  when (isOpt "tr" opts) $ putStrLn s
                                  return tss

-- analyse command parse tree to a uniform datastructure, normalizing comm name
--- the env is needed for macro lookup
--getCommand :: CommandEnv -> [Expr] -> Command -> Either String (CommandInfo PGFEnv,[Option],[Expr])
getCommand env es co@(Command c opts arg) = do
  info <- getCommandInfo  env c
  checkOpts info opts
  es   <- getCommandTrees env (needsTypeCheck info) arg es
  return (info,opts,es)

--getCommandInfo :: CommandEnv -> String -> Either String (CommandInfo PGFEnv)
getCommandInfo env cmd = 
  case Map.lookup (getCommandOp cmd) (commands env) of
    Just info -> return info
    Nothing   -> fail $ "command not found: " ++ cmd

checkOpts :: CommandInfo env -> [Option] -> Either String ()
checkOpts info opts = 
  case
    [o | OOpt  o   <- opts, notElem o ("tr" : map fst (options info))] ++
    [o | OFlag o _ <- opts, notElem o (map fst (flags info))]
  of
    []  -> return () 
    [o] -> fail $ "option not interpreted: " ++ o
    os  -> fail $ "options not interpreted: " ++ unwords os

--getCommandTrees :: CommandEnv -> Bool -> Argument -> [Expr] -> Either String [Expr]
getCommandTrees env needsTypeCheck a es =
  case a of
    AMacro m -> case Map.lookup m (expmacros env) of
                  Just e -> return [e]
                  _      -> return [] 
    AExpr e -> if needsTypeCheck
                 then case typeCheckArg (pgfenv env) e of
                        Left tcErr -> fail $ render tcErr
                        Right e    -> return [e] -- ignore piped
                 else return [e]
    ANoArg  -> return es  -- use piped

