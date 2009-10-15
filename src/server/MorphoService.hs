import GF.Compile
import GF.Compile.Compute (computeConcrete)
import GF.Compile.Rename (renameSourceTerm)
import GF.Compile.CheckGrammar (inferLType)
import GF.Data.Operations
import GF.Grammar
import GF.Grammar.Parser
import GF.Infra.Option
import GF.Infra.UseIO
import GF.Infra.Modules (greatestResource)
import GF.Infra.CheckM
import GF.Text.UTF8

import Network.FastCGI
import Text.JSON
import Text.PrettyPrint
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

fcgiMain :: Cache SourceGrammar -> CGI CGIResult
fcgiMain cache = liftIO (readCache cache grammarFile) >>= cgiMain

readGrammar :: FilePath -> IO SourceGrammar
readGrammar file = 
    do let opts = concatOptions [modifyFlags $ \fs -> fs { optVerbosity = Quiet },
                                 modifyFlags $ \fs -> fs { optLibraryPath = [grammarPath] }]
       mgr <- appIOE $ batchCompile opts [file]
       err (fail "Grammar loading error") return mgr

cgiMain :: SourceGrammar -> CGI CGIResult
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

doEval :: SourceGrammar -> String -> Err JSValue
doEval sgr t = liftM termToJSValue $ eval sgr t 

termToJSValue :: Term -> JSValue
termToJSValue t =
  showJSON [toJSObject [("name", render name), ("value",render value)] | (name,value) <- ppTermTabular Unqualified t]

eval :: SourceGrammar -> String -> Err Term
eval sgr t = 
  case runP pExp (BS.pack t) of
    Right t       -> do mo <- maybe (Bad "no source grammar in scope") return $ greatestResource sgr
                        (t,_) <- runCheck (renameSourceTerm sgr mo t)
                        ((t,_),_) <- runCheck (inferLType sgr [] t)
                        computeConcrete sgr t
    Left  (_,msg) -> fail msg

-- * General CGI and JSON stuff

outputJSON :: JSON a => a -> CGI CGIResult
outputJSON x = do setHeader "Content-Type" "text/json; charset=utf-8"
                  outputStrict $ UTF8.encodeString $ encode x

outputStrict :: String -> CGI CGIResult
outputStrict x | x == x = output x
               | otherwise = fail "I am the pope."

