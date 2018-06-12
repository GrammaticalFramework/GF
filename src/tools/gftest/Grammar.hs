{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}

module Grammar
    ( Grammar(..), readGrammar
    , Tree, top, Symbol(..), showTree
    , Cat, ConcrCat(..)
    , Lang, Name

    -- Categories, coercions
    , ccats, ccatOf, arity
    , coerces, uncoerce
    , uncoerceAbsCat, mkCC

    -- Testing and comparison
    , testTree, testFun
    , compareTree, Comparison(..)
    , treesUsingFun

    -- Contexts
    , contextsFor, dummyHole

    -- FEAT
    , featIth, featCard

    -- Fields
    , forgets, reachableFieldsFromTop
    , emptyFields, equalFields, fieldNames

    -- misc
    , showConcrFun, subTree, flatten
    , diffCats, hasConcrString
) where

import Data.Either ( lefts )
import Data.List
import qualified Data.Map as M
import Data.Maybe
import Data.Char
import qualified Data.Set as S
import qualified Mu
import qualified FMap as F
import qualified Data.Tree as T
import EqRel

import GHC.Exts ( the )
import Debug.Trace

import qualified PGF2
import qualified PGF2.Internal as I

--------------------------------------------------------------------------------
-- grammar types

-- name

type Name = String

-- concrete category

type Cat = PGF2.Cat -- i.e. String

data ConcrCat = CC (Maybe Cat) I.FId -- i.e. Int
  deriving ( Eq )

instance Show ConcrCat where
  show (CC (Just cat) fid) = cat ++ "_" ++ show fid 
  show (CC Nothing    fid) = "_" ++ show fid 

instance Ord ConcrCat where
  (CC _ fid1) `compare` (CC _ fid2) = fid1 `compare` fid2

ccatOf :: Tree -> ConcrCat
ccatOf (App tp _) = snd (ctyp tp)

-- tree

data RoseTree a
  = App { top :: a, args :: [RoseTree a] }
 deriving ( Eq, Ord )

-- from http://hackage.haskell.org/package/containers-0.5.11.0/docs/src/Data.Tree.html#foldTree
foldTree :: (a -> [b] -> b) -> RoseTree a -> b
foldTree f = go where
    go (App x ts) = f x (map go ts)

flatten :: RoseTree a -> [a]
flatten (App tp as) = tp : concatMap flatten as

type Tree = RoseTree Symbol
type AmbTree = RoseTree [Symbol] -- used as an intermediate category for parsing

instance Show Tree where
  show = showTree

showTree :: Tree -> String
showTree (App a []) = show a
showTree (App f xs) = unwords (show f : map showTreeArg xs)
  where showTreeArg (App a []) = show a
        showTreeArg t = "(" ++ showTree t ++ ")"

subTree :: Symbol -> Tree -> Maybe Tree
subTree symb t@(App tp tr) 
  | symb==tp  = Just t
  | otherwise = listToMaybe $ mapMaybe (subTree symb) tr

-- symbol

type SeqId = Int

data Symbol
  = Symbol
  { name :: Name
  , seqs :: [SeqId]
  , typ  :: ([Cat], Cat)
  , ctyp :: ([ConcrCat],ConcrCat)
  }
 deriving ( Eq, Ord )

instance Show Symbol where
  show = name

arity :: Symbol -> Int
arity = length . fst . ctyp

hole :: ConcrCat -> Symbol
hole c = Symbol (show c) [] ([], "") ([],c)

showConcrFun :: Grammar -> Symbol -> String
showConcrFun gr detCN = show detCN ++ " : " ++ args ++ show np_209
 where
  (dets_cns,np_209) = ctyp detCN
  args = concatMap (\x -> show x ++ " → ") dets_cns

-- grammar

type Lang = String

data Grammar 
  = Grammar
  {
    concrLang    :: Lang
  , parse        :: String -> [Tree]
  , readTree     :: String -> Tree
  , linearize    :: Tree -> String
  , tabularLin   :: Tree ->  [(String,String)]
  , concrCats    :: [(PGF2.Cat,I.FId,I.FId,[String])]
  , coercions    :: [(ConcrCat,ConcrCat)]
  , contextsTab  :: M.Map ConcrCat (M.Map ConcrCat [Tree -> Tree])
  , startCat     :: Cat
  , symbols      :: [Symbol]
  , lookupSymbol :: String -> [Symbol]
  , functionsByCat :: Cat -> [Symbol]
  , concrSeqs    :: SeqId -> [Either String (Int,Int)] 
  , feat         :: FEAT
  , nonEmptyCats :: S.Set ConcrCat
  , allCats      :: [ConcrCat]
  }

