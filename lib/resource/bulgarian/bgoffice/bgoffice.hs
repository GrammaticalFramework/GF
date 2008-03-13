import System.Directory
import Data.List
import Data.Char
import qualified Data.Map as Map
import Text.PrettyPrint

import System.Win32.NLS
import System.Win32.Console

main = do
  codepage <- getACP
  setConsoleCP codepage
  setConsoleOutputCP codepage
  fns <- fmap (sortByParadigm . concat) (mapM processCats cats)
  writeParadigmsBul fns
  writeLexiconBul fns
  writeLexiconBulAbs fns
  
processCats ch = do
  xs <- getDirectoryContents (dir ch)
  let files = [x | x <- xs, take 2 x == "bg"]
  mapM (processFile ch) files

sortByParadigm xs = map snd (sortBy (\(k1,_) (k2,_) -> compare k1 k2) ys)
  where
    ys = [case reads p of
            [(n,_)] -> (n :: Int,x)
            _       -> error ("Bad paradigm "++p) | x@(p,_,_,_) <- xs]

processFile ch file = do
  putStr file
  let fpath = dir ch++"/"++file
  txt <- readFile fpath
  let (suffixes,words) = parse fpath ch (lines txt)
  let paradigm  = reverse (drop 4 (reverse (drop 2 file)))      
      base_tmpl = head suffixes
      body = text "let" <+> vcat (punctuate (char ';') (text "v0 =" <+> mkGetStem (length (head suffixes))
                                 : [char 'v' <> int i <+> char '=' <+> text "last" <+> parens (mkGetStem suf) 
                                          | (i,suf) <- zip [1..] (splitQ base_tmpl)])) $$
             text "in" <+> text (conName ch) <+> (vcat (map (parens . mkCalcForm 0 . ('?':)) suffixes) $$
                                                  if null (params ch) then empty else text (params ch))
                                             <+> char ';'
  putStrLn (" - " ++ show (length suffixes) ++ ", " ++ show (length words) ++ " words")
  return (paradigm,ch,body,words)

deUnicode = map deUnicodeChar
  where
    deUnicodeChar c
      | n >= 1040 && n <= 1103 
                    = chr (n-848)
      | otherwise   = c
      where
        n = ord c

