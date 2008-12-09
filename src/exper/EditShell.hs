module Main where

import PGF.Editor
import PGF

import Data.Char
import System (getArgs)

main = do
  putStrLn "Hi, I'm the Editor!"
  file:_ <- getArgs
  pgf <- readPGF file
  let dict = pgf2dict pgf
  let st0 = new (startCat pgf)
  editLoop pgf dict st0

editLoop :: PGF -> Dict -> State -> IO State
editLoop pgf dict st = do
  putStrLn $ "I want something of type " ++ showType (focusType st) ++
             " (0 - " ++ show (length (refineMenu dict st)-1) ++ ")"
  c   <- getLine
  st' <- interpret pgf dict st c
  editLoop pgf dict st'

interpret :: PGF -> Dict -> State -> String -> IO State
interpret pgf dict st c = case words c of
  "r":f:_ -> do
    let st' = goNext (refine dict (mkCId f) st)
    prState pgf st'
    return st'
  "p":ws -> do
    let tts = parseAll pgf (focusType st) (dropWhile (not . isSpace) c)
    st' <- selectReplace dict (concat tts) st >>= return . goNext
    prState pgf st'
    return st'
  "m":_   -> do
    putStrLn (unwords (map prCId (refineMenu dict st)))
    return st
  d : _ | all isDigit d -> do
    let f = refineMenu dict st !! read d
    let st' = goNextMeta (refine dict f st)
    prState pgf st'
    return st' 
  ">":_ -> return (goNext st)
  _ -> do
    putStrLn "command not understood"
    return st

prState pgf st = do
  let t = stateTree st
  putStrLn (unlines ([
    "Now I have",
     showTree t] ++ 
     linearizeAll pgf t))

-- prompt selection from list of trees, such as ambiguous choice
selectReplace :: Dict -> [Tree] -> State -> IO State
selectReplace dict ts st = case ts of
  []  -> putStrLn "no results" >> return st
  [t] -> return $ replace dict t st
  _   -> do
    mapM_ putStrLn $ "choose tree" : 
      [show i ++ " : " ++ showTree t | (i,t) <- zip [0..] ts]
    d <- getLine
    let t = ts !! read d
    return $ replace dict t st

    

