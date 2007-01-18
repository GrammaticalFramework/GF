----------------------------------------------------------------------
-- |
-- Module      : GrammarToVoiceXML
-- Maintainer  : Bjorn Bringert
-- Stability   : (stable)
-- Portability : (portable)
--
-- Create VoiceXML dialogue system from a GF grammar.
-----------------------------------------------------------------------------

module GF.Speech.GrammarToVoiceXML (grammar2vxml) where

import GF.Canon.CanonToGFCC (mkCanon2gfcc)
import qualified GF.Canon.GFCC.AbsGFCC as C
import GF.Canon.GFCC.DataGFCC (GFCC(..), Abstr(..), mkGFCC, lookMap)

import qualified GF.Canon.GFC as GFC
import GF.Canon.AbsGFC (Term)
import GF.Canon.PrintGFC (printTree)
import GF.Canon.CMacros (noMark, strsFromTerm)
import GF.Canon.Unlex (formatAsText)
import GF.Data.Utilities
import GF.CF.CFIdent (cfCat2Ident)
import GF.Compile.ShellState (StateGrammar,stateGrammarST,cncId,grammar,startCatStateOpts)
import GF.Data.Str (sstrV)
import GF.Grammar.Macros hiding (assign,strsFromTerm)
import GF.Grammar.Grammar (Fun)
import GF.Grammar.Values (Tree)
import GF.Infra.Option (Options)
import GF.UseGrammar.GetTree (string2treeErr)
import GF.UseGrammar.Linear (linTree2strings)

import GF.Infra.Ident
import GF.Infra.Modules
import GF.Data.Operations

import GF.Data.XML

import Control.Monad (liftM)
import Data.List (isPrefixOf, find, intersperse)
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

import Debug.Trace

