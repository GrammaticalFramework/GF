module Main where

import Char
import System

main :: IO ()
main = do
  jvm:src:_ <- getArgs
  s <- readFile jvm
  let cls = takeWhile (/='.') src
  let obj = cls ++ ".j"
  writeFile  obj $ boilerplate cls
  appendFile obj $ mkJVM cls s
  putStrLn $ "wrote file " ++ obj

mkJVM :: String -> String -> String
mkJVM cls = unlines . map trans . lines where
  trans s = case words s of
    ".method":p:s:f:ns   -> unwords [".method",p,s, unindex f ++ typesig ns]
    ".limit":"locals":ns -> ".limit locals " ++ show (length ns - 1)
    "invokestatic":t:"runtime/lt":ns -> ".invokestatic " ++ "runtime/" ++ t ++ "lt" ++ typesig ns 
    "invokestatic":f:ns  -> "invokestatic " ++ cls ++ "/" ++ unindex f ++ typesig ns 
    "alloc":ns           -> "; " ++ s
    t:('_':instr):x:_    -> t ++ instr ++ " " ++ address x
    "goto":ns            -> "goto "   ++ label ns
    "ifeq":ns            -> "ifzero " ++ label ns
    "label":ns           -> label ns
    ";":[] -> ""
    _ -> s
   where
     unindex = reverse . drop 1 . dropWhile (/= '_') . reverse
     typesig = init . map toUpper . concat
     address = reverse . takeWhile (/= '_') . reverse
     label   = init . concat

boilerplate :: String -> String
boilerplate cls = unlines [
  ".class public " ++ cls ++ ".j",
  ".super java/lang/Object",
  ".method public <init>()V",
  "aload_0",
  "invokenonvirtual java/lang/Object/<init>()V",
  "return",
  ".end method"
  ]
