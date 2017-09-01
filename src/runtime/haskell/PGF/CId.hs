module PGF.CId (CId(..), 
                mkCId, wildCId,
                readCId, showCId,
                
                -- utils
                utf8CId, pCId, pIdent, ppCId) where

import Control.Monad
import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.UTF8 as UTF8
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
mkCId s = CId (UTF8.fromString s)

-- | Creates an identifier from a UTF-8-encoded 'ByteString'
utf8CId = CId

-- | Reads an identifier from 'String'. The function returns 'Nothing' if the string is not valid identifier.
readCId :: String -> Maybe CId
readCId s = case [x | (x,cs) <- RP.readP_to_S pCId s, all isSpace cs] of
              [x] -> Just x
              _   -> Nothing

-- | Renders the identifier as 'String'
showCId :: CId -> String
showCId (CId x) = 
  let raw = UTF8.toString x
  in if isIdent raw
       then raw
       else "'" ++ concatMap escape raw ++ "'"
  where
    isIdent []     = False
    isIdent (c:cs) = isIdentFirst c && all isIdentRest cs

    escape '\'' = "\\\'"
    escape '\\' = "\\\\"
    escape c    = [c]

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
pIdent = 
  liftM2 (:) (RP.satisfy isIdentFirst) (RP.munch isIdentRest)
  `mplus`
  do RP.char '\''
     cs <- RP.many1 insideChar
     RP.char '\''
     return cs
--  where
insideChar = RP.readS_to_P $ \s ->
  case s of
    []             -> []
    ('\\':'\\':cs) -> [('\\',cs)]
    ('\\':'\'':cs) -> [('\'',cs)]
    ('\\':cs)      -> []
    ('\'':cs)      -> []
    (c:cs)         -> [(c,cs)]

isIdentFirst c =
  (c == '_') ||
  (c >= 'a' && c <= 'z') ||
  (c >= 'A' && c <= 'Z') ||
  (c >= '\192' && c <= '\255' && c /= '\247' && c /= '\215')
isIdentRest c = 
  (c == '_') ||
  (c == '\'') ||
  (c >= '0' && c <= '9') ||
  (c >= 'a' && c <= 'z') ||
  (c >= 'A' && c <= 'Z') ||
  (c >= '\192' && c <= '\255' && c /= '\247' && c /= '\215')

ppCId :: CId -> PP.Doc
ppCId = PP.text . showCId