-- | the main function
grammar2vxml :: Options -> StateGrammar -> String
grammar2vxml opts s = showsXMLDoc (skel2vxml name language startcat gr' qs) ""
    where (name, gr') = vSkeleton (stateGrammarST s)
          qs = catQuestions s (map fst gr')
          language = "en" -- FIXME: use speechLanguage tag
          startcat = C.CId $ prIdent $ cfCat2Ident $ startCatStateOpts opts s

--
-- * VSkeleton: a simple description of the abstract syntax.
--

type VSkeleton = [(VIdent, [(VIdent, [VIdent])])]
type VIdent = C.CId

prid :: VIdent -> String
prid (C.CId x) = x

vSkeleton :: GFC.CanonGrammar -> (VIdent,VSkeleton)
vSkeleton = gfccSkeleton . mkGFCC . mkCanon2gfcc

gfccSkeleton :: GFCC -> (VIdent,VSkeleton)
gfccSkeleton gfcc = (absname gfcc, ts)
  where a = abstract gfcc
        ts = [(c,[(f,ft f) | f <- fs]) | (c,fs) <- Map.toList (cats a)]
        ft f = case lookMap (error $ prid f) f (funs a) of
                 C.Typ args _ -> args

--
-- * Questions to ask 
--

type CatQuestions = [(VIdent,String)]

catQuestions :: StateGrammar -> [VIdent] -> CatQuestions
catQuestions gr cats = [(c,catQuestion gr c) | c <- cats]

catQuestion :: StateGrammar -> VIdent -> String
catQuestion gr cat = err errHandler id (getPrintname gr cat >>= term2string)
  where -- FIXME: use some better warning facility
        errHandler e = trace ("GrammarToVoiceXML: " ++ e) ("quest_"++prid cat)
        term2string = liftM sstrV . strsFromTerm

getPrintname :: StateGrammar -> VIdent -> Err Term
getPrintname gr cat = 
    do m <- lookupModMod (grammar gr) (cncId gr)
       i <- lookupInfo m (IC (prid cat))
       case i of
         GFC.CncCat _ _ p -> return p
         _ -> fail $ "getPrintname " ++ prid cat
                      ++ ": Expected CncCat, got " ++ show i


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

getCatQuestion :: VIdent -> CatQuestions -> String
getCatQuestion c qs = 
    fromMaybe (error "No question for category " ++ prid c) (lookup c qs)

--
-- * Generate VoiceXML
--

skel2vxml :: VIdent -> String -> VIdent -> VSkeleton -> CatQuestions -> XML
skel2vxml name language start skel qs = 
    vxml language ([startForm] ++ concatMap (uncurry (catForms gr qs)) skel)
  where 
  gr = grammarURI (prid name)
  startForm = Tag "form" [] [subdialog "sub" [("src", "#"++catFormId start)] []]

grammarURI :: String -> String
grammarURI name = name ++ ".grxml"


catForms :: String -> CatQuestions -> VIdent -> [(VIdent, [VIdent])] -> [XML]
catForms gr qs cat fs = 
    comments [prid cat ++ " category."]
    ++ [cat2form gr qs cat fs] 

{-
cat2form :: String -> CatQuestions -> VIdent -> [(VIdent, [VIdent])] -> XML
cat2form gr qs cat fs = 
    form (catFormId cat) 
      [field "value" [] 
         [promptString (getCatQuestion cat qs), 
          vxmlGrammar (gr++"#"++catFormId cat),
          filled [] [return_ ["value"]]
         ]
      ]
-}

cat2form :: String -> CatQuestions -> VIdent -> [(VIdent, [VIdent])] -> XML
cat2form gr qs cat fs = 
  form (catFormId cat) $ 
      [var "value" Nothing, 
--       var "callbacks" Nothing, 
       blockCond "value.name != '?'" [assign (catFieldId cat) "value"],
--       block [doCallback "entered" cat [return_ [catFieldId cat]] []],
       field (catFieldId cat) [] 
           [promptString (getCatQuestion cat qs), 
            vxmlGrammar (gr++"#"++catFormId cat)
            -- , nomatch [Data "I didn't understand you.", reprompt],
            -- help [Data (mkHelpText cat)],
            --filled [] [if_else (catFieldId cat ++ ".name == '?'") 
            --           [reprompt] 
            --           [{-doCallback "refined" cat [return_ [catFieldId cat]] []-}]]
           ]
      ]
     ++ concatMap (uncurry (fun2sub gr cat)) fs
     ++ [block [{- doCallback "done" cat [return_ [catFieldId cat]] [-} return_ [catFieldId cat]{-]-}]]


mkHelpText :: VIdent -> String
mkHelpText cat = "help_"++ prid cat

fun2sub :: String -> VIdent -> VIdent -> [VIdent] -> [XML]
fun2sub gr cat fun args = 
    comments [prid fun ++ " : (" 
              ++ concat (intersperse ", " (map prid args))
              ++ ") " ++ prid cat] ++ ss
  where 
  ss = zipWith mkSub [0..] args
  mkSub n t = subdialog s [("src","#"++catFormId t),
                           ("cond",catFieldId cat++".name == "++string (prid fun))] 
              [param "value" v,
--               param "callbacks" "callbacks",
               filled [] [assign v (s++"."++catFieldId t)]]
    where s = prid fun ++ "_" ++ show n
          v = catFieldId cat++".children["++show n++"]"

doCallback :: String -> VIdent -> [XML] -> [XML] -> XML
doCallback f cat i e = 
 if_else ("typeof callbacks != 'undefined' && typeof " ++ cf ++ " != 'undefined' && !" ++ cf ++ "("++string (prid cat)++","++ catFieldId cat ++ ")") 
         i e
  where cf = "callbacks." ++ f

catFieldId :: VIdent -> String
catFieldId c = prid c ++ "_field"

catFormId :: VIdent -> String
catFormId c = prid c ++ "_cat"


--
-- * VoiceXML stuff
--

vxml :: String -> [XML] -> XML
vxml language = Tag "vxml" [("version","2.0"),
                            ("xmlns","http://www.w3.org/2001/vxml"),
                            ("xml:lang", language)]

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

isListCat :: (VIdent, [(VIdent, [VIdent])]) -> Bool
isListCat (cat,rules) = "List" `isPrefixOf` prIdent cat && length rules == 2
		    && ("Base"++c) `elem` fs && ("Cons"++c) `elem` fs
    where c = drop 4 (prIdent cat)
	  fs = map (prIdent . fst) rules

isBaseFun :: VIdent -> Bool
isBaseFun f = "Base" `isPrefixOf` prIdent f

isConsFun :: VIdent -> Bool
isConsFun f = "Cons" `isPrefixOf` prIdent f

baseSize :: (VIdent, [(VIdent, [VIdent])]) -> Int
baseSize (_,rules) = length bs
    where Just (_,bs) = find (isBaseFun . fst) rules
-}