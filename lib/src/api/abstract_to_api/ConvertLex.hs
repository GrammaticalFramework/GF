module ConvertLex where

import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO

import Data.List 
import Data.Char

main = 
  do args <- getArgs 
     case args of
      [fname] ->    
        do file <- readFile fname
           let newName = "Abs" ++ (reverse $ takeWhile (/= '/') $ reverse fname)
           let rootName = reverse $ drop 3 $ takeWhile (/='/') $ reverse newName
           let absContent = unlines $ map (makeAbstract (\bf pos hd -> bf ++" fun " ++ hd ++ " : " ++ pos ++ " ; ")) (lines file)  
           let intContent = unlines $ map (makeAbstract (\bf pos hd -> bf ++ " lin " ++ hd ++ " = " ++ "mkSimpCat" ++ "\"" ++ hd ++ "\" ;")) (lines file)
           let absFile = "abstract " ++ rootName ++ " = AbsToAPI ** { \n\n" ++ absContent ++ "\n\n}"
           let intFile = "incomplete concrete " ++  rootName ++ "I of " ++ rootName ++ " = AbsToAPI ** {\n\n" ++ intContent ++ "\n\n}"
           let concAbs = "concrete " ++ rootName ++ "Abs of " ++ rootName ++ " =  AbsToAPIAbs, "++ rootName ++ "I ** {}"
           let concApi = "concrete " ++ rootName ++ "api of " ++ rootName ++ " =  AbsToAPIapi, "++ rootName ++ "I ** {}" 
           writeFile newName absFile
           putStrLn $ "Wrote file "++ newName
           writeFile (rootName ++ "I.gf") intFile 
           putStrLn $ "Wrote file " ++ rootName ++ "I.gf"
           writeFile (rootName ++ "Abs.gf") concAbs
           putStrLn $ "Wrote file " ++ rootName ++ "Abs.gf"
           writeFile (rootName ++ "api.gf") concApi
           putStrLn $ "Wrote file " ++ rootName ++ "api.gf"  
      _ -> error "usage ConvertLex file_name"


makeAbstract :: (String -> String -> String -> String) -> String -> String
makeAbstract fcs str = 
    let newss = dropWhile isSpace str
       in 
      if isInfixOf "=" newss && isInfixOf ";" newss then
           let hd = head $ words newss 
               maybepos = dropWhile (/='_') hd
               pos = if null maybepos then "??" else tail maybepos
               bf = if null maybepos then "--" else ""
                   in
                   if isInfixOf "flags" newss && bf == "--" then ""
                        else fcs bf pos hd
        else ""