fieldNames :: Grammar -> Cat -> [String]
fieldNames gr c = map fst . tabularLin gr $ t
 where
  t:_ = [ t
        | f <- functionsByCat gr c
        , let (_,c') = ctyp f
        , c' `S.member` nonEmptyCats gr
        , t <- featAll gr c'
        ]


--------------------------------------------------------------------------------
-- grammar

readGrammar :: Lang -> FilePath -> IO Grammar
readGrammar lang file =
  do pgf <- PGF2.readPGF file
     return (toGrammar pgf lang)

toGrammar :: PGF2.PGF -> Lang -> Grammar
toGrammar pgf langName =
  let gr =
        Grammar
        { concrLang = lname

        , parse = \s ->
            case PGF2.parse lang (PGF2.startCat pgf) s of 
              PGF2.ParseOk es_fs -> map (mkTree gr.fst) es_fs
              PGF2.ParseFailed i s -> error s
              PGF2.ParseIncomplete -> error "Incomplete parse"

        , readTree = \s ->
            case PGF2.readExpr s of
              Just t  -> mkTree gr t
              Nothing -> error "readTree: no parse"

        , linearize = \t ->
            PGF2.linearize lang (mkExpr t)

        , tabularLin = \t ->
            PGF2.tabularLinearize lang (mkExpr t)

        , startCat =
            mkCat (PGF2.startCat pgf)

        , concrCats = 
            I.concrCategories lang

        , symbols =
            [ Symbol { 
              name = nm,
              seqs = sqs,
              ctyp = (argsCC, goalCC),
              typ = (map (uncoerceAbsCat gr) argsCC, goalcat)
            }
            | (goalcat,bg,end,_) <- I.concrCategories lang
            , goalfid <- [bg..end] 
            , I.PApply funId pargs <- I.concrProductions lang goalfid
            , let goalCC = CC (Just goalcat) goalfid 
            , let argsCC = [ mkCC argfid | I.PArg _ argfid <- pargs ]
            , let (nm,sqs) = I.concrFunction lang funId ]

        , lookupSymbol = lookupAll (symb2table `map` symbols gr)

        , functionsByCat = \c ->
            [ symb
            | symb <- symbols gr
            , snd (typ symb) == c
            , snd (ctyp symb) `elem` nonEmptyCats gr ]

        , coercions =
            [ ( mkCC cfid, CC Nothing afid )
            | afid <- [0..I.concrTotalCats lang]
            , I.PCoerce cfid <- I.concrProductions lang afid ]
        
        , contextsTab =
            M.fromList
            [ (top, M.fromList (contexts gr top))
            | top <- allCats gr ]
         
        , concrSeqs = 
            map cseq2Either . I.concrSequence lang

        , feat =
            mkFEAT gr

        , allCats = S.toList $ S.fromList $
            [ a | f <- symbols gr, let (args,goal) = ctyp f
            , a <- goal:args
            ] ++
            [ c | (cat,coe) <- coercions gr
            , c <- [coe,cat]
            ]  
        , nonEmptyCats = S.fromList
            [ c
            | let -- all functions, organized by result type
                  funs = M.fromListWith (++) $
                    [ (cat,[Right f])
                    | f <- symbols gr
                    , let (_,cat) = ctyp f
                    ] ++
                    [ (coe,[Left cat])
                    | (cat,coe) <- coercions gr
                    ]
            
                  -- all categories, with their dependencies
                  defs =
                    [ if or [ arity f == 0 | Right f <- fs ]
                        then (c, [], \_ -> True) -- has a word
                        else (c, ys, h)          -- no word
                    | c <- allCats gr
                    , let -- relevant functions for c
                          fs = fromMaybe [] (M.lookup c funs)
                    
                          -- categories we depend on
                          ys = S.toList $ S.fromList $
                               [ cat | Right f <- fs, cat <- fst (ctyp f) ] ++
                               [ cat | Left cat <- fs ]
                    
                          -- compute if we're empty, given the emptiness of others
                          h bs = or $
                            [ and [ tab M.! a | a <- args ]
                            | Right f <- fs
                            , let (args,_) = ctyp f
                            ] ++
                            [ tab M.! cat
                            | Left cat <- fs
                            ]
                           where
                            tab = M.fromList (ys `zip` bs)
                    ]
            , (c,True) <- allCats gr `zip` Mu.mu False defs (allCats gr)
            ]



        }
   in gr
 where
  -- language
  (lang,lname) = case M.lookup langName (PGF2.languages pgf) of
           Just la -> (la,langName)
           Nothing -> let (defName,defGr) = head $ M.assocs $ PGF2.languages pgf
                          msg = "no grammar found with name " ++ langName ++ 
                                ", using " ++ defName
                      in trace msg (defGr,defName)

  -- categories and expressions
  mkCat tp = cat where (_, cat, _) = PGF2.unType tp

  mkExpr (App n []) | not (null s) && all isDigit s =
    PGF2.mkInt (read s)
   where
    s = show n

  mkExpr (App f xs) =
    PGF2.mkApp (name f) [ mkExpr x | x <- xs ] 
     
  mkCC fid = CC ccat fid 
   where ccat = case [ cat | (cat,bg,end,_) <- I.concrCategories lang
                           , fid `elem` [bg..end] ] of 
                  [] -> Nothing -- means it's coercion
                  xs -> Just $ the xs

  -- misc
  symb2table s = (s, name s)

  cseq2Either (I.SymKS tok)  = Left tok
  cseq2Either (I.SymCat x y) = Right (x,y)
  cseq2Either x              = Left (show x)


mkCC gr fid = CC ccat fid
 where ccat = case [ cat | (cat,bg,end,_) <- concrCats gr
                         , fid `elem` [bg..end] ] of
                [] -> Nothing -- means it's coercion
                xs -> Just $ the xs

-- parsing and reading trees
mkTree :: Grammar -> PGF2.Expr -> Tree
mkTree gr = disambTree . ambTree

 where
  ambTree t = -- :: PGF2.Expr -> AmbTree
    case PGF2.unApp t of
      Just (f,xs) -> App (lookupSymbol gr f) [ ambTree x | x <- xs ]
      Nothing     -> error (PGF2.showExpr [] t)

  disambTree at =  -- :: AmbTree -> Tree
    case foldTree reduce at of
      App [x] ts -> App x [ disambTree t | t <- ts ]
      App _  _ts -> error "mkTree: invalid tree"
 
  reduce fs as =  -- :: [Symbol] -> [AmbTree] -> AmbTree
    let red = [ symbol | symbol <- fs
              , let argTypes =
                     uncoerce gr `map` fst (ctyp symbol)
              , let goalTypes =
                     uncoerce gr `map` [ snd (ctyp s) | App [s] _ <- as ]
              -- there should be only one symbol in (still ambiguous) fs
              -- whose argument type matches its (already unambiguous) subtrees
              , and [ intersect a r /= []
                    | (a,r) <- zip argTypes goalTypes ] ]
     in case red of
         [x] -> App [x] as
         _   -> App fs  as

-- categories and coercions
ccats :: Grammar -> Cat -> [ConcrCat]
ccats gr utt = [ cc
               | cc@(CC (Just cat) _) <- S.toList (nonEmptyCats gr)
               , cat == utt ]

uncoerceAbsCat :: Grammar -> ConcrCat -> Cat
uncoerceAbsCat gr c = case c of
  CC (Just cat) _ -> cat
  CC Nothing    _ -> the [ uncoerceAbsCat gr x | x <- uncoerce gr c ]

uncoerce :: Grammar -> ConcrCat -> [ConcrCat]
uncoerce gr c = case c of
  CC Nothing _ -> lookupAll (coercions gr) c
  _            -> [c]

coerces :: Grammar -> ConcrCat -> ConcrCat -> Bool
coerces gr coe cat = (cat,coe) `elem` coercions gr

lookupAll :: (Eq a) => [(b,a)] -> a -> [b]
lookupAll kvs key = [ v | (v,k) <- kvs, k==key ]

singleton [x] = True
singleton xs  = False

--------------------------------------------------------------------------------
-- compute categories reachable from S

reachableCatsFromTop :: Grammar -> ConcrCat -> [ConcrCat]
reachableCatsFromTop gr top = [ c | (c,True) <- cs `zip` rs ]
 where
  rs = Mu.mu False defs cs
  cs = S.toList (nonEmptyCats gr)
  
  defs =
    [ if c == top
        then (c, [], \_ -> True)
        else (c, ys, or)
    | c <- cs
    , let ys = S.toList $ S.fromList $
               [ b
               | f <- symbols gr
               , let (as,b) = ctyp f
               , all (`S.member` nonEmptyCats gr) as
               , c `elem` as
               ] ++
               [ b
               | (a,b) <- coercions gr
               , a == c
               , b `S.member` nonEmptyCats gr
               ]
    ]

reachableFieldsFromTop :: Grammar -> ConcrCat -> [(ConcrCat,S.Set Int)]
reachableFieldsFromTop gr top = cs `zip` rs
 where
  rs = Mu.mu S.empty defs cs
  cs = S.toList (nonEmptyCats gr)

  defs =
    [ if c == top
        then (c, [], \_ -> S.fromList [0]) -- this assumes the top only has one field
        else (c, ys, h)
    | c <- cs
    , let fs = [ Right (f,k)
               | f <- symbols gr
               , let (as,_) = ctyp f
               , all (`S.member` nonEmptyCats gr) as
               , (a,k) <- as `zip` [0..]
               , c == a
               ] ++
               [ Left b
               | (a,b) <- coercions gr
               , a == c
               , b `S.member` nonEmptyCats gr
               ]
          
          ys = S.toList $ S.fromList
               [ case f of
                   Right (f,_) -> snd (ctyp f)
                   Left b      -> b
               | f <- fs
               ]
          
          h rs = S.unions
                 [ case f of
                     Right (f,k) -> apply (f,k) (args M.! snd (ctyp f))
                     Left b      -> args M.! b
                 | f <- fs
                 ]
           where
            args = M.fromList (ys `zip` rs)
    ]

  apply (f,k) r =
    S.fromList
    [ j
    | (sq,i) <- seqs f `zip` [0..]
    , i `S.member` r
    , Right (k',j) <- concrSeqs gr sq
    , k' == k
    ]

--------------------------------------------------------------------------------
-- analyzing contexts

equalFields :: Grammar -> [(ConcrCat,EqRel Int)]
equalFields gr = cs `zip` eqrels
 where
  eqrels = Mu.mu Top defs cs
  cs     = S.toList (nonEmptyCats gr)
  
  defs =
    [ (c, depcats, h)
    | c <- cs
      -- fs = everything that has c as a goal category
      -- there's two possibilities:
    , let fs = -- 1) c is not a coercion: functions can have c as a goal category
               [ Right f
               | f <- symbols gr
               , all (`S.member` nonEmptyCats gr) (fst (ctyp f))
               , c == snd (ctyp f)
               ] ++
               -- 2) c is a coercion: here's a list of (nonempty) categories c uncoerces into
               [ Left cat
               | (cat,coe) <- coercions gr
               , coe == c
               , cat `S.member` nonEmptyCats gr
               ]

          -- all the categories c depends on
          depcats = S.toList $ S.fromList $ concat
               [ case f of
                   Right f  -> fst (ctyp f) -- 1) if c is not a coercion: 
                                            -- all arg cats of the functions with c as goal cat
                   Left cat -> [cat] -- 2) if c is a coercion: just the cats that it uncoerces into
               | f <- fs
               ]

          -- Function to give to mu:
          -- computes the equivalence relation, given the eq.rels of its arguments
          h rs = foldr (/\) Top $ [ apply f eqs
                  | Right f <- fs
                  , let eqs = map (args M.!) (fst $ ctyp f)
                  ] ++
                  [ args M.! cat
                  | Left cat <- fs
                  ]
           where
            args = M.fromList (depcats `zip` rs)
    ]
   where
    apply f eqs =
      basic [ concatMap lin (concrSeqs gr sq)
            | sq <- seqs f
            ]
      where 
        lin (Left str)    = [ str | not (null str) ]
        lin (Right (i,j)) = [ show i ++ "#" ++ show (rep (eqs !! i) j) ]

