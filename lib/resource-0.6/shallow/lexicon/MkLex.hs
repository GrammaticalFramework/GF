module MkLex where

import System
import Monad

-- to massage an ispell word list into a GF lexicon. AR 20/2/2004

lexfile = "linux.words"
absfile = "Lex.gf"
cncfile = "LexEng.gf"
maxsize = 10000 :: Int --- add more!

massage :: IO ()
massage = do
  -- initialize target files
  system $ "echo \"\" >" ++ absfile
  system $ "echo \"\" >" ++ cncfile
  appendFile absfile $ 
    "abstract Lex = Shallow ** {\nfun\n"
  appendFile cncfile $ 
    "--# -path=.:..:../../../prelude:../../abstract:../../english\n\n"
  appendFile cncfile $ 
    "concrete LexEng of Lex = ShallowEng ** open ParadigmsEng in {\nlin\n"
  -- reverse to study endings
  ws <- liftM (map reverse . lines) $ readFile lexfile
  sortWords $ take maxsize ws

-- we exploit the fact that the original list is sorted and
-- different forms therefore lie consecutively
sortWords :: [String] -> IO ()
sortWords ws = case ws of
  u : ('d':'e':v) : ('s':w) : vs | v == u && w == u -> -- regular verb
    mkEntry verbReg u >> sortWords vs
  ('e':u) : ('d':'e':v) : ('s':'e':w) : vs | v == u && w == u -> -- e-verb
    mkEntry verbE ('e':u) >> sortWords vs
  u : ('y':'l':v) : vs | v == u ->                     -- regular adjective
    mkEntry adjReg u >> sortWords vs
  u : ('s':v) : vs | v == u ->                         -- regular noun
    mkEntry nounReg u >> sortWords vs
  ---- add more
  _ : vs -> sortWords vs
  [] -> appendFile absfile "  }\n" >> appendFile cncfile "  }\n"

mkEntry :: (String -> (String,String)) -> String -> IO ()
mkEntry abc w0 = do
  let w = reverse w0
  let (ab,cn) = abc w
  appendFile absfile $ "  " ++ ab
  appendFile absfile $ " ;\n"
  appendFile cncfile $ "  " ++ cn
  appendFile cncfile $ " ;\n"

verbReg :: String -> (String,String)
verbReg = mkGF "Verb" "vReg"

verbE = verbReg ----
adjReg  = mkGF "Adj" "mkAdj1"
nounReg = mkGF "Noun" "cnNonhuman"


mkGF :: String -> String -> (String -> (String,String))
mkGF cat oper w = (
  w ++ "L : " ++ cat,
  w ++ "L = " ++ oper ++ " \"" ++ w ++ "\""
  )

