----------------------------------------------------------------------
-- |
-- Module      : VisualizeGrammar
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:23 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.7 $
--
-- Print a graph of module dependencies in Graphviz DOT format
-----------------------------------------------------------------------------

module VisualizeGrammar ( visualizeCanonGrammar, 
			  visualizeSourceGrammar
			) where

import qualified Modules as M
import GFC
import Ident
import Grammar (SourceGrammar)

import Data.List (intersperse, nub)
import Data.Maybe (maybeToList)

data GrType = GrAbstract 
	    | GrConcrete 
	    | GrResource 
	    | GrInterface
	    | GrInstance
	    deriving Show

data Node = Node { 
		  label :: String,
		  url :: String,
		  grtype :: GrType,
		  extends :: [String],
		  opens :: [String],
		  implements :: Maybe String
		  }
		  deriving Show


visualizeCanonGrammar :: CanonGrammar -> String
visualizeCanonGrammar = prGraph . canon2graph

visualizeSourceGrammar :: SourceGrammar -> String
visualizeSourceGrammar = prGraph . source2graph

canon2graph :: CanonGrammar -> [Node]
canon2graph gr = [ toNode i m | (i,M.ModMod m) <- M.modules gr ]

source2graph :: SourceGrammar -> [Node]
source2graph gr = [ toNode i m | (i,M.ModMod m) <- M.modules gr ] -- FIXME: handle ModWith?

toNode :: Ident -> M.Module Ident f i -> Node
toNode i m = Node {
		   label = l,
		   url = l ++ ".gf", -- FIXME: might be in a different directory
		   grtype = t,
		   extends = map prIdent (M.extends m),
		   opens = nub $ map openName (M.opens m), -- FIXME: nub is needed because of triple open with 
		                                           -- instance modules
		   implements = is
		  }
    where 
    l = prIdent i
    (t,is) = fromModType (M.mtype m)

fromModType :: M.ModuleType Ident -> (GrType, Maybe String)
fromModType t = case t of
		       M.MTAbstract -> (GrAbstract, Nothing)
		       M.MTTransfer _ _ -> error "Can't visualize transfer modules yet" -- FIXME
		       M.MTConcrete i -> (GrConcrete, Just (prIdent i))
		       M.MTResource -> (GrResource, Nothing)
		       M.MTInterface -> (GrInterface, Nothing)
		       M.MTInstance i -> (GrInstance, Just (prIdent i))
		       M.MTReuse rt -> error "Can't visualize reuse modules yet" -- FIXME
		       M.MTUnion _ _ -> error "Can't visualize union modules yet" -- FIXME

-- | FIXME: there is something odd about OQualif with 'with' modules,
-- both names seem to be the same.
openName :: M.OpenSpec Ident -> String
openName (M.OSimple q i) = prIdent i
openName (M.OQualif q i _) = prIdent i

prGraph :: [Node] -> String
prGraph ns = concat $ map (++"\n") $ ["digraph {\n"] ++ map prNode ns ++ ["}"]

prNode :: Node -> String
prNode n = concat (map (++";\n") stmts)
    where 
    l = label n
    t = grtype n
    stmts = [l ++ " [" ++ prAttributes attrs ++ "]"]
	    ++ map (prExtend t l) (extends n)
	    ++ map (prOpen l) (opens n)
	    ++ map (prImplement t l) (maybeToList (implements n))
    (shape,style) = case t of
			   GrAbstract  -> ("ellipse","solid")
			   GrConcrete  -> ("box","dashed")
			   GrResource  -> ("ellipse","dashed")
			   GrInterface -> ("ellipse","dotted")
			   GrInstance  -> ("diamond","dotted")
    attrs = [("style", style),("shape", shape),("URL", url n)]


prExtend :: GrType -> String -> String -> String
prExtend g f t = prEdge f t [("style","solid")]

prOpen :: String -> String -> String
prOpen f t = prEdge f t [("style","dotted")]

prImplement :: GrType -> String -> String -> String
prImplement g f t = prEdge f t [("arrowhead","empty"),("style","dashed")]

prEdge :: String -> String -> [(String,String)] -> String
prEdge f t as = f ++ " -> " ++ t ++ " [" ++ prAttributes as ++ "]"

prAttributes :: [(String,String)] -> String
prAttributes = concat . intersperse ", " . map (\ (n,v) -> n ++ " = " ++ show v)
