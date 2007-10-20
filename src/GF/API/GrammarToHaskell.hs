----------------------------------------------------------------------
-- |
-- Module      : GrammarToHaskell
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

module GF.API.GrammarToHaskell (grammar2haskell, grammar2haskellGADT) where

import qualified GF.Canon.GFC as GFC
import GF.Grammar.Macros

import GF.Infra.Modules
import GF.Data.Operations

import Data.List (isPrefixOf, find, intersperse)
import Data.Maybe (fromMaybe)

-- | the main function
grammar2haskell :: GFC.CanonGrammar -> String
grammar2haskell gr = foldr (++++) [] $  
  haskPreamble ++ [datatypes gr', gfinstances gr', fginstances gr']
    where gr' = hSkeleton gr

grammar2haskellGADT :: GFC.CanonGrammar -> String
grammar2haskellGADT gr = foldr (++++) [] $  
  ["{-# OPTIONS_GHC -fglasgow-exts #-}"] ++ 
  haskPreamble ++ [datatypesGADT gr', composInstance gr', showInstanceGADT gr', 
                   gfinstances gr', fginstances gr']
    where gr' = hSkeleton gr

-- | by this you can prefix all identifiers with stg; the default is 'G'
gId :: OIdent -> OIdent 
gId i = 'G':i

haskPreamble =
 [
  "module GSyntax where",
  "",
  "import GF.Infra.Ident",
  "import GF.Grammar.Grammar",
  "import GF.Grammar.PrGrammar",
  "import GF.Grammar.Macros",
  "import GF.Data.Compos",
  "import GF.Data.Operations",
  "",
  "import Control.Applicative (pure,(<*>))",
  "import Data.Traversable (traverse)",
  "----------------------------------------------------",
  "-- automatic translation from GF to Haskell",
  "----------------------------------------------------",
  "", 
  "class Gf a where gf :: a -> Trm",
  "class Fg a where fg :: Trm -> a",
  "",
  predefInst "GString" "String" "K s",
  "",
  predefInst "GInt" "Integer" "EInt s",
  "",
  predefInst "GFloat" "Double" "EFloat s",
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
  "    case termForm t of" ++++
  "      Ok ([]," +++ patt +++ ",[]) ->" +++ gtyp +++ "s" ++++
  "      _ -> error (\"no" +++ gtyp +++ "\" ++ prt t)"

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
   mkRHS f vars = "appqc \"" ++ m ++ "\" \"" ++ f ++ "\"" +++ 
		   "[" ++ prTList ", " ["gf" +++ x | x <- vars] ++ "]"


----fInstance m ("Cn",_) = "" ---
fInstance m (cat,[]) = ""
fInstance m (cat,rules) =
  "instance Fg" +++ gId cat +++ "where" ++++
  " fg t =" ++++
  "  case termForm t of" ++++
  foldr1 (\x y -> x ++ "\n" ++ y) [mkInst f xx | (f,xx) <- rules] ++++
  "    _ -> error (\"no" +++ cat ++ " \" ++ prt t)"
   where
    mkInst f xx =
     "    Ok ([], Q (IC \"" ++ m ++ "\") (IC \"" ++ f ++ "\")," ++
     "[" ++ prTList "," xx' ++ "])" +++
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

composInstance :: (String,HSkeleton) -> String
composInstance (_,skel) = unlines $
    ["instance Compos Tree where",
     "  compos f t = case t of"]
    ++ map ("      "++) (concatMap prComposCat skel
                         ++ if not allRecursive then ["_ -> pure t"] else [])
    where
    prComposCat c@(cat, fs) 
        | isListCat c = [gId cat +++ "xs" +++ "->" 
                         +++ "pure" +++ gId cat +++ "<*> traverse f" +++ "xs"]
        | otherwise = concatMap (prComposFun cat) fs
    prComposFun :: OIdent -> (OIdent,[OIdent]) -> [String]
    prComposFun cat c@(fun,args) 
	| any isTreeType args = [gId fun +++ unwords vars +++ "->" +++ rhs]
        | otherwise = []
      where vars = ["x" ++ show n | n <- [1..length args]]
            rhs = "pure" +++ gId fun +++ unwords (zipWith prRec vars args)
	        where prRec var typ
                          | not (isTreeType typ) = "<*>" +++ "pure" +++ var
			  | otherwise = "<*>" +++ "f" +++ var
    allRecursive = and [any isTreeType args | (_,fs) <- skel, (_,args) <- fs] 
    isTreeType cat = cat `elem` (map fst skel ++ builtin)
    isList cat = case filter ((==cat) . fst) skel of
                   [] -> error $ "Unknown cat " ++ show cat
                   x:_ -> isListCat x
    builtin = ["GString", "GInt", "GFloat"]

showInstanceGADT :: (String,HSkeleton) -> String
showInstanceGADT (_,skel) = unlines $
            ["instance Show (Tree c) where",
	     "  showsPrec n t = case t of"]
	     ++ map ("    "++) (concatMap prShowCat skel)
	     ++ ["   where opar n = if n > 0 then showChar '(' else id",
	         "         cpar n = if n > 0 then showChar ')' else id"]
  where 
  prShowCat c@(cat, fs)
      | isListCat c = [gId cat +++ "xs" +++ "->" +++ "showList" +++ "xs"]
      | otherwise = map (prShowFun cat) fs
  prShowFun :: OIdent -> (OIdent,[OIdent]) -> String
  prShowFun cat (fun,args) 
      | null vars = gId fun +++ "->" +++ "showString" +++ show fun
      | otherwise = gId fun +++ unwords vars +++ "->" 
			     +++ "opar n . showString" +++ show fun
			     +++ unwords [". showChar ' ' . showsPrec 1 " ++ x | x <- vars]
			     +++ ". cpar n"
      where vars = ["x" ++ show n | n <- [1..length args]]

hSkeleton :: GFC.CanonGrammar -> (String,HSkeleton)
hSkeleton gr = (name,collectR rules [(c,[]) | c <- cats]) where
  collectR rr hh =
   case rr of
     (fun,typ):rs -> case catSkeleton typ of
        Ok (cats,cat) -> 
             collectR rs (updateSkeleton (symid (snd cat)) hh (fun,
	                                                    map (symid . snd) cats))
        _ -> collectR rs hh
     _ -> hh
  cats =  [symid cat | (cat,GFC.AbsCat _ _) <- defs]
  rules = [(symid fun, typ) | (fun,GFC.AbsFun typ _) <- defs]

  defs = concat [tree2list (jments m) | im@(_,ModMod m) <- modules gr, isModAbs m]
  name = ifNull "UnknownModule" (symid . last) [n | (n,ModMod m) <- modules gr, isModAbs m]

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