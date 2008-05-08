main = interact udeva

udeva :: String -> String
udeva = unlines . map (unwords . map udevaWord . words) . lines

udevaGF :: String -> String
udevaGF s = case s of
  '"':cs -> let (w,q:rest) = span (/='"') cs in '"' : udevaWord w ++ [q] ++ udevaGF rest
  c  :cs -> c : udevaGF cs
  _ -> s

udevaWord = encodeUTF8 . str2deva

str2deva :: String -> String
str2deva s = map toEnum $ case chop s of
  c:cs -> encodeInit c : map encode cs
  _ -> []

chop s = case s of 
  ['-']    -> [s]
  '-'  :cs -> let (c:r) = chop cs in  ('-':c) : r -- to force initial vowel
  '+'  :cs -> let (c:r) = chop cs in  ('+':c) : r -- to force non-initial vowel
  v:':':cs -> [v,':'] : chop cs
  v:'.':cs -> [v,'.'] : chop cs
  c:'a':cs -> [c]     : chop cs
  c    :cs -> [c]     : chop cs
  _        -> []

encodeInit :: String -> Int
encodeInit s = case s of
  '+':c -> encode c
  '-':c -> encodeInit c
  "a"  -> 0x0905
  "a:" -> 0x0906
  "i"  -> 0x0907
  "i:" -> 0x0908
  "u"  -> 0x0909
  "u:" -> 0x090a
  "r:" -> 0x090b
  "e"  -> 0x090f
  "E"  -> 0x0910
  "o"  -> 0x0913
  "O"  -> 0x0914
  _    -> encode s

encode :: String -> Int
encode s = case s of
  "k"  -> 0x0915
  "K"  -> 0x0916
  "g"  -> 0x0917
  "G"  -> 0x0918
  "N:" -> 0x0919

  "c"  -> 0x091a
  "C"  -> 0x091b
  "j"  -> 0x091c
  "J"  -> 0x091d
  "n:" -> 0x091e

  "t." -> 0x091f
  "T." -> 0x0920
  "d." -> 0x0921
  "D." -> 0x0922
  "n." -> 0x0923

  "t"  -> 0x0924
  "T"  -> 0x0925
  "d"  -> 0x0926
  "D"  -> 0x0927
  "n"  -> 0x0928

  "p"  -> 0x092a
  "P"  -> 0x092b
  "b"  -> 0x092c
  "B"  -> 0x092d
  "m"  -> 0x092e

  "y"  -> 0x092f
  "r"  -> 0x0930
  "l"  -> 0x0932
  "v"  -> 0x0935

  "S"  -> 0x0936
  "s." -> 0x0937
  "s"  -> 0x0938
  "h"  -> 0x0939

  "R"  -> 0x095c

  "a:" -> 0x093e
  "i"  -> 0x093f
  "i:" -> 0x0940
  "u"  -> 0x0941
  "u:" -> 0x0942
  "r:" -> 0x0943
  "e"  -> 0x0947
  "E"  -> 0x0948
  "o"  -> 0x094b
  "O"  -> 0x094c  

  "~"  -> 0x0901
  "*"  -> 0x0902

  " "  -> space
  "\n" -> fromEnum '\n'

  '-':c -> encodeInit c
  '+':c -> encode c

  _    -> 0x093e  --- a:


space = fromEnum ' '


encodeUTF8 :: String -> String
encodeUTF8 "" = ""
encodeUTF8 (c:cs) =
	if c > '\x0000' && c < '\x0080' then
	    c : encodeUTF8 cs
	else if c < toEnum 0x0800 then
	    let i = fromEnum c
	    in  toEnum (0xc0 + i `div` 0x40) : 
	        toEnum (0x80 + i `mod` 0x40) : 
		encodeUTF8 cs
	else
	    let i = fromEnum c
	    in  toEnum (0xe0 + i `div` 0x1000) : 
	        toEnum (0x80 + (i `mod` 0x1000) `div` 0x40) : 
		toEnum (0x80 + i `mod` 0x40) : 
		encodeUTF8 cs
