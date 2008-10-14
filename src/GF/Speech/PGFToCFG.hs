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
import GF.Speech.CFG

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


pgfToCFG :: PGF 
          -> CId   -- ^ Concrete syntax name
          -> CFG
pgfToCFG pgf lang = mkCFG (lookStartCat pgf) extCats (startRules ++ concatMap fruleToCFRule rules)
  where
    pinfo = fromMaybe (error "pgfToCFG: No parser.") (lookParser pgf lang)

    rules :: [(FCat,Production)]
    rules = [(fcat,prod) | (fcat,set) <- IntMap.toList (PGF.productions pinfo)
                         , prod <- Set.toList set]

    fcatCats :: Map FCat Cat
    fcatCats = Map.fromList [(fc, prCId c ++ "_" ++ show i) 
                                 | (c,fcs) <- Map.toList (startCats pinfo), 
                                   (fc,i) <- zip fcs [1..]]

    fcatCat :: FCat -> Cat
    fcatCat c = Map.findWithDefault ("Unknown_" ++ show c) c fcatCats

    fcatToCat :: FCat -> FIndex -> Cat
    fcatToCat c l = fcatCat c ++ row
      where row = if catLinArity c == 1 then "" else "_" ++ show l

    -- gets the number of fields in the lincat for the given category
    catLinArity :: FCat -> Int
    catLinArity c = maximum (1:[rangeSize (bounds rhs) | (FFun _ _ rhs, _) <- topdownRules c])

    topdownRules cat = f cat []
      where
        f cat rules = maybe rules (Set.fold g rules) (IntMap.lookup cat (productions pinfo))
	 
        g (FApply funid args) rules = (functions pinfo ! funid,args) : rules
        g (FCoerce cat)       rules = f cat rules


    extCats :: Set Cat
    extCats = Set.fromList $ map lhsCat startRules

    startRules :: [CFRule]
    startRules = [CFRule (prCId c) [NonTerminal (fcatToCat fc r)] (CFRes 0) 
                      | (c,fcs) <- Map.toList (startCats pinfo), 
                        fc <- fcs, not (isLiteralFCat fc),
                        r <- [0..catLinArity fc-1]]

    fruleToCFRule :: (FCat,Production) -> [CFRule]
    fruleToCFRule (c,FApply funid args) = 
        [CFRule (fcatToCat c l) (mkRhs row) (profilesToTerm (map (fixProfile row) ps))
           | (l,seqid) <- Array.assocs rhs
           , let row = sequences pinfo ! seqid
           , not (containsLiterals row)]
      where
        FFun f ps rhs = functions pinfo ! funid

        mkRhs :: Array FPointPos FSymbol -> [CFSymbol]
        mkRhs = map fsymbolToSymbol . Array.elems

        containsLiterals :: Array FPointPos FSymbol -> Bool
        containsLiterals row = any isLiteralFCat [args!!n | FSymCat n _ <- Array.elems row]

        fsymbolToSymbol :: FSymbol -> CFSymbol
        fsymbolToSymbol (FSymCat n l)    = NonTerminal (fcatToCat (args!!n) l)
        fsymbolToSymbol (FSymTok (KS t)) = Terminal t

        fixProfile :: Array FPointPos FSymbol -> Profile -> Profile
        fixProfile row = concatMap positions
            where
              nts = zip [0..] [nt | nt@(FSymCat _ _) <- Array.elems row]
              positions i = [k | (k,FSymCat j _) <- nts, j == i]

        profilesToTerm :: [Profile] -> CFTerm
        profilesToTerm ps = CFObj f (zipWith profileToTerm argTypes ps)
            where (argTypes,_) = catSkeleton $ lookType pgf f

        profileToTerm :: CId -> Profile -> CFTerm
        profileToTerm t [] = CFMeta t
        profileToTerm _ xs = CFRes (last xs) -- FIXME: unify
    fruleToCFRule (c,FCoerce c') =
        [CFRule (fcatToCat c l) [NonTerminal (fcatToCat c' l)] (CFRes 0)
           | l <- [0..catLinArity c-1]]


isLiteralFCat :: FCat -> Bool
isLiteralFCat = (`elem` [fcatString, fcatInt, fcatFloat, fcatVar])
