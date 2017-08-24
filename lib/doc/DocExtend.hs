module Main where

import Data.List
import Data.Ord (comparing)

main = docExtend

docExtend = do

  -- read the abstract syntax file
  funds <- readFile "../src/abstract/Extend.gf" >>= return . map words . lines

  -- function format:
  --   GenNP : NP -> Quant ; -- this man's
  let funs = [[fu,unwords ty,unwords co] | fu:":":ws <- funds, (ty,_:_:co) <- [break (==";") ws]]
  --- mapM print funs
  
  -- read the concrete syntax functor
  funcs <- readFile "../src/common/ExtendFunctor.gf" >>= return . map words . lines

  -- definition format: one of
  --  GenNP = variants {} ;     -- NP -> Quant ; -- this man's
  --  UttDatIP ip = UttAccIP (lin IP ip) ; -- whom (dative) ; DEFAULT who
  let defs = [[[fu],de,co] | fuws <- funcs, (fu:_,_:ws) <- [break (=="=") fuws], (de,_:_:co) <- [break (==";") ws]]
  let undef de co = if de == ["variants", "{}"] then "-" else unwords (tail (dropWhile (/="DEFAULT") co))
  let fundefs = [[fu,ty,co,undef d c] | fu:ty:co:_ <- funs, [f]:d:c:_ <- defs, f==fu]
  --- mapM print fundefs

  -- read the functor exclusion lists for each language
  let langs = [("Eng","english"),("Dut","dutch"),("Spa","spanish"),("Swe","swedish")]
  funss <- mapM getExclusions langs
  ---  mapM_ print funss
  let langfuns = zip (map fst langs) funss
  let funlangs = [(fu,[lang | (lang,fs) <- langfuns, elem fu fs]) | fu:_ <- funs]
  let fundeflangs = [[fu,ty,co,de,unwords ls] | fu:ty:co:de:_ <- fundefs, (f,ls) <- funlangs, f==fu]
  --- mapM print fundeflangs
  writeFile "GF-RGL-Extend.html" $ printHTML $ sortBy (comparing (\z -> (last (words (z !! 1)), z!!0)))  fundeflangs
  putStrLn "wrote file GF-RGL-Extend.html"

-- exclusion format:
--   concrete ExtendEng of Extend =
--     CatEng ** ExtendFunctor -
--     [
--      VPS, ListVPS, RNP, RNPList  --- lines between the first [ and ] lines are read
--     ]

getExclusions (lan,language) = do
  rs <- readFile ("../src/" ++ language ++ "/Extend" ++ lan ++ ".gf") >>= return . map words . lines
  let excls = case dropWhile (/=["["]) rs of
        [] -> []
        _:es -> map (filter (/=',')) $ concat $ takeWhile (/= ["]"]) es
  return excls

printHTML fs = unlines $
  "<html>" :
  "<body>" :
  "<table>" :
  map prRow fs ++ [
  "</table>",
  "</body>",
  "</html>"
  ]
 where
   prRow ss = concat $ "<tr>" : ["<td>" ++ s ++ "</td>" | s <- ss] ++ ["</tr>"]

