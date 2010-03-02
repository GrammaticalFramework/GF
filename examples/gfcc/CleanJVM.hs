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
  system $ "java -jar jasmin.jar " ++ obj
  return () 

mkJVM :: String -> String -> String
mkJVM cls = unlines . reverse . fst . foldl trans ([],([],0)) . liness where
  trans (code,(env,v)) s = case words s of
    ".method":p:s:f:ns
        | f == "main" -> 
            (".method public static main([Ljava/lang/String;)V":code,([],1))   
        | otherwise  -> 
            (unwords [".method",p,s, f ++ glue ns] : code,([],0))
    "alloc":t:x:_  -> (("; " ++ s):code, ((x,v):env, v + size t))
    ".limit":"locals":ns -> chCode (".limit locals " ++ show (length ns + 1))
    "runtime":f:ns -> chCode $ "invokestatic " ++ "runtime/" ++ f ++ glue ns 
    "static":f:ns  -> chCode $ "invokestatic " ++ cls ++ "/" ++ f ++ glue ns 
    "alloc":ns           -> chCode $ "; " ++ s
    ins:x:_ | symb ins   -> chCode $ ins ++ " " ++ look x
    "goto":ns            -> chCode $ "goto " ++ glue ns
    "ifeq":ns            -> chCode $ "ifeq " ++ glue ns
    "label":ns           -> chCode $ glue ns ++ ":"
    ";":[] -> chCode ""
    _ -> chCode s
   where
     chCode c = (c:code,(env,v))
     look x   = maybe (error $ x ++ show env) show $ lookup x env
     glue     = concat --init . concat
     symb     = flip elem ["load","store"] . tail
     size t   = case t of
       "d" -> 2
       _ -> 1
  liness = lines . map (\c -> if c==';' then '\n' else c)


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
