module Main where

import GF.Embed.EmbedAPI
import GSyntax

main :: IO () 
main = do
  gr <- file2grammar "math.gfcm"
  loop (translate answerTree gr)

loop :: (String -> String) -> IO ()
loop trans = do 
  s <- getLine
  if s == "quit" then putStrLn "bye" else do  
    putStrLn $ trans s
    loop trans

translate :: (Tree -> Tree) -> MultiGrammar -> String -> String
translate tr gr = unlines . map transLine . lines where
  transLine s = case parseAllLang gr (startCat gr) s of
    (lg,t:_):_ -> linearize gr lg (tr t)
    _ -> "NO PARSE"

answerTree :: Tree -> Tree
answerTree = gf . answer . fg

answer :: GQuestion -> GAnswer
answer p = case p of
  GOdd x   -> test odd x
  GEven x  -> test even x
  GPrime x -> test prime x

value :: GObject -> Int
value e = case e of
  GNumber (GInt i) -> fromInteger i

test :: (Int -> Bool) -> GObject -> GAnswer
test f x = if f (value x) then GYes else GNo

prime :: Int -> Bool
prime = (< 8) ----
