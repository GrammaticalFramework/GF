----------------------------------------------------------------------
-- |
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/16 17:35:42 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.6 $
--
-- chop an HTML file into separate files, each linked to the next and previous.
-- the names of the files are n-file, with n = 01,02,...
-- the chopping is performed at each separator, here defined as @\<!-- NEW --\>@
--
-- AR 7\/1\/2002 for the Vinnova meeting in Linköping.
-- Added table of contents generation in file 00, 16/4/2005
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
  let ss = allPages file s
      lg = length ss
  putStrLn $ show lg ++ " slides"
  mapM_ (uncurry writeFile . mkFile file lg) ss

allPages :: FilePath -> String -> [(Int,String)]
allPages file s = addIndex $ zip [1..] $ map unlines $ chop lss where
  chop ls = case span isNoSep ls of
      (s,_:ss) -> s : chop ss
      _ -> [ls]                 
  isNoSep = (/= separator)
  addIndex = ((0,mkIndex file lss) :) 
  lss = lines s

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
                           ("   <a href=\"" ++ file0 ++ "\">Contents</a>") ++
                           ("   <a href=\"" ++ file1 ++ "\">First</a>") ++
                           ("   <a href=\"" ++ file2 ++ "\">Last</a>")
  where
    file_ = fileName file (n - 1)
    file' = fileName file (n + 1)
    file0 = fileName file 0
    file1 = fileName file 1
    file2 = fileName file mx

fileName :: FilePath -> Int -> FilePath
fileName file n = (if n < 10 then ('0':) else id) $ show n ++ "-" ++ file

pageNum mx num = "<p align=right>" ++ show num ++"/" ++ show mx ++ "</p>"

mkIndex file = unlines . mkInd 0 where
  mkInd n ss = case ss of
    s : rest | (s==separator) -> mkInd (n+1) rest
    s : rest -> case getHeading s of
      Just (i,t) -> mkLine n i t : mkInd n rest
      _ -> mkInd n rest
    _ -> []
  getHeading s = case dropWhile isSpace s of
    '<':h:i:_:t | isDigit i -> return (i,take (length t - 5) t)  -- drop final </hi>
    _ -> Nothing
  mkLine _ '1' t = t ++ " : Table of Contents<p>"       -- heading of whole document
  mkLine n i t = stars i ++ link n t ++ "<br>"
  stars i = case i of
    '3' -> "*"
    '4' -> "**"
    _   -> ""
  link n t = "<a href=\"" ++ fileName file n ++ "\">" ++ t ++ "</a>"
