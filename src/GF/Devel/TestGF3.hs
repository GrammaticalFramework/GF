module Main where

import GF.Devel.Compile.Compile

import GF.Data.Operations
import GF.Infra.Option ----

import System (getArgs)

main = do
  xx <- getArgs
  mainGFC xx


mainGFC :: [String] -> IO ()
mainGFC xx = do
  let (opts,fs) = getOptions "-" xx
  case opts of
    _ -> do
      mapM_ (batchCompile opts) (map return fs)
      putStrLn "Done."
