module Session where

import Abstract
import Option
import Custom
import Editing
import ShellState ---- grammar

import Operations

-- First version 8/2001. Adapted to GFC with modules 19/6/2003.
-- Nothing had to be changed, which is a sign of good modularity.

-- keep these abstract

type SState = [(State,([Exp],[Clip]),SInfo)] -- exps: candidate refinements,clipboard
type SInfo  = ([String],(Int,Options))       -- string is message, int is the view

initSState :: SState
initSState = [(initState, ([],[]), (["Select 'New' category to start"],(0,noOptions)))] 
             -- instead of empty

type Clip = Tree ---- (Exp,Type)

okInfo n = ([],(n,True))

stateSState ((s,_,_):_)     = s
candsSState ((_,(ts,_),_):_)= ts
clipSState  ((_,(_,ts),_):_)= ts
infoSState  ((_,_,i):_)     = i
msgSState   ((_,_,(m,_)):_) = m
viewSState  ((_,_,(_,(v,_))):_) = v
optsSState  ((_,_,(_,(_,o))):_) = o

treeSState = actTree . stateSState


-- from state to state

type ECommand = SState -> SState

-- elementary commands

-- change state, drop cands, drop message, preserve options
changeState :: State -> ECommand
changeState s ss = changeMsg [] $ (s,([],clipSState ss),infoSState ss) : ss 

changeCands :: [Exp] -> ECommand
changeCands ts ss@((s,(_,cb),(_,b)):_) = (s,(ts,cb),(candInfo ts,b)) : ss   

addtoClip :: Clip -> ECommand
addtoClip t ss@((s,(ts,cb),(i,b)):_) = (s,(ts,t:cb),(i,b)) : ss   

changeMsg :: [String] -> ECommand
changeMsg m ((s,ts,(_,b)):ss) = (s,ts,(m,b)) : ss   -- just change message

changeView :: ECommand
changeView ((s,ts,(m,(v,b))):ss) = (s,ts,(m,(v+1,b))) : ss    -- toggle view

withMsg :: [String] -> ECommand -> ECommand
withMsg m c = changeMsg m . c

changeStOptions :: (Options -> Options) -> ECommand
changeStOptions f ((s,ts,(m,(v,o))):ss) = (s,ts,(m,(v, f o))) : ss

noNeedForMsg = changeMsg [] -- everything's all right: no message

candInfo ts = case length ts of
  0 -> ["no acceptable alternative"]
  1 -> ["just one acceptable alternative"]
  n -> [show n +++ "alternatives to select"]

-- keep SState abstract from this on

-- editing commands

action2command :: Action -> ECommand
action2command act state = case act (stateSState state) of 
  Ok  s -> changeState s state 
  Bad m -> changeMsg [m] state
  
action2commandNext :: Action -> ECommand -- move to next meta after execution
action2commandNext act = action2command (\s -> act s >>= goNextMetaIfCan)

undoCommand :: ECommand
undoCommand ss@[_] = changeMsg ["cannot go back"] ss
undoCommand (_:ss) = changeMsg ["successful undo"] ss

selectCand :: CGrammar -> Int -> ECommand
selectCand gr i state = err (\m -> changeMsg [m] state) id $ do
  exp <- candsSState state !? i
  let s = stateSState state
  tree <- annotateInState gr exp s
  return $ case replaceSubTree tree s of
      Ok st' -> changeState st' state
      Bad s  -> changeMsg [s] state

refineByExps :: Bool -> CGrammar -> [Exp] -> ECommand
refineByExps der gr trees = case trees of
  [t] -> action2commandNext (refineWithExpTC der gr t)
  _  -> changeCands trees

refineByTrees :: Bool -> CGrammar -> [Tree] -> ECommand
refineByTrees der gr trees = case trees of
  [t] -> action2commandNext (refineOrReplaceWithTree der gr t)
  _  -> changeCands  $ map tree2exp trees

replaceByTrees :: CGrammar -> [Exp] -> ECommand
replaceByTrees gr trees = case trees of
  [t] -> action2commandNext (\s -> 
            annotateExpInState gr t s >>= flip replaceSubTree s)
  _  -> changeCands trees

replaceByEditCommand :: StateGrammar -> String -> ECommand
replaceByEditCommand gr co = 
  action2command $
  maybe return ($ gr) $
  lookupCustom customEditCommand (strCI co) 

replaceByTermCommand :: Bool -> StateGrammar -> String -> Tree -> ECommand ----
replaceByTermCommand der gr co exp = 
  let g = grammar gr in
    refineByTrees der g $ maybe [exp] (\f -> f gr exp) $
      lookupCustom customTermCommand (strCI co)

possClipsSState :: StateGrammar -> SState -> [(Int,Clip)]
possClipsSState gr s = filter poss $ zip [0..] (clipSState s) 
 where
  poss = possibleTreeVal cgr st . snd
  st   = stateSState s
  cgr  = grammar gr

getNumberedClip :: Int -> SState -> Err Clip
getNumberedClip i s = if length cs > i then return (cs !! i) 
                         else Bad "not enough clips"
  where
   cs = clipSState s
