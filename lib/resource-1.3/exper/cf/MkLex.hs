mkEd file = do
  let out = "new.tmp"
  writeFile out ""
  ss <- readFile file >>= return . lines
  mapM_ (\s -> appendFile out (addIng s) >> appendFile out "\n") ss

addEd line = case words line of
  c@('V':_):ar:p:b:v:sc:_ -> unwords $ [c,ar,p,b,v,b,past (init v) ++ "\"",sc]
  _ -> line
 where
   past v = case last v of
     'e' -> v ++ "d"
     'y' -> init v ++ "ied"
     _   -> v ++ "ed"

addIng line = case words line of
  c@('V':_):ar:p:b:v:_:ed:sc:_ -> unwords $ [c,ar,p,b,v,b,ed,b,ing (init v) ++ "\"",sc]
  _ -> line
 where
   ing v = case last v of
     'e' -> init v ++ "ing"
     _   -> v ++ "ing"
