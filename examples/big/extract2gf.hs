import System
import Char

-- usage: extract2gf <lang> <extracted>

main = do
  la:f:_ <- getArgs
  let cnc = f ++ ".gf" 
  let abs = f ++ "Abs.gf" 
  s <- readFile f
  writeFile abs $ "abstract " ++ f ++ "Abs = Cat ** {\n"
  writeFile cnc $ "concrete " ++ f ++ " of " ++ f ++ 
    "Abs = Cat" ++ la ++ " ** open Paradigms" ++ la ++ " in {\n"
  mapM_ (mkOne abs cnc . words) $ filter (not . empty) $ lines s
  appendFile abs "}"
  appendFile cnc "}"

-- format: cat oper args

mkOne abs cnc (cat : oper : args@(a1:_)) = do
  appendFile abs $ "  fun " ++ fun ++ " : " ++ cat ++ " ;\n"
  appendFile cnc $ "  lin " ++ fun ++ " = " ++ lin ++ " ;\n"
 where
   fun = a1 ++ "_" ++ cat ++ "_" ++ oper
   lin = unwords $ oper:["\"" ++ s ++ "\"" | s <- args]
mkOne _ _ ws = putStrLn $ unwords ws

empty s = all isSpace s || take 2 s == "--"
