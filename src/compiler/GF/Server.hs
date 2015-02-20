-- | GF server mode
{-# LANGUAGE CPP #-}
module GF.Server(server) where
import Data.List(partition,stripPrefix,isInfixOf)
import qualified Data.Map as M
import Control.Monad(when)
import Control.Monad.State(StateT(..),get,gets,put)
import Control.Monad.Error(ErrorT(..),Error(..))
import System.Random(randomRIO)
--import System.IO(stderr,hPutStrLn)
import GF.System.Catch(try)
import Control.Exception(bracket_)
import System.IO.Error(isAlreadyExistsError)
import GF.System.Directory(doesDirectoryExist,doesFileExist,createDirectory,
                           setCurrentDirectory,getCurrentDirectory,
                           getDirectoryContents,removeFile,removeDirectory,
                           getModificationTime)
import Data.Time (getCurrentTime,formatTime)
#if MIN_VERSION_time(1,5,0)
import Data.Time.Format(defaultTimeLocale,rfc822DateFormat)
#else
import System.Locale(defaultTimeLocale,rfc822DateFormat)
#endif
import System.FilePath(dropExtension,takeExtension,takeFileName,takeDirectory,
                       (</>),makeRelative)
#ifndef mingw32_HOST_OS
import System.Posix.Files(getSymbolicLinkStatus,isSymbolicLink,removeLink,
                          createSymbolicLink)
#endif
import GF.Infra.Concurrency(newMVar,modifyMVar,newLog)
import Network.URI(URI(..))
import Network.Shed.Httpd(initServer,Request(..),Response(..),noCache)
--import qualified Network.FastCGI as FCGI -- from hackage direct-fastcgi
import Network.CGI(handleErrors,liftIO)
import CGIUtils(handleCGIErrors)--,outputJSONP,stderrToFile
import Text.JSON(encode,showJSON,makeObj)
--import System.IO.Silently(hCapture)
import System.Process(readProcessWithExitCode)
import System.Exit(ExitCode(..))
import Codec.Binary.UTF8.String(decodeString,encodeString)
import GF.Infra.UseIO(readBinaryFile,writeBinaryFile,ePutStrLn)
import GF.Infra.SIO(captureSIO)
import GF.Data.Utilities(apSnd,mapSnd)
import qualified PGFService as PS
import qualified ExampleService as ES
import Data.Version(showVersion)
import Paths_gf(getDataDir,version)
import GF.Infra.BuildInfo (buildInfo)
import SimpleEditor.Convert(parseModule)
import RunHTTP(cgiHandler)
import URLEncoding(decodeQuery)

--logFile :: FilePath
--logFile = "pgf-error.log"

debug s = logPutStrLn s

-- | Combined FastCGI and HTTP server
server jobs port optroot execute1 state0 =
  do --stderrToFile logFile
     state <- newMVar M.empty
     cache <- PS.newPGFCache jobs
     datadir <- getDataDir
     let root = maybe (datadir</>"www") id optroot
--   debug $ "document root="++root
     setDir root
--   FCGI.acceptLoop forkIO (handle_fcgi execute1 state0 state cache)
     -- if acceptLoop returns, then GF was not invoked as a FastCGI script
     http_server execute1 state0 state cache root
  where
    -- | HTTP server
    http_server execute1 state0 state cache root =
      do logLn <- newLog ePutStrLn -- to avoid intertwined log messages
         logLn gf_version
         logLn $ "Document root = "++root
         logLn $ "Starting HTTP server, open http://localhost:"
                 ++show port++"/ in your web browser."
         initServer port (handle logLn root state0 cache execute1 state)

gf_version = "This is GF version "++showVersion version++".\n"++buildInfo

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

-- * Request handler
-- | Handler monad
type HM s a = StateT (Q,s) (ErrorT Response IO) a
run :: HM s Response -> (Q,s) -> IO (s,Response)
run m s = either bad ok =<< runErrorT (runStateT m s)
  where
    bad resp = return (snd s,resp)
    ok (resp,(qs,state)) = return (state,resp)

get_qs :: HM s Q
get_qs = gets fst
get_state :: HM s s
get_state = gets snd
put_qs qs = do state <- get_state; put (qs,state)
put_state state = do qs <- get_qs; put (qs,state)

err :: Response -> HM s a
err e = StateT $ \ s -> ErrorT $ return $ Left e

hmbracket_ :: IO () -> IO () -> HM s a -> HM s a
hmbracket_ pre post m =
    do s <- get
       e <- liftIO $ bracket_ pre post $ runErrorT $ runStateT m s
       case e of
         Left resp -> err resp
         Right (a,s) -> do put s;return a

-- | HTTP request handler
handle logLn documentroot state0 cache execute1 stateVar
       rq@(Request method URI{uriPath=upath,uriQuery=q} hdrs body) =
    addDate $
    case method of
      "POST" -> normal_request (utf8inputs body)
      "GET"  -> normal_request (utf8inputs q)
      _ -> return (resp501 $ "method "++method)
  where
    logPutStrLn msg = liftIO $ logLn msg
    debug msg = logPutStrLn msg

    addDate m =
      do t <- getCurrentTime
         r <- m
         let fmt = formatTime defaultTimeLocale rfc822DateFormat t
         return r{resHeaders=("Date",fmt):resHeaders r}

    normal_request qs =
      do logPutStrLn $ method++" "++upath++" "++show (mapSnd (take 100.fst) qs)
         let stateful m = modifyMVar stateVar $ \ s -> run m (qs,s)
          -- stateful ensures mutual exclusion, so you can use/change the cwd
         case upath of
           "/new"     -> stateful $ new
           "/gfshell" -> stateful $ inDir command
           "/cloud"   -> stateful $ inDir cloud
--         "/stop"    ->
--         "/start"   ->
           "/parse"   -> parse (decoded qs)
           "/version" -> do (c1,c2) <- PS.listPGFCache cache
                            let rel = map (makeRelative documentroot)
                            return $ ok200 (unlines (gf_version:"":rel c1++"":rel c2))
           "/flush"   -> do PS.flushPGFCache cache; return (ok200 "flushed")
           '/':rpath ->
             -- This code runs without mutual exclusion, so it must *not*
             -- use/change the cwd. Access files by absolute paths only.
             case (takeDirectory path,takeFileName path,takeExtension path) of
               (_  ,_             ,".pgf") -> do --debug $ "PGF service: "++path
                                                 wrapCGI $ PS.cgiMain' cache path
               (dir,"grammars.cgi",_     ) -> grammarList dir (decoded qs)
               (dir  ,"exb.fcgi"  ,_    ) -> wrapCGI $ ES.cgiMain' root dir (fst cache)
               _ -> serveStaticFile rpath path
             where path = translatePath rpath
           _ -> return $ resp400 upath

    root = documentroot

    translatePath rpath = root</>rpath -- hmm, check for ".."

    wrapCGI cgi = cgiHandler root (handleErrors . handleCGIErrors $ cgi) rq

    look field =
      do qs <- get_qs
         case partition ((==field).fst) qs of
           ((_,(value,_)):qs1,qs2) -> do put_qs (qs1++qs2)
                                         return value
           _ -> err $ resp400 $ "no "++field++" in request"
    
    inDir ok = cd =<< look "dir"
      where
        cd ('/':dir@('t':'m':'p':_)) =
          do cwd <- getCurrentDirectory
             b <- doesDirectoryExist dir
             case b of
               False  -> do b <- liftIO $ try $ readFile dir -- poor man's symbolic links
                            case b of
                              Left _ -> err $ resp404 dir
                              Right dir' -> cd dir'
               True  -> do --logPutStrLn $ "cd "++dir
                           hmInDir dir (ok dir)
        cd dir = err $ resp400 $ "unacceptable directory "++dir

    -- First ensure that only one thread that depends on the cwd is running!
    hmInDir dir = hmbracket_ (setDir dir) (setDir documentroot)

    new = fmap ok200 $ liftIO $ newDirectory

    command dir =
      do cmd <- look "command"
         state <- get_state
         let st = maybe state0 id $ M.lookup dir state
         (output,st') <- liftIO $ captureSIO $ execute1 st cmd
         let state' = maybe state (flip (M.insert dir) state) st'
         put_state state'
         return $ ok200 output

    parse qs = return $ json200 (makeObj(map parseModule qs))

    cloud dir =
      do cmd <- look "command"
         case cmd of
           "make" -> make id dir . raw =<< get_qs
           "remake" -> make skip_empty dir . raw =<< get_qs
           "upload" -> upload id . raw =<< get_qs
           "ls" -> jsonList . maybe ".json" fst . lookup "ext" =<< get_qs
           "ls-l" -> jsonListLong . maybe ".json" fst . lookup "ext" =<< get_qs
           "rm" -> rm =<< look_file
           "download" -> download =<< look_file
           "link_directories" ->  link_directories dir =<< look "newdir"
           _ -> err $ resp400 $ "cloud command "++cmd

    look_file = check =<< look "file"
      where
        check path =
          if ok_access path
          then return path
          else err $ resp400 $ "unacceptable path "++path

    make skip dir args =
      do let (flags,files) = partition ((=="-").take 1.fst) args
         _ <- upload skip files
         let args = "-s":"-make":map flag flags++map fst files
             flag (n,"") = n
             flag (n,v) = n++"="++v
             cmd = unwords ("gf":args)
         logPutStrLn cmd
         out@(ecode,_,_) <- liftIO $ readProcessWithExitCode "gf" args ""
         logPutStrLn $ show ecode
         cwd <- getCurrentDirectory
         return $ json200 (jsonresult cwd ('/':dir++"/") cmd out files)

    upload skip files =
        if null badpaths
        then do liftIO $ mapM_ (uncurry updateFile) (skip okfiles)
                return resp204
        else err $ resp404 $ "unacceptable path(s) "++unwords badpaths
      where
        (okfiles,badpaths) = apSnd (map fst) $ partition (ok_access.fst) files

    skip_empty = filter (not.null.snd)

    jsonList = jsonList' return
    jsonListLong = jsonList' (mapM addTime)
    jsonList' details ext = fmap (json200) (details =<< ls_ext "." ext)

    addTime path =
        do t <- getModificationTime path
           return $ makeObj ["path".=path,"time".=format t]
      where
        format = formatTime defaultTimeLocale rfc822DateFormat

    rm path | takeExtension path `elem` ok_to_delete =
      do b <- doesFileExist path
         if b
           then do removeFile path
                   return $ ok200 ""
           else err $ resp404 path
    rm path = err $ resp400 $ "unacceptable extension "++path

    download path = liftIO $ serveStaticFile' path

    link_directories olddir newdir@('/':'t':'m':'p':'/':_) | old/=new =
        hmInDir ".." $ liftIO $
        do logPutStrLn =<< getCurrentDirectory
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
           return $ ok200 ""
      where
        old = takeFileName olddir
        new = takeFileName newdir
    link_directories olddir newdir =
      err $ resp400 $ "unacceptable directories "++olddir++" "++newdir

    grammarList dir qs =
        do pgfs <- ls_ext dir ".pgf"
           return $ jsonp qs pgfs

    ls_ext dir ext =
        do paths <- getDirectoryContents dir
           return [path | path<-paths, takeExtension path==ext]

-- * Dynamic content

jsonresult cwd dir cmd (ecode,stdout,stderr) files =
  makeObj [
    "errorcode" .= if ecode==ExitSuccess then "OK" else "Error",
    "command" .= cmd,
    "output" .= unlines [rel stderr,rel stdout],
    "minibar_url" .= "/minibar/minibar.html?"++dir++pgf]
  where
    pgf = case files of
            (abstract,_):_ -> "%20"++dropExtension abstract++".pgf"
            _ -> ""

    rel = unlines . map relative . lines

    -- remove absolute file paths from error messages:
    relative s = case stripPrefix cwd s of
                   Just ('/':rest) -> rest
                   _ -> s

-- * Static content

serveStaticFile rpath path =
  do --logPutStrLn $ "Serving static file "++path
     b <- doesDirectoryExist path
     if b
       then if rpath `elem` ["","."] || last path=='/'
            then serveStaticFile' (path </> "index.html")
            else return (resp301 ('/':rpath++"/"))
       else serveStaticFile' path

serveStaticFile' path =
  do let ext = takeExtension path
         (t,rdFile) = contentTypeFromExt ext
     if ext `elem` [".cgi",".fcgi",".sh",".php"]
       then return $ resp400 $ "Unsupported file type: "++ext
       else do b <- doesFileExist path
               if b then fmap (ok200' (ct t "")) $ rdFile path
                    else do cwd <- getCurrentDirectory
                            logPutStrLn $ "Not found: "++path++" cwd="++cwd
                            return (resp404 path)

-- * Logging
logPutStrLn s = ePutStrLn s

-- * JSONP output

jsonp qs =  maybe json200 apply (lookup "jsonp" qs)
  where
    apply f = jsonp200' $ \ json -> f++"("++json++")"

-- * Standard HTTP responses
ok200        = Response 200 [plainUTF8,noCache,xo] . encodeString
ok200' t     = Response 200 [t,xo]
json200 x    = json200' id x
json200' f   = ok200' jsonUTF8 . encodeString . f . encode
jsonp200' f  = ok200' jsonpUTF8 . encodeString . f . encode
html200      = ok200' htmlUTF8 . encodeString
resp204      = Response 204 [xo] "" -- no content
resp301 url  = Response 301 [plain,xo,location url] $
               "Moved permanently to "++url
resp400 msg  = Response 400 [plain,xo] $ "Bad request: "++msg++"\n"
resp404 path = Response 404 [plain,xo] $ "Not found: "++path++"\n"
resp500 msg  = Response 500 [plain,xo] $ "Internal error: "++msg++"\n"
resp501 msg  = Response 501 [plain,xo] $ "Not implemented: "++msg++"\n"

instance Error Response where
  noMsg = resp500 "no message"
  strMsg = resp500

-- * Content types
plain = ct "text/plain" ""
plainUTF8 = ct "text/plain" csutf8
jsonUTF8 = ct "application/json" csutf8 -- http://www.ietf.org/rfc/rfc4627.txt
jsonpUTF8 = ct "application/javascript" csutf8
htmlUTF8 = ct "text/html" csutf8

ct t cs = ("Content-Type",t++cs)
csutf8 = "; charset=UTF-8"
xo = ("Access-Control-Allow-Origin","*") -- Allow cross origin requests
     -- https://developer.mozilla.org/en-US/docs/HTTP/Access_control_CORS
location url = ("Location",url)

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
     text subtype = ("text/"++subtype++"; charset=UTF-8",
                     fmap encodeString . readFile)
     bin t = (t,readBinaryFile)

-- * IO utilities
updateFile path new =
  do old <- try $ readBinaryFile path
--   let new = encodeString new0
     when (Right new/=old) $ do logPutStrLn $ "Updating "++path
                                seq (either (const 0) length old) $
                                    writeBinaryFile path new

-- | Check that a path is not outside the current directory
ok_access path =
    case path of
      '/':_ -> False
      '.':'.':'/':_ -> False
      _ -> not ("/../" `isInfixOf` path)

-- | Only delete files with these extensions
ok_to_delete = [".json",".gfstdoc",".gfo",".gf",".pgf"]

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

setDir path =
  do --logPutStrLn $ "cd "++show path
     setCurrentDirectory path

{-
-- * direct-fastcgi deficiency workaround

--toHeader = FCGI.toHeader -- not exported, unfortuntately

toHeader "Content-Type" = FCGI.HttpContentType -- to avoid duplicate headers
toHeader s = FCGI.HttpExtensionHeader s -- cheating a bit
-}

-- * misc utils

--utf8inputs = mapBoth decodeString . inputs
type Q = [(String,(String,String))]
utf8inputs :: String -> Q
utf8inputs q = [(decodeString k,(decodeString v,v))|(k,v)<-inputs q]
decoded = mapSnd fst
raw = mapSnd snd

inputs ('?':q) = decodeQuery q
inputs q = decodeQuery q

{-
-- Stay clear of queryToArgument, which uses unEscapeString, which had
-- backward incompatible changes in network-2.4.1.1, see
-- https://github.com/haskell/network/commit/f2168b1f8978b4ad9c504e545755f0795ac869ce
inputs = queryToArguments . fixplus
  where
    fixplus = concatMap decode
    decode '+' = "%20" -- httpd-shed bug workaround
    decode c   = [c]
-}

infix 1 .=
n .= v = (n,showJSON v)
