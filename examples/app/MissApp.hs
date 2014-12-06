module MissApp where

import qualified Data.Set as S
import qualified Data.Map as M
import Data.Char

-- prerequisite: pg -missing | wf -file=missing-app.txt

missFile = "missing-app.txt"

allLangs = words "AppBul AppCat AppChi AppDut AppEng AppFin AppFre AppGer AppHin AppIta AppSpa AppSwe"

type Lang = String
type Fun = String

type MissMap = M.Map Lang (S.Set Fun)

getMissMap :: FilePath -> IO MissMap
getMissMap file = do
  ms <- readFile file >>= return . map words . lines
  return $ M.fromList [(lang,S.fromList ws) | lang:":":ws <- ms]

ifMiss :: MissMap -> Lang -> Fun -> Bool
ifMiss mm lang fun = case M.lookup lang mm of
  Just ws -> S.member fun ws
  _ -> error $ "language not found: " ++ lang

allMissLangs :: MissMap -> Fun -> [Lang]
allMissLangs mm fun = [l | l <- allLangs, ifMiss mm l fun]

allMissFuns :: MissMap -> Lang -> [Fun]
allMissFuns mm lang = maybe [] S.toList $ M.lookup lang mm

isSyntaxFun :: Fun -> Bool
isSyntaxFun (f:un) = isUpper f && any isUpper un  -- the latter to exclude Phrasebook 

allMissingSyntaxFuns :: MissMap -> [(Lang,[Fun])]
allMissingSyntaxFuns mm = [(l,takeWhile isSyntaxFun $ allMissFuns mm l) | l <- allLangs]  -- takeWhile works on the sorted list

allMissingSuchFuns :: MissMap -> (Fun -> Bool) -> [(Lang,[Fun])]
allMissingSuchFuns mm f = [(l,filter f $ allMissFuns mm l) | l <- allLangs]

allMissingThoseFuns :: MissMap -> [Fun] -> [(Lang,[Fun])]
allMissingThoseFuns mm fs = let s = S.fromList fs in allMissingSuchFuns mm (flip S.member s)

parts :: Fun -> [String]
parts f = words (map (\c -> if c =='_' then ' ' else c) f)

catOf :: Fun -> String
catOf = last . parts

prepareMissing :: MissMap -> Lang -> String -> IO ()
prepareMissing mm lang cat = putStrLn $ unlines 
  [ "lin " ++ p ++ " = mk" ++ cat ++ " \"\" ;"| (l,ps) <- allMissingSuchFuns mm (\f -> catOf f == cat), l == lang, p <- ps]
