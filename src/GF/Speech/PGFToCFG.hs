----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.PGFToCFG
--
-- Approximates PGF grammars with context-free grammars.
----------------------------------------------------------------------
module GF.Speech.PGFToCFG (bnfPrinter, nonLeftRecursivePrinter, regularPrinter, 
                           fcfgPrinter, pgfToCFG) where

import PGF.CId
import PGF.Data as PGF
import PGF.Macros
import GF.Data.MultiMap (MultiMap)
import qualified GF.Data.MultiMap as MultiMap
import GF.Infra.Ident
import GF.Speech.CFG

import Data.Array as Array
import Data.List
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Data.Set (Set)
import qualified Data.Set as Set

bnfPrinter :: PGF -> CId -> String
bnfPrinter = toBNF id

nonLeftRecursivePrinter :: PGF -> CId -> String
nonLeftRecursivePrinter = toBNF removeLeftRecursion

regularPrinter :: PGF -> CId -> String
regularPrinter = toBNF makeRegular

toBNF :: (CFG -> CFG) -> PGF -> CId -> String
toBNF f pgf cnc = prCFG $ f $ pgfToCFG pgf cnc

-- FIXME: move this somewhere else
fcfgPrinter :: PGF -> CId -> String
fcfgPrinter pgf cnc = unlines (map showRule rules)
  where
    pinfo = fromMaybe (error "fcfgPrinter") (lookParser pgf cnc)

    rules :: [FRule]
    rules = Array.elems (PGF.allRules pinfo)

    showRule (FRule cid ps cs fc arr) = prCId cid ++ " " ++ show ps ++ ". " ++ showCat fc ++ " ::= [" ++ concat (intersperse ", " (map showCat cs)) ++ "] = " ++ showLin arr
        where
          showLin arr = "[" ++ concat (intersperse ", " [ unwords (map showFSymbol (Array.elems r)) | r <- Array.elems arr]) ++ "]"
          showFSymbol (FSymCat i j) = showCat (cs!!j) ++ "_" ++ show j ++ "." ++ show i
          showFSymbol (FSymTok t) = t
    showCat c = "C" ++ show c

pgfToCFG :: PGF 
          -> CId   -- ^ Concrete syntax name
          -> CFG
pgfToCFG pgf lang = mkCFG (lookStartCat pgf) extCats (startRules ++ concatMap fruleToCFRule rules)
  where
    pinfo = fromMaybe (error "pgfToCFG: No parser.") (lookParser pgf lang)

    rules :: [FRule]
    rules = Array.elems (PGF.allRules pinfo)

    fcatCats :: Map FCat Cat
    fcatCats = Map.fromList [(fc, prCId c ++ "_" ++ show i) 
                                 | (c,fcs) <- Map.toList (startupCats pinfo), 
                                   (fc,i) <- zip fcs [1..]]

    fcatCat :: FCat -> Cat
    fcatCat c = Map.findWithDefault ("Unknown_" ++ show c) c fcatCats

    fcatToCat :: FCat -> FIndex -> Cat
    fcatToCat c l = fcatCat c ++ row
      where row = if catLinArity c == 1 then "" else "_" ++ show l

    -- gets the number of fields in the lincat for the given category
    catLinArity :: FCat -> Int
    catLinArity c = maximum (1:[rangeSize (bounds rhs) | FRule _ _ _ _ rhs <- Map.findWithDefault [] c rulesByFCat])

    rulesByFCat :: Map FCat [FRule]
    rulesByFCat = Map.fromListWith (++) [(c,[r]) | r@(FRule _ _ _ c _) <- rules]

    extCats :: Set Cat
    extCats = Set.fromList $ map lhsCat startRules

    -- NOTE: this is only correct for cats that have a lincat with exactly one row.
    startRules :: [CFRule]
    startRules = [CFRule (prCId c) [NonTerminal (fcatToCat fc 0)] (CFRes 0) 
                      | (c,fcs) <- Map.toList (startupCats pinfo), 
                        fc <- fcs, not (isLiteralFCat fc)]

    fruleToCFRule :: FRule -> [CFRule]
    fruleToCFRule (FRule f ps args c rhs) = 
        [CFRule (fcatToCat c l) (mkRhs row) (profilesToTerm (map (fixProfile row) ps))
         | (l,row) <- Array.assocs rhs, not (containsLiterals row)]
      where
        mkRhs :: Array FPointPos FSymbol -> [CFSymbol]
        mkRhs = map fsymbolToSymbol . Array.elems

        containsLiterals :: Array FPointPos FSymbol -> Bool
        containsLiterals row = any isLiteralFCat [args!!n | FSymCat _ n <- Array.elems row]

        fsymbolToSymbol :: FSymbol -> CFSymbol
        fsymbolToSymbol (FSymCat l n) = NonTerminal (fcatToCat (args!!n) l)
        fsymbolToSymbol (FSymTok t) = Terminal t

        fixProfile :: Array FPointPos FSymbol -> Profile -> Profile
        fixProfile row = concatMap positions
            where
              nts = zip [0..] [nt | nt@(FSymCat _ _) <- Array.elems row ]
              positions i = [k | (k,FSymCat _ j) <- nts, j == i]

        profilesToTerm :: [Profile] -> CFTerm
        profilesToTerm [[n]] | f == wildCId = CFRes n
        profilesToTerm ps = CFObj f (zipWith profileToTerm argTypes ps)
            where (argTypes,_) = catSkeleton $ lookType pgf f

        profileToTerm :: CId -> Profile -> CFTerm
        profileToTerm t [] = CFMeta t
        profileToTerm _ xs = CFRes (last xs) -- FIXME: unify

isLiteralFCat :: FCat -> Bool
isLiteralFCat = (`elem` [fcatString, fcatInt, fcatFloat, fcatVar])
