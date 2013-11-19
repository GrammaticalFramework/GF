module GF.System.Process where
import System.Process
import System.IO(hGetContents,hClose,hPutStr)
import Control.Concurrent(forkIO)
import GF.System.Catch(try)

-- | Feed some input to a shell process and read the output lazily
readShellProcess :: String     -- ^ shell command
                  -> String    -- ^ input to shell command
                  -> IO String -- ^ output from shell command
readShellProcess cmd input =
  do (Just stdin,Just stdout,Nothing,ph) <-
         createProcess (shell cmd){std_in=CreatePipe,std_out=CreatePipe}
     forkIO $ do try $ hPutStr stdin input
                 try $ hClose stdin
                 waitForProcess ph
                 return ()
     hGetContents stdout
