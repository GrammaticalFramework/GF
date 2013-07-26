import System.Environment (getArgs)
import Data.List.Utils (replace)

main = do
  a <- getArgs
  case a of
    [] -> print "You need to provide a language code"
    langs -> mapM_ makeOne langs

name = "LibraryBrowserEng.gf"

makeOne "Eng" = putStrLn "Skipping Eng"
makeOne lang  = do
  contents <- readFile name
  let name'     = replace "Eng" lang name
  let contents' = replace "Eng" lang contents
  writeFile name' contents'
  putStrLn $ "Wrote " ++ name'
