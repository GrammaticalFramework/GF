module Main where

-- to learn a lexicon from Google translate via sentence translation

import System

main = do
  xx <- getArgs
  case xx of
    "align":trees:lins:_ -> do
      ts <- readFile trees >>= return . lines
      ls <- readFile lins  >>= return . lines
      mapM_ (putStrLn . align) (zip ts ls)
    n:f:_ -> do
      nouns <- readFile n >>= return . words
      preds <- readFile f >>= return . words
      interact (const (mkExx nouns preds))

type Ident = String

mkExx nouns preds = unlines $ map predic (zip nouns predss) where
  predss = preds ++ predss -- there are more nouns than predicates

predic :: (Ident,Ident) -> String
predic (n,f) = case c of
  'A':_ -> predn n ("(UseComp (CompAP (PositA " ++ f ++ ")))")
  "V2" -> predn n ("(ComplSlash (SlashV2a " ++ f ++ ") (" ++ detn n ++ "))")
  'V':_ -> predn n ("(UseV " ++ f ++ ")")
 where
   c = tail $ dropWhile (/='_') f

predn n f = "PredVP (" ++ detn n ++ ") " ++ f
detn n = "DetCN (DetQuant DefArt NumSg) (UseN " ++ n ++ ")"

align (t,s) = unlines [
  noun ++ " = mkN " ++ nargs ++ " ;",
  pred ++ " = mk" ++ cat ++ " " ++ fargs ++ " ;"
  ]
 where
  (noun,(pred,cat)) = case words t of
    _:_:_:_:_:_:n:ps -> (
      takeWhile (/=')') n, 
      case ps of 
        "(UseComp":_:_:a:_ -> (takeWhile (/=')') a,"A")
        "(UseV":v:_ -> (takeWhile (/=')') v,"V")
        "(ComplSlash":_:v:_ -> (takeWhile (/=')') v,"V2")
      )
  (nargs,fargs) = case words s of
    de:n:"is":a:_ -> (nargsOf n de, quote (init a))
    de:n:v:_:_  -> (nargsOf n de, quote (verb v))
    de:n:v:_    -> (nargsOf n de, quote (verb (init v)))

nargsOf n d = unwords [quote n, if d == "Het" then "neuter" else "utrum"]

verb s = init s ++ "en"

quote s = "\"" ++ s ++ "\""



-- do this way:

{-
gf LangEng
> gt -cat=N | wf -file=ns
> gt -cat=A | wf -file=fs
> gt -cat=V | wf -append -file=fs
> gt -cat=V2 | wf -append -file=fs

sort -u ns >nouns
sort -u fs >preds

runghc MkExx.hs nouns preds >exx-input

gf
> rf -file=exx-input -lines -tree | l | wf -file=all-exx

ghci
> let mk (_:c:cs) = Data.Char.toUpper c : cs ++ "."
> do {s <- readFile "all-exx" ; writeFile "trans-eng" (unlines (map mk (lines s)))}

-- google-translate trans-eng, obtaining trans-dut

-- align the files, producing LexiconDut.gf

runghc MkExx.hs align exx-input trans-dut | sort -u >newlex

-}

