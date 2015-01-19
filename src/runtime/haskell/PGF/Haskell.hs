-- | Auxiliary types and functions for use with grammars translated to Haskell
-- with @gf -output-format=haskell -haskell=concrete@
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies, FlexibleInstances #-}
module PGF.Haskell where
import Control.Applicative((<$>))
import Data.Char(toUpper)
import Data.List(isPrefixOf)
import qualified Data.Map as M

-- ** Concrete syntax

-- | For enumerating parameter values used in tables
class EnumAll a where enumAll :: [a]

-- | Tables
table vs = let m = M.fromList (zip enumAll vs) in (M.!) m


-- | Token sequences, output form linearization functions
type Str = [Tok] -- token sequence

-- | Tokens
data Tok = TK String | TP [([Prefix],Str)] Str | BIND | SOFT_BIND | CAPIT
         deriving (Eq,Ord,Show)

type Prefix = String -- ^ To be matched with the prefix of a following token

-- | Render a token sequence as a 'String'
fromStr :: Str -> String
fromStr = from False False
  where
    from space cap ts =
      case ts of
        [] -> []
        TK s:ts -> put s++from True cap ts
        BIND:ts -> from False cap ts
        SOFT_BIND:ts -> from False cap ts
        CAPIT:ts -> from space True ts
        TP alts def:ts -> from space cap (pick alts def r++[TK r]) -- hmm
          where r = fromStr ts
      where
        put s = [' '|space]++up s
        up = if cap then toUpper1 else id

    toUpper1 (c:s) = toUpper c:s
    toUpper1 s     = s

    pick alts def r = head ([str|(ps,str)<-alts,any (`isPrefixOf` r) ps]++[def])

-- *** Common record types

-- | Overloaded function to project the @s@ field from any record type
class Has_s r a | r -> a where proj_s :: r -> a

-- | Haskell representation of the GF record type @{s:t}@
data R_s t = R_s t deriving (Eq,Ord,Show)
instance (EnumAll t) => EnumAll (R_s t) where
    enumAll = (R_s <$> enumAll)
instance Has_s (R_s t) t where proj_s (R_s t) = t

-- | Coerce from any record type @{...,s:t,...}@ field to the supertype @{s:t}@
to_R_s r = R_s (proj_s r)
