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

import Transfer.Core.Abs as C
import Transfer.Core.Print


-- | the main function
grammar2transfer :: GFC.CanonGrammar -> String
grammar2transfer gr = printTree $ C.Module [cats2cat cat tree cats, funs2tree cat tree funs]
  where
  cat = C.CIdent "Cat" -- FIXME
  tree = C.CIdent "Tree" -- FIXME
  defs = concat [tree2list (jments m) | im@(_,ModMod m) <- modules gr, isModAbs m]
  -- get category name and context
  cats = [(cat, c) | (cat,GFC.AbsCat c _) <- defs]
  -- get function name and type
  funs = [(fun, typ) | (fun,GFC.AbsFun typ _) <- defs]
  name = ifNull "UnknownModule" (symid . last) [n | (n,ModMod m) <- modules gr, isModAbs m]




-- | Create a declaration of the type of categories given a list
--   of category names and their contexts.
cats2cat :: CIdent -- ^ the name of the Cat type
         -> CIdent -- ^ the name of the Tree type
         -> [(A.Ident,A.Context)] -> Decl
cats2cat cat tree = C.DataDecl cat C.EType . map (uncurry catCons)
  where
  catCons i c = C.ConsDecl (id2id i) (catConsType c)
  catConsType = foldr pi (C.EVar cat)
  pi (i,x) t = C.EPi (id2pv i) (addTree tree $ term2exp x) t

funs2tree :: CIdent -- ^ the name of the Cat type
          -> CIdent -- ^ the name of the Tree type
          -> [(A.Ident,A.Type)] -> Decl
funs2tree cat tree = 
    C.DataDecl tree (C.EPi C.PVWild (EVar cat) C.EType) . map (uncurry funCons)
  where 
  funCons i t = C.ConsDecl (id2id i) (addTree tree $ term2exp t)

term2exp :: A.Term -> C.Exp
term2exp t = case t of
  A.Vr i         -> C.EVar (id2id i)
  A.App t1 t2    -> C.EApp (term2exp t1) (term2exp t2)
  A.Abs i t1     -> C.EAbs (id2pv i) (term2exp t1)
  A.Prod i t1 t2 -> C.EPi (id2pv i) (term2exp t1) (term2exp t2)
  A.Q m i        -> C.EVar (id2id i)
  _ -> error $ "term2exp: can't handle " ++ show t

id2id :: A.Ident -> C.CIdent
id2id = CIdent . symid

id2pv :: A.Ident -> PatternVariable
id2pv = C.PVVar . id2id

-- FIXME: I think this is not general enoguh.
addTree :: CIdent -> C.Exp -> C.Exp
addTree tree x = case x of
  C.EPi i t e -> C.EPi i (addTree tree t) (addTree tree e)
  e -> C.EApp (C.EVar tree) e