----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/08/11 14:11:46 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.10 $
--
-- All possible instantiations of different grammar formats used in conversion from GFC
-----------------------------------------------------------------------------


module GF.Conversion.Types where

import qualified GF.Infra.Ident as Ident (Ident(..), wildIdent, isWildIdent)
import qualified GF.Canon.AbsGFC as AbsGFC (CIdent(..), Label(..))
import qualified GF.Grammar.Grammar as Grammar (Term)
import qualified GF.Grammar.Values as Values (cString, cInt, cFloat)

import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC
import GF.Formalism.MCFG
import GF.Formalism.FCFG
import GF.Formalism.CFG
import GF.Formalism.Utilities
import GF.Infra.Print
import GF.Data.Assoc

import Control.Monad (foldM)
import Data.Array

----------------------------------------------------------------------
-- * basic (leaf) types

-- ** input tokens

type Token = String

-- ** function names

type Fun  = Ident.Ident
type Name = NameProfile Fun


----------------------------------------------------------------------
-- * Simple GFC

type SCat = Ident.Ident

constr2fun :: Constr -> Fun
constr2fun (AbsGFC.CIQ _ fun) = fun

-- ** grammar types

type SGrammar = SimpleGrammar SCat Name Token
type SRule    = SimpleRule    SCat Name Token

type SPath    = Path    SCat Token
type STerm    = Term    SCat Token
type SLinType = LinType SCat Token
type SDecl    = Decl    SCat

----------------------------------------------------------------------
-- * erasing MCFG

type EGrammar = MCFGrammar ECat Name ELabel Token
type ERule    = MCFRule    ECat Name ELabel Token
data ECat     = ECat SCat [Constraint]   deriving (Eq, Ord, Show)
type ELabel   = SPath

type Constraint = (SPath, STerm)

-- ** type coercions etc

initialECat :: SCat -> ECat
initialECat cat = ECat cat []

ecat2scat :: ECat -> SCat
ecat2scat (ECat cat _) = cat

ecatConstraints :: ECat -> [Constraint]
ecatConstraints (ECat _ cns) = cns

sameECat :: ECat -> ECat -> Bool
sameECat ec1 ec2 = ecat2scat ec1 == ecat2scat ec2

coercionName :: Name
coercionName = Name Ident.wildIdent [Unify [0]]

isCoercion :: Name -> Bool
isCoercion (Name fun [Unify [0]]) = Ident.isWildIdent fun
isCoercion _ = False

----------------------------------------------------------------------
-- * nonerasing MCFG

type MGrammar = MCFGrammar MCat Name MLabel Token
type MRule    = MCFRule    MCat Name MLabel Token
data MCat     = MCat ECat [ELabel]   deriving (Eq, Ord, Show)
type MLabel   = ELabel

mcat2ecat :: MCat -> ECat
mcat2ecat (MCat cat _) = cat

mcat2scat :: MCat -> SCat
mcat2scat = ecat2scat . mcat2ecat

----------------------------------------------------------------------
-- * fast nonerasing MCFG

type FGrammar = FCFGrammar FCat Name Token
type FRule    = FCFRule    FCat Name Token
data FCat     = FCat  {-# UNPACK #-} !Int SCat [SPath] [(SPath,STerm)]

initialFCat :: SCat -> FCat
initialFCat cat = FCat 0 cat [] []

fcatString = FCat (-1) Values.cString [Path [Left (AbsGFC.L (Ident.IC "s"))]] []
fcatInt    = FCat (-2) Values.cInt    [Path [Left (AbsGFC.L (Ident.IC "s"))]] []
fcatFloat  = FCat (-3) Values.cFloat  [Path [Left (AbsGFC.L (Ident.IC "s"))]] []

fcat2scat :: FCat -> SCat
fcat2scat (FCat _ c _ _) = c

instance Eq FCat where
  (FCat id1 _ _ _) == (FCat id2 _ _ _) = id1 == id2

instance Ord FCat where
  compare (FCat id1 _ _ _) (FCat id2 _ _ _) = compare id1 id2

----------------------------------------------------------------------
-- * CFG

type CGrammar = CFGrammar CCat Name Token
type CRule    = CFRule    CCat Name Token
data CCat     = CCat      ECat ELabel  deriving (Eq, Ord, Show)

ccat2ecat :: CCat -> ECat
ccat2ecat (CCat cat _) = cat

ccat2scat :: CCat -> SCat
ccat2scat = ecat2scat . ccat2ecat

----------------------------------------------------------------------
-- * pretty-printing

instance Print ECat where
    prt (ECat cat constrs) = prt cat ++ "{" ++ 
			     concat [ prt path ++ "=" ++ prt term ++ ";" |
				      (path, term) <- constrs ] ++ "}"

instance Print MCat where
    prt (MCat cat labels) = prt cat ++ prt labels

instance Print CCat where
    prt (CCat cat label) = prt cat ++ prt label

instance Print FCat where
    prt (FCat _ cat rcs tcs) = prt cat ++ "{" ++ 
			       prtSep ";" ([prt path                    |  path       <- rcs] ++
			                   [prt path ++ "=" ++ prt term | (path,term) <- tcs])
			               ++ "}"

