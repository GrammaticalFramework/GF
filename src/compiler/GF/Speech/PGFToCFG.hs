----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.PGFToCFG
--
-- Approximates PGF grammars with context-free grammars.
----------------------------------------------------------------------
module GF.Speech.PGFToCFG (bnfPrinter, pgfToCFG) where

import PGF.CId
import PGF.Data as PGF
import PGF.Macros
import GF.Infra.Ident
import GF.Speech.CFG hiding (Symbol)

import Data.Array.IArray as Array
import Data.List
import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Data.Maybe
import Data.Set (Set)
import qualified Data.Set as Set

bnfPrinter :: PGF -> CId -> String
bnfPrinter = toBNF id

toBNF :: (CFG -> CFG) -> PGF -> CId -> String
toBNF f pgf cnc = prCFG $ f $ pgfToCFG pgf cnc

type Profile = [Int]

pgfToCFG :: PGF 
          -> CId   -- ^ Concrete syntax name
          -> CFG
pgfToCFG pgf lang = mkCFG (showCId (lookStartCat pgf)) extCats (startRules ++ concatMap ruleToCFRule rules)
  where
    cnc = lookConcr pgf lang

    rules :: [(FId,Production)]
    rules = [(fcat,prod) | (fcat,set) <- IntMap.toList (PGF.pproductions cnc)
                         , prod <- Set.toList set]

    fcatCats :: Map FId Cat
    fcatCats = Map.fromList [(fc, showCId c ++ "_" ++ show i) 
                                 | (c,CncCat s e lbls) <- Map.toList (cnccats cnc), 
                                   (fc,i) <- zip (range (s,e)) [1..]]

    fcatCat :: FId -> Cat
    fcatCat c = Map.findWithDefault ("Unknown_" ++ show c) c fcatCats

    fcatToCat :: FId -> LIndex -> Cat
    fcatToCat c l = fcatCat c ++ row
      where row = if catLinArity c == 1 then "" else "_" ++ show l

    -- gets the number of fields in the lincat for the given category
    catLinArity :: FId -> Int
    catLinArity c = maximum (1:[rangeSize (bounds rhs) | (CncFun _ rhs, _) <- topdownRules c])

    topdownRules cat = f cat []
      where
        f cat rules = maybe rules (Set.fold g rules) (IntMap.lookup cat (pproductions cnc))
	 
        g (PApply funid args) rules = (cncfuns cnc ! funid,args) : rules
        g (PCoerce cat)       rules = f cat rules


    extCats :: Set Cat
    extCats = Set.fromList $ map lhsCat startRules

    startRules :: [CFRule]
    startRules = [CFRule (showCId c) [NonTerminal (fcatToCat fc r)] (CFRes 0) 
                      | (c,CncCat s e lbls) <- Map.toList (cnccats cnc), 
                        fc <- range (s,e), not (isLiteralFCat fc),
                        r <- [0..catLinArity fc-1]]

    ruleToCFRule :: (FId,Production) -> [CFRule]
    ruleToCFRule (c,PApply funid args) = 
        [CFRule (fcatToCat c l) (mkRhs row) (profilesToTerm [fixProfile row n | n <- [0..length args-1]])
           | (l,seqid) <- Array.assocs rhs
           , let row = sequences cnc ! seqid
           , not (containsLiterals row)]
      where
        CncFun f rhs = cncfuns cnc ! funid

        mkRhs :: Array DotPos Symbol -> [CFSymbol]
        mkRhs = concatMap symbolToCFSymbol . Array.elems

        containsLiterals :: Array DotPos Symbol -> Bool
        containsLiterals row = any isLiteralFCat [args!!n | SymCat n _ <- Array.elems row] ||
                               not (null [n | SymLit n _ <- Array.elems row])   -- only this is needed for PMCFG.
                                                                                -- The first line is for backward compat.

        symbolToCFSymbol :: Symbol -> [CFSymbol]
        symbolToCFSymbol (SymCat n l)    = [NonTerminal (fcatToCat (args!!n) l)]
        symbolToCFSymbol (SymLit n l)    = [NonTerminal (fcatToCat (args!!n) l)]
        symbolToCFSymbol (SymKS ts)      = map Terminal ts
        symbolToCFSymbol (SymKP ts as)   = map Terminal $ ts 
                                           ---- ++ [t | Alt ss _ <- as, t <- ss]
                                           ---- should be alternatives in [[CFSymbol]]
                                           ---- AR 3/6/2010
        fixProfile :: Array DotPos Symbol -> Int -> Profile
        fixProfile row i = [k | (k,j) <- nts, j == i]
            where
              nts = zip [0..] [j | nt <- Array.elems row, j <- getPos nt]
              
              getPos (SymCat j _) = [j]
              getPos (SymLit j _) = [j]
              getPos _            = []

        profilesToTerm :: [Profile] -> CFTerm
        profilesToTerm ps = CFObj f (zipWith profileToTerm argTypes ps)
            where (argTypes,_) = catSkeleton $ lookType pgf f

        profileToTerm :: CId -> Profile -> CFTerm
        profileToTerm t [] = CFMeta t
        profileToTerm _ xs = CFRes (last xs) -- FIXME: unify
    ruleToCFRule (c,PCoerce c') =
        [CFRule (fcatToCat c l) [NonTerminal (fcatToCat c' l)] (CFRes 0)
           | l <- [0..catLinArity c-1]]
