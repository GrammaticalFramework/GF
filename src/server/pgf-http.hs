
import Network.CGI(requestMethod,getVarWithDefault,logCGI,handleErrors,liftIO)
import System.Environment(getArgs)
import System.Directory(getDirectoryContents)
import System.FilePath(takeExtension,takeFileName,takeDirectory)
       
import RunHTTP(runHTTP)
import ServeStaticFile(serveStaticFile)
import PGFService(cgiMain',getPath,stderrToFile,logFile,newPGFCache)
import FastCGIUtils(outputJSONP,handleCGIErrors)

main :: IO ()
main = do stderrToFile logFile
          cache <- newPGFCache
          args <- getArgs
          port <- case args of
                    []     -> return 41296
                    [port] -> readIO port
          httpMain cache port

httpMain cache port = runHTTP port (do log ; serve =<< getPath)
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
