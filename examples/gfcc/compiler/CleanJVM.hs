module Main where

import System

main :: IO ()
main = do
  jvm:src:_ <- getArgs
  s <- readFile jvm
  let obj = takeWhile (/='.') src ++ ".j"
  writeFile obj $ mkJVM s
  putStrLn $ "wrote file " ++ obj

mkJVM :: String -> String
mkJVM = unlines . reverse . fst . foldl trans ([],([],0)) . lines where
  trans (code,(env,v)) s = case words s of
    ".method":f:ns -> ((".method " ++ f ++ concat ns):code,([],0))
    "alloc":t:x:_  -> (code, ((x,v):env, v + size t))
    ".limit":"locals":ns -> chCode (".limit locals " ++ show (length ns - 1))
    t:"_load" :x:_ -> chCode (t ++ "load "  ++ look x) 
    t:"_store":x:_ -> chCode (t ++ "store " ++ look x)
    t:"_return":_  -> chCode (t ++ "return")
    "goto":ns      -> chCode ("goto " ++ concat ns)
    "ifzero":ns    -> chCode ("ifzero " ++ concat ns) 
    _ ->   chCode s
   where
     chCode c = (c:code,(env,v))
     look x = maybe (x ++ show env) show $ lookup x env
     size t = case t of
       "d" -> 2
       _ -> 1
