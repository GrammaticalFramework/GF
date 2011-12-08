import qualified Data.Map as Map
import Data.Char

gold = "CC_eng_tha.txt"
tested = "api-examples-Tha.txt"

main = do
  s <- readFile gold
  let corrects = Map.fromList $ exx 1 5 2 (lines s)
--  mapM_ putStrLn $ concat [[t,s] | (t,s) <- Map.toList corrects]
  t <- readFile tested
  mapM_ (doTest corrects) (exx 18 22 1 (map (drop 4) (lines t)))

exx x y z ss = [(ss!!k,ss!!(k+z)) | k <- [x,y .. length ss - 2]]

doTest corrects (t,s) = case Map.lookup t corrects of
  Just c -> if unspace s == uncomment c then return () else mapM_ putStrLn [t,unspace s,c]
  _ -> return ()

unspace = filter (not . isSpace)
uncomment = unspace . takeWhile (/= '-')

