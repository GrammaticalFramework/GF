-- data structures for bilingual Eng-Fin wordnet
-- so far: processing Princeton wordnet

import Data.List
import Data.Char
import qualified Data.Map as M

main = do
  mkPOS "data.adj" "A"
  mkPOS "data.adv" "Adv"
  mkPOS "data.noun" "N"
  mkPOS "data.verb" "V"

mkPOS file cat = do
  s <- readFile file
  mapM_ (putStrLn . prEntry . mkEngEntry cat) (dataLines s)

dataLines = filter ((/= " ") . take 1) . lines

type Wordnet = M.Map Ident Entry

data Entry = E {
  ident   :: Ident,
  cat     :: Ident,
  english :: [Lex],
  finnish :: [Lex]
  }

entry :: Entry
entry = E {ident = "000", cat = "XXX", english = [], finnish = []}

prEntry e = unwords $ [ident e, cat e, ";"] ++ intersperse "|" (map prLex (english e)) ++ [";"] ++ intersperse "|" (map prLex (finnish e))

type Ident = String

type Lex = ([String],Ident)  -- parts of multiword, paradigm name

prLex (ws,f) = unwords (f:[unwords (map quote ws)])

quote s = "\"" ++ s ++ "\""

-- English format, in data.adj
-- 00004615 00 s 02 cut 0 shortened 0 001 & 00004413 a 0000 | with parts removed; "the drastically cut film" 

mkEngEntry :: Ident -> String -> Entry
mkEngEntry c line = case words line of
  i:_:_:_:ws -> entry {ident = i, cat = c, english = mkLin (usable ws)}
 where
  mkLin ws = [(words (unUnderscore w),"mkW" ++ c) | w <- ws]
  usable = takeWhile (isAlpha . head) . everyOther

everyOther :: [a] -> [a]
everyOther xs = case xs of
  x:_:ys -> x : everyOther ys
  _ -> []

unUnderscore :: String -> String
unUnderscore = map (\c -> if c == '_' then ' ' else c)