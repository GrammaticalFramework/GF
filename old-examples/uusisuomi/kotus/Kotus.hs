import List
import Char

kotus = "sanat.xxmmll"

main = do
  ss <- readFile kotus >>= return . lines
  let ws = [w | Just w <- map analyse ss]
  writeFile "kotus.gf" $ unlines $ treat ws
--  mapM putStrLn $ treat ws

treat = map mkLin . entries

entries = zip [10001..] . filter isNoun

isNoun x = ((<5) . read . take 1 . fst) x && (all isAlpha . snd) x

mkLin (n,(pa,ex)) = 
  "fun n" ++ show n ++ "_" ++ ex ++ " : N ;\n" ++
  "lin n" ++ show n ++ "_" ++ ex ++ " = ud d" ++ pa ++ " \"" ++ ex ++ "\" ;"

-- treat = map mkRule . paradigms

mkRule ((pa,ex),nu) = 
  "  " ++ pos ++ pa ++ " : Str -> " ++ poss  ++ 
  "Forms -- " ++ show nu ++ " " ++ ex ++ "\n    = \\s ->  ;" 
 where
   (pos,poss) = if read (take 2 pa) < 52 then ("d","N") else ("c","V")

-- paradigms = map info . groupByFst . sort

info x = (last x, length x)
--info = last

-- groupByFst = groupBy (\ x y -> fst x == fst y)

-- <st><s>aaloe</s><t><tn>3</tn></t></st>
-- <st><s>vuoksi</s><hn>1</hn><t><tn>7</tn></t></st>
-- <st><s>visiitti</s><t><tn>5</tn><av>C</av></t></st>

analyse s = 
  let 
    rest = drop 7 s
    (word,end) = span (/='<') rest
    lst = drop 6 $ dropWhile (/='t') end
    (num,gr) = span isDigit lst
    para = (replicate (2 - length num) '0' ++ num) ++ ['A' | isPrefixOf "av" (drop 6 gr)]
  in case num of
    "" -> Nothing
    "0" -> Nothing
    _ | length num > 2 -> Nothing
    _ -> if last word == 't' then Nothing else Just (para,word)

sub cs s = isPrefixOf cs s || isPrefixOf cs (drop 1 s)

