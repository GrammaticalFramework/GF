-- | Isolate backwards incompatible library changes to 'getModificationTime'
-- and provide lifted versions of some directory operations
module GF.System.Directory(module GF.System.Directory,module D) where
import Control.Monad.Trans(MonadIO(..))
import qualified System.Directory as D
import System.Directory as D
       hiding (canonicalizePath,createDirectoryIfMissing,
               doesDirectoryExist,doesFileExist,getModificationTime,
               getCurrentDirectory,getDirectoryContents,getPermissions,
               removeFile,renameFile)
import Data.Time.Compat

canonicalizePath path = liftIO $ D.canonicalizePath path
createDirectoryIfMissing b = liftIO . D.createDirectoryIfMissing b
doesDirectoryExist path = liftIO $ D.doesDirectoryExist path
doesFileExist path = liftIO $ D.doesFileExist path
getModificationTime path = liftIO $ fmap toUTCTime (D.getModificationTime path)
getDirectoryContents path = liftIO $ D.getDirectoryContents path

getCurrentDirectory :: MonadIO io => io FilePath
getCurrentDirectory = liftIO D.getCurrentDirectory
getPermissions path = liftIO $ D.getPermissions path

removeFile path = liftIO $ D.removeFile path
renameFile path = liftIO . D.renameFile path
