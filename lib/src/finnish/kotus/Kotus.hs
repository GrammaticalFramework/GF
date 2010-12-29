import qualified Data.Map as M
import qualified Data.Set as S
import System

-- build DictFin from KOTUS word list. See Makefile for how to run
-- AR 28/12/2010

main = do
  f:xx <- getArgs
  ss  <- readFile f >>= return . lines
  let dict0 = map getEntry ss
  let dictList = [(word e,e) | e <- dict0]
  let dictMap = M.fromAscList dictList
  let adjList = [(adj,adv) | (adv,e) <- dictList, 
                          cat e == catAdverb, -- kultamitali - kultamitalisti, hence need this
                          Just adj <- [lookAdj adv dictMap]]
---  mapM_ (\ (adj,adv) -> putStrLn (adv ++ " - " ++ adj)) adjList -- to see the adjectives
  let compoundList = [(whole,(end,beg)) | (whole,e) <- dictList,
                          elem (cat e) [catNoun,catAdjective],
                          Just (end,beg) <- [lookCompound (whole,e) dictMap]]
---  mapM_ (\ (x,(y,_)) -> putStrLn (unwords [x,"-", word y])) compoundList -- to see compounds
  let (adjSet,advSet) = let (adjs,advs) = unzip adjList in (S.fromList adjs,S.fromList advs)
  let compoundMap  = M.fromList compoundList
  let dictList1    = map (mkAdjAdv adjSet advSet) dictList
  let dictListComp = concatMap (mkCompound compoundMap) dictList1
  let dictList2    = filter (flip M.notMember compoundMap . fst) dictList1
  let dictList3 = case xx of 
        "-compounds":_ -> dictListComp
        "-all":_  -> dictList2 ++ dictListComp
        _ -> dictList2
  let dict3 = map snd dictList3
  mapM_ mkRules dict3




----------------------------------------------------------------
-- identify the parts of compounds

-- longest match, suffix length 3..10, prefix length at least 3, both parts exist
-- this gives 36557 compounds...
--- no recursion to multi-word compounds
lookCompound :: (String, Entry) -> M.Map String Entry -> Maybe (Entry,String)
lookCompound (w,ent) dict = 
  looks [splitAt i w | let k = length w, i <- [k-3, k-4 .. max (k-10) 3]] 
 where
  looks ws = case [(e,u) | (u,v) <- ws, 
                       Just e <- [M.lookup v dict], cat e == catNoun,
                       Just _ <- [M.lookup u dict]] of
    eu :_ -> return eu
    _ -> Nothing

-- return compounds
mkCompound compMap (w,ent) = 
  case M.lookup w compMap of
    Just (e,b) -> return (w, ent {
            word = word e,
            tn = tn e, 
            par = unwords ["compoundNK",par e,quoted b],
            isDummy = tn e == 0
            }
          )
    _ -> []


----------------------------------------------------------------
--
-- for words ending "-sti", look for corresponding adjective. If found, mark the adjective
-- as adjective, and eliminate the adverb.

mkAdjAdv adjSet advSet (w,e) = 
  if S.member w adjSet && (cat e == catNoun) 
     then (w,e{cat = catAdjective, fun = take (length (fun e) - 2) (fun e) ++ "AK"})
  else if S.member w advSet && (cat e == catAdverb) then (w,e{isDerived = True})
  else (w,e)

lookAdj adv dict = case splitAt (length adv - 3) adv of
  (adj,"sti") -> case [e | a <- adjCandidates adj, 
                       Just e <- [M.lookup a dict], cat e == catNoun] of
    e :_ -> return $ word e
    _ -> Nothing
  _ -> Nothing

