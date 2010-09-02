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
    ".html" -> "text/html; charset=\"iso8859-1\""
    ".htm" -> "text/html; charset=\"iso8859-1\""
    ".xml" -> "text/xml; charset=\"iso8859-1\""
    ".txt" -> "text/plain; charset=\"iso8859-1\""
    ".css" -> "text/css; charset=\"iso8859-1\""
    ".js" -> "text/javascript; charset=\"iso8859-1\""
    ".png" -> "image/png"
    ".jpg" -> "image/jpg"
    _ -> "application/octet-stream"