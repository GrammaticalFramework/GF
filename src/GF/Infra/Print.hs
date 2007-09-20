----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/17 14:15:18 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.4 $
--
-- Pretty-printing
-----------------------------------------------------------------------------

module GF.Infra.Print
    (module GF.Infra.PrintClass
    ) where

-- haskell modules:
import Data.Char (toUpper)
-- gf modules:

import GF.Infra.PrintClass
import GF.Data.Operations (Err(..))
import GF.Infra.Ident (Ident(..))
import GF.Canon.AbsGFC
import GF.CF.CF
import GF.CF.CFIdent
import qualified GF.Canon.PrintGFC as P

------------------------------------------------------------

----------------------------------------------------------------------

instance Print Ident where
    prt = P.printTree 

instance Print Term where
    prt (Arg arg)         = prt arg
    prt (con `Par` [])    = prt con
    prt (con `Par` terms) = prt con ++ "(" ++ prtSep ", " terms ++ ")"
    prt (LI ident)        = "$" ++ prt ident
    prt (R record)        = "{" ++ prtSep "; " record ++ "}"
    prt (term `P` lbl)    = prt term ++ "." ++ prt lbl
    prt (T _ table)       = "table{" ++ prtSep "; " table ++ "}"
    prt (V _ terms)       = "values{" ++ prtSep "; " terms ++ "}"
    prt (term `S` sel)    = "(" ++ prt term ++ " ! " ++ prt sel ++ ")"
    prt (FV terms)        = "variants{" ++ prtSep " | " terms ++ "}"
    prt (term `C` term')  = prt term ++ "  " ++ prt term'
    prt (EInt n)          = prt n
    prt (K tokn)          = show (prt tokn)
    prt (E)               = show ""

instance Print Patt where
    prt (con `PC` [])     = prt con
    prt (con `PC` pats)   = prt con ++ "(" ++ prtSep "," pats ++ ")"
    prt (PV ident)        = "$" ++ prt ident
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
    prt atom   = show atom

instance Print CType where
    prt (RecType rtype) = "{" ++ prtSep "; " rtype ++ "}"
    prt (Table ptype vtype) = "(" ++ prt ptype ++ " => " ++ prt vtype ++ ")"
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
    prt (TC (c:str)) = '(' : toUpper c : ')' : str
    prt (TL str) = show str
    prt (TI n) = "#" ++ show n
    prt (TV x) = "$" ++ prt x
    prt (TM n s) = "?" ++ show n ++ s

instance Print CFCat where
    prt (CFCat (cid,lbl)) = prt cid ++ "-" ++ prt lbl

instance Print CFFun where 
    prt (CFFun fun) = prt (fst fun)

instance Print Exp where
    prt = P.printTree


