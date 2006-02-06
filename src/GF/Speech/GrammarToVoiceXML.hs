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

import qualified GF.Canon.GFC as GFC
import GF.Grammar.Macros hiding (assign)

import GF.Infra.Modules
import GF.Data.Operations

import GF.Data.XML

import Data.List (isPrefixOf, find, intersperse)

-- | the main function
grammar2vxml :: GFC.CanonGrammar -> String
grammar2vxml gr = showsXMLDoc (skel2vxml name startcat gr') ""
    where (name, gr') = vSkeleton gr
          startcat = "Order" -- FIXME

type VIdent = String

type VSkeleton = [(VIdent, [(VIdent, [VIdent])])]


vSkeleton :: GFC.CanonGrammar -> (String,VSkeleton)
vSkeleton gr = (name,collectR rules [(c,[]) | c <- cats]) where
  collectR rr hh =
   case rr of
     (fun,typ):rs -> case catSkeleton typ of
        Ok (cats,cat) -> 
             collectR rs (updateSkeleton (symid (snd cat)) hh (fun,
	                                                    map (symid . snd) cats))
        _ -> collectR rs hh
     _ -> hh
  cats =  [symid cat | (cat,GFC.AbsCat _ _) <- defs]
  rules = [(symid fun, typ) | (fun,GFC.AbsFun typ _) <- defs]

  defs = concat [tree2list (jments m) | im@(_,ModMod m) <- modules gr, isModAbs m]
  name = ifNull "UnknownModule" (symid . last) [n | (n,ModMod m) <- modules gr, isModAbs m]

updateSkeleton :: VIdent -> VSkeleton -> (VIdent, [VIdent]) -> VSkeleton
updateSkeleton cat skel rule =
 case skel of
   (cat0,rules):rr | cat0 == cat -> (cat0, rule:rules) : rr
   (cat0,rules):rr               -> (cat0, rules) : updateSkeleton cat rr rule


skel2vxml :: String -> VIdent -> VSkeleton -> XML
skel2vxml name start skel = 
    vxml ([startForm] ++ concatMap (uncurry (catForms gr)) skel)
  where 
  gr = grammarURI name
  startForm = Tag "form" [] [subdialog "sub" [("src","#"++start)] []]

grammarURI :: String -> String
grammarURI name = name ++ ".grxml"

catForms :: String -> VIdent -> [(VIdent, [VIdent])] -> [XML]
catForms gr cat fs = 
    comments [cat ++ " category."]
    ++ [cat2form gr cat fs] 
    ++ map (uncurry (fun2form gr)) fs

cat2form :: String -> VIdent -> [(VIdent, [VIdent])] -> XML
cat2form gr cat fs = 
    form cat [var "value" (Just "'?'"),
              block [if_ "value != '?'" [assign cat "value"]],
              field cat [] [promptString ("quest_"++cat), 
                            grammar (gr++"#"++cat),
                            nomatch [Data "I didn't understand you.", reprompt],
                            help [Data ("help_"++cat)],
                            filled [] [if_else (cat ++ " == '?'") [reprompt] feedback]],
              subdialog "sub" [("srcexpr","'#'+"++cat++".name")] 
                             [param "value" cat, filled [] subDone]]
  where subDone = [assign cat "sub.value", return_ [cat]]
        feedback = [Data "Constructor: ", value (cat++".name")]

fun2form :: String -> VIdent -> [VIdent] -> XML
fun2form gr fun args = 
    form fun ([var "value" Nothing]
              ++ ss
              ++ [ret])
  where 
  argNames = zip ["arg"++show n | n <- [0..]] args
  ss = map (uncurry mkSub) argNames
  mkSub a t = subdialog a [("src","#"++t)] 
                [param "value" ("value."++a),
                 filled [] [assign ("value."++a) (a++"."++t)]]
  ret = block [return_ ["value"]]

--
-- * VoiceXML stuff
--

vxml :: [XML] -> XML
vxml = Tag "vxml" [("version","2.0"),("xmlns","http://www.w3.org/2001/vxml")]

form :: String -> [XML] -> XML
form id = Tag "form" [("id", id)]

field :: String -> [(String,String)] -> [XML] -> XML
field name attrs = Tag "field" ([("name",name)]++attrs)

subdialog :: String -> [(String,String)] -> [XML] -> XML
subdialog name attrs = Tag "subdialog" ([("name",name)]++attrs)

filled :: [(String,String)] -> [XML] -> XML
filled = Tag "filled"

grammar :: String -> XML
grammar uri = Tag "grammar" [("src",uri)] []

prompt :: [XML] -> XML
prompt = Tag "prompt" []

promptString :: String -> XML
promptString p = prompt [Data p]

reprompt :: XML
reprompt = Tag "reprompt" [] []

assign :: String -> String -> XML
assign n e = Tag "assign" [("name",n),("expr",e)] []

value :: String -> XML
value expr = Tag "value" [("expr",expr)] []

if_ :: String -> [XML] -> XML
if_ c b = if_else c b []

if_else :: String -> [XML] -> [XML] -> XML
if_else c t f = cond [(c,t)] f

cond :: [(String,[XML])] -> [XML] -> XML
cond ((c,b):rest) els = Tag "if" [("cond",c)] (b ++ es)
  where es = [Tag "elseif" [("cond",c')] b' | (c',b') <- rest] 
             ++ if null els then [] else (Tag "else" [] []:els)

goto_item :: String -> XML
goto_item nextitem = Tag "goto" [("nextitem",nextitem)] []

return_ :: [String] -> XML
return_ names = Tag "return" [("namelist", unwords names)] []

block :: [XML] -> XML
block = Tag "block" []

throw :: String -> String -> XML
throw event msg = Tag "throw" [("event",event),("message",msg)] []

nomatch :: [XML] -> XML
nomatch = Tag "nomatch" []

help :: [XML] -> XML
help = Tag "help" []

param :: String -> String -> XML
param name expr = Tag "param" [("name",name),("expr",expr)] []

var :: String -> Maybe String -> XML
var name expr = Tag "var" ([("name",name)]++e) []
  where e = maybe [] ((:[]) . (,) "expr") expr


--
-- * List stuff
--

isListCat :: (VIdent, [(VIdent, [VIdent])]) -> Bool
isListCat (cat,rules) = "List" `isPrefixOf` cat && length rules == 2
		    && ("Base"++c) `elem` fs && ("Cons"++c) `elem` fs
    where c = elemCat cat
	  fs = map fst rules

-- | Gets the element category of a list category.
elemCat :: VIdent -> VIdent
elemCat = drop 4

isBaseFun :: VIdent -> Bool
isBaseFun f = "Base" `isPrefixOf` f

isConsFun :: VIdent -> Bool
isConsFun f = "Cons" `isPrefixOf` f

baseSize :: (VIdent, [(VIdent, [VIdent])]) -> Int
baseSize (_,rules) = length bs
    where Just (_,bs) = find (("Base" `isPrefixOf`) . fst) rules
