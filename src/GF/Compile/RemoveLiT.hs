----------------------------------------------------------------------
-- |
-- Module      : RemoveLiT
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:09 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
-- remove obsolete (Lin C) expressions before doing anything else. AR 21/6/2003
--
-- What the program does is replace the occurrences of Lin C with the actual
-- definition T given in lincat C = T ; with {s : Str} if no lincat is found.
-- The procedure is uncertain, if T contains another Lin.
-----------------------------------------------------------------------------

module RemoveLiT (removeLiT) where

import Grammar
import Ident
import Modules
import Macros
import Lookup

import Operations

import Monad

removeLiT :: SourceGrammar -> Err SourceGrammar
removeLiT gr = liftM MGrammar $ mapM (remlModule gr) (modules gr)

remlModule :: SourceGrammar -> (Ident,SourceModInfo) -> Err (Ident,SourceModInfo)
remlModule gr mi@(name,mod) = case mod of
  ModMod (Module mt st fs me ops js) -> do
    js1 <- mapMTree (remlResInfo gr) js
    let mod2 = ModMod $ Module mt st fs me ops js1
    return $ (name,mod2)
  _ -> return mi

remlResInfo :: SourceGrammar -> (Ident,Info) -> Err (Ident,Info)
remlResInfo gr mi@(i,info) = case info of
  ResOper pty ptr    -> liftM ((,) i) $ liftM2 ResOper (ren pty) (ren ptr)
  CncCat pty ptr ppr -> liftM ((,) i) $ liftM3 CncCat (ren pty) (ren ptr) (ren ppr)
  CncFun mt  ptr ppr -> liftM ((,) i) $ liftM2 (CncFun mt)      (ren ptr) (ren ppr)
  _ -> return mi
 where 
   ren = remlPerh gr

remlPerh gr pt = case pt of
  Yes t -> liftM Yes $ remlTerm gr t
  _ -> return pt

remlTerm :: SourceGrammar -> Term -> Err Term
remlTerm gr trm = case trm of
  LiT c -> look c >>= remlTerm gr
  _ -> composOp (remlTerm gr) trm
 where
   look c = err (const $ return defLinType) return $ lookupLincat gr m c
   m = case [cnc | (cnc,ModMod m) <- modules gr, isModCnc m] of
     cnc:_ -> cnc   -- actually there is always exactly one
     _ -> zIdent "CNC" 
