import PGF
import Data.Maybe
import System.IO
import System.CPUTime
import Control.Monad
import Data.Set as Set (fromList,toList)

start_cat = fromJust (readType "Phr")

main = do
  pgf <- readPGF "Lang.pgf"
  trees0 <- generateRandom pgf start_cat
  let trees = Set.toList (Set.fromList (take 5000 trees0))
  hPutStrLn stderr ("Number of trees: "++show (length trees))
  mapM_ (\l -> doTestLang pgf l trees) (languages pgf)

doTestLang pgf l ts = do
  hPutStrLn stderr (show l)
  ss <- foldM (doTest pgf l (fromJust (readType "Phr"))) [] ts
  mapM_ (hPutStrLn stderr . show) [(fromIntegral s / fromIntegral n)/1000000000 | (s,n) <- ss]
  putStrLn "Done."
  
doTest pgf lang cat ss t = do
  let s = linearize pgf lang t
  putStr (s ++ " ... ")
  hFlush stdout
  let st = initState pgf lang cat
  t1 <- getCPUTime
  res <- doParse st t1 [] (words s)
  case res of
    Just (st,ts) -> putStrLn "Ok"   >> return (accum ts ss)
    Nothing      -> putStrLn "Fail" >> return ss


doParse st t1 ts []       = return (Just (st,reverse ts))
doParse st t1 ts (tk:tks) = do
  case nextState st tk of
    Left _   -> return Nothing
    Right st -> do t2 <- getCPUTime
                   doParse st t1 ((t2-t1):ts) tks

accum []     ss         = ss
accum (t:ts) []         = (t,1) : accum ts []
accum (t:ts) ((s,n):ss) = (s+t,n+1) : accum ts ss
