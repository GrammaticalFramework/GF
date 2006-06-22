module Tab where

import Data.Map

type Tree = String ----
type Bracket = [String] ---

type Tab = Map [String] [Tree]


-- build a Tab from a unilingual treebank file (not XML)

test file = do
  tab <- tb2tab file
  tst tab
 where
  tst tab = do
    s  <- getLine 
--    let ts = analyse tab $ words s
    let ts = Prelude.map unwords $ analyseParts tab $ words s
    mapM_ putStrLn ts
    tst tab

-- analyse whole inputs
analyse :: Tab -> [String] -> [Tree]
analyse tab s = maybe [] id $ Data.Map.lookup s tab

-- analyse parts of inputs
analyseParts :: Tab -> [String] -> [Bracket]
analyseParts tab = anap where
  anap ws = case ws of
    w:vs -> case results ws of
      []         -> [w:res | res <- anap vs]
      (ts,ws2):_ -> [t:res | t <- ts, res <- anap ws2]
    _ -> [[]]
  results ws = Prelude.filter (not . Prelude.null . fst) 
    [(ana ws1,ws2) | i <- [0..length ws], let (ws1,ws2) = splitAt i ws]
  ana = analyse tab


tb2tab :: FilePath -> IO Tab
tb2tab file = do
  ss <- readFile file >>= return . lines
  let ps = pairs ss
  return $ fromListWith (++) ps

pairs :: [String] -> [([String],[String])]
pairs xs = case xs of
  x:y:ys -> (words y,[x]) : pairs ys
  _ -> []



{-

ceci - that_NP 

-}
