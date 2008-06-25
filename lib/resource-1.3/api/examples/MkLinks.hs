import Char (isDigit)

src = "Constructors.html"
tgt = "Cons.html"
linkfile ex = "links/" ++ ex ++ ".txt"


main = do
  writeFile tgt ""
  readFile src >>= (mapM_ mkLink . lines)

mkLink line = case break (=="--") (words (takeWhile (/='#')line)) of
  (fun : ":" : typ, _ : num : ex) | isDigit (head num) ->
    appendFile tgt ("\n" ++ takeInit line ++ " " ++ link ex typ num)
  _ -> appendFile tgt ("\n" ++ line)
 where
   takeInit line = init (init (takeWhile (/='.') line))
   link ex typ num =
        "<a href=\"" ++ linkfile (example typ num) ++ "\">" ++ unwords ex ++ "</a>"
   example typ num = case reverse typ of
     ";":val:_ -> "ex" ++ init num ++ "_" ++ val 
     val:_     -> "ex" ++ init num ++ "_" ++ val 
