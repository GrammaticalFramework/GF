-- Print a graph of module dependencies in Graphviz DOT format
module VisualizeGrammar where

import qualified Modules as M
import GFC
import Ident

import Data.List (intersperse)
import Data.Maybe (maybeToList)

data GrType = GrAbstract | GrConcrete | GrResource
	    deriving Show

data Node = Node { 
		  label :: String,
		  grtype :: GrType,
		  extends :: [String],
		  opens :: [String],
		  implements :: Maybe String
		  }
		  deriving Show


visualizeGrammar :: CanonGrammar -> String
visualizeGrammar gr = prGraph ns
    where
    ns = [ toNode i m | (i,M.ModMod m) <- M.modules gr ]

toNode :: Ident -> M.Module Ident f Info -> Node
toNode i m = Node {
		   label = prIdent i,
		   grtype = t,
		   extends = map prIdent (M.extends m),
		   opens = map openName (M.opens m),
		   implements = is
		  }
    where 
    (t,is) = case M.mtype m of
			  M.MTAbstract -> (GrAbstract, Nothing)
			  M.MTConcrete i -> (GrConcrete, Just (prIdent i))
			  M.MTResource -> (GrResource, Nothing)
			  -- FIXME: transfer and resource
    
openName :: M.OpenSpec Ident -> String
openName (M.OSimple q i) = prIdent i
openName (M.OQualif q i _) = prIdent i

prGraph :: [Node] -> String
prGraph ns = concat $ map (++"\n") $ ["digraph {\n"] ++ map prNode ns ++ ["}"]

prNode :: Node -> String
prNode n = concat (map (++";\n") stmts)
    where 
    l = label n
    stmts = [l ++ " [" ++ prAttributes attrs ++ "]"]
	    ++ map (prExtend l) (extends n)
	    ++ map (prOpen l) (opens n)
	    ++ map (prImplement l) (maybeToList (implements n))
    style = case grtype n of
			  GrAbstract -> "solid"
			  GrConcrete -> "dashed"
			  GrResource -> "dotted"
    attrs = [("style",style)]


prExtend :: String -> String -> String
prExtend f t = prEdge f t []

prOpen :: String -> String -> String
prOpen f t = prEdge f t [("style","dotted")]

prImplement :: String -> String -> String
prImplement f t = prEdge f t [("arrowhead","empty"),("style","dashed")]

prEdge :: String -> String -> [(String,String)] -> String
prEdge f t as = f ++ " -> " ++ t ++ " [" ++ prAttributes as ++ "]"

prAttributes :: [(String,String)] -> String
prAttributes = concat . intersperse ", " . map (\ (n,v) -> n ++ " = " ++ v)
