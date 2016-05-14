-- update the import list of every language
-- although possibly some extra definitions at the end
-- the new files are produced in ./tmp/ which has to be created first
-- usage: runghc MkApp.hs

langs = words "Bul Cat Chi Dut Eng Est Fin Fre Ger Hin Ita Jpn Spa Swe Tha"
appCnc lang = "App" ++ lang ++ ".gf"

appAbs = "App.gf"

main = do
  imports <- readFile appAbs >>= return . getImports
  mapM_ (\f -> readFile f >>= writeFile ("tmp/" ++ f) . (putImports imports)) (map appCnc langs)

getImports = takeWhile (/= ']') . tail . dropWhile (/='[')

putImports i s = 
  let
    (s1,_:s2) = span (/='[') s
    (_,   s3) = span (/=']') s2
  in s1 ++ "[" ++ i ++ extra s3

extra s = unlines (init (lines s) ++ extraLines ++ ["}"])

extraLines = [
--  "  PassV2 v2 = passiveVP v2 ;"
  ] -- default: no extra
