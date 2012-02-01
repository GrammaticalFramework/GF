{-# LANGUAGE CPP #-}
module GFServer(server) where
import Data.List(partition)
import qualified Data.Map as M
import Control.Monad(when)
import System.Random(randomRIO)
import System.IO(stdout,stderr,hPutStrLn)
import System.IO.Error(try,ioError,isAlreadyExistsError)
import System.Directory(doesDirectoryExist,doesFileExist,createDirectory,
                        setCurrentDirectory,getCurrentDirectory,
                        getDirectoryContents,removeFile,removeDirectory)
import System.FilePath(takeExtension,takeFileName,takeDirectory,(</>))
#ifndef mingw32_HOST_OS
import System.Posix.Files(getSymbolicLinkStatus,isSymbolicLink,removeLink,
                          createSymbolicLink)
#endif
import Control.Concurrent(newMVar,modifyMVar,forkIO)
import Network.URI(URI(..),parseURI)
import Network.Shed.Httpd(initServer,Request(..),Response(..),queryToArguments,
                          noCache)
--import qualified Network.FastCGI as FCGI -- from hackage direct-fastcgi
--import qualified Data.ByteString.Char8 as BS(pack,unpack,length)
import Network.CGI(handleErrors,liftIO)
import FastCGIUtils(outputJSONP,handleCGIErrors,stderrToFile)
import System.IO.Silently(hCapture)
import System.Process(readProcessWithExitCode)
import System.Exit(ExitCode(..))
import Codec.Binary.UTF8.String(encodeString)
import GF.Infra.UseIO(readBinaryFile,writeBinaryFile)
import qualified PGFService as PS
import qualified ExampleService as ES
import Data.Version(showVersion)
import Paths_gf(getDataDir,version)
import GF.Infra.BuildInfo (buildInfo)
import RunHTTP(cgiHandler)

--logFile :: FilePath
--logFile = "pgf-error.log"

debug s = liftIO (logPutStrLn s)

-- | Combined FastCGI and HTTP server
server port execute1 state0 = 
  do --stderrToFile logFile
     state <- newMVar M.empty
     cache <- PS.newPGFCache
     datadir <- getDataDir
     let root = datadir</>"www"
     debug $ "document root="++root
     setCurrentDirectory root
--   FCGI.acceptLoop forkIO (handle_fcgi execute1 state0 state cache)
     -- if acceptLoop returns, then GF was not invoked as a FastCGI script
     http_server execute1 state0 state cache root
  where
    -- | HTTP server
    http_server execute1 state0 state cache root =
      do putStrLn $ "This is GF version "++showVersion version++"."
         putStrLn buildInfo
         putStrLn $ "Document root = "++root
         putStrLn $ "Starting HTTP server, open http://localhost:"
                    ++show port++"/ in your web browser."
         initServer port (modifyMVar state . handle state0 cache execute1)

{-
-- | FastCGI request handler
handle_fcgi execute1 state0 stateM cache =
  do Just method <- FCGI.getRequestMethod
     debug $ "request method="++method
     Just path <- FCGI.getPathInfo
--   debug $ "path info="++path
     query <- maybe (return "") return =<< FCGI.getQueryString
--   debug $ "query string="++query
     let uri = URI "" Nothing path query ""
     headers <- fmap (mapFst show) FCGI.getAllRequestHeaders
     body <- fmap BS.unpack FCGI.fGetContents
     let req = Request method uri headers body
--   debug (show req)
     (output,resp) <- liftIO $ hCapture [stdout] $ modifyMVar stateM $ handle state0 cache execute1 req
     let Response code headers body = resp
--   debug output
     debug $ "    "++show code++" "++show headers
     FCGI.setResponseStatus code
     mapM_ (uncurry (FCGI.setResponseHeader . toHeader)) headers
     let pbody = BS.pack body
         n = BS.length pbody
     FCGI.fPut pbody
     debug $ "done "++show n
-}

-- | HTTP request handler
handle state0 cache execute1
       rq@(Request method URI{uriPath=upath,uriQuery=q} hdrs body) state =
    do let qs = case method of
                  "GET" -> inputs q
                  "POST" -> inputs body

       logPutStrLn $ method++" "++upath++" "++show qs
       case upath of
         "/new" -> new
--       "/stop" ->
--       "/start" ->
         "/gfshell" -> inDir qs $ look "command" . command
         "/cloud" -> inDir qs $ look "command" . cloud
         '/':rpath ->
           case (takeDirectory path,takeFileName path,takeExtension path) of
             (_  ,_             ,".pgf") -> wrapCGI $ PS.cgiMain' cache path
             (dir,"grammars.cgi",_     ) -> wrapCGI $ grammarList dir
             (dir  ,"exb.fcgi"  ,_     ) -> wrapCGI $ ES.cgiMain' root dir cache
             _ -> do resp <- serveStaticFile path
                     return (state,resp)
           where path = translatePath rpath
         _ -> return (state,resp400 upath)
  where
    root = "."

    translatePath rpath = root</>rpath -- hmm, check for ".."

    wrapCGI cgi = 
      do resp <- cgiHandler root (handleErrors . handleCGIErrors $ cgi) rq
         return (state,resp)

    look field ok qs =
        case partition ((==field).fst) qs of
          ((_,value):qs1,qs2) -> ok value (qs1++qs2)
          _ -> bad
      where
        bad = return (state,resp400 $ "no "++field++" in request")
    
    inDir qs ok = look "dir" cd qs
      where
        cd ('/':dir@('t':'m':'p':_)) qs' =
          do cwd <- getCurrentDirectory
             b <- try $ setCurrentDirectory dir
             case b of
               Left _ -> do b <- try $ readFile dir -- poor man's symbolic links
                            case b of
                              Left _ -> return (state,resp404 dir)
                              Right dir' -> cd dir' qs'
               Right _ -> do logPutStrLn $ "cd "++dir
                             r <- try (ok dir qs')
                             setCurrentDirectory cwd
                             either ioError return r
        cd dir _ = return (state,resp400 $ "unacceptable directory "++dir)

    new =
      do dir <- newDirectory
         return (state,ok200 dir)

    command dir cmd _ =
      do let st = maybe state0 id $ M.lookup dir state
         (output,st') <- hCapture [stdout,stderr] (execute1 st cmd)
         let state' = maybe state (flip (M.insert dir) state) st'
         return (state',ok200 output)

    cloud dir cmd qs =
      case cmd of
        "make" -> make dir qs
        "upload" -> upload qs
        "ls" -> jsonList
        "rm" -> look "file" rm qs
        "download" -> look "file" download qs
        "link_directories" -> look "newdir" (link_directories dir) qs
        _ -> return (state,resp400 $ "cloud command "++cmd)

    make dir files =
      do (state,_) <- upload files
         let args = "-s":"-make":map fst files
             cmd = unwords ("gf":args)
         out <- readProcessWithExitCode "gf" args ""
         return (state,html200 (resultpage ('/':dir++"/") cmd out files))

    upload files =
      do let update (name,contents)= updateFile name contents
         mapM_ update files
         return (state,resp204)

    jsonList =
        do jsons <- ls_ext "." ".json"
           return (state,ok200 (unwords jsons))

    rm path _ | takeExtension path==".json" =
      do b <- doesFileExist path
         if b
           then do removeFile path
                   return (state,ok200 "")
           else return (state,resp404 path)
    rm path _ = return (state,resp400 $ "unacceptable file "++path)

    download path _ = (,) state `fmap` serveStaticFile path

    link_directories olddir newdir@('/':'t':'m':'p':'/':_) _ | old/=new =
        do setCurrentDirectory ".."
           logPutStrLn =<< getCurrentDirectory
           logPutStrLn $ "link_dirs new="++new++", old="++old
#ifdef mingw32_HOST_OS
           isDir <- doesDirectoryExist old
           if isDir then removeDir old else removeFile old
           writeFile old new -- poor man's symbolic links
#else
           isLink <- isSymbolicLink `fmap` getSymbolicLinkStatus old
           logPutStrLn $ "old is link: "++show isLink
           if isLink then removeLink old else removeDir old
           createSymbolicLink new old
#endif
           return (state,ok200 "")
      where
        old = takeFileName olddir
        new = takeFileName newdir
    link_directories olddir newdir _ =
      return (state,resp400 $ "unacceptable directories "++olddir++" "++newdir)

    grammarList dir = outputJSONP =<< liftIO (ls_ext dir ".pgf")

    ls_ext dir ext =
        do paths <- getDirectoryContents dir
           return [path | path<-paths, takeExtension path==ext]

-- * Dynamic content

resultpage dir cmd (ecode,stdout,stderr) files =
  unlines $ 
    "<!DOCTYPE html>":
    "<title>Uploaded</title>":
    "<link rel=stylesheet type=\"text/css\" HREF=\"/gfse/editor.css\" title=\"Normal\">":
    "<h1>Uploaded</h1>":
    "<pre>":escape cmd:"":escape stderr:escape stdout:
    "</pre>":
    (if ecode==ExitSuccess
     then "<h3>OK</h3>":links
     else "<h3 class=error_message>Error</h3>":listing)
  where
    links = "<dl>":
            ("<dt>▸ <a href=\"/minibar/minibar.html?"++dir++"\">Minibar</a>"):
            "<dt>◂ <a href=\"javascript:history.back()\">Back to Editor</a>":
            "</dl>":
            []

    listing = concatMap listfile files

    listfile (name,source) = 
      ("<h4>"++name++"</h4><pre class=plain>"):number source:"</pre>":[]

    number = unlines . zipWith num [1..] . lines
    num n s = pad (show n)++"  "++escape s
    pad s = replicate (5-length s) ' '++s

escape = concatMap escape1
escape1 '<' = "&lt;"
escape1 '&' = "&amp;"
escape1 c   = [c]

-- * Static content

serveStaticFile path =
  do b <- doesDirectoryExist path
     let path' = if b then path </> "index.html" else path
     serveStaticFile' path'

serveStaticFile' path =
  do let ext = takeExtension path
         (t,rdFile,encode) = contentTypeFromExt ext
     if ext `elem` [".cgi",".fcgi",".sh",".php"]
       then return $ resp400 $ "Unsupported file type: "++ext
       else do b <- doesFileExist path
               if b then fmap (ok200' (ct t) . encode) $ rdFile path
                    else return (resp404 path)

-- * Logging
logPutStrLn = hPutStrLn stderr

-- * Standard HTTP responses
ok200        = Response 200 [plainUTF8,noCache] . encodeString
ok200' t     = Response 200 [t]
html200      = ok200' htmlUTF8 . encodeString
resp204      = Response 204 [] "" -- no content
resp400 msg  = Response 400 [plain] $ "Bad request: "++msg++"\n"
resp404 path = Response 404 [plain] $ "Not found: "++path++"\n"

-- * Content types
plain = ct "text/plain"
plainUTF8 = ct "text/plain; charset=UTF-8"
htmlUTF8 = ct "text/html; charset=UTF-8"
ct t = ("Content-Type",t)

contentTypeFromExt ext =
  case ext of
    ".html" -> text "html"
    ".htm" -> text "html"
    ".xml" -> text "xml"
    ".txt" -> text "plain"
    ".css" -> text "css"
    ".js" -> text "javascript"
    ".png" -> bin "image/png"
    ".jpg" -> bin "image/jpg"
    _ -> bin "application/octet-stream"
  where
     text subtype = ("text/"++subtype++"; charset=UTF-8",readFile,encodeString)
     bin t = (t,readBinaryFile,id)

-- * IO utilities
updateFile path new =
  do old <- try $ readBinaryFile path
     when (Right new/=old) $ do logPutStrLn $ "Updating "++path
                                seq (either (const 0) length old) $
                                    writeBinaryFile path new

newDirectory =
    do debug "newDirectory"
       loop 10
  where
    loop 0 = fail "Failed to create a new directory"
    loop n = maybe (loop (n-1)) return =<< once

    once =
      do k <- randomRIO (1,maxBound::Int)
         let path = "tmp/gfse."++show k
         b <- try $ createDirectory path
         case b of
           Left err -> do debug (show err) ;
                          if isAlreadyExistsError err
                             then return Nothing
                             else ioError err
           Right _ -> return (Just ('/':path))

-- | Remove a directory and the files in it, but not recursively
removeDir dir =
  do files <- filter (`notElem` [".",".."]) `fmap` getDirectoryContents dir
     mapM (removeFile . (dir</>)) files
     removeDirectory dir
{-
-- * direct-fastcgi deficiency workaround

--toHeader = FCGI.toHeader -- not exported, unfortuntately

toHeader "Content-Type" = FCGI.HttpContentType -- to avoid duplicate headers
toHeader s = FCGI.HttpExtensionHeader s -- cheating a bit
-}
-- * misc utils


inputs = queryToArguments . fixplus
  where
    fixplus = concatMap decode
    decode '+' = "%20" -- httpd-shed bug workaround
    decode c   = [c]

mapFst f xys = [(f x,y)|(x,y)<-xys]