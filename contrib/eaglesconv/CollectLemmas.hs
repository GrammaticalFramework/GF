-- Copyright (C) 2011 Nikita Frolov

import qualified Data.Text as T
import qualified Data.Text.IO as UTF8
import System.IO
import System.Environment
import Control.Monad
import Control.Monad.State

main :: IO ()
main = do
  args <- getArgs
  forM_ args $ \ f -> do
    entries <- UTF8.readFile f >>= (return . T.lines)
    forM_ entries $ \ entry ->
       do
         let ws = T.words entry
             form = head ws
             tags = toPairs $ tail ws
         forM_ tags $ \ (lemma, tag) ->
             do
               UTF8.putStrLn $ T.concat [lemma, sp, form, sp, tag]
                   where sp = T.singleton ' '
                       

toPairs xs = zip (stride 2 xs) (stride 2 (drop 1 xs))
    where stride _ [] = []
          stride n (x:xs) = x : stride n (drop (n-1) xs)
