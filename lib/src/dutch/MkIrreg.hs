main = interact mkIrreg

mkIrreg = unlines . map (mkOne . words) . lines

mkOne ws = case ws of
  ('-':_):_ -> []
  p:ps:pp:ge:m:eng | elem m ["*"] -> mkV "mkZijnV" p ps pp ge eng
  p:ps:pp:ge:m:eng | elem m ["@","!"] -> mkV "mkZijnHebbenV" p ps pp ge eng
  p:ps:pp:ge:eng -> mkV "mkV" p ps pp ge eng
  _ -> []

mkV par p ps pp ge eng = unlines [
  unwords $ ["fun",f,":","V",";","--"] ++ eng,
  unwords $ ["lin",f,"=",par] ++ map quote [p,ps,pp,ge] ++ [";"]
  ]
 where f = p ++ "_V"

quote s = "\"" ++ s ++ "\""
