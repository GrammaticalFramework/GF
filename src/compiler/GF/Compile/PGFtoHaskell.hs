----------------------------------------------------------------------
-- |
-- Module      : PGFtoHaskell
-- Maintainer  : Aarne Ranta
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/17 12:39:07 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.8 $
--
-- to write a GF abstract grammar into a Haskell module with translations from
-- data objects into GF trees. Example: GSyntax for Agda.
-- AR 11/11/1999 -- 7/12/2000 -- 18/5/2004
-----------------------------------------------------------------------------

module GF.Compile.PGFtoHaskell (grammar2haskell) where

import PGF(showCId)
import PGF.Internal

import GF.Data.Operations
import GF.Infra.Option

import Data.List --(isPrefixOf, find, intersperse)
import qualified Data.Map as Map

type Prefix = String -> String

-- | the main function
grammar2haskell :: Options
                -> String  -- ^ Module name.
                -> PGF
                -> String
grammar2haskell opts name gr = foldr (++++) [] $  
  pragmas ++ haskPreamble gadt name ++ [types, gfinstances gId lexical gr'] ++ compos
    where gr' = hSkeleton gr
          gadt = haskellOption opts HaskellGADT
          lexical cat = haskellOption opts HaskellLexical && isLexicalCat opts cat
          gId | haskellOption opts HaskellNoPrefix = id
              | otherwise = ("G"++)
          pragmas | gadt = ["{-# OPTIONS_GHC -fglasgow-exts #-}"]
                  | otherwise = []
          types | gadt = datatypesGADT gId lexical gr'
                | otherwise = datatypes gId lexical gr'
          compos | gadt = prCompos gId lexical gr' ++ composClass
                 | otherwise = []

haskPreamble gadt name =
 [
  "module " ++ name ++ " where",
  ""
 ] ++
 (if gadt then [
  "import Control.Monad.Identity",
  "import Data.Monoid"
  ] else []) ++
 [
  "import PGF",
  "----------------------------------------------------",
  "-- automatic translation from GF to Haskell",
  "----------------------------------------------------",
  "", 
  "class Gf a where",
  "  gf :: a -> Expr",
  "  fg :: Expr -> a",
  "",
  predefInst gadt "GString" "String"  "unStr"    "mkStr",
  "",
  predefInst gadt "GInt"    "Int"     "unInt"    "mkInt",
  "",
  predefInst gadt "GFloat"  "Double"  "unFloat"  "mkFloat",
  "",
  "----------------------------------------------------",
  "-- below this line machine-generated",
  "----------------------------------------------------",
  ""
 ]

predefInst gadt gtyp typ destr consr = 
  (if gadt
    then [] 
    else ("newtype" +++ gtyp +++ "=" +++ gtyp +++ typ +++ " deriving Show\n\n") 
    ) 
  ++
  "instance Gf" +++ gtyp +++ "where" ++++
  "  gf (" ++ gtyp +++ "x) =" +++ consr +++ "x" ++++
  "  fg t =" ++++
  "    case "++destr++" t of" ++++
  "      Just x  -> " +++ gtyp +++ "x" ++++
  "      Nothing -> error (\"no" +++ gtyp +++ "\" ++ show t)"

type OIdent = String

type HSkeleton = [(OIdent, [(OIdent, [OIdent])])]

datatypes :: Prefix -> (OIdent -> Bool) -> (String,HSkeleton) -> String
datatypes gId lexical = (foldr (+++++) "") . (filter (/="")) . (map (hDatatype gId lexical)) . snd

gfinstances :: Prefix -> (OIdent -> Bool) -> (String,HSkeleton) -> String
gfinstances gId lexical (m,g) = (foldr (+++++) "") $ (filter (/="")) $ (map (gfInstance gId lexical m)) g


hDatatype  :: Prefix -> (OIdent -> Bool) -> (OIdent, [(OIdent, [OIdent])]) -> String
hDatatype _ _ ("Cn",_) = "" ---
hDatatype gId _ (cat,[]) = "data" +++ gId cat
hDatatype gId _ (cat,rules) | isListCat (cat,rules) = 
 "newtype" +++ gId cat +++ "=" +++ gId cat +++ "[" ++ gId (elemCat cat) ++ "]" 
  +++ "deriving Show"
hDatatype gId lexical (cat,rules) =
 "data" +++ gId cat +++ "=" ++
 (if length rules == 1 then "" else "\n  ") +++
 foldr1 (\x y -> x ++ "\n |" +++ y) constructors ++++
 "  deriving Show"
  where
    constructors = [gId f +++ foldr (+++) "" (map (gId) xx) | (f,xx) <- nonLexicalRules (lexical cat) rules]
                   ++ if lexical cat then [lexicalConstructor cat +++ "String"] else []

nonLexicalRules :: Bool -> [(OIdent, [OIdent])] -> [(OIdent, [OIdent])]
nonLexicalRules False rules = rules
nonLexicalRules True rules = [r | r@(f,t) <- rules, not (null t)]

lexicalConstructor :: OIdent -> String
lexicalConstructor cat = "Lex" ++ cat

predefTypeSkel = [(c,[]) | c <- ["String", "Int", "Float"]]

-- GADT version of data types
datatypesGADT :: Prefix -> (OIdent -> Bool) -> (String,HSkeleton) -> String
datatypesGADT gId lexical (_,skel) = unlines $ 
    concatMap (hCatTypeGADT gId) (skel ++ predefTypeSkel) ++
    [ 
      "", 
      "data Tree :: * -> * where"
    ] ++ 
    concatMap (map ("  "++) . hDatatypeGADT gId lexical) skel ++
    [
      "  GString :: String -> Tree GString_",
      "  GInt :: Int -> Tree GInt_",
      "  GFloat :: Double -> Tree GFloat_",
      "",
      "instance Eq (Tree a) where",
      "  i == j = case (i,j) of"
    ] ++
    concatMap (map ("    "++) . hEqGADT gId lexical) skel ++
    [
      "    (GString x, GString y) -> x == y",
      "    (GInt x, GInt y) -> x == y",
      "    (GFloat x, GFloat y) -> x == y",
      "    _ -> False"
    ]

hCatTypeGADT :: Prefix -> (OIdent, [(OIdent, [OIdent])]) -> [String]
hCatTypeGADT gId (cat,rules)
    = ["type"+++gId cat+++"="+++"Tree"+++gId cat++"_",
       "data"+++gId cat++"_"]

hDatatypeGADT :: Prefix -> (OIdent -> Bool) -> (OIdent, [(OIdent, [OIdent])]) -> [String]
hDatatypeGADT gId lexical (cat, rules) 
    | isListCat (cat,rules) = [gId cat+++"::"+++"["++gId (elemCat cat)++"]" +++ "->" +++ t]
    | otherwise =
        [ gId f +++ "::" +++ concatMap (\a -> gId a +++ "-> ") args ++ t 
          | (f,args) <- nonLexicalRules (lexical cat) rules ]
        ++ if lexical cat then [lexicalConstructor cat +++ ":: String ->"+++ t] else []
  where t = "Tree" +++ gId cat ++ "_"

hEqGADT :: Prefix -> (OIdent -> Bool) -> (OIdent, [(OIdent, [OIdent])]) -> [String]
hEqGADT gId lexical (cat, rules)
  | isListCat (cat,rules) = let r = listr cat in ["(" ++ patt "x" r ++ "," ++ patt "y" r ++ ") -> " ++ listeqs] 
  | otherwise = ["(" ++ patt "x" r ++ "," ++ patt "y" r ++ ") -> " ++ eqs r | r <- nonLexicalRules (lexical cat) rules]
          ++ if lexical cat then ["(" ++ lexicalConstructor cat +++ "x" ++ "," ++ lexicalConstructor cat +++ "y" ++ ") -> x == y"] else []

 where
   patt s (f,xs) = unwords (gId f : mkSVars s (length xs))
   eqs (_,xs) = unwords ("and" : "[" : intersperse "," [x ++ " == " ++ y | 
     (x,y) <- zip (mkSVars "x" (length xs)) (mkSVars "y" (length xs)) ] ++ ["]"])
   listr c = (c,["foo"]) -- foo just for length = 1
   listeqs = "and [x == y | (x,y) <- zip x1 y1]"

prCompos :: Prefix -> (OIdent -> Bool) -> (String,HSkeleton) -> [String]
prCompos gId lexical (_,catrules) =
    ["instance Compos Tree where",
     "  compos r a f t = case t of"]
    ++ 
    ["    " ++ prComposCons (gId f) xs | (c,rs) <- catrules, not (isListCat (c,rs)),
                                         (f,xs) <- rs, not (null xs)] 
    ++ 
    ["    " ++ prComposCons (gId c) ["x1"] | (c,rs) <- catrules, isListCat (c,rs)]
    ++ 
    ["    _ -> r t"]
  where
    prComposCons f xs = let vs = mkVars (length xs) in 
                        f +++ unwords vs +++ "->" +++ rhs f (zip vs xs)
    rhs f vcs = "r" +++ f +++ unwords (map (prRec f) vcs)
    prRec f (v,c) 
      | isList f  = "`a` foldr (a . a (r (:)) . f) (r [])" +++ v
      | otherwise = "`a`" +++ "f" +++ v
    isList f = (gId "List") `isPrefixOf` f

gfInstance :: Prefix -> (OIdent -> Bool) -> String -> (OIdent, [(OIdent, [OIdent])]) -> String
gfInstance gId lexical m crs = hInstance gId lexical m crs ++++ fInstance gId lexical m crs

----hInstance m ("Cn",_) = "" --- seems to belong to an old applic. AR 18/5/2004
hInstance gId _ m (cat,[]) = unlines [
  "instance Show" +++ gId cat,
  "",
  "instance Gf" +++ gId cat +++ "where",
  "  gf _ = undefined",
  "  fg _ = undefined"
  ]
hInstance gId lexical m (cat,rules) 
 | isListCat (cat,rules) =
  "instance Gf" +++ gId cat +++ "where" ++++
     "  gf (" ++ gId cat +++ "[" ++ concat (intersperse "," baseVars) ++ "])" 
           +++ "=" +++ mkRHS ("Base"++ec) baseVars ++++
     "  gf (" ++ gId cat +++ "(x:xs)) = " 
           ++ mkRHS ("Cons"++ec) ["x",prParenth (gId cat+++"xs")] 
-- no show for GADTs
--     ++++ " gf (" ++ gId cat +++ "xs) = error (\"Bad " ++ cat ++ " value: \" ++ show xs)" 
 | otherwise =
  "instance Gf" +++ gId cat +++ "where\n" ++
  unlines ([mkInst f xx | (f,xx) <- nonLexicalRules (lexical cat) rules]
            ++ if lexical cat then ["  gf (" ++ lexicalConstructor cat +++ "x) = mkApp (mkCId x) []"] else [])
 where
   ec = elemCat cat
   baseVars = mkVars (baseSize (cat,rules))
   mkInst f xx = let xx' = mkVars (length xx) in "  gf " ++
     (if length xx == 0 then gId f else prParenth (gId f +++ foldr1 (+++) xx')) +++
     "=" +++ mkRHS f xx'
   mkRHS f vars = "mkApp (mkCId \"" ++ f ++ "\")" +++ 
		   "[" ++ prTList ", " ["gf" +++ x | x <- vars] ++ "]"

mkVars = mkSVars "x"
mkSVars s n = [s ++ show i | i <- [1..n]]

----fInstance m ("Cn",_) = "" ---
fInstance _ _ m (cat,[]) = ""
fInstance gId lexical m (cat,rules) =
  "  fg t =" ++++
  (if isList 
    then "    " ++ gId cat ++ " (fgs t) where\n     fgs t = case unApp t of"
    else "    case unApp t of") ++++
  unlines [mkInst f xx | (f,xx) <- nonLexicalRules (lexical cat) rules] ++++
  (if lexical cat then "      Just (i,[]) -> " ++ lexicalConstructor cat +++ "(showCId i)" else "") ++++
  "      _ -> error (\"no" +++ cat ++ " \" ++ show t)"
   where
    isList = isListCat (cat,rules)
    mkInst f xx =
     "      Just (i," ++
     "[" ++ prTList "," xx' ++ "])" +++
     "| i == mkCId \"" ++ f ++ "\" ->" +++ mkRHS f xx'
       where xx' = ["x" ++ show i | (_,i) <- zip xx [1..]]
	     mkRHS f vars 
		 | isList =
		     if "Base" `isPrefixOf` f 
                       then "[" ++ prTList ", " [ "fg" +++ x | x <- vars ] ++ "]"
		       else "fg" +++ (vars !! 0) +++ ":" +++ "fgs" +++ (vars !! 1)
		 | otherwise = 
		     gId f +++  
		     prTList " " [prParenth ("fg" +++ x) | x <- vars]

--type HSkeleton = [(OIdent, [(OIdent, [OIdent])])]
hSkeleton :: PGF -> (String,HSkeleton)
hSkeleton gr = 
  (showCId (absname gr), 
   let fs = 
         [(showCId c, [(showCId f, map showCId cs) | (f, (cs,_)) <- fs]) | 
                                        fs@((_, (_,c)):_) <- fns]
   in fs ++ [(sc, []) | c <- cts, let sc = showCId c, notElem sc (["Int", "Float", "String"] ++ map fst fs)]
  )
 where
   cts = Map.keys (cats (abstract gr)) 
   fns = groupBy valtypg (sortBy valtyps (map jty (Map.assocs (funs (abstract gr)))))
   valtyps (_, (_,x)) (_, (_,y)) = compare x y
   valtypg (_, (_,x)) (_, (_,y)) = x == y
   jty (f,(ty,_,_,_)) = (f,catSkeleton ty)
{-
updateSkeleton :: OIdent -> HSkeleton -> (OIdent, [OIdent]) -> HSkeleton
updateSkeleton cat skel rule =
 case skel of
   (cat0,rules):rr | cat0 == cat -> (cat0, rule:rules) : rr
   (cat0,rules):rr               -> (cat0, rules) : updateSkeleton cat rr rule
-}
isListCat :: (OIdent, [(OIdent, [OIdent])]) -> Bool
isListCat (cat,rules) = "List" `isPrefixOf` cat && length rules == 2
		    && ("Base"++c) `elem` fs && ("Cons"++c) `elem` fs
    where c = elemCat cat
	  fs = map fst rules

-- | Gets the element category of a list category.
elemCat :: OIdent -> OIdent
elemCat = drop 4
{-
isBaseFun :: OIdent -> Bool
isBaseFun f = "Base" `isPrefixOf` f

isConsFun :: OIdent -> Bool
isConsFun f = "Cons" `isPrefixOf` f
-}
baseSize :: (OIdent, [(OIdent, [OIdent])]) -> Int
baseSize (_,rules) = length bs
    where Just (_,bs) = find (("Base" `isPrefixOf`) . fst) rules

composClass :: [String]
composClass = 
    [
     "",
     "class Compos t where",
     "  compos :: (forall a. a -> m a) -> (forall a b. m (a -> b) -> m a -> m b)",
     "         -> (forall a. t a -> m (t a)) -> t c -> m (t c)",
     "",
     "composOp :: Compos t => (forall a. t a -> t a) -> t c -> t c",
     "composOp f = runIdentity . composOpM (Identity . f)",
     "",
     "composOpM :: (Compos t, Monad m) => (forall a. t a -> m (t a)) -> t c -> m (t c)",
     "composOpM = compos return ap",
     "",
     "composOpM_ :: (Compos t, Monad m) => (forall a. t a -> m ()) -> t c -> m ()",
     "composOpM_ = composOpFold (return ()) (>>)",
     "",
     "composOpMonoid :: (Compos t, Monoid m) => (forall a. t a -> m) -> t c -> m",
     "composOpMonoid = composOpFold mempty mappend",
     "",
     "composOpMPlus :: (Compos t, MonadPlus m) => (forall a. t a -> m b) -> t c -> m b",
     "composOpMPlus = composOpFold mzero mplus",
     "",
     "composOpFold :: Compos t => b -> (b -> b -> b) -> (forall a. t a -> b) -> t c -> b",
     "composOpFold z c f = unC . compos (\\_ -> C z) (\\(C x) (C y) -> C (c x y)) (C . f)",
     "",
     "newtype C b a = C { unC :: b }"
    ]

