import System

main = do
  file:_  <- getArgs
  updates <- readFile file >= return . readUpdates
  mapM_ (doUpdate file) updates
  return ()

type Update = (FilePath, [String])

readUpdates :: String -> [Update]
readUpdates s = []

doUpdate :: FilePath -> Update -> IO ()
doUpdate src (target,ls) = do
  s <- readFile target 
  let beg = dropLastBracket s
  let tmp = tmpFile target
  writeFile tmp beg
  appendFile tmp $ unlines [(line ++ "-- UPDATE FROM " ++ src) | line <- ls]
  appendFile tmp "\n}\n"

tmpFile file = "tmp-update/"++ file

---- quick and dirty
dropLastBracket = reverse . init . dropWhile (/='}') . reverse

