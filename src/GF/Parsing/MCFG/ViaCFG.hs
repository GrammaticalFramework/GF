{-- Module --------------------------------------------------------------------
  Filename:    ApproxParse.hs
  Author:      Håkan Burden
  Time-stamp:  <2005-04-18, 14:56>

  Description: An agenda-driven implementation of the active algorithm 4.3.4,
               parsing through context-free approximation as described in 
	       Ljunglöf (2004)   
------------------------------------------------------------------------------}

module GF.Parsing.MCFG.ViaCFG where


-- Haskell modules
import Data.List
import Control.Monad

-- GF modules 
import ConvertMCFGtoDecoratedCFG
import qualified DecoratedCFParser as CFP
import qualified DecoratedGrammar as CFG
import Examples
import GF.OldParsing.GeneralChart
import qualified GF.OldParsing.MCFGrammar as MCFG
import MCFParser
import Nondet 
import Parser
import GF.Parsing.MCFG.Range


{-- Datatypes -----------------------------------------------------------------
Chart
Item
Key


  Item  : Four different Items are used. PreMCFG for MCFG Pre Items, Pre are 
          the Items returned by the pre-Functions and Mark are the 
	  corresponding Items for the mark-Functions. For convenience correctly
	  marked Mark Items are converted to Passive Items.
I use dottedrule for convenience to keep track of wich daughter's RangeRec to look for.
  AChart: A RedBlackMap with Items and Keys
  AKey  :  
------------------------------------------------------------------------------}

--Ev ta bort några typer av Item och bara nyckla på det som är unikt för den typen...
data Item     n c l   = PreMCFG (n, c) (RangeRec l) [RangeRec l]
		      | Pre     (n, c) (RangeRec l) [l] [RangeRec l]
		      | Mark    (n, c) (RangeRec l) (RangeRec l) [RangeRec l]
		      | Passive (n, c) (RangeRec l) (RangeRec l)
			deriving (Eq, Ord, Show)

type AChart   n c l   = ParseChart (Item n c l) (AKey n c l)

data AKey n c l       = Pr (n, c) l 
		      | Pm (n, c) l
                      | Mk (RangeRec l)
		      | Ps (RangeRec l)
                      | Useless
			deriving (Eq, Ord, Show)


{-- Parsing -------------------------------------------------------------------
  recognize:
  parse    : The Agenda consists of the Passive Items from context-free 
             approximation (as PreMCFG Items) and the Pre Items inferred by
             pre-prediction.
  keyof    : Given an Item returns an appropriate Key for the Chart
------------------------------------------------------------------------------}

recognize strategy mcfg toks = chartMember (parse strategy mcfg toks)
			       (Passive ("f", S) 
				[("s" , MCFG.Range (0, n))]
				[("p" , MCFG.Range (0, n2)), ("q", MCFG.Range (n2, n))])
			       (Ps [("s" , MCFG.Range (0, n))])
    where n  = length toks
	  n2 = n `div` 2


--parse :: (Ord n, Ord NT, Ord String, Eq t) => CFP.Strategy -> MCFG.Grammar n NT String t -> [t] 
--      -> AChart n NT String
parse strategy mcfg toks
    = buildChart keyof 
      [preCombine, markPredict, markCombine, convert]
      (makePreItems (CFP.parse strategy (CFG.pInfo (convertGrammar mcfg)) [(S, "s")] toks) ++
       (prePredict mcfg))

 
keyof :: Item n c l -> AKey n c l
keyof (PreMCFG head [(lbl, rng)] _) = Pm head lbl
keyof (Pre head _ (lbl:lbls) _)     = Pr head lbl
keyof (Mark _ _ _ (rec:recs))       = Mk rec
keyof (Passive _ rec _)             = Ps rec
keyof _                             = Useless


{-- Initializing agenda -------------------------------------------------------
  makePreItems: 
------------------------------------------------------------------------------}

