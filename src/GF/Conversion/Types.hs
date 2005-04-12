----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/12 10:49:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- All possible instantiations of different grammar formats used in conversion from GFC
-----------------------------------------------------------------------------


module GF.Conversion.Types where

import qualified Ident   (Ident, wildIdent, isWildIdent)
import qualified AbsGFC  (CIdent(..))
import qualified Grammar (Term)

import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC
import GF.Formalism.MCFG
import GF.Formalism.CFG
import GF.Formalism.Utilities
import GF.Infra.Print
import GF.Data.Assoc

import Monad (foldM)

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

-- | A profile is a simple representation of a function on a number of arguments.
-- We only use lists of profiles
data Profile a = Unify [Int] -- ^ The Int's are the argument positions.
			     -- 'Unify []' will become a metavariable,
			     -- 'Unify [a,b]' means that the arguments are equal,
	       | Epsilon a
		 deriving (Eq, Ord, Show)

-- | profile application; we need some way of unifying a list of arguments
applyProfile :: ([b] -> a) -> [Profile a] -> [b] -> [a]
applyProfile unify profile args = map apply profile
    where apply (Unify xs)  = unify $ map (args !!) xs
	  apply (Epsilon a) = a

-- | monadic profile application
applyProfileM :: Monad m => ([b] -> m a) -> [Profile a] -> [b] -> m [a]
applyProfileM unify profile args = mapM apply profile
    where apply (Unify xs)  = unify $ map (args !!) xs
	  apply (Epsilon a) = return a

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
-- Note that composing an 'Epsilon' with two or more arguments returns an error
-- (since 'Unify' can only take arguments) -- this might change in the future, if there is a need.
composeProfiles :: [Profile a] -> [Profile a] -> [Profile a]
composeProfiles ps qs = map compose ps
    where compose (Unify [x]) = qs !! x
	  compose (Unify xs)  = Unify [ y | x <- xs, let Unify ys = qs !! x, y <- ys ]
	  compose epsilon     = epsilon



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
type SType    = Type    SCat

----------------------------------------------------------------------
-- * MCFG

type MGrammar = MCFGrammar MCat Name MLabel Token
type MRule    = MCFRule    MCat Name MLabel Token
data MCat     = MCat SCat [Constraint] deriving (Eq, Ord, Show)
type MLabel   = SPath

type Constraint = (SPath, STerm)

-- ** type coercions etc

initialMCat :: SCat -> MCat
initialMCat cat = MCat cat []

mcat2scat :: MCat -> SCat
mcat2scat (MCat cat _) = cat

sameCat :: MCat -> MCat -> Bool
sameCat mc1 mc2 = mcat2scat mc1 == mcat2scat mc2

coercionName :: Name
coercionName = Name Ident.wildIdent [Unify [0]]

isCoercion :: Name -> Bool
isCoercion (Name fun [Unify [0]]) = Ident.isWildIdent fun
isCoercion _ = False

----------------------------------------------------------------------
-- * CFG

type CGrammar = CFGrammar CCat Name Token
type CRule    = CFRule    CCat Name Token

data CCat     = CCat      MCat MLabel
		deriving (Eq, Ord, Show)

----------------------------------------------------------------------
-- * pretty-printing

instance Print MCat where
    prt (MCat cat constrs) = prt cat ++ "{" ++ 
			     concat [ prt path ++ "=" ++ prt term ++ ";" |
				      (path, term) <- constrs ] ++ "}"

instance Print CCat where
    prt (CCat cat label) = prt cat ++ prt label

instance Print Name where
    prt (Name fun profile) = prt fun ++ prt profile

instance Print a => Print (Profile a) where
    prt (Unify [])   = "?"
    prt (Unify args) = prtSep "=" args
    prt (Epsilon a)  = prt a


