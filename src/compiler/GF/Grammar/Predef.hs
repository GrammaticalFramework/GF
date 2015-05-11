----------------------------------------------------------------------
-- |
-- Module      : GF.Grammar.Predef
-- Maintainer  : kr.angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- Predefined identifiers and labels which the compiler knows
----------------------------------------------------------------------

module GF.Grammar.Predef where

import GF.Infra.Ident(Ident,identS,moduleNameS)

cType = identS "Type"
cPType = identS "PType"
cTok = identS "Tok"
cStr = identS "Str"
cStrs = identS "Strs"
cPredefAbs = moduleNameS "PredefAbs"
cPredefCnc = moduleNameS "PredefCnc"
cPredef = moduleNameS "Predef"
cInt = identS "Int"
cFloat = identS "Float"
cString = identS "String"
cVar = identS "__gfVar"
cInts = identS "Ints"
cPBool = identS "PBool"
cErrorType = identS "Error"
cOverload = identS "overload"
cUndefinedType = identS "UndefinedType"
cNonExist = identS "nonExist"
cBIND = identS "BIND"
cSOFT_BIND = identS "SOFT_BIND"
cSOFT_SPACE = identS "SOFT_SPACE"
cCAPIT = identS "CAPIT"
cALL_CAPIT = identS "ALL_CAPIT"

isPredefCat :: Ident -> Bool
isPredefCat c = elem c [cInt,cString,cFloat]

cPTrue  = identS "PTrue"
cPFalse = identS "PFalse"
cLength = identS "length"
cDrop = identS "drop"
cTake = identS "take"
cTk = identS "tk"
cDp = identS "dp"
cToUpper = identS "toUpper"
cToLower = identS "toLower"
cIsUpper = identS "isUpper"
cEqStr = identS "eqStr"
cEqVal = identS "eqVal"
cOccur = identS "occur"
cOccurs = identS "occurs"
cEqInt = identS "eqInt"
cLessInt = identS "lessInt"
cPlus = identS "plus"
cShow = identS "show"
cRead = identS "read"
cToStr = identS "toStr"
cMapStr = identS "mapStr"
cError = identS "error"

-- * Hacks: dummy identifiers used in various places.
-- Not very nice!

cMeta = identS "?"
cAs = identS "@"
cChar = identS "?"
cChars = identS "[]"
cSeq = identS "+"
cAlt = identS "|"
cRep = identS "*"
cNeg = identS "-"
cCNC = identS "CNC"
cConflict = identS "#conflict"
