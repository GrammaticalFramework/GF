module SusanneFormat(Tag,Id,Word,Lemma,ParseTree(..),readTreebank) where

import Data.Char

type Tag   = String
type Id    = String
type Word  = String
type Lemma = String

data ParseTree
 = Phrase Tag [ParseTree]
 | Word   Id Tag Word Lemma

data ParseTreePos
 = Root
 | At ParseTreePos Tag [ParseTree]

instance Show ParseTree where
  show (Phrase tag ts)  = "["++tag++" "++unwords (map show ts)++"]"
  show (Word _ tag w _) = "["++tag++" "++w++"]"

readTreebank ls = readLines Root (map words ls)

readLines p []                        = []
readLines p ([id,_,tag,w,l,parse]:ls) =
  readParse p (Word id tag w l) parse ls

readParse p    w []       ls = readLines p ls
readParse p    w ('[':cs) ls =
  case break (not . isTagChar) cs of
    (tag,cs) -> readParse (At p tag []) w cs ls
readParse (At p tag ts) w ('.':cs) ls =
  readParse (At p tag (w:ts)) w cs ls
readParse (At p tag ts) w cs ls =
  case break (not . isTagChar) cs of
    (tag,']':cs) -> let t = Phrase tag (reverse ts)
                    in case p of
                         Root        -> t : readLines p ls
                         At p tag ts -> readParse (At p tag (t:ts)) w cs ls
    _            -> error cs

isTagChar c =
  isLetter c || isDigit c || elem c ":&+-%@=?\"*!"
