{-# OPTIONS_GHC -cpp #-}

-----------------------------------------------------------------------------
-- File name and directory utilities. Stolen from 
-- ghc-6.4.1/ghc/compiler/main/DriverUtil.hs
--
-- (c) The University of Glasgow 2000
--
-----------------------------------------------------------------------------

module Transfer.PathUtil (
	Suffix, splitFilename, getFileSuffix,
	splitFilename3, remove_suffix, split_longest_prefix,
	replaceFilenameSuffix, directoryOf, filenameOf,
	replaceFilenameDirectory, replaceFilename, remove_spaces, escapeSpaces,
  ) where

import Data.Char (isSpace)
	
type Suffix = String

splitFilename :: String -> (String,Suffix)
splitFilename f = split_longest_prefix f (=='.')

getFileSuffix :: String -> Suffix
getFileSuffix f = drop_longest_prefix f (=='.')

-- "foo/bar/xyzzy.ext" -> ("foo/bar", "xyzzy.ext")
splitFilenameDir :: String -> (String,String)
splitFilenameDir str
  = let (dir, rest) = split_longest_prefix str isPathSeparator
  	real_dir | null dir  = "."
		 | otherwise = dir
    in  (real_dir, rest)

-- "foo/bar/xyzzy.ext" -> ("foo/bar", "xyzzy", ".ext")
splitFilename3 :: String -> (String,String,Suffix)
splitFilename3 str
   = let (dir, rest) = split_longest_prefix str isPathSeparator
	 (name, ext) = splitFilename rest
	 real_dir | null dir  = "."
		  | otherwise = dir
     in  (real_dir, name, ext)

remove_suffix :: Char -> String -> Suffix
remove_suffix c s
  | null pre  = s
  | otherwise = reverse pre
  where (suf,pre) = break (==c) (reverse s)

drop_longest_prefix :: String -> (Char -> Bool) -> String
drop_longest_prefix s pred = reverse suf
  where (suf,_pre) = break pred (reverse s)

take_longest_prefix :: String -> (Char -> Bool) -> String
take_longest_prefix s pred = reverse pre
  where (_suf,pre) = break pred (reverse s)

-- split a string at the last character where 'pred' is True,
-- returning a pair of strings. The first component holds the string
-- up (but not including) the last character for which 'pred' returned
-- True, the second whatever comes after (but also not including the
-- last character).
--
-- If 'pred' returns False for all characters in the string, the original
-- string is returned in the second component (and the first one is just
-- empty).
split_longest_prefix :: String -> (Char -> Bool) -> (String,String)
split_longest_prefix s pred
  = case pre of
	[]      -> ([], reverse suf)
	(_:pre) -> (reverse pre, reverse suf)
  where (suf,pre) = break pred (reverse s)

replaceFilenameSuffix :: FilePath -> Suffix -> FilePath
replaceFilenameSuffix s suf = remove_suffix '.' s ++ suf

-- directoryOf strips the filename off the input string, returning
-- the directory.
directoryOf :: FilePath -> String
directoryOf = fst . splitFilenameDir

-- filenameOf strips the directory off the input string, returning
-- the filename.
filenameOf :: FilePath -> String
filenameOf = snd . splitFilenameDir

replaceFilenameDirectory :: FilePath -> String -> FilePath
replaceFilenameDirectory s dir
 = dir ++ '/':drop_longest_prefix s isPathSeparator

replaceFilename :: FilePath -> String -> FilePath
replaceFilename f n
 = case directoryOf f of
                      "" -> n
                      d  -> d ++ '/' : n

remove_spaces :: String -> String
remove_spaces = reverse . dropWhile isSpace . reverse . dropWhile isSpace

escapeSpaces :: String -> String
escapeSpaces = foldr (\c s -> if isSpace c then '\\':c:s else c:s) ""

isPathSeparator :: Char -> Bool
isPathSeparator ch =
#ifdef mingw32_TARGET_OS
  ch == '/' || ch == '\\'
#else
  ch == '/'
#endif
