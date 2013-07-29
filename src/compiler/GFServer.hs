-- | GF server mode
{-# LANGUAGE CPP #-}
module GFServer(server) where
import Data.List(partition,stripPrefix,isInfixOf)
import qualified Data.Map as M
import Control.Monad(when)
import Control.Monad.State(StateT(..),get,gets,put)
import Control.Monad.Error(ErrorT(..),Error(..))
import System.Random(randomRIO)
import System.IO(stderr,hPutStrLn)
import GF.System.Catch(try)
import System.IO.Error(isAlreadyExistsError)
import GF.System.Directory(doesDirectoryExist,doesFileExist,createDirectory,
                           setCurrentDirectory,getCurrentDirectory,
                           getDirectoryContents,removeFile,removeDirectory,
                           getModificationTime)
import Data.Time (formatTime)
import System.Locale(defaultTimeLocale,rfc822DateFormat)
import System.FilePath(dropExtension,takeExtension,takeFileName,takeDirectory,
                       (</>))
#ifndef mingw32_HOST_OS
import System.Posix.Files(getSymbolicLinkStatus,isSymbolicLink,removeLink,
                          createSymbolicLink)
#endif
import Control.Concurrent(newMVar,modifyMVar)
import Network.URI(URI(..))
import Network.Shed.Httpd(initServer,Request(..),Response(..),noCache)
--import qualified Network.FastCGI as FCGI -- from hackage direct-fastcgi
import Network.CGI(handleErrors,liftIO)
import FastCGIUtils(handleCGIErrors)--,outputJSONP,stderrToFile
import Text.JSON(encode,showJSON,makeObj)
--import System.IO.Silently(hCapture)
import System.Process(readProcessWithExitCode)
import System.Exit(ExitCode(..))
import Codec.Binary.UTF8.String(decodeString,encodeString)
import GF.Infra.UseIO(readBinaryFile,writeBinaryFile)
import GF.Infra.SIO(captureSIO)
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
server port optroot execute1 state0 =
  do --stderrToFile logFile
     state <- newMVar M.empty
     cache <- PS.newPGFCache
     datadir <- getDataDir
     let root = maybe (datadir</>"www") id optroot
--   debug $ "document root="++root
     setCurrentDirectory root
--   FCGI.acceptLoop forkIO (handle_fcgi execute1 state0 state cache)
     -- if acceptLoop returns, then GF was not invoked as a FastCGI script
     http_server execute1 state0 state cache root
  where
    -- | HTTP server
    http_server execute1 state0 state cache root =
      do logPutStrLn gf_version
         logPutStrLn $ "Document root = "++root
         logPutStrLn $ "Starting HTTP server, open http://localhost:"
                       ++show port++"/ in your web browser."
         initServer port (modifyMVar state . handle root state0 cache execute1)

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

hmtry :: HM s a -> HM s (Either (Either IOError Response) a)
hmtry m = do s <- get
             e <- liftIO $ try $ runErrorT $ runStateT m s
             case e of
               Left ioerror -> return (Left (Left ioerror))
               Right (Left resp) -> return (Left (Right resp))
               Right (Right (a,s)) -> do put s;return (Right a)

-- | HTTP request handler
handle documentroot state0 cache execute1
       rq@(Request method URI{uriPath=upath,uriQuery=q} hdrs body) state =
    case method of
      "POST" -> run normal_request (utf8inputs body,state)
      "GET"  -> run normal_request (utf8inputs q,state)
      _ -> return (state,resp501 $ "method "++method)
  where
    normal_request =
      do -- Defend against unhandled errors under inDir:
         liftIO $ setDir documentroot
         qs <- get_qs
         logPutStrLn $ method++" "++upath++" "++show (mapSnd (take 100.fst) qs)
         case upath of
           "/new" -> new
--         "/stop" ->
--         "/start" ->
           "/gfshell" -> inDir command
           "/parse" -> parse (decoded qs)
           "/cloud" -> inDir cloud
           "/version" -> return (ok200 gf_version)
           '/':rpath ->
             case (takeDirectory path,takeFileName path,takeExtension path) of
               (_  ,_             ,".pgf") -> wrapCGI $ PS.cgiMain' cache path
               (dir,"grammars.cgi",_     ) -> grammarList dir (decoded qs)
               (dir  ,"exb.fcgi"  ,_    ) -> wrapCGI $ ES.cgiMain' root dir cache
               _ -> liftIO $ serveStaticFile path
             where path = translatePath rpath
           _ -> err $ resp400 upath

    root = "."

    translatePath rpath = root</>rpath -- hmm, check for ".."

    wrapCGI cgi = 
      liftIO $ cgiHandler root (handleErrors . handleCGIErrors $ cgi) rq

    look field =
      do qs <- get_qs
         case partition ((==field).fst) qs of
           ((_,(value,_)):qs1,qs2) -> do put_qs (qs1++qs2)
                                         return value
           _ -> err $ resp400 $ "no "++field++" in request"
    
    inDir ok = cd =<< look "dir"
      where
        cd ('/':dir@('t':'m':'p':_)) =
          do cwd <- liftIO $ getCurrentDirectory
             b <- liftIO $ try $ setDir dir
             case b of
               Left _ -> do b <- liftIO $ try $ readFile dir -- poor man's symbolic links
                            case b of
                              Left _ -> err $ resp404 dir
                              Right dir' -> cd dir'
               Right _ -> do --logPutStrLn $ "cd "++dir
                             r <- hmtry (ok dir)
                             liftIO $ setDir cwd
                             either (either (liftIO . ioError) err) return r
        cd dir = err $ resp400 $ "unacceptable directory "++dir

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
         cwd <- liftIO $ getCurrentDirectory
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
        do t <- liftIO $ getModificationTime path
           return $ makeObj ["path".=path,"time".=format t]
      where
        format = formatTime defaultTimeLocale rfc822DateFormat

    rm path | takeExtension path `elem` ok_to_delete =
      do b <- liftIO $ doesFileExist path
         if b
           then do liftIO $ removeFile path
                   return $ ok200 ""
           else err $ resp404 path
    rm path = err $ resp400 $ "unacceptable extension "++path

    download path = liftIO $ serveStaticFile path

    link_directories olddir newdir@('/':'t':'m':'p':'/':_) | old/=new =
        liftIO $
        do setDir ".."
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
        do paths <- liftIO $ getDirectoryContents dir
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

serveStaticFile path =
  do b <- doesDirectoryExist path
     let path' = if b then path </> "index.html" else path
     serveStaticFile' path'

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
logPutStrLn s = liftIO . hPutStrLn stderr $ s

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
  do logPutStrLn $ "cd "++show path
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

mapFst f xys = [(f x,y)|(x,y)<-xys]
mapSnd f xys = [(x,f y)|(x,y)<-xys]
mapBoth = map . apBoth
apBoth f (x,y) = (f x,f y)
apSnd f (x,y) = (x,f y)

infix 1 .=
n .= v = (n,showJSON v)
