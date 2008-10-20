module PGF.CId (CId(..), 
                mkCId, readCId, prCId,
                wildCId, 
                pCId, pIdent) where

import Control.Monad
import qualified Data.ByteString.Char8 as BS
import Data.Char
import qualified Text.ParserCombinators.ReadP as RP


-- | An abstract data type that represents
-- function identifier in PGF.
newtype CId = CId BS.ByteString deriving (Eq,Ord)

wildCId :: CId
wildCId = CId (BS.singleton '_')

-- | Creates a new identifier from 'String'
mkCId :: String -> CId
mkCId s = CId (BS.pack s)

readCId :: String -> Maybe CId
readCId s = case [x | (x,cs) <- RP.readP_to_S pCId s, all isSpace cs] of
              [x] -> Just x
              _   -> Nothing

-- | Renders the identifier as 'String'
prCId :: CId -> String
prCId (CId x) = BS.unpack x

instance Show CId where
    showsPrec _ = showString . prCId

instance Read CId where
    readsPrec _ = RP.readP_to_S pCId

pCId :: RP.ReadP CId
pCId = fmap mkCId pIdent

pIdent :: RP.ReadP String
pIdent = liftM2 (:) (RP.satisfy isIdentFirst) (RP.munch isIdentRest)
  where
    isIdentFirst c = c == '_' || isLetter c
    isIdentRest c = c == '_' || c == '\'' || isAlphaNum c