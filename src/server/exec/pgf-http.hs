
import Network.CGI(requestMethod,getVarWithDefault,logCGI,handleErrors,liftIO)
import System.Environment(getArgs)
import System.Directory(getDirectoryContents)
import System.FilePath(takeExtension,takeFileName,takeDirectory,(</>))
       
import RunHTTP(runHTTP,Options(..))
import ServeStaticFile(serveStaticFile)
import PGFService(cgiMain',getPath,stderrToFile,logFile,newPGFCache)
import FastCGIUtils(outputJSONP,handleCGIErrors)

import Paths_gf_server(getDataDir)

main :: IO ()
main = do datadir <- getDataDir
          let defaults = Options { documentRoot = datadir</>"www",
                                   port = 41296 }
          cache <- newPGFCache
          args <- getArgs
          options <- case args of
                       []     -> return defaults
                       [port] -> do p <- readIO port
                                    return defaults{port=p}    
          putStrLn $ "Starting HTTP server, open http://localhost:"
                     ++show (port options)++"/ in your web browser.\n"
          print options
          putStrLn $ "logFile="++logFile
          stderrToFile logFile
          httpMain cache options


httpMain cache options = runHTTP options (do log ; serve =<< getPath)
  where
    log = do method <- requestMethod
             uri    <- getVarWithDefault "REQUEST_URI" "-"
             logCGI $ method++" "++uri

    serve path =
        handleErrors . handleCGIErrors $
        if takeExtension path==".pgf"
        then cgiMain' cache path
        else if takeFileName path=="grammars.cgi"
             then grammarList (takeDirectory path)
             else serveStaticFile path

    grammarList dir =
        do paths <- liftIO $ getDirectoryContents dir
           let pgfs = [path|path<-paths, takeExtension path==".pgf"]
           outputJSONP pgfs