contextsFor :: Grammar -> ConcrCat -> ConcrCat -> [Tree -> Tree]
contextsFor gr top hole = [] `fromMaybe` M.lookup hole (contextsTab gr M.! top)

contexts :: Grammar -> ConcrCat -> [(ConcrCat,[Tree -> Tree])]
contexts gr top =
  [ (c, map (path2context . reverse . snd) (F.toList paths))
  | (c, paths) <- cs `zip` pathss
  ]
 where
  pathss = Mu.muDiff F.nil F.isNil dif uni defs cs
  cs     = S.toList (nonEmptyCats gr)
  
  -- all symbols with at least one argument, and only good arguments
  goodSyms =
    [ f
    | f <- symbols gr
    , arity f >= 1
    , snd (ctyp f) `S.member` nonEmptyCats gr
    , all (`S.member` nonEmptyCats gr) (fst (ctyp f))
    ]
 
  -- definitions table for fixpoint iteration
  fm1 `dif` fm2 =
    [ d | d@(xs,_) <- F.toList fm1, not (fm2 `F.covers` xs) ] `ins` F.nil
  
  fm1 `uni` fm2 =
    F.toList fm1 `ins` fm2
  
  paths `ins` fm =
       foldl collect fm
     . map snd
     . sort
     $ [ (size p, p) | p <- paths ]
   where
    collect fm (str,p)
      | fm `F.covers` str = fm
      | otherwise         = F.add str p fm

    size (_,p) =
      sum [ if i == j then 1 else smallest gr t
          | (f,i) <- p
          , let (ts,_) = ctyp f
          , (t,j) <- ts `zip` [0..]
          ]

  defs =
    [ if c == top
        then (c, [], \_ -> F.unit [0] [])
        else (c, ys, h)
    | c <- cs

      -- everything that uses c in one of the two ways:
    , let fs = -- 1) Functions that take c as the kth argument
               [ Right (f,k)
               | f <- goodSyms
               , (t,k) <- fst (ctyp f) `zip` [0..]
               , t == c
               ] ++
               -- 2) coercions that uncoerce to c
               [ Left coe
               | (cat,coe) <- coercions gr
               , cat == c
               , coe `S.member` nonEmptyCats gr
               ]
          
          -- goal categories for c
          ys = S.toList $ S.fromList $
               [ case f of
                   Right (f,_) -> snd (ctyp f) -- 1) goal category of the function that uses c
                   Left coe    -> coe          -- 2)    (category of the) coercion that uncoerces to c
               | f <- fs
               ]
               
          -- function to give to Mu
          h ps = ([ (apply (f,k) str, (f,k):fis)
                  | Right (f,k) <- fs 
                  , (str,fis) <- args M.! snd (ctyp f)
                  ] ++
                  [ q
                  | Left a <- fs
                  , q <- args M.! a
                  ]) `ins` F.nil
           where
            args = M.fromList (ys `zip` map F.toList ps)
    ]
   where                      -- fields of B that make it to the top
    apply :: (Symbol, Int) -> [Int] -> [Int] -- fields of A that make it to the top
    apply (f,k) is =
      S.toList $ S.fromList $
      [ y
      | (sq,i) <- seqs f `zip` [0..]
      , i `elem` is 
      , Right (x,y) <- concrSeqs gr sq
      , x == k
      ]
  
  path2context []          x = x
  path2context ((f,i):fis) x =
    App f
    [ if j == i
        then path2context fis x
        else head (featAll gr t)
    | (t,j) <- fst (ctyp f) `zip` [0..]
    ]

