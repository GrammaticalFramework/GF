module Main where

import Char
import System

--- translation from Symbolic JVM to real Jasmin code

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
mkJVM cls = unlines . reverse . fst . foldl trans ([],([],0)) . lines where
  trans (code,(env,v)) s = case words s of
    ".method":p:s:f:ns
        | f == "main" -> 
            (".method public static main([Ljava/lang/String;)V":code,([],1))   
        | otherwise  -> 
            (unwords [".method",p,s, f ++ typesig ns] : code,([],0))
    "alloc":t:x:_  -> (("; " ++ s):code, ((x,v):env, v + size t))
    ".limit":"locals":ns -> chCode (".limit locals " ++ show (length ns))
    "invokestatic":t:f:ns 
       | take 8 f == "runtime/" -> 
          chCode $ "invokestatic " ++ "runtime/" ++ t ++ drop 8 f ++ typesig ns 
    "invokestatic":f:ns -> 
          chCode $ "invokestatic " ++ cls ++ "/" ++ f ++ typesig ns 
    "alloc":ns           -> chCode $ "; " ++ s
    t:('_':instr):[";"]  -> chCode $ t ++ instr
    t:('_':instr):x:_    -> chCode $ t ++ instr ++ " " ++ look x
    "goto":ns            -> chCode $ "goto " ++ label ns
    "ifeq":ns            -> chCode $ "ifeq " ++ label ns
    "label":ns           -> chCode $ label ns ++ ":"
    ";":[] -> chCode ""
    _ -> chCode s
   where
     chCode c = (c:code,(env,v))
     look x   = maybe (error $ x ++ show env) show $ lookup x env
     typesig  = init . map toUpper . concat
     label    = init . concat
     size t   = case t of
       "d" -> 2
       _ -> 1

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
