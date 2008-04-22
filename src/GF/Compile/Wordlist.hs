----------------------------------------------------------------------
-- |
-- Module      : Wordlist
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 
-- > CVS $Author: 
-- > CVS $Revision: 
--
-- Compile a gfwl file (multilingual word list) to an abstract + concretes
-----------------------------------------------------------------------------

module GF.Compile.Wordlist (mkWordlist) where

import GF.Data.Operations
import GF.Infra.UseIO
import Data.List
import Data.Char
import System.FilePath

-- read File.gfwl, write File.gf (abstract) and a set of concretes
-- return the names of the concretes

mkWordlist :: FilePath -> IO [FilePath]
mkWordlist file = do
  s <- readFileIf file
  let abs = dropExtension file
  let (cnchs,wlist) = pWordlist abs $ filter notComment $ lines s
  let (gr,grs) = mkGrammars abs cnchs wlist
  let cncfs = [cnc ++ ".gf" | (cnc,_) <- cnchs]
  mapM_ (uncurry writeFile) $ (abs ++ ".gf",gr) : zip cncfs grs
  putStrLn $ "wrote " ++ unwords ((abs ++ ".gf") : cncfs)
  return cncfs

{-
-- syntax of files, e.g.

  # Svenska - Franska - Finska  -- names of concretes
 
  berg  - montagne - vuori      -- word entry

-- this creates:

  cat S ; 
  fun berg_S : S ; 
  lin berg_S = {s = ["berg"]} ;
  lin berg_S = {s = ["montagne"]} ;
  lin berg_S = {s = ["vuori"]} ;

-- support for different categories to be elaborated. The syntax it

  Verb . klättra - grimper / escalader - kiivetä / kiipeillä

-- notice that a word can have several alternative (separator /)
-- and that an alternative can consist of several words
-}

type CncHeader = (String,String) -- module name, module header

type Wordlist = [(String, [[String]])] -- cat, variants for each cnc


pWordlist :: String -> [String] -> ([CncHeader],Wordlist)
pWordlist abs ls = (headers,rules) where
  (hs,rs) = span ((=="#") . take 1) ls
  headers = map mkHeader $ chunks "-" $ filter (/="#") $ words $ concat hs
  rules   = map (mkRule   . words) rs

  mkHeader ws = case ws of
    w:ws2 -> (w, unwords ("concrete":w:"of":abs:"=":ws2))
  mkRule ws = case ws of
    cat:".":vs -> (cat, mkWords vs)
    _          -> ("S", mkWords ws)
  mkWords = map (map unwords . chunks "/") . chunks "-"


mkGrammars :: String -> [CncHeader] -> Wordlist -> (String,[String])
mkGrammars ab hs wl = (abs,cncs) where
  abs = unlines $ map unwords $
    ["abstract",ab,"=","{"]:
    cats ++
    funs ++
    [["}"]]

  cncs = [unlines $ (h ++ " {") : map lin rs ++ ["}"] | ((_,h),rs) <- zip hs rss]

  cats = [["cat",c,";"] | c <- nub $ map fst wl]
  funs = [["fun", f , ":", c,";"] | (f,c,_) <- wlf]

  wlf = [(ident f c, c, ws) | (c,ws@(f:_)) <- wl]

  rss = [[(f, wss !! i) | (f,_,wss) <- wlf] | i <- [0..length hs - 1]]

  lin (f,ss) = unwords ["lin", f, "=", "{s", "=", val ss, "}", ";"]

  val ss = case ss of
    [w] -> quote w
    _   -> "variants {" ++ unwords (intersperse ";" (map quote ss)) ++ "}"

  quote w = "[" ++ prQuotedString w ++ "]" 

  ident f c = concat $ intersperse "_" $ words (head f) ++ [c]


notComment s = not (all isSpace s) && take 2 s /= "--"

