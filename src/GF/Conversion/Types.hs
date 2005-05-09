----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/09 09:28:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.8 $
--
-- All possible instantiations of different grammar formats used in conversion from GFC
-----------------------------------------------------------------------------


module GF.Conversion.Types where

import qualified GF.Infra.Ident as Ident (Ident, wildIdent, isWildIdent)
import qualified GF.Canon.AbsGFC as AbsGFC (CIdent(..))
import qualified GF.Grammar.Grammar as Grammar (Term)

import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC
import GF.Formalism.MCFG
import GF.Formalism.CFG
import GF.Formalism.Utilities
import GF.Infra.Print
import GF.Data.Assoc

import Control.Monad (foldM)

----------------------------------------------------------------------
-- * basic (leaf) types

-- ** input tokens

type Token = String

-- ** function names

type Fun  = Ident.Ident
data Name = Name Fun [Profile (SyntaxForest Fun)]
	    deriving (Eq, Ord, Show)

name2fun :: Name -> Fun
name2fun (Name fun _) = fun

----------------------------------------------------------------------
-- * profiles

-- | A profile is a simple representation of a function on a number of arguments.
-- We only use lists of profiles
data Profile a = Unify [Int] -- ^ The Int's are the argument positions.
			     -- 'Unify []' will become a metavariable,
			     -- 'Unify [a,b]' means that the arguments are equal,
	       | Constant a
		 deriving (Eq, Ord, Show)

instance Functor Profile where
    fmap f (Constant a) = Constant (f a)
    fmap f (Unify xs)   = Unify xs

-- | a function name where the profile does not contain arguments 
-- (i.e. denoting a constant, not a function)
constantNameToForest :: Name -> SyntaxForest Fun
constantNameToForest name@(Name fun profile) = FNode fun [map unConstant profile] 
    where unConstant (Constant a) = a
	  unConstant (Unify [])   = FMeta
	  unConstant _ = error $ "constantNameToForest: the profile should not contain arguments: " ++ prt name

-- | profile application; we need some way of unifying a list of arguments
applyProfile :: ([b] -> a) -> [Profile a] -> [b] -> [a]
applyProfile unify profile args = map apply profile
    where apply (Unify xs)  = unify $ map (args !!) xs
	  apply (Constant a) = a

-- | monadic profile application
applyProfileM :: Monad m => ([b] -> m a) -> [Profile a] -> [b] -> m [a]
applyProfileM unify profile args = mapM apply profile
    where apply (Unify xs)  = unify $ map (args !!) xs
	  apply (Constant a) = return a

-- | profile composition: 
-- 
-- >   applyProfile u z (ps `composeProfiles` qs) args
-- >      ==
-- >   applyProfile u z ps (applyProfile u z qs args)
--
-- compare with function composition
--
-- >   (p . q) arg
-- >      ==
-- >   p (q arg)
--
-- Note that composing an 'Constant' with two or more arguments returns an error
-- (since 'Unify' can only take arguments) -- this might change in the future, if there is a need.
composeProfiles :: [Profile a] -> [Profile a] -> [Profile a]
composeProfiles ps qs = map compose ps
    where compose (Unify [x]) = qs !! x
	  compose (Unify xs)  = Unify [ y | x <- xs, let Unify ys = qs !! x, y <- ys ]
	  compose constant    = constant



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

instance Print Name where
    prt (Name fun profile) = prt fun ++ prt profile

instance Print a => Print (Profile a) where
    prt (Unify [])   = "?"
    prt (Unify args) = prtSep "=" args
    prt (Constant a) = prt a


