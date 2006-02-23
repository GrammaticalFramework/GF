-- to make certain verbs transitive

mkV2 file = do
  ls <- readFile file >>= return . lines
  mapM_ (putStrLn . mkOne) ls

mkOne = mkOneV2

--mkOne = mkOneQuote

mkOneQuote li = if elem '"' li then "-- " ++ li else li

mkOneV2 li = case words li of
  v : e : ws | elem v v2s -> 
    "    " ++ unwords (v : e : "dirV2" : ["(" ++ unwords (init ws) ++ ") ;"])
  _ -> li



-- grep dirV2 SwadeshEng.gf >v2s
-- readFile "v2s" >>= print . map (head . words) . lines

v2s = ["bite_V","breathe_V","count_V","cut_V","drink_V","eat_V","fear_V","fight_V","hear_V","hit_V","hold_V","hunt_V","kill_V","know_V","pull_V","push_V","rub_V","scratch_V","see_V","smell_V","split_V","squeeze_V","stab_V","suck_V","throw_V","tie_V","wash_V","wipe_V"]

