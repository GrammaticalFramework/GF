-- to process constructor examples to lin commans

main = mkgfs

src = "ExxI.gf"
script = "exx.gfs"

mkgfs = do
  writeFile script ""
  readFile src >>= (mapM addLin . lines)


addLin s = case words s of
  c@('e':'x':_):_ -> appendFile script ("l " ++ c ++ "\n")
  _ -> return ()

