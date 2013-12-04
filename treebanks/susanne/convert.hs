import System.Directory
import System.FilePath
import Data.List

import SusanneFormat

main = do
  fs <- getDirectoryContents "data"
  txts <- (mapM (\f -> readFile ("data" </> f)) . filter ((/= ".") . take 1)) (sort fs)
  let ts = filter (not . isBreak) (readTreebank (lines (concat txts)))
  writeFile "text" (unlines (map show ts))

isBreak (Phrase "Oh" [Word _ "YB" "<minbrk>" _]) = True
isBreak _                                        = False
