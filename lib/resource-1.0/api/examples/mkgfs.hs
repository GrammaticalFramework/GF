-- to process constructor examples to lin commans

main = mkgfs

src = "ExxI.gf"
script = "exx.gfs"
linkfile ex = "links/" ++ ex ++ ".txt"

mkgfs = do
  writeFile script ""
  readFile src >>= (mapM addLin . lines)


addLin s = case words s of
  c@('e':'x':_):"=":def -> do
    appendFile script ("ps \"" ++ unwords (init def) ++ "\\n\\n\" | wf " ++ linkfile c ++ "\n")
    appendFile script ("l -multi " ++ cc ++ " | af " ++ linkfile c ++ "\n")

   where
    cc = case take 2 (reverse c) of
      "PV" -> "utt " ++ c
      _ -> c 
  _ -> return ()

