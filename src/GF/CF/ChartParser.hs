
module ChartParser (chartParser) where

import Operations
import CF
import CFIdent
import PPrCF (prCFItem)

import OrdSet
import OrdMap2

import List (groupBy)

type Token      = CFTok
type Name       = CFFun
type Category   = CFItem
type Grammar    = ([Production], Terminal)
type Production = (Name, Category, [Category])
type Terminal   = Token -> [(Category, Maybe Name)]
type GParser    = Grammar -> Category -> [Token] -> ([ParseTree],String)
data ParseTree  = Node Name Category [ParseTree] | Leaf Token

--------------------------------------------------
-- converting between GF parsing and CFG parsing

buildParser :: GParser -> CF -> CFCat -> CFParser
buildParser gparser cf = parse
  where 
    parse = \start input -> 
            let parse2 = parse' (CFNonterm start) input in 
            ([(parse2tree t, []) | t <- fst parse2], snd parse2) 
    parse' = gparser (cf2grammar cf)

cf2grammar :: CF -> Grammar
cf2grammar cf = (productions, terminal)
  where 
    productions  = [ (name, CFNonterm cat, rhs) | 
		     (name, (cat, rhs)) <- cfRules ]
    terminal tok = [ (CFNonterm cat, Just name) |
		     (cat, name) <- cfPredef tok ] 
		   ++
		   [ (item, Nothing) |
		     item <- elems rhsItems,
		     matchCFTerm item tok ]
    cfRules  = rulesOfCF cf
    cfPredef = predefOfCF cf
    rhsItems :: Set Category
    rhsItems = union [ makeSet rhs | (_, (_, rhs)) <- cfRules ]

parse2tree :: ParseTree -> CFTree
parse2tree (Node name (CFNonterm cat) trees) = CFTree (name, (cat, trees')) 
  where
    trees' = [ parse2tree t | t@(Node _ _ _) <- trees ]   -- ignore leafs

maybeNode :: Maybe Name -> Category -> Token -> ParseTree
maybeNode (Just name) cat tok = Node name cat [Leaf tok]
maybeNode Nothing     _   tok = Leaf tok


--------------------------------------------------
-- chart parsing (bottom up kilbury-like)

type Chart   = [CState]
type CState  = Set Edge 
type Edge    = (Int, Category, [Category])
type Passive = (Int, Int, Category)

chartParser :: CF -> CFCat -> CFParser
chartParser = buildParser chartParser0

chartParser0 :: GParser
chartParser0 (productions, terminal) = cparse
  where
    emptyCats :: Set Category
    emptyCats = empties emptySet
      where 
        empties cats | cats==cats' = cats
		     | otherwise   = empties cats'
	  where cats' = makeSet [ cat | (_, cat, rhs) <- productions,
				        all (`elemSet` cats) rhs ]

    grammarMap :: Map Category [(Name, [Category])]
    grammarMap = makeMapWith (++) 
		 [ (cat, [(name,rhs)]) | (name, cat, rhs) <- productions ]

    leftCornerMap :: Map Category (Set (Category,[Category]))
    leftCornerMap = makeMapWith (<++>) [ (a, unitSet (b, bs)) | 
					 (_, b, abs) <- productions, 
					 (a : bs) <- removeNullable abs ]

    removeNullable :: [Category] -> [[Category]]
    removeNullable [] = []
    removeNullable cats@(cat:cats')
	| cat `elemSet` emptyCats = cats : removeNullable cats'
	| otherwise               = [cats]

    cparse :: Category -> [Token] -> ([ParseTree], String)
    cparse start input = case lookup (0, length input, start) edgeTrees of
			   Just trees -> (trees, "Chart:" ++++ prChart passiveEdges)
			   Nothing    -> ([],    "Chart:" ++++ prChart passiveEdges)
      where 
        finalChart :: Chart
        finalChart = map buildState initialChart

        finalChartMap :: [Map Category (Set Edge)]
	finalChartMap = map stateMap finalChart

        stateMap :: CState -> Map Category (Set Edge)
	stateMap state = makeMapWith (<++>) [ (a, unitSet (i,b,bs)) |
					      (i, b, a:bs) <- elems state ]

        initialChart :: Chart
        initialChart = emptySet : map initialState (zip [0..] input)
          where initialState (j, sym) = makeSet [ (j, cat, []) | 
						  (cat, _) <- terminal sym ]

        buildState :: CState -> CState
	buildState = limit more
	  where more (j, a, [])   = ordSet [ (j, b, bs) |
				             (b, bs) <- elems (lookupWith emptySet leftCornerMap a) ]
				    <++>
				    lookupWith emptySet (finalChartMap !! j) a
		more (j, b, a:bs) = ordSet [ (j, b, bs) |
					     a `elemSet` emptyCats ]

        passiveEdges :: [Passive]
	passiveEdges = [ (i, j, cat) |
			 (j, state) <- zip [0..] finalChart,
			 (i, cat, []) <- elems state ]
		       ++
		       [ (i, i, cat) |
			 i <- [0 .. length input],
			 cat <- elems emptyCats ]

        edgeTrees :: [ (Passive, [ParseTree]) ]
	edgeTrees = [ (edge, treesFor edge) | edge <- passiveEdges ]

        edgeTreesMap :: Map (Int, Category) [(Int, [ParseTree])]
	edgeTreesMap = makeMapWith (++) [ ((i,c), [(j,trees)]) |
					  ((i,j,c), trees) <- edgeTrees ]

        treesFor :: Passive -> [ParseTree]
	treesFor (i, j, cat) = [ Node name cat trees |
				 (name, rhs) <- lookupWith [] grammarMap cat,
				 trees <- children rhs i j ]
			       ++
			       [ maybeNode name cat tok |
				 i == j-1,
				 let tok = input !! i,
				 Just name <- [lookup cat (terminal tok)] ]

        children :: [Category] -> Int -> Int -> [[ParseTree]]
	children []     i k = [ [] | i == k ]
	children (c:cs) i k = [ tree : rest |
				i <= k,
				(j, trees) <- lookupWith [] edgeTreesMap (i,c),
				rest <- children cs j k,
				tree <- trees ]


-- AR 10/12/2002

prChart :: [Passive] -> String
prChart = unlines . map (unwords . map prOne) . positions where
  prOne (i,j,it) = show i ++ "-" ++ show j ++ "-" ++ prCFItem it
  positions = groupBy (\ (i,_,_) (j,_,_) -> i == j) 
