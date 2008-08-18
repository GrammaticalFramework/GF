{-# LANGUAGE DeriveDataTypeable #-}

import PGF (PGF)
import qualified PGF
import FastCGIUtils

import Network.CGI
import Text.JSON
import qualified Codec.Binary.UTF8.String as UTF8 (encodeString)

import Control.Exception
import Control.Monad
import Data.Dynamic
import Data.Maybe


grammarFile :: FilePath
grammarFile = "grammar.pgf"


newtype Record a = Record { unRecord ::  [(String,a)] }

type Translation = Record [Record String]

instance JSON a => JSON (Record a) where
    readJSON = fmap (Record . fromJSObject) . readJSON
    showJSON = showJSON . toJSObject . unRecord

main :: IO ()
main = do initFastCGI
          r <- newDataRef
          loopFastCGI (handleErrors (handleCGIErrors (fcgiMain r)))

fcgiMain :: DataRef PGF -> CGI CGIResult
fcgiMain ref = getData PGF.readPGF ref grammarFile >>= cgiMain

cgiMain :: PGF -> CGI CGIResult
cgiMain pgf =
    do path <- pathInfo
       case path of
         "/translate" -> do input <- liftM (fromMaybe "") $ getInput "input"
                            mcat  <- getCat pgf "cat"
                            mfrom <- getLang pgf "from"
                            mto   <- getLang pgf "to"
                            outputJSON $ translate pgf input mcat mfrom mto
         "/categories" -> outputJSON $ PGF.categories pgf
         "/languages"  -> outputJSON $ toJSObject $ listLanguages pgf
         _ -> outputNotFound path

getCat :: PGF -> String -> CGI (Maybe PGF.Category)
getCat pgf i = 
    do mcat  <- getInput i
       case mcat of
         Just "" -> return Nothing
         Just cat | cat `notElem` PGF.categories pgf ->
                      throwCGIError 400 "Unknown category" ["Unknown category: " ++ cat]
         _ -> return mcat

getLang :: PGF -> String -> CGI (Maybe PGF.Language)
getLang pgf i = 
    do mlang <- getInput i
       case mlang of
         Just "" -> return Nothing
         Just lang | lang `notElem` PGF.languages pgf ->
                       throwCGIError 400 "Unknown language" ["Unknown language: " ++ lang]
         _ -> return mlang

outputJSON :: JSON a => a -> CGI CGIResult
outputJSON x = do setHeader "Content-Type" "text/json; charset=utf-8"
                  outputStrict $ UTF8.encodeString $ encode x

outputStrict :: String -> CGI CGIResult
outputStrict x | x == x = output x
               | otherwise = fail "I am the pope."

translate :: PGF -> String -> Maybe PGF.Category -> Maybe PGF.Language -> Maybe PGF.Language -> Translation
translate pgf input mcat mfrom mto = 
    Record [(from,[Record (linearize' pgf mto tree) | tree <- trees]) 
           | (from,trees) <- parse' pgf input mcat mfrom]

parse' :: PGF -> String -> Maybe PGF.Category -> Maybe PGF.Language -> [(PGF.Language,[PGF.Tree])]
parse' pgf input mcat mfrom = 
    case mfrom of
      Nothing   -> PGF.parseAllLang pgf cat input
      Just from -> [(from, PGF.parse pgf from cat input)]
  where cat = fromMaybe (PGF.startCat pgf) mcat

linearize' :: PGF -> Maybe PGF.Language -> PGF.Tree -> [(PGF.Language,String)]
linearize' pgf mto tree = 
    case mto of
      Nothing -> PGF.linearizeAllLang pgf tree
      Just to -> [(to,PGF.linearize pgf to tree)]

listLanguages :: PGF -> [(PGF.Language,JSObject JSValue)]
listLanguages pgf = [(l,toJSObject (info l)) | l <- PGF.languages pgf]
  where info l = [("languageCode", showJSON (fromMaybe "" (PGF.languageCode pgf l))),
                  ("canParse",     showJSON (PGF.canParse pgf l))]

-- * General CGI Error exception mechanism

data CGIError = CGIError { cgiErrorCode :: Int, cgiErrorMessage :: String, cgiErrorText :: [String] }
                deriving Typeable

throwCGIError :: Int -> String -> [String] -> CGI a
throwCGIError c m t = throwCGI $ DynException $ toDyn $ CGIError c m t

handleCGIErrors :: CGI CGIResult -> CGI CGIResult
handleCGIErrors x = x `catchCGI` \e -> case e of
                                         DynException d -> case fromDynamic d of
                                                             Nothing -> throw e
                                                             Just (CGIError c m t) -> outputError c m t
                                         _ -> throw e
