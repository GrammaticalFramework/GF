----------------------------------------------------------------------
-- |
-- Module      : GF.Grammar.Predef
-- Maintainer  : kr.angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- Predefined identifiers and labels which the compiler knows
----------------------------------------------------------------------


module GF.Grammar.Predef
          ( cType
          , cPType
          , cTok
          , cStr
          , cStrs
          , cPredefAbs, cPredefCnc, cPredef
          , cInt
          , cFloat
          , cString
          , cVar
          , cInts
          , cPBool
          , cErrorType
          , cOverload
          , cUndefinedType
          , isLiteralCat

          , cPTrue, cPFalse

          , cLength, cDrop, cTake, cTk, cDp, cEqStr, cOccur
          , cOccurs, cEqInt, cLessInt, cPlus, cShow, cRead
          , cToStr, cMapStr, cError

          -- hacks
          , cMeta, cAs, cChar, cChars, cSeq, cAlt, cRep
          , cNeg, cCNC, cConflict
          ) where

import GF.Infra.Ident
import qualified Data.ByteString.Char8 as BS

cType :: Ident
cType = identC (BS.pack "Type")

cPType :: Ident
cPType = identC (BS.pack "PType")

cTok :: Ident
cTok = identC (BS.pack "Tok")

cStr :: Ident
cStr = identC (BS.pack "Str")

cStrs :: Ident
cStrs = identC (BS.pack "Strs")

cPredefAbs :: Ident
cPredefAbs = identC (BS.pack "PredefAbs")

cPredefCnc :: Ident
cPredefCnc = identC (BS.pack "PredefCnc")

cPredef :: Ident
cPredef = identC (BS.pack "Predef")

cInt :: Ident
cInt = identC (BS.pack "Int")

cFloat :: Ident
cFloat = identC (BS.pack "Float")

cString :: Ident
cString = identC (BS.pack "String")

cVar :: Ident
cVar = identC (BS.pack "__gfVar")

cInts :: Ident
cInts = identC (BS.pack "Ints")

cPBool :: Ident
cPBool = identC (BS.pack "PBool")

cErrorType :: Ident
cErrorType = identC (BS.pack "Error")

cOverload :: Ident
cOverload = identC (BS.pack "overload")

cUndefinedType :: Ident
cUndefinedType = identC (BS.pack "UndefinedType")

isLiteralCat :: Ident -> Bool
isLiteralCat c = elem c [cInt,cString,cFloat,cVar]

cPTrue :: Ident
cPTrue  = identC (BS.pack "PTrue")

cPFalse :: Ident
cPFalse = identC (BS.pack "PFalse")

cLength :: Ident
cLength = identC (BS.pack "length")

cDrop :: Ident
cDrop = identC (BS.pack "drop")

cTake :: Ident
cTake = identC (BS.pack "take")

cTk :: Ident
cTk = identC (BS.pack "tk")

cDp :: Ident
cDp = identC (BS.pack "dp")

cEqStr :: Ident
cEqStr = identC (BS.pack "eqStr")

cOccur :: Ident
cOccur = identC (BS.pack "occur")

cOccurs :: Ident
cOccurs = identC (BS.pack "occurs")

cEqInt :: Ident
cEqInt = identC (BS.pack "eqInt")

cLessInt :: Ident
cLessInt = identC (BS.pack "lessInt")

cPlus :: Ident
cPlus = identC (BS.pack "plus")

cShow :: Ident
cShow = identC (BS.pack "show")

cRead :: Ident
cRead = identC (BS.pack "read")

cToStr :: Ident
cToStr = identC (BS.pack "toStr")

cMapStr :: Ident
cMapStr = identC (BS.pack "mapStr")

cError :: Ident
cError = identC (BS.pack "error")


--- hacks: dummy identifiers used in various places
--- Not very nice!

cMeta :: Ident
cMeta = identC (BS.singleton '?')

cAs :: Ident
cAs = identC (BS.singleton '@')

cChar :: Ident
cChar = identC (BS.singleton '?')

cChars :: Ident
cChars = identC (BS.pack "[]")

cSeq :: Ident
cSeq = identC (BS.pack "+")

cAlt :: Ident
cAlt = identC (BS.pack "|")

cRep :: Ident
cRep = identC (BS.pack "*")

cNeg :: Ident
cNeg = identC (BS.pack "-")

cCNC :: Ident
cCNC = identC (BS.pack "CNC")

cConflict :: Ident
cConflict = IC (BS.pack "#conflict")