adjCandidates adj = case reverse adj of
  'e':'s': w -> [reverse w ++ "nen", adj]  -- vihainen - vihaisesti
  'a':'a': 'k' : 'k' : w -> 
    [reverse w ++ "kas",  adj]  -- halukas
  'a':'a': w -> 
    [init adj ++ "s",  adj]  -- hurskas - hurskaasti, suulas - suulaasti
  v  : v': 'k' : 'k' : w | v == v' && fromEnum v == 228 -> 
    [reverse w ++ "käs",  adj] -- nenäkäs - nenäkkäästi
  v  : v': w | v == v' && fromEnum v == 228 -> 
    [init adj ++ "s",  adj] -- ylväs - ylväästi
  'e':'e': w -> let rw = reverse w in 
                [rw ++ "e", rw ++ "ut", rw ++ "yt", adj]  -- terveesti, ahdistuneesti
  'i':'i': w -> [reverse w ++ "is",  adj]  -- kaunis - kauniisti
  'e':_      -> [init adj ++ "i", adj]     -- suuri - suuresti (not: suure - suuresti)
  _ -> [adj]


-------------------------------------------------
-- produce rules

mkRules e = do
  putRule $ mkFun (fun e) (cat e)
  putRule $ mkLin (fun e) (par e) (word e)
 where
   putRule
    | isDummy e = const (return ()) -- putStrLn . ("-- " ++)
    | isDerived e = putStrLn . ("--+ " ++)
    | isPlurTant e = putStrLn . ("--? " ++)
    | otherwise = putStrLn 

mkFun fun cat = unwords ["fun",fun,":",cat,";"]
mkLin fun par w = case words par of
  f@"compoundNK":p:v:_ -> unwords ["lin",fun,"=","{s","=",f,v,"("++ p,quoted w ++")}",";"]
  _ -> unwords ["lin",fun,"=","{s","=",par,quoted w ++"}",";"]

mkId = concatMap trim where
  trim c = case fromEnum c of
    32 -> "_" -- space
    45 -> "_" -- -
    224 -> "a''" -- à
    228 -> "a'" -- ä
    246 -> "o'" -- ö
    252 -> "u'" -- ü
    x | x < 65 || (x > 90 && x < 97) || x > 122 -> "_"
    _   -> [c]

quoted s = "\"" ++ s ++ "\""

-- analyse each line in KOTUS by this

getEntry :: String -> Entry
getEntry s = emptyEntry {
  word = w,
  tn   = p,
  av   = g,
  hn   = h,
  fun  = mkId w ++ "_" ++ (if h=="0" then "" else h ++ "_") ++ c,
  cat  = c,
  par  = (if p < 52 then "d" else "c") ++ num p ++ (if g == "0" then "" else "A"),
  isSuffix = suff,
  isDummy = elem p [0,50,51,101],
  isPlurTant = last w == 't' && notElem p [5,43,47,99]
  } 
 where
  x = getTags s
  (w,suff) = let w0 = tagged "s" x in if (head w0 == '-') then (tail w0, True) else (w0,False)
  p = (read (tagged "tn" x) :: Int)
  h = tagged "hn" x
  g = tagged "av" x
  c = if p < 50 then catNoun 
      else if p < 99 then catVerb
      else catAdverb
  num p = if p < 10 then "0" ++ show p else show p


tagged :: String -> Tags -> String
tagged s x = maybe "0" id $ lookup s x

-- get values of leave tags
getTags :: String -> Tags
getTags s = case s of
  '<':rest -> case break (=='>') rest of
     (tag,_:more) -> case break (=='<') more of
       ([],_)  -> getTags more
       (v,end) -> (tag,v):getTags end
     _ -> []
  _ -> []

type Tags = [(String,String)]

data Entry = Entry {
  word :: String,
  tn   :: Int,
  av   :: String,
  hn   :: String,
  fun  :: String,
  cat  :: String,
  par  :: String,
  comp1 :: String,  -- compound word with this as inflected first part
  comp2 :: String,  -- compound word with this as last part
  isSuffix :: Bool, -- used only as suffix, e.g. "-tekoinen"
  isDummy :: Bool,  -- no inflection information, or compound, or pron, or adverb from adjective
  isPlurTant :: Bool, -- plurale tantum, e.g. "sakset"
  isDerived :: Bool   -- is derived from other words, e.g. adverb from adjective
}

emptyEntry = Entry "" 0 "" "" "" "" "" "" "" False False False False

catNoun = "NK"
catVerb = "VK"
catAdjective = "AK"
catAdverb = "AdvK"
