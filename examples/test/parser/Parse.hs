import PGF
import Data.Maybe
import System.IO
import System.CPUTime
import Control.Monad

main = do
  pgf <- readPGF "grammar.pgf"
  ts <- fmap (map (fromJust . readTree) . lines) $ readFile "trees.txt"
  ss <- foldM (doTest pgf (mkCId "LangGer") (fromJust (readType "Phr"))) [] ts
  mapM_ (hPutStrLn stderr . show) [(fromIntegral s / fromIntegral n)/1000000000 | (s,n) <- ss]
  putStrLn "Done."
  
doTest pgf lang cat ss t = do
  let s = linearize pgf lang t
  putStr (s ++ " ... ")
  let st = initState pgf lang cat
  t1 <- getCPUTime
  res <- doParse st t1 [] (words s)
  case res of
    Just (st,ts) -> putStrLn "Ok"   >> return (accum ts ss)
    Nothing      -> putStrLn "Fail" >> return ss


doParse st t1 ts []       = return (Just (st,reverse ts))
doParse st t1 ts (tk:tks) = do
  case nextState st tk of
    Nothing -> return Nothing
    Just st -> do t2 <- getCPUTime
                  doParse st t1 ((t2-t1):ts) tks

accum []     ss         = ss
accum (t:ts) []         = (t,1) : accum ts []
accum (t:ts) ((s,n):ss) = (s+t,n+1) : accum ts ss
