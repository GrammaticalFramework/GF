module Main where

import Char
import System

--- now works for programs with exactly 2 functions, main last

main :: IO ()
main = do
  jvm:src:_ <- getArgs
  s <- readFile jvm
  let cls = takeWhile (/='.') src
  let obj = cls ++ ".j"
  writeFile  obj $ boilerplate cls
  appendFile obj $ mkJVM cls s
  putStrLn $ "wrote file " ++ obj
  system $ "jasmin " ++ obj
  return () 

mkJVM :: String -> String -> String
mkJVM cls = unlines . map trans . lines where
  trans s = case words s of
    ".method":p:s:f:ns
        | take 5 f == "main_" -> ".method public static main([Ljava/lang/String;)V"   
        | otherwise  -> unwords [".method",p,s, unindex f ++ typesig ns]
    ".limit":"locals":ns -> ".limit locals " ++ show (length ns)
    "invokestatic":t:f:ns | take 8 f == "runtime/" -> 
        "invokestatic " ++ "runtime/" ++ t ++ drop 8 f ++ typesig ns 
    "invokestatic":f:ns  -> "invokestatic " ++ cls ++ "/" ++ unindex f ++ typesig ns 
    "alloc":ns           -> "; " ++ s
    t:('_':instr):[]     -> t ++ instr
    t:('_':instr):x:_    -> t ++ instr ++ " " ++ address x
    "goto":ns            -> "goto " ++ label ns
    "ifeq":ns            -> "ifeq " ++ label ns
    "label":ns           -> label ns ++ ":"
    ";":[] -> ""
    _ -> s
   where
     unindex = reverse . drop 1 . dropWhile (/= '_') . reverse
     typesig = init . map toUpper . concat
     address x = case (filter isDigit . reverse . takeWhile (/= '_') . reverse) x of
       s@(_:_) -> show $ read s - (1 :: Int)
       s -> s
     label   = init . concat

boilerplate :: String -> String
boilerplate cls = unlines [
  ".class public " ++ cls,
  ".super java/lang/Object",
  ".method public <init>()V",
  "aload_0",
  "invokenonvirtual java/lang/Object/<init>()V",
  "return",
  ".end method"
  ]
