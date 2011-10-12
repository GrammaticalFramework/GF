module GFServer(server) where
import Data.List(partition)
import qualified Data.Map as M
import Control.Monad(when)
import System.Random(randomRIO)
import System.IO(stdout,stderr)
import System.IO.Error(try,ioError)
import System.Directory(doesDirectoryExist,doesFileExist,createDirectory,
                        setCurrentDirectory,getCurrentDirectory,
                        getDirectoryContents,removeFile,removeDirectory)
import System.FilePath(takeExtension,takeFileName,takeDirectory,(</>))
import System.Posix.Files(getFileStatus,isSymbolicLink,removeLink,
                          createSymbolicLink)
import Control.Concurrent.MVar(newMVar,modifyMVar)
import Network.URI(URI(..))
import Network.Shed.Httpd(initServer,Request(..),Response(..),queryToArguments,
                          noCache)
import Network.CGI(handleErrors,liftIO)
import FastCGIUtils(outputJSONP,handleCGIErrors)
import System.IO.Silently(hCapture)
import System.Process(readProcessWithExitCode)
import System.Exit(ExitCode(..))
import Codec.Binary.UTF8.String(encodeString)
import GF.Infra.UseIO(readBinaryFile,writeBinaryFile)
import qualified PGFService as PS
import qualified ExampleService as ES
import Paths_gf(getDataDir)
import RunHTTP(Options(..),cgiHandler)

-- * HTTP server
server execute1 state0 = 
  do state <- newMVar M.empty
     cache <- PS.newPGFCache
     datadir <- getDataDir
     let options = Options { documentRoot = datadir</>"www", port = 41296 }
     putStrLn $ "Starting HTTP server, open http://localhost:"
                ++show (port options)++"/ in your web browser."
     initServer (port options)
                (modifyMVar state . handle options state0 cache execute1)

-- * HTTP request handler
handle options state0 cache execute1
       rq@(Request method URI{uriPath=upath,uriQuery=q} hdrs body) state =
    do let qs = decodeQ $ 
                case method of
                  "GET" -> queryToArguments q
                  "POST" -> queryToArguments body

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
    root = documentRoot options

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
               Left _ -> return (state,resp404 dir)
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

    link_directories olddir newdir@('/':'t':'m':'p':'/':_) _ | olddir/=newdir =
        do setCurrentDirectory ".."
           st <- getFileStatus old
           if isSymbolicLink st then removeLink old else removeDir old
           createSymbolicLink new old
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
logPutStrLn = putStrLn

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
  do k <- randomRIO (1,maxBound::Int)
     let path = "tmp/gfse."++show k
     b <- try $ createDirectory path
     case b of
       Left _ -> newDirectory
       Right _ -> return ('/':path)

-- | Remove a directory and the files in it, but not recursively
removeDir dir =
  do files <- filter (`notElem` [".",".."]) `fmap` getDirectoryContents dir
     mapM (removeFile . (dir</>)) files
     removeDirectory dir

-- * misc utils

decodeQ qs = [(decode n,decode v)|(n,v)<-qs]
decode = map decode1
decode1 '+' = ' ' -- httpd-shed bug workaround
decode1 c   = c
