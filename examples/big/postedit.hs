import Char
import System

infile = "BigLexEng.gf"
tmp = "tm"

main = do
  writeFile tmp ""
  s <- readFile infile
  mapM_ (appendFile tmp . mkOne) $ lines s --- $ chop s
  system "mv tm BigLexEng.gf"

chop s = case s of
  ';':cs -> ";\n"++chop cs
  c:cs -> c:chop cs
  _ -> s

mkOne s = case words s of
  lin:a2:eq:pa2:ws | take 6 pa2 == "prepA2" -> 
    unwords $ [lin,a2,eq,"prepA2"] ++ ws ++ ["\n"]
  lin:a2:eq:pa2:ws | take 6 pa2 == "prepV2" -> 
    unwords $ [lin,a2,eq,"prepV2"] ++ ws ++ ["\n"]
  lin:v2:eq:"mkV2":v:_:ws ->
    unwords $ [lin,v2,eq,"mkV2",(read v ++ "_V")] ++ ws ++ ["\n"]
  lin:v2:eq:"mkV3":v:_:ws ->
    unwords $ [lin,v2,eq,"dirV3",(read v ++ "_V")] ++ ws ++ ["\n"]
  lin:a2:eq:pa2:ws | take 4 pa2 == "mkV2" -> 
    unwords $ [lin,a2,eq,"mkV2"] ++ ws ++ ["\n"]
  lin:a2:eq:pa2:ws | take 6 pa2 == "prepN2" -> 
    unwords $ [lin,a2,eq,"prepN2"] ++ ws ++ ["\n"]
  lin:a2:eq:pa2:ws | take 4 pa2 == "mkV3" -> 
    unwords $ [lin,a2,eq,"mkV3"] ++ ws ++ ["\n"]

  lin:v2:eq:"irreg":v:_:ws ->
    unwords $ [lin,v2,eq,"dirV2",(read v ++ "_V")] ++ ws ++ ["\n"]


  _ -> s ++ "\n"