forgets :: Grammar -> ConcrCat -> [(ConcrCat,[Tree])]
forgets gr top =
  filter (not . null . snd)
  [ (c, [ path2context (reverse p) (head (featAll gr c))
        | (is,p) <- F.toList paths
        , length is == fields c -- all indices forgotten
        ]
    )
  | (c, paths) <- cs `zip` pathss
  ]
 where
  pathss = Mu.muDiff F.nil F.isNil dif uni defs cs
  cs     = S.toList (nonEmptyCats gr)
  
  -- all symbols with at least one argument, and only good arguments
  goodSyms =
    [ f
    | f <- symbols gr
    , arity f >= 1
    , snd (ctyp f) `S.member` nonEmptyCats gr
    , all (`S.member` nonEmptyCats gr) (fst (ctyp f))
    ]
 
  fieldsTab =
    M.fromList $
    [ (b, length (seqs f))
    | f <- symbols gr
    , let (as,b) = ctyp f
    ]
 
  fields a =
    head $
    [ n
    | c <- a : [ b | (b,a') <- coercions gr, a' == a ]
    , Just n <- [M.lookup c fieldsTab]
    ] ++
    error (show a ++ " has no function creating it")
 
  -- definitions table for fixpoint iteration
  fm1 `dif` fm2 =
    [ d | d@(xs,_) <- F.toList fm1, not (fm2 `F.covers` xs) ] `ins` F.nil
  
  fm1 `uni` fm2 =
    F.toList fm1 `ins` fm2
  
  paths `ins` fm =
       foldl collect fm
     . map snd
     . sort
     $ [ (size p, p) | p <- paths ]
   where
    collect fm (str,p)
      | fm `F.covers` str = fm
      | otherwise         = F.add str p fm

    size (_,p) =
      sum [ if i == j then 1 else smallest gr t
          | (f,i) <- p
          , let (ts,_) = ctyp f
          , (t,j) <- ts `zip` [0..]
          ]

  defs =
    [ if c == top
        then (c, [], \_ -> F.unit [] [])
        else (c, ys, h)
    | c <- cs

      -- everything that uses c in one of the two ways:
    , let fs = -- 1) Functions that take c as the kth argument
               [ Right (f,k)
               | f <- goodSyms
               , (t,k) <- fst (ctyp f) `zip` [0..]
               , t == c
               ] ++
               -- 2) coercions that uncoerce to c
               [ Left coe
               | (cat,coe) <- coercions gr
               , cat == c
               , coe `S.member` nonEmptyCats gr
               ]
          
          -- goal categories for c
          ys = S.toList $ S.fromList $
               [ case f of
                   Right (f,_) -> snd (ctyp f)
                   Left coe    -> coe
               | f <- fs
               ]

          h ps = ([ (apply (f,k) str, (f,k):fis)
                  | Right (f,k) <- fs 
                  , (str,fis) <- args M.! snd (ctyp f)
                  , length str < fields c
                  ] ++
                  [ q
                  | Left a <- fs
                  , q@(str,_) <- args M.! a
                  , length str < fields c
                  ]) `ins` F.nil
           where
            args = M.fromList (ys `zip` map F.toList ps)
    ]
   where
    apply :: (Symbol, Int) -> [Int] -> [Int]
    apply (f,k) is =
      [ y
      | y <- [0..fields (fst (ctyp f) !! k)-1]
      , y `S.notMember` used
      ]
     where
      used = S.fromList $
             [ y
             | (sq,i) <- seqs f `zip` [0..]
             , i `notElem` is 
             , Right (x,y) <- concrSeqs gr sq
             , x == k
             ]
  
  path2context []          x = x
  path2context ((f,i):fis) x =
    App f
    [ if j == i
        then path2context fis x
        else head (featAll gr t)
    | (t,j) <- fst (ctyp f) `zip` [0..]
    ]

