import System

main = mapM_ (\la -> mapM_ (\fi -> port "Eng" fi la) files) languages

languages = words "Dan Eng Fin Fre Ger Ita Nor Rus Spa Swe"
langlong = words 
  "danish english finnish french german italian norwegian russian spanish swedish"
families = [
  ("romance", ["french", "italian", "spanish"]),
  ("scandinavian",["danish","norwegian","swedish"])
  ]

longname lang = 
  maybe (error ("no " ++ lang)) id $ lookup lang $ zip languages langlong

files = words "Combinators Constructors Symbolic"

port src file dst 
 | src == dst = return ()
 | otherwise = do
  let fdst = file ++ dst ++ ".gf"
  system $ "cp " ++ file ++ src ++ ".gf " ++ fdst
  let longsrc = longname src
  let longdst = longname dst
--  putStrLn $ "sed -i 's/" ++ longsrc ++ "/" ++ longdst ++ "/g' " ++ fdst
--  system   $ "sed -i 's/" ++ longsrc ++ "/" ++ longdst ++ "/g' " ++ fdst
  putStrLn $ "sed -i 's/" ++     src ++ "/" ++     dst ++ "/g' " ++ fdst
  system   $ "sed -i 's/" ++     src ++ "/" ++     dst ++ "/g' " ++ fdst
--  addFamily longdst fdst
  return ()

addFamily ldst fdst = maybe (return ()) add $ lookup ldst fams where
  fams = [(l,f) | (f,ls) <- families, l <- ls]
  add fam = do
    putStrLn $
      "sed -i 's/" ++ ldst ++ "/" ++ ldst ++ ":\\.\\.\\/" ++ fam ++ "/g' " ++ fdst
    system $ 
      "sed -i 's/" ++ ldst ++ "/" ++ ldst ++ ":\\.\\.\\/" ++ fam ++ "/g' " ++ fdst
    return ()
