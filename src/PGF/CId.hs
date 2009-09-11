module PGF.CId (CId(..), 
                mkCId, wildCId,
                readCId, showCId,
                
                -- utils
                pCId, pIdent, ppCId) where

import Control.Monad
import qualified Data.ByteString.Char8 as BS
import Data.Char
import qualified Text.ParserCombinators.ReadP as RP
import qualified Text.PrettyPrint as PP


-- | An abstract data type that represents
-- identifiers for functions and categories in PGF.
newtype CId = CId BS.ByteString deriving (Eq,Ord)

wildCId :: CId
wildCId = CId (BS.singleton '_')

-- | Creates a new identifier from 'String'
mkCId :: String -> CId
mkCId s = CId (BS.pack s)

-- | Reads an identifier from 'String'. The function returns 'Nothing' if the string is not valid identifier.
readCId :: String -> Maybe CId
readCId s = case [x | (x,cs) <- RP.readP_to_S pCId s, all isSpace cs] of
              [x] -> Just x
              _   -> Nothing

-- | Renders the identifier as 'String'
showCId :: CId -> String
showCId (CId x) = BS.unpack x

instance Show CId where
    showsPrec _ = showString . showCId

instance Read CId where
    readsPrec _ = RP.readP_to_S pCId

pCId :: RP.ReadP CId
pCId = do s <- pIdent
          if s == "_"
            then RP.pfail
            else return (mkCId s)

pIdent :: RP.ReadP String
pIdent = liftM2 (:) (RP.satisfy isIdentFirst) (RP.munch isIdentRest)
  where
    isIdentFirst c = c == '_' || isLetter c
    isIdentRest c = c == '_' || c == '\'' || isAlphaNum c

ppCId :: CId -> PP.Doc
ppCId = PP.text . showCId
