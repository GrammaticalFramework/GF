----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.VoiceXML
--
-- Creates VoiceXML dialogue systems from PGF grammars.
-----------------------------------------------------------------------------
module GF.Speech.VoiceXML (grammar2vxml) where

import GF.Data.Operations
import GF.Data.Str (sstrV)
import GF.Data.Utilities
import GF.Data.XML
import GF.Infra.Ident
import GF.Infra.Modules
import GF.Speech.SRG (getSpeechLanguage)
import PGF.CId
import PGF.Data
import PGF.Macros
import PGF.Linearize (realize)

import Control.Monad (liftM)
import Data.List (isPrefixOf, find, intersperse)
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

import Debug.Trace

-- | the main function
grammar2vxml :: PGF -> CId -> String
grammar2vxml pgf cnc = showsXMLDoc (skel2vxml name language start skel qs) ""
    where skel = pgfSkeleton pgf
          name = prCId cnc
          qs = catQuestions pgf cnc (map fst skel)
          language = getSpeechLanguage pgf cnc
          start = mkCId (lookStartCat pgf)

--
-- * VSkeleton: a simple description of the abstract syntax.
--

type Skeleton = [(CId, [(CId, [CId])])]

pgfSkeleton :: PGF -> Skeleton
pgfSkeleton pgf = [(c,[(f,fst (catSkeleton (lookType pgf f))) | f <- fs]) 
                   | (c,fs) <- Map.toList (catfuns (abstract pgf))]

--
-- * Questions to ask 
--

type CatQuestions = [(CId,String)]

catQuestions :: PGF -> CId -> [CId] -> CatQuestions
catQuestions pgf cnc cats = [(c,catQuestion pgf cnc c) | c <- cats]

catQuestion :: PGF -> CId -> CId -> String
catQuestion pgf cnc cat = realize (lookPrintName pgf cnc cat)


{-
lin :: StateGrammar -> String -> Err String
lin gr fun = do
             tree <- string2treeErr gr fun
             let ls = map unt $ linTree2strings noMark g c tree
             case ls of
                 [] -> fail $ "No linearization of " ++ fun
                 l:_ -> return l
  where c = cncId gr
        g = stateGrammarST gr
        unt = formatAsText 
-}

getCatQuestion :: CId -> CatQuestions -> String
getCatQuestion c qs = 
    fromMaybe (error "No question for category " ++ prCId c) (lookup c qs)

--
-- * Generate VoiceXML
--

skel2vxml :: String -> Maybe String -> CId -> Skeleton -> CatQuestions -> XML
skel2vxml name language start skel qs = 
    vxml language ([startForm] ++ concatMap (uncurry (catForms gr qs)) skel)
  where 
  gr = grammarURI name
  startForm = Tag "form" [] [subdialog "sub" [("src", "#"++catFormId start)] 
                                           [param "old" "{ name : '?' }"]]

grammarURI :: String -> String
grammarURI name = name ++ ".grxml"


catForms :: String -> CatQuestions -> CId -> [(CId, [CId])] -> [XML]
catForms gr qs cat fs = 
    comments [prCId cat ++ " category."]
    ++ [cat2form gr qs cat fs] 

cat2form :: String -> CatQuestions -> CId -> [(CId, [CId])] -> XML
cat2form gr qs cat fs = 
  form (catFormId cat) $ 
      [var "old" Nothing, 
       blockCond "old.name != '?'" [assign "term" "old"],
       field "term" []
           [promptString (getCatQuestion cat qs), 
            vxmlGrammar (gr++"#"++catFormId cat)
           ]
      ]
     ++ concatMap (uncurry (fun2sub gr cat)) fs
     ++ [block [return_ ["term"]{-]-}]]

fun2sub :: String -> CId -> CId -> [CId] -> [XML]
fun2sub gr cat fun args = 
    comments [prCId fun ++ " : (" 
              ++ concat (intersperse ", " (map prCId args))
              ++ ") " ++ prCId cat] ++ ss
  where 
  ss = zipWith mkSub [0..] args
  mkSub n t = subdialog s [("src","#"++catFormId t),
                           ("cond","term.name == "++string (prCId fun))] 
              [param "old" v,
               filled [] [assign v (s++".term")]]
    where s = prCId fun ++ "_" ++ show n
          v = "term.args["++show n++"]"

