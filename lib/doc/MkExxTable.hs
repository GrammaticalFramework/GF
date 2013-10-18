module MkExxTable (getApiExx, ApiExx, prApiEx, mkEx) where

import System.Cmd
import System.Environment
import qualified Data.Map as M
import Data.Char

main = do
  xx <- getArgs 
  aexx <- getApiExx xx
  return () -- putStrLn $ prApiExx aexx

getApiExx :: [FilePath] -> IO ApiExx
getApiExx xx = do
  s  <- readFile (head xx)
  let aet = getApiExxTrees $ filter validOutput $ mergeOutput $ lines s 
  aeos <- mapM readApiExxOne xx
  let aexx = mkApiExx $ ("API",aet) : aeos
--  putStrLn $ prApiExx aexx
  return aexx

readApiExxOne file = do
  s <- readFile file
  let lang = reverse (take 3 (drop 4 (reverse file))) -- api-exx-*Eng*.txt
  let api = getApiExxOne $ filter validOutput $ mergeOutput $ lines s
  putStrLn $ unlines $ prApiEx api ---
  return (lang,api)

-- map function -> language -> example
type ApiExx = M.Map String (M.Map String String)

-- map function -> example
type ApiExxOne = M.Map String String

-- get a map function -> example
getApiExxOne :: [String] -> ApiExxOne
getApiExxOne = M.fromList . pairs . map cleanUp
 where
   pairs ss = case ss of
     f:_:e:rest -> (f,e) : pairs (drop 1 (dropWhile (notElem '*') rest))
     _ -> []

-- get the map function -> tree
getApiExxTrees :: [String] -> ApiExxOne
getApiExxTrees = M.fromList . pairs . map cleanUp
 where
   pairs ss = case ss of
     f:e:_:rest -> (f,e) : pairs (drop 1 (dropWhile (notElem '*') rest))
     _ -> []

-- remove leading prompts and spaces
cleanUp = dropWhile (flip elem " >")

--- this makes txt2tags loop...
mergeOutput ls = ls
mergeOutputt ls = case ls of
  l@('>':_):ll -> let (ll1,ll2) = span ((/=">") . take 1) ll in unwords (l : map (unwords . words) ll1) : mergeOutput ll2 
  _:ll -> mergeOutput ll
  _ -> []

-- only accept lines starting with prompts (to eliminate multi-line gf uncomputed output)
validOutput = (==">") . take 1

mkApiExx :: [(String,ApiExxOne)] -> ApiExx
mkApiExx ltes = 
  M.fromList [(t, 
      M.fromList [(l,maybe "NONE" id (M.lookup t te)) | (l,te) <- ltes]) 
    | t <- M.keys firstL]
  where
    firstL = snd (head ltes)

prApiExx :: ApiExx -> String
prApiExx aexx = unlines 
  [unlines (t:prApiEx lexx) | (t,lexx) <- M.toList aexx]

prApiEx :: M.Map String String -> [String]
prApiEx apexx = case M.toList apexx of
  (a,e):lexx -> (a ++ ": ``" ++ unwords (words e) ++ "``"):
                [l ++ ": //" ++ mkEx l e ++ "//" | (l,e) <- lexx]

mkEx l = unws . bind . mkE . words where 
  unws = if elem l ["Chi","Jpn","Tha"] then concat else unwords  -- remove spaces
  mkE e = case e of
    "atomic":"term":_ -> ["*"]
    "[]":_ -> ["''"]
    "(table":es -> ["..."]
    "table":es -> ["..."]
    ('{':_):es -> ["..."]
    "pre":p@('{':_):es -> init (init (drop 2 p)) : ["..."]
---    "pre":p@('{':_):es -> init (init (drop 2 p)) : reverse (takeWhile ((/='}') . head) (reverse es))
    e0:es -> e0:mkE es
    _ -> e

bind ws = case ws of
         w : "&+" : u : ws2 -> bind ((w ++ u) : ws2)
         w : "Predef.BIND" : u : ws2 -> bind ((w ++ u) : ws2)
         "&+":ws2           -> bind ws2
         "Predef.BIND":ws2           -> bind ws2
         w : ws2            -> w : bind ws2
         w : "++" : ws2     -> w : bind ws2
         _ -> ws
