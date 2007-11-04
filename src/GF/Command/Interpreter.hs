module GF.Command.Interpreter (
  interpretCommandLine
  ) where

import GF.Command.AbsGFShell hiding (Tree)
import GF.Command.PPrTree
import GF.Command.ParGFShell
import GF.GFCC.API
import GF.GFCC.Macros
import GF.GFCC.AbsGFCC ----

import GF.Command.ErrM ----

import qualified Data.Map as Map

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
interpret :: MultiGrammar -> [Tree] -> Command -> IO CommandOutput
interpret mgr trees0 comm = case lookCommand co commands of
  Just info -> do
    checkOpts info
    tss@(_,s) <- exec info trees
    optTrace s
    return tss
  _ -> do
    putStrLn $ "command " ++ co ++ " not interpreted"
    return ([],[])
 where
   optTrace = if isOpt "tr" opts then putStrLn else const (return ()) 
   (co,opts,trees) = getCommand comm trees0
   commands = allCommands mgr opts
   checkOpts info = 
     case
       [o | OOpt  (Ident o)   <- opts, notElem o (options info)] ++
       [o | OFlag (Ident o) _ <- opts, notElem o (flags info)]
      of
        []  -> return () 
        [o] -> putStrLn $ "option not interpreted: " ++ o
        os  -> putStrLn $ "options not interpreted: " ++ unwords os

type CommandOutput = ([Tree],String) ---- errors, etc

data CommandInfo = CommandInfo {
  exec     :: [Tree] -> IO CommandOutput,
  synopsis :: String,
  explanation :: String,
  longname :: String,
  options  :: [String],
  flags    :: [String]
  }

emptyCommandInfo :: CommandInfo
emptyCommandInfo = CommandInfo {
  exec = \ts -> return (ts,[]), ----
  synopsis = "synopsis",
  explanation = "explanation",
  longname = "longname",
  options = [],
  flags = []
  }

lookCommand :: String -> Map.Map String CommandInfo -> Maybe CommandInfo
lookCommand = Map.lookup

commandHelpAll :: MultiGrammar -> [Option] -> String
commandHelpAll mgr opts = unlines
  [commandHelp (isOpt "full" opts) (co,info)
    | (co,info) <- Map.assocs (allCommands mgr opts)]

commandHelp :: Bool -> (String,CommandInfo) -> String
commandHelp full (co,info) = unlines $ [
  co ++ ", " ++ longname info,
  synopsis info] ++ if full then [
  explanation info,
  "options: " ++ unwords (options info),
  "flags: " ++ unwords (flags info)
  ] else []

allCommands :: MultiGrammar -> [Option] -> Map.Map String CommandInfo
allCommands mgr opts = Map.fromAscList [
  ("gr", emptyCommandInfo {
     longname = "generate_random",
     synopsis = "generates a list of random trees, by default one tree",
     flags = ["number"],
     exec = \_ -> do
       ts <- generateRandom mgr optCat
       return $ fromTrees $ take optNum ts
     }),
  ("h", emptyCommandInfo {
     longname = "help",
     synopsis = "get description of a command, or a the full list of commands",
     options = ["full"],
     exec = \ts -> return ([], case ts of
       [t] -> let co = (showTree t) in 
              case lookCommand co (allCommands mgr opts) of
                Just info -> commandHelp True (co,info)
                _ -> "command not found"
       _ -> commandHelpAll mgr opts)
     }),
  ("l", emptyCommandInfo {
     exec = return . fromStrings . map lin,
     flags = ["lang"]
     }),
  ("p", emptyCommandInfo {
     exec = return . fromTrees . concatMap par . toStrings,
     flags = ["cat","lang"]
     })
  ]
 where
   lin t = unlines [linearize mgr lang t    | lang <- optLangs]
   par s = concat  [parse mgr lang optCat s | lang <- optLangs]
 
   optLangs = case valIdOpts "lang" "" opts of
     "" -> languages mgr
     lang -> [lang] 
   optCat   = valIdOpts "cat" (lookAbsFlag gr (cid "startcat")) opts
   optNum   = valIntOpts "number" 1 opts

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

