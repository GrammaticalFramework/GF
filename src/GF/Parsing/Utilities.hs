----------------------------------------------------------------------
-- |
-- Module      : Parsing.Utilities
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/29 11:17:54 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- Basic type declarations and functions to be used when parsing
-----------------------------------------------------------------------------


module GF.Parsing.Utilities 
    ( -- * Symbols
      Symbol(..), symbol, mapSymbol,
      -- * Edges
      Edge(..),
      -- * Parser input
      Input(..), makeInput, input, inputMany,
      -- * charts, parse forests & trees
      ParseChart, ParseForest(..), ParseTree(..),
      chart2forests, forest2trees
    ) where

-- haskell modules:
import Monad
import Array
-- gf modules:
import GF.Data.SortedList
import GF.Data.Assoc
-- parsing modules:
import GF.Printing.PrintParser

------------------------------------------------------------
-- symbols

data Symbol c t = Cat c | Tok t
		  deriving (Eq, Ord, Show)

symbol    :: (c -> a) -> (t -> a) -> Symbol c t -> a
mapSymbol :: (c -> d) -> (t -> u) -> Symbol c t -> Symbol d u

----------

symbol fc ft (Cat cat) = fc cat
symbol fc ft (Tok tok) = ft tok

mapSymbol fc ft = symbol (Cat . fc) (Tok . ft)


------------------------------------------------------------
-- edges

data Edge s = Edge Int Int s
	      deriving (Eq, Ord, Show)

instance Functor Edge where
    fmap f (Edge i j s) = Edge i j (f s)


------------------------------------------------------------
-- parser input 

data Input t = MkInput { inputEdges  :: [Edge t],
			 inputBounds :: (Int, Int),
			 inputFrom   :: Array Int (Assoc t [Int]),
			 inputTo     :: Array Int (Assoc t [Int]),
			 inputToken  :: Assoc t [(Int, Int)]
		       }

makeInput :: Ord t => [Edge t] -> Input t
input     :: Ord t =>  [t]     -> Input t
inputMany :: Ord t => [[t]]    -> Input t

----------

makeInput inEdges  | null inEdges = input []
		   | otherwise    = MkInput inEdges inBounds inFrom inTo inToken
    where inBounds = foldr1 minmax [ (i, j) | Edge i j _ <- inEdges ]
	      where minmax (a, b) (a', b') = (min a a', max b b')
	  inFrom   = fmap (accumAssoc id) $ accumArray (<++>) [] inBounds $
		     [ (i, [(tok, j)]) | Edge i j tok <- inEdges ]
	  inTo     = fmap (accumAssoc id) $ accumArray (<++>) [] inBounds
		     [ (j, [(tok, i)]) | Edge i j tok <- inEdges ]
	  inToken  = accumAssoc id [ (tok, (i, j)) | Edge i j tok <- inEdges ]

input toks         = MkInput inEdges inBounds inFrom inTo inToken
    where inEdges  = zipWith3 Edge [0..] [1..] toks
	  inBounds = (0, length toks)
	  inFrom   = listArray inBounds $
		     [ listAssoc [(tok, [j])] | (tok, j) <- zip toks [1..] ] ++ [ listAssoc [] ]
	  inTo     = listArray inBounds $
		     [ listAssoc [] ] ++ [ listAssoc [(tok, [i])] | (tok, i) <- zip toks [0..] ]
	  inToken  = accumAssoc id [ (tok, (i, j)) | Edge i j tok <- inEdges ]

inputMany toks     = MkInput inEdges inBounds inFrom inTo inToken
    where inEdges  = [ Edge i j t | (i, j, ts) <- zip3 [0..] [1..] toks, t <- ts ]
	  inBounds = (0, length toks)
	  inFrom   = listArray inBounds $
		     [ listAssoc [ (t, [j]) | t <- nubsort ts ] | (ts, j) <- zip toks [1..] ]
		     ++ [ listAssoc [] ]
	  inTo     = listArray inBounds $
		     [ listAssoc [] ] ++ 
		     [ listAssoc [ (t, [i]) | t <- nubsort ts ] | (ts, i) <- zip toks [0..] ]
	  inToken  = accumAssoc id [ (tok, (i, j)) | Edge i j tok <- inEdges ]


------------------------------------------------------------
-- charts, parse forests & trees

type ParseChart n e = Assoc e [(n, [[e]])]

data ParseForest n = FNode n [[ParseForest n]] | FMeta 
		     deriving (Eq, Ord, Show)

data ParseTree n = TNode n [ParseTree n] | TMeta 
		   deriving (Eq, Ord, Show)

chart2forests :: Ord e => ParseChart n e -> (e -> Bool) -> e -> [ParseForest n]

--filterCoercions :: (n -> Bool) -> ParseForest n -> [ParseForest n]

forest2trees :: ParseForest n -> [ParseTree n]

instance Functor ParseTree where
    fmap f (TNode n trees) = TNode (f n) $ map (fmap f) trees
    fmap f (TMeta) = TMeta 
	     
instance Functor ParseForest where
    fmap f (FNode n forests) = FNode (f n) $ map (map (fmap f)) forests
    fmap f (FMeta) = FMeta 

----------

chart2forests chart isMeta = edge2forests
    where item2forest (name, children) = FNode name $
					 do edges <- children
					    mapM edge2forests edges 
          edge2forests edge 
	      | isMeta     edge = [FMeta]
	      | otherwise       = filter checkForest $ map item2forest $ chart ? edge
	  checkForest (FNode _ children) = not (null children)

-- filterCoercions _ (FMeta) = [FMeta]
-- filterCoercions isCoercion (FNode s forests) 
--     | isCoercion s = do [forest] <- forests ; filterCoercions isCoercion forest
--     | otherwise    = FNode s $ do children <- forests ; mapM (filterCoercions isCoercion)

forest2trees (FNode s forests) = map (TNode s) $ forests >>= mapM forest2trees
forest2trees (FMeta) = [TMeta]



------------------------------------------------------------
-- pretty-printing

instance (Print c, Print t) => Print (Symbol c t) where
    prt = symbol prt (simpleShow.prt)
    prtList = prtSep " "

simpleShow :: String -> String
simpleShow s = "\"" ++ concatMap mkEsc s ++ "\""
    where
    mkEsc :: Char -> String
    mkEsc c = case c of
		     _ | elem c "\\\"" -> '\\' : [c]
		     '\n' -> "\\n"
		     '\t' -> "\\t"
		     _ -> [c]

instance (Print s) => Print (Edge s) where
    prt (Edge i j s) = "[" ++ show i ++ "-" ++ show j ++ ": " ++ prt s ++ "]"
    prtList = prtSep ""

instance (Print s) => Print (ParseTree s) where
    prt (TNode s trees) = prt s ++ "^{" ++ prtSep " " trees ++ "}"
    prt (TMeta) = "?"
    prtList = prtAfter "\n"

instance (Print s) => Print (ParseForest s) where
    prt (FNode s forests) = prt s ++ "^{" ++ prtSep " | " (map (prtSep " ") forests) ++ "}"
    prt (FMeta) = "?"
    prtList = prtAfter "\n"


