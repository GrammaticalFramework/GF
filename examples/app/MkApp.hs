-- update the import list of every language
-- the new files are produced in ./tmp/
-- usage: runghc MkApp.hs

langs = words "Bul Chi Eng Fin Fre Ger Hin Ita Spa Swe"
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
  in s1 ++ "[" ++ i ++ s3

