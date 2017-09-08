----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.PGFToCFG
--
-- Approximates PGF grammars with context-free grammars.
----------------------------------------------------------------------
module GF.Speech.PGFToCFG (bnfPrinter, pgfToCFG) where

import PGF
import PGF.Internal
import GF.Grammar.CFG hiding (Symbol)

import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
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
pgfToCFG pgf lang = mkCFG (showCId start_cat) extCats (startRules ++ concatMap ruleToCFRule rules)
  where
    (_,start_cat,_) = unType (startCat pgf)
    cnc = lookConcr pgf lang

    rules :: [(FId,Production)]
    rules = [(fcat,prod) | fcat <- [0..concrTotalCats cnc],
                           prod <- concrProductions cnc fcat]

    fcatCats :: Map FId Cat
    fcatCats = Map.fromList [(fc, showCId c ++ "_" ++ show i) 
                                 | (c,s,e,lbls) <- concrCategories cnc,
                                   (fc,i) <- zip [s..e] [1..]]

    fcatCat :: FId -> Cat
    fcatCat c = Map.findWithDefault ("Unknown_" ++ show c) c fcatCats

    fcatToCat :: FId -> Int -> Cat
    fcatToCat c l = fcatCat c ++ row
      where row = if catLinArity c == 1 then "" else "_" ++ show l

    -- gets the number of fields in the lincat for the given category
    catLinArity :: FId -> Int
    catLinArity c = maximum (1:[length rhs | ((_,rhs), _) <- topdownRules c])

    topdownRules cat = f cat []
      where
        f cat rules = foldr g rules (concrProductions cnc cat)
	 
        g (PApply funid args) rules = (concrFunction cnc funid,args) : rules
        g (PCoerce cat)       rules = f cat rules


    extCats :: Set Cat
    extCats = Set.fromList $ map ruleLhs startRules

    startRules :: [CFRule]
    startRules = [Rule (showCId c) [NonTerminal (fcatToCat fc r)] (CFRes 0) 
                      | (c,s,e,lbls) <- concrCategories cnc,
                        fc <- [s..e], not (isPredefFId fc),
                        r <- [0..catLinArity fc-1]]

    ruleToCFRule :: (FId,Production) -> [CFRule]
    ruleToCFRule (c,PApply funid args) = 
        [Rule (fcatToCat c l) (mkRhs row) (profilesToTerm [fixProfile row n | n <- [0..length args-1]])
           | (l,seqid) <- zip [0..] rhs
           , let row = concrSequence cnc seqid
           , not (containsLiterals row)]
      where
        (f, rhs) = concrFunction cnc funid

        mkRhs :: [Symbol] -> [CFSymbol]
        mkRhs = concatMap symbolToCFSymbol

        containsLiterals :: [Symbol] -> Bool
        containsLiterals row = not (null ([n | SymLit n _ <- row] ++
                                          [n | SymVar n _ <- row]))

        symbolToCFSymbol :: Symbol -> [CFSymbol]
        symbolToCFSymbol (SymCat n l)    = [let PArg _ fid = args!!n in NonTerminal (fcatToCat fid l)]
        symbolToCFSymbol (SymKS t)       = [Terminal t]
        symbolToCFSymbol (SymKP syms as) = concatMap symbolToCFSymbol syms
                                           ---- ++ [t | Alt ss _ <- as, t <- ss]
                                           ---- should be alternatives in [[CFSymbol]]
                                           ---- AR 3/6/2010
        symbolToCFSymbol SymBIND         = [Terminal "&+"]
        symbolToCFSymbol SymSOFT_BIND    = []
        symbolToCFSymbol SymSOFT_SPACE   = []
        symbolToCFSymbol SymCAPIT        = [Terminal "&|"]
        symbolToCFSymbol SymALL_CAPIT    = [Terminal "&|"]
        symbolToCFSymbol SymNE           = []

        fixProfile :: [Symbol] -> Int -> Profile
        fixProfile row i = [k | (k,j) <- nts, j == i]
            where
              nts = zip [0..] [j | nt <- row, j <- getPos nt]
              
              getPos (SymCat j _) = [j]
              getPos (SymLit j _) = [j]
              getPos _            = []

        profilesToTerm :: [Profile] -> CFTerm
        profilesToTerm ps = CFObj f (zipWith profileToTerm argTypes ps)
            where Just (hypos,_,_) = fmap unType (functionType pgf f)
                  argTypes = [cat | (_,_,ty) <- hypos, let (_,cat,_) = unType ty]

        profileToTerm :: CId -> Profile -> CFTerm
        profileToTerm t [] = CFMeta t
        profileToTerm _ xs = CFRes (last xs) -- FIXME: unify
    ruleToCFRule (c,PCoerce c') =
        [Rule (fcatToCat c l) [NonTerminal (fcatToCat c' l)] (CFRes 0)
           | l <- [0..catLinArity c-1]]
