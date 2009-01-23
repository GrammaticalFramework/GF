----------------------------------------------------------------------
-- |
-- Module      : PrGrammar
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/04 11:45:38 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.16 $
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
--		  prt_Tree, prMarkedTree, prTree,
--		  tree2string, prprTree,
		  prConstrs, prConstraints, 
--		  prMetaSubst, prEnv, prMSubst, 
		  prExp, prOperSignature,
                  lookupIdent, lookupIdentInfo, lookupIdentInfoIn,
                  prTermTabular
		 ) where

import GF.Data.Operations
--import GF.Data.Zipper
import GF.Grammar.Grammar
import GF.Infra.Modules
import qualified GF.Source.PrintGF as P
import GF.Grammar.Values
import GF.Source.GrammarToSource
--- import GFC (CanonGrammar) --- cycle of modules

import GF.Infra.Option
import GF.Infra.Ident

import GF.Infra.CompactPrint

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

pprintTree :: P.Print a => a -> String
pprintTree = compactPrint . P.printTree

prGrammar :: SourceGrammar -> String
prGrammar = pprintTree . trGrammar

prModule :: SourceModule -> String
prModule  = pprintTree . trModule

instance Print Term where
  prt = pprintTree . trt
  prt_ = prExp

instance Print Ident where
  prt = pprintTree . tri

instance Print Patt where
  prt = pprintTree . trp
  prt_ = prt . unqual where
    unqual p = case p of
      PP _ c [] -> PV c --- to remove curlies
      PP _ c ps -> PC c (map unqual ps)
      PC   c ps -> PC c (map unqual ps)
      _ -> p ---- records

instance Print Label where
  prt = pprintTree . trLabel

instance Print MetaSymb where
  prt (MetaSymb i) = "?" ++ show i

prParam :: Param -> String
prParam (c,co) = prt c +++ prContext co

prContext :: Context -> String
prContext co = unwords $ map prParenth [prt x +++ ":" +++ prt t | (x,t) <- co]

-- some GFC notions
{-
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
-}

-- auxiliaries

prConstraints :: Constraints -> String
prConstraints = concat . prConstrs

prMetaSubst :: MetaSubst -> String
prMetaSubst = concat . prMSubst
  
prConstrs :: Constraints -> [String]
prConstrs = map (\ (v,w) -> prCurly (prt v ++ "<>" ++ prt w))

prMSubst :: MetaSubst -> [String]
prMSubst = map (\ (m,e) -> prCurly ("?" ++ show m ++ "=" ++ prt e))

prBinds bi = if null bi 
                then [] 
                else "\\" ++ concat (intersperse "," (map prValDecl bi)) +++ "-> "
 where
   prValDecl (x,t) = prParenth (prt_ x +++ ":" +++ prt_ t)
{-
instance Print Atom where
  prt (AtC f) = prQIdent f
  prt (AtM i) = prt i
  prt (AtV i) = prt i
  prt (AtL s) = prQuotedString s
  prt (AtI i) = show i
  prt (AtF i) = show i
  prt_ (AtC (_,f)) = prt f 
  prt_ a = prt a
-}
prEnv :: Env -> String
---- prEnv [] = prCurly "" ---- for debugging
prEnv e = concatMap (\ (x,t) -> prCurly (prt x ++ ":=" ++ prt t)) e


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

-- | option @-strip@ strips qualifications
prTermOpt :: Options -> Term -> String
prTermOpt opts = if PrinterStrip `elem` flag optPrinter opts then prt else prExp

-- | to get rid of brackets in the editor
prRefinement :: Term -> String
prRefinement t = case t of
    Q m c  -> prQIdent (m,c)
    QC m c -> prQIdent (m,c)
    _ -> prt t

prOperSignature :: (QIdent,Type) -> String
prOperSignature (f, t) = prQIdent f +++ ":" +++ prt t

-- to look up a constant etc in a search tree --- why here? AR 29/5/2008

lookupIdent :: Ident -> BinTree Ident b -> Err b
lookupIdent c t = case lookupTree prt c t of
  Ok v -> return v
  _ -> prtBad "unknown identifier" c

lookupIdentInfo :: ModInfo Ident a -> Ident -> Err a
lookupIdentInfo mo i = lookupIdent i (jments mo)

lookupIdentInfoIn :: ModInfo Ident a -> Ident -> Ident -> Err a
lookupIdentInfoIn mo m i = 
  err (\s -> Bad (s +++ "in module" +++ prt m)) return $ lookupIdentInfo mo i


--- printing cc command output AR 26/5/2008

prTermTabular :: Term -> [(String,String)]
prTermTabular = pr where
  pr t = case t of
    R rs   -> 
      [(prt_ lab +++ "." +++ path, str) | (lab,(_,val)) <- rs, (path,str) <- pr val]
    T _ cs -> 
      [(prt_ lab +++"=>" +++ path, str) | (lab,   val)  <- cs, (path,str) <- pr val]
    V _ cs -> 
      [("#" ++ show i +++"=>" +++ path, str) | (i,val)  <- zip [0..] cs, (path,str) <- pr val]
    _ -> [([],ps t)]
  ps t = case t of
    K s   -> s
    C s u -> ps s +++ ps u
    FV ts -> unwords (intersperse "/" (map ps ts))
    _ -> prt_ t 
