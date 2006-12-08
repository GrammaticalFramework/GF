----------------------------------------------------------------------
-- |
-- Module      : XML
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- Utilities for creating XML documents.
-----------------------------------------------------------------------------

module GF.Data.XML (XML(..), Attr, comments, showsXMLDoc, showsXML) where

import GF.Data.Utilities

data XML = Data String | CData String | Tag String [Attr] [XML] | Comment String | Empty
 deriving (Ord,Eq,Show)

type Attr = (String,String)

comments :: [String] -> [XML]
comments = map Comment

showsXMLDoc :: XML -> ShowS
showsXMLDoc xml = showString header . showsXML xml 
  where header = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"

showsXML :: XML -> ShowS
showsXML (Data s) = showString s
showsXML (CData s) = showString "<![CDATA[" . showString s .showString "]]>"
showsXML (Tag t as []) = showChar '<' . showString t . showsAttrs as . showString "/>"
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
