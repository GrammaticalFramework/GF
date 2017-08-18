-- | Backwards compatible 'catch' and 'try'
module GF.System.Catch where
import qualified System.IO.Error as S

-- ** Backwards compatible try and catch
catch = S.catchIOError
try = S.tryIOError