--traceLength s xs = trace (s ++ ":" ++ show (length xs)) xs

emptyFields :: Grammar -> [(ConcrCat,S.Set Int)]
emptyFields gr = cs `zip` fields
 where
  cs     = S.toList (nonEmptyCats gr)
  fields = Mu.mu (S.fromList [0..99999]) defs cs 

  defs =
    [ (c, ys, h)
    | c <- cs
    , let fs =  -- everything that has c as a goal category
               [ Right f
               | f <- symbols gr
               , all (`S.member` nonEmptyCats gr) (fst (ctyp f))
               , c == snd (ctyp f)
               ] ++
               -- 2) c is a coercion: here's a list of (nonempty) categories c uncoerces into
               [ Left cat
               | (cat,coe) <- coercions gr
               , coe == c
               , cat `S.member` nonEmptyCats gr
               ]

          -- all the categories c depends on
          ys = S.toList $ S.fromList $ concat
               [ case f of
                   Right f  -> fst (ctyp f)
                   Left cat -> [cat]
               | f <- fs
               ]

          -- Function to give to mu:
          -- computes whether the field is empty, given the emptiness of its arguments.
          -- a field in C is empty, if there's some function
          --      f :: A -> B -> C
          -- and it uses only empty fields from A and B.
          -- we're only looking at a given C at a time, 

          h :: [S.Set Int] -> S.Set Int
          h vs = foldr1 S.intersection $ [ apply f emptyfields
                  | Right f <- fs
                  , let emptyfields = map (args M.!) (fst $ ctyp f)
                  ] ++
                  [ args M.! cat
                  | Left cat <- fs
                  ]
           where
            args :: M.Map ConcrCat (S.Set Int) -- empty fields of each category
            args = M.fromList (ys `zip` vs)
    ]
   where            
    --apply :: Symbol        -- some f :: A -> B
    --        -> [S.Set Int] -- for each argument type to f, which fields are empty
    --        -> S.Set Int   -- empty fields in B
    apply f empties =
      S.fromList 
      [ i
      | (sq,i) <- seqs f `zip` [0..]
      , let isEmpty s = case s of 
              Left str    -> str == ""
              Right (k,j) -> j `S.member` (empties !! k)
      , all isEmpty (concrSeqs gr sq)
      ]
