----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- to write a GF abstract grammar into a Haskell module with translations from
-- data objects into GF trees. Example: GSyntax for Agda.
-- AR 11/11/1999 -- 7/12/2000 -- 18/5/2004
-----------------------------------------------------------------------------

module GrammarToHaskell (grammar2haskell) where

import qualified GFC
import Macros

import Modules
import Operations

-- | the main function
grammar2haskell :: GFC.CanonGrammar -> String
grammar2haskell gr = foldr (++++) [] $  
  haskPreamble ++ [datatypes gr', gfinstances gr', fginstances gr']
    where gr' = hSkeleton gr

-- | by this you can prefix all identifiers with stg; the default is 'G'
gId :: OIdent -> OIdent 
gId i = 'G':i

haskPreamble =
 [
  "module GSyntax where",
  "",
  "import Ident",
  "import Grammar",
  "import PrGrammar",
  "import Macros",
  "import Operations",
  "----------------------------------------------------",
  "-- automatic translation from GF to Haskell",
  "----------------------------------------------------",
  "", 
  "class Gf a where gf :: a -> Trm",
  "class Fg a where fg :: Trm -> a",
  "",
  predefInst "String" "K s",
  "",
  predefInst "Int" "EInt s",
  "",
  "----------------------------------------------------",
  "-- below this line machine-generated",
  "----------------------------------------------------",
  ""
 ]

predefInst typ patt = let gtyp = gId typ in
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
hDatatype (cat,rules) =
 "data" +++ gId cat +++ "=" ++
 (if length rules == 1 then "" else "\n  ") +++
 foldr1 (\x y -> x ++ "\n |" +++ y) 
        [gId f +++ foldr (+++) "" (map gId xx) | (f,xx) <- rules] ++++
 "  deriving Show"

----hInstance m ("Cn",_) = "" --- seems to belong to an old applic. AR 18/5/2004
hInstance m (cat,[]) = ""
hInstance m (cat,rules) = 
 "instance Gf" +++ gId cat +++ "where" ++
 (if length rules == 1 then "" else "\n") +++
 foldr1 (\x y -> x ++ "\n" +++ y) [mkInst f xx | (f,xx) <- rules]
   where
    mkInst f xx =
     "gf " ++
     (if length xx == 0 then gId f else prParenth (gId f +++ foldr1 (+++) xx')) +++
     "=" +++
     "appqc \"" ++ m ++ "\" \"" ++ f ++ "\"" +++ 
     "[" ++ prTList ", " ["gf" +++ x | x <- xx'] ++ "]"
       where xx' = ["x" ++ show i | (_,i) <- zip xx [1..]]

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
     "->" +++
     gId f +++  
     prTList " " [prParenth ("fg" +++ x) | x <- xx']
       where xx' = ["x" ++ show i | (_,i) <- zip xx [1..]]

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

