
import System.Environment (getArgs)
import Data.List.Utils (replace)

name = "LibraryBrowserEng.gf"

main = do
  a <- getArgs
  case a of
    lang:_ -> do
      contents <- readFile name
      let name'     = replace "Eng" lang name
      let contents' = replace "Eng" lang contents
      writeFile name' contents'
      putStrLn $ "Wrote " ++ name'
    _ -> print "You need to provide a language code"
