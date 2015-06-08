{-
Merge two concrete syntaxes that have lin rules of the form

  lin f = t1 | ... | tn ; -- comment

one per line. The concrete syntaxes are marked "old" and "new", where "old" is more trusted. Merging

  lin f = t1 | ... | tm ; -- comment1
  lin f = u1 | ... | un ; -- comment2

results in

  lin f = t1 | ... | tm | {- SEP -} u1' | ... | un' ; -- comment 1 -- comment2

where u1'... are without duplicates. The comment SEP is given as an argument.

If either grammar is missing the rule for f, then only the other grammar is used. 

Comments can be added at the merging phase.

Other lines than 'lin' rules are taken from "old". The rules in the resulting grammar are sorted alphabetically.

The Preference argument is set POldOnly if you do not want to add new rules to already existing old ones:

  lin f = t1 | ... | tm ; -- comment1
  lin f = u1 | ... | un ; -- comment2

where m > 0, results in

  lin f = t1 | ... | tm ; -- comment1

Usage:

  mergeDict <OldFile> <NewFile> (POld|PNew|PMerge) (Maybe separator) <TargetFile>

Example:

  mergeDict "DictionaryChi.gf" "../chinese/hsk/csv/hsku.gf" True (Just "HSK") "tmp/DictionaryChi.gf"
-}



import Data.List

data Preference = PNew | POld | PMerge deriving Eq

mergeDict :: FilePath -> FilePath -> Preference -> Maybe String -> FilePath -> IO ()
mergeDict old new pref comm file = do
  olds1 <- readFile old >>= return . lines
  news1 <- readFile new >>= return . lines
  let (preamble,olds2) = break ((== ["lin"]) . take 1 . words) olds1
  let lastopers = [l | l@('o':'p':'e':'r':_) <- olds2] 
  let olds = [mkRule 0 (w:ws) | w:ws <- map words olds2, w == "lin"]
  let news = [mkRule 1 (w:ws) | w:ws <- map words news1, w == "lin"]
  let lins = sort $ olds ++ news
  let linss = groupBy (\x y -> (fun x) == (fun y)) lins
  let lins2 = map (mergeRule pref comm) linss
  writeFile file $ unlines preamble
  appendFile file $ unlines $ map prRule lins2
  appendFile file $ unlines $ lastopers
  appendFile file "}"

data Rule = R {fun :: String, priority :: Int, lins :: [[String]], comment :: [String]} -- fun, variants, comment
  deriving (Eq,Ord,Show)

mkRule :: Int -> [String] -> Rule
mkRule i ws = case ws of
  "lin":f:"=":ww -> rule f i (getLin ww)
  _ -> error $ "not a valid rule: " ++ unwords ws
 where
   rule f i (l,c) = R f i l c
   getLin ws = case break isComment ws of
     (ls,cc) -> (getVariants (initSC ls), cc)
   getVariants ws = case break (=="|") ws of
      (e,vs) | isEmpty e -> getVariants vs
      (v,_:vs) -> v : getVariants vs
      ([],_)   -> []
      (v,_)    -> [v]
   isEmpty v = elem v [["variants{}"],["variants","{}"],["variants{};"],["variants","{};"]]
   isComment = (=="--") . take 2

initSC :: [String] -> [String]
initSC ss = 
  let lss = last ss in 
  case lss of
    ";" -> init ss 
    _ -> if last lss == ';' then init ss ++ [init lss] else ss


mergeRule :: Preference -> Maybe String -> [Rule] -> Rule
mergeRule pref mco rs = case rs of
  [r] -> r
  [old,new] 
    | pref == POld && not (null (lins old)) -> old    -- old has something: just keep it
    | pref == PNew && not (null (lins new)) -> new    -- new has something: just take it
    | null (lins old) && null (lins new) -> old         -- both are empty: just keep old
    | null (lins old) -> new                            -- old is empty: just keep new
    | otherwise -> case filter (flip notElem (lins old)) (lins new) of
       l:ls -> case mco of 
         Just co -> R (fun old) 0 (lins old ++ (("{-"++co++"-}"):l):ls) (comment new ++ comment old)
         _       -> R (fun old) 0 (lins old ++ l:ls) (comment new ++ comment old)
       _ -> old
        
  _ -> error $ "cannot handle more than two rule sources: " ++ show rs

prRule :: Rule -> String
prRule ru = unwords $ "lin" : fun ru : "=" : variants ru ++ [";"] ++ comment ru

variants :: Rule -> [String]
variants ru = case lins ru of
  [] -> ["variants","{}"] 
  ls -> intersperse "|" (map unwords (filter (not . null) ls))

