module GFServer(server) where
import Data.List(partition)
import qualified Data.Map as M
import Control.Monad(when)
import System.Random(randomRIO)
import System.IO(stdout,stderr)
import System.IO.Error(try,ioError)
import System.Directory(doesDirectoryExist,doesFileExist,createDirectory,
                        setCurrentDirectory,getCurrentDirectory)
import System.FilePath(takeExtension,(</>))
import Control.Concurrent.MVar(newMVar,modifyMVar)
import Network.URI(URI(..))
import Network.Shed.Httpd(initServer,Request(..),Response(..),queryToArguments,
                          noCache)
import System.IO.Silently(hCapture)
import Codec.Binary.UTF8.String(encodeString)
import GF.Infra.UseIO(readBinaryFile)

-- * Configuraiton
port = 41295
documentRoot = "."

-- * HTTP server
server execute1 state0 = 
  do state <- newMVar M.empty
     putStrLn $ "Starting server on port "++show port
     initServer port (modifyMVar state . handle state0 execute1)

-- * HTTP request handler
handle state0 execute1 (Request method URI{uriPath=path,uriQuery=q} hdrs body) state =
    do let qs = decodeQ $ 
                case method of
                  "GET" -> queryToArguments q
                  "POST" -> queryToArguments body

       logPutStrLn $ method++" "++path++" "++show qs
       case path of
         "/new" -> new
--       "/stop" ->
--       "/start" ->
         "/gfshell" -> inDir qs $ look "command" . command
         "/upload" -> inDir qs upload
         '/':rpath -> do resp <- serveStaticFile (translatePath rpath)
                         return (state,resp)
         _ -> return (state,resp400 path)
  where
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

    upload dir files=
      do let update (name,contents)= updateFile (name++".gf") contents
         mapM_ update files
         return (state,resp204)

-- * Static content

translatePath path = documentRoot</>path -- hmm, check for ".."

serveStaticFile path =
  do b <- doesDirectoryExist path
     let path' = if b then path </> "index.html" else path
     serveStaticFile' path'

serveStaticFile' path =
  do b <- doesFileExist path
     let (t,rdFile,encode) = contentTypeFromExt (takeExtension path)
     if b then fmap (ok200' (ct t) . encode) $ rdFile path
          else return (resp404 path)

-- * Logging
logPutStrLn = putStrLn

-- * Standard HTTP responses
ok200 body   = Response 200 [plainUTF8,noCache] (encodeString body)
ok200' t body = Response 200 [t] body
resp204      = Response 204 [] "" -- no content
resp400 msg  = Response 400 [plain] $ "Bad request: "++msg++"\n"
resp404 path = Response 404 [plain] $ "Not found: "++path++"\n"

-- * Content types
plain = ct "text/plain"
plainUTF8 = ct "text/plain; charset=UTF-8"
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
  do old <- try $ readFile path
     when (Right new/=old) $ do logPutStrLn $ "Updating "++path
                                seq (either (const 0) length old) $
                                    writeFile path new


newDirectory =
  do k <- randomRIO (1,maxBound::Int)
     let path = "tmp/gfse."++show k
     b <- try $ createDirectory path
     case b of
       Left _ -> newDirectory
       Right _ -> return ('/':path)

-- * misc utils

decodeQ qs = [(decode n,decode v)|(n,v)<-qs]
decode = map decode1
decode1 '+' = ' ' -- httpd-shed bug workaround
decode1 c   = c
