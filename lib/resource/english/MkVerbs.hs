module Main where

import List

-- create a GF file from a word form list:
-- one entry per line, newline or tab separated;
-- variants separated by /
-- comments are lines starting with --
-- example line: bid 	bid/bade 	bid/bidden
-- example resource: http://www2.gsu.edu/~wwwesl/egw/verbs.htm

-- parameters, depending on language

infile   = "verbs.txt"
outfile  = "VerbsEng.gf"
preamble = 
  "resource VerbsEng = open ResourceEng, MorphoEng in {\n" ++
  "  oper vIrreg : Str -> Str -> Str -> V = \\x,y,z ->\n" ++
  "    mkVerbIrreg x y z ** {s1 = [] ; lock_V = <>} ;\n\n" 
oper     = "vIrreg"
cat      = "V"
name s   = s ++ "_V"

ending   = "}\n"

main :: IO ()
main = do
  ss <- readFile infile >>= return . filter (not . null) . lines
  writeFile outfile preamble
  mapM_ (appendFile outfile . mkOne . words) (filter notComment ss)
  appendFile outfile ending

notComment = (/="--") . take 2

mkOne :: [String] -> String
mkOne ws@(v:_) = 
  "  oper " ++ name v ++ " : " ++ cat ++ " = " ++ 
       oper ++ " " ++ unwords (map arg ws) ++ " ;\n" 
    where
      arg w = case variants w of
        [s] -> quote s
        vs  -> "(variants {" ++ 
                  unwords (intersperse ";" (map quote vs)) ++ "})"
      quote s = "\"" ++ s ++ "\""
      variants = chopBy '/'

chopBy c s = case span (/= c) s of
  (w1,_:w2) -> w1 : chopBy c w2
  (w1,_)    -> [w1]
