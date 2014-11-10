{-# LANGUAGE CPP #-}
module GF.System.Console(
    -- ** Console IO
    -- *** Changing which character encoding to use for console IO
    setConsoleEncoding,changeConsoleEncoding,
    -- *** Console colors
    TermColors(..),getTermColors
) where
import System.IO
import Control.Monad(guard)
import Control.Monad.Trans(MonadIO(..))
#ifdef mingw32_HOST_OS
import System.Win32.Console
import System.Win32.NLS
#else
import System.Console.Terminfo
#endif

-- | Set the console encoding (for Windows, has no effect on Unix-like systems)
setConsoleEncoding =
#ifdef mingw32_HOST_OS
    do codepage <- getACP
       setCP codepage
       setEncoding ("CP"++show codepage)
#endif
       return () :: IO ()

changeConsoleEncoding code =
    do
#ifdef mingw32_HOST_OS
       maybe (return ()) setCP (readCP code)
#endif
       setEncoding code

setEncoding code =
    do enc <- mkTextEncoding code
       hSetEncoding stdin  enc
       hSetEncoding stdout enc
       hSetEncoding stderr enc

#ifdef mingw32_HOST_OS
setCP codepage =
    do setConsoleCP codepage
       setConsoleOutputCP codepage

readCP code =
       case code of
         'C':'P':c -> case reads c of
                        [(cp,"")] -> Just cp
                        _         -> Nothing
         "UTF-8"   -> Just 65001
         _         -> Nothing
#endif

data TermColors = TermColors { redFg,blueFg,restore :: String } deriving Show
noTermColors = TermColors "" "" ""

getTermColors :: MonadIO m => m TermColors
#ifdef mingw32_HOST_OS
getTermColors = return noTermColors
#else
getTermColors =
    liftIO $
    do term <- setupTermFromEnv
       return $ maybe noTermColors id $ getCapability term $
         do n <- termColors
            guard (n>=8)
            fg <- setForegroundColor
            restore <- restoreDefaultColors
            return $ TermColors (fg Red) (fg Blue) restore
#endif
