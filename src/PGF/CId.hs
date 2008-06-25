module PGF.CId (CId(..), wildCId, mkCId, prCId) where

import Data.ByteString.Char8 as BS

-- | An abstract data type that represents
-- function identifier in PGF.
newtype CId = CId BS.ByteString deriving (Eq,Ord,Show)

wildCId :: CId
wildCId = CId (BS.singleton '_')

-- | Creates a new identifier from 'String'
mkCId :: String -> CId
mkCId s = CId (BS.pack s)

-- | Renders the identifier as 'String'
prCId :: CId -> String
prCId (CId x) = BS.unpack x
