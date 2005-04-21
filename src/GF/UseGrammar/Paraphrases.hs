----------------------------------------------------------------------
-- |
-- Module      : Paraphrases
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:49 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.6 $
--
-- paraphrases of GF terms. AR 6\/10\/1998 -- 24\/9\/1999 -- 5\/7\/2000 -- 5\/6\/2002
--
-- Copyright (c) Aarne Ranta 1998--99, under GNU General Public License (see GPL)
--
-- thus inherited from the old GF. Incomplete and inefficient...
-----------------------------------------------------------------------------

module GF.UseGrammar.Paraphrases (mkParaphrases) where

import GF.Grammar.Abstract
import GF.Grammar.PrGrammar
import GF.Grammar.LookAbs
import GF.Grammar.AbsCompute

import GF.Data.Operations

import Data.List (nub)

-- paraphrases of GF terms. AR 6/10/1998 -- 24/9/1999 -- 5/7/2000 -- 5/6/2002
-- Copyright (c) Aarne Ranta 1998--99, under GNU General Public License (see GPL)
-- thus inherited from the old GF. Incomplete and inefficient...

mkParaphrases :: GFCGrammar -> Term -> [Term]
mkParaphrases st = nub . map (beta []) . paraphrases (allDefs st)

type Definition = (Fun,Term)

paraphrases :: [Definition] -> Term -> [Term]
paraphrases th t =
  paraImmed th t ++
---  paraMatch th t ++
  case t of
    App c a -> [App d b | d <- paraphrases th c, b <- paraphrases th a]
    Abs x b -> [Abs x d | d <- paraphrases th b]
    c       -> []
  ++ [t]

paraImmed :: [Definition] -> Term -> [Term]
paraImmed defs t = 
  [Q m f | ((m,f), u) <- defs, t == u] ++ --- eqTerm
  case t of
  ----  Cn c -> [u | (f, u) <- defs, eqStrIdent f c]
    _    -> []

{- ---
paraMatch :: [Definition] -> Trm -> [Trm]
paraMatch th@defs t = 
 [mkApp (Cn f) xx | (PC f zz, u) <- defs, 
                    let (fs,sn) = fullApp u, fs == h, length sn == length zz] ++
 case findAMatch defs t of
   Ok (g,b) -> [substTerm [] g b]
   _        -> []
  where 
    (h,xx)    = fullApp t
    fullApp c = case c of 
                  App f a -> (f', a' ++ [a]) where (f',a') = fullApp f
                  c       -> (c,[])

-}
