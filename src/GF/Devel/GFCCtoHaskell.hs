----------------------------------------------------------------------
-- |
-- Module      : GFCCtoHaskell
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

module GF.Devel.GFCCtoHaskell (grammar2haskell, grammar2haskellGADT) where

import GF.GFCC.Macros
import GF.GFCC.DataGFCC
import GF.GFCC.AbsGFCC

import GF.Data.Operations
import GF.Text.UTF8

import Data.List --(isPrefixOf, find, intersperse)
import qualified Data.Map as Map

-- | the main function
grammar2haskell :: GFCC -> String
grammar2haskell gr = encodeUTF8 $ foldr (++++) [] $  
  haskPreamble ++ [datatypes gr', gfinstances gr', fginstances gr']
    where gr' = hSkeleton gr

grammar2haskellGADT :: GFCC -> String
grammar2haskellGADT gr = encodeUTF8 $ foldr (++++) [] $  
  ["{-# OPTIONS_GHC -fglasgow-exts #-}"] ++ 
  haskPreamble ++ [datatypesGADT gr', gfinstances gr', fginstances gr']
    where gr' = hSkeleton gr

-- | by this you can prefix all identifiers with stg; the default is 'G'
gId :: OIdent -> OIdent 
gId i = 'G':i

haskPreamble =
 [
  "module GSyntax where",
  "",
  "import GF.GFCC.DataGFCC",
  "import GF.GFCC.AbsGFCC",
  "----------------------------------------------------",
  "-- automatic translation from GF to Haskell",
  "----------------------------------------------------",
  "", 
  "class Gf a where gf :: a -> Exp",
  "class Fg a where fg :: Exp -> a",
  "",
  predefInst "GString" "String" "DTr [] (AS s) []",
  "",
  predefInst "GInt" "Integer" "DTr [] (AI s) []",
  "",
  predefInst "GFloat" "Double" "DTr [] (AF s) []",
  "",
  "----------------------------------------------------",
  "-- below this line machine-generated",
  "----------------------------------------------------",
  ""
 ]

predefInst gtyp typ patt = 
  "newtype" +++ gtyp +++ "=" +++ gtyp +++ typ +++ " deriving Show" +++++
  "instance Gf" +++ gtyp +++ "where" ++++
  "  gf (" ++ gtyp +++ "s) =" +++ patt +++++
  "instance Fg" +++ gtyp +++ "where" ++++
  "  fg t =" ++++
  "    case t of" ++++
  "     " +++ patt +++ " ->" +++ gtyp +++ "s" ++++
  "      _ -> error (\"no" +++ gtyp +++ "\" ++ show t)"

type OIdent = String

type HSkeleton = [(OIdent, [(OIdent, [OIdent])])]

datatypes, gfinstances, fginstances :: (String,HSkeleton) -> String
datatypes   = (foldr (+++++) "") . (filter (/="")) . (map hDatatype) . snd
gfinstances (m,g) = (foldr (+++++) "") $ (filter (/="")) $ (map (hInstance m)) g
fginstances (m,g) = (foldr (+++++) "") $ (filter (/="")) $ (map (fInstance m)) g

hDatatype :: (OIdent, [(OIdent, [OIdent])]) -> String
hInstance, fInstance :: String -> (OIdent, [(OIdent, [OIdent])]) -> String

hDatatype ("Cn",_) = "" ---
hDatatype (cat,[]) = ""
hDatatype (cat,rules) | isListCat (cat,rules) = 
 "newtype" +++ gId cat +++ "=" +++ gId cat +++ "[" ++ gId (elemCat cat) ++ "]" 
  +++ "deriving Show"
hDatatype (cat,rules) =
 "data" +++ gId cat +++ "=" ++
 (if length rules == 1 then "" else "\n  ") +++
 foldr1 (\x y -> x ++ "\n |" +++ y) 
        [gId f +++ foldr (+++) "" (map gId xx) | (f,xx) <- rules] ++++
 "  deriving Show"

-- GADT version of data types
datatypesGADT :: (String,HSkeleton) -> String
datatypesGADT (_,skel) = 
    unlines (concatMap hCatTypeGADT skel)
    +++++
    "data Tree :: * -> * where" ++++ unlines (concatMap (map ("  "++) . hDatatypeGADT) skel)

hCatTypeGADT :: (OIdent, [(OIdent, [OIdent])]) -> [String]
hCatTypeGADT (cat,rules)
    = ["type"+++gId cat+++"="+++"Tree"+++gId cat++"_",
       "data"+++gId cat++"_"]

hDatatypeGADT :: (OIdent, [(OIdent, [OIdent])]) -> [String]
hDatatypeGADT (cat, rules) 
    | isListCat (cat,rules) = [gId cat+++"::"+++"["++gId (elemCat cat)++"]" +++ "->" +++ t]
    | otherwise =
        [ gId f +++ "::" +++ concatMap (\a -> gId a +++ "-> ") args ++ t | (f,args) <- rules ]
  where t = "Tree" +++ gId cat ++ "_"


----hInstance m ("Cn",_) = "" --- seems to belong to an old applic. AR 18/5/2004
hInstance m (cat,[]) = "" 
hInstance m (cat,rules) 
 | isListCat (cat,rules) =
  "instance Gf" +++ gId cat +++ "where" ++++
     " gf (" ++ gId cat +++ "[" ++ concat (intersperse "," baseVars) ++ "])" 
           +++ "=" +++ mkRHS ("Base"++ec) baseVars ++++
     " gf (" ++ gId cat +++ "(x:xs)) = " 
           ++ mkRHS ("Cons"++ec) ["x",prParenth (gId cat+++"xs")] 
-- no show for GADTs
--     ++++ " gf (" ++ gId cat +++ "xs) = error (\"Bad " ++ cat ++ " value: \" ++ show xs)" 
 | otherwise =
  "instance Gf" +++ gId cat +++ "where" ++
  (if length rules == 1 then "" else "\n") +++
  foldr1 (\x y -> x ++ "\n" +++ y) [mkInst f xx | (f,xx) <- rules]
 where
   ec = elemCat cat
   baseVars = mkVars (baseSize (cat,rules))
   mkInst f xx = let xx' = mkVars (length xx) in "gf " ++
     (if length xx == 0 then gId f else prParenth (gId f +++ foldr1 (+++) xx')) +++
     "=" +++ mkRHS f xx'
   mkVars n = ["x" ++ show i | i <- [1..n]]
   mkRHS f vars = "DTr [] (AC (CId \"" ++ f ++ "\"))" +++ 
		   "[" ++ prTList ", " ["gf" +++ x | x <- vars] ++ "]"


----fInstance m ("Cn",_) = "" ---
fInstance m (cat,[]) = ""
fInstance m (cat,rules) =
  "instance Fg" +++ gId cat +++ "where" ++++
  " fg t =" ++++
  "  case t of" ++++
  foldr1 (\x y -> x ++ "\n" ++ y) [mkInst f xx | (f,xx) <- rules] ++++
  "    _ -> error (\"no" +++ cat ++ " \" ++ show t)"
   where
    mkInst f xx =
     "    DTr [] (AC (CId \"" ++ f ++ "\")) " ++
     "[" ++ prTList "," xx' ++ "]" +++
     "->" +++ mkRHS f xx'
       where xx' = ["x" ++ show i | (_,i) <- zip xx [1..]]
	     mkRHS f vars 
		 | isListCat (cat,rules) =
		     if "Base" `isPrefixOf` f then
			gId cat +++ "[" ++ prTList ", " [ "fg" +++ x | x <- vars ] ++ "]"
		      else
                       let (i,t) = (init vars,last vars)
                        in "let" +++ gId cat +++ "xs = fg " ++ t +++ "in" +++ 
                          gId cat +++ prParenth (prTList ":" (["fg"+++v | v <- i] ++ ["xs"]))
		 | otherwise = 
		     gId f +++  
		     prTList " " [prParenth ("fg" +++ x) | x <- vars]


--type HSkeleton = [(OIdent, [(OIdent, [OIdent])])]
hSkeleton :: GFCC -> (String,HSkeleton)
hSkeleton gr = 
  (pr (absname gr), 
   [(pr c, [(pr f, map pr cs) | (f, (cs,_)) <- fs]) | 
                                        fs@((_, (_,c)):_) <- fns]
  )
 where
   fns = groupBy valtypg (sortBy valtyps (map jty (Map.assocs (funs (abstract gr)))))
   valtyps (_, (_,x)) (_, (_,y)) = compare x y
   valtypg (_, (_,x)) (_, (_,y)) = x == y
   pr (CId c) = c
   jty (f,(ty,_)) = (f,catSkeleton ty)

updateSkeleton :: OIdent -> HSkeleton -> (OIdent, [OIdent]) -> HSkeleton
updateSkeleton cat skel rule =
 case skel of
   (cat0,rules):rr | cat0 == cat -> (cat0, rule:rules) : rr
   (cat0,rules):rr               -> (cat0, rules) : updateSkeleton cat rr rule

isListCat :: (OIdent, [(OIdent, [OIdent])]) -> Bool
isListCat (cat,rules) = "List" `isPrefixOf` cat && length rules == 2
		    && ("Base"++c) `elem` fs && ("Cons"++c) `elem` fs
    where c = elemCat cat
	  fs = map fst rules

-- | Gets the element category of a list category.
elemCat :: OIdent -> OIdent
elemCat = drop 4

isBaseFun :: OIdent -> Bool
isBaseFun f = "Base" `isPrefixOf` f

isConsFun :: OIdent -> Bool
isConsFun f = "Cons" `isPrefixOf` f

baseSize :: (OIdent, [(OIdent, [OIdent])]) -> Int
baseSize (_,rules) = length bs
    where Just (_,bs) = find (("Base" `isPrefixOf`) . fst) rules
