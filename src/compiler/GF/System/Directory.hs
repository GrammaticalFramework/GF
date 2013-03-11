-- | Isolate backwards incompatible library changes to 'getModificationTime'
module GF.System.Directory(getModificationTime,module D) where
import qualified System.Directory as D
import System.Directory as D hiding (getModificationTime)
import Data.Time.Compat

getModificationTime path = fmap toUTCTime (D.getModificationTime path)