--------------------------------------------------------------------------------
-- FEAT-style generator magic

type FEAT = [ConcrCat] -> Int -> (Integer, Integer -> [Tree])

smallest :: Grammar -> ConcrCat -> Int
smallest gr c = head [ n | n <- [0..], featCard gr c n > 0 ]

-- compute how many trees there are of a given size and type
featCard :: Grammar -> ConcrCat -> Int -> Integer
featCard gr c n = featCardVec gr [c] n

-- generate the i-th tree of a given size and type
featIth :: Grammar -> ConcrCat -> Int -> Integer -> Tree
featIth gr c n i = head (featIthVec gr [c] n i)

-- generate all trees (infinitely many) of a given type
featAll :: Grammar -> ConcrCat -> [Tree]
featAll gr c = [ featIth gr c n i | n <- [0..], i <- [0..featCard gr c n-1] ]

-- compute how many tree-vectors there are of a given size and type-vector
featCardVec :: Grammar -> [ConcrCat] -> Int -> Integer
featCardVec gr cs n = fst (feat gr cs n)

-- generate the i-th tree-vector of a given size and type-vector
featIthVec :: Grammar -> [ConcrCat] -> Int -> Integer -> [Tree]
featIthVec gr cs n i = snd (feat gr cs n) i

mkFEAT :: Grammar -> FEAT
mkFEAT gr = catList
 where
  catList' :: FEAT
  catList' [] 0 = (1, \0 -> [])
  catList' [] _ = (0, error "indexing in an empty sequence")

  catList' [c] s =
    parts $ 
          [ (n, \i -> [App f (h i)])
          | s > 0 
          , f <- symbols gr
          , let (xs,y) = ctyp f
          , y == c
          , let (n,h) = catList xs (s-1)
          ] ++
          [ catList [x] s -- put (s-1) if it doesn't terminate
          | s > 0 
          , (x,y) <- coercions gr
          , y == c
          ]

  catList' (c:cs) s =
    parts [ (nx*nxs, \i -> hx (i `mod` nx) ++ hxs (i `div` nx))
          | k <- [0..s]
          , let (nx,hx)   = catList [c] k
                (nxs,hxs) = catList cs (s-k)
          ]

  catList :: FEAT
  catList = memoList (memoNat . catList')
   where
    -- all possible categories of the grammar
    cats = S.toList $ S.fromList $
           [ x | f <- symbols gr
               , let (xs,y) = ctyp f
               , x <- y:xs ] ++
           [ z | (x,y) <- coercions gr
               , z <- [x,y] ]

    memoList f = \cs -> case cs of
                    []   -> fNil
                    a:as -> fCons a as
     where
      fNil  = f []
      fCons = (tab M.!)
      tab   = M.fromList [ (c, memoList (f . (c:))) | c <- cats ]

    memoNat f = (tab!!)
     where
      tab = [ f i | i <- [0..] ]

  parts []          = (0, error "indexing outside of a sequence")
  parts ((n,h):nhs) = (n+n', \i -> if i < n then h i else h' (i-n))
   where
    (n',h') = parts nhs


--------------------------------------------------------------------------------
-- Functions used in Main

-- compare two grammars
diffCats :: Grammar -> Grammar -> [(Cat,[Int],[String],[String])]
diffCats gr1 gr2 = 
  [ (acat1,[difFid c1, difFid c2],labels1  \\ labels2,labels2 \\ labels1)
    | c1@(acat1,_i1,_j2,labels1) <- concrCats gr1
    , c2@(acat2,_i2,_j2,labels2) <- concrCats gr2
    , difFid c1 /= difFid c2 -- different amount of concrete categories
      || labels1 /= labels2 -- or the labels are different
    , acat1==acat2 ]

 where
  difFid (_,i,j,_) = 1 + (j-i)


-- return a list of symbols that have a specified string, e.g. "it" in English
-- grammar appears in functions CleftAdv, CleftNP, ImpersCl, DefArt, it_Pron
hasConcrString :: Grammar -> String -> [Symbol]
hasConcrString gr str =
  [ symb
  | symb <- symbols gr 
  , str `elem` concatMap (lefts . concrSeqs gr) (seqs symb) ]

-- nice printouts
type Context = String
type LinTree = ((Lang,Context),(Lang,String),(Lang,String),(Lang,String))
data Comparison = Comparison { funTree :: String, linTree :: [LinTree] }

instance Show Comparison where
  show c = unlines $ funTree c : map showLinTree (linTree c)

dummyCCat = CC Nothing 99999999
dummyHole = App (Symbol "∅" [] ([], "") ([], dummyCCat)) []

showLinTree :: LinTree -> String
showLinTree ((an,hl),(l1,t1),(l2,t2),(_l,[])) = unlines ["", an++hl, l1++t1, l2++t2]
showLinTree ((an,hl),(l1,t1),(l2,t2),(l3,t3)) = unlines ["", an++hl, l1++t1, l2++t2, l3++t3]

compareTree :: Grammar -> Grammar -> [Grammar] -> Cat -> Tree -> Comparison
compareTree gr oldgr transgr startcat t = Comparison {
  funTree = "* " ++ show t
, linTree = [ ( ("** ",hl), (langName gr,newLin), (langName oldgr, oldLin), transLin )
            | ctx <- ctxs
            , let hl = show (ctx dummyHole)
            , let newLin = linearize gr (ctx t)
            , let oldLin = linearize oldgr (ctx t)
            , let transLin = case transgr of
                              []  -> ("","")
                              g:_ -> (langName g, linearize g (ctx t))
            , newLin /= oldLin
            ] }
 where
  w    = top t
  c    = snd (ctyp w)
  cs   = c:[ coe
           | (cat,coe) <- coercions gr
           , c == cat ]
  ctxs = concat
         [ contextsFor gr sc cat
         | sc <- ccats gr startcat
         , cat <- cs ] 
  langName gr = concrLang gr ++ "> "

type Result = String

testFun :: Bool -> Grammar -> [Grammar] -> Cat -> Name -> Result
testFun debug gr trans startcat funname =
 let test = testTree debug gr trans
  in unlines [ test t n cs
             | (n,(t,cs)) <- zip [1..] testcase_ctxs ]

 where
  testcase_ctxs = M.toList $ M.fromListWith (++) $ uniqueTCs++commonTCs

  uniqueTCs = [ (testcase,uniqueCtxs)
   | (testcase,ctxs) <- M.elems cat_testcase_ctxs
   , let uniqueCtxs = deleteFirstsBy applyHole ctxs commonCtxs
   , not $ null uniqueCtxs
   ]
  commonTCs = [ (App newTop subtrees,ctxs)
   | (coe,cats,ctxs) <- coercion_goalcats_commonCtxs
   , let testcases_ctxs = catMaybes [ M.lookup cat cat_testcase_ctxs
                                    | cat <- cats ]
   , not $ null testcases_ctxs
   , let fstLen (a,_) (b,_) = length (flatten a) `compare` length (flatten b)
   , let (App tp subtrees,_) = -- pick smallest test case to be the representative
           minimumBy fstLen testcases_ctxs
   , let newTop = -- debug: put coerced contexts under a separate test case
          if debug then tp { ctyp = (fst $ ctyp tp, coe)} else tp
   ]

  starts = ccats gr startcat

  hl f c1 c2 = f (c1 dummyHole) == f (c2 dummyHole)
--  applyHole = hl id -- TODO why doesn't this work for equality of contexts?
  applyHole = hl show -- :: (Tree -> Tree) -> (Tree -> Tree) -> Bool

  funs = case lookupSymbol gr funname of
           [] -> error $ "Function "++funname++" not found"
           fs -> fs

  cat_testcase_ctxs = M.fromList
    [ (goalcat,(testcase,ctxs))
    | testcase <- treesUsingFun gr funs
    , let goalcat = ccatOf testcase -- never a coercion (coercions can't be goals)
    , let ctxs = [ ctx | st <- starts
                 , ctx <- contextsFor gr st goalcat ]
    ] :: M.Map ConcrCat (Tree,[Tree->Tree])
  goalcats = M.keys cat_testcase_ctxs

  coercion_goalcats_commonCtxs =
    [ (coe,coveredGoalcats,ctxs)
    | coe@(CC Nothing _) <- S.toList $ nonEmptyCats gr -- only coercions
    , let coveredGoalcats = filter (coerces gr coe) goalcats
    , let ctxs = [ ctx | st <- starts            -- Contexts that have
                 , ctx <- contextsFor gr st coe  -- a) hole of coercion, and are
                 , any (applyHole ctx) allCtxs ] -- b) relevant for the function we test
    , length coveredGoalcats >= 2 -- no use if the coercion covers 0 or 1 categories
    , not $ null ctxs ]


  allCtxs = [ ctx | (_,ctxs) <- M.elems cat_testcase_ctxs
                  , ctx <- ctxs ] :: [Tree->Tree]

  commonCtxs = nubBy applyHole [ ctx | (_,_,ctxs) <- coercion_goalcats_commonCtxs
                               , ctx <- ctxs ] :: [Tree->Tree]


testTree :: Bool -> Grammar -> [Grammar] -> Tree -> Int -> [Tree -> Tree] -> Result
testTree debug gr tgrs t n ctxs = unlines
  [ "* " ++ {- show n ++ ")" ++ -} show t
  , showConcrFun gr w
  , if debug then unlines $ tabularPrint gr t else ""
  , unlines $ concat
       [ [ "** " ++ show m ++ ") " ++ show (ctx (App (hole c) []))
         , langName gr ++ linearize gr (ctx t) 
         ] ++
         [ langName tgr ++ linearize tgr (ctx t) 
         | tgr <- tgrs ]
       | (ctx,m) <- zip ctxs [1..]
       ]
  , "" ]
 where
  w = top t
  c = snd (ctyp w)
  langName gr = concrLang gr ++ "> "

  tabularPrint gr t = 
    let cseqs = [ concatMap showCSeq cseq
                | cseq <- map (concrSeqs gr) (seqs $ top t) ]
        tablins = tabularLin gr t :: [(String,String)]
     in [ fieldname ++ ":\t" ++ lin ++ "\t" ++ s
        | ((fieldname,lin),s) <- zip tablins cseqs ]
  showCSeq (Left tok) = " " ++ show tok ++ " "
  showCSeq (Right (i,j)) = " <" ++ show i ++ "," ++ show j ++ "> "

