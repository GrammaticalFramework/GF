module Main where

import System
import Char

-- generate Finnish lexicon implementations with 1 or more 
-- characteristic arguments
-- usage: runghc MkLex.hs 3 cat name

main = do
  i:cat:tgt:_ <- getArgs
  let src = "correct-" ++ tgt ++ ".txt"
  ss <- readFile src >>= return . filter (not . (all isSpace)) . lines
  initiate tgt cat i
  mapM_ (mkLex cat (read i) . uncurry (++)) (zip nums ss)
  putStrLn "}"

initiate tgt cat i = mapM_ putStrLn [
  "--# -path=.:alltenses",
  "",
  header i,
  ""
  ]
 where
  header i = case i of
    "0" -> unlines [
      "abstract " ++ tgt ++ "Abs = Cat ** {",
      "fun testN : N -> Utt ;",
      "fun testV : V -> Utt ;"
      ]
    _ -> unlines [
      "concrete " ++ tgt ++ i ++ 
      " of " ++ tgt ++ 
      "Abs = CatFin ** open Nominal, Verbal, ResFin, Prelude in {",
      "",
      "lin testN = showN ;",
      "lin testV = showV ;"
     ]

nums = map prt [10001 ..] where
----  prt i = (if i < 10 then "0" else "") ++ show i ++ ". "
  prt i = show i ++ ". "

-- W is the flag for mixed-class word lists
mkLex "W" 0 line = case words line of
  num:cat:sana:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "fun " ++ nimi ++ "_" ++ cat ++ " : " ++ cat ++ " ;"
  _ -> return ()

mkLex "W" 1 line = case words line of
  num:cat:sanat@(sana:_) -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "lin " ++ nimi ++ 
               "_" ++ cat ++ " = mk" ++ cat ++ " " ++ 
               unwords (map prQuoted sanat) ++" ;"
  _ -> return ()

mkLex cat 0 line = case words line of
  num:sana:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "fun " ++ nimi ++ "_" ++ cat ++ " : " ++ cat ++ " ;"
  _ -> return ()

mkLex cat 1 line = case words line of
  num:sana:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "lin " ++ nimi ++ 
               "_" ++ cat ++ " = mk" ++ cat ++ " \"" ++ sana ++ "\" ;"
  _ -> return ()

mkLex "V" _ line = case words line of
  num:sana:_:_:_:_:_:_:sanan:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "lin " ++ nimi ++ 
      "_V = mkV \"" ++ sana ++ "\" \"" ++ sanan ++ "\" ;"
  _ -> return ()

mkLex "N" 2 line = case words line of
  num:sana:sanan:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "lin " ++ nimi ++ 
      "_N = mkN \"" ++ sana ++ "\" \"" ++ sanan ++ "\" ;"
  _ -> return ()

mkLex "N" 3 line = case words line of
----  num:sana:sanan:sanoja:_ -> do
  num:sana:sanan:_:_:_:_:sanoja:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "lin " ++ nimi ++ 
      "_N = mkN \"" ++ sana ++ "\" \"" ++ sanan ++ "\" \"" ++ sanoja ++ "\" ;"
  _ -> return ()

mkLex "N" 4 line = case words line of
  num:sana:sanan:sanaa:_:_:_:sanoja:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "lin " ++ nimi ++ 
      "_N = mkN \"" ++ sana ++ "\" \"" ++ sanan ++ 
                 "\" \"" ++ sanoja ++ "\" \"" ++ sanaa ++ "\" ;"
  _ -> return ()

-- to initiate from a noun list that has compounds

mkLex "N" 11 line = case words line of
  _:"--":_ -> return ()
  num:sana0:_ -> do
    let sana = uncompound sana0
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "fun " ++ nimi ++ "_N : N ;"
    putStrLn $ "lin " ++ nimi ++ "_N = mkN \"" ++ sana ++ "\" ;"
  _ -> return ()

prQuoted s = concat ["\"",s,"\""]

-- from sora+tie to tie

uncompound = reverse . takeWhile (/= '+') . reverse
