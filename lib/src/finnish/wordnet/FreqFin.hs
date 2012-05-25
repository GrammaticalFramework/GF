import Data.Map
import Data.List
import Data.Char
import System

-- a script for extracting an English-Finnish translation dictionary from
-- (1) Eng-Fin wordnet links
-- (2) Fin frequency dictionary
-- (3) Fin KOTUS morpho wordlist
-- usage: runghc FreqFin.hs, which produces DictEngFin.gf (with appropriate files in place)
-- AR 23/5/2012

main = do
  lexicon <- readFile "../../abstract/Lexicon.gf" >>= return . getLexicon
  freqs   <- readFile "taajuus.txt"  >>= return . getFreqMap
  morpho  <- readFile "../DictFin.gf"   >>= return . getMorphoMap
  transV  <- readFile "Ven_fi.txt"   >>= return . getTransDict "V" freqs morpho
  transV2 <- readFile "V2en_fi.txt"  >>= return . getTransDict "V2" freqs morpho
  transA  <- readFile "Aen_fi.txt"   >>= return . getTransDict "A" freqs morpho
  transN  <- readFile "Nen_fi.txt"   >>= return . getTransDict "N" freqs morpho
  transAdv <- readFile "Adven_fi.txt"   >>= return . getTransDict "Adv" freqs morpho
  let cnc = sort $ lmap mkLin $ Data.List.filter (notLex lexicon) $ transV ++ transV2 ++ transA ++ transN ++ transAdv
  system $ "cp dictBegin dictEngFin"
  mapM_ (appendFile "dictEngFin") cnc
  system $ "cat dictEngFin dictEnd >DictEngFin.gf"

getFreqMap = fromList . lmap (getFreq . words) . lines 

lmap = Prelude.map
mlookup = Data.Map.lookup
lnull = Prelude.null


type FreqMap = Map Word (Rank,Cat)
type Rank = Int
type Cat = String
type Word = String
type Lin = String

getFreq :: [String] -> (Word,(Rank,Cat))
getFreq ws = case ws of
  n:a:r:w:c:_ -> (w,(read n,c))


-- trusted lexicon overrides all other decisions
getLexicon :: String -> MorphoMap
getLexicon = fromList . concat . lmap (getLex . words) . lines where
  getLex ws = case ws of
    fun:":":cat:_ -> [(takeWhile (/='_') fun, (cat,fun))]
    _ -> []

notLex :: MorphoMap -> (Word,(Cat,[(Word,(Rank,Lin))])) -> Bool
notLex morpho (word,(cat,_)) = case mlookup word morpho of
  Just (c,l) -> False --- | c == cat -> False --- love_V2/love_N
  _ -> True

type MorphoMap = Map Word (Cat,Lin)

getMorphoMap = fromList . concat . lmap (getMorpho . words) . lines

getMorpho ws = case ws of
  "lin":w:_:vs -> [(fst (wordcat w), (snd (wordcat w), unwords (init vs)))]
  _ -> []
 where
   wordcat w = let (wd,c) = break (=='_') w in (wd, init (tail c))

type TransDict = [(Word,(Cat,[(Word,(Rank,Lin))]))]

getTransDict :: Cat -> FreqMap -> MorphoMap -> String -> TransDict
getTransDict cat freqs morpho = lmap getOne . lmap (lmap words) . stanzas . lines
  where
    getOne ls@((w:_):_) = (w,(cat, sortTrans cat [getRank vs | _:vs <- ls]))
    getRank (v:[]) = case (mlookup v freqs, mlookup v morpho) of
      (Just (i,c), Just (k,l)) | compatCat cat c && compatCat cat k -> (v, (i, linK l))
      (Just (i,c), _)          | compatCat cat c -> (v, (i, lin ("\"" ++ v ++ "\"")))
      (_,          Just (c,l)) | compatCat cat c -> (v, (morphoRank, linK l))
      _ | all isLetter (take 1 v) && notVerb cat -> (v,(guessRank,lin ("\"" ++ v ++ "\"")))
      _ -> (v,(noRank,lin v))
    getRank vs = (unwords vs, (compRank,lin (unwords vs)))

    lin l = "mk" ++ cat ++ " " ++ l
    linK l = lin ("(lin " ++ catK ++ "K " ++ l ++ ")") 
    catK = case cat of
      "V2" -> "V"
      _ -> cat
    notVerb cat = take 1 cat /= "V" -- can produce non-verbs

sortTrans :: Cat -> [(Word,(Rank,Lin))] -> [(Word,(Rank,Lin))]
sortTrans cat = chooseBest . sortBy (\ (_,(r,_)) (_,(s,_)) -> compare r s) where
  chooseBest = take 1 ----

compatCat cat c = case cat of
  "V2" -> c == "V"
  _ -> c == cat

morphoRank, guessRank, noRank, compRank :: Int
morphoRank = 10000
guessRank = 20000
compRank = 30000
noRank = 40000

mkLin :: (Word,(Cat,[(Word,(Rank,Lin))])) -> String
mkLin (word,(cat,ws)) = unwords $ [keyw,fun,"=",lin,"; --",rank,"\n"] where
  fun = lmap clean word ++ "_" ++ cat
  (keyw,lin,rank) = case ws of
     (w,(r,l)):_ | r < guessRank -> ("lin", l,show r)
     (w,(r,_)):_ -> ("-- lin", "\"" ++ w ++ "\"",show r) -- non-wordnet or many-word
  clean c = case c of
    '-' -> '_'
    _   -> c

stanzas :: [String] -> [[String]]
stanzas ls = case ls of
  []:ls2 -> stanzas ls2
  _:_    -> let (ls1,ls2) = span (not . lnull) ls in ls1 : stanzas ls2
  []     -> []
