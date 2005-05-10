----------------------------------------------------------------------
-- |
-- Module      : EmbedCustom
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 
-- > CVS $Author: 
-- > CVS $Revision: 
--
-- A database for customizable lexers and unlexers. Reduced version of
-- GF.API, intended for embedded GF grammars.

-----------------------------------------------------------------------------

module GF.Embed.EmbedCustom where

import GF.Data.Operations
import GF.Text.Text
import GF.UseGrammar.Tokenize
import GF.UseGrammar.Morphology
import GF.Infra.Option
import GF.CF.CFIdent
import GF.Compile.ShellState
import Data.Char

-- | useTokenizer, \"-lexer=x\"
customTokenizer      :: CustomData (StateGrammar -> String -> [CFTok])  

-- | useUntokenizer, \"-unlexer=x\" --- should be from token list to string
customUntokenizer    :: CustomData (StateGrammar -> String -> String)  

-- | this is the way of selecting an item
customOrDefault :: Options -> OptFun -> CustomData a -> a
customOrDefault opts optfun db = maybe (defaultCustomVal db) id $ 
                                   customAsOptVal opts optfun db

-- | to produce menus of custom operations
customInfo :: CustomData a -> (String, [String])
customInfo c = (titleCustomData c, map (ciStr . fst) (dbCustomData c))

type CommandId = String

strCI :: String -> CommandId
strCI = id

ciStr :: CommandId -> String
ciStr = id

ciOpt :: CommandId -> Option
ciOpt = iOpt

newtype CustomData a = CustomData (String, [(CommandId,a)])

customData :: String -> [(CommandId, a)] -> CustomData a
customData title db = CustomData (title,db)

dbCustomData :: CustomData a -> [(CommandId, a)]
dbCustomData (CustomData (_,db)) = db

titleCustomData :: CustomData a -> String
titleCustomData (CustomData (t,_)) = t

lookupCustom :: CustomData a -> CommandId -> Maybe a
lookupCustom = flip lookup . dbCustomData

customAsOptVal :: Options -> OptFun -> CustomData a -> Maybe a
customAsOptVal opts optfun db = do
  arg <- getOptVal opts optfun
  lookupCustom db (strCI arg)

-- | take the first entry from the database
defaultCustomVal :: CustomData a -> a
defaultCustomVal (CustomData (s,db)) = 
  ifNull (error ("empty database:" +++ s)) (snd . head) db

customTokenizer = 
  customData "Tokenizers, selected by option -lexer=x" $
  [
   (strCI "words",     const $ tokWords)
  ,(strCI "literals",  const $ tokLits)
  ,(strCI "vars",      const $ tokVars)
  ,(strCI "chars",     const $ map (tS . singleton))
  ,(strCI "code",      const $ lexHaskell)
  ,(strCI "codevars",  lexHaskellVar . stateIsWord)
  ,(strCI "text",      const $ lexText)
  ,(strCI "unglue",    \gr -> map tS . decomposeWords (stateMorpho gr))
  ,(strCI "codelit",   lexHaskellLiteral . stateIsWord)
  ,(strCI "textlit",   lexTextLiteral . stateIsWord)
  ,(strCI "codeC",     const $ lexC2M)
  ,(strCI "codeCHigh", const $ lexC2M' True)
-- add your own tokenizers here
  ]

customUntokenizer = 
  customData "Untokenizers, selected by option -unlexer=x" $
  [
   (strCI "unwords",   const $ id)   -- DEFAULT
  ,(strCI "text",      const $ formatAsText)
  ,(strCI "html",      const $ formatAsHTML)
  ,(strCI "latex",     const $ formatAsLatex)
  ,(strCI "code",      const $ formatAsCode)
  ,(strCI "concat",    const $ filter (not . isSpace))
  ,(strCI "textlit",   const $ formatAsTextLit)
  ,(strCI "codelit",   const $ formatAsCodeLit)
  ,(strCI "concat",    const $ concatRemSpace)
  ,(strCI "glue",      const $ performBinds)
  ,(strCI "reverse",   const $ reverse)
  ,(strCI "bind",      const $ performBinds) -- backward compat
-- add your own untokenizers here
  ]