--------------------------------------------------------------------------------
-- Generate test trees

treesUsingFun :: Grammar -> [Symbol] -> [Tree] 
treesUsingFun gr detCNs = 
  [ tree
    | detCN <- detCNs
    , let (dets_cns,np_209) = ctyp detCN -- :: ([ConcrCat],ConcrCat)
    , let bestArgs = case dets_cns of
                      [] -> [[]] 
                      xs -> bestTrees detCN gr dets_cns 
    , tree <- App detCN `map` bestArgs ]
  

bestTrees :: Symbol -> Grammar -> [ConcrCat] -> [[Tree]]
bestTrees fun gr cats =
  bestExamples fun gr $ take 200 -- change this to something else if too slow
  [ featIthVec gr cats size i
  | all (`S.member` nonEmptyCats gr) cats
  , size <- [0..20]
  , let card = featCardVec gr cats size 
  , i <- [0..card-1]
  ]

testsAsWellAs :: (Eq a, Eq b) => [a] -> [b] -> Bool
xs `testsAsWellAs` ys = go (xs `zip` ys)
 where
  go [] =
    True
    
  go ((x,y):xys) =
    and [ y' == y | (x',y') <- xys, x == x' ] &&
    go [ xy | xy@(x',_) <- xys, x /= x' ]


bestExamples :: Symbol -> Grammar -> [[Tree]] -> [[Tree]]
bestExamples fun gr vtrees = go [] vtrees_lins
 where
  syncategorematics = concatMap (lefts . concrSeqs gr) (seqs fun)
  vtrees_lins = [ (vtree, syncategorematics ++
                  concatMap (map snd . tabularLin gr) vtree) --linearise all trees at once
                 | vtree <- vtrees ] :: [([Tree],[String])]

  go cur []  = map fst cur
  go cur (vt@(ts,lins):vts)
    | any (`testsAsWellAs` lins) (map snd cur) = go cur vts
    | otherwise = go' (vt:[ c | c@(_,clins) <- cur
                              , not (lins `testsAsWellAs` clins) ])
                      vts

  go' cur vts | enough cur = map fst cur
              | otherwise  = go cur vts

  enough :: [([Tree],[String])] -> Bool
  enough [(_,lins)] = all singleton (group $ sort lins) -- can stop earlier but let's not do that
  enough _          = False
 