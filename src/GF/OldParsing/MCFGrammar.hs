----------------------------------------------------------------------
-- |
-- Module      : MCFGrammar
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:54 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Definitions of multiple context-free grammars,
-- parser information and chart conversion
-----------------------------------------------------------------------------

module GF.OldParsing.MCFGrammar 
    (-- * Type definitions
     Grammar,
     Rule(..),
     Lin(..),
     -- * Parser information
     MCFParser,
     MEdge,
     edges2chart,
     PInfo,
     pInfo,
     -- * Ranges
     Range(..),
     makeRange,
     concatRange,
     unifyRange,
     unionRange,
     failRange,
     -- * Utilities
     select,
     updateIndex
    ) where

-- gf modules:
import GF.Data.SortedList
import GF.Data.Assoc
-- parser modules:
import GF.OldParsing.Utilities
import GF.Printing.PrintParser



select :: [a] -> [(a, [a])]
select [] = []
select (x:xs) = (x,xs) : [ (y,x:ys) | (y,ys) <- select xs ]

updateIndex :: Functor f => Int -> [a] -> (a -> f a) -> f [a]
updateIndex 0 (a:as) f = fmap (:as) $ f a
updateIndex n (a:as) f = fmap (a:)  $ updateIndex (n-1) as f
updateIndex _ _ _ = error "ParserUtils.updateIndex: Index out of range"


------------------------------------------------------------
-- grammar types

type Grammar n c l t = [Rule n c l t]
data Rule    n c l t = Rule c [c] [Lin c l t] n
		       deriving (Eq, Ord, Show)
data Lin       c l t = Lin l [Symbol (c, l, Int) t]
		       deriving (Eq, Ord, Show)

-- variants is simply several linearizations with the same label


------------------------------------------------------------
-- parser information

type PInfo n c l t = Grammar n c l t

pInfo :: Grammar n c l t -> PInfo n c l t
pInfo = id

type MCFParser n c l t = PInfo n c l t -> [c] -> Input t -> ParseChart n (MEdge c l)

type MEdge c l = (c, [(l, Range)])

edges2chart :: (Ord n, Ord c, Ord l) =>
	       [(n, MEdge c l, [MEdge c l])] -> ParseChart n (MEdge c l)
edges2chart edges = fmap groupPairs $ accumAssoc id $
		    [ (medge, (name, medges)) | (name, medge, medges) <- edges ]


------------------------------------------------------------
-- ranges as sets of int-pairs

newtype Range = Rng (SList (Int, Int)) deriving (Eq, Ord, Show)

makeRange :: SList (Int, Int) -> Range
makeRange rho = Rng rho

concatRange :: Range -> Range -> Range
concatRange (Rng rho) (Rng rho') = Rng $ nubsort [ (i,k) | (i,j) <- rho, (j',k) <- rho', j==j' ]

unifyRange :: Range -> Range -> Range
unifyRange  (Rng rho) (Rng rho') = Rng $ rho <**> rho'

unionRange :: Range -> Range -> Range
unionRange  (Rng rho) (Rng rho') = Rng $ rho <++> rho'

failRange :: Range
failRange = Rng []


------------------------------------------------------------
-- pretty-printing

instance (Print n, Print c, Print l, Print t) => Print (Rule n c l t) where
    prt (Rule cat args record name) 
	= prt name ++ ". " ++ prt cat ++ " -> " ++ prtSep " " args ++ "\n" ++ prt record
    prtList = concatMap prt

instance (Print c, Print l, Print t) => Print (Lin c l t) where
    prt (Lin lbl lin) = prt lbl ++ " = " ++ prtSep " " (map (symbol prArg (show.prt)) lin)
	where prArg (cat, lbl, arg) = prt cat ++ "@" ++ prt arg ++ "." ++ prt lbl
    prtList = prtBeforeAfter "\t" "\n" 

instance Print Range where
    prt (Rng rho) = "(" ++ prtSep "|" [ show i ++ "-" ++ show j | (i,j) <- rho ] ++ ")"

{-
------------------------------------------------------------
-- items & forests

data Item    n c l   = Item n (MEdge c l) [[MEdge c l]]
		       deriving (Eq, Ord, Show)
type MEdge     c l   = (c, [Edge l])

items2forests :: (Ord n, Ord c, Ord l) => Edge ((c, l) -> Bool) -> [Item n c l] -> [ParseForest n]

----------

items2forests (Edge i0 k0 startCat) items 
    = concatMap edge2forests $ filter checkEdge $ aElems chart
    where edge2forests (cat, []) = [FMeta]
	  edge2forests edge = filter checkForest $ map item2forest (chart ? edge)

	  item2forest (Item name _ children) = FNode name [ forests | edges <- children,
							    forests <- mapM edge2forests edges ]

	  checkEdge (cat, [Edge i k lbl]) = i == i0 && k == k0 && startCat (cat, lbl)
	  checkEdge _ = False

          checkForest (FNode _ children) = not (null children)

          chart = accumAssoc id [ (edge, item) | item@(Item _ edge _) <- items ]
-}


------------------------------------------------------------
-- grammar checking
{-
--checkGrammar :: (Ord c, Ord l, Print n, Print c, Print l, Print t) => Grammar n c l t -> [String]

checkGrammar rules
    = do rule@(Rule cat rhs record name) <- rules
	 if null record 
            then [ "empty linearization record in rule: " ++ prt rule ]
	    else [ "category does not exist: " ++ prt rcat ++ "\n" ++
		   "  - in rule: " ++ prt rule |
		   rcat <- rhs, rcat `notElem` lhsCats ] ++
 	         do Lin _ lin <- record  
		    Cat (arg, albl) <- lin
		    if arg<0 || arg>=length rhs 
		       then [ "argument index out of range: " ++ show arg ++ "/" ++ prt albl ++ "\n" ++
			      "  - in rule: " ++ prt rule ]
		       else [ "label does not exist: " ++ prt albl ++ "\n" ++
			      "  - from rule: " ++ prt rule ++
			      "  - in rule: " ++ prt arule |
			      arule@(Rule _ acat _ arecord) <- rules,
			      acat == rhs !! arg,
			      albl `notElem` [ lbl | Lin lbl _ <- arecord ] ]
    where lhsCats = nubsort [ cat | Rule _ cat _ _ <- rules ]
-}





{-----
------------------------------------------------------------
-- simplifications 

splitMRule :: (Ord n, Ord c, Ord l, Ord t) => Grammar n c l t -> Rule n c l t -> [Rule n c l t]
splitMRule rules (Rule name cat args record) = nubsort [ (Rule name cat args splitrec) |
							 (cat', lbls) <- rhsCats, cat == cat',
							 let splitrec = [ lin | lin@(Lin lbl _) <- record, lbl `elem` lbls ] ]
    where rhsCats = limit rhsC lhsCats
	  lhsCats = nubsort [ (cat, [lbl]) | Rule _ cat _ record <- rules, Lin lbl _ <- record ]
	  rhsC (cat, lbls) = nubsort [ (rcat, rlbls) |
				       Rule _ cat' rhs lins <- rules, cat == cat',
				       (arg, rcat) <- zip [0..] rhs,
				       let rlbls = nubsort [ rlbl | Lin lbl lin <- lins, lbl `elem` lbls,
							     Cat (arg', rlbl) <- lin, arg == arg' ],
				       not $ null rlbls
				     ]


----}



