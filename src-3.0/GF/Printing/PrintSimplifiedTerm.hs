----------------------------------------------------------------------
-- |
-- Module      : PrintSimplifiedTerm
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/17 14:15:19 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.4 $
--
-- Instances for printing terms in a simplified format
-----------------------------------------------------------------------------


module GF.Printing.PrintSimplifiedTerm () where

import GF.Canon.AbsGFC
import GF.CF.CF
import GF.CF.CFIdent
import GF.Printing.PrintParser
import qualified GF.Canon.PrintGFC as P

instance Print Term where
    prt (Arg arg)         = prt arg
    prt (con `Par` [])    = prt con
    prt (con `Par` terms) = prt con ++ "(" ++ prtSep ", " terms ++ ")"
    prt (LI ident)        = prt ident
    prt (R record)        = "{" ++ prtSep ";" record ++ "}"
    prt (term `P` lbl)    = prt term ++ "." ++ prt lbl
    prt (T _ table)       = "table{" ++ prtSep ";" table ++ "}"
    prt (term `S` sel)    = prt term ++ "!" ++ prt sel
    prt (FV terms)        = "variants{" ++ prtSep "|" terms ++ "}"
    prt (term `C` term')  = prt term ++ "  " ++ prt term'
    prt (K tokn)          = show (prt tokn)
    prt (E)               = show ""

instance Print Patt where
    prt (con `PC` [])     = prt con
    prt (con `PC` pats)   = prt con ++ "(" ++ prtSep "," pats ++ ")"
    prt (PV ident)        = prt ident
    prt (PW)              = "_"
    prt (PR record)       = "{" ++ prtSep ";" record ++ "}"

instance Print Label where
    prt (L ident)          = prt ident
    prt (LV nr)            = "$" ++ show nr

instance Print Tokn where
    prt (KS str)          = str
    prt tokn@(KP _ _)     = show tokn

instance Print ArgVar where
    prt (A cat argNr)     = prt cat ++ "#" ++ show argNr

instance Print CIdent where
    prt (CIQ _ ident)     = prt ident

instance Print Case where
    prt (pats `Cas` term) = prtSep "|" pats ++ "=>" ++ prt term

instance Print Assign where
    prt (lbl `Ass` term)  = prt lbl ++ "=" ++ prt term

instance Print PattAssign where
    prt (lbl `PAss` pat)  = prt lbl ++ "=" ++ prt pat

instance Print Atom where
    prt (AC c) = prt c
    prt (AD c) = "<" ++ prt c ++ ">"
    prt (AV i) = "$" ++ prt i
    prt (AM n) = "?" ++ show n
    prt (AS s) = show s
    prt (AI n) = show n
    prt (AT s) = show s

instance Print CType where
    prt (RecType rtype) = "{" ++ prtSep ";" rtype ++ "}"
    prt (Table ptype vtype) = "(" ++ prt ptype ++ "=>" ++ prt vtype ++ ")"
    prt (Cn cn) = prt cn
    prt (TStr) = "Str"

instance Print Labelling where
    prt (lbl `Lbg` ctype) = prt lbl ++ ":" ++ prt ctype

instance Print CFItem where
    prt (CFTerm regexp) = prt regexp
    prt (CFNonterm cat) = prt cat

instance Print RegExp where
    prt (RegAlts words) = "("++prtSep "|" words ++ ")"
    prt (RegSpec tok) = prt tok

instance Print CFTok where
    prt (TS str) = str
    prt tok = show tok

instance Print CFCat where
    prt (CFCat (cid,lbl)) = prt cid ++ "-" ++ prt lbl

instance Print CFFun where 
    prt (CFFun fun) = prt (fst fun)

instance Print Exp where
    prt = P.printTree


sizeCT :: CType -> Int
sizeCT (RecType rt) = 1 + sum [ sizeCT t | _ `Lbg` t <- rt ]
sizeCT (Table pt vt) = 1 + sizeCT pt + sizeCT vt
sizeCT (Cn cn) = 1
sizeCT (TStr) = 1

sizeT :: Term -> Int
sizeT (_ `Par` ts) = 2 + sum (map sizeT ts)
sizeT (R rec) = 1 + sum [ sizeT t | _ `Ass` t <- rec ]
sizeT (t `P` _) = 1 + sizeT t
sizeT (T _ tbl) = 1 + sum [ sum (map sizeP ps) + sizeT t | ps `Cas` t <- tbl ]
sizeT (t `S` s) = 1 + sizeT t + sizeT s
sizeT (t `C` t') = 1 + sizeT t + sizeT t'
sizeT (FV ts) = 1 + sum (map sizeT ts)
sizeT _ = 1

sizeP :: Patt -> Int
sizeP (con `PC` pats) = 2 + sum (map sizeP pats)
sizeP (PR record)     = 1 + sum [ sizeP p | _ `PAss` p <- record ]
sizeP _ = 1
