{-# OPTIONS -fglasgow-exts -cpp #-}
module GF.Canon.ParGFC where
import GF.Canon.AbsGFC
import GF.Canon.LexGFC
import GF.Data.ErrM -- H
import GF.Infra.Ident -- H
import Array
#if __GLASGOW_HASKELL__ >= 503
import GHC.Exts
#else
import GlaExts
#endif

-- parser produced by Happy Version 1.15

newtype HappyAbsSyn  = HappyAbsSyn (() -> ())
happyIn5 :: (Ident) -> (HappyAbsSyn )
happyIn5 x = unsafeCoerce# x
{-# INLINE happyIn5 #-}
happyOut5 :: (HappyAbsSyn ) -> (Ident)
happyOut5 x = unsafeCoerce# x
{-# INLINE happyOut5 #-}
happyIn6 :: (String) -> (HappyAbsSyn )
happyIn6 x = unsafeCoerce# x
{-# INLINE happyIn6 #-}
happyOut6 :: (HappyAbsSyn ) -> (String)
happyOut6 x = unsafeCoerce# x
{-# INLINE happyOut6 #-}
happyIn7 :: (Integer) -> (HappyAbsSyn )
happyIn7 x = unsafeCoerce# x
{-# INLINE happyIn7 #-}
happyOut7 :: (HappyAbsSyn ) -> (Integer)
happyOut7 x = unsafeCoerce# x
{-# INLINE happyOut7 #-}
happyIn8 :: (Canon) -> (HappyAbsSyn )
happyIn8 x = unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn ) -> (Canon)
happyOut8 x = unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (Line) -> (HappyAbsSyn )
happyIn9 x = unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> (Line)
happyOut9 x = unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: (Module) -> (HappyAbsSyn )
happyIn10 x = unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> (Module)
happyOut10 x = unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: (ModType) -> (HappyAbsSyn )
happyIn11 x = unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> (ModType)
happyOut11 x = unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: ([Module]) -> (HappyAbsSyn )
happyIn12 x = unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> ([Module])
happyOut12 x = unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: (Extend) -> (HappyAbsSyn )
happyIn13 x = unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn ) -> (Extend)
happyOut13 x = unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: (Open) -> (HappyAbsSyn )
happyIn14 x = unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> (Open)
happyOut14 x = unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: (Flag) -> (HappyAbsSyn )
happyIn15 x = unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> (Flag)
happyOut15 x = unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (Def) -> (HappyAbsSyn )
happyIn16 x = unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> (Def)
happyOut16 x = unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: (ParDef) -> (HappyAbsSyn )
happyIn17 x = unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> (ParDef)
happyOut17 x = unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: (Status) -> (HappyAbsSyn )
happyIn18 x = unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> (Status)
happyOut18 x = unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: (CIdent) -> (HappyAbsSyn )
happyIn19 x = unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> (CIdent)
happyOut19 x = unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: (Exp) -> (HappyAbsSyn )
happyIn20 x = unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> (Exp)
happyOut20 x = unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: (Exp) -> (HappyAbsSyn )
happyIn21 x = unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> (Exp)
happyOut21 x = unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyIn22 :: (Exp) -> (HappyAbsSyn )
happyIn22 x = unsafeCoerce# x
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn ) -> (Exp)
happyOut22 x = unsafeCoerce# x
{-# INLINE happyOut22 #-}
happyIn23 :: (Sort) -> (HappyAbsSyn )
happyIn23 x = unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> (Sort)
happyOut23 x = unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: (Equation) -> (HappyAbsSyn )
happyIn24 x = unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> (Equation)
happyOut24 x = unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: (APatt) -> (HappyAbsSyn )
happyIn25 x = unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> (APatt)
happyOut25 x = unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: ([Decl]) -> (HappyAbsSyn )
happyIn26 x = unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> ([Decl])
happyOut26 x = unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: ([APatt]) -> (HappyAbsSyn )
happyIn27 x = unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> ([APatt])
happyOut27 x = unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: ([Equation]) -> (HappyAbsSyn )
happyIn28 x = unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> ([Equation])
happyOut28 x = unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: (Atom) -> (HappyAbsSyn )
happyIn29 x = unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> (Atom)
happyOut29 x = unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: (Decl) -> (HappyAbsSyn )
happyIn30 x = unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> (Decl)
happyOut30 x = unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: (CType) -> (HappyAbsSyn )
happyIn31 x = unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> (CType)
happyOut31 x = unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: (Labelling) -> (HappyAbsSyn )
happyIn32 x = unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> (Labelling)
happyOut32 x = unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (Term) -> (HappyAbsSyn )
happyIn33 x = unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (Term)
happyOut33 x = unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyIn34 :: (Term) -> (HappyAbsSyn )
happyIn34 x = unsafeCoerce# x
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> (Term)
happyOut34 x = unsafeCoerce# x
{-# INLINE happyOut34 #-}
happyIn35 :: (Term) -> (HappyAbsSyn )
happyIn35 x = unsafeCoerce# x
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> (Term)
happyOut35 x = unsafeCoerce# x
{-# INLINE happyOut35 #-}
happyIn36 :: (Tokn) -> (HappyAbsSyn )
happyIn36 x = unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> (Tokn)
happyOut36 x = unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: (Assign) -> (HappyAbsSyn )
happyIn37 x = unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> (Assign)
happyOut37 x = unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: (Case) -> (HappyAbsSyn )
happyIn38 x = unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> (Case)
happyOut38 x = unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: (Variant) -> (HappyAbsSyn )
happyIn39 x = unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> (Variant)
happyOut39 x = unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: (Label) -> (HappyAbsSyn )
happyIn40 x = unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> (Label)
happyOut40 x = unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyIn41 :: (ArgVar) -> (HappyAbsSyn )
happyIn41 x = unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> (ArgVar)
happyOut41 x = unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: (Patt) -> (HappyAbsSyn )
happyIn42 x = unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> (Patt)
happyOut42 x = unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyIn43 :: (PattAssign) -> (HappyAbsSyn )
happyIn43 x = unsafeCoerce# x
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> (PattAssign)
happyOut43 x = unsafeCoerce# x
{-# INLINE happyOut43 #-}
happyIn44 :: ([Flag]) -> (HappyAbsSyn )
happyIn44 x = unsafeCoerce# x
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> ([Flag])
happyOut44 x = unsafeCoerce# x
{-# INLINE happyOut44 #-}
happyIn45 :: ([Def]) -> (HappyAbsSyn )
happyIn45 x = unsafeCoerce# x
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> ([Def])
happyOut45 x = unsafeCoerce# x
{-# INLINE happyOut45 #-}
happyIn46 :: ([ParDef]) -> (HappyAbsSyn )
happyIn46 x = unsafeCoerce# x
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> ([ParDef])
happyOut46 x = unsafeCoerce# x
{-# INLINE happyOut46 #-}
happyIn47 :: ([CType]) -> (HappyAbsSyn )
happyIn47 x = unsafeCoerce# x
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn ) -> ([CType])
happyOut47 x = unsafeCoerce# x
{-# INLINE happyOut47 #-}
happyIn48 :: ([CIdent]) -> (HappyAbsSyn )
happyIn48 x = unsafeCoerce# x
{-# INLINE happyIn48 #-}
happyOut48 :: (HappyAbsSyn ) -> ([CIdent])
happyOut48 x = unsafeCoerce# x
{-# INLINE happyOut48 #-}
happyIn49 :: ([Assign]) -> (HappyAbsSyn )
happyIn49 x = unsafeCoerce# x
{-# INLINE happyIn49 #-}
happyOut49 :: (HappyAbsSyn ) -> ([Assign])
happyOut49 x = unsafeCoerce# x
{-# INLINE happyOut49 #-}
happyIn50 :: ([ArgVar]) -> (HappyAbsSyn )
happyIn50 x = unsafeCoerce# x
{-# INLINE happyIn50 #-}
happyOut50 :: (HappyAbsSyn ) -> ([ArgVar])
happyOut50 x = unsafeCoerce# x
{-# INLINE happyOut50 #-}
happyIn51 :: ([Labelling]) -> (HappyAbsSyn )
happyIn51 x = unsafeCoerce# x
{-# INLINE happyIn51 #-}
happyOut51 :: (HappyAbsSyn ) -> ([Labelling])
happyOut51 x = unsafeCoerce# x
{-# INLINE happyOut51 #-}
happyIn52 :: ([Case]) -> (HappyAbsSyn )
happyIn52 x = unsafeCoerce# x
{-# INLINE happyIn52 #-}
happyOut52 :: (HappyAbsSyn ) -> ([Case])
happyOut52 x = unsafeCoerce# x
{-# INLINE happyOut52 #-}
happyIn53 :: ([Term]) -> (HappyAbsSyn )
happyIn53 x = unsafeCoerce# x
{-# INLINE happyIn53 #-}
happyOut53 :: (HappyAbsSyn ) -> ([Term])
happyOut53 x = unsafeCoerce# x
{-# INLINE happyOut53 #-}
happyIn54 :: ([String]) -> (HappyAbsSyn )
happyIn54 x = unsafeCoerce# x
{-# INLINE happyIn54 #-}
happyOut54 :: (HappyAbsSyn ) -> ([String])
happyOut54 x = unsafeCoerce# x
{-# INLINE happyOut54 #-}
happyIn55 :: ([Variant]) -> (HappyAbsSyn )
happyIn55 x = unsafeCoerce# x
{-# INLINE happyIn55 #-}
happyOut55 :: (HappyAbsSyn ) -> ([Variant])
happyOut55 x = unsafeCoerce# x
{-# INLINE happyOut55 #-}
happyIn56 :: ([PattAssign]) -> (HappyAbsSyn )
happyIn56 x = unsafeCoerce# x
{-# INLINE happyIn56 #-}
happyOut56 :: (HappyAbsSyn ) -> ([PattAssign])
happyOut56 x = unsafeCoerce# x
{-# INLINE happyOut56 #-}
happyIn57 :: ([Patt]) -> (HappyAbsSyn )
happyIn57 x = unsafeCoerce# x
{-# INLINE happyIn57 #-}
happyOut57 :: (HappyAbsSyn ) -> ([Patt])
happyOut57 x = unsafeCoerce# x
{-# INLINE happyOut57 #-}
happyIn58 :: ([Ident]) -> (HappyAbsSyn )
happyIn58 x = unsafeCoerce# x
{-# INLINE happyIn58 #-}
happyOut58 :: (HappyAbsSyn ) -> ([Ident])
happyOut58 x = unsafeCoerce# x
{-# INLINE happyOut58 #-}
happyInTok :: Token -> (HappyAbsSyn )
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x5b\x02\x83\x00\x55\x02\x00\x00\x53\x02\x4d\x02\x70\x02\x6e\x02\x6b\x02\x00\x00\x49\x02\x49\x02\x49\x02\x49\x02\x49\x02\x49\x02\x49\x02\x49\x02\x49\x02\x49\x02\x49\x02\x49\x02\x46\x02\x8a\x01\x42\x02\x54\x02\x45\x02\x00\x00\x69\x02\x40\x02\xe4\x00\x00\x00\x67\x02\x65\x02\x64\x02\x63\x02\x3f\x02\x60\x02\x61\x02\x39\x02\x5a\x02\x00\x00\x00\x00\x00\x00\x1d\x00\x3a\x02\x00\x00\x33\x02\x35\x02\x59\x02\x2c\x02\x2c\x02\x2c\x02\x0f\x00\x2c\x02\x2c\x02\x67\x00\x67\x00\x2c\x02\x0f\x00\x2c\x02\x57\x02\x1d\x00\x29\x02\x29\x02\x00\x00\x58\x02\x32\x02\x51\x02\x4b\x02\x00\x00\x00\x00\x00\x00\xcb\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1f\x02\x0f\x00\x1f\x02\x1f\x02\x25\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3c\x02\x00\x00\x00\x00\x52\x02\xf6\xff\x67\x00\x20\x02\x00\x00\x50\x02\x4f\x02\x4e\x02\x4c\x02\x00\x00\x00\x00\x48\x02\x43\x02\x4a\x02\x00\x00\x47\x02\x18\x02\x00\x00\x23\x02\x00\x00\x16\x02\x44\x02\x0f\x00\x0f\x00\x00\x00\x3b\x02\x17\x00\x00\x00\x31\x02\x00\x00\x41\x02\x3e\x02\x3d\x02\x0d\x02\x17\x00\x0e\x02\x67\x00\x00\x00\x00\x00\x2e\x02\x12\x00\x30\x02\x36\x02\x37\x02\x00\x00\x0f\x00\x07\x02\x07\x02\x34\x02\x00\x00\x8a\x01\x00\x00\x00\x00\x00\x00\x27\x02\x8d\x00\x00\x00\x0f\x00\x00\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x49\x01\x00\x00\x00\x00\x00\x00\x26\x02\x22\x02\x1d\x02\x00\x00\x00\x00\xf6\xff\x4e\x00\x17\x00\xff\x01\xff\x01\x67\x00\x24\x02\x00\x00\x00\x00\x67\x00\xf6\xff\x67\x00\xc6\x00\xf5\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf5\x01\xf7\x00\x0b\x02\x1e\x02\x17\x00\x17\x00\x13\x02\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x07\x00\x00\x00\x00\x00\x14\x02\x12\x02\x03\x02\x5d\x00\xf6\xff\xd5\x01\xd5\x01\xf7\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0f\x00\xd4\x01\x00\x00\x00\x00\xe4\x01\xf6\x01\x92\x00\x00\x00\x00\x00\xfc\x01\xea\x01\x00\x00\x00\x00\x00\x00\x00\x00\x17\x00\xf6\xff\x0a\x00\x00\x00\x53\x00\xf1\x01\x00\x00\x4d\x00\x00\x00\xe2\x01\xde\x01\x17\x00\xc3\x01\x00\x00\x00\x00\x14\x00\x00\x00\x00\x00\x43\x00\xe9\x01\xe3\x01\x5a\x00\x00\x00\x00\x00\x72\x00\x00\x00\xd3\x01\xb6\x01\x0f\x00\xbc\x00\xe5\x01\x00\x00\xb3\x01\x00\x00\xe1\x01\x00\x00\x00\x00\x00\x00\x00\x00\xd8\x01\x4b\x00\xd2\x01\x00\x00\x00\x00\x00\x00\xf6\xff\x9b\x01\x00\x00\x17\x00\x00\x00\xd1\x01\x00\x00\x17\x00\xb5\x01\x00\x00\xb5\x01\x00\x00\xc9\x01\xc8\x01\xb4\x01\xbd\x01\x00\x00\xfb\xff\x00\x00\x93\x01\x00\x00\x00\x00\xf6\xff\x64\x00\x27\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x75\x00\x2f\x02\x00\x00\x00\x00\x7c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xae\x01\xad\x01\xac\x01\xa7\x01\x9c\x01\x06\x00\x9a\x01\x94\x01\x8c\x01\x87\x01\x86\x01\x85\x01\x00\x00\xdf\x00\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x83\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x80\x01\x60\x01\x00\x00\xf2\x00\x6b\x01\x63\x01\x1c\x02\x62\x01\x34\x01\x81\x01\x7d\x01\xab\x00\x09\x02\x5d\x01\x00\x00\x01\x00\x57\x01\x04\x00\x00\x00\x00\x00\x38\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x11\x02\x00\x00\x00\x00\x00\x00\x00\x00\x41\x01\x40\x01\xfe\x01\x2b\x01\x3a\x01\x36\x01\x00\x00\x00\x00\x00\x00\x00\x00\x0d\x01\x00\x00\x00\x00\x00\x00\x00\x00\x71\x00\x74\x01\x33\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\xe2\x00\x00\x00\xeb\x01\xe0\x01\x00\x00\x00\x00\x51\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2e\x01\x48\x01\x9c\x00\x6a\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbf\x00\x00\x00\xcd\x01\x2f\x01\x19\x01\x00\x00\x10\x01\xdf\x00\xee\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x00\x00\xc2\x01\x00\x00\xaf\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb3\x00\x00\x00\x31\x01\x0c\x01\xf1\x00\x14\x01\x00\x00\x00\x00\x00\x00\xeb\x00\x6f\x00\xea\x00\x00\x00\xa0\x00\x00\x00\x00\x00\xcf\x00\x00\x00\x00\x00\xd9\x00\x00\x00\x00\x00\x00\x00\x28\x01\x5a\x01\x00\x00\x00\x00\x00\x00\xc0\x00\x00\x00\x00\x00\xa1\x00\x00\x00\x00\x00\x95\x00\x00\x00\x00\x00\x00\x00\x7a\x01\x08\x00\xb9\x00\xb4\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa4\x01\x7b\x00\x00\x00\x00\x00\x1b\x00\x00\x00\xaf\x00\x84\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1f\x01\xac\x00\x80\x00\x00\x00\x71\x01\x69\x01\x61\x00\x71\x01\x00\x00\x00\x00\x00\x00\x08\x01\x9e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x71\x01\x00\x00\x00\x00\xe1\x00\x00\x00\x00\x00\xa6\x01\x00\x00\x00\x00\x51\x00\x91\x01\x0e\x00\x00\x00\x00\x00\x77\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x4c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0c\x00\x6b\x00\x00\x00\xff\x00\x00\x00\x2a\x01\x00\x00\xf4\x00\x00\x00\x00\x00\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x89\x01\x00\x00\x15\x00\x00\x00\x00\x00\x0b\x00\xde\x00\xce\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xee\xff\x00\x00\x00\x00\xfd\xff\xdd\xff\x00\x00\x00\x00\x00\x00\x00\x00\xf4\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x73\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf9\xff\x73\xff\x72\xff\x00\x00\xed\xff\x00\x00\x00\x00\x00\x00\xf0\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf2\xff\xf5\xff\xf6\xff\xeb\xff\x00\x00\xde\xff\x00\x00\xe9\xff\x00\x00\xcb\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x92\xff\x00\x00\x00\x00\x00\x00\xeb\xff\x00\x00\x73\xff\x71\xff\x00\x00\xe9\xff\x00\x00\x00\x00\xc0\xff\xbf\xff\xc4\xff\xd6\xff\xe5\xff\xda\xff\xbe\xff\xd5\xff\xc6\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd2\xff\xd4\xff\xfc\xff\xfb\xff\x8f\xff\x91\xff\xe4\xff\xba\xff\x00\x00\x85\xff\x00\x00\x00\x00\xb9\xff\x00\x00\x00\x00\x00\x00\x00\x00\xe8\xff\xf1\xff\x00\x00\x00\x00\xca\xff\xec\xff\x00\x00\x73\xff\xe0\xff\x00\x00\xf7\xff\xcb\xff\x00\x00\x00\x00\x00\x00\xf8\xff\x00\x00\x00\x00\xb8\xff\x00\x00\xa0\xff\x84\xff\x00\x00\x00\x00\x00\x00\x00\x00\x92\xff\xdf\xff\xc1\xff\xc2\xff\x00\x00\x00\x00\x00\x00\x00\x00\xc8\xff\xdb\xff\x00\x00\x00\x00\x00\x00\x00\x00\xee\xff\xfa\xff\x96\xff\xef\xff\xdc\xff\x00\x00\x00\x00\xd7\xff\x00\x00\xd3\xff\x00\x00\xc3\xff\x8e\xff\x90\xff\x00\x00\xa5\xff\xb1\xff\xb5\xff\xa8\xff\xa6\xff\xe3\xff\xb0\xff\xb6\xff\x8b\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9f\xff\xbc\xff\x00\x00\x85\xff\x00\x00\x00\x00\x88\xff\xe6\xff\xbd\xff\x8d\xff\xc9\xff\xea\xff\xe7\xff\x00\x00\x87\xff\x00\x00\x00\x00\x00\x00\x00\x00\x83\xff\xb7\xff\x7f\xff\x00\x00\xb3\xff\x7f\xff\x00\x00\xaf\xff\x7d\xff\x8a\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd8\xff\xcf\xff\xce\xff\xcd\xff\xc7\xff\x00\x00\x00\x00\xcc\xff\xc5\xff\x94\xff\x00\x00\x00\x00\xc8\xff\xd1\xff\x00\x00\x00\x00\x9e\xff\xad\xff\xaa\xff\xb2\xff\x00\x00\x8b\xff\x00\x00\xae\xff\x00\x00\x75\xff\x7f\xff\x00\x00\xbb\xff\xa7\xff\xe2\xff\x00\x00\x88\xff\x8c\xff\x86\xff\x00\x00\x7e\xff\xa9\xff\x00\x00\x81\xff\x00\x00\x00\x00\xb4\xff\x7c\xff\x7b\xff\x89\xff\xa3\xff\x00\x00\x00\x00\x00\x00\x00\x00\xf3\xff\x00\x00\x95\xff\x00\x00\x93\xff\xd0\xff\xd9\xff\x9d\xff\x7a\xff\x00\x00\x00\x00\x9b\xff\x98\xff\x74\xff\x78\xff\x00\x00\x9a\xff\x00\x00\xac\xff\x75\xff\xab\xff\x00\x00\xe1\xff\x80\xff\xa2\xff\x75\xff\x00\x00\x77\xff\x00\x00\x00\x00\x7d\xff\x7b\xff\x79\xff\xa1\xff\xa4\xff\x99\xff\x78\xff\x00\x00\x00\x00\x9c\xff\x97\xff\x76\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x11\x00\x00\x00\x08\x00\x08\x00\x00\x00\x00\x00\x03\x00\x00\x00\x01\x00\x02\x00\x16\x00\x03\x00\x03\x00\x0d\x00\x01\x00\x01\x00\x05\x00\x08\x00\x0a\x00\x03\x00\x0c\x00\x15\x00\x0b\x00\x0f\x00\x08\x00\x11\x00\x12\x00\x14\x00\x0c\x00\x07\x00\x0a\x00\x0f\x00\x31\x00\x11\x00\x15\x00\x03\x00\x23\x00\x1d\x00\x32\x00\x23\x00\x23\x00\x21\x00\x26\x00\x26\x00\x0c\x00\x0d\x00\x0e\x00\x35\x00\x35\x00\x35\x00\x35\x00\x35\x00\x35\x00\x32\x00\x34\x00\x33\x00\x33\x00\x31\x00\x32\x00\x33\x00\x28\x00\x31\x00\x2e\x00\x03\x00\x30\x00\x31\x00\x32\x00\x33\x00\x08\x00\x09\x00\x01\x00\x31\x00\x0c\x00\x03\x00\x04\x00\x0f\x00\x02\x00\x11\x00\x08\x00\x03\x00\x09\x00\x31\x00\x0c\x00\x33\x00\x08\x00\x0f\x00\x03\x00\x11\x00\x0c\x00\x03\x00\x16\x00\x0f\x00\x10\x00\x11\x00\x08\x00\x0c\x00\x03\x00\x0e\x00\x0c\x00\x03\x00\x00\x00\x0f\x00\x13\x00\x11\x00\x00\x00\x0c\x00\x00\x00\x0e\x00\x0c\x00\x31\x00\x32\x00\x33\x00\x00\x00\x03\x00\x0e\x00\x2c\x00\x00\x00\x07\x00\x32\x00\x31\x00\x32\x00\x33\x00\x01\x00\x1b\x00\x1c\x00\x31\x00\x32\x00\x33\x00\x04\x00\x16\x00\x0e\x00\x1b\x00\x31\x00\x1b\x00\x33\x00\x31\x00\x32\x00\x33\x00\x30\x00\x23\x00\x06\x00\x23\x00\x31\x00\x04\x00\x33\x00\x31\x00\x0c\x00\x16\x00\x0e\x00\x00\x00\x2e\x00\x00\x00\x2e\x00\x00\x00\x1e\x00\x1f\x00\x20\x00\x32\x00\x22\x00\x23\x00\x24\x00\x0c\x00\x26\x00\x27\x00\x00\x00\x00\x00\x2a\x00\x2b\x00\x00\x00\x2d\x00\x1f\x00\x2f\x00\x00\x00\x31\x00\x23\x00\x02\x00\x0c\x00\x26\x00\x27\x00\x0b\x00\x02\x00\x2a\x00\x2b\x00\x31\x00\x32\x00\x33\x00\x2f\x00\x24\x00\x31\x00\x24\x00\x29\x00\x31\x00\x01\x00\x0c\x00\x0d\x00\x0e\x00\x2d\x00\x20\x00\x2d\x00\x00\x00\x23\x00\x02\x00\x30\x00\x13\x00\x20\x00\x29\x00\x16\x00\x23\x00\x0c\x00\x2c\x00\x00\x00\x0f\x00\x15\x00\x11\x00\x12\x00\x00\x00\x2c\x00\x02\x00\x00\x00\x00\x00\x02\x00\x05\x00\x06\x00\x02\x00\x0e\x00\x1d\x00\x05\x00\x00\x00\x00\x00\x21\x00\x31\x00\x32\x00\x33\x00\x30\x00\x00\x00\x00\x00\x25\x00\x00\x00\x01\x00\x02\x00\x15\x00\x0e\x00\x0e\x00\x2b\x00\x19\x00\x31\x00\x32\x00\x33\x00\x00\x00\x01\x00\x02\x00\x0e\x00\x25\x00\x1a\x00\x1a\x00\x25\x00\x15\x00\x00\x00\x01\x00\x02\x00\x19\x00\x00\x00\x0e\x00\x17\x00\x18\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x00\x00\x27\x00\x0e\x00\x07\x00\x24\x00\x00\x00\x0e\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x00\x00\x01\x00\x02\x00\x0e\x00\x24\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x00\x00\x01\x00\x02\x00\x00\x00\x24\x00\x0e\x00\x1a\x00\x00\x00\x02\x00\x00\x00\x01\x00\x02\x00\x00\x00\x02\x00\x0e\x00\x2a\x00\x02\x00\x0e\x00\x00\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x0e\x00\x00\x00\x09\x00\x0e\x00\x24\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x00\x00\x01\x00\x02\x00\x21\x00\x24\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x00\x00\x01\x00\x02\x00\x0b\x00\x24\x00\x0e\x00\x00\x00\x17\x00\x2f\x00\x00\x00\x01\x00\x02\x00\x00\x00\x34\x00\x0e\x00\x17\x00\x18\x00\x00\x00\x00\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x0e\x00\x09\x00\x00\x00\x00\x00\x24\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x00\x00\x01\x00\x02\x00\x00\x00\x24\x00\x1c\x00\x1d\x00\x0e\x00\x1f\x00\x00\x00\x01\x00\x02\x00\x00\x00\x24\x00\x0e\x00\x00\x00\x00\x00\x0e\x00\x00\x00\x1a\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x0d\x00\x21\x00\x0e\x00\x00\x00\x1c\x00\x1a\x00\x0e\x00\x1f\x00\x00\x00\x01\x00\x02\x00\x00\x00\x24\x00\x1c\x00\x1a\x00\x2f\x00\x1f\x00\x00\x00\x1a\x00\x00\x00\x34\x00\x24\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x00\x00\x01\x00\x02\x00\x00\x00\x1e\x00\x18\x00\x20\x00\x22\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x02\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x2d\x00\x04\x00\x2f\x00\x31\x00\x32\x00\x18\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x00\x00\x01\x00\x02\x00\x32\x00\x09\x00\x18\x00\x22\x00\x01\x00\x15\x00\x02\x00\x31\x00\x00\x00\x01\x00\x02\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x04\x00\x04\x00\x31\x00\x32\x00\x01\x00\x18\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x00\x00\x01\x00\x02\x00\x02\x00\x31\x00\x18\x00\x01\x00\x04\x00\x15\x00\x33\x00\x01\x00\x00\x00\x01\x00\x02\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x15\x00\x31\x00\x04\x00\x14\x00\x01\x00\x18\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x00\x00\x01\x00\x02\x00\x17\x00\x06\x00\x18\x00\x0d\x00\x31\x00\x22\x00\x04\x00\x33\x00\x00\x00\x01\x00\x02\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x00\x00\x01\x00\x02\x00\x02\x00\x01\x00\x18\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x00\x00\x01\x00\x02\x00\x0e\x00\x0d\x00\x18\x00\x11\x00\x12\x00\x06\x00\x1a\x00\x31\x00\x03\x00\x01\x00\x18\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x00\x00\x31\x00\x0b\x00\x15\x00\x04\x00\x18\x00\x06\x00\x14\x00\x03\x00\x31\x00\x0a\x00\x0b\x00\x04\x00\x06\x00\x0d\x00\x10\x00\x31\x00\x33\x00\x04\x00\x01\x00\x05\x00\x13\x00\x0a\x00\x02\x00\x31\x00\x25\x00\x31\x00\x03\x00\x01\x00\x09\x00\x05\x00\x02\x00\x01\x00\x31\x00\x02\x00\x02\x00\x33\x00\x02\x00\x19\x00\x0b\x00\x06\x00\x33\x00\x01\x00\x31\x00\x29\x00\x05\x00\x31\x00\x29\x00\x25\x00\x07\x00\x28\x00\x08\x00\x02\x00\x31\x00\x05\x00\x02\x00\x28\x00\x05\x00\x02\x00\x05\x00\x02\x00\x01\x00\x28\x00\x1a\x00\x01\x00\xff\xff\x31\x00\x02\x00\x31\x00\x21\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x31\x00\x35\x00\xff\xff\xff\xff\xff\xff\x24\x00\xff\xff\xff\xff\x35\x00\xff\xff\xff\xff\xff\xff\x31\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x19\x00\x19\x00\x19\x00\x19\x00\x19\x00\x19\x00\x7e\x00\x79\x00\x43\x00\x30\x00\x79\x00\x79\x00\xfc\x00\xd0\x00\xd1\x00\xd2\x00\x7d\xff\x4f\x00\xe9\x00\xe7\x00\x18\x01\xfa\x00\x98\x00\xea\x00\x50\x00\xa5\x00\x51\x00\xbd\x00\x8b\x00\x52\x00\xa6\x00\x53\x00\x54\x00\xd3\x00\xa7\x00\x73\xff\xd9\x00\xa8\x00\x04\x00\xa9\x00\xbd\x00\x11\x01\xe0\x00\x55\x00\x7d\xff\x1c\x01\x1c\x01\x56\x00\x1d\x01\x1d\x01\x12\x01\x2a\x01\x13\x01\x31\x00\x31\x00\x6e\x00\x41\x00\x1a\x00\x24\x00\x57\x00\x28\x01\x2b\x01\x1e\x01\x04\x00\x57\x00\x58\x00\xda\x00\x23\x01\xaa\x00\xa5\x00\xab\x00\x04\x00\x57\x00\x58\x00\xa6\x00\x17\x01\xfa\x00\x04\x00\xa7\x00\xa5\x00\xf5\x00\xa8\x00\x09\x01\xa9\x00\xa6\x00\xa5\x00\xc6\x00\x04\x00\xa7\x00\x58\x00\xa6\x00\xa8\x00\x11\x01\xa9\x00\xa7\x00\xa5\x00\x21\x01\xa8\x00\xfa\x00\xa9\x00\xa6\x00\x12\x01\x11\x01\x13\x01\xa7\x00\x5e\x00\x45\x00\xa8\x00\x14\x01\xa9\x00\x79\x00\x12\x01\x79\x00\x13\x01\x5f\x00\x04\x00\x57\x00\x58\x00\x05\x01\x16\x00\x1b\x01\xc7\x00\x45\x00\x17\x00\x57\x00\x04\x00\x57\x00\x58\x00\xfa\x00\x60\x00\x61\x00\x04\x00\x57\x00\x58\x00\x0a\x00\x7d\xff\xdb\x00\x7a\x00\x04\x00\x7a\x00\x58\x00\x04\x00\x57\x00\x58\x00\xf5\x00\x7b\x00\xd5\x00\x7b\x00\x04\x00\x03\x01\x58\x00\x04\x00\xd6\x00\x00\x01\xd7\x00\x58\x00\xbe\x00\xb8\x00\x7c\x00\xb8\x00\x0b\x00\x0c\x00\x0d\x00\x7d\xff\x0e\x00\x0f\x00\x10\x00\x59\x00\x11\x00\x12\x00\x58\x00\x79\x00\x13\x00\x14\x00\x04\x00\x15\x00\x0c\x00\x16\x00\x79\x00\x04\x00\x0f\x00\xde\x00\x59\x00\x11\x00\x12\x00\x01\x01\xdf\x00\x13\x00\x14\x00\x04\x00\x57\x00\x58\x00\x04\x01\xb9\x00\x04\x00\xb9\x00\x9a\x00\xe5\x00\xbc\x00\xd6\x00\x08\x01\xd7\x00\xf1\x00\xc7\x00\xba\x00\x0d\x01\xc8\x00\x0e\x01\xe7\x00\x92\x00\xc7\x00\x5a\x00\x93\x00\xc8\x00\x8a\x00\xfc\x00\x45\x00\x52\x00\xbd\x00\x53\x00\x54\x00\x0d\x01\xc9\x00\x0e\x01\x0d\x01\x67\x00\x0e\x01\x1b\x00\x1c\x00\x3c\x00\xf0\x00\x55\x00\x3d\x00\x45\x00\x45\x00\x56\x00\x04\x00\x57\x00\x58\x00\xea\x00\xc2\x00\x67\x00\x0f\x01\x9b\x00\x9c\x00\x9d\x00\xb5\x00\x5b\x00\x5b\x00\xb7\x00\x69\x00\x04\x00\x57\x00\x58\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\x2a\x01\xbd\x00\xbf\x00\x0f\x01\x68\x00\x9b\x00\x9c\x00\x9d\x00\x69\x00\x45\x00\x9e\x00\xcd\x00\xce\x00\x9f\x00\xa0\x00\x18\x01\xa2\x00\x45\x00\xd8\x00\x9e\x00\x8e\x00\xa3\x00\x90\x00\xc3\x00\x9f\x00\xa0\x00\x1a\x01\xa2\x00\x9b\x00\x9c\x00\x9d\x00\x5b\x00\xa3\x00\x9f\x00\xa0\x00\xf2\x00\xa2\x00\x9b\x00\x9c\x00\x9d\x00\x45\x00\xa3\x00\x9e\x00\xc1\x00\x91\x00\xab\x00\x9b\x00\x9c\x00\x9d\x00\x45\x00\x77\x00\x9e\x00\x80\x00\x81\x00\x83\x00\x82\x00\x9f\x00\xa0\x00\xfd\x00\xa2\x00\x9e\x00\x86\x00\x8c\x00\x62\x00\xa3\x00\x9f\x00\xa0\x00\xed\x00\xa2\x00\x9b\x00\x9c\x00\x9d\x00\xf6\x00\xa3\x00\x9f\x00\xa0\x00\xc4\x00\xa2\x00\x9b\x00\x9c\x00\x9d\x00\x8b\x00\xa3\x00\x9e\x00\x42\x00\x87\x00\x19\x01\x9b\x00\x9c\x00\x9d\x00\x44\x00\xf8\x00\x9e\x00\xcd\x00\xce\x00\x63\x00\x65\x00\x9f\x00\xa0\x00\xa1\x00\xa2\x00\x9e\x00\x6b\x00\x45\x00\x66\x00\xa3\x00\x9f\x00\xa0\x00\xb0\x00\xa2\x00\x9b\x00\x9c\x00\x9d\x00\x45\x00\xa3\x00\x9f\x00\xec\x00\x5b\x00\xa2\x00\x9b\x00\x9c\x00\x9d\x00\x45\x00\xa3\x00\x9e\x00\x6d\x00\x45\x00\x5b\x00\x3d\x00\x99\x00\x1e\x00\x1f\x00\x20\x00\x9e\x00\x2d\x00\xf6\x00\x5b\x00\x21\x00\xf3\x00\x78\x00\x5b\x00\xa2\x00\x45\x00\x46\x00\x47\x00\x22\x00\xa3\x00\xe1\x00\x5c\x00\xf7\x00\xa2\x00\x23\x00\x61\x00\x25\x00\xf8\x00\xa3\x00\x48\x00\x49\x00\x08\x01\x4b\x00\x4c\x00\x45\x00\x46\x00\x47\x00\x26\x00\x0b\x00\x4d\x00\x0d\x00\x0a\x01\x27\x00\x28\x00\x29\x00\x45\x00\x46\x00\x47\x00\x48\x00\x49\x00\xdc\x00\x4b\x00\x4c\x00\x15\x00\x26\x01\x1e\x00\x0b\x01\x22\x01\x4d\x00\x48\x00\x49\x00\xce\x00\x4b\x00\x4c\x00\x45\x00\x46\x00\x47\x00\x57\x00\x25\x01\x4d\x00\x0a\x01\x27\x01\xbd\x00\x28\x01\x04\x00\x45\x00\x46\x00\x47\x00\x48\x00\x49\x00\xcf\x00\x4b\x00\x4c\x00\x82\xff\x20\x01\x0b\x01\x0c\x01\x22\x01\x4d\x00\x48\x00\x49\x00\x85\x00\x4b\x00\x4c\x00\x45\x00\x46\x00\x47\x00\x3c\x00\x04\x00\x4d\x00\x07\x01\x15\x01\xbd\x00\x58\x00\x16\x01\x45\x00\x46\x00\x47\x00\x48\x00\x49\x00\xb2\x00\x4b\x00\x4c\x00\xbd\x00\x04\x00\x82\xff\xcb\x00\x05\x01\x4d\x00\x48\x00\x49\x00\xb3\x00\x4b\x00\x4c\x00\x84\x00\x46\x00\x47\x00\xff\x00\x00\x01\x4d\x00\xde\x00\x04\x00\x0e\x00\xe3\x00\x58\x00\x45\x00\x46\x00\x47\x00\x48\x00\x49\x00\x85\x00\x4b\x00\x4c\x00\x45\x00\x46\x00\x47\x00\xe4\x00\xe5\x00\x4d\x00\x48\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x45\x00\x46\x00\x47\x00\x48\x00\xec\x00\x4d\x00\x88\x00\x4c\x00\xef\x00\xf0\x00\x04\x00\xc1\x00\xd8\x00\x4d\x00\x48\x00\x49\x00\x64\x00\x4b\x00\x4c\x00\x04\x00\x04\x00\xcc\x00\xbd\x00\x05\x00\x4d\x00\x06\x00\xcb\x00\x90\x00\x04\x00\x07\x00\x08\x00\x95\x00\x96\x00\x97\x00\x99\x00\x04\x00\x58\x00\xad\x00\xaf\x00\xae\x00\xb0\x00\xb2\x00\xb5\x00\x04\x00\xb7\x00\x04\x00\x70\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x04\x00\x76\x00\x77\x00\x58\x00\x7f\x00\x80\x00\x8b\x00\x8c\x00\x58\x00\x8e\x00\x04\x00\x6d\x00\x3d\x00\x04\x00\x6d\x00\x30\x00\x6b\x00\x34\x00\x33\x00\x35\x00\x04\x00\x36\x00\x39\x00\x37\x00\x38\x00\x3b\x00\x3a\x00\x3f\x00\x2b\x00\x40\x00\x41\x00\x2c\x00\x00\x00\x04\x00\x2d\x00\x04\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\xff\xff\x00\x00\x00\x00\x00\x00\x19\x00\x00\x00\x00\x00\xff\xff\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (2, 142) [
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
	(135 , happyReduce_135),
	(136 , happyReduce_136),
	(137 , happyReduce_137),
	(138 , happyReduce_138),
	(139 , happyReduce_139),
	(140 , happyReduce_140),
	(141 , happyReduce_141),
	(142 , happyReduce_142)
	]

happy_n_terms = 54 :: Int
happy_n_nonterms = 54 :: Int

happyReduce_2 = happySpecReduce_1 0# happyReduction_2
happyReduction_2 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TV happy_var_1)) -> 
	happyIn5
		 (identC happy_var_1
	)}

happyReduce_3 = happySpecReduce_1 1# happyReduction_3
happyReduction_3 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TL happy_var_1)) -> 
	happyIn6
		 (happy_var_1
	)}

happyReduce_4 = happySpecReduce_1 2# happyReduction_4
happyReduction_4 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TI happy_var_1)) -> 
	happyIn7
		 ((read happy_var_1) :: Integer
	)}

happyReduce_5 = happyReduce 6# 3# happyReduction_5
happyReduction_5 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut58 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	case happyOut12 happy_x_6 of { happy_var_6 -> 
	happyIn8
		 (MGr happy_var_2 happy_var_4 (reverse happy_var_6)
	) `HappyStk` happyRest}}}

happyReduce_6 = happySpecReduce_1 3# happyReduction_6
happyReduction_6 happy_x_1
	 =  case happyOut12 happy_x_1 of { happy_var_1 -> 
	happyIn8
		 (Gr (reverse happy_var_1)
	)}

happyReduce_7 = happyReduce 5# 4# happyReduction_7
happyReduction_7 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut58 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	happyIn9
		 (LMulti happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_8 = happyReduce 5# 4# happyReduction_8
happyReduction_8 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut11 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	case happyOut14 happy_x_4 of { happy_var_4 -> 
	happyIn9
		 (LHeader happy_var_1 happy_var_3 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_9 = happySpecReduce_2 4# happyReduction_9
happyReduction_9 happy_x_2
	happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	happyIn9
		 (LFlag happy_var_1
	)}

happyReduce_10 = happySpecReduce_2 4# happyReduction_10
happyReduction_10 happy_x_2
	happy_x_1
	 =  case happyOut16 happy_x_1 of { happy_var_1 -> 
	happyIn9
		 (LDef happy_var_1
	)}

happyReduce_11 = happySpecReduce_1 4# happyReduction_11
happyReduction_11 happy_x_1
	 =  happyIn9
		 (LEnd
	)

happyReduce_12 = happyReduce 8# 5# happyReduction_12
happyReduction_12 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut11 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_3 of { happy_var_3 -> 
	case happyOut14 happy_x_4 of { happy_var_4 -> 
	case happyOut44 happy_x_6 of { happy_var_6 -> 
	case happyOut45 happy_x_7 of { happy_var_7 -> 
	happyIn10
		 (Mod happy_var_1 happy_var_3 happy_var_4 (reverse happy_var_6) (reverse happy_var_7)
	) `HappyStk` happyRest}}}}}

happyReduce_13 = happySpecReduce_2 6# happyReduction_13
happyReduction_13 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn11
		 (MTAbs happy_var_2
	)}

happyReduce_14 = happyReduce 4# 6# happyReduction_14
happyReduction_14 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	happyIn11
		 (MTCnc happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_15 = happySpecReduce_2 6# happyReduction_15
happyReduction_15 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn11
		 (MTRes happy_var_2
	)}

happyReduce_16 = happyReduce 6# 6# happyReduction_16
happyReduction_16 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	case happyOut5 happy_x_6 of { happy_var_6 -> 
	happyIn11
		 (MTTrans happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_17 = happySpecReduce_0 7# happyReduction_17
happyReduction_17  =  happyIn12
		 ([]
	)

happyReduce_18 = happySpecReduce_2 7# happyReduction_18
happyReduction_18 happy_x_2
	happy_x_1
	 =  case happyOut12 happy_x_1 of { happy_var_1 -> 
	case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn12
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_19 = happySpecReduce_2 8# happyReduction_19
happyReduction_19 happy_x_2
	happy_x_1
	 =  case happyOut58 happy_x_1 of { happy_var_1 -> 
	happyIn13
		 (Ext happy_var_1
	)}

happyReduce_20 = happySpecReduce_0 8# happyReduction_20
happyReduction_20  =  happyIn13
		 (NoExt
	)

happyReduce_21 = happySpecReduce_3 9# happyReduction_21
happyReduction_21 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut58 happy_x_2 of { happy_var_2 -> 
	happyIn14
		 (Opens happy_var_2
	)}

happyReduce_22 = happySpecReduce_0 9# happyReduction_22
happyReduction_22  =  happyIn14
		 (NoOpens
	)

happyReduce_23 = happyReduce 4# 10# happyReduction_23
happyReduction_23 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	happyIn15
		 (Flg happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_24 = happyReduce 7# 11# happyReduction_24
happyReduction_24 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut26 happy_x_4 of { happy_var_4 -> 
	case happyOut48 happy_x_7 of { happy_var_7 -> 
	happyIn16
		 (AbsDCat happy_var_2 happy_var_4 (reverse happy_var_7)
	) `HappyStk` happyRest}}}

happyReduce_25 = happyReduce 6# 11# happyReduction_25
happyReduction_25 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	case happyOut21 happy_x_6 of { happy_var_6 -> 
	happyIn16
		 (AbsDFun happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_26 = happyReduce 4# 11# happyReduction_26
happyReduction_26 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	happyIn16
		 (AbsDTrans happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_27 = happyReduce 4# 11# happyReduction_27
happyReduction_27 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut46 happy_x_4 of { happy_var_4 -> 
	happyIn16
		 (ResDPar happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_28 = happyReduce 6# 11# happyReduction_28
happyReduction_28 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut31 happy_x_4 of { happy_var_4 -> 
	case happyOut35 happy_x_6 of { happy_var_6 -> 
	happyIn16
		 (ResDOper happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_29 = happyReduce 8# 11# happyReduction_29
happyReduction_29 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut31 happy_x_4 of { happy_var_4 -> 
	case happyOut35 happy_x_6 of { happy_var_6 -> 
	case happyOut35 happy_x_8 of { happy_var_8 -> 
	happyIn16
		 (CncDCat happy_var_2 happy_var_4 happy_var_6 happy_var_8
	) `HappyStk` happyRest}}}}

happyReduce_30 = happyReduce 11# 11# happyReduction_30
happyReduction_30 (happy_x_11 `HappyStk`
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
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut19 happy_x_4 of { happy_var_4 -> 
	case happyOut50 happy_x_7 of { happy_var_7 -> 
	case happyOut35 happy_x_9 of { happy_var_9 -> 
	case happyOut35 happy_x_11 of { happy_var_11 -> 
	happyIn16
		 (CncDFun happy_var_2 happy_var_4 happy_var_7 happy_var_9 happy_var_11
	) `HappyStk` happyRest}}}}}

happyReduce_31 = happyReduce 4# 11# happyReduction_31
happyReduction_31 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut18 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	happyIn16
		 (AnyDInd happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_32 = happySpecReduce_2 12# happyReduction_32
happyReduction_32 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_2 of { happy_var_2 -> 
	happyIn17
		 (ParD happy_var_1 (reverse happy_var_2)
	)}}

happyReduce_33 = happySpecReduce_1 13# happyReduction_33
happyReduction_33 happy_x_1
	 =  happyIn18
		 (Canon
	)

happyReduce_34 = happySpecReduce_0 13# happyReduction_34
happyReduction_34  =  happyIn18
		 (NonCan
	)

happyReduce_35 = happySpecReduce_3 14# happyReduction_35
happyReduction_35 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut5 happy_x_3 of { happy_var_3 -> 
	happyIn19
		 (CIQ happy_var_1 happy_var_3
	)}}

happyReduce_36 = happySpecReduce_2 15# happyReduction_36
happyReduction_36 happy_x_2
	happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_2 of { happy_var_2 -> 
	happyIn20
		 (EApp happy_var_1 happy_var_2
	)}}

happyReduce_37 = happySpecReduce_1 15# happyReduction_37
happyReduction_37 happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 (happy_var_1
	)}

happyReduce_38 = happyReduce 7# 16# happyReduction_38
happyReduction_38 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	case happyOut21 happy_x_7 of { happy_var_7 -> 
	happyIn21
		 (EProd happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_39 = happyReduce 4# 16# happyReduction_39
happyReduction_39 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	happyIn21
		 (EAbs happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_40 = happySpecReduce_3 16# happyReduction_40
happyReduction_40 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_2 of { happy_var_2 -> 
	happyIn21
		 (EEq (reverse happy_var_2)
	)}

happyReduce_41 = happySpecReduce_1 16# happyReduction_41
happyReduction_41 happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	happyIn21
		 (happy_var_1
	)}

happyReduce_42 = happySpecReduce_1 17# happyReduction_42
happyReduction_42 happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	happyIn22
		 (EAtom happy_var_1
	)}

happyReduce_43 = happySpecReduce_1 17# happyReduction_43
happyReduction_43 happy_x_1
	 =  happyIn22
		 (EData
	)

happyReduce_44 = happySpecReduce_3 17# happyReduction_44
happyReduction_44 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (happy_var_2
	)}

happyReduce_45 = happySpecReduce_1 18# happyReduction_45
happyReduction_45 happy_x_1
	 =  happyIn23
		 (SType
	)

happyReduce_46 = happySpecReduce_3 19# happyReduction_46
happyReduction_46 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	happyIn24
		 (Equ (reverse happy_var_1) happy_var_3
	)}}

happyReduce_47 = happyReduce 4# 20# happyReduction_47
happyReduction_47 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut19 happy_x_2 of { happy_var_2 -> 
	case happyOut27 happy_x_3 of { happy_var_3 -> 
	happyIn25
		 (APC happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_48 = happySpecReduce_1 20# happyReduction_48
happyReduction_48 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn25
		 (APV happy_var_1
	)}

happyReduce_49 = happySpecReduce_1 20# happyReduction_49
happyReduction_49 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn25
		 (APS happy_var_1
	)}

happyReduce_50 = happySpecReduce_1 20# happyReduction_50
happyReduction_50 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn25
		 (API happy_var_1
	)}

happyReduce_51 = happySpecReduce_1 20# happyReduction_51
happyReduction_51 happy_x_1
	 =  happyIn25
		 (APW
	)

happyReduce_52 = happySpecReduce_0 21# happyReduction_52
happyReduction_52  =  happyIn26
		 ([]
	)

happyReduce_53 = happySpecReduce_1 21# happyReduction_53
happyReduction_53 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 ((:[]) happy_var_1
	)}

happyReduce_54 = happySpecReduce_3 21# happyReduction_54
happyReduction_54 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn26
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_55 = happySpecReduce_0 22# happyReduction_55
happyReduction_55  =  happyIn27
		 ([]
	)

happyReduce_56 = happySpecReduce_2 22# happyReduction_56
happyReduction_56 happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut25 happy_x_2 of { happy_var_2 -> 
	happyIn27
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_57 = happySpecReduce_0 23# happyReduction_57
happyReduction_57  =  happyIn28
		 ([]
	)

happyReduce_58 = happySpecReduce_3 23# happyReduction_58
happyReduction_58 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	case happyOut24 happy_x_2 of { happy_var_2 -> 
	happyIn28
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_59 = happySpecReduce_1 24# happyReduction_59
happyReduction_59 happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	happyIn29
		 (AC happy_var_1
	)}

happyReduce_60 = happySpecReduce_3 24# happyReduction_60
happyReduction_60 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_2 of { happy_var_2 -> 
	happyIn29
		 (AD happy_var_2
	)}

happyReduce_61 = happySpecReduce_2 24# happyReduction_61
happyReduction_61 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn29
		 (AV happy_var_2
	)}

happyReduce_62 = happySpecReduce_2 24# happyReduction_62
happyReduction_62 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_2 of { happy_var_2 -> 
	happyIn29
		 (AM happy_var_2
	)}

happyReduce_63 = happySpecReduce_1 24# happyReduction_63
happyReduction_63 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn29
		 (AS happy_var_1
	)}

happyReduce_64 = happySpecReduce_1 24# happyReduction_64
happyReduction_64 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn29
		 (AI happy_var_1
	)}

happyReduce_65 = happySpecReduce_1 24# happyReduction_65
happyReduction_65 happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn29
		 (AT happy_var_1
	)}

happyReduce_66 = happySpecReduce_3 25# happyReduction_66
happyReduction_66 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	happyIn30
		 (Decl happy_var_1 happy_var_3
	)}}

happyReduce_67 = happySpecReduce_3 26# happyReduction_67
happyReduction_67 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut51 happy_x_2 of { happy_var_2 -> 
	happyIn31
		 (RecType happy_var_2
	)}

happyReduce_68 = happyReduce 5# 26# happyReduction_68
happyReduction_68 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut31 happy_x_2 of { happy_var_2 -> 
	case happyOut31 happy_x_4 of { happy_var_4 -> 
	happyIn31
		 (Table happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_69 = happySpecReduce_1 26# happyReduction_69
happyReduction_69 happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	happyIn31
		 (Cn happy_var_1
	)}

happyReduce_70 = happySpecReduce_1 26# happyReduction_70
happyReduction_70 happy_x_1
	 =  happyIn31
		 (TStr
	)

happyReduce_71 = happySpecReduce_2 26# happyReduction_71
happyReduction_71 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_2 of { happy_var_2 -> 
	happyIn31
		 (TInts happy_var_2
	)}

happyReduce_72 = happySpecReduce_3 27# happyReduction_72
happyReduction_72 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 (Lbg happy_var_1 happy_var_3
	)}}

happyReduce_73 = happySpecReduce_1 28# happyReduction_73
happyReduction_73 happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (Arg happy_var_1
	)}

happyReduce_74 = happySpecReduce_1 28# happyReduction_74
happyReduction_74 happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (I happy_var_1
	)}

happyReduce_75 = happyReduce 4# 28# happyReduction_75
happyReduction_75 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut19 happy_x_2 of { happy_var_2 -> 
	case happyOut53 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (Par happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_76 = happySpecReduce_2 28# happyReduction_76
happyReduction_76 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn33
		 (LI happy_var_2
	)}

happyReduce_77 = happySpecReduce_3 28# happyReduction_77
happyReduction_77 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut49 happy_x_2 of { happy_var_2 -> 
	happyIn33
		 (R happy_var_2
	)}

happyReduce_78 = happySpecReduce_1 28# happyReduction_78
happyReduction_78 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (EInt happy_var_1
	)}

happyReduce_79 = happySpecReduce_1 28# happyReduction_79
happyReduction_79 happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (K happy_var_1
	)}

happyReduce_80 = happySpecReduce_2 28# happyReduction_80
happyReduction_80 happy_x_2
	happy_x_1
	 =  happyIn33
		 (E
	)

happyReduce_81 = happySpecReduce_3 28# happyReduction_81
happyReduction_81 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_2 of { happy_var_2 -> 
	happyIn33
		 (happy_var_2
	)}

happyReduce_82 = happySpecReduce_3 29# happyReduction_82
happyReduction_82 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut40 happy_x_3 of { happy_var_3 -> 
	happyIn34
		 (P happy_var_1 happy_var_3
	)}}

happyReduce_83 = happyReduce 5# 29# happyReduction_83
happyReduction_83 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut31 happy_x_2 of { happy_var_2 -> 
	case happyOut52 happy_x_4 of { happy_var_4 -> 
	happyIn34
		 (T happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_84 = happyReduce 5# 29# happyReduction_84
happyReduction_84 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut31 happy_x_2 of { happy_var_2 -> 
	case happyOut53 happy_x_4 of { happy_var_4 -> 
	happyIn34
		 (V happy_var_2 (reverse happy_var_4)
	) `HappyStk` happyRest}}

happyReduce_85 = happySpecReduce_3 29# happyReduction_85
happyReduction_85 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut33 happy_x_3 of { happy_var_3 -> 
	happyIn34
		 (S happy_var_1 happy_var_3
	)}}

happyReduce_86 = happyReduce 4# 29# happyReduction_86
happyReduction_86 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut53 happy_x_3 of { happy_var_3 -> 
	happyIn34
		 (FV (reverse happy_var_3)
	) `HappyStk` happyRest}

happyReduce_87 = happySpecReduce_1 29# happyReduction_87
happyReduction_87 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (happy_var_1
	)}

happyReduce_88 = happySpecReduce_3 30# happyReduction_88
happyReduction_88 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (C happy_var_1 happy_var_3
	)}}

happyReduce_89 = happySpecReduce_1 30# happyReduction_89
happyReduction_89 happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 (happy_var_1
	)}

happyReduce_90 = happySpecReduce_1 31# happyReduction_90
happyReduction_90 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn36
		 (KS happy_var_1
	)}

happyReduce_91 = happyReduce 7# 31# happyReduction_91
happyReduction_91 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut54 happy_x_3 of { happy_var_3 -> 
	case happyOut55 happy_x_5 of { happy_var_5 -> 
	happyIn36
		 (KP (reverse happy_var_3) happy_var_5
	) `HappyStk` happyRest}}

happyReduce_92 = happySpecReduce_3 32# happyReduction_92
happyReduction_92 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn37
		 (Ass happy_var_1 happy_var_3
	)}}

happyReduce_93 = happySpecReduce_3 33# happyReduction_93
happyReduction_93 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (Cas (reverse happy_var_1) happy_var_3
	)}}

happyReduce_94 = happySpecReduce_3 34# happyReduction_94
happyReduction_94 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut54 happy_x_3 of { happy_var_3 -> 
	happyIn39
		 (Var (reverse happy_var_1) (reverse happy_var_3)
	)}}

happyReduce_95 = happySpecReduce_1 35# happyReduction_95
happyReduction_95 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn40
		 (L happy_var_1
	)}

happyReduce_96 = happySpecReduce_2 35# happyReduction_96
happyReduction_96 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_2 of { happy_var_2 -> 
	happyIn40
		 (LV happy_var_2
	)}

happyReduce_97 = happySpecReduce_3 36# happyReduction_97
happyReduction_97 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut7 happy_x_3 of { happy_var_3 -> 
	happyIn41
		 (A happy_var_1 happy_var_3
	)}}

happyReduce_98 = happyReduce 5# 36# happyReduction_98
happyReduction_98 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut7 happy_x_3 of { happy_var_3 -> 
	case happyOut7 happy_x_5 of { happy_var_5 -> 
	happyIn41
		 (AB happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_99 = happyReduce 4# 37# happyReduction_99
happyReduction_99 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut19 happy_x_2 of { happy_var_2 -> 
	case happyOut57 happy_x_3 of { happy_var_3 -> 
	happyIn42
		 (PC happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_100 = happySpecReduce_1 37# happyReduction_100
happyReduction_100 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn42
		 (PV happy_var_1
	)}

happyReduce_101 = happySpecReduce_1 37# happyReduction_101
happyReduction_101 happy_x_1
	 =  happyIn42
		 (PW
	)

happyReduce_102 = happySpecReduce_3 37# happyReduction_102
happyReduction_102 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_2 of { happy_var_2 -> 
	happyIn42
		 (PR happy_var_2
	)}

happyReduce_103 = happySpecReduce_1 37# happyReduction_103
happyReduction_103 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn42
		 (PI happy_var_1
	)}

happyReduce_104 = happySpecReduce_3 38# happyReduction_104
happyReduction_104 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_3 of { happy_var_3 -> 
	happyIn43
		 (PAss happy_var_1 happy_var_3
	)}}

happyReduce_105 = happySpecReduce_0 39# happyReduction_105
happyReduction_105  =  happyIn44
		 ([]
	)

happyReduce_106 = happySpecReduce_3 39# happyReduction_106
happyReduction_106 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut44 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_2 of { happy_var_2 -> 
	happyIn44
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_107 = happySpecReduce_0 40# happyReduction_107
happyReduction_107  =  happyIn45
		 ([]
	)

happyReduce_108 = happySpecReduce_3 40# happyReduction_108
happyReduction_108 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	case happyOut16 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_109 = happySpecReduce_0 41# happyReduction_109
happyReduction_109  =  happyIn46
		 ([]
	)

happyReduce_110 = happySpecReduce_1 41# happyReduction_110
happyReduction_110 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn46
		 ((:[]) happy_var_1
	)}

happyReduce_111 = happySpecReduce_3 41# happyReduction_111
happyReduction_111 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	case happyOut46 happy_x_3 of { happy_var_3 -> 
	happyIn46
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_112 = happySpecReduce_0 42# happyReduction_112
happyReduction_112  =  happyIn47
		 ([]
	)

happyReduce_113 = happySpecReduce_2 42# happyReduction_113
happyReduction_113 happy_x_2
	happy_x_1
	 =  case happyOut47 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_2 of { happy_var_2 -> 
	happyIn47
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_114 = happySpecReduce_0 43# happyReduction_114
happyReduction_114  =  happyIn48
		 ([]
	)

happyReduce_115 = happySpecReduce_2 43# happyReduction_115
happyReduction_115 happy_x_2
	happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_2 of { happy_var_2 -> 
	happyIn48
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_116 = happySpecReduce_0 44# happyReduction_116
happyReduction_116  =  happyIn49
		 ([]
	)

happyReduce_117 = happySpecReduce_1 44# happyReduction_117
happyReduction_117 happy_x_1
	 =  case happyOut37 happy_x_1 of { happy_var_1 -> 
	happyIn49
		 ((:[]) happy_var_1
	)}

happyReduce_118 = happySpecReduce_3 44# happyReduction_118
happyReduction_118 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut37 happy_x_1 of { happy_var_1 -> 
	case happyOut49 happy_x_3 of { happy_var_3 -> 
	happyIn49
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_119 = happySpecReduce_0 45# happyReduction_119
happyReduction_119  =  happyIn50
		 ([]
	)

happyReduce_120 = happySpecReduce_1 45# happyReduction_120
happyReduction_120 happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	happyIn50
		 ((:[]) happy_var_1
	)}

happyReduce_121 = happySpecReduce_3 45# happyReduction_121
happyReduction_121 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn50
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_122 = happySpecReduce_0 46# happyReduction_122
happyReduction_122  =  happyIn51
		 ([]
	)

happyReduce_123 = happySpecReduce_1 46# happyReduction_123
happyReduction_123 happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	happyIn51
		 ((:[]) happy_var_1
	)}

happyReduce_124 = happySpecReduce_3 46# happyReduction_124
happyReduction_124 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn51
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_125 = happySpecReduce_0 47# happyReduction_125
happyReduction_125  =  happyIn52
		 ([]
	)

happyReduce_126 = happySpecReduce_1 47# happyReduction_126
happyReduction_126 happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	happyIn52
		 ((:[]) happy_var_1
	)}

happyReduce_127 = happySpecReduce_3 47# happyReduction_127
happyReduction_127 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	case happyOut52 happy_x_3 of { happy_var_3 -> 
	happyIn52
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_128 = happySpecReduce_0 48# happyReduction_128
happyReduction_128  =  happyIn53
		 ([]
	)

happyReduce_129 = happySpecReduce_2 48# happyReduction_129
happyReduction_129 happy_x_2
	happy_x_1
	 =  case happyOut53 happy_x_1 of { happy_var_1 -> 
	case happyOut33 happy_x_2 of { happy_var_2 -> 
	happyIn53
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_130 = happySpecReduce_0 49# happyReduction_130
happyReduction_130  =  happyIn54
		 ([]
	)

happyReduce_131 = happySpecReduce_2 49# happyReduction_131
happyReduction_131 happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_2 of { happy_var_2 -> 
	happyIn54
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_132 = happySpecReduce_0 50# happyReduction_132
happyReduction_132  =  happyIn55
		 ([]
	)

happyReduce_133 = happySpecReduce_1 50# happyReduction_133
happyReduction_133 happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	happyIn55
		 ((:[]) happy_var_1
	)}

happyReduce_134 = happySpecReduce_3 50# happyReduction_134
happyReduction_134 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	case happyOut55 happy_x_3 of { happy_var_3 -> 
	happyIn55
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_135 = happySpecReduce_0 51# happyReduction_135
happyReduction_135  =  happyIn56
		 ([]
	)

happyReduce_136 = happySpecReduce_1 51# happyReduction_136
happyReduction_136 happy_x_1
	 =  case happyOut43 happy_x_1 of { happy_var_1 -> 
	happyIn56
		 ((:[]) happy_var_1
	)}

happyReduce_137 = happySpecReduce_3 51# happyReduction_137
happyReduction_137 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut43 happy_x_1 of { happy_var_1 -> 
	case happyOut56 happy_x_3 of { happy_var_3 -> 
	happyIn56
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_138 = happySpecReduce_0 52# happyReduction_138
happyReduction_138  =  happyIn57
		 ([]
	)

happyReduce_139 = happySpecReduce_2 52# happyReduction_139
happyReduction_139 happy_x_2
	happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_2 of { happy_var_2 -> 
	happyIn57
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_140 = happySpecReduce_0 53# happyReduction_140
happyReduction_140  =  happyIn58
		 ([]
	)

happyReduce_141 = happySpecReduce_1 53# happyReduction_141
happyReduction_141 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn58
		 ((:[]) happy_var_1
	)}

happyReduce_142 = happySpecReduce_3 53# happyReduction_142
happyReduction_142 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut58 happy_x_3 of { happy_var_3 -> 
	happyIn58
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
	_ -> happyError' (tk:tks)
	}

happyError_ tk tks = happyError' (tk:tks)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: () => a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (returnM) a
happyError' :: () => [Token] -> Err a
happyError' = happyError

pCanon tks = happySomeParser where
  happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut8 x))

pLine tks = happySomeParser where
  happySomeParser = happyThen (happyParse 1# tks) (\x -> happyReturn (happyOut9 x))

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
-- $Id: ParGFC.hs,v 1.11 2005/06/17 14:15:17 bringert Exp $













{-# LINE 27 "GenericTemplate.hs" #-}



data Happy_IntList = HappyCons Int# Happy_IntList






































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is 0#, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept 0# tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	(happyTcHack j (happyTcHack st)) (happyReturn1 ans)

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

{-# LINE 169 "GenericTemplate.hs" #-}


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
    	happyError_ tk

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
