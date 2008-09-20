import GF.Compile
import GF.Data.Operations
import GF.Grammar.API
import GF.Grammar.Grammar (Term)
import GF.Grammar.PrGrammar (prTermTabular)
import GF.Infra.Option
import GF.Infra.UseIO
import GF.Text.UTF8

import Network.FastCGI
import Text.JSON
import qualified Codec.Binary.UTF8.String as UTF8 (encodeString)

import Control.Monad
import System.Environment
import System.FilePath

import FastCGIUtils
import URLEncoding

-- FIXME !!!!!!

grammarFile :: IO FilePath
grammarFile = return "/Users/aarne/GF/lib/alltenses/ParadigmsFin.gfo"
--grammarFile = return "/Users/bringert/Projects/gf/lib/alltenses/ParadigmsFin.gfo"
grammarPath :: FilePath
grammarPath = "/Users/aarne/GF/lib/prelude"
--grammarPath = "/Users/bringert/Projects/gf/lib/prelude"

main :: IO ()
main = do initFastCGI
          r <- newDataRef
          loopFastCGI (handleErrors (handleCGIErrors (fcgiMain r)))

fcgiMain :: DataRef Grammar -> CGI CGIResult
fcgiMain ref = liftIO grammarFile >>= getData readGrammar ref >>= cgiMain

readGrammar :: FilePath -> CGI Grammar
readGrammar file = 
    do let opts = concatOptions [modifyFlags $ \fs -> fs { optVerbosity = Quiet },
                                 modifyModuleFlags $ \fs -> fs { optLibraryPath = [grammarPath] }]
       mgr <- liftIO $ appIOE $ batchCompile opts [file]
       err (throwCGIError 500 "Grammar loading error" . (:[])) return mgr

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
                 maybe (throwCGIError 400 "No term given" ["No term given"]) (return . urlDecodeUnicode) mt

doEval :: Grammar -> String -> Err JSValue
doEval sgr t = liftM termToJSValue $ eval sgr t 

-- FIXME
termToJSValue :: Term -> JSValue
termToJSValue = showJSON . toJSObject . prTermTabular

eval :: Grammar -> String -> Err Term
eval sgr t = pTerm t >>= checkTerm sgr >>= computeTerm sgr

-- * General CGI and JSON stuff

outputJSON :: JSON a => a -> CGI CGIResult
outputJSON x = do setHeader "Content-Type" "text/json; charset=utf-8"
                  outputStrict $ UTF8.encodeString $ encode x

outputStrict :: String -> CGI CGIResult
outputStrict x | x == x = output x
               | otherwise = fail "I am the pope."
