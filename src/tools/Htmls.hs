----------------------------------------------------------------------
-- |
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/16 05:40:50 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
-- chop an HTML file into separate files, each linked to the next and previous.
-- the names of the files are n-file, with n = 01,02,...
-- the chopping is performed at each separator, here defined as @\<!-- NEW --\>@
--
-- AR 7\/1\/2002 for the Vinnova meeting in Linköping.
-----------------------------------------------------------------------------

module Main (main) where

import System

main :: IO ()
main = do
  file:_ <- getArgs
  htmls file

htmls :: FilePath -> IO ()
htmls file = do
  s  <- readFile file
  let ss = allPages s
      lg = length ss
  putStrLn $ show lg ++ " slides"
  mapM_ (uncurry writeFile . mkFile file lg) ss

allPages :: String -> [(Int,String)]
allPages = zip [1..] . map unlines . chop . lines where
  chop ls = case span isNoSep ls of
      (s,_:ss) -> s : chop ss
      _ -> [ls]                 
  isNoSep = (/= separator)
  
mkFile :: FilePath -> Int -> (Int,String) -> (FilePath,String)
mkFile base mx (number,content) = 
 (fileName base number,
  unlines [
    begHTML,
    "<font size=1>",
    pageNum mx number,
    link base mx number,
    "</font>",
    "<p>",
    content,
    endHTML
   ]
  )

begHTML, endHTML, separator :: String
begHTML   = "<html><body bgcolor=\"#FFFFFF\" text=\"#000000\">"
endHTML   = "</body></html>"
separator = "<!-- NEW -->"

link :: FilePath -> Int -> Int -> String
link file mx n = 
  (if n >= mx then "" else ("   <a href=\"" ++ file' ++ "\">Next</a>")) ++
  (if n == 1  then "" else ("   <a href=\"" ++ file_ ++ "\">Previous</a>")) ++
                           ("   <a href=\"" ++ file1 ++ "\">First</a>") ++
                           ("   <a href=\"" ++ file2 ++ "\">Last</a>")
  where
    file_ = fileName file (n - 1)
    file' = fileName file (n + 1)
    file1 = fileName file 1
    file2 = fileName file mx

fileName :: FilePath -> Int -> FilePath
fileName file n = (if n < 10 then ('0':) else id) $ show n ++ "-" ++ file

pageNum mx num = "<p align=right>" ++ show num ++"/" ++ show mx ++ "</p>"
