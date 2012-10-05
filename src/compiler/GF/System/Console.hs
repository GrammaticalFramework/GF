{-# LANGUAGE CPP #-}
module GF.System.Console(setConsoleEncoding,changeConsoleEncoding) where
import System.IO
#ifdef mingw32_HOST_OS
import System.Win32.Console
import System.Win32.NLS
#endif

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
