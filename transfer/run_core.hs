import Transfer.InterpreterAPI
import Transfer.Interpreter (prEnv)

import Control.Monad (when)
import Data.List (partition, isPrefixOf)
import System.Environment (getArgs)
import System.IO (isEOF)

interpretLoop :: Env -> IO ()
interpretLoop env = 
    do
    eof <- isEOF
    if eof
       then return ()
       else do
            line <- getLine
            r <- evaluateString env line
            putStrLn r
            interpretLoop env

runMain :: Env -> IO ()
runMain env = do
              r <- evaluateString env "main"
              putStrLn r

main :: IO ()
main = do args <- getArgs
          let (flags,files) = partition ("-" `isPrefixOf`) args
          env <- case files of
            [f] -> loadFile f
            _   -> fail "Usage: run_core [-i] <file>"
          when ("-v" `elem` flags) $ do
                                     putStrLn "Top-level environment:"
                                     putStrLn (prEnv env)
          if "-i" `elem` flags 
            then interpretLoop env
            else runMain env
