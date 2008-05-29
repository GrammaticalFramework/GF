module GF.GFCC.CId (CId(..), wildCId, mkCId, prCId) where

import Data.ByteString.Char8 as BS

newtype CId = CId BS.ByteString deriving (Eq,Ord,Show)

wildCId :: CId
wildCId = CId (BS.singleton '_')

mkCId :: String -> CId
mkCId s = CId (BS.pack s)

prCId :: CId -> String
prCId (CId x) = BS.unpack x
