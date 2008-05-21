----------------------------------------------------------------------
-- |
-- Module      : GrammarToTransfer
-- Maintainer  : Björn Bringert
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/17 12:39:07 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.8 $
--
-- Creates a data type definition in the transfer language
-- for an abstract module.
-----------------------------------------------------------------------------

module GF.API.GrammarToTransfer (grammar2transfer) where

import qualified GF.Canon.GFC as GFC
import qualified GF.Grammar.Abstract as A
import GF.Grammar.Macros

import GF.Infra.Modules
import GF.Data.Operations

import Transfer.Syntax.Abs as S
import Transfer.Syntax.Print


-- | the main function
grammar2transfer :: GFC.CanonGrammar -> String
grammar2transfer gr = printTree $ S.Module imports decls
  where
  cat = S.Ident "Cat" -- FIXME
  tree = S.Ident "Tree" -- FIXME
  defs = concat [tree2list (jments m) | im@(_,ModMod m) <- modules gr, isModAbs m]
  -- get category name and context
  cats = [(cat, c) | (cat,GFC.AbsCat c _) <- defs]
  -- get function name and type
  funs = [(fun, typ) | (fun,GFC.AbsFun typ _) <- defs]
  name = ifNull "UnknownModule" (symid . last) [n | (n,ModMod m) <- modules gr, isModAbs m]
  imports = [Import (S.Ident "prelude")]
  decls = [cats2cat cat tree cats, funs2tree cat tree funs] ++ instances tree


-- | Create a declaration of the type of categories given a list
--   of category names and their contexts.
cats2cat :: S.Ident -- ^ the name of the Cat type
         -> S.Ident -- ^ the name of the Tree type
         -> [(A.Ident,A.Context)] -> Decl
cats2cat cat tree = S.DataDecl cat S.EType . map (uncurry catCons)
  where
  catCons i c = S.ConsDecl (id2id i) (catConsType c)
  catConsType = foldr pi (S.EVar cat)
  pi (i,x) t = mkPi (id2pv i) (addTree tree $ term2exp x) t

funs2tree :: S.Ident -- ^ the name of the Cat type
          -> S.Ident -- ^ the name of the Tree type
          -> [(A.Ident,A.Type)] -> Decl
funs2tree cat tree = 
    S.DataDecl tree (S.EPiNoVar (S.EVar cat) S.EType) . map (uncurry funCons)
  where 
  funCons i t = S.ConsDecl (id2id i) (addTree tree $ term2exp t)

term2exp :: A.Term -> S.Exp
term2exp t = case t of
  A.Vr i         -> S.EVar (id2id i)
  A.App t1 t2    -> S.EApp (term2exp t1) (term2exp t2)
  A.Abs i t1     -> S.EAbs (id2pv i) (term2exp t1)
  A.Prod i t1 t2 -> mkPi (id2pv i) (term2exp t1) (term2exp t2)
  A.Q m i        -> S.EVar (id2id i)
  _ -> error $ "term2exp: can't handle " ++ show t

mkPi :: S.VarOrWild -> S.Exp -> S.Exp -> S.Exp 
mkPi VWild t e = S.EPiNoVar t e
mkPi v     t e = S.EPi v t e

id2id :: A.Ident -> S.Ident
id2id = S.Ident . symid

id2pv :: A.Ident -> S.VarOrWild
id2pv i = case symid i of
                       "h_" -> S.VWild -- FIXME: hacky?
                       x    -> S.VVar (S.Ident x)

-- FIXME: I think this is not general enoguh.
addTree :: S.Ident -> S.Exp -> S.Exp
addTree tree x = case x of
  S.EPi i t e -> S.EPi i (addTree tree t) (addTree tree e)
  S.EPiNoVar t e -> S.EPiNoVar (addTree tree t) (addTree tree e)
  e -> S.EApp (S.EVar tree) e

instances :: S.Ident -> [S.Decl]
instances tree = [DeriveDecl (S.Ident "Eq") tree, 
                  DeriveDecl (S.Ident "Compos") tree]
