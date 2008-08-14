import PGF
import FastCGIUtils

import Network.CGI hiding (Language)
import Text.JSON
import qualified Codec.Binary.UTF8.String as UTF8 (encodeString)

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
          loopFastCGI (fcgiMain r)

fcgiMain :: DataRef PGF -> CGI CGIResult
fcgiMain ref = getData readPGF ref grammarFile >>= cgiMain

cgiMain :: PGF -> CGI CGIResult
cgiMain pgf =
    do path <- pathInfo
       case path of
         "/translate" -> do input <- fmap (fromMaybe "") $ getInput "input"
                            mcat <- getInput "cat"
                            mfrom <- getInput "from"
                            mto <- getInput "to"
                            outputJSON $ translate pgf input mcat mfrom mto
         _ -> outputNotFound path

outputJSON :: JSON a => a -> CGI CGIResult
outputJSON x = do setHeader "Content-Type" "text/json; charset=utf-8"
                  output $ UTF8.encodeString $ encode x

translate :: PGF -> String -> Maybe Category -> Maybe Language -> Maybe Language -> Translation
translate pgf input mcat mfrom mto = 
    Record [(from, [Record [(to, linearize pgf to tree) | to <- toLangs] | tree <- parse pgf from cat input]) 
                | from <- fromLangs]
  where cat       = fromMaybe (startCat pgf) mcat
        fromLangs = maybe (languages pgf) (:[]) mfrom
        toLangs   = maybe (languages pgf) (:[]) mfrom
            