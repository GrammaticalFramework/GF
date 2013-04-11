-- A script for adding missing words to DictEngSwe by taking them from
-- from DictSwe, guided by translations in Folkets Lexikon,
-- http://folkets-lexikon.csc.kth.se/folkets/om.html

-- Run it from lib/src/swedish/folketslexikon with +RTS -K32M -M1500M

-- TODO: alo try Lexin

import Prelude hiding (lookup)
import Data.List hiding (lookup)
import System.Directory(doesFileExist,renameFile)
import System.Cmd(system)
import System.Exit
import Control.Monad(unless)
import Data.Maybe(fromJust)
import qualified Data.Map as M
import Text.XML.Light
import PGF

main = do prepare
          create

--- Source and target names ----------------------------------------------------

folkets_root = "http://folkets-lexikon.csc.kth.se/folkets/"
folkets_en_sv = "folkets_en_sv_public.xml"
folkets_sv_en = "folkets_sv_en_public.xml"

name   = "FolketsLexikon"
target = name++".gf"

--- Prepare --------------------------------------------------------------------

prepare =
    do writeFile target dummy
       download folkets_root folkets_en_sv
       download folkets_root folkets_sv_en
       makePGF pre "../../english/" "DictEngAbs.pgf" "DictEng.gf"
       gfmake  engswe "../"                  "DictEngSwe.gf"
       makePGF swe    "../" "DictSweAbs.pgf" "DictSwe.gf"
  where
    download url file         = ifMissing file $ curl (url++file)
    makePGF  imps dir pgf src = ifMissing (dir++pgf) (gfmake imps dir src)

    curl   url          = shell $ ["curl -OL --compressed",url]
    gfmake imps dir src = shell $ ["cd",dir,"&&","gf",opts,imp imps,src]

    opts = "-s -make -no-pmcfg -gfo-dir ../../alltenses"
    imp dirs = unwords ["-i ../"++dir|dir<-dirs]
    pre = ["prelude","abstract","common"]
    swe = pre++["scandinavian"]
    engswe = swe++["english"]

    ifMissing path cmd = do e <- doesFileExist path
                            unless e cmd

    shell ws  = do let cmd = unwords ws
                   putStrLn cmd
                   e <- system cmd
                   case e of
                     ExitSuccess -> return ()
                     _ -> fail "command failed"

--- Create ---------------------------------------------------------------------

create =
    do lexicon1 <- fromFolketsEnSv `fmap` readFile folkets_en_sv
       lexicon2 <- fromFolketsSvEn `fmap` readFile folkets_sv_en
       let lexicon = M.unionWith (++) lexicon1 lexicon2
       missing <- missingWords `fmap` readPGF "../DictEngAbs.pgf"
       putStrLn $ "Looking for "++show (length missing)++" missing words."
       eng <- readPGF "../../english/DictEngAbs.pgf"
       saldo <- dict2map `fmap` readPGF "../DictSweAbs.pgf"
       let entries = map (translate lexicon eng saldo) missing
           histo = M.toList $ M.fromListWith (+) [(length ts,1)|(_,ts)<-entries]
           tmp = target++".tmp"
       putStrLn $ "Found "++show (sum [n|(a,n)<-histo,a>0])++" words."
       writeFile tmp . concWrap $ map toGF entries
       renameFile tmp target
       mapM_ print histo

lang1 = head . languages

-- Finding functions by parsing is too slow. Linearize all functions instead.
dict2map :: PGF -> M.Map String [CId]
dict2map pgf = fromList [(w,[f])|f<-functions pgf,w<-lins pgf f]

lin dict f = linearize dict (lang1 dict) (mkApp f [])

lins dict f = nub . filter (/="") . map snd . concat .
              tabularLinearizes dict (lang1 dict) $ mkApp f []

missingWords pgf = missingLins pgf (lang1 pgf)

fromFolketsEnSv :: String -> M.Map String [String]
fromFolketsEnSv = 
    fromList .
    map entry . findElements (unqual "word") . fromJust . parseXMLDoc
  where
    entry w = (value w,map value (findChildren (unqual "translation") w))

fromFolketsSvEn :: String -> M.Map String [String]
fromFolketsSvEn = 
    fromList .
    concatMap entry . findElements (unqual "word") . fromJust . parseXMLDoc
  where
    entry w = [(en,[sv])|let sv=value w,
                         en<-map value (findChildren (unqual "translation") w)]

value = fromJust . findAttr (unqual "value")

lookup m = maybe [] id . M.lookup m
fromList xs = fmap nub $ M.fromListWith (++) xs

translate lexicon eng saldo eabs =
    (eabs,nub [sabs|let en=lin eng eabs,
                    sv<-lookup en lexicon,
                    sabs<-lookup sv saldo,
                    sameCat eabs sabs])

sameCat f1 f2 = suffix f1==suffix f2
  where suffix = takeWhile (/='_') . reverse . show

toGF (eabs,[]) = "--"++show eabs++"\n"
toGF (eabs,s:ss) = "  "++en++" = "++show s++";"
                   ++" -- "++show (1+length ss)
                   ++"\n"
                   ++unlines [indent++"--"++show s|s<-{-take 10-} ss]
  where
    en = show eabs
    indent = replicate (length en+3) ' '

concWrap ws = unlines header++concat ws++unlines footer

header = ["concrete "++name++" of DictEngAbs = CatSwe ** open DictSwe in {",
          "",
          "flags coding=utf8 ;",
          "",
          "lin"]
footer = ["}"]

dummy = unlines (init header++footer)
