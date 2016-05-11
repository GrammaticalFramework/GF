-- runghc Globes.hs >globe.dot
-- circo -Tsvg globe.dot >globe.svg

main = do
  putStrLn $ graph languages

graph langs = unlines $[
  "digraph {",
  "node [shape = oval] ;",
  "edge [dir = none] ;"
--  "edge [dir = both] ;"
  ] ++ links langs ++ [
  "}"
  ]

links langs = [a ++ " -> " ++ b ++ " ;" | a <- langs, b <- langs, a < b] -- transfer
-- links langs = [a ++ " -> " ++ interlingua ++ " ;" | a <- langs] -- interlingua

interlingua = "Meaning"

languages = [
  "afrikaans",
--  "አማርኛ",
--  "العربية",
  "Български",
  "català",
  "中文",
  "dansk",
  "nederlands",
  "English",
  "eesti",
  "suomi",
  "français",
  "Deutsch",
  "Ελληνικά",
  "हिन्दी",
  "italiano",
  "日本語", 
--  "latina",
  "latviešu",
  "Malti",
  "Монгол",
  "नेपाली",
  "norsk",
  "پeرسن",
  "polski",
  "پنجابی",
  "Русский",
  "ٻولي",
  "español",
  "svenska",
  "ไทย",
  "اردو"
  ]
