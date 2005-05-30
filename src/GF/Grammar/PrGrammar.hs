----------------------------------------------------------------------
-- |
-- Module      : PrGrammar
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 18:39:44 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.15 $
--
-- AR 7\/12\/1999 - 1\/4\/2000 - 10\/5\/2003
--
-- printing and prettyprinting class
--
-- 8\/1\/2004:
-- Usually followed principle: 'prt_' for displaying in the editor, 'prt'
-- in writing grammars to a file. For some constructs, e.g. 'prMarkedTree',
-- only the former is ever needed.
-----------------------------------------------------------------------------

module GF.Grammar.PrGrammar (Print(..),
		  prtBad,
		  prGrammar, prModule,
		  prContext, prParam,
		  prQIdent, prQIdent_,
		  prRefinement, prTermOpt,
		  prt_Tree, prMarkedTree, prTree,
		  tree2string, prprTree,
		  prConstrs, prConstraints, 
		  prMetaSubst, prEnv, prMSubst, 
		  prExp, prPatt, prOperSignature,
                  lookupIdent, lookupIdentInfo
		 ) where

import GF.Data.Operations
import GF.Data.Zipper
import GF.Grammar.Grammar
import GF.Infra.Modules
import qualified GF.Source.PrintGF as P
import qualified GF.Canon.PrintGFC as C
import qualified GF.Canon.AbsGFC as A
import GF.Grammar.Values
import GF.Source.GrammarToSource
--- import GFC (CanonGrammar) --- cycle of modules

import GF.Infra.Option
import GF.Infra.Ident
import GF.Data.Str

import Data.List (intersperse)

class Print a where
  prt  :: a -> String
  -- | printing with parentheses, if needed
  prt2 :: a -> String
  -- | pretty printing
  prpr :: a -> [String]
  -- | printing without ident qualifications
  prt_ :: a -> String 
  prt2 = prt
  prt_ = prt
  prpr = return . prt

-- 8/1/2004
--- Usually followed principle: prt_ for displaying in the editor, prt
--- in writing grammars to a file. For some constructs, e.g. prMarkedTree,
--- only the former is ever needed.

-- | to show terms etc in error messages
prtBad :: Print a => String -> a -> Err b
prtBad s a = Bad (s +++ prt a)

prGrammar :: SourceGrammar -> String
prGrammar = P.printTree . trGrammar

prModule :: (Ident, SourceModInfo) -> String
prModule  = P.printTree . trModule

instance Print Term where
  prt = P.printTree . trt
  prt_ = prExp

instance Print Ident where
  prt = P.printTree . tri

instance Print Patt where
  prt = P.printTree . trp

instance Print Label where
  prt = P.printTree . trLabel

instance Print MetaSymb where
  prt (MetaSymb i) = "?" ++ show i

prParam :: Param -> String
prParam (c,co) = prt c +++ prContext co

prContext :: Context -> String
prContext co = unwords $ map prParenth [prt x +++ ":" +++ prt t | (x,t) <- co]

-- some GFC notions

instance Print A.Exp where prt = C.printTree
instance Print A.Term where prt = C.printTree
instance Print A.Case where prt = C.printTree
instance Print A.CType where prt = C.printTree
instance Print A.Label where prt = C.printTree
instance Print A.Module where prt = C.printTree
instance Print A.Canon where prt = C.printTree
instance Print A.Sort where prt = C.printTree

instance Print A.Atom where 
  prt = C.printTree
  prt_ (A.AC c) = prt_ c
  prt_ (A.AD c) = prt_ c
  prt_ a = prt a

instance Print A.Patt where 
  prt = C.printTree
  prt_ = prPatt

instance Print A.CIdent where 
  prt = C.printTree
  prt_ (A.CIQ _ c) = prt c

-- printing values and trees in editing

instance Print a => Print (Tr a) where
  prt (Tr (n, trees)) = prt n +++ unwords (map prt2 trees)
  prt2 t@(Tr (_,args)) = if null args then prt t else prParenth (prt t)

-- | we cannot define the method prt_ in this way 
prt_Tree :: Tree -> String
prt_Tree = prt_ . tree2exp

instance Print TrNode where
  prt (N (bi,at,vt,(cs,ms),_)) = 
    prBinds bi ++ 
    prt at +++ ":" +++ prt vt 
    +++ prConstraints cs +++ prMetaSubst ms
  prt_ (N (bi,at,vt,(cs,ms),_)) = 
    prBinds bi ++ 
    prt_ at +++ ":" +++ prt_ vt 
    +++ prConstraints cs +++ prMetaSubst ms

prMarkedTree :: Tr (TrNode,Bool) -> [String]
prMarkedTree = prf 1 where
  prf ind t@(Tr (node, trees)) = 
    prNode ind node : concatMap (prf (ind + 2)) trees
  prNode ind node = case node of
    (n, False) -> indent ind (prt_ n)
    (n, _)     -> '*' : indent (ind - 1) (prt_ n)

prTree :: Tree -> [String]
prTree = prMarkedTree . mapTr (\n -> (n,False))

-- | a pretty-printer for parsable output
tree2string :: Tree -> String
tree2string = unlines . prprTree

prprTree :: Tree -> [String]
prprTree = prf False where
  prf par t@(Tr (node, trees)) = 
    parIf par (prn node : concat [prf (ifPar t) t | t <- trees])
  prn (N (bi,at,_,_,_)) = prb bi ++ prt_ at
  prb [] = ""
  prb bi = "\\" ++ concat (intersperse "," (map (prt_ . fst) bi)) ++ " -> "
  parIf par (s:ss) = map (indent 2) $
                         if par 
                            then ('(':s) : ss ++ [")"] 
                            else s:ss
  ifPar (Tr (N ([],_,_,_,_), [])) = False
  ifPar _ = True


-- auxiliaries

prConstraints :: Constraints -> String
prConstraints = concat . prConstrs

prMetaSubst :: MetaSubst -> String
prMetaSubst = concat . prMSubst
  
prEnv :: Env -> String
---- prEnv [] = prCurly "" ---- for debugging
prEnv e = concatMap (\ (x,t) -> prCurly (prt x ++ ":=" ++ prt t)) e

prConstrs :: Constraints -> [String]
prConstrs = map (\ (v,w) -> prCurly (prt v ++ "<>" ++ prt w))

prMSubst :: MetaSubst -> [String]
prMSubst = map (\ (m,e) -> prCurly ("?" ++ show m ++ "=" ++ prt e))

prBinds bi = if null bi 
                then [] 
                else "\\" ++ concat (intersperse "," (map prValDecl bi)) +++ "-> "
 where
   prValDecl (x,t) = prParenth (prt_ x +++ ":" +++ prt_ t)

instance Print Val where
  prt (VGen i x) = prt x ++ "{-" ++ show i ++ "-}" ---- latter part for debugging
  prt (VApp u v) = prt u +++ prv1 v
  prt (VCn mc) = prQIdent_ mc
  prt (VClos env e) = case e of
    Meta _ -> prt_ e ++ prEnv env
    _      -> prt_ e ---- ++ prEnv env ---- for debugging
  prt VType = "Type"
 
prv1 v = case v of
  VApp _ _  -> prParenth $ prt v
  VClos _ _ -> prParenth $ prt v
  _ -> prt v

instance Print Atom where
  prt (AtC f) = prQIdent f
  prt (AtM i) = prt i
  prt (AtV i) = prt i
  prt (AtL s) = s
  prt (AtI i) = show i
  prt_ (AtC (_,f)) = prt f 
  prt_ a = prt a

prQIdent :: QIdent -> String
prQIdent (m,f) = prt m ++ "." ++ prt f

prQIdent_ :: QIdent -> String
prQIdent_ (_,f) = prt f

-- | print terms without qualifications
prExp :: Term -> String
prExp e = case e of
  App f a    -> pr1 f +++ pr2 a
  Abs x b    -> "\\" ++ prt x +++ "->" +++ prExp b
  Prod x a b -> "(\\" ++ prt x +++ ":" +++ prExp a ++ ")" +++ "->" +++ prExp b
  Q _ c      -> prt c
  QC _ c     -> prt c  
  _ -> prt e
 where
   pr1 e = case e of
     Abs _ _    -> prParenth $ prExp e
     Prod _ _ _ -> prParenth $ prExp e
     _ -> prExp e
   pr2 e = case e of
     App _ _ -> prParenth $ prExp e
     _ -> pr1 e

prPatt :: A.Patt -> String
prPatt p = case p of
  A.PC c ps -> prt_ c +++ unwords (map pr1 ps)
  _ -> prt p --- PR
 where
   pr1 p = case p of
     A.PC _ (_:_) -> prParenth $ prPatt p
     _ -> prPatt p

-- | option @-strip@ strips qualifications
prTermOpt :: Options -> Term -> String
prTermOpt opts = if oElem nostripQualif opts then prt else prExp

-- | to get rid of brackets in the editor
prRefinement :: Term -> String
prRefinement t = case t of
    Q m c  -> prQIdent (m,c)
    QC m c -> prQIdent (m,c)
    _ -> prt t

prOperSignature :: (QIdent,Type) -> String
prOperSignature (f, t) = prQIdent f +++ ":" +++ prt t

-- to look up a constant etc in a search tree

lookupIdent :: Ident -> BinTree Ident b -> Err b
lookupIdent c t = case lookupTree prt c t of
  Ok v -> return v
  _ -> prtBad "unknown identifier" c

lookupIdentInfo :: Module Ident f a -> Ident -> Err a
lookupIdentInfo mo i = lookupIdent i (jments mo)
