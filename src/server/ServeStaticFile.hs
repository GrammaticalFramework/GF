module ServeStaticFile where
import System.FilePath
import System.Directory(doesDirectoryExist)
import Network.CGI(setHeader,outputFPS,liftIO)
import qualified Data.ByteString.Lazy.Char8 as BS

serveStaticFile path =
  do b <- liftIO $ doesDirectoryExist path
     let path' = if b then path </> "index.html" else path
     serveStaticFile' path'

serveStaticFile' path =
  do setHeader "Content-Type" (contentTypeFromExt (takeExtension path))
     outputFPS =<< liftIO (BS.readFile path)

contentTypeFromExt ext =
  case ext of
    ".html" -> "text/html"
    ".htm" -> "text/html"
    ".xml" -> "text/xml"
    ".txt" -> "text/plain"
    ".css" -> "text/css"
    ".js" -> "text/javascript"
    ".png" -> "image/png"
    ".jpg" -> "image/jpg"
    _ -> "application/octet-stream"