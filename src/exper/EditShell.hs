module Main where

import PGF.Editor
import PGF

import Data.Char
import System (getArgs)

-- a rough editor shell using the PGF.Edito API
-- compile:
--   cd .. ; ghc --make exper/EditShell.hs
-- use:
--   EditShell file.pgf

main = do
  putStrLn "Hi, I'm the Editor! Type h for help on commands."
  file:_ <- getArgs
  pgf <- readPGF file
  let dict = pgf2dict pgf
  let st0 = new (startCat pgf)
  let lang = head (languages pgf) ---- for printnames; enable choosing lang
  editLoop pgf dict lang st0        -- alt 1: all editing commands
--  dialogueLoop pgf dict lang st0  -- alt 2: just refinement by parsing (see bottom)

editLoop :: PGF -> Dict -> Language -> State -> IO State
editLoop pgf dict lang st = do
  putStrLn $ 
    if null (allMetas st) 
      then unlines 
             (["The tree is complete:",prState st] ++ linearizeAll pgf (stateTree st))
    else if isMetaFocus st 
      then "I want something of type " ++ showType (focusType st) ++
         " (0 - " ++ show (length (refineMenu dict st)-1) ++ ")"
    else "Do you want to change this node?" 
  c   <- getLine
  st' <- interpret pgf dict st c
  editLoop pgf dict lang st'

interpret :: PGF -> Dict -> State -> String -> IO State
interpret pgf dict st c = case words c of
  "r":f:_ -> do
    let st' = goNextMeta (refine dict (mkCId f) st)
    prLState pgf st'
    return st'
  "p":ws -> do
    let tts = parseAll pgf (focusType st) (dropWhile (not . isSpace) c)
    st' <- selectReplace dict (concat tts) st
    prLState pgf st'
    return st'
  "a":_ -> do
    t:_  <- generateRandom pgf (focusType st)
    let st' = goNextMeta (replace dict t st)
    prLState pgf st'
    return st'
  "d":_ -> do
    let st' = delete st
    prLState pgf st'
    return st'
  "m":_   -> do
    putStrLn (unwords (map prCId (refineMenu dict st)))
    return st
  d : _ | all isDigit d -> do
    let f = refineMenu dict st !! read d
    let st' = goNextMeta (refine dict f st)
    prLState pgf st'
    return st' 
  p@('[':_):_ -> do
    let st' = goPosition (mkPosition (read p)) st
    prLState pgf st'
    return st'
  ">":_ -> do
    let st' = goNext st
    prLState pgf st'
    return st'
  "x":_ -> do
    mapM_ putStrLn [show (showPosition p) ++ showType t  | (p,t) <- allMetas st]
    return st
  "h":_ -> putStrLn commandHelp >> return st
  _ -> do
    putStrLn "command not understood"
    return st

prLState pgf st = do
  let t = stateTree st
  putStrLn (unlines ([
    "Now I have:","",
     prState st] ++ 
     linearizeAll pgf t))

-- prompt selection from list of trees, such as ambiguous choice
selectReplace :: Dict -> [Tree] -> State -> IO State
selectReplace dict ts st = case ts of
  []  -> putStrLn "no results" >> return st
  [t] -> return $ goNextMeta $ replace dict t st 
  _   -> do
    mapM_ putStrLn $ "choose tree by entering its number:" : 
      [show i ++ " : " ++ showTree t | (i,t) <- zip [0..] ts]
    d <- getLine
    let t = ts !! read d
    return $ goNextMeta $ replace dict t st

commandHelp = unlines [
  "a           -- refine with a random subtree",
  "d           -- delete current subtree",
  "h           -- display this help message",
  "m           -- show refinement menu",
  "p Anything  -- parse Anything and refine with it",
  "r Function  -- refine with Function",
  "x           -- show all unknown positions and their types", 
  "4           -- refine with 4th item from menu (see m)", 
  "[1,2,3]     -- go to position 1,2,3",
  ">           -- go to next node"
  ]    

----------------
-- for a dialogue system, working just by parsing; questions are cat printnames
----------------

dialogueLoop :: PGF -> Dict -> Language -> State -> IO State
dialogueLoop pgf dict lang st = do
  putStrLn $ 
    if null (allMetas st) 
    then "Ready!\n  " ++ unlines (linearizeAll pgf (stateTree st))
    else if isMetaFocus st 
      then showPrintName pgf lang (focusType st)
    else "Do you want to change this node?" 
  c   <- getLine
  st' <- interpretD pgf dict st c
  dialogueLoop pgf dict lang st'

interpretD :: PGF -> Dict -> State -> String -> IO State
interpretD pgf dict st c = do
  let tts = parseAll pgf (focusType st) c
  st' <- selectReplace dict (concat tts) st
--  prLState pgf st'
  return st'
