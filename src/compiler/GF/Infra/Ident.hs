----------------------------------------------------------------------
-- |
-- Module      : Ident
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/15 11:43:33 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.8 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Infra.Ident (-- ** Identifiers
          ModuleName(..), moduleNameS,
          Ident, ident2utf8, showIdent, prefixIdent,
          -- *** Normal identifiers (returned by the parser)
          identS, identC, identW,
          -- *** Special identifiers for internal use
          identV, identA, identAV,
          argIdent, isArgIdent, getArgIndex,
          varStr, varX, isWildIdent, varIndex,
          -- *** Raw identifiers
          RawIdent, rawIdentS, rawIdentC, ident2raw, prefixRawIdent,
          isPrefixOf, showRawIdent
	     ) where

import qualified Data.ByteString.UTF8 as UTF8
import qualified Data.ByteString.Char8 as BS(append,isPrefixOf)
                 -- Limit use of BS functions to the ones that work correctly on
                 -- UTF-8-encoded bytestrings!
import Data.Char(isDigit)
import Data.Binary(Binary(..))
import GF.Text.Pretty


-- | Module names
newtype ModuleName = MN Ident deriving (Eq,Ord)

moduleNameS = MN . identS

instance Show ModuleName where showsPrec d (MN m) = showsPrec d m
instance Pretty ModuleName where pp (MN m) = pp m


-- | the constructors labelled /INTERNAL/ are
-- internal representation never returned by the parser
data Ident = 
   IC  {-# UNPACK #-} !RawIdent                                           -- ^ raw identifier after parsing, resolved in Rename
 | IW                                                                     -- ^ wildcard
--
-- below this constructor: internal representation never returned by the parser
 | IV  {-# UNPACK #-} !RawIdent {-# UNPACK #-} !Int                       -- ^ /INTERNAL/ variable
 | IA  {-# UNPACK #-} !RawIdent {-# UNPACK #-} !Int                       -- ^ /INTERNAL/ argument of cat at position
 | IAV {-# UNPACK #-} !RawIdent {-# UNPACK #-} !Int {-# UNPACK #-} !Int   -- ^ /INTERNAL/ argument of cat with bindings at position
-- 
  deriving (Eq, Ord, Show, Read)

-- | Identifiers are stored as UTF-8-encoded bytestrings.
-- (It is also possible to use regular Haskell 'String's, with somewhat
-- reduced performance and increased memory use.)
newtype RawIdent = Id { rawId2utf8 :: UTF8.ByteString }
  deriving (Eq, Ord, Show, Read)

pack = UTF8.fromString
unpack = UTF8.toString

rawIdentS = Id . pack
rawIdentC = Id
showRawIdent = unpack . rawId2utf8

prefixRawIdent (Id x) (Id y) = Id (BS.append x y) 
isPrefixOf (Id x) (Id y) = BS.isPrefixOf x y

instance Binary RawIdent where
  put = put . rawId2utf8
  get = fmap rawIdentC get


-- | This function should be used with care, since the returned ByteString is
-- UTF-8-encoded.
ident2utf8 :: Ident -> UTF8.ByteString
ident2utf8 i = case i of
  IC (Id s) -> s
  IV (Id s) n -> BS.append s (pack ('_':show n))
  IA (Id s) j -> BS.append s (pack ('_':show j))
  IAV (Id s) b j -> BS.append s (pack ('_':show b ++ '_':show j))
  IW -> pack "_"

ident2raw = Id . ident2utf8

showIdent :: Ident -> String
showIdent i = unpack $! ident2utf8 i

instance Pretty Ident where pp = pp . showIdent

identS :: String -> Ident
identS = identC . rawIdentS

identC :: RawIdent -> Ident
identW :: Ident


prefixIdent :: String -> Ident -> Ident
prefixIdent pref = identC . Id . BS.append (pack pref) . ident2utf8

-- normal identifier
-- ident s = IC s

identV :: RawIdent -> Int -> Ident
identA :: RawIdent -> Int -> Ident
identAV:: RawIdent -> Int -> Int -> Ident

(identC, identV, identA, identAV, identW) = 
    (IC,     IV,     IA,     IAV,     IW)

-- | to mark argument variables
argIdent :: Int -> Ident -> Int -> Ident
argIdent 0 (IC c) i = identA  c i
argIdent b (IC c) i = identAV c b i

isArgIdent IA{}  = True
isArgIdent IAV{} = True
isArgIdent _     = False

getArgIndex (IA _ i)    = Just i
getArgIndex (IAV _ _ i) = Just i
getArgIndex (IC (Id bs))
  | isDigit c =
   -- (Just . read . unpack . snd . BS.spanEnd isDigit) bs -- not ok with UTF-8
      (Just . read . reverse . takeWhile isDigit) s
  where s@(c:_) = reverse (unpack bs)
getArgIndex x = Nothing

-- | used in lin defaults
varStr :: Ident
varStr = identA (rawIdentS "str") 0

-- | refreshing variables
varX :: Int -> Ident
varX = identV (rawIdentS "x")

isWildIdent :: Ident -> Bool
isWildIdent x = case x of
  IW -> True
  IC s | s == wild -> True
  _ -> False

wild = Id (pack "_")

varIndex :: Ident -> Int
varIndex (IV _ n) = n
varIndex _ = -1 --- other than IV should not count
