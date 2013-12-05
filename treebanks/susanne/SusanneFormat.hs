module SusanneFormat(Tag,Id,Word,Lemma,ParseTree(..),readTreebank,readTag) where

import PGF(CId)
import Data.Char

type Tag   = String
type Mods  = String
type Fn    = String
type Index = Int
type Id    = String
type Word  = String
type Lemma = String

data ParseTree
 = Phrase Tag Mods Fn Index [ParseTree]
 | Word   Id Tag Word Lemma
 | App CId [ParseTree]

data ParseTreePos
 = Root
 | At ParseTreePos ([ParseTree] -> ParseTree) [ParseTree]

instance Show ParseTree where
  show (Phrase tag mods fn idx ts)
    | tag == ""            = "["++fn++show idx++" "++unwords (map show ts)++"]"
    | fn == "" && idx == 0 = "["++tag++mods++" "++unwords (map show ts)++"]"
    | otherwise            = "["++tag++mods++":"++fn++show idx++" "++unwords (map show ts)++"]"
  show (Word _ tag w _)    = "["++tag++" "++w++"]"
  show (App f ts)           
    | null ts              = show f
    | otherwise            = "("++show f++" "++unwords (map show ts)++")"

readTreebank ls = readLines Root (map words ls)

readLines p []                        = []
readLines p ([id,_,tag,w,l,parse]:ls) =
  readParse (Word id tag w l) p parse ls

readParse w p []       ls = readLines p ls
readParse w p ('[':cs) ls =
  case readTag w cs of
    (fn,cs) -> readParse w (At p fn []) cs ls
readParse w (At p fn ts) ('.':cs) ls =
  readParse w (At p fn (w:ts)) cs ls
readParse w (At p fn ts) cs ls =
  case readTag w cs of
    (_,']':cs) -> let t = fn (reverse ts)
                  in case p of
                       Root       -> t : readLines p ls
                       At p fn ts -> readParse w (At p fn (t:ts)) cs ls
    _          -> readError w

readTag w cs@(c1:c2:_)             -- word tag on phrase level
  | isUpper c1 && isUpper c2 =
      case break (\c -> not (isLetter c || isDigit c)) cs of
        (tag,cs) -> case break (\c -> not (elem c "?*%!\"=+-&@")) cs of
                      (mods,cs) -> case cs of
                                    (':':c:cs) | isLetter c -> case break (not . isDigit) cs of
                                                                 (ds,cs) -> (Phrase tag mods [c] (if null ds then 0 else read ds),cs)
                                               | isDigit  c -> case break (not . isDigit) (c:cs) of
                                                                 (ds,cs) -> (Phrase tag mods "" (if null ds then 0 else read ds),cs)
                                    _                       -> (Phrase tag mods "" 0,cs)
readTag w (c:cs)                -- phrase tag
  | isUpper c = let tag = [c]
                in case break (\c -> not (isLetter c || isDigit c || elem c "?*%!\"=+-&@")) cs of
                     (mods,cs) -> case cs of
                                    (':':c:cs) | isLetter c -> case break (not . isDigit) cs of
                                                                 (ds,cs) -> (Phrase tag mods [c] (if null ds then 0 else read ds),cs)
                                               | isDigit  c -> case break (not . isDigit) (c:cs) of
                                                                 (ds,cs) -> (Phrase tag mods "" (if null ds then 0 else read ds),cs)
                                    _                       -> (Phrase tag mods "" 0,cs)
  | isLower c = let tag  = []
                    mods = []
                in case break (not . isDigit) cs of
                     (ds,cs) -> (Phrase tag mods [c] (if null ds then 0 else read ds),cs)
  | isDigit c = let tag  = []
                    mods = []
                in case break (not . isDigit) cs of
                     (ds,cs) -> (Phrase tag mods [] (read ds),cs)
readTag w cs = readError w

readError (Word id _ _ _) = error id
