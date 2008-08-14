{-# LANGUAGE DeriveDataTypeable #-}

import PGF
import FastCGIUtils

import Network.CGI hiding (Language)
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
fcgiMain ref = getData readPGF ref grammarFile >>= cgiMain

cgiMain :: PGF -> CGI CGIResult
cgiMain pgf =
    do path <- pathInfo
       case path of
         "/translate" -> do input <- liftM (fromMaybe "") $ getInput "input"
                            mcat  <- getInput "cat"
                            mfrom <- getInput "from"
                            mto   <- getInput "to"
                            maybe (return ()) (checkCategory pgf) mcat
                            maybe (return ()) (checkLanguage pgf) mfrom
                            maybe (return ()) (checkLanguage pgf) mto
                            outputJSON $ translate pgf input mcat mfrom mto
         _ -> outputNotFound path

outputJSON :: JSON a => a -> CGI CGIResult
outputJSON x = do setHeader "Content-Type" "text/json; charset=utf-8"
                  outputStrict $ UTF8.encodeString $ encode x

outputStrict :: String -> CGI CGIResult
outputStrict x | x == x = output x
               | otherwise = fail "I am the pope."

checkCategory :: PGF -> Category -> CGI ()
checkCategory pgf cat = unless (cat `elem` categories pgf) $ 
                        throwCGIError 400 "Unknown category" ["Unknown category: " ++ cat]

checkLanguage :: PGF -> Category -> CGI ()
checkLanguage pgf lang = unless (lang `elem` languages pgf) $ 
                         throwCGIError 400 "Unknown language" ["Unknown language: " ++ lang]

translate :: PGF -> String -> Maybe Category -> Maybe Language -> Maybe Language -> Translation
translate pgf input mcat mfrom mto = 
    Record [(from, [Record [(to, linearize pgf to tree) | to <- toLangs] | tree <- trees]) 
                | from <- fromLangs, let trees = parse pgf from cat input, not (null trees)]
  where cat       = fromMaybe (startCat pgf) mcat
        fromLangs = maybe (languages pgf) (:[]) mfrom
        toLangs   = maybe (languages pgf) (:[]) mto


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
