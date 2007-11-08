module GF.Command.Commands (
  allCommands,
  lookCommand,
  exec,
  isOpt,
  options,
  flags,
  CommandInfo,
  CommandOutput
  ) where

import GF.Command.AbsGFShell hiding (Tree)
import GF.Command.PPrTree
import GF.Command.ParGFShell
import GF.GFCC.ShowLinearize
import GF.GFCC.API
import GF.GFCC.Macros
import GF.GFCC.AbsGFCC ----

import GF.Command.ErrM ----

import qualified Data.Map as Map

type CommandOutput = ([Tree],String) ---- errors, etc

data CommandInfo = CommandInfo {
  exec     :: [Option] -> [Tree] -> IO CommandOutput,
  synopsis :: String,
  explanation :: String,
  longname :: String,
  options  :: [String],
  flags    :: [String]
  }

emptyCommandInfo :: CommandInfo
emptyCommandInfo = CommandInfo {
  exec = \_ ts -> return (ts,[]), ----
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
    | (co,info) <- Map.assocs (allCommands mgr)]

commandHelp :: Bool -> (String,CommandInfo) -> String
commandHelp full (co,info) = unlines $ [
  co ++ ", " ++ longname info,
  synopsis info] ++ if full then [
  explanation info,
  "options: " ++ unwords (options info),
  "flags: " ++ unwords (flags info)
  ] else []

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


allCommands :: MultiGrammar -> Map.Map String CommandInfo
allCommands mgr = Map.fromAscList [
  ("gr", emptyCommandInfo {
     longname = "generate_random",
     synopsis = "generates a list of random trees, by default one tree",
     flags = ["cat","number"],
     exec = \opts _ -> do
       ts <- generateRandom mgr (optCat opts)
       return $ fromTrees $ take (optNum opts) ts
     }),
  ("h", emptyCommandInfo {
     longname = "help",
     synopsis = "get description of a command, or a the full list of commands",
     options = ["full"],
     exec = \opts ts -> return ([], case ts of
       [t] -> let co = (showTree t) in 
              case lookCommand co (allCommands mgr) of   ---- new map ??!!
                Just info -> commandHelp True (co,info)
                _ -> "command not found"
       _ -> commandHelpAll mgr opts)
     }),
  ("l", emptyCommandInfo {
     exec = \opts -> return . fromStrings . map (optLin opts),
     options = ["record","table","term"],
     flags = ["lang"]
     }),
  ("p", emptyCommandInfo {
     exec = \opts -> return . fromTrees . concatMap (par opts). toStrings,
     flags = ["cat","lang"]
     })
  ]
 where
   lin opts t = unlines [linearize mgr lang t    | lang <- optLangs opts]
   par opts s = concat  [parse mgr lang (optCat opts) s | lang <- optLangs opts]
 
   optLin opts t = unlines [linea lang t | lang <- optLangs opts] where
     linea lang = case opts of
       _ | isOpt "table"  opts -> tableLinearize gr (cid lang)
       _ | isOpt "term"   opts -> termLinearize gr (cid lang)
       _ | isOpt "record" opts -> recordLinearize gr (cid lang)
       _  -> linearize mgr lang


   optLangs opts = case valIdOpts "lang" "" opts of
     "" -> languages mgr
     lang -> [lang] 
   optCat opts = valIdOpts "cat" (lookAbsFlag gr (cid "startcat")) opts
   optNum opts = valIntOpts "number" 1 opts

   gr       = gfcc mgr

   fromTrees ts = (ts,unlines (map showTree ts))
   fromStrings ss = (map tStr ss, unlines ss)
   toStrings ts = [s | DTr [] (AS s) [] <- ts] 
   tStr s = DTr [] (AS s) []

