----------------------------------------------------------------------
-- |
-- Module      : XML
--
-- Utilities for creating XML documents.
----------------------------------------------------------------------
module GF.Data.XML (XML(..), Attr, comments, showXMLDoc, showsXMLDoc, showsXML, bottomUpXML) where

import GF.Data.Utilities
import GF.Text.UTF8

data XML = Data String | CData String | Tag String [Attr] [XML] | ETag String [Attr] | Comment String | Empty
 deriving (Ord,Eq,Show)

type Attr = (String,String)

comments :: [String] -> [XML]
comments = map Comment

showXMLDoc :: XML -> String
showXMLDoc xml = showsXMLDoc xml ""

showsXMLDoc :: XML -> ShowS
showsXMLDoc xml = encodeUTF8 . showString header . showsXML xml
  where header = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"

showsXML :: XML -> ShowS
showsXML (Data s) = showString s
showsXML (CData s) = showString "<![CDATA[" . showString s .showString "]]>"
showsXML (ETag t as) = showChar '<' . showString t . showsAttrs as . showString "/>"
showsXML (Tag t as cs) = 
    showChar '<' . showString t . showsAttrs as . showChar '>' 
		 . concatS (map showsXML cs) . showString "</" . showString t . showChar '>'
showsXML (Comment c) = showString "<!-- " . showString c . showString " -->"
showsXML (Empty) = id

showsAttrs :: [Attr] -> ShowS
showsAttrs = concatS . map (showChar ' ' .) . map showsAttr

showsAttr :: Attr -> ShowS
showsAttr (n,v) = showString n . showString "=\"" . showString (escape v) . showString "\""

escape :: String -> String
escape = concatMap escChar
  where
  escChar '<'  = "&lt;"
  escChar '>'  = "&gt;"
  escChar '&'  = "&amp;"
  escChar '"'  = "&quot;"
  escChar c    = [c]

bottomUpXML :: (XML -> XML) -> XML -> XML
bottomUpXML f (Tag n attrs cs) = f (Tag n attrs (map (bottomUpXML f) cs))
bottomUpXML f x = f x
