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

import GF.Command.Abstract
import GF.Command.Parse
import PGF
import PGF.CId
import PGF.ShowLinearize
import PGF.Macros
import PGF.Data ----
import qualified PGF.Parsing.FCFG.Incremental as Incremental
import GF.Compile.Export
import GF.Infra.UseIO
import GF.Data.ErrM ----
import GF.System.Readline

import Data.Maybe
import qualified Data.Map as Map
import System.CPUTime

type CommandOutput = ([Exp],String) ---- errors, etc

data CommandInfo = CommandInfo {
  exec     :: [Option] -> [Exp] -> IO CommandOutput,
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

commandHelpAll :: PGF -> [Option] -> String
commandHelpAll pgf opts = unlines
  [commandHelp (isOpt "full" opts) (co,info)
    | (co,info) <- Map.assocs (allCommands pgf)]

commandHelp :: Bool -> (String,CommandInfo) -> String
commandHelp full (co,info) = unlines $ [
  co ++ ", " ++ longname info,
  synopsis info] ++ if full then [
  explanation info,
  "options: " ++ unwords (options info),
  "flags: " ++ unwords (flags info)
  ] else []

valIdOpts :: String -> String -> [Option] -> String
valIdOpts flag def opts = case valOpts flag (VId def) opts of
  VId v -> v
  _     -> def

valIntOpts :: String -> Integer -> [Option] -> Int
valIntOpts flag def opts = fromInteger $ case valOpts flag (VInt def) opts of
  VInt v -> v
  _      -> def

valOpts :: String -> Value -> [Option] -> Value
valOpts flag def opts = case lookup flag flags of
  Just v -> v
  _ -> def
 where
   flags = [(f,v) | OFlag f v <- opts]

isOpt :: String -> [Option] -> Bool
isOpt o opts = elem o [x | OOpt x <- opts]

-- this list must be kept sorted by the command name!
allCommands :: PGF -> Map.Map String CommandInfo
allCommands pgf = Map.fromAscList [
  ("gr", emptyCommandInfo {
     longname = "generate_random",
     synopsis = "generates a list of random trees, by default one tree",
     flags = ["cat","number"],
     exec = \opts _ -> do
       ts <- generateRandom pgf (optCat opts)
       return $ fromTrees $ take (optNum opts) ts
     }),
  ("gt", emptyCommandInfo {
     longname = "generate_trees",
     synopsis = "generates a list of trees, by default exhaustive",
     flags = ["cat","depth","number"],
     exec = \opts _ -> do
       let dp = return $ valIntOpts "depth" 4 opts
       let ts = generateAllDepth pgf (optCat opts) dp
       return $ fromTrees $ take (optNumInf opts) ts
     }),
  ("h", emptyCommandInfo {
     longname = "help",
     synopsis = "get description of a command, or a the full list of commands",
     options = ["full"],
     exec = \opts ts -> return ([], case ts of
       [t] -> let co = showExp t in 
              case lookCommand co (allCommands pgf) of   ---- new map ??!!
                Just info -> commandHelp True (co,info)
                _ -> "command not found"
       _ -> commandHelpAll pgf opts)
     }),
  ("l", emptyCommandInfo {
     exec = \opts -> return . fromStrings . map (optLin opts),
     options = ["all","record","table","term"],
     flags = ["lang"]
     }),
  ("p", emptyCommandInfo {
     exec = \opts -> return . fromTrees . concatMap (par opts). toStrings,
     flags = ["cat","lang"]
     }),
  ("pg", emptyCommandInfo {
     exec  = \opts _ -> return $ fromString $ prGrammar opts,
     flags = ["cat","lang","printer"]
     }),
  ("wc", emptyCommandInfo {
     exec  = \opts _ -> wordCompletion opts >> return ([],[]),
     flags = ["cat","lang"]
     })
  ]
 where
   lin opts t = unlines [linearize pgf lang t    | lang <- optLangs opts]
   par opts s = concat  [parse pgf lang (optCat opts) s | lang <- optLangs opts]
 
   optLin opts t = unlines [linea lang t | lang <- optLangs opts] where
     linea lang = case opts of
       _ | isOpt "all"    opts -> allLinearize pgf (mkCId lang)
       _ | isOpt "table"  opts -> tableLinearize pgf (mkCId lang)
       _ | isOpt "term"   opts -> termLinearize pgf (mkCId lang)
       _ | isOpt "record" opts -> recordLinearize pgf (mkCId lang)
       _  -> linearize pgf lang


   optLangs opts = case valIdOpts "lang" "" opts of
     "" -> languages pgf
     lang -> [lang] 
   optCat opts = valIdOpts "cat" (lookStartCat pgf) opts
   optNum opts = valIntOpts "number" 1 opts
   optNumInf opts = valIntOpts "number" 1000000000 opts ---- 10^9

   fromTrees ts = (ts,unlines (map showExp ts))
   fromStrings ss = (map EStr ss, unlines ss)
   fromString  s  = ([EStr s], s)
   toStrings ts = [s | EStr s <- ts] 

   prGrammar opts = case valIdOpts "printer" "" opts of
     "cats" -> unwords $ categories pgf
     v -> prPGF (read v) pgf (prCId (absname pgf))

   wordCompletion opts = do
     let lang = head (optLangs opts)
         cat  = optCat opts
         pinfo = fromMaybe (error ("Unknown language: " ++ lang)) (lookParser pgf (mkCId lang))
         state0 = Incremental.initState pinfo (mkCId cat)
     setCompletionFunction (Just (myCompletion pinfo state0))
     s <- fetchCommand ">> "
     if s == "q"
       then return ()
       else do cpu1 <- getCPUTime
               exps <- return $! Incremental.parse pinfo (mkCId cat) (words s)
               mapM_ (putStrLn . showExp) exps
               cpu2 <- getCPUTime
	       putStrLn (show ((cpu2 - cpu1) `div` 1000000000) ++ " msec")
               wordCompletion opts
     where
       myCompletion pinfo state0 line prefix p = do
         let ws = words (take (p-length prefix) line)
             state = foldl Incremental.nextState state0 ws
             compls = Incremental.getCompletions state prefix
         return (Map.keys compls)
