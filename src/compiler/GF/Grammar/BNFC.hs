----------------------------------------------------------------------
-- |
-- Module      : CFEG 
-- Maintainer  : Gleb Lobanov 
-- Stability   : (experimental)
-- Portability : (portable)
--
-- > CVS $Date: 2016/03/16 19:59:00 $ 
-- > CVS $Author: Gleb Lobanov $
-- > CVS $Revision: 0.1 $
--
-- Contains a function to convert extended CF grammars to CF grammars. 
-----------------------------------------------------------------------------

module GF.Grammar.BNFC(BNFCRule(..), BNFCSymbol, Symbol(..), CFTerm(..), bnfc2cf) where

import GF.Grammar.CFG
import PGF (Token, mkCId)
import Data.List (partition)

type IsList = Bool
type BNFCSymbol = Symbol (Cat, IsList) Token
data BNFCRule = BNFCRule {
                 lhsCat :: Cat,
                 ruleRhs :: [BNFCSymbol],
                 ruleName :: CFTerm }
              | BNFCCoercions {
                 coerCat :: Cat,
                 coerNum :: Int }
              | BNFCTerminator {
                 termNonEmpty :: Bool,
                 termCat :: Cat,
                 termSep :: String }
              | BNFCSeparator {
                 sepNonEmpty :: Bool,
                 sepCat :: Cat,
                 sepSep :: String }
              deriving (Eq, Ord, Show)

type IsNonempty  = Bool
type IsSeparator = Bool
type SepTermSymb = String 
type SepMap      = [(Cat, (IsNonempty, IsSeparator, SepTermSymb))]

bnfc2cf :: [BNFCRule] -> [ParamCFRule]
bnfc2cf rules = concatMap (transformRules (map makeSepTerm rules1)) rules2
  where (rules1,rules2) = partition isSepTerm rules
        makeSepTerm (BNFCTerminator ne c s) = (c, (ne, False, s))
        makeSepTerm (BNFCSeparator  ne c s) = (c, (ne, True,  s))

isSepTerm :: BNFCRule -> Bool
isSepTerm (BNFCTerminator {}) = True
isSepTerm (BNFCSeparator  {}) = True
isSepTerm _                   = False

transformRules :: SepMap -> BNFCRule -> [ParamCFRule]
transformRules sepMap (BNFCRule c smbs@(s:ss) r) = Rule (c,[0]) cfSmbs r : rls
  where smbs'   = map (transformSymb sepMap) smbs
        cfSmbs  = [snd s | s            <- smbs']
        ids = filter (/= "") [fst s | s <- smbs']
        rls = concatMap (createListRules sepMap) ids
transformRules sepMap (BNFCCoercions c num) = rules ++ [lastRule]
          where rules = map (fRules c)  [0..num-1]
                lastRule = Rule (c',[0]) ss rn
                  where c' = c ++ show num
                        ss = [Terminal "(", NonTerminal (c,[0]), Terminal ")"]
                        rn = CFObj (mkCId $ "coercion_" ++ c) []

fRules c n = Rule (c',[0]) ss rn
   where c' = if n == 0 then c else c ++ show n
         ss = [NonTerminal (c ++ show (n+1),[0])]
         rn = CFObj (mkCId $ "coercion_" ++ c') []

transformSymb :: SepMap -> BNFCSymbol -> (String, ParamCFSymbol)
transformSymb sepMap s = case s of
  NonTerminal (c,False) -> ("", NonTerminal (c,[0]))
  NonTerminal (c,True ) -> let needsCoercion = 
                                 case lookup c sepMap of
                                   Just (ne, isSep, symb) -> isSep && symb /= "" && not ne
                                   Nothing                -> False
                           in (c , NonTerminal ("List" ++ c,if needsCoercion then [0,1] else [0]))
  Terminal t            -> ("", Terminal t)

createListRules :: SepMap -> String -> [ParamCFRule]
createListRules sepMap c =
  case lookup c sepMap of
    Just (ne, isSep, symb) -> createListRules' ne isSep symb c
    Nothing                -> createListRules' False True "" c

createListRules':: IsNonempty -> IsSeparator -> SepTermSymb -> String -> [ParamCFRule]
createListRules' ne isSep symb c = ruleBase : ruleCons
  where ruleBase = Rule ("List" ++ c,[0]) smbs rn
          where smbs = if isSep
                       then [NonTerminal (c,[0]) | ne]
                       else [NonTerminal (c,[0]) | ne] ++
                            [Terminal symb | symb /= "" && ne]
                rn   = CFObj (mkCId $ "Base" ++ c) []
        ruleCons
          | isSep && symb /= "" && not ne = [Rule ("List" ++ c,[1]) smbs0 rn
                                            ,Rule ("List" ++ c,[1]) smbs1 rn]
          | otherwise                     = [Rule ("List" ++ c,[0]) smbs  rn]
          where smbs0 =[NonTerminal (c,[0])] ++
                       [NonTerminal ("List" ++ c,[0])]
                smbs1 =[NonTerminal (c,[0])] ++
                       [Terminal symb] ++
                       [NonTerminal ("List" ++ c,[1])]
                smbs = [NonTerminal (c,[0])] ++
                       [Terminal symb | symb /= ""] ++
                       [NonTerminal ("List" ++ c,[0])]
                rn   = CFObj (mkCId $ "Cons" ++ c) []
