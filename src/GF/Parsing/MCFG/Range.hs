
module GF.NewParsing.MCFG.Range where


-- Haskell
import List
import Monad

-- GF modules
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.Utilities
import GF.Infra.Print
import GF.Data.Assoc ((?))

------------------------------------------------------------
-- ranges as single pairs

data Range = Range (Int, Int)
	   | EmptyRange
             deriving (Eq, Ord, Show)

makeRange   :: (Int, Int) -> Range
concatRange :: Range -> Range -> [Range]
rangeEdge   :: a -> Range -> Edge a
minRange    :: Range -> Int
maxRange    :: Range -> Int

makeRange                              = Range 
concatRange EmptyRange rng = return rng
concatRange rng EmptyRange = return rng
concatRange (Range(i,j)) (Range(j',k)) = [ Range(i,k) | j==j']
rangeEdge    a           (Range(i,j))  = Edge i j a
minRange    (Range rho)                = fst rho
maxRange    (Range rho)                = snd rho

instance Print Range where
    prt (Range (i,j)) = "(" ++ show i ++ "-" ++ show j ++ ")"
    prt (EmptyRange)  = "(?)"

{-- Types --------------------------------------------------------------------
  Linearization- and Range records implemented as lists
-----------------------------------------------------------------------------}

type LinRec c l t = [Lin c l t]
 
type RangeRec   l = [(l, Range)]


{-- Functions ----------------------------------------------------------------
  Concatenation         : Concatenation of Ranges, Symbols and Linearizations 
                          and records of Linearizations 
  Record transformation : Makes a Range record from a fully instantiated
                          Linearization record 
  Record projection     : Given a label, returns the corresponding Range
  Range restriction     : Range restriction of Tokens, Symbols, 
                          Linearizations and Records given a list of Tokens
  Record replacment     : Substitute a record for another in a list of Range 
                          records
  Argument substitution : Substitution of a Cat c to a Tok Range, where 
                          Range is the cover of c
			  Note: The argument is still a Symbol c Range
  Subsumation           : Checks if a Range record subsumes another Range 
                          record
  Record unification    : Unification of two Range records
-----------------------------------------------------------------------------}


--- Concatenation ------------------------------------------------------------


concSymbols :: [Symbol c Range] -> [[Symbol c Range]]
concSymbols (Tok rng:Tok rng':toks) = do rng'' <- concatRange rng rng'
					 concSymbols (Tok rng'':toks)
concSymbols (sym:syms)              = do syms' <- concSymbols syms
					 return (sym:syms')
concSymbols []                      = return []


concLin :: Lin c l Range -> [Lin c l Range]
concLin (Lin lbl syms) = do syms' <- concSymbols syms
			    return (Lin lbl syms')


concLinRec :: LinRec c l Range -> [LinRec c l Range]
concLinRec = mapM concLin 


--- Record transformation ----------------------------------------------------

makeRangeRec :: LinRec c l Range -> RangeRec l
makeRangeRec lins = map convLin lins
    where convLin (Lin lbl [Tok rng]) = (lbl, rng)


--- Record projection --------------------------------------------------------

projection :: Ord l => l -> RangeRec l -> [Range]
projection l rec = maybe (fail "projection") return $ lookup l rec


--- Range restriction --------------------------------------------------------

rangeRestTok :: Ord t => Input t -> t -> [Range]
rangeRestTok toks tok = do rng <- inputToken toks ? tok
			   return (makeRange rng)


rangeRestSym :: Ord t => Input t -> Symbol a t -> [Symbol a Range]
rangeRestSym toks (Tok tok) = do rng <- rangeRestTok toks tok
				 return (Tok rng)
rangeRestSym _ (Cat c)      = return (Cat c)


rangeRestLin :: Ord t => Input t -> Lin c l t -> [Lin c l Range]
rangeRestLin toks (Lin lbl syms) = do syms' <- mapM (rangeRestSym toks) syms
				      return (Lin lbl syms')


rangeRestRec :: Ord t => Input t -> LinRec c l t -> [LinRec c l Range]
rangeRestRec toks = mapM (rangeRestLin toks)


-- Record replacment ---------------------------------------------------------
-- ineffektiv!!

replaceRec :: [RangeRec l] -> Int -> RangeRec l -> [RangeRec l]
replaceRec recs i rec = (fst tup) ++ [rec] ++ (tail $ snd tup)       
    where tup = splitAt i recs


--- Argument substitution ----------------------------------------------------

substArgSymbol :: Ord l => Int -> RangeRec l -> Symbol (c, l, Int) Range 
	       -> Symbol (c, l, Int) Range
substArgSymbol i rec (Tok rng) = (Tok rng)
substArgSymbol i rec (Cat (c, l, j))
    | i==j      = maybe (Cat (c, l, j)) Tok $ lookup l rec 
    | otherwise = (Cat (c, l, j))


substArgLin :: Ord l => Int -> RangeRec l -> Lin c l Range 
	    -> Lin c l Range
substArgLin i rec (Lin lbl syms) = 
    (Lin lbl (map (substArgSymbol i rec) syms))


substArgRec :: Ord l => Int -> RangeRec l -> LinRec c l Range 
	    -> LinRec c l Range
substArgRec i rec lins = map (substArgLin i rec) lins


--- Subsumation -------------------------------------------------------------

-- "rec' subsumes rec?"
subsumes :: Ord l => RangeRec l -> RangeRec l -> Bool
subsumes rec rec' = and [elem r rec' | r <- rec]


--- Record unification -------------------------------------------------------

unifyRangeRecs :: Ord l => [RangeRec l] -> [RangeRec l] -> [[RangeRec l]]
unifyRangeRecs recs recs' = zipWithM unify recs recs'
    where unify :: Ord l => RangeRec l -> RangeRec l -> [RangeRec l]
	  unify rec [] = return rec
	  unify [] rec = return rec
	  unify rec1'@(p1@(l1, r1):rec1) rec2'@(p2@(l2, r2):rec2) 
	      = case compare l1 l2 of
		LT -> do rec3 <- unify rec1 rec2'
			 return (p1:rec3)
		GT -> do rec3 <- unify rec1' rec2
			 return (p2:rec3)
		EQ -> do guard (r1 == r2)
			 rec3 <- unify rec1 rec2
			 return (p1:rec3)
