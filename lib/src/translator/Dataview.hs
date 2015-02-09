module Dataview where

import Data.List

dataFile :: FilePath -> IO ()
dataFile file = do
  wss <- readFile file >>= return . filter (not . null) . map commaSep . lines
  let d = view2data wss
  writeFile (file ++ ".tsv") (unlines d)

view2data :: [[String]] -> [String]
view2data ss = case ss of
  s:ss2 -> case s of
    "Dataview":f:_ ->
      let (s1,s2) = break ((=="Dataview") . head) ss2
      in [last (words f) ++ sp ++ values l | l <- s1] ++ view2data s2
    _ -> error (show s)
  _ -> []
 where
   values (w:ws) = concat $ intersperse sp $ map normalize $ case w of {'D':'a':'t':'a':'v':'i':'e':'w':_:_ -> ws  ; _ -> w:ws}
   sp = "\t"

commaSep :: String -> [String]
commaSep = lines . map (\c -> if elem c ":," then '\n' else c) . normalize

normalize = unwords . words