parse fileName ch ls = (suffixes,words)
  where
    ls1 = skipTo (deUnicode "Окончания:") ls
    (suffixes', ls2) = collect [] ls1
    suffixes = [normSuffix (getSuffix fileName suffixes' i) | i <- baseForms ch]
    ls3 = skipTo (deUnicode "Думи:") ls2
    (words, ls4) = collect [] ls3

getSuffix fileName xs i
  | i < length xs = xs !! i
  | otherwise     = error (fileName++": getSuffix "++unwords xs++" "++show i)

skipTo ll []     = []
skipTo ll (l:ls)
  | l == ll      = ls
  | otherwise    = skipTo ll ls

collect acc []     = (reverse acc,[])
collect acc (l:ls)
  | null l         = collect acc ls
  | head l == '#'  = collect acc ls
  | last l == ':'  = (reverse acc,l:ls)
  | otherwise      = collect (l:acc) ls

normSuffix "0" = ""
normSuffix s   = takeWhile (/=',') s

splitQ []       = []
splitQ ('?':cs) = length cs : splitQ cs
splitQ (c:cs)   = splitQ cs

mkGetStem n
  | n == 0    = text "base"
  | otherwise = text "tk" <+> int n <+> text "base"

mkCalcForm i form =
  case break (=='?') form of
    (cs,[])       -> doubleQuotes (text cs)
    (cs,'?':form) -> opt cs (doubleQuotes (text cs) <> char '+') <> char 'v' <> int i <> opt form (char '+' <> mkCalcForm (i+1) form)
  where
    opt [] doc = empty
    opt _  doc = doc

cyr2lats ss = 
  let xs = concatMap (cyr2lat . chr . (+848) . ord) ss
      ys = case xs of
             '_':xs -> xs
             _      -> xs
      zs = case reverse ys of
             '_':ys -> reverse ys
             _      -> ys
  in zs

cyr2lat 'а' = "a"
cyr2lat 'б' = "b"
cyr2lat 'в' = "v"
cyr2lat 'г' = "g"
cyr2lat 'д' = "d"
cyr2lat 'е' = "e"
cyr2lat 'ж' = "_zj_"
cyr2lat 'з' = "z"
cyr2lat 'и' = "i"
cyr2lat 'й' = "j"
cyr2lat 'к' = "k"
cyr2lat 'л' = "l"
cyr2lat 'м' = "m"
cyr2lat 'н' = "n"
cyr2lat 'о' = "o"
cyr2lat 'п' = "p"
cyr2lat 'р' = "r"
cyr2lat 'с' = "s"
cyr2lat 'т' = "t"
cyr2lat 'у' = "u"
cyr2lat 'ф' = "f"
cyr2lat 'х' = "h"
cyr2lat 'ц' = "c"
cyr2lat 'ч' = "_ch_"
cyr2lat 'ш' = "_sh_"
cyr2lat 'щ' = "_sht_"
cyr2lat 'ъ' = "y"
cyr2lat 'ь' = "a"
cyr2lat 'ю' = "_iu_"
cyr2lat 'я' = "_ja_"
cyr2lat x = "("++[x]++show (ord x)++")"

writeParadigmsBul fns = do  
  putStr "Writing ParadigmsBul ... "
  let opers = text "oper" $$ nest 2 (vcat (map mkOper fns))

      mkOper (paradigm,ch,body,ws) = decl $$ def
        where
          fname = "mk"++catName ch++paradigm
          def = text fname <+> text "base =" <+> body
          decl = text fname <+> text ": Str ->" <+> text (catName ch) <+> text ";"

      doc = text "resource ParadigmsBul = MorphoFunsBul ** open" $$
            text "  Predef," $$
            text "  Prelude," $$
            text "  MorphoBul," $$
            text "  CatBul" $$
            text "  in {" $$
            opers $$
            text "}"
  writeFile "ParadigmsBul.gf" (show doc)
  putStrLn "Done"

writeLexiconBulAbs fns = do
  putStr "Writing BGOfficeLexiconAbs ... "
  let mkFuns (paradigm,ch,body,ws) =
        [(w,text (cyr2lats w++"_"++catName ch) <+> char ':' <+> text (catName ch) <+> char ';') | w <- ws]        
      doc = text "abstract BGOfficeLexiconAbs = Cat ** {" $$
            text "fun" $$
            nest 2 (vcat (Map.elems (Map.fromList (concatMap mkFuns fns)))) $$
            text "}"
  writeFile "BGOfficeLexiconAbs.gf" (show doc)
  putStrLn "Done"

writeLexiconBul fns = do
  putStr "Writing BGOfficeLexicon ... "
  let mkLins (paradigm,ch,body,ws) =
        [(w,text (cyr2lats w++"_"++catName ch) <+> char '=' <+> text fname <+> doubleQuotes (text w) <+> char ';') | w <- ws]
        where
          fname = "mk"++catName ch++paradigm
      lins = Map.elems (Map.fromList (concatMap mkLins fns))
      doc = text "--# -path=.:prelude:resource/common:resource/abstract:resource/bulgarian" $$
            text "" $$
            text "concrete BGOfficeLexicon of BGOfficeLexiconAbs = CatBul **" $$
            text "open ParadigmsBul, Prelude in {" $$
            text "" $$
            text "flags" $$
            text "  optimize=values ;" $$
            text "" $$
            text "lin" $$
            nest 2 (vcat lins) $$
            text "}"
  writeFile "BGOfficeLexicon.gf" (show doc)
  putStrLn "Done"


data CatHints
  = CH { dir       :: FilePath
       , catName   :: String
       , conName   :: String
       , params    :: String
       , baseForms :: [Int]
       }  

cats = [ CH { dir = "data/verb"
            , catName = "V"
            , conName = "mkVerb"
            , params  = ""
            , baseForms = [1,3,7,13,21,30,39,48,19]
            }
       , CH { dir = "data/noun/female"
            , catName = "N"
            , conName = "mkNoun"
            , params  = "DFem"
            , baseForms = [1,3,3,5]
            }
       , CH { dir = "data/noun/male"
            , catName = "N"
            , conName = "mkNoun"
            , params  = "DMasc"
            , baseForms = [1,4,6,7]
            }
       , CH { dir = "data/noun/personal"
            , catName = "N"
            , conName = "mkNoun"
            , params  = "DMascPersonal"
            , baseForms = [1,4,6,7]
            }
       , CH { dir = "data/noun/neutral"
            , catName = "N"
            , conName = "mkNoun"
            , params  = "DNeut"
            , baseForms = [1,3,3,1]
            }
       , CH { dir = "data/adjective"
            , catName = "A"
            , conName = "mkAdjective"
            , params  = ""
            , baseForms = [1,2,3,4,5,6,7,8,9]
            }
       ]
