module PennFormat(parseTreebank, showTree) where

import Text.PrettyPrint
import Data.Tree
import Data.Char

parseTreebank :: String -> [Tree String]
parseTreebank []     = []
parseTreebank (c:cs)
  | isSpace c        = parseTreebank cs
  | c == '('         = let (ts,cs1) = parseTrees cs
                       in ts ++ parseTreebank cs1

parseTrees []     = ([],[])
parseTrees (c:cs)
  | isSpace c     = parseTrees cs
  | c == ')'      = ([],cs)
  | c == '('      = let (w,       cs1) = parseWord  cs
                        (children,cs2) = parseTrees cs1
                        (rest,    cs3) = parseTrees cs2
                    in (Node (normalize w) children : rest,cs3)
  | otherwise     = let (w,       cs1) = parseWord  (c:cs)
                        (rest,    cs2) = parseTrees cs1
                    in (Node w [] : rest,cs2)

normalize tag =
  let (tag0,mod) = break (=='-') tag
  in if null tag0
       then tag
       else tag0

parseWord = break (\c -> isSpace c || c == '(' || c == ')')

printTree (Node w [])       = text w
printTree (Node l children) = parens (text l <+> hsep (map printTree children))

showTree :: Tree String -> String
showTree = render . printTree
