module GF.Speech.RegExp (RE(..), dfa2re, prRE) where

import Data.List

import GF.Data.Utilities
import GF.Speech.FiniteState

data RE a = 
      REUnion [RE a]  -- ^ REUnion [] is null
    | REConcat [RE a] -- ^ REConcat [] is epsilon
    | RERepeat (RE a)
    | RESymbol a
      deriving (Eq,Show)


dfa2re :: Show a => DFA a -> RE a
dfa2re = finalRE . elimStates . modifyTransitions merge . addLoops
             . oneFinalState () epsilonRE . mapTransitions RESymbol 
  where addLoops fa = newTransitions [(s,s,nullRE) | (s,_) <- states fa] fa
        merge es = [(f,t,unionRE ls) 
                        | ((f,t),ls) <- buildMultiMap [((f,t),l) | (f,t,l) <- es]]

elimStates :: Show a => DFA (RE a) -> DFA (RE a)
elimStates fa =
    case [s | (s,_) <- states fa, isInternal fa s] of
      [] -> fa
      sE:_ -> elimStates $ insertTransitionsWith (\x y -> unionRE [x,y]) ts $ removeState sE fa
          where sAs = nonLoopTransitionsTo sE fa
                sBs = nonLoopTransitionsFrom sE fa
                r2 = unionRE $ loops sE fa
                ts = [(sA, sB, r r1 r3) | (sA,r1) <- sAs, (sB,r3) <- sBs]
                r r1 r3 = concatRE [r1, repeatRE r2, r3]

epsilonRE = REConcat []

nullRE = REUnion []

isNull (REUnion []) = True
isNull _ = False

isEpsilon (REConcat []) = True
isEpsilon _ = False

unionRE :: [RE a] -> RE a
unionRE = unionOrId . concatMap toList 
  where 
    toList (REUnion xs) = xs
    toList x = [x]
    unionOrId [r] = r
    unionOrId rs = REUnion rs

concatRE :: [RE a] -> RE a
concatRE xs | any isNull xs = nullRE
            | otherwise = case concatMap toList xs of
                            [r] -> r
                            rs -> REConcat rs
  where
    toList (REConcat xs) = xs
    toList x = [x]

repeatRE :: RE a -> RE a
repeatRE x | isNull x || isEpsilon x = epsilonRE
           | otherwise = RERepeat x

finalRE :: DFA (RE a) -> RE a
finalRE fa = concatRE [repeatRE r1, r2, 
                       repeatRE (unionRE [r3, concatRE [r4, repeatRE r1, r2]])]
  where 
    s0 = startState fa
    [sF] = finalStates fa
    r1 = unionRE $ loops s0 fa
    r2 = unionRE $ map snd $ nonLoopTransitionsTo sF fa
    r3 = unionRE $ loops sF fa
    r4 = unionRE $ map snd $ nonLoopTransitionsFrom sF fa

-- Debugging

prRE :: Show a => RE a -> String
prRE (REUnion []) = "<NULL>"
prRE (REUnion xs) = "(" ++ concat (intersperse " | " (map prRE xs)) ++ ")"
prRE (REConcat xs) = "(" ++ unwords (map prRE xs) ++ ")"
prRE (RERepeat x) = "(" ++ prRE x ++ ")*"
prRE (RESymbol s) = show s

