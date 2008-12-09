module Main where

import PGF.Editor
import PGF

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
  putStrLn ("I want something of type " ++ prCId (focusType st))
  c   <- getLine
  st' <- interpret pgf dict st c
  let t = etree2tree (tree st')
  putStrLn (unlines ([
    "Now I have",
     showTree t] ++ 
     linearizeAll pgf t))
  editLoop pgf dict st'

interpret :: PGF -> Dict -> State -> String -> IO State
interpret pgf dict st c = case words c of
  "r":f:_ -> do
    return $ goNextMeta (refine dict (mkCId f) st)
  "m":_   -> do
    putStrLn (unwords (map (prCId . fst) (refineMenu dict st)))
    return st
  _ -> do
    putStrLn "command not understood"
    return st


