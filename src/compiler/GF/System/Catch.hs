-- | Isolate backwards incompatible library changes to 'catch' and 'try'
{-# LANGUAGE CPP #-}
module GF.System.Catch where
import qualified System.IO.Error as S

#include "cabal_macros.h"

#if MIN_VERSION_base(4,4,0)
catch = S.catchIOError
try = S.tryIOError
#else
catch = S.catch
try = S.try
#endif
