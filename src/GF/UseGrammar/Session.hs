----------------------------------------------------------------------
-- |
-- Module      : Session
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/08/17 15:13:55 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.12 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.UseGrammar.Session where

import GF.Grammar.Abstract
import GF.Infra.Option
import GF.UseGrammar.Custom
import GF.UseGrammar.Editing
import GF.Compile.ShellState ---- grammar

import GF.Data.Operations
import GF.Data.Zipper (keepPosition) ---

-- First version 8/2001. Adapted to GFC with modules 19/6/2003.
-- Nothing had to be changed, which is a sign of good modularity.

-- keep these abstract

-- | 'Exp'-list: candidate refinements,clipboard
type SState = [(State,([Exp],[Clip]),SInfo)] 

-- | 'String' is message, 'Int' is the view
type SInfo  = ([String],(Int,Options))       

initSState :: SState
initSState = [(initState, ([],[]), (["Select 'New' category to start"],(0,noOptions)))] 
             -- instead of empty

type Clip = Tree ---- (Exp,Type)

-- | (peb): Something wrong with this definition??
-- Shouldn't the result type be 'SInfo'?
--
-- > okInfo :: Int -> SInfo == ([String], (Int, Options))
okInfo :: n -> ([s], (n, Bool))
okInfo n = ([],(n,True))

stateSState :: SState -> State
candsSState :: SState -> [Exp]
clipSState  :: SState -> [Clip]
infoSState  :: SState -> SInfo
msgSState   :: SState -> [String]
viewSState  :: SState -> Int
optsSState  :: SState -> Options

stateSState ((s,_,_):_)     = s
candsSState ((_,(ts,_),_):_)= ts
clipSState  ((_,(_,ts),_):_)= ts
infoSState  ((_,_,i):_)     = i
msgSState   ((_,_,(m,_)):_) = m
viewSState  ((_,_,(_,(v,_))):_) = v
optsSState  ((_,_,(_,(_,o))):_) = o

treeSState :: SState -> Tree
treeSState = actTree . stateSState


-- | from state to state
type ECommand = SState -> SState

-- * elementary commands

-- ** change state, drop cands, drop message, preserve options

changeState :: State -> ECommand
changeState s ss = changeMsg [] $ (s,([],clipSState ss),infoSState ss) : ss 

changeCands :: [Exp] -> ECommand
changeCands ts ss@((s,(_,cb),(_,b)):_) = (s,(ts,cb),(candInfo ts,b)) : ss   

addtoClip :: Clip -> ECommand
addtoClip t ss@((s,(ts,cb),(i,b)):_) = (s,(ts,t:cb),(i,b)) : ss   

removeClip :: Int -> ECommand
removeClip n ss@((s,(ts,cb),(i,b)):_) = (s,(ts, drop n cb),(i,b)) : ss   

changeMsg :: [String] -> ECommand
changeMsg m ((s,ts,(_,b)):ss) = (s,ts,(m,b)) : ss   -- just change message
changeMsg m _                 = (s,ts,(m,b)) : []  where [(s,ts,(_,b))] = initSState

changeView :: ECommand
changeView ((s,ts,(m,(v,b))):ss) = (s,ts,(m,(v+1,b))) : ss    -- toggle view

withMsg :: [String] -> ECommand -> ECommand
withMsg m c = changeMsg m . c

changeStOptions :: (Options -> Options) -> ECommand
changeStOptions f ((s,ts,(m,(v,o))):ss) = (s,ts,(m,(v, f o))) : ss

noNeedForMsg :: ECommand
noNeedForMsg = changeMsg [] -- everything's all right: no message

candInfo :: [Exp] -> [String]
candInfo ts = case length ts of
  0 -> ["no acceptable alternative"]
  1 -> ["just one acceptable alternative"]
  n -> [show n +++ "alternatives to select"]

-- * keep SState abstract from this on

-- ** editing commands

action2command :: Action -> ECommand
action2command act state = case act (stateSState state) of 
  Ok  s -> changeState s state 
  Bad m -> changeMsg [m] state
  
action2commandNext :: Action -> ECommand -- move to next meta after execution
action2commandNext act = action2command (\s -> act s >>= goNextMetaIfCan)

action2commandKeep :: Action -> ECommand -- keep old position after execution
action2commandKeep act = action2command (\s -> keepPosition act s)

undoCommand :: Int -> ECommand
undoCommand n ss =
  let k = length ss in
  if k < n 
     then changeMsg ["cannot go all the way back"] [last ss]
     else changeMsg ["successful undo"] (drop n ss)

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
  action2commandKeep $
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
