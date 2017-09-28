module GF.Command.Interpreter (
  CommandEnv(..),mkCommandEnv,
  interpretCommandLine,
  getCommandOp
  ) where
import GF.Command.CommandInfo
import GF.Command.Abstract
import GF.Command.Parse
import PGF
import GF.Infra.UseIO(putStrLnE)

import Control.Monad(when)
import qualified Data.Map as Map

data CommandEnv m = CommandEnv {
  commands      :: Map.Map String (CommandInfo m),
  commandmacros :: Map.Map String CommandLine,
  expmacros     :: Map.Map String Expr
  }

--mkCommandEnv :: PGFEnv -> CommandEnv
mkCommandEnv cmds = CommandEnv cmds Map.empty Map.empty

--interpretCommandLine :: CommandEnv -> String -> SIO ()
interpretCommandLine env line =
  case readCommandLine line of
    Just []    -> return ()
    Just pipes -> mapM_ (interpretPipe env) pipes
    Nothing    -> putStrLnE $ "command not parsed: "++line

interpretPipe env cs = do
     Piped v@(_,s) <- intercs cs void
     putStrLnE s
     return ()
  where
   intercs [] args = return args
   intercs (c:cs) (Piped (args,_)) = interc c args >>= intercs cs

   interc comm@(Command co opts arg) args =
     case co of
       '%':f -> case Map.lookup f (commandmacros env) of
         Just css ->
           do args <- getCommandTrees env False arg args
              mapM_ (interpretPipe env) (appLine args css)
              return void
         Nothing  -> do
           putStrLnE $ "command macro " ++ co ++ " not interpreted"
           return void
       _ -> interpret env args comm

   appLine = map . map . appCommand

-- | macro definition applications: replace ?i by (exps !! i)
appCommand :: CommandArguments -> Command -> Command
appCommand args c@(Command i os arg) = case arg of
  AExpr e -> Command i os (AExpr (exprSubstitute e (toExprs args)))
  _       -> c

-- | return the trees to be sent in pipe, and the output possibly printed
--interpret :: CommandEnv -> [Expr] -> Command -> SIO CommandOutput
interpret env trees comm = 
  do (info,opts,trees) <- getCommand env trees comm
     tss@(Piped (_,s)) <- exec info opts trees
     when (isOpt "tr" opts) $ putStrLnE s
     return tss

-- | analyse command parse tree to a uniform datastructure, normalizing comm name
--- the env is needed for macro lookup
--getCommand :: CommandEnv -> [Expr] -> Command -> Either String (CommandInfo PGFEnv,[Option],[Expr])
getCommand env es co@(Command c opts arg) =
  do info <- getCommandInfo  env c
     checkOpts info opts
     es <- getCommandTrees env (needsTypeCheck info) arg es
     return (info,opts,es)

--getCommandInfo :: CommandEnv -> String -> Either String (CommandInfo PGFEnv)
getCommandInfo env cmd = 
  case Map.lookup (getCommandOp cmd) (commands env) of
    Just info -> return info
    Nothing   -> fail $ "command not found: " ++ cmd

--checkOpts :: CommandInfo env -> [Option] -> Either String ()
checkOpts info opts = 
  case
    [o | OOpt  o   <- opts, notElem o ("tr" : map fst (options info))] ++
    [o | OFlag o _ <- opts, notElem o (map fst (flags info))]
  of
    []  -> return () 
    [o] -> fail $ "option not interpreted: " ++ o
    os  -> fail $ "options not interpreted: " ++ unwords os

--getCommandTrees :: CommandEnv -> Bool -> Argument -> [Expr] -> Either String [Expr]
getCommandTrees env needsTypeCheck a args =
  case a of
    AMacro m -> case Map.lookup m (expmacros env) of
                  Just e -> one e
                  _      -> return (Exprs []) -- report error?
    AExpr e -> if needsTypeCheck
               then one =<< typeCheckArg e
               else one e
    ATerm t -> return (Term t)
    ANoArg  -> return args  -- use piped
  where
    one e = return (Exprs [e]) -- ignore piped
