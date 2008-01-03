module Main where

import System
import Char

-- generate Finnish lexicon implementations with 1 or more 
-- characteristic arguments
-- usage: runghc MkLex.hs 3 name

main = do
  i:tgt:_ <- getArgs
  let src = "correct-" ++ tgt ++ ".txt"
  ss <- readFile src >>= return . filter (not . (all isSpace)) . lines
  initiate tgt i
  mapM_ (mkLex (read i) . uncurry (++)) (zip nums ss)
  putStrLn "}"

initiate tgt i = mapM_ putStrLn [
  "--# -path=.:alltenses",
  "",
  header i,
  ""
  ]
 where
  header i = case i of
    "0" -> "abstract " ++ tgt ++ "Abs = Cat ** {\n\nfun testN : N -> Utt ;\n"
    _ -> unlines [
      "concrete " ++ tgt ++ i ++ 
      " of " ++ tgt ++ "Abs = CatFin ** open Nominal, ResFin, Prelude in {",
      "",
      "lin testN talo = let t = talo.s in ss (",
      "  t ! NCase Sg Nom ++",
      "  t ! NCase Sg Gen ++",
      "  t ! NCase Sg Part ++", 
      "  t ! NCase Sg Ess ++",
      "  t ! NCase Sg Illat ++",
      "  t ! NCase Pl Gen ++",
      "  t ! NCase Pl Part ++",
      "  t ! NCase Pl Ess ++",
      "  t ! NCase Pl Iness ++",
      "  t ! NCase Pl Illat",
      "  ) ;"
     ]

nums = map prt [1 ..] where
  prt i = (if i < 10 then "0" else "") ++ show i ++ ". "

mkLex 0 line = case words line of
  num:sana:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "fun " ++ nimi ++ "_N : N ;"
  _ -> return ()

mkLex 1 line = case words line of
  num:sana:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "lin " ++ nimi ++ "_N = mk1N \"" ++ sana ++ "\" ;"
  _ -> return ()

mkLex 2 line = case words line of
  num:sana:sanan:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "lin " ++ nimi ++ 
      "_N = mk2N \"" ++ sana ++ "\" \"" ++ sanan ++ "\" ;"
  _ -> return ()

mkLex 3 line = case words line of
  num:sana:sanan:_:_:_:_:sanoja:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "lin " ++ nimi ++ 
      "_N = mk3N \"" ++ sana ++ "\" \"" ++ sanan ++ "\" \"" ++ sanoja ++ "\" ;"
  _ -> return ()

mkLex 4 line = case words line of
  num:sana:sanan:sanaa:_:_:_:sanoja:_ -> do
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "lin " ++ nimi ++ 
      "_N = mk4N \"" ++ sana ++ "\" \"" ++ sanan ++ 
                 "\" \"" ++ sanaa ++ "\" \"" ++ sanoja ++ "\" ;"
  _ -> return ()


-- to initiate from a noun list

mkLex 11 line = case words line of
  _:"--":_ -> return ()
  num:sana0:_ -> do
    let sana = uncompound sana0
    let nimi = "n" ++ init num ++ "_" ++ sana 
    putStrLn $ "fun " ++ nimi ++ "_N : N ;"
    putStrLn $ "lin " ++ nimi ++ "_N = mk1N \"" ++ sana ++ "\" ;"
  _ -> return ()

-- from sora+tie to tie

uncompound = reverse . takeWhile (/= '+') . reverse