makePreItems :: (Eq c, Ord i) => CFG.Grammar n (Edge (c, l)) i t -> [Item n c l]
makePreItems cfchart 
    = [ PreMCFG (fun, cat) [(lbl, MCFG.makeRange (i, j))] (symToRec beta) | 
        CFG.Rule (Edge i j (cat,lbl)) beta fun <- cfchart ]


prePredict :: (Ord n, Ord c, Ord l) => MCFG.Grammar n c l t -> [Item n c l]
prePredict mcfg = 
    [ Pre (f, nt) [] (getLables lins) (replicate (nrOfCats (head lins)) []) | 
      MCFG.Rule nt nts lins f <- mcfg ]


{-- Inference rules ---------------------------------------------------------
  prePredict :  
  preCombine :
  markPredict:
  markCombine:
  convert    :
----------------------------------------------------------------------------}

preCombine :: (Ord n, Ord c, Ord l) => ParseChart (Item n c l) (AKey n c l) 
	   -> Item n c l -> [Item n c l]
preCombine chart (Pre head rec (l:ls) recs) =
    [ Pre head (rec ++ [(l, r)]) ls recs'' |
      PreMCFG head [(l, r)] recs' <- chartLookup chart (Pm head l),
      recs'' <- solutions (unifyRangeRecs recs recs') ]
preCombine chart (PreMCFG head [(l, r)] recs) =
    [ Pre head (rec ++ [(l, r)]) ls recs'' |
      Pre head rec (l:ls) recs' <- chartLookup chart (Pr head l),
      recs'' <- solutions (unifyRangeRecs recs recs') ]
preCombine _ _ = []


markPredict :: (Ord n, Ord c, Ord l) => ParseChart (Item n c l) (AKey n c l) 
	    -> Item n c l -> [Item n c l]
markPredict _ (Pre (n, c) rec [] recs) = [Mark (n, c) rec [] recs]
markPredict _ _                        = []


markCombine :: (Ord n, Ord c, Ord l) => ParseChart (Item n c l) (AKey n c l) 
	    -> Item n c l -> [Item n c l]
markCombine chart (Mark (f, c) rec mRec (r:recs)) = 
    [ Mark (f, c) rec (mRec ++ r) recs |
      Passive _ r _ <- chartLookup chart (Ps r)]
markCombine chart (Passive _ r _) =
    [ Mark (f, c) rec (mRec++r) recs |
      Mark (f, c) rec mRec (r:recs) <- chartLookup chart (Mk r) ]
markCombine _ _ = []


convert :: (Ord n, Ord c, Ord l) => ParseChart (Item n c l) (AKey n c l) 
	-> Item n c l -> [Item n c l]
convert _ (Mark (f, c) r rec []) = [Passive (f, c) r rec]
convert _ _                      = []


{-- Help functions ----------------------------------------------------------------
  getRHS   :  
  getLables:
  symToRec :
----------------------------------------------------------------------------------}

-- FULKOD !
nrOfCats :: Eq c => MCFG.Lin c l t  -> Int
nrOfCats (MCFG.Lin l syms) = length $ nub [(c, i) | Cat (c, l, i) <- syms]


--
getLables :: LinRec c l t -> [l] 
getLables lins = [l | MCFG.Lin l syms <- lins]


--
symToRec :: Ord i => [Symbol (Edge (c, l), i) d] -> [[(l, MCFG.Range)]]
symToRec beta = map makeLblRng $ groupBy (\(_, d) (_, d') -> (d == d')) 
		$ sortBy sBd [(Edge i j (c, l) , d) | Cat (Edge i j (c, l), d)  
		    <- beta]
    where makeLblRng edges = [(l, (MCFG.makeRange (i, j))) | (Edge i j (_, l), _) 
			   <- edges]
	  sBd (_, d) (_, d') 
	      | d < d' = LT
	      | d > d' = GT
	      | otherwise = EQ
