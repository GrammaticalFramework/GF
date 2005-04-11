----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:49 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- All possible instantiations of different grammar formats used in conversion from GFC
-----------------------------------------------------------------------------


module GF.Conversion.Types where

import qualified Ident
import qualified Grammar (Term)
import qualified Macros

import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC
import GF.Formalism.MCFG
import GF.Formalism.CFG
import GF.Infra.Print

----------------------------------------------------------------------
-- * MCFG

type MGrammar = MCFGrammar MCat Name MLabel Token
type MRule    = MCFRule    MCat Name MLabel Token
data MCat     = MCat Cat [Constraint] deriving (Eq, Ord, Show)
type MLabel   = Path

type Constraint = (Path, Term)

initialMCat :: Cat -> MCat
initialMCat cat = MCat cat []

mcat2cat :: MCat -> Cat
mcat2cat (MCat cat _) = cat

sameCat :: MCat -> MCat -> Bool
sameCat mc1 mc2 = mcat2cat mc1 == mcat2cat mc2

coercionName :: Name
coercionName = Ident.wildIdent

isCoercion :: Name -> Bool
isCoercion = Ident.isWildIdent

----------------------------------------------------------------------
-- * CFG

type CGrammar = CFGrammar CCat CName Token
type CRule    = CFRule    CCat CName Token

data CCat     = CCat      MCat MLabel
		deriving (Eq, Ord, Show)
data CName    = CName     Name Profile
		deriving (Eq, Ord, Show)
type Profile   = [[Int]]

----------------------------------------------------------------------
-- * pretty-printing

instance Print MCat where
    prt (MCat cat constrs) = prt cat ++ "{" ++ 
			     concat [ prt path ++ "=" ++ prt term ++ ";" |
				      (path, term) <- constrs ] ++ "}"

instance Print CCat where
    prt (CCat cat label) = prt cat ++ prt label

instance Print CName where
    prt (CName fun args) = prt fun ++ prt args



