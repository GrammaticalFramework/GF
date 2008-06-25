module Main where

import System

-- compare lines word-by-word, returning difference pairs with their positions

main = do
  x:y:_ <- getArgs
  old <- readFile x >>= return . lines
  new <- readFile y >>= return . lines
  mapM_ comp (zip old new)

comp (ws1,ws2) = do
  let diffs = [form ++ ":" ++ w1 ++ "-" ++ w2 | 
        (form,(w1,w2)) <- zip forms (zip (words ws1) (words ws2)), diff w2 w1]
  putStr $ unwords diffs
  if null diffs then return () else putStrLn ""

forms = map show [1..]

diff w ws = notElem w (chop ws) where
  chop cs = case span (/='/') cs of
    ([],_)  -> []
    (w1,ww) -> w1:chop (drop 1 ww)

