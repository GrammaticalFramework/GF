{-# OPTIONS -fglasgow-exts -cpp #-}
-- parser produced by Happy Version 1.13

module ParGFC where
import AbsGFC
import LexGFC
import ErrM
import Ident --H
import Array
#if __GLASGOW_HASKELL__ >= 503
import GHC.Exts
#else
import GlaExts
#endif

newtype HappyAbsSyn t4 t5 t6 = HappyAbsSyn (() -> ())
happyIn4 :: t4 -> (HappyAbsSyn t4 t5 t6)
happyIn4 x = unsafeCoerce# x
{-# INLINE happyIn4 #-}
happyOut4 :: (HappyAbsSyn t4 t5 t6) -> t4
happyOut4 x = unsafeCoerce# x
{-# INLINE happyOut4 #-}
happyIn5 :: t5 -> (HappyAbsSyn t4 t5 t6)
happyIn5 x = unsafeCoerce# x
{-# INLINE happyIn5 #-}
happyOut5 :: (HappyAbsSyn t4 t5 t6) -> t5
happyOut5 x = unsafeCoerce# x
{-# INLINE happyOut5 #-}
happyIn6 :: t6 -> (HappyAbsSyn t4 t5 t6)
happyIn6 x = unsafeCoerce# x
{-# INLINE happyIn6 #-}
happyOut6 :: (HappyAbsSyn t4 t5 t6) -> t6
happyOut6 x = unsafeCoerce# x
{-# INLINE happyOut6 #-}
happyIn7 :: (Canon) -> (HappyAbsSyn t4 t5 t6)
happyIn7 x = unsafeCoerce# x
{-# INLINE happyIn7 #-}
happyOut7 :: (HappyAbsSyn t4 t5 t6) -> (Canon)
happyOut7 x = unsafeCoerce# x
{-# INLINE happyOut7 #-}
happyIn8 :: (Module) -> (HappyAbsSyn t4 t5 t6)
happyIn8 x = unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn t4 t5 t6) -> (Module)
happyOut8 x = unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (ModType) -> (HappyAbsSyn t4 t5 t6)
happyIn9 x = unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn t4 t5 t6) -> (ModType)
happyOut9 x = unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: ([Module]) -> (HappyAbsSyn t4 t5 t6)
happyIn10 x = unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn t4 t5 t6) -> ([Module])
happyOut10 x = unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: (Extend) -> (HappyAbsSyn t4 t5 t6)
happyIn11 x = unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn t4 t5 t6) -> (Extend)
happyOut11 x = unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: (Open) -> (HappyAbsSyn t4 t5 t6)
happyIn12 x = unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn t4 t5 t6) -> (Open)
happyOut12 x = unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: (Flag) -> (HappyAbsSyn t4 t5 t6)
happyIn13 x = unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn t4 t5 t6) -> (Flag)
happyOut13 x = unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: (Def) -> (HappyAbsSyn t4 t5 t6)
happyIn14 x = unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn t4 t5 t6) -> (Def)
happyOut14 x = unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: (ParDef) -> (HappyAbsSyn t4 t5 t6)
happyIn15 x = unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn t4 t5 t6) -> (ParDef)
happyOut15 x = unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (Status) -> (HappyAbsSyn t4 t5 t6)
happyIn16 x = unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn t4 t5 t6) -> (Status)
happyOut16 x = unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: (CIdent) -> (HappyAbsSyn t4 t5 t6)
happyIn17 x = unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn t4 t5 t6) -> (CIdent)
happyOut17 x = unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: (Exp) -> (HappyAbsSyn t4 t5 t6)
happyIn18 x = unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn t4 t5 t6) -> (Exp)
happyOut18 x = unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: (Exp) -> (HappyAbsSyn t4 t5 t6)
happyIn19 x = unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn t4 t5 t6) -> (Exp)
happyOut19 x = unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: (Exp) -> (HappyAbsSyn t4 t5 t6)
happyIn20 x = unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn t4 t5 t6) -> (Exp)
happyOut20 x = unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: (Sort) -> (HappyAbsSyn t4 t5 t6)
happyIn21 x = unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn t4 t5 t6) -> (Sort)
happyOut21 x = unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyIn22 :: (Equation) -> (HappyAbsSyn t4 t5 t6)
happyIn22 x = unsafeCoerce# x
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn t4 t5 t6) -> (Equation)
happyOut22 x = unsafeCoerce# x
{-# INLINE happyOut22 #-}
happyIn23 :: (APatt) -> (HappyAbsSyn t4 t5 t6)
happyIn23 x = unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn t4 t5 t6) -> (APatt)
happyOut23 x = unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: ([Decl]) -> (HappyAbsSyn t4 t5 t6)
happyIn24 x = unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn t4 t5 t6) -> ([Decl])
happyOut24 x = unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: ([APatt]) -> (HappyAbsSyn t4 t5 t6)
happyIn25 x = unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn t4 t5 t6) -> ([APatt])
happyOut25 x = unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: ([Equation]) -> (HappyAbsSyn t4 t5 t6)
happyIn26 x = unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn t4 t5 t6) -> ([Equation])
happyOut26 x = unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: (Atom) -> (HappyAbsSyn t4 t5 t6)
happyIn27 x = unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn t4 t5 t6) -> (Atom)
happyOut27 x = unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: (Decl) -> (HappyAbsSyn t4 t5 t6)
happyIn28 x = unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn t4 t5 t6) -> (Decl)
happyOut28 x = unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: (CType) -> (HappyAbsSyn t4 t5 t6)
happyIn29 x = unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn t4 t5 t6) -> (CType)
happyOut29 x = unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: (Labelling) -> (HappyAbsSyn t4 t5 t6)
happyIn30 x = unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn t4 t5 t6) -> (Labelling)
happyOut30 x = unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: (Term) -> (HappyAbsSyn t4 t5 t6)
happyIn31 x = unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn t4 t5 t6) -> (Term)
happyOut31 x = unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: (Term) -> (HappyAbsSyn t4 t5 t6)
happyIn32 x = unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn t4 t5 t6) -> (Term)
happyOut32 x = unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (Term) -> (HappyAbsSyn t4 t5 t6)
happyIn33 x = unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn t4 t5 t6) -> (Term)
happyOut33 x = unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyIn34 :: (Tokn) -> (HappyAbsSyn t4 t5 t6)
happyIn34 x = unsafeCoerce# x
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn t4 t5 t6) -> (Tokn)
happyOut34 x = unsafeCoerce# x
{-# INLINE happyOut34 #-}
happyIn35 :: (Assign) -> (HappyAbsSyn t4 t5 t6)
happyIn35 x = unsafeCoerce# x
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn t4 t5 t6) -> (Assign)
happyOut35 x = unsafeCoerce# x
{-# INLINE happyOut35 #-}
happyIn36 :: (Case) -> (HappyAbsSyn t4 t5 t6)
happyIn36 x = unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn t4 t5 t6) -> (Case)
happyOut36 x = unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: (Variant) -> (HappyAbsSyn t4 t5 t6)
happyIn37 x = unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn t4 t5 t6) -> (Variant)
happyOut37 x = unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: (Label) -> (HappyAbsSyn t4 t5 t6)
happyIn38 x = unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn t4 t5 t6) -> (Label)
happyOut38 x = unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: (ArgVar) -> (HappyAbsSyn t4 t5 t6)
happyIn39 x = unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn t4 t5 t6) -> (ArgVar)
happyOut39 x = unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: (Patt) -> (HappyAbsSyn t4 t5 t6)
happyIn40 x = unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn t4 t5 t6) -> (Patt)
happyOut40 x = unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyIn41 :: (PattAssign) -> (HappyAbsSyn t4 t5 t6)
happyIn41 x = unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn t4 t5 t6) -> (PattAssign)
happyOut41 x = unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: ([Flag]) -> (HappyAbsSyn t4 t5 t6)
happyIn42 x = unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn t4 t5 t6) -> ([Flag])
happyOut42 x = unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyIn43 :: ([Def]) -> (HappyAbsSyn t4 t5 t6)
happyIn43 x = unsafeCoerce# x
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn t4 t5 t6) -> ([Def])
happyOut43 x = unsafeCoerce# x
{-# INLINE happyOut43 #-}
happyIn44 :: ([ParDef]) -> (HappyAbsSyn t4 t5 t6)
happyIn44 x = unsafeCoerce# x
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn t4 t5 t6) -> ([ParDef])
happyOut44 x = unsafeCoerce# x
{-# INLINE happyOut44 #-}
happyIn45 :: ([CType]) -> (HappyAbsSyn t4 t5 t6)
happyIn45 x = unsafeCoerce# x
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn t4 t5 t6) -> ([CType])
happyOut45 x = unsafeCoerce# x
{-# INLINE happyOut45 #-}
happyIn46 :: ([CIdent]) -> (HappyAbsSyn t4 t5 t6)
happyIn46 x = unsafeCoerce# x
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn t4 t5 t6) -> ([CIdent])
happyOut46 x = unsafeCoerce# x
{-# INLINE happyOut46 #-}
happyIn47 :: ([Assign]) -> (HappyAbsSyn t4 t5 t6)
happyIn47 x = unsafeCoerce# x
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn t4 t5 t6) -> ([Assign])
happyOut47 x = unsafeCoerce# x
{-# INLINE happyOut47 #-}
happyIn48 :: ([ArgVar]) -> (HappyAbsSyn t4 t5 t6)
happyIn48 x = unsafeCoerce# x
{-# INLINE happyIn48 #-}
happyOut48 :: (HappyAbsSyn t4 t5 t6) -> ([ArgVar])
happyOut48 x = unsafeCoerce# x
{-# INLINE happyOut48 #-}
happyIn49 :: ([Labelling]) -> (HappyAbsSyn t4 t5 t6)
happyIn49 x = unsafeCoerce# x
{-# INLINE happyIn49 #-}
happyOut49 :: (HappyAbsSyn t4 t5 t6) -> ([Labelling])
happyOut49 x = unsafeCoerce# x
{-# INLINE happyOut49 #-}
happyIn50 :: ([Case]) -> (HappyAbsSyn t4 t5 t6)
happyIn50 x = unsafeCoerce# x
{-# INLINE happyIn50 #-}
happyOut50 :: (HappyAbsSyn t4 t5 t6) -> ([Case])
happyOut50 x = unsafeCoerce# x
{-# INLINE happyOut50 #-}
happyIn51 :: ([Term]) -> (HappyAbsSyn t4 t5 t6)
happyIn51 x = unsafeCoerce# x
{-# INLINE happyIn51 #-}
happyOut51 :: (HappyAbsSyn t4 t5 t6) -> ([Term])
happyOut51 x = unsafeCoerce# x
{-# INLINE happyOut51 #-}
happyIn52 :: ([String]) -> (HappyAbsSyn t4 t5 t6)
happyIn52 x = unsafeCoerce# x
{-# INLINE happyIn52 #-}
happyOut52 :: (HappyAbsSyn t4 t5 t6) -> ([String])
happyOut52 x = unsafeCoerce# x
{-# INLINE happyOut52 #-}
happyIn53 :: ([Variant]) -> (HappyAbsSyn t4 t5 t6)
happyIn53 x = unsafeCoerce# x
{-# INLINE happyIn53 #-}
happyOut53 :: (HappyAbsSyn t4 t5 t6) -> ([Variant])
happyOut53 x = unsafeCoerce# x
{-# INLINE happyOut53 #-}
happyIn54 :: ([PattAssign]) -> (HappyAbsSyn t4 t5 t6)
happyIn54 x = unsafeCoerce# x
{-# INLINE happyIn54 #-}
happyOut54 :: (HappyAbsSyn t4 t5 t6) -> ([PattAssign])
happyOut54 x = unsafeCoerce# x
{-# INLINE happyOut54 #-}
happyIn55 :: ([Patt]) -> (HappyAbsSyn t4 t5 t6)
happyIn55 x = unsafeCoerce# x
{-# INLINE happyIn55 #-}
happyOut55 :: (HappyAbsSyn t4 t5 t6) -> ([Patt])
happyOut55 x = unsafeCoerce# x
{-# INLINE happyOut55 #-}
happyIn56 :: ([Ident]) -> (HappyAbsSyn t4 t5 t6)
happyIn56 x = unsafeCoerce# x
{-# INLINE happyIn56 #-}
happyOut56 :: (HappyAbsSyn t4 t5 t6) -> ([Ident])
happyOut56 x = unsafeCoerce# x
{-# INLINE happyOut56 #-}
happyInTok :: Token -> (HappyAbsSyn t4 t5 t6)
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn t4 t5 t6) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x26\x02\x22\x02\x00\x00\x21\x02\x5b\x01\x18\x02\x28\x02\x1f\x02\x00\x00\x3f\x02\x12\x02\x12\x02\x12\x02\x12\x02\x3a\x02\x00\x00\x1c\x02\x00\x00\x17\x00\x0d\x02\x0d\x02\x00\x00\x38\x02\x17\x02\x34\x02\x0c\x02\x0c\x02\x32\x02\x00\x00\x00\x00\x33\x02\x0b\x02\x00\x00\x5b\x01\x15\x02\x00\x00\x06\x02\x00\x00\x13\x02\x00\x00\x31\x02\x71\x00\x03\x02\x2f\x02\x0f\x02\x2e\x02\x00\x00\x02\x02\x02\x02\x02\x02\x02\x02\x02\x02\x02\x02\x02\x02\x00\x00\x2c\x02\x2b\x02\x27\x02\x29\x02\x25\x02\x24\x02\x20\x02\x00\x00\x00\x02\x00\x00\xf6\x01\x00\x00\xf6\x01\xf6\x01\x10\x00\xf6\x01\x60\x00\x60\x00\xf6\x01\x10\x00\x19\x02\x00\x00\x00\x00\x00\x00\xa2\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf5\x01\x10\x00\xf5\x01\xf5\x01\xf0\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09\x02\x00\x00\x00\x00\x1e\x02\x15\x00\x60\x00\xee\x01\x00\x00\x1d\x02\x1b\x02\x1a\x02\x16\x02\x10\x02\x14\x02\x00\x00\xe9\x01\x11\x02\x10\x00\x10\x00\x08\x02\x0c\x00\x00\x00\xfe\x01\x00\x00\x0a\x02\x05\x02\x01\x02\xd3\x01\x0c\x00\xd2\x01\x60\x00\x00\x00\x00\x00\xf2\x01\xf8\x00\xec\x01\xf1\x01\xf4\x01\x00\x00\x10\x00\xc4\x01\x00\x00\xf3\x01\x7a\x00\x00\x00\x10\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\xe4\x00\x00\x00\x00\x00\x00\x00\xe8\x01\xdd\x01\xe1\x01\x00\x00\x00\x00\x15\x00\x43\x00\x0c\x00\xbf\x01\xbf\x01\x60\x00\xe4\x01\x00\x00\x00\x00\x60\x00\x15\x00\x60\x00\xb7\x00\xb4\x01\x00\x00\x00\x00\x00\x00\x00\x00\xb4\x01\x87\x00\xca\x01\xe0\x01\x0c\x00\x0c\x00\xd4\x01\x00\x00\x00\x00\x00\x00\xdf\x01\x00\x00\x00\x00\xb4\x00\x00\x00\x00\x00\xde\x01\xdc\x01\xd1\x01\x51\x00\x15\x00\xb0\x01\xb0\x01\xc7\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\xa2\x01\x00\x00\x00\x00\x00\x00\x00\x00\xcc\x01\xb6\x01\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00\x15\x00\x0e\x00\x00\x00\x47\x00\xcb\x01\x41\x00\x00\x00\xbd\x01\xbb\x01\x0c\x00\x9b\x01\x00\x00\x00\x00\x94\x00\x00\x00\x00\x00\xc0\x01\xbc\x01\x5b\x00\x00\x00\x00\x00\x4b\x00\x00\x00\xae\x01\x88\x01\x10\x00\xa9\x00\x00\x00\x00\x00\x00\x00\xbe\x01\x3f\x00\xba\x01\x00\x00\x00\x00\x00\x00\x15\x00\x80\x01\x00\x00\x0c\x00\x00\x00\xb9\x01\x0c\x00\xad\x01\x00\x00\xad\x01\x00\x00\xb8\x01\xaf\x01\xaa\x01\xa6\x01\x00\x00\xf8\xff\x00\x00\x7b\x01\x00\x00\x00\x00\x15\x00\x5c\x00\x4e\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x13\x00\x00\x00\x00\x00\x00\x00\x61\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\xac\x01\xab\x01\xa9\x01\xa8\x01\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x9f\x01\x03\x00\x00\x00\x00\x00\x96\x01\x00\x00\x9d\x01\x9c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x95\x01\x61\x00\x00\x00\x74\x01\x8d\x01\x00\x00\x64\x00\x00\x00\x00\x00\xaf\x00\x8b\x01\x00\x00\x38\x01\x00\x00\x00\x00\x7a\x01\x75\x01\x73\x01\x69\x01\x65\x01\x57\x01\x54\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4f\x01\x00\x00\x49\x01\x34\x01\xff\x01\x8c\x01\x4e\x01\x4d\x01\x6b\x00\xed\x01\x00\x00\x00\x00\x00\x00\x00\x00\x07\x02\x00\x00\x00\x00\x00\x00\x00\x00\x2d\x01\x2e\x01\xdb\x01\x78\x01\x2c\x01\x24\x01\x00\x00\x00\x00\x00\x00\x00\x00\xfc\x00\x00\x00\x00\x00\x00\x00\x00\x00\x70\x00\x3d\x01\x22\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xba\x00\x00\x00\xc9\x01\xb7\x01\x00\x00\x1e\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe8\x00\x15\x01\x0a\x00\x14\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x39\x00\x00\x00\xa5\x01\x23\x01\x00\x00\x00\x00\xf2\x00\x00\x00\x93\x01\x00\x00\x81\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x85\x00\x00\x00\x0c\x01\x55\x01\x1d\x01\xeb\x00\x00\x00\x00\x00\x00\x00\xd0\x00\x06\x00\xa5\x00\x00\x00\x7e\x00\x00\x00\x00\x00\xc7\x00\x00\x00\xc2\x00\x00\x00\x00\x00\x00\x00\xf5\x00\x35\x01\x00\x00\x00\x00\x00\x00\xed\x00\x00\x00\x00\x00\xcb\x00\x00\x00\x00\x00\xb6\x00\x00\x00\x00\x00\x00\x00\x45\x01\x12\x00\xe6\x00\xc9\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6f\x01\xc0\x00\x00\x00\x00\x00\xb2\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xec\x00\x05\x00\x86\x00\x00\x00\x3e\x01\x56\x01\x3e\x01\x00\x00\x00\x00\x00\x00\xe3\x00\x77\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa6\x00\x00\x00\x00\x00\x66\x01\x00\x00\x00\x00\x97\x00\x5d\x01\xf2\x00\x00\x00\x00\x00\x00\x00\x00\x00\x63\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09\x00\x89\x00\x00\x00\xc4\x00\x00\x00\x44\x01\xbb\x00\x00\x00\x00\x00\x00\x00\xe4\xff\x00\x00\x00\x00\x00\x00\x00\x00\xdc\xff\xea\x00\x00\x00\x0f\x00\x00\x00\x00\x00\x07\x00\x23\x00\x0b\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xf4\xff\x00\x00\xfe\xff\x00\x00\xfa\xff\x7a\xff\x79\xff\x00\x00\xf3\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf6\xff\x00\x00\xf8\xff\xf1\xff\x00\x00\x7a\xff\x78\xff\x00\x00\xef\xff\x00\x00\x00\x00\x00\x00\x00\x00\xf7\xff\xf2\xff\x00\x00\x7a\xff\xf4\xff\xfb\xff\x00\x00\x9d\xff\x00\x00\xf5\xff\x9b\xff\xf0\xff\x00\x00\x00\x00\x00\x00\x00\x00\xe3\xff\x00\x00\xf9\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9c\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9a\xff\x00\x00\xe4\xff\x00\x00\xee\xff\x00\x00\xd1\xff\x00\x00\x00\x00\x00\x00\x00\x00\x99\xff\x00\x00\x00\x00\xc6\xff\xc5\xff\xca\xff\xdc\xff\xeb\xff\xe0\xff\xc4\xff\xdb\xff\xcc\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd8\xff\xda\xff\xfd\xff\xfc\xff\x96\xff\x98\xff\xea\xff\xc0\xff\x00\x00\x8c\xff\x00\x00\x00\x00\xbf\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd0\xff\xe6\xff\xd1\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbe\xff\x00\x00\xa7\xff\x8b\xff\x00\x00\x00\x00\x00\x00\x00\x00\x99\xff\xe5\xff\xc7\xff\xc8\xff\x00\x00\x00\x00\x00\x00\x00\x00\xce\xff\xe1\xff\x00\x00\x00\x00\xe2\xff\x00\x00\x00\x00\xdd\xff\x00\x00\xd9\xff\x00\x00\xc9\xff\x95\xff\x97\xff\x00\x00\xac\xff\xb7\xff\xbb\xff\xaf\xff\xad\xff\xe9\xff\xb6\xff\xbc\xff\x92\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa6\xff\xc2\xff\x00\x00\x8c\xff\x00\x00\x00\x00\x8f\xff\xec\xff\xc3\xff\x94\xff\xcf\xff\xed\xff\x00\x00\x8e\xff\x00\x00\x00\x00\x00\x00\x00\x00\x8a\xff\xbd\xff\x86\xff\x00\x00\xb9\xff\x86\xff\x00\x00\xb5\xff\x84\xff\x91\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xde\xff\xd5\xff\xd4\xff\xd3\xff\xcd\xff\x00\x00\x00\x00\xd2\xff\xcb\xff\xce\xff\xd7\xff\x00\x00\x00\x00\xa5\xff\xb3\xff\xb1\xff\xb8\xff\x00\x00\x92\xff\x00\x00\xb4\xff\x00\x00\x7c\xff\x00\x00\xc1\xff\xae\xff\xe8\xff\x00\x00\x8f\xff\x93\xff\x8d\xff\x00\x00\x85\xff\xb0\xff\x88\xff\x00\x00\x00\x00\xba\xff\x83\xff\x82\xff\x90\xff\xaa\xff\x00\x00\x00\x00\x00\x00\xd6\xff\xdf\xff\xa4\xff\x81\xff\x00\x00\x00\x00\xa2\xff\x9f\xff\x7b\xff\x7f\xff\x00\x00\xa1\xff\x00\x00\xb2\xff\x7c\xff\x00\x00\xe7\xff\x87\xff\xa9\xff\x7c\xff\x00\x00\x7e\xff\x00\x00\x00\x00\x84\xff\x82\xff\x80\xff\xa8\xff\xab\xff\xa0\xff\x7f\xff\x00\x00\x00\x00\xa3\xff\x9e\xff\x7d\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x07\x00\x00\x00\x00\x00\x00\x00\x30\x00\x02\x00\x16\x00\x03\x00\x01\x00\x03\x00\x00\x00\x03\x00\x08\x00\x0b\x00\x03\x00\x33\x00\x0c\x00\x06\x00\x0a\x00\x0f\x00\x0c\x00\x11\x00\x07\x00\x0f\x00\x1a\x00\x11\x00\x12\x00\x00\x00\x1f\x00\x02\x00\x11\x00\x22\x00\x22\x00\x22\x00\x32\x00\x22\x00\x25\x00\x1d\x00\x25\x00\x24\x00\x2b\x00\x21\x00\x28\x00\x2d\x00\x22\x00\x34\x00\x34\x00\x34\x00\x34\x00\x32\x00\x2e\x00\x32\x00\x30\x00\x31\x00\x32\x00\x33\x00\x32\x00\x31\x00\x32\x00\x33\x00\x03\x00\x04\x00\x31\x00\x24\x00\x31\x00\x08\x00\x03\x00\x12\x00\x09\x00\x0c\x00\x15\x00\x08\x00\x0f\x00\x03\x00\x11\x00\x0c\x00\x03\x00\x16\x00\x0f\x00\x10\x00\x11\x00\x08\x00\x0c\x00\x0d\x00\x0e\x00\x0c\x00\x03\x00\x03\x00\x0f\x00\x16\x00\x11\x00\x03\x00\x01\x00\x04\x00\x05\x00\x0c\x00\x0c\x00\x0e\x00\x0e\x00\x00\x00\x0c\x00\x09\x00\x13\x00\x2c\x00\x00\x00\x32\x00\x31\x00\x32\x00\x33\x00\x04\x00\x0b\x00\x00\x00\x31\x00\x32\x00\x33\x00\x1b\x00\x1c\x00\x32\x00\x00\x00\x31\x00\x06\x00\x33\x00\x31\x00\x32\x00\x33\x00\x00\x00\x0c\x00\x01\x00\x0e\x00\x00\x00\x1a\x00\x27\x00\x31\x00\x31\x00\x33\x00\x33\x00\x1f\x00\x31\x00\x22\x00\x28\x00\x23\x00\x01\x00\x0d\x00\x26\x00\x27\x00\x02\x00\x23\x00\x2a\x00\x2b\x00\x2d\x00\x17\x00\x18\x00\x2f\x00\x23\x00\x31\x00\x2c\x00\x1f\x00\x00\x00\x00\x00\x22\x00\x02\x00\x15\x00\x2c\x00\x31\x00\x32\x00\x33\x00\x0c\x00\x00\x00\x2b\x00\x0f\x00\x0d\x00\x11\x00\x12\x00\x0c\x00\x0d\x00\x0e\x00\x01\x00\x0a\x00\x00\x00\x00\x00\x01\x00\x02\x00\x19\x00\x1d\x00\x00\x00\x0d\x00\x00\x00\x21\x00\x00\x00\x01\x00\x02\x00\x15\x00\x0d\x00\x15\x00\x24\x00\x02\x00\x15\x00\x0d\x00\x14\x00\x0d\x00\x00\x00\x0d\x00\x18\x00\x31\x00\x32\x00\x33\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x31\x00\x32\x00\x33\x00\x0d\x00\x23\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x30\x00\x23\x00\x02\x00\x19\x00\x02\x00\x00\x00\x00\x00\x01\x00\x02\x00\x0b\x00\x0d\x00\x2a\x00\x00\x00\x01\x00\x02\x00\x00\x00\x01\x00\x02\x00\x0d\x00\x0d\x00\x2f\x00\x17\x00\x18\x00\x05\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0d\x00\x0b\x00\x19\x00\x13\x00\x23\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x21\x00\x00\x00\x01\x00\x02\x00\x23\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x01\x00\x02\x00\x23\x00\x0d\x00\x30\x00\x31\x00\x2f\x00\x00\x00\x00\x00\x01\x00\x02\x00\x0d\x00\x0d\x00\x00\x00\x02\x00\x29\x00\x02\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0d\x00\x00\x00\x19\x00\x00\x00\x23\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x01\x00\x02\x00\x23\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x00\x00\x01\x00\x02\x00\x23\x00\x0d\x00\x16\x00\x0c\x00\x00\x00\x01\x00\x02\x00\x14\x00\x00\x00\x0d\x00\x0d\x00\x18\x00\x00\x00\x00\x00\x00\x00\x1b\x00\x1c\x00\x0d\x00\x1e\x00\x00\x00\x00\x00\x19\x00\x00\x00\x23\x00\x1b\x00\x0d\x00\x0d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x1b\x00\x23\x00\x0d\x00\x1e\x00\x20\x00\x00\x00\x19\x00\x19\x00\x23\x00\x00\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x2e\x00\x00\x00\x17\x00\x00\x00\x20\x00\x33\x00\x00\x00\x1e\x00\x00\x00\x20\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x2e\x00\x0d\x00\x17\x00\x21\x00\x2d\x00\x33\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x30\x00\x31\x00\x17\x00\x0d\x00\x26\x00\x06\x00\x00\x00\x00\x00\x08\x00\x00\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x00\x00\x00\x00\x17\x00\x00\x00\x00\x00\x32\x00\x04\x00\x09\x00\x01\x00\x31\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x02\x00\x33\x00\x17\x00\x04\x00\x04\x00\x01\x00\x04\x00\x01\x00\x15\x00\x15\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x31\x00\x17\x00\x17\x00\x04\x00\x15\x00\x14\x00\x06\x00\x31\x00\x0d\x00\x04\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x02\x00\x01\x00\x17\x00\x0d\x00\x03\x00\x33\x00\x1a\x00\x31\x00\x06\x00\x03\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x31\x00\x14\x00\x17\x00\x0b\x00\x01\x00\x31\x00\x15\x00\x06\x00\x04\x00\x0d\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x10\x00\x31\x00\x17\x00\x04\x00\x33\x00\x00\x00\x01\x00\x02\x00\x05\x00\x01\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x13\x00\x0a\x00\x02\x00\x0d\x00\x01\x00\x17\x00\x10\x00\x11\x00\x09\x00\x31\x00\x05\x00\x02\x00\x02\x00\x17\x00\x02\x00\x02\x00\x33\x00\x19\x00\x33\x00\x0b\x00\x25\x00\x31\x00\x31\x00\x08\x00\x05\x00\x05\x00\x02\x00\x05\x00\x02\x00\x02\x00\x01\x00\x21\x00\x02\x00\x01\x00\x31\x00\x31\x00\x22\x00\x03\x00\x31\x00\x06\x00\x01\x00\x25\x00\x07\x00\x31\x00\x31\x00\x31\x00\x05\x00\x29\x00\x02\x00\x1a\x00\x31\x00\x28\x00\xff\xff\xff\xff\x28\x00\xff\xff\x31\x00\x24\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x31\x00\xff\xff\xff\xff\x35\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x06\x00\x06\x00\x06\x00\x06\x00\x76\x00\x76\x00\x76\x00\x17\x00\x76\x00\x5e\x00\xf8\x00\x0d\x01\xf9\x00\x84\xff\x9c\x00\xeb\x00\xed\x00\x76\x00\x55\x00\x9d\x00\x5f\x00\x03\x00\x12\x01\x9e\x00\x04\x00\x56\x00\x9f\x00\x57\x00\xa0\x00\x7a\xff\x58\x00\x77\x00\x59\x00\x5a\x00\xf8\x00\xbd\x00\xf9\x00\x7b\x00\xbe\x00\x78\x00\x06\x01\x84\xff\x06\x01\x07\x01\x5b\x00\x07\x01\xfa\x00\xed\x00\x5c\x00\x91\x00\xb4\x00\xd3\x00\x18\x00\x22\x00\x15\x00\x07\x00\x15\x01\xa1\x00\x08\x01\xa2\x00\x03\x00\x5d\x00\x5e\x00\x5d\x00\x03\x00\x5d\x00\x5e\x00\x9c\x00\xe7\x00\x03\x00\x14\x01\x03\x00\x9d\x00\x9c\x00\x89\x00\xbc\x00\x9e\x00\x8a\x00\x9d\x00\x9f\x00\xfc\x00\xa0\x00\x9e\x00\x9c\x00\x0b\x01\x9f\x00\xeb\x00\xa0\x00\x9d\x00\xfd\x00\x14\x01\xfe\x00\x9e\x00\xfc\x00\xfc\x00\x9f\x00\x84\xff\xa0\x00\x64\x00\xeb\x00\x08\x00\x09\x00\xfd\x00\xfd\x00\xfe\x00\xfe\x00\x5e\x00\x65\x00\x28\x00\xff\x00\xbd\x00\x76\x00\x5d\x00\x03\x00\x5d\x00\x5e\x00\x2f\x00\x5f\x00\xae\x00\x03\x00\x5d\x00\x5e\x00\x66\x00\x67\x00\x84\xff\xae\x00\x03\x00\xcb\x00\x5e\x00\x03\x00\x5d\x00\x5e\x00\x76\x00\xcc\x00\xeb\x00\xcd\x00\x4b\x00\x77\x00\x29\x00\x03\x00\x03\x00\x5e\x00\x5e\x00\x30\x00\x03\x00\x78\x00\x60\x00\x31\x00\x02\x01\x05\x01\x32\x00\x33\x00\xf4\x00\xaf\x00\x34\x00\x35\x00\x79\x00\xc3\x00\xc4\x00\x36\x00\xaf\x00\x03\x00\xe3\x00\xbd\x00\x4b\x00\xf8\x00\xbe\x00\xf9\x00\xb3\x00\xb0\x00\x03\x00\x5d\x00\x5e\x00\x87\x00\x2c\x00\xbf\x00\x58\x00\x61\x00\x59\x00\x5a\x00\xcc\x00\xf3\x00\xcd\x00\xb2\x00\x2d\x00\x6a\x00\x92\x00\x93\x00\x94\x00\xb3\x00\x5b\x00\x4b\x00\xda\x00\x4b\x00\x5c\x00\x92\x00\x93\x00\x94\x00\xf1\x00\x95\x00\xb3\x00\xfa\x00\xd1\x00\xb3\x00\xce\x00\xac\x00\xe2\x00\x4b\x00\x95\x00\x6c\x00\x03\x00\x5d\x00\x5e\x00\x96\x00\x97\x00\x02\x01\x99\x00\x03\x00\x5d\x00\x5e\x00\x61\x00\x9a\x00\x96\x00\x97\x00\x04\x01\x99\x00\x92\x00\x93\x00\x94\x00\xd8\x00\x9a\x00\xd2\x00\xb5\x00\xa2\x00\x4b\x00\x92\x00\x93\x00\x94\x00\x88\x00\x95\x00\xad\x00\xc6\x00\xc7\x00\xc8\x00\x92\x00\x93\x00\x94\x00\x61\x00\x95\x00\xda\x00\xc3\x00\xc4\x00\x8f\x00\x96\x00\x97\x00\xe4\x00\x99\x00\x95\x00\x88\x00\xb7\x00\xc9\x00\x9a\x00\x96\x00\x97\x00\xee\x00\x99\x00\xf5\x00\x92\x00\x93\x00\x94\x00\x9a\x00\x96\x00\x97\x00\xdf\x00\x99\x00\x4b\x00\x92\x00\x93\x00\x94\x00\x9a\x00\x95\x00\xf6\x00\x0c\x01\xdc\x00\xb8\x00\x92\x00\x93\x00\x94\x00\x61\x00\x95\x00\x88\x00\x74\x00\x7d\x00\x7e\x00\x96\x00\x97\x00\xba\x00\x99\x00\x95\x00\x7f\x00\x90\x00\x83\x00\x9a\x00\x96\x00\x97\x00\x98\x00\x99\x00\x6a\x00\x92\x00\x93\x00\x94\x00\x9a\x00\x96\x00\x97\x00\xa7\x00\x99\x00\x4b\x00\x92\x00\x93\x00\x94\x00\x9a\x00\x95\x00\x84\x00\x3f\x00\x92\x00\x93\x00\x94\x00\x6b\x00\x6d\x00\x61\x00\x95\x00\x6c\x00\x4b\x00\x4b\x00\x42\x00\x96\x00\xde\x00\x95\x00\x99\x00\x37\x00\x4b\x00\x75\x00\x38\x00\x9a\x00\xe5\x00\x61\x00\x61\x00\x99\x00\x4b\x00\x4c\x00\x4d\x00\xd4\x00\x9a\x00\xb9\x00\x99\x00\xe7\x00\x39\x00\x62\x00\x67\x00\x9a\x00\x3a\x00\x4e\x00\x4f\x00\xf3\x00\x51\x00\x52\x00\x4b\x00\x4c\x00\x4d\x00\x03\x01\x3b\x00\x53\x00\x3c\x00\xe7\x00\xe9\x00\x4b\x00\x0b\x00\x3d\x00\x0c\x00\x4e\x00\x4f\x00\xcf\x00\x51\x00\x52\x00\x4b\x00\x4c\x00\x4d\x00\xe8\x00\x80\x00\x53\x00\xf5\x00\x0d\x00\xe9\x00\x0e\x00\x2b\x00\x4b\x00\x25\x00\x4e\x00\x4f\x00\xc4\x00\x51\x00\x52\x00\x4b\x00\x4c\x00\x4d\x00\xf6\x00\xf7\x00\x53\x00\x68\x00\x26\x00\x21\x00\x1b\x00\x1c\x00\x1e\x00\x16\x00\x4e\x00\x4f\x00\xc5\x00\x51\x00\x52\x00\x4b\x00\x4c\x00\x4d\x00\x0e\x00\x0f\x00\x53\x00\x10\x00\x11\x00\x5d\x00\x10\x01\x0f\x01\x11\x01\x03\x00\x4e\x00\x4f\x00\x82\x00\x51\x00\x52\x00\x4b\x00\x4c\x00\x4d\x00\x12\x01\x5e\x00\x53\x00\x89\xff\x0a\x01\x0c\x01\x00\x01\x01\x01\xb3\x00\xb3\x00\x4e\x00\x4f\x00\xa9\x00\x51\x00\x52\x00\x4b\x00\x4c\x00\x4d\x00\x03\x00\xf0\x00\x53\x00\x89\xff\xb3\x00\xc1\x00\xf1\x00\x03\x00\xd1\x00\xd6\x00\x4e\x00\x4f\x00\xaa\x00\x51\x00\x52\x00\x81\x00\x4c\x00\x4d\x00\xd7\x00\xd8\x00\x53\x00\xde\x00\xdc\x00\x5e\x00\xe2\x00\x03\x00\xe1\x00\xb7\x00\x4e\x00\x4f\x00\x82\x00\x51\x00\x52\x00\x4b\x00\x4c\x00\x4d\x00\x03\x00\xc1\x00\x53\x00\xc2\x00\xce\x00\x03\x00\xb3\x00\x8d\x00\x8c\x00\x8e\x00\x4e\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x4b\x00\x4c\x00\x4d\x00\x90\x00\x03\x00\x53\x00\xa4\x00\x5e\x00\x4b\x00\x4c\x00\x4d\x00\xa5\x00\xa6\x00\x4e\x00\x4f\x00\x69\x00\x51\x00\x52\x00\xa7\x00\xa9\x00\xac\x00\x4e\x00\x6f\x00\x53\x00\x85\x00\x52\x00\x70\x00\x03\x00\x71\x00\x72\x00\x73\x00\x53\x00\x74\x00\x7c\x00\x5e\x00\x7d\x00\x5e\x00\x88\x00\x44\x00\x03\x00\x03\x00\x45\x00\x46\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x4b\x00\x3f\x00\x41\x00\x42\x00\x37\x00\x03\x00\x03\x00\x2b\x00\x24\x00\x03\x00\x25\x00\x21\x00\x28\x00\x1e\x00\x03\x00\x03\x00\x03\x00\x1b\x00\x20\x00\x13\x00\x15\x00\x03\x00\x1a\x00\x00\x00\x00\x00\x14\x00\x00\x00\x03\x00\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (1, 135) [
	(1 , happyReduce_1),
	(2 , happyReduce_2),
	(3 , happyReduce_3),
	(4 , happyReduce_4),
	(5 , happyReduce_5),
	(6 , happyReduce_6),
	(7 , happyReduce_7),
	(8 , happyReduce_8),
	(9 , happyReduce_9),
	(10 , happyReduce_10),
	(11 , happyReduce_11),
	(12 , happyReduce_12),
	(13 , happyReduce_13),
	(14 , happyReduce_14),
	(15 , happyReduce_15),
	(16 , happyReduce_16),
	(17 , happyReduce_17),
	(18 , happyReduce_18),
	(19 , happyReduce_19),
	(20 , happyReduce_20),
	(21 , happyReduce_21),
	(22 , happyReduce_22),
	(23 , happyReduce_23),
	(24 , happyReduce_24),
	(25 , happyReduce_25),
	(26 , happyReduce_26),
	(27 , happyReduce_27),
	(28 , happyReduce_28),
	(29 , happyReduce_29),
	(30 , happyReduce_30),
	(31 , happyReduce_31),
	(32 , happyReduce_32),
	(33 , happyReduce_33),
	(34 , happyReduce_34),
	(35 , happyReduce_35),
	(36 , happyReduce_36),
	(37 , happyReduce_37),
	(38 , happyReduce_38),
	(39 , happyReduce_39),
	(40 , happyReduce_40),
	(41 , happyReduce_41),
	(42 , happyReduce_42),
	(43 , happyReduce_43),
	(44 , happyReduce_44),
	(45 , happyReduce_45),
	(46 , happyReduce_46),
	(47 , happyReduce_47),
	(48 , happyReduce_48),
	(49 , happyReduce_49),
	(50 , happyReduce_50),
	(51 , happyReduce_51),
	(52 , happyReduce_52),
	(53 , happyReduce_53),
	(54 , happyReduce_54),
	(55 , happyReduce_55),
	(56 , happyReduce_56),
	(57 , happyReduce_57),
	(58 , happyReduce_58),
	(59 , happyReduce_59),
	(60 , happyReduce_60),
	(61 , happyReduce_61),
	(62 , happyReduce_62),
	(63 , happyReduce_63),
	(64 , happyReduce_64),
	(65 , happyReduce_65),
	(66 , happyReduce_66),
	(67 , happyReduce_67),
	(68 , happyReduce_68),
	(69 , happyReduce_69),
	(70 , happyReduce_70),
	(71 , happyReduce_71),
	(72 , happyReduce_72),
	(73 , happyReduce_73),
	(74 , happyReduce_74),
	(75 , happyReduce_75),
	(76 , happyReduce_76),
	(77 , happyReduce_77),
	(78 , happyReduce_78),
	(79 , happyReduce_79),
	(80 , happyReduce_80),
	(81 , happyReduce_81),
	(82 , happyReduce_82),
	(83 , happyReduce_83),
	(84 , happyReduce_84),
	(85 , happyReduce_85),
	(86 , happyReduce_86),
	(87 , happyReduce_87),
	(88 , happyReduce_88),
	(89 , happyReduce_89),
	(90 , happyReduce_90),
	(91 , happyReduce_91),
	(92 , happyReduce_92),
	(93 , happyReduce_93),
	(94 , happyReduce_94),
	(95 , happyReduce_95),
	(96 , happyReduce_96),
	(97 , happyReduce_97),
	(98 , happyReduce_98),
	(99 , happyReduce_99),
	(100 , happyReduce_100),
	(101 , happyReduce_101),
	(102 , happyReduce_102),
	(103 , happyReduce_103),
	(104 , happyReduce_104),
	(105 , happyReduce_105),
	(106 , happyReduce_106),
	(107 , happyReduce_107),
	(108 , happyReduce_108),
	(109 , happyReduce_109),
	(110 , happyReduce_110),
	(111 , happyReduce_111),
	(112 , happyReduce_112),
	(113 , happyReduce_113),
	(114 , happyReduce_114),
	(115 , happyReduce_115),
	(116 , happyReduce_116),
	(117 , happyReduce_117),
	(118 , happyReduce_118),
	(119 , happyReduce_119),
	(120 , happyReduce_120),
	(121 , happyReduce_121),
	(122 , happyReduce_122),
	(123 , happyReduce_123),
	(124 , happyReduce_124),
	(125 , happyReduce_125),
	(126 , happyReduce_126),
	(127 , happyReduce_127),
	(128 , happyReduce_128),
	(129 , happyReduce_129),
	(130 , happyReduce_130),
	(131 , happyReduce_131),
	(132 , happyReduce_132),
	(133 , happyReduce_133),
	(134 , happyReduce_134),
	(135 , happyReduce_135)
	]

happy_n_terms = 54 :: Int
happy_n_nonterms = 53 :: Int

happyReduce_1 = happySpecReduce_1 0# happyReduction_1
happyReduction_1 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TV happy_var_1)) -> 
	happyIn4
		 (identC happy_var_1 --H
	)}

happyReduce_2 = happySpecReduce_1 1# happyReduction_2
happyReduction_2 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TL happy_var_1)) -> 
	happyIn5
		 (happy_var_1
	)}

happyReduce_3 = happySpecReduce_1 2# happyReduction_3
happyReduction_3 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TI happy_var_1)) -> 
	happyIn6
		 ((read happy_var_1) :: Integer
	)}

happyReduce_4 = happyReduce 6# 3# happyReduction_4
happyReduction_4 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut56 happy_x_2 of { happy_var_2 -> 
	case happyOut4 happy_x_4 of { happy_var_4 -> 
	case happyOut10 happy_x_6 of { happy_var_6 -> 
	happyIn7
		 (MGr happy_var_2 happy_var_4 (reverse happy_var_6)
	) `HappyStk` happyRest}}}

happyReduce_5 = happySpecReduce_1 3# happyReduction_5
happyReduction_5 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn7
		 (Gr (reverse happy_var_1)
	)}

happyReduce_6 = happyReduce 8# 4# happyReduction_6
happyReduction_6 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut11 happy_x_3 of { happy_var_3 -> 
	case happyOut12 happy_x_4 of { happy_var_4 -> 
	case happyOut42 happy_x_6 of { happy_var_6 -> 
	case happyOut43 happy_x_7 of { happy_var_7 -> 
	happyIn8
		 (Mod happy_var_1 happy_var_3 happy_var_4 (reverse happy_var_6) (reverse happy_var_7)
	) `HappyStk` happyRest}}}}}

happyReduce_7 = happySpecReduce_2 5# happyReduction_7
happyReduction_7 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_2 of { happy_var_2 -> 
	happyIn9
		 (MTAbs happy_var_2
	)}

happyReduce_8 = happyReduce 4# 5# happyReduction_8
happyReduction_8 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut4 happy_x_4 of { happy_var_4 -> 
	happyIn9
		 (MTCnc happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_9 = happySpecReduce_2 5# happyReduction_9
happyReduction_9 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_2 of { happy_var_2 -> 
	happyIn9
		 (MTRes happy_var_2
	)}

happyReduce_10 = happyReduce 6# 5# happyReduction_10
happyReduction_10 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut4 happy_x_4 of { happy_var_4 -> 
	case happyOut4 happy_x_6 of { happy_var_6 -> 
	happyIn9
		 (MTTrans happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_11 = happySpecReduce_0 6# happyReduction_11
happyReduction_11  =  happyIn10
		 ([]
	)

happyReduce_12 = happySpecReduce_2 6# happyReduction_12
happyReduction_12 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut8 happy_x_2 of { happy_var_2 -> 
	happyIn10
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_13 = happySpecReduce_2 7# happyReduction_13
happyReduction_13 happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_1 of { happy_var_1 -> 
	happyIn11
		 (Ext happy_var_1
	)}

happyReduce_14 = happySpecReduce_0 7# happyReduction_14
happyReduction_14  =  happyIn11
		 (NoExt
	)

happyReduce_15 = happySpecReduce_3 8# happyReduction_15
happyReduction_15 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_2 of { happy_var_2 -> 
	happyIn12
		 (Opens happy_var_2
	)}

happyReduce_16 = happySpecReduce_0 8# happyReduction_16
happyReduction_16  =  happyIn12
		 (NoOpens
	)

happyReduce_17 = happyReduce 4# 9# happyReduction_17
happyReduction_17 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut4 happy_x_4 of { happy_var_4 -> 
	happyIn13
		 (Flg happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_18 = happyReduce 7# 10# happyReduction_18
happyReduction_18 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut24 happy_x_4 of { happy_var_4 -> 
	case happyOut46 happy_x_7 of { happy_var_7 -> 
	happyIn14
		 (AbsDCat happy_var_2 happy_var_4 (reverse happy_var_7)
	) `HappyStk` happyRest}}}

happyReduce_19 = happyReduce 6# 10# happyReduction_19
happyReduction_19 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut19 happy_x_4 of { happy_var_4 -> 
	case happyOut19 happy_x_6 of { happy_var_6 -> 
	happyIn14
		 (AbsDFun happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_20 = happyReduce 4# 10# happyReduction_20
happyReduction_20 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut19 happy_x_4 of { happy_var_4 -> 
	happyIn14
		 (AbsDTrans happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_21 = happyReduce 4# 10# happyReduction_21
happyReduction_21 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut44 happy_x_4 of { happy_var_4 -> 
	happyIn14
		 (ResDPar happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_22 = happyReduce 6# 10# happyReduction_22
happyReduction_22 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut29 happy_x_4 of { happy_var_4 -> 
	case happyOut33 happy_x_6 of { happy_var_6 -> 
	happyIn14
		 (ResDOper happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_23 = happyReduce 8# 10# happyReduction_23
happyReduction_23 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut29 happy_x_4 of { happy_var_4 -> 
	case happyOut33 happy_x_6 of { happy_var_6 -> 
	case happyOut33 happy_x_8 of { happy_var_8 -> 
	happyIn14
		 (CncDCat happy_var_2 happy_var_4 happy_var_6 happy_var_8
	) `HappyStk` happyRest}}}}

happyReduce_24 = happyReduce 11# 10# happyReduction_24
happyReduction_24 (happy_x_11 `HappyStk`
	happy_x_10 `HappyStk`
	happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut17 happy_x_4 of { happy_var_4 -> 
	case happyOut48 happy_x_7 of { happy_var_7 -> 
	case happyOut33 happy_x_9 of { happy_var_9 -> 
	case happyOut33 happy_x_11 of { happy_var_11 -> 
	happyIn14
		 (CncDFun happy_var_2 happy_var_4 happy_var_7 happy_var_9 happy_var_11
	) `HappyStk` happyRest}}}}}

happyReduce_25 = happyReduce 4# 10# happyReduction_25
happyReduction_25 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut16 happy_x_2 of { happy_var_2 -> 
	case happyOut4 happy_x_4 of { happy_var_4 -> 
	happyIn14
		 (AnyDInd happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_26 = happySpecReduce_2 11# happyReduction_26
happyReduction_26 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut45 happy_x_2 of { happy_var_2 -> 
	happyIn15
		 (ParD happy_var_1 (reverse happy_var_2)
	)}}

happyReduce_27 = happySpecReduce_1 12# happyReduction_27
happyReduction_27 happy_x_1
	 =  happyIn16
		 (Canon
	)

happyReduce_28 = happySpecReduce_0 12# happyReduction_28
happyReduction_28  =  happyIn16
		 (NonCan
	)

happyReduce_29 = happySpecReduce_3 13# happyReduction_29
happyReduction_29 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut4 happy_x_3 of { happy_var_3 -> 
	happyIn17
		 (CIQ happy_var_1 happy_var_3
	)}}

happyReduce_30 = happySpecReduce_2 14# happyReduction_30
happyReduction_30 happy_x_2
	happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_2 of { happy_var_2 -> 
	happyIn18
		 (EApp happy_var_1 happy_var_2
	)}}

happyReduce_31 = happySpecReduce_1 14# happyReduction_31
happyReduction_31 happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	happyIn18
		 (happy_var_1
	)}

happyReduce_32 = happyReduce 7# 15# happyReduction_32
happyReduction_32 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut19 happy_x_4 of { happy_var_4 -> 
	case happyOut19 happy_x_7 of { happy_var_7 -> 
	happyIn19
		 (EProd happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_33 = happyReduce 4# 15# happyReduction_33
happyReduction_33 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_2 of { happy_var_2 -> 
	case happyOut19 happy_x_4 of { happy_var_4 -> 
	happyIn19
		 (EAbs happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_34 = happySpecReduce_3 15# happyReduction_34
happyReduction_34 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_2 of { happy_var_2 -> 
	happyIn19
		 (EEq (reverse happy_var_2)
	)}

happyReduce_35 = happySpecReduce_1 15# happyReduction_35
happyReduction_35 happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	happyIn19
		 (happy_var_1
	)}

happyReduce_36 = happySpecReduce_1 16# happyReduction_36
happyReduction_36 happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 (EAtom happy_var_1
	)}

happyReduce_37 = happySpecReduce_1 16# happyReduction_37
happyReduction_37 happy_x_1
	 =  happyIn20
		 (EData
	)

happyReduce_38 = happySpecReduce_3 16# happyReduction_38
happyReduction_38 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_2 of { happy_var_2 -> 
	happyIn20
		 (happy_var_2
	)}

happyReduce_39 = happySpecReduce_1 17# happyReduction_39
happyReduction_39 happy_x_1
	 =  happyIn21
		 (SType
	)

happyReduce_40 = happySpecReduce_3 18# happyReduction_40
happyReduction_40 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut25 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_3 of { happy_var_3 -> 
	happyIn22
		 (Equ (reverse happy_var_1) happy_var_3
	)}}

happyReduce_41 = happyReduce 4# 19# happyReduction_41
happyReduction_41 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut17 happy_x_2 of { happy_var_2 -> 
	case happyOut25 happy_x_3 of { happy_var_3 -> 
	happyIn23
		 (APC happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_42 = happySpecReduce_1 19# happyReduction_42
happyReduction_42 happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	happyIn23
		 (APV happy_var_1
	)}

happyReduce_43 = happySpecReduce_1 19# happyReduction_43
happyReduction_43 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn23
		 (APS happy_var_1
	)}

happyReduce_44 = happySpecReduce_1 19# happyReduction_44
happyReduction_44 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn23
		 (API happy_var_1
	)}

happyReduce_45 = happySpecReduce_1 19# happyReduction_45
happyReduction_45 happy_x_1
	 =  happyIn23
		 (APW
	)

happyReduce_46 = happySpecReduce_0 20# happyReduction_46
happyReduction_46  =  happyIn24
		 ([]
	)

happyReduce_47 = happySpecReduce_1 20# happyReduction_47
happyReduction_47 happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	happyIn24
		 ((:[]) happy_var_1
	)}

happyReduce_48 = happySpecReduce_3 20# happyReduction_48
happyReduction_48 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	case happyOut24 happy_x_3 of { happy_var_3 -> 
	happyIn24
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_49 = happySpecReduce_0 21# happyReduction_49
happyReduction_49  =  happyIn25
		 ([]
	)

happyReduce_50 = happySpecReduce_2 21# happyReduction_50
happyReduction_50 happy_x_2
	happy_x_1
	 =  case happyOut25 happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_51 = happySpecReduce_0 22# happyReduction_51
happyReduction_51  =  happyIn26
		 ([]
	)

happyReduce_52 = happySpecReduce_3 22# happyReduction_52
happyReduction_52 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_2 of { happy_var_2 -> 
	happyIn26
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_53 = happySpecReduce_1 23# happyReduction_53
happyReduction_53 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 (AC happy_var_1
	)}

happyReduce_54 = happySpecReduce_3 23# happyReduction_54
happyReduction_54 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut17 happy_x_2 of { happy_var_2 -> 
	happyIn27
		 (AD happy_var_2
	)}

happyReduce_55 = happySpecReduce_2 23# happyReduction_55
happyReduction_55 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_2 of { happy_var_2 -> 
	happyIn27
		 (AV happy_var_2
	)}

happyReduce_56 = happySpecReduce_2 23# happyReduction_56
happyReduction_56 happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_2 of { happy_var_2 -> 
	happyIn27
		 (AM happy_var_2
	)}

happyReduce_57 = happySpecReduce_1 23# happyReduction_57
happyReduction_57 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 (AS happy_var_1
	)}

happyReduce_58 = happySpecReduce_1 23# happyReduction_58
happyReduction_58 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 (AI happy_var_1
	)}

happyReduce_59 = happySpecReduce_1 23# happyReduction_59
happyReduction_59 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 (AT happy_var_1
	)}

happyReduce_60 = happySpecReduce_3 24# happyReduction_60
happyReduction_60 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_3 of { happy_var_3 -> 
	happyIn28
		 (Decl happy_var_1 happy_var_3
	)}}

happyReduce_61 = happySpecReduce_3 25# happyReduction_61
happyReduction_61 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut49 happy_x_2 of { happy_var_2 -> 
	happyIn29
		 (RecType happy_var_2
	)}

happyReduce_62 = happyReduce 5# 25# happyReduction_62
happyReduction_62 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut29 happy_x_2 of { happy_var_2 -> 
	case happyOut29 happy_x_4 of { happy_var_4 -> 
	happyIn29
		 (Table happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_63 = happySpecReduce_1 25# happyReduction_63
happyReduction_63 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn29
		 (Cn happy_var_1
	)}

happyReduce_64 = happySpecReduce_1 25# happyReduction_64
happyReduction_64 happy_x_1
	 =  happyIn29
		 (TStr
	)

happyReduce_65 = happySpecReduce_2 25# happyReduction_65
happyReduction_65 happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_2 of { happy_var_2 -> 
	happyIn29
		 (TInts happy_var_2
	)}

happyReduce_66 = happySpecReduce_3 26# happyReduction_66
happyReduction_66 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	case happyOut29 happy_x_3 of { happy_var_3 -> 
	happyIn30
		 (Lbg happy_var_1 happy_var_3
	)}}

happyReduce_67 = happySpecReduce_1 27# happyReduction_67
happyReduction_67 happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	happyIn31
		 (Arg happy_var_1
	)}

happyReduce_68 = happySpecReduce_1 27# happyReduction_68
happyReduction_68 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn31
		 (I happy_var_1
	)}

happyReduce_69 = happyReduce 4# 27# happyReduction_69
happyReduction_69 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut17 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn31
		 (Con happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_70 = happySpecReduce_2 27# happyReduction_70
happyReduction_70 happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_2 of { happy_var_2 -> 
	happyIn31
		 (LI happy_var_2
	)}

happyReduce_71 = happySpecReduce_3 27# happyReduction_71
happyReduction_71 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut47 happy_x_2 of { happy_var_2 -> 
	happyIn31
		 (R happy_var_2
	)}

happyReduce_72 = happySpecReduce_1 27# happyReduction_72
happyReduction_72 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn31
		 (EInt happy_var_1
	)}

happyReduce_73 = happySpecReduce_1 27# happyReduction_73
happyReduction_73 happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	happyIn31
		 (K happy_var_1
	)}

happyReduce_74 = happySpecReduce_2 27# happyReduction_74
happyReduction_74 happy_x_2
	happy_x_1
	 =  happyIn31
		 (E
	)

happyReduce_75 = happySpecReduce_3 27# happyReduction_75
happyReduction_75 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_2 of { happy_var_2 -> 
	happyIn31
		 (happy_var_2
	)}

happyReduce_76 = happySpecReduce_3 28# happyReduction_76
happyReduction_76 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 (P happy_var_1 happy_var_3
	)}}

happyReduce_77 = happyReduce 5# 28# happyReduction_77
happyReduction_77 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut29 happy_x_2 of { happy_var_2 -> 
	case happyOut50 happy_x_4 of { happy_var_4 -> 
	happyIn32
		 (T happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_78 = happySpecReduce_3 28# happyReduction_78
happyReduction_78 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 (S happy_var_1 happy_var_3
	)}}

happyReduce_79 = happyReduce 4# 28# happyReduction_79
happyReduction_79 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 (FV (reverse happy_var_3)
	) `HappyStk` happyRest}

happyReduce_80 = happySpecReduce_1 28# happyReduction_80
happyReduction_80 happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	happyIn32
		 (happy_var_1
	)}

happyReduce_81 = happySpecReduce_3 29# happyReduction_81
happyReduction_81 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (C happy_var_1 happy_var_3
	)}}

happyReduce_82 = happySpecReduce_1 29# happyReduction_82
happyReduction_82 happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (happy_var_1
	)}

happyReduce_83 = happySpecReduce_1 30# happyReduction_83
happyReduction_83 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (KS happy_var_1
	)}

happyReduce_84 = happyReduce 7# 30# happyReduction_84
happyReduction_84 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut52 happy_x_3 of { happy_var_3 -> 
	case happyOut53 happy_x_5 of { happy_var_5 -> 
	happyIn34
		 (KP (reverse happy_var_3) happy_var_5
	) `HappyStk` happyRest}}

happyReduce_85 = happySpecReduce_3 31# happyReduction_85
happyReduction_85 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	case happyOut33 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (Ass happy_var_1 happy_var_3
	)}}

happyReduce_86 = happySpecReduce_3 32# happyReduction_86
happyReduction_86 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut33 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 (Cas (reverse happy_var_1) happy_var_3
	)}}

happyReduce_87 = happySpecReduce_3 33# happyReduction_87
happyReduction_87 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut52 happy_x_3 of { happy_var_3 -> 
	happyIn37
		 (Var (reverse happy_var_1) (reverse happy_var_3)
	)}}

happyReduce_88 = happySpecReduce_1 34# happyReduction_88
happyReduction_88 happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	happyIn38
		 (L happy_var_1
	)}

happyReduce_89 = happySpecReduce_2 34# happyReduction_89
happyReduction_89 happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_2 of { happy_var_2 -> 
	happyIn38
		 (LV happy_var_2
	)}

happyReduce_90 = happySpecReduce_3 35# happyReduction_90
happyReduction_90 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	happyIn39
		 (A happy_var_1 happy_var_3
	)}}

happyReduce_91 = happyReduce 5# 35# happyReduction_91
happyReduction_91 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_3 of { happy_var_3 -> 
	case happyOut6 happy_x_5 of { happy_var_5 -> 
	happyIn39
		 (AB happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_92 = happyReduce 4# 36# happyReduction_92
happyReduction_92 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut17 happy_x_2 of { happy_var_2 -> 
	case happyOut55 happy_x_3 of { happy_var_3 -> 
	happyIn40
		 (PC happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_93 = happySpecReduce_1 36# happyReduction_93
happyReduction_93 happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	happyIn40
		 (PV happy_var_1
	)}

happyReduce_94 = happySpecReduce_1 36# happyReduction_94
happyReduction_94 happy_x_1
	 =  happyIn40
		 (PW
	)

happyReduce_95 = happySpecReduce_3 36# happyReduction_95
happyReduction_95 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_2 of { happy_var_2 -> 
	happyIn40
		 (PR happy_var_2
	)}

happyReduce_96 = happySpecReduce_1 36# happyReduction_96
happyReduction_96 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn40
		 (PI happy_var_1
	)}

happyReduce_97 = happySpecReduce_3 37# happyReduction_97
happyReduction_97 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	case happyOut40 happy_x_3 of { happy_var_3 -> 
	happyIn41
		 (PAss happy_var_1 happy_var_3
	)}}

happyReduce_98 = happySpecReduce_0 38# happyReduction_98
happyReduction_98  =  happyIn42
		 ([]
	)

happyReduce_99 = happySpecReduce_3 38# happyReduction_99
happyReduction_99 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut42 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_2 of { happy_var_2 -> 
	happyIn42
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_100 = happySpecReduce_0 39# happyReduction_100
happyReduction_100  =  happyIn43
		 ([]
	)

happyReduce_101 = happySpecReduce_3 39# happyReduction_101
happyReduction_101 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut43 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_2 of { happy_var_2 -> 
	happyIn43
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_102 = happySpecReduce_0 40# happyReduction_102
happyReduction_102  =  happyIn44
		 ([]
	)

happyReduce_103 = happySpecReduce_1 40# happyReduction_103
happyReduction_103 happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 ((:[]) happy_var_1
	)}

happyReduce_104 = happySpecReduce_3 40# happyReduction_104
happyReduction_104 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_3 of { happy_var_3 -> 
	happyIn44
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_105 = happySpecReduce_0 41# happyReduction_105
happyReduction_105  =  happyIn45
		 ([]
	)

happyReduce_106 = happySpecReduce_2 41# happyReduction_106
happyReduction_106 happy_x_2
	happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	case happyOut29 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_107 = happySpecReduce_0 42# happyReduction_107
happyReduction_107  =  happyIn46
		 ([]
	)

happyReduce_108 = happySpecReduce_2 42# happyReduction_108
happyReduction_108 happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	case happyOut17 happy_x_2 of { happy_var_2 -> 
	happyIn46
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_109 = happySpecReduce_0 43# happyReduction_109
happyReduction_109  =  happyIn47
		 ([]
	)

happyReduce_110 = happySpecReduce_1 43# happyReduction_110
happyReduction_110 happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	happyIn47
		 ((:[]) happy_var_1
	)}

happyReduce_111 = happySpecReduce_3 43# happyReduction_111
happyReduction_111 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_3 of { happy_var_3 -> 
	happyIn47
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_112 = happySpecReduce_0 44# happyReduction_112
happyReduction_112  =  happyIn48
		 ([]
	)

happyReduce_113 = happySpecReduce_1 44# happyReduction_113
happyReduction_113 happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	happyIn48
		 ((:[]) happy_var_1
	)}

happyReduce_114 = happySpecReduce_3 44# happyReduction_114
happyReduction_114 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_3 of { happy_var_3 -> 
	happyIn48
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_115 = happySpecReduce_0 45# happyReduction_115
happyReduction_115  =  happyIn49
		 ([]
	)

happyReduce_116 = happySpecReduce_1 45# happyReduction_116
happyReduction_116 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn49
		 ((:[]) happy_var_1
	)}

happyReduce_117 = happySpecReduce_3 45# happyReduction_117
happyReduction_117 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut49 happy_x_3 of { happy_var_3 -> 
	happyIn49
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_118 = happySpecReduce_0 46# happyReduction_118
happyReduction_118  =  happyIn50
		 ([]
	)

happyReduce_119 = happySpecReduce_1 46# happyReduction_119
happyReduction_119 happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	happyIn50
		 ((:[]) happy_var_1
	)}

happyReduce_120 = happySpecReduce_3 46# happyReduction_120
happyReduction_120 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn50
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_121 = happySpecReduce_0 47# happyReduction_121
happyReduction_121  =  happyIn51
		 ([]
	)

happyReduce_122 = happySpecReduce_2 47# happyReduction_122
happyReduction_122 happy_x_2
	happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_2 of { happy_var_2 -> 
	happyIn51
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_123 = happySpecReduce_0 48# happyReduction_123
happyReduction_123  =  happyIn52
		 ([]
	)

happyReduce_124 = happySpecReduce_2 48# happyReduction_124
happyReduction_124 happy_x_2
	happy_x_1
	 =  case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn52
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_125 = happySpecReduce_0 49# happyReduction_125
happyReduction_125  =  happyIn53
		 ([]
	)

happyReduce_126 = happySpecReduce_1 49# happyReduction_126
happyReduction_126 happy_x_1
	 =  case happyOut37 happy_x_1 of { happy_var_1 -> 
	happyIn53
		 ((:[]) happy_var_1
	)}

happyReduce_127 = happySpecReduce_3 49# happyReduction_127
happyReduction_127 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut37 happy_x_1 of { happy_var_1 -> 
	case happyOut53 happy_x_3 of { happy_var_3 -> 
	happyIn53
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_128 = happySpecReduce_0 50# happyReduction_128
happyReduction_128  =  happyIn54
		 ([]
	)

happyReduce_129 = happySpecReduce_1 50# happyReduction_129
happyReduction_129 happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	happyIn54
		 ((:[]) happy_var_1
	)}

happyReduce_130 = happySpecReduce_3 50# happyReduction_130
happyReduction_130 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut54 happy_x_3 of { happy_var_3 -> 
	happyIn54
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_131 = happySpecReduce_0 51# happyReduction_131
happyReduction_131  =  happyIn55
		 ([]
	)

happyReduce_132 = happySpecReduce_2 51# happyReduction_132
happyReduction_132 happy_x_2
	happy_x_1
	 =  case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut40 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_133 = happySpecReduce_0 52# happyReduction_133
happyReduction_133  =  happyIn56
		 ([]
	)

happyReduce_134 = happySpecReduce_1 52# happyReduction_134
happyReduction_134 happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	happyIn56
		 ((:[]) happy_var_1
	)}

happyReduce_135 = happySpecReduce_3 52# happyReduction_135
happyReduction_135 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut4 happy_x_1 of { happy_var_1 -> 
	case happyOut56 happy_x_3 of { happy_var_3 -> 
	happyIn56
		 ((:) happy_var_1 happy_var_3
	)}}

happyNewToken action sts stk [] =
	happyDoAction 53# (error "reading EOF!") action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	PT _ (TS ";") -> cont 1#;
	PT _ (TS "=") -> cont 2#;
	PT _ (TS "{") -> cont 3#;
	PT _ (TS "}") -> cont 4#;
	PT _ (TS ":") -> cont 5#;
	PT _ (TS "->") -> cont 6#;
	PT _ (TS "**") -> cont 7#;
	PT _ (TS "[") -> cont 8#;
	PT _ (TS "]") -> cont 9#;
	PT _ (TS "\\") -> cont 10#;
	PT _ (TS ".") -> cont 11#;
	PT _ (TS "(") -> cont 12#;
	PT _ (TS ")") -> cont 13#;
	PT _ (TS "_") -> cont 14#;
	PT _ (TS "<") -> cont 15#;
	PT _ (TS ">") -> cont 16#;
	PT _ (TS "$") -> cont 17#;
	PT _ (TS "?") -> cont 18#;
	PT _ (TS "=>") -> cont 19#;
	PT _ (TS "!") -> cont 20#;
	PT _ (TS "++") -> cont 21#;
	PT _ (TS "/") -> cont 22#;
	PT _ (TS "@") -> cont 23#;
	PT _ (TS "+") -> cont 24#;
	PT _ (TS "|") -> cont 25#;
	PT _ (TS ",") -> cont 26#;
	PT _ (TS "Ints") -> cont 27#;
	PT _ (TS "Str") -> cont 28#;
	PT _ (TS "Type") -> cont 29#;
	PT _ (TS "abstract") -> cont 30#;
	PT _ (TS "cat") -> cont 31#;
	PT _ (TS "concrete") -> cont 32#;
	PT _ (TS "data") -> cont 33#;
	PT _ (TS "flags") -> cont 34#;
	PT _ (TS "fun") -> cont 35#;
	PT _ (TS "grammar") -> cont 36#;
	PT _ (TS "in") -> cont 37#;
	PT _ (TS "lin") -> cont 38#;
	PT _ (TS "lincat") -> cont 39#;
	PT _ (TS "of") -> cont 40#;
	PT _ (TS "open") -> cont 41#;
	PT _ (TS "oper") -> cont 42#;
	PT _ (TS "param") -> cont 43#;
	PT _ (TS "pre") -> cont 44#;
	PT _ (TS "resource") -> cont 45#;
	PT _ (TS "table") -> cont 46#;
	PT _ (TS "transfer") -> cont 47#;
	PT _ (TS "variants") -> cont 48#;
	PT _ (TV happy_dollar_dollar) -> cont 49#;
	PT _ (TL happy_dollar_dollar) -> cont 50#;
	PT _ (TI happy_dollar_dollar) -> cont 51#;
	_ -> cont 52#;
	_ -> happyError tks
	}

happyThen :: Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 = \a tks -> (returnM) a

pCanon tks = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut7 x))

happySeq = happyDontSeq

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ if null ts then [] else (" before " ++ unwords (map prToken (take 4 ts)))

myLexer = tokens
{-# LINE 1 "GenericTemplate.hs" #-}
-- $Id: ParGFC.hs,v 1.4 2004/09/23 15:41:45 aarne Exp $













{-# LINE 27 "GenericTemplate.hs" #-}



data Happy_IntList = HappyCons Int# Happy_IntList






































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

happyAccept j tk st sts (HappyStk ans _) = (happyTcHack j 
				                  (happyTcHack st))
					   (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action



happyDoAction i tk st
	= {- nothing -}


	  case action of
		0#		  -> {- nothing -}
				     happyFail i tk st
		-1# 	  -> {- nothing -}
				     happyAccept i tk st
		n | (n <# (0# :: Int#)) -> {- nothing -}

				     (happyReduceArr ! rule) i tk st
				     where rule = (I# ((negateInt# ((n +# (1# :: Int#))))))
		n		  -> {- nothing -}


				     happyShift new_state i tk st
				     where new_state = (n -# (1# :: Int#))
   where off    = indexShortOffAddr happyActOffsets st
	 off_i  = (off +# i)
	 check  = if (off_i >=# (0# :: Int#))
			then (indexShortOffAddr happyCheck off_i ==#  i)
			else False
 	 action | check     = indexShortOffAddr happyTable off_i
		| otherwise = indexShortOffAddr happyDefActions st











indexShortOffAddr (HappyA# arr) off =
#if __GLASGOW_HASKELL__ > 500
	narrow16Int# i
#elif __GLASGOW_HASKELL__ == 500
	intToInt16# i
#else
	(i `iShiftL#` 16#) `iShiftRA#` 16#
#endif
  where
#if __GLASGOW_HASKELL__ >= 503
	i = word2Int# ((high `uncheckedShiftL#` 8#) `or#` low)
#else
	i = word2Int# ((high `shiftL#` 8#) `or#` low)
#endif
	high = int2Word# (ord# (indexCharOffAddr# arr (off' +# 1#)))
	low  = int2Word# (ord# (indexCharOffAddr# arr off'))
	off' = off *# 2#





data HappyAddr = HappyA# Addr#




-----------------------------------------------------------------------------
-- HappyState data type (not arrays)

{-# LINE 165 "GenericTemplate.hs" #-}


-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state 0# tk st sts stk@(x `HappyStk` _) =
     let i = (case unsafeCoerce# x of { (I# (i)) -> i }) in
--     trace "shifting the error token" $
     happyDoAction i tk new_state (HappyCons (st) (sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state (HappyCons (st) (sts)) ((happyInTok (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_0 nt fn j tk st@((action)) sts stk
     = happyGoto nt j tk st (HappyCons (st) (sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@((HappyCons (st@(action)) (_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_2 nt fn j tk _ (HappyCons (_) (sts@((HappyCons (st@(action)) (_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happySpecReduce_3 nt fn j tk _ (HappyCons (_) ((HappyCons (_) (sts@((HappyCons (st@(action)) (_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (happyGoto nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k -# (1# :: Int#)) sts of
	 sts1@((HappyCons (st1@(action)) (_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (happyGoto nt j tk st1 sts1 r)

happyMonadReduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@((HappyCons (st1@(action)) (_))) = happyDrop k (HappyCons (st) (sts))
             drop_stk = happyDropStk k stk

happyDrop 0# l = l
happyDrop n (HappyCons (_) (t)) = happyDrop (n -# (1# :: Int#)) t

happyDropStk 0# l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n -# (1#::Int#)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction


happyGoto nt j tk st = 
   {- nothing -}
   happyDoAction j tk new_state
   where off    = indexShortOffAddr happyGotoOffsets st
	 off_i  = (off +# nt)
 	 new_state = indexShortOffAddr happyTable off_i




-----------------------------------------------------------------------------
-- Error recovery (0# is the error token)

-- parse error if we are in recovery and we fail again
happyFail  0# tk old_st _ stk =
--	trace "failing" $ 
    	happyError


{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  0# tk old_st (HappyCons ((action)) (sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	happyDoAction 0# tk action sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (action) sts stk =
--      trace "entering error recovery" $
	happyDoAction 0# tk action sts ( (unsafeCoerce# (I# (i))) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions


happyTcHack :: Int# -> a -> a
happyTcHack x y = y
{-# INLINE happyTcHack #-}


-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.


{-# NOINLINE happyDoAction #-}
{-# NOINLINE happyTable #-}
{-# NOINLINE happyCheck #-}
{-# NOINLINE happyActOffsets #-}
{-# NOINLINE happyGotoOffsets #-}
{-# NOINLINE happyDefActions #-}

{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
