import Data.List (intersperse)
import Data.Char (isAlpha)

-- to massage cf rules to funs, in order, preserving comments
-- to get cats, use pg -printer=gf

cf2gf :: FilePath -> IO ()
cf2gf file = do
  ss <- readFile file >>= return . lines
  mapM_ (putStrLn . mkOne) ss

mkOne line = case words line of
  fun : cat : "::=" : cats -> 
    let 
      (cats0,cats2) = span (/=";") cats
      cats1 = filter (isAlpha . head) cats0 ++ [cat] 
    in
    unwords $ [init fun, ":"] ++ intersperse "->" cats1 ++ cats2
  _ -> line
 