catFormId :: CId -> String
catFormId c = prCId c ++ "_cat"


--
-- * VoiceXML stuff
--

vxml :: Maybe String -> [XML] -> XML
vxml ml = Tag "vxml" $ [("version","2.0"),
                        ("xmlns","http://www.w3.org/2001/vxml")]
                      ++ maybe [] (\l -> [("xml:lang", l)]) ml

form :: String -> [XML] -> XML
form id xs = Tag "form" [("id", id)] xs

field :: String -> [(String,String)] -> [XML] -> XML
field name attrs = Tag "field" ([("name",name)]++attrs)

subdialog :: String -> [(String,String)] -> [XML] -> XML
subdialog name attrs = Tag "subdialog" ([("name",name)]++attrs)

filled :: [(String,String)] -> [XML] -> XML
filled = Tag "filled"

vxmlGrammar :: String -> XML
vxmlGrammar uri = ETag "grammar" [("src",uri)]

prompt :: [XML] -> XML
prompt = Tag "prompt" []

promptString :: String -> XML
promptString p = prompt [Data p]

reprompt :: XML
reprompt = ETag "reprompt" []

assign :: String -> String -> XML
assign n e = ETag "assign" [("name",n),("expr",e)]

value :: String -> XML
value expr = ETag "value" [("expr",expr)]

if_ :: String -> [XML] -> XML
if_ c b = if_else c b []

if_else :: String -> [XML] -> [XML] -> XML
if_else c t f = cond [(c,t)] f

cond :: [(String,[XML])] -> [XML] -> XML
cond ((c,b):rest) els = Tag "if" [("cond",c)] (b ++ es)
  where es = [Tag "elseif" [("cond",c')] b' | (c',b') <- rest] 
             ++ if null els then [] else (Tag "else" [] []:els)

goto_item :: String -> XML
goto_item nextitem = ETag "goto" [("nextitem",nextitem)]

return_ :: [String] -> XML
return_ names = ETag "return" [("namelist", unwords names)]

block :: [XML] -> XML
block = Tag "block" []

blockCond :: String -> [XML] -> XML
blockCond cond = Tag "block" [("cond", cond)]

throw :: String -> String -> XML
throw event msg = Tag "throw" [("event",event),("message",msg)] []

nomatch :: [XML] -> XML
nomatch = Tag "nomatch" []

help :: [XML] -> XML
help = Tag "help" []

param :: String -> String -> XML
param name expr = ETag "param" [("name",name),("expr",expr)]

var :: String -> Maybe String -> XML
var name expr = ETag "var" ([("name",name)]++e)
  where e = maybe [] ((:[]) . (,) "expr") expr

script :: String -> XML
script s = Tag "script" [] [CData s]

scriptURI :: String -> XML
scriptURI uri = Tag "script" [("uri", uri)] []

--
-- * ECMAScript stuff
--

string :: String -> String
string s = "'" ++ concatMap esc s ++ "'"
  where esc '\'' = "\\'"
        esc c    = [c]

{-
--
-- * List stuff
--

isListCat :: (CId, [(CId, [CId])]) -> Bool
isListCat (cat,rules) = "List" `isPrefixOf` prIdent cat && length rules == 2
		    && ("Base"++c) `elem` fs && ("Cons"++c) `elem` fs
    where c = drop 4 (prIdent cat)
	  fs = map (prIdent . fst) rules

isBaseFun :: CId -> Bool
isBaseFun f = "Base" `isPrefixOf` prIdent f

isConsFun :: CId -> Bool
isConsFun f = "Cons" `isPrefixOf` prIdent f

baseSize :: (CId, [(CId, [CId])]) -> Int
baseSize (_,rules) = length bs
    where Just (_,bs) = find (isBaseFun . fst) rules
-}
