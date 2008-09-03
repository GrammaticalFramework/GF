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

module GF.Compile.GFCCtoHaskell (grammar2haskell, grammar2haskellGADT) where

import PGF.CId
import PGF.Data
import PGF.Macros

import GF.Data.Operations
import GF.Text.UTF8

import Data.List --(isPrefixOf, find, intersperse)
import qualified Data.Map as Map

type Prefix = String -> String

-- | the main function
grammar2haskell :: String -- ^ Constructor prefix 
                -> String  -- ^ Module name.
                -> PGF
                -> String
grammar2haskell prefix name gr = encodeUTF8 $ foldr (++++) [] $  
  haskPreamble name ++ [datatypes gId gr', gfinstances gId gr']
    where gr' = hSkeleton gr
          gId = (prefix++)

grammar2haskellGADT :: String  -- ^ Constructor prefix
                    -> String   -- ^ Module name.
                    -> PGF
                    -> String
grammar2haskellGADT prefix name gr = encodeUTF8 $ foldr (++++) [] $  
  ["{-# OPTIONS_GHC -fglasgow-exts #-}"] ++ 
  haskPreamble name ++ [datatypesGADT gId gr', gfinstances gId gr']
    where gr' = hSkeleton gr
          gId = (prefix++)

haskPreamble name =
 [
  "module " ++ name ++ " where",
  "",
  "import PGF",
  "----------------------------------------------------",
  "-- automatic translation from GF to Haskell",
  "----------------------------------------------------",
  "", 
  "class Gf a where",
  "  gf :: a -> Tree",
  "  fg :: Tree -> a",
  "",
  predefInst "GString" "String"  "Lit (LStr s)",
  "",
  predefInst "GInt"    "Integer" "Lit (LInt s)",
  "",
  predefInst "GFloat"  "Double"  "Lit (LFlt s)",
  "",
  "----------------------------------------------------",
  "-- below this line machine-generated",
  "----------------------------------------------------",
  ""
 ]

predefInst gtyp typ patt = 
  "newtype" +++ gtyp +++ "=" +++ gtyp +++ typ +++ " deriving Show" +++++
  "instance Gf" +++ gtyp +++ "where" ++++
  "  gf (" ++ gtyp +++ "s) =" +++ patt ++++
  "  fg t =" ++++
  "    case t of" ++++
  "     " +++ patt +++ " ->" +++ gtyp +++ "s" ++++
  "      _ -> error (\"no" +++ gtyp +++ "\" ++ show t)"

type OIdent = String

type HSkeleton = [(OIdent, [(OIdent, [OIdent])])]

datatypes, gfinstances :: Prefix -> (String,HSkeleton) -> String
datatypes gId = (foldr (+++++) "") . (filter (/="")) . (map (hDatatype gId)) . snd
gfinstances gId (m,g) = (foldr (+++++) "") $ (filter (/="")) $ (map (gfInstance gId m)) g

hDatatype  :: Prefix -> (OIdent, [(OIdent, [OIdent])]) -> String
gfInstance :: Prefix -> String -> (OIdent, [(OIdent, [OIdent])]) -> String

hDatatype _ ("Cn",_) = "" ---
hDatatype _ (cat,[]) = ""
hDatatype gId (cat,rules) | isListCat (cat,rules) = 
 "newtype" +++ gId cat +++ "=" +++ gId cat +++ "[" ++ gId (elemCat cat) ++ "]" 
  +++ "deriving Show"
hDatatype gId (cat,rules) =
 "data" +++ gId cat +++ "=" ++
 (if length rules == 1 then "" else "\n  ") +++
 foldr1 (\x y -> x ++ "\n |" +++ y) 
        [gId f +++ foldr (+++) "" (map (gId) xx) | (f,xx) <- rules] ++++
 "  deriving Show"

-- GADT version of data types
datatypesGADT :: Prefix -> (String,HSkeleton) -> String
datatypesGADT gId (_,skel) = 
    unlines (concatMap (hCatTypeGADT gId) skel)
    +++++
    "data Tree :: * -> * where" ++++ unlines (concatMap (map ("  "++) . hDatatypeGADT gId) skel)

hCatTypeGADT :: Prefix -> (OIdent, [(OIdent, [OIdent])]) -> [String]
hCatTypeGADT gId (cat,rules)
    = ["type"+++gId cat+++"="+++"Tree"+++gId cat++"_",
       "data"+++gId cat++"_"]

hDatatypeGADT :: Prefix -> (OIdent, [(OIdent, [OIdent])]) -> [String]
hDatatypeGADT gId (cat, rules) 
    | isListCat (cat,rules) = [gId cat+++"::"+++"["++gId (elemCat cat)++"]" +++ "->" +++ t]
    | otherwise =
        [ gId f +++ "::" +++ concatMap (\a -> gId a +++ "-> ") args ++ t | (f,args) <- rules ]
  where t = "Tree" +++ gId cat ++ "_"

gfInstance gId m crs = hInstance gId m crs ++++ fInstance gId m crs

----hInstance m ("Cn",_) = "" --- seems to belong to an old applic. AR 18/5/2004
hInstance _ m (cat,[]) = "" 
hInstance gId m (cat,rules) 
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
  unlines [mkInst f xx | (f,xx) <- rules]
 where
   ec = elemCat cat
   baseVars = mkVars (baseSize (cat,rules))
   mkInst f xx = let xx' = mkVars (length xx) in "  gf " ++
     (if length xx == 0 then gId f else prParenth (gId f +++ foldr1 (+++) xx')) +++
     "=" +++ mkRHS f xx'
   mkVars n = ["x" ++ show i | i <- [1..n]]
   mkRHS f vars = "Fun (mkCId \"" ++ f ++ "\")" +++ 
		   "[" ++ prTList ", " ["gf" +++ x | x <- vars] ++ "]"


----fInstance m ("Cn",_) = "" ---
fInstance _ m (cat,[]) = ""
fInstance gId m (cat,rules) =
  "  fg t =" ++++
  "    case t of" ++++
  unlines [mkInst f xx | (f,xx) <- rules] ++++
  "      _ -> error (\"no" +++ cat ++ " \" ++ show t)"
   where
    mkInst f xx =
     "      Fun i " ++
     "[" ++ prTList "," xx' ++ "]" +++
     "| i == mkCId \"" ++ f ++ "\" ->" +++ mkRHS f xx'
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
hSkeleton :: PGF -> (String,HSkeleton)
hSkeleton gr = 
  (prCId (absname gr), 
   [(prCId c, [(prCId f, map prCId cs) | (f, (cs,_)) <- fs]) | 
                                        fs@((_, (_,c)):_) <- fns]
  )
 where
   fns = groupBy valtypg (sortBy valtyps (map jty (Map.assocs (funs (abstract gr)))))
   valtyps (_, (_,x)) (_, (_,y)) = compare x y
   valtypg (_, (_,x)) (_, (_,y)) = x == y
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
