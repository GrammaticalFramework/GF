import Data.List

-- To massage the verb list in
-- http://www.iee.et.tu-dresden.de/~wernerr/grammar/verben_dt.html
-- Some manual clean-up needed.

mk file = do
  s <- readFile file
  mapM_ putStrLn $ map mkV $ lines s


mkV l = case words l of
  tun:tut:tat:tate:getan:_ -> fun tun ++ "\n" ++ lin tun tut tat tate getan
  tun:tut:tat:getan:_ -> fun tun ++ "\n" ++ lin tun tut tat (tat++"e") getan
  _ -> ""

fun tun = "  fun " ++ tun ++ "_V : V ;"

lin tun tut tat tate getan = 
  "  lin " ++ tun ++ "_V =  irregV " ++ 
  quote [tun,sg3 tun tut,tat,tate,getan] ++ " ;"

quote = unwords . map qu where
  qu s = case s of 
    '(':w -> vars (init w)
    _ -> vars s

sg3 tun tut = case tut of
  "*" -> case reverse tun of
    'n':'e':'t':_ -> init tun ++ "t"
    'n':'e':_     -> init (init tun) ++ "t"
    _ -> init tun ++ "t"
  _ -> words tut' !! 2
 where
   tut' = map (\c -> if c==',' then ' ' else c) tut

vars w = case words (map (\c -> if c=='/' then ' ' else c) w) of
  [s] -> quo s
  ws  -> "(variants {" ++ unwords (intersperse ";" (map quo ws)) ++ "})"

quo s = "\"" ++ s ++ "\""
