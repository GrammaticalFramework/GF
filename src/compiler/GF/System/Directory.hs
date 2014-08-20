-- | Isolate backwards incompatible library changes to 'getModificationTime'
-- and provide lifted versions of some directory operations
module GF.System.Directory(module GF.System.Directory,module D) where
import Control.Monad.Trans(MonadIO(..))
import qualified System.Directory as D
import System.Directory as D
       hiding (doesDirectoryExist,doesFileExist,getModificationTime,
               getCurrentDirectory,getDirectoryContents,removeFile)
import Data.Time.Compat

doesDirectoryExist path = liftIO $ D.doesDirectoryExist path
doesFileExist path = liftIO $ D.doesFileExist path
getModificationTime path = liftIO $ fmap toUTCTime (D.getModificationTime path)
getDirectoryContents path = liftIO $ D.getDirectoryContents path

getCurrentDirectory :: MonadIO io => io FilePath
getCurrentDirectory = liftIO D.getCurrentDirectory

removeFile path = liftIO $ D.removeFile path