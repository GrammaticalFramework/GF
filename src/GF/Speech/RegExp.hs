module GF.Speech.RegExp (RE(..), 
                         epsilonRE, nullRE, 
                         isEpsilon, isNull,
                         unionRE, concatRE, seqRE,
                         repeatRE, minimizeRE,
                         mapRE, mapRE', joinRE,
                         symbolsRE,
                         dfa2re, prRE) where

import Data.List

import GF.Data.Utilities
import GF.Speech.FiniteState

data RE a = 
      REUnion [RE a]  -- ^ REUnion [] is null
    | REConcat [RE a] -- ^ REConcat [] is epsilon
    | RERepeat (RE a)
    | RESymbol a
      deriving (Eq,Ord,Show)


dfa2re :: (Ord a) => DFA a -> RE a
dfa2re = finalRE . elimStates . modifyTransitions merge . addLoops
             . oneFinalState () epsilonRE . mapTransitions RESymbol 
  where addLoops fa = newTransitions [(s,s,nullRE) | (s,_) <- states fa] fa
        merge es = [(f,t,unionRE ls) 
                        | ((f,t),ls) <- buildMultiMap [((f,t),l) | (f,t,l) <- es]]

elimStates :: (Ord a) => DFA (RE a) -> DFA (RE a)
elimStates fa =
    case [s | (s,_) <- states fa, isInternal fa s] of
      [] -> fa
      sE:_ -> elimStates $ insertTransitionsWith (\x y -> unionRE [x,y]) ts $ removeState sE fa
          where sAs = nonLoopTransitionsTo sE fa
                sBs = nonLoopTransitionsFrom sE fa
                r2 = unionRE $ loops sE fa
                ts = [(sA, sB, r r1 r3) | (sA,r1) <- sAs, (sB,r3) <- sBs]
                r r1 r3 = concatRE [r1, repeatRE r2, r3]

epsilonRE :: RE a
epsilonRE = REConcat []

nullRE :: RE a
nullRE = REUnion []

isNull :: RE a -> Bool
isNull (REUnion []) = True
isNull _ = False

isEpsilon :: RE a -> Bool
isEpsilon (REConcat []) = True
isEpsilon _ = False

unionRE :: Ord a => [RE a] -> RE a
unionRE = unionOrId . sortNub . concatMap toList 
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

seqRE :: [a] -> RE a
seqRE = concatRE . map RESymbol

repeatRE :: RE a -> RE a
repeatRE x | isNull x || isEpsilon x = epsilonRE
           | otherwise = RERepeat x

finalRE :: Ord a => DFA (RE a) -> RE a
finalRE fa = concatRE [repeatRE r1, r2, 
                       repeatRE (unionRE [r3, concatRE [r4, repeatRE r1, r2]])]
  where 
    s0 = startState fa
    [sF] = finalStates fa
    r1 = unionRE $ loops s0 fa
    r2 = unionRE $ map snd $ nonLoopTransitionsTo sF fa
    r3 = unionRE $ loops sF fa
    r4 = unionRE $ map snd $ nonLoopTransitionsFrom sF fa

reverseRE :: RE a -> RE a
reverseRE (REConcat xs) = REConcat $ map reverseRE $ reverse xs
reverseRE (REUnion xs) = REUnion (map reverseRE xs)
reverseRE (RERepeat x) = RERepeat (reverseRE x)
reverseRE x = x

minimizeRE :: Ord a => RE a -> RE a
minimizeRE = reverseRE . mergeForward . reverseRE . mergeForward

mergeForward :: Ord a => RE a -> RE a
mergeForward (REUnion xs) = 
    unionRE [concatRE [mergeForward y,mergeForward (unionRE rs)] | (y,rs) <- buildMultiMap (map firstRE xs)]
mergeForward (REConcat (x:xs)) = concatRE [mergeForward x,mergeForward (REConcat xs)]
mergeForward (RERepeat r) = repeatRE (mergeForward r)
mergeForward r = r

firstRE :: RE a -> (RE a, RE a)
firstRE (REConcat (x:xs)) = (x, REConcat xs)
firstRE r = (r,epsilonRE)

mapRE :: (a -> b) -> RE a -> RE b
mapRE f = mapRE' (RESymbol . f)

mapRE' :: (a -> RE b) -> RE a -> RE b
mapRE' f (REConcat xs) = REConcat (map (mapRE' f) xs)
mapRE' f (REUnion xs) = REUnion (map (mapRE' f) xs)
mapRE' f (RERepeat x) = RERepeat (mapRE' f x)
mapRE' f (RESymbol s) = f s

joinRE :: RE (RE a) -> RE a
joinRE (REConcat xs) = REConcat (map joinRE xs)
joinRE (REUnion xs) = REUnion (map joinRE xs)
joinRE (RERepeat xs) = RERepeat (joinRE xs)
joinRE (RESymbol ss) = ss

symbolsRE :: RE a -> [a]
symbolsRE (REConcat xs) = concatMap symbolsRE xs
symbolsRE (REUnion xs) = concatMap symbolsRE xs
symbolsRE (RERepeat x) = symbolsRE x
symbolsRE (RESymbol x) = [x]

-- Debugging

prRE :: RE String -> String
prRE (REUnion []) = "<NULL>"
prRE (REUnion xs) = "(" ++ concat (intersperse " | " (map prRE xs)) ++ ")"
prRE (REConcat xs) = "(" ++ unwords (map prRE xs) ++ ")"
prRE (RERepeat x) = "(" ++ prRE x ++ ")*"
prRE (RESymbol s) = s

