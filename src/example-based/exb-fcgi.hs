{-# LANGUAGE CPP #-}
import Control.Concurrent(forkIO)
import Network.FastCGI(runFastCGI,runFastCGIConcurrent')
import ExampleService(cgiMain,newPGFCache)

main = do --stderrToFile logFile
          fcgiMain =<< newPGFCache


fcgiMain cache =
#ifndef mingw32_HOST_OS
          runFastCGIConcurrent' forkIO 100 (cgiMain cache)
#else
          runFastCGI (cgiMain cache)
#endif
