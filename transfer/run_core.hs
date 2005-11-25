import Transfer.InterpreterAPI

import Data.List (partition, isPrefixOf)
import System.Environment (getArgs)

interpretLoop :: Env -> IO ()
interpretLoop env = do    
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
          if "-i" `elem` flags 
            then interpretLoop env
            else runMain env
