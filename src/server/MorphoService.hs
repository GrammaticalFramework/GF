import GF.Compile
import GF.Data.Operations
import GF.Grammar.API
import GF.Grammar.Parser
import GF.Grammar.Grammar (Term)
import GF.Grammar.PrGrammar (prTermTabular)
import GF.Infra.Option
import GF.Infra.UseIO
import GF.Text.UTF8

import Network.FastCGI
import Text.JSON
import qualified Codec.Binary.UTF8.String as UTF8 (decodeString, encodeString)
import Data.ByteString.Char8 as BS

import Control.Monad
import System.Environment
import System.FilePath

import Cache
import FastCGIUtils
import URLEncoding

-- FIXME !!!!!!
grammarFile :: FilePath
grammarFile = "/usr/local/share/gf-3.0/lib/alltenses/ParadigmsFin.gfo"

grammarPath :: FilePath
grammarPath = "/usr/local/share/gf-3.0/lib/prelude"

main :: IO ()
main = do initFastCGI
          r <- newCache readGrammar
          loopFastCGI (handleErrors (handleCGIErrors (fcgiMain r)))

fcgiMain :: Cache Grammar -> CGI CGIResult
fcgiMain cache = liftIO (readCache cache grammarFile) >>= cgiMain

readGrammar :: FilePath -> IO Grammar
readGrammar file = 
    do let opts = concatOptions [modifyFlags $ \fs -> fs { optVerbosity = Quiet },
                                 modifyFlags $ \fs -> fs { optLibraryPath = [grammarPath] }]
       mgr <- appIOE $ batchCompile opts [file]
       err (fail "Grammar loading error") return mgr

cgiMain :: Grammar -> CGI CGIResult
cgiMain sgr =
    do path <- pathInfo
       json <- case path of
         "/eval"           -> do mjson <- return (doEval sgr) `ap` getTerm
                                 err (throwCGIError 400 "Evaluation error" . (:[])) return mjson
         _                 -> throwCGIError 404 "Not Found" ["Resource not found: " ++ path]
       outputJSON json
  where
    getTerm :: CGI String
    getTerm = do mt <- getInput "term"
                 maybe (throwCGIError 400 "No term given" ["No term given"]) (return . urlDecodeUnicode . UTF8.decodeString) mt

doEval :: Grammar -> String -> Err JSValue
doEval sgr t = liftM termToJSValue $ eval sgr t 

termToJSValue :: Term -> JSValue
termToJSValue t = showJSON [toJSObject [("name", name), ("value",value)] | (name,value) <- prTermTabular t]

eval :: Grammar -> String -> Err Term
eval sgr t = 
  case runP pExp (BS.pack t) of
    Right e       -> checkTerm sgr e >>= computeTerm sgr
    Left  (_,msg) -> fail msg

-- * General CGI and JSON stuff

outputJSON :: JSON a => a -> CGI CGIResult
outputJSON x = do setHeader "Content-Type" "text/json; charset=utf-8"
                  outputStrict $ UTF8.encodeString $ encode x

outputStrict :: String -> CGI CGIResult
outputStrict x | x == x = output x
               | otherwise = fail "I am the pope."
