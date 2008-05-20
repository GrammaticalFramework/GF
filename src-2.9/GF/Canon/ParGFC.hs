{-# OPTIONS -fglasgow-exts -cpp #-}
module GF.Canon.ParGFC where  -- H
import GF.Canon.AbsGFC -- H
import GF.Canon.LexGFC -- H
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
happyIn8 :: (Double) -> (HappyAbsSyn )
happyIn8 x = unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn ) -> (Double)
happyOut8 x = unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (Canon) -> (HappyAbsSyn )
happyIn9 x = unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> (Canon)
happyOut9 x = unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: (Line) -> (HappyAbsSyn )
happyIn10 x = unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> (Line)
happyOut10 x = unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: (Module) -> (HappyAbsSyn )
happyIn11 x = unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> (Module)
happyOut11 x = unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: (ModType) -> (HappyAbsSyn )
happyIn12 x = unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> (ModType)
happyOut12 x = unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: ([Module]) -> (HappyAbsSyn )
happyIn13 x = unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn ) -> ([Module])
happyOut13 x = unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: (Extend) -> (HappyAbsSyn )
happyIn14 x = unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> (Extend)
happyOut14 x = unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: (Open) -> (HappyAbsSyn )
happyIn15 x = unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> (Open)
happyOut15 x = unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (Flag) -> (HappyAbsSyn )
happyIn16 x = unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> (Flag)
happyOut16 x = unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: (Def) -> (HappyAbsSyn )
happyIn17 x = unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> (Def)
happyOut17 x = unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: (ParDef) -> (HappyAbsSyn )
happyIn18 x = unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> (ParDef)
happyOut18 x = unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: (Status) -> (HappyAbsSyn )
happyIn19 x = unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> (Status)
happyOut19 x = unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: (CIdent) -> (HappyAbsSyn )
happyIn20 x = unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> (CIdent)
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
happyIn23 :: (Exp) -> (HappyAbsSyn )
happyIn23 x = unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> (Exp)
happyOut23 x = unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: (Sort) -> (HappyAbsSyn )
happyIn24 x = unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> (Sort)
happyOut24 x = unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: (Equation) -> (HappyAbsSyn )
happyIn25 x = unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> (Equation)
happyOut25 x = unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: (APatt) -> (HappyAbsSyn )
happyIn26 x = unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> (APatt)
happyOut26 x = unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: ([Decl]) -> (HappyAbsSyn )
happyIn27 x = unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> ([Decl])
happyOut27 x = unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: ([APatt]) -> (HappyAbsSyn )
happyIn28 x = unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> ([APatt])
happyOut28 x = unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: ([Equation]) -> (HappyAbsSyn )
happyIn29 x = unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> ([Equation])
happyOut29 x = unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: (Atom) -> (HappyAbsSyn )
happyIn30 x = unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> (Atom)
happyOut30 x = unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: (Decl) -> (HappyAbsSyn )
happyIn31 x = unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> (Decl)
happyOut31 x = unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: (CType) -> (HappyAbsSyn )
happyIn32 x = unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> (CType)
happyOut32 x = unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (Labelling) -> (HappyAbsSyn )
happyIn33 x = unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (Labelling)
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
happyIn36 :: (Term) -> (HappyAbsSyn )
happyIn36 x = unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> (Term)
happyOut36 x = unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: (Tokn) -> (HappyAbsSyn )
happyIn37 x = unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> (Tokn)
happyOut37 x = unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: (Assign) -> (HappyAbsSyn )
happyIn38 x = unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> (Assign)
happyOut38 x = unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: (Case) -> (HappyAbsSyn )
happyIn39 x = unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> (Case)
happyOut39 x = unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: (Variant) -> (HappyAbsSyn )
happyIn40 x = unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> (Variant)
happyOut40 x = unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyIn41 :: (Label) -> (HappyAbsSyn )
happyIn41 x = unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> (Label)
happyOut41 x = unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: (ArgVar) -> (HappyAbsSyn )
happyIn42 x = unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> (ArgVar)
happyOut42 x = unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyIn43 :: (Patt) -> (HappyAbsSyn )
happyIn43 x = unsafeCoerce# x
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> (Patt)
happyOut43 x = unsafeCoerce# x
{-# INLINE happyOut43 #-}
happyIn44 :: (PattAssign) -> (HappyAbsSyn )
happyIn44 x = unsafeCoerce# x
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> (PattAssign)
happyOut44 x = unsafeCoerce# x
{-# INLINE happyOut44 #-}
happyIn45 :: ([Flag]) -> (HappyAbsSyn )
happyIn45 x = unsafeCoerce# x
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> ([Flag])
happyOut45 x = unsafeCoerce# x
{-# INLINE happyOut45 #-}
happyIn46 :: ([Def]) -> (HappyAbsSyn )
happyIn46 x = unsafeCoerce# x
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> ([Def])
happyOut46 x = unsafeCoerce# x
{-# INLINE happyOut46 #-}
happyIn47 :: ([ParDef]) -> (HappyAbsSyn )
happyIn47 x = unsafeCoerce# x
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn ) -> ([ParDef])
happyOut47 x = unsafeCoerce# x
{-# INLINE happyOut47 #-}
happyIn48 :: ([CType]) -> (HappyAbsSyn )
happyIn48 x = unsafeCoerce# x
{-# INLINE happyIn48 #-}
happyOut48 :: (HappyAbsSyn ) -> ([CType])
happyOut48 x = unsafeCoerce# x
{-# INLINE happyOut48 #-}
happyIn49 :: ([CIdent]) -> (HappyAbsSyn )
happyIn49 x = unsafeCoerce# x
{-# INLINE happyIn49 #-}
happyOut49 :: (HappyAbsSyn ) -> ([CIdent])
happyOut49 x = unsafeCoerce# x
{-# INLINE happyOut49 #-}
happyIn50 :: ([Assign]) -> (HappyAbsSyn )
happyIn50 x = unsafeCoerce# x
{-# INLINE happyIn50 #-}
happyOut50 :: (HappyAbsSyn ) -> ([Assign])
happyOut50 x = unsafeCoerce# x
{-# INLINE happyOut50 #-}
happyIn51 :: ([ArgVar]) -> (HappyAbsSyn )
happyIn51 x = unsafeCoerce# x
{-# INLINE happyIn51 #-}
happyOut51 :: (HappyAbsSyn ) -> ([ArgVar])
happyOut51 x = unsafeCoerce# x
{-# INLINE happyOut51 #-}
happyIn52 :: ([Labelling]) -> (HappyAbsSyn )
happyIn52 x = unsafeCoerce# x
{-# INLINE happyIn52 #-}
happyOut52 :: (HappyAbsSyn ) -> ([Labelling])
happyOut52 x = unsafeCoerce# x
{-# INLINE happyOut52 #-}
happyIn53 :: ([Case]) -> (HappyAbsSyn )
happyIn53 x = unsafeCoerce# x
{-# INLINE happyIn53 #-}
happyOut53 :: (HappyAbsSyn ) -> ([Case])
happyOut53 x = unsafeCoerce# x
{-# INLINE happyOut53 #-}
happyIn54 :: ([Term]) -> (HappyAbsSyn )
happyIn54 x = unsafeCoerce# x
{-# INLINE happyIn54 #-}
happyOut54 :: (HappyAbsSyn ) -> ([Term])
happyOut54 x = unsafeCoerce# x
{-# INLINE happyOut54 #-}
happyIn55 :: ([String]) -> (HappyAbsSyn )
happyIn55 x = unsafeCoerce# x
{-# INLINE happyIn55 #-}
happyOut55 :: (HappyAbsSyn ) -> ([String])
happyOut55 x = unsafeCoerce# x
{-# INLINE happyOut55 #-}
happyIn56 :: ([Variant]) -> (HappyAbsSyn )
happyIn56 x = unsafeCoerce# x
{-# INLINE happyIn56 #-}
happyOut56 :: (HappyAbsSyn ) -> ([Variant])
happyOut56 x = unsafeCoerce# x
{-# INLINE happyOut56 #-}
happyIn57 :: ([PattAssign]) -> (HappyAbsSyn )
happyIn57 x = unsafeCoerce# x
{-# INLINE happyIn57 #-}
happyOut57 :: (HappyAbsSyn ) -> ([PattAssign])
happyOut57 x = unsafeCoerce# x
{-# INLINE happyOut57 #-}
happyIn58 :: ([Patt]) -> (HappyAbsSyn )
happyIn58 x = unsafeCoerce# x
{-# INLINE happyIn58 #-}
happyOut58 :: (HappyAbsSyn ) -> ([Patt])
happyOut58 x = unsafeCoerce# x
{-# INLINE happyOut58 #-}
happyIn59 :: ([Ident]) -> (HappyAbsSyn )
happyIn59 x = unsafeCoerce# x
{-# INLINE happyIn59 #-}
happyOut59 :: (HappyAbsSyn ) -> ([Ident])
happyOut59 x = unsafeCoerce# x
{-# INLINE happyOut59 #-}
happyInTok :: Token -> (HappyAbsSyn )
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x74\x02\xa7\x00\x6e\x02\x00\x00\x6c\x02\x66\x02\x89\x02\x88\x02\x84\x02\x00\x00\x62\x02\x62\x02\x62\x02\x62\x02\x62\x02\x62\x02\x62\x02\x62\x02\x62\x02\x62\x02\x62\x02\x62\x02\x52\x02\x21\x02\x60\x02\x6d\x02\x5e\x02\x00\x00\x82\x02\x5b\x02\xdb\x00\x00\x00\x80\x02\x7e\x02\x7d\x02\x79\x02\x59\x02\x78\x02\x7a\x02\x58\x02\x73\x02\x00\x00\x00\x00\x00\x00\x28\x00\x53\x02\x00\x00\x46\x02\x51\x02\x72\x02\x44\x02\x44\x02\x44\x02\x8b\x00\x44\x02\x44\x02\x9b\x00\x9b\x00\x44\x02\x8b\x00\x44\x02\x71\x02\x28\x00\x42\x02\x42\x02\x00\x00\x70\x02\x4b\x02\x6a\x02\x64\x02\x00\x00\x00\x00\x00\x00\xdf\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x38\x02\x8b\x00\x38\x02\x38\x02\x3f\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x55\x02\x00\x00\x00\x00\x6b\x02\xf7\xff\x9b\x00\x39\x02\x00\x00\x69\x02\x68\x02\x67\x02\x65\x02\x00\x00\x00\x00\x61\x02\x5c\x02\x63\x02\x00\x00\x5f\x02\x30\x02\x00\x00\x3e\x02\x00\x00\x2f\x02\x5d\x02\x8b\x00\x8b\x00\x00\x00\x54\x02\x12\x00\x00\x00\x4a\x02\x00\x00\x5a\x02\x57\x02\x56\x02\x26\x02\x12\x00\x27\x02\x9b\x00\x00\x00\x00\x00\x47\x02\xd7\x00\x48\x02\x50\x02\x4d\x02\x00\x00\x8b\x00\x23\x02\x23\x02\x4f\x02\x00\x00\x21\x02\x00\x00\x00\x00\x00\x00\x4e\x02\x7e\x00\x00\x00\x8b\x00\x00\x00\x8b\x00\x00\x00\x00\x00\x00\x00\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x40\x02\x36\x02\x33\x02\x00\x00\x00\x00\xf7\xff\xfe\xff\x12\x00\x16\x02\x16\x02\x9b\x00\x43\x02\x00\x00\x00\x00\x00\x00\x9b\x00\xf7\xff\x9b\x00\xba\x00\x14\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x14\x02\x66\x00\x2a\x02\x3d\x02\x12\x00\x12\x00\x35\x02\x00\x00\x00\x00\x00\x00\xb7\x00\x00\x00\x00\x00\x07\x00\x00\x00\x00\x00\x3c\x02\x2c\x02\x29\x02\x5f\x00\xf7\xff\x0d\x02\x0d\x02\x1e\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8b\x00\xfb\x01\x00\x00\x00\x00\x08\x02\x28\x02\xb4\x00\x00\x00\x00\x00\x22\x02\x0c\x02\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\xf7\xff\x1a\x00\x00\x00\x55\x00\x10\x02\x00\x00\x4f\x00\x00\x00\xff\x01\xfc\x01\x12\x00\xe1\x01\x00\x00\x00\x00\xac\x00\x00\x00\x00\x00\x1d\x00\x0f\x02\x0a\x02\x65\x00\x00\x00\x00\x00\x6f\x00\x00\x00\xfa\x01\xd6\x01\x8b\x00\xda\x00\xf9\x01\x00\x00\xc8\x01\x00\x00\xf6\x01\x00\x00\x00\x00\x00\x00\x00\x00\xf4\x01\x59\x00\xf3\x01\x00\x00\x00\x00\x00\x00\x00\x00\xf7\xff\xc5\x01\x00\x00\x12\x00\x00\x00\xf0\x01\x00\x00\x12\x00\xc9\x01\x00\x00\xc9\x01\x00\x00\xdd\x01\xdc\x01\xd8\x01\xd1\x01\x00\x00\x37\x00\x00\x00\xa9\x01\x00\x00\x00\x00\xf7\xff\x16\x00\x48\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x9c\x00\x5d\x01\x00\x00\x00\x00\xb7\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc4\x01\xc2\x01\xc1\x01\xbc\x01\xb1\x01\x06\x00\xb0\x01\xa8\x01\xa4\x01\x8f\x01\x8e\x01\x8c\x01\x00\x00\x6e\x00\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x87\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x86\x01\x72\x01\x00\x00\x9f\x00\x7b\x01\x70\x01\x25\x02\x65\x01\xe0\x01\x36\x01\x19\x01\xa6\x00\x20\x02\x52\x01\x00\x00\x01\x00\x40\x01\x04\x00\x00\x00\x00\x00\x35\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3a\x02\x00\x00\x00\x00\x00\x00\x00\x00\x26\x01\x3c\x01\x0b\x02\xc6\x01\x3b\x01\x38\x01\x00\x00\x00\x00\x00\x00\x00\x00\x0d\x01\x00\x00\x00\x00\x00\x00\x00\x00\x7f\x00\x18\x01\x33\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x8f\x00\x00\x00\x06\x02\xf1\x01\x00\x00\x00\x00\x7e\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1e\x01\x6b\x01\x6a\x00\x17\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\xff\x00\x00\xec\x01\x1f\x01\x1d\x01\x00\x00\x14\x01\x6e\x00\xf3\x00\x00\x00\x00\x00\x00\x00\xab\x01\x00\x00\xd7\x01\x00\x00\xd2\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc8\x00\x00\x00\x58\x01\xb4\x01\xfd\x00\xf9\x00\x00\x00\x00\x00\x00\x00\x00\x00\xef\x00\x0f\x00\x0c\x00\x00\x00\x35\x00\x00\x00\x00\x00\xc7\x00\x00\x00\x00\x00\xa6\x01\x00\x00\x00\x00\x00\x00\x54\x01\x82\x01\x00\x00\x00\x00\x00\x00\xc1\x00\x00\x00\x00\x00\xa8\x00\x00\x00\x00\x00\x90\x00\x00\x00\x00\x00\x00\x00\x96\x01\x0e\x00\xe8\x00\xd3\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbd\x01\x37\x01\x00\x00\x00\x00\x51\x00\x00\x00\x03\x01\x93\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x41\x01\xc0\x00\xa1\x00\x00\x00\x92\x01\x3a\x01\x5c\x00\x92\x01\x00\x00\x00\x00\x00\x00\x2e\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x92\x01\x00\x00\x00\x00\xff\x00\x00\x00\x00\x00\x77\x01\x00\x00\x00\x00\x74\x00\xb8\x01\xab\x01\x00\x00\x00\x00\x6c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x47\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x10\x00\x00\x00\x2a\x01\x00\x00\x3d\x00\x00\x00\x04\x01\x00\x00\x00\x00\x00\x00\xe2\xff\x00\x00\x00\x00\x00\x00\x00\x00\xe0\xff\x91\x00\x00\x00\x17\x00\x00\x00\x00\x00\x09\x00\xf8\x00\xf4\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xed\xff\x00\x00\x00\x00\xfd\xff\xdc\xff\x00\x00\x00\x00\x00\x00\x00\x00\xf3\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6f\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf8\xff\x6f\xff\x6e\xff\x00\x00\xec\xff\x00\x00\x00\x00\x00\x00\xef\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf1\xff\xf4\xff\xf5\xff\xea\xff\x00\x00\xdd\xff\x00\x00\xe8\xff\x00\x00\xc9\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8e\xff\x00\x00\x00\x00\x00\x00\xea\xff\x00\x00\x6f\xff\x6d\xff\x00\x00\xe8\xff\x00\x00\x00\x00\xbe\xff\xbd\xff\xc2\xff\xd5\xff\xe4\xff\xd9\xff\xbc\xff\xd4\xff\xc4\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd1\xff\xd3\xff\xfc\xff\xfb\xff\x8b\xff\x8d\xff\xe3\xff\xb8\xff\x00\x00\x81\xff\x00\x00\x00\x00\xb7\xff\x00\x00\x00\x00\x00\x00\x00\x00\xe7\xff\xf0\xff\x00\x00\x00\x00\xc8\xff\xeb\xff\x00\x00\x6f\xff\xdf\xff\x00\x00\xf6\xff\xc9\xff\x00\x00\x00\x00\x00\x00\xf7\xff\x00\x00\x00\x00\xb6\xff\x00\x00\x9d\xff\x80\xff\x00\x00\x00\x00\x00\x00\x00\x00\x8e\xff\xde\xff\xbf\xff\xc0\xff\x00\x00\x00\x00\x00\x00\x00\x00\xc6\xff\xda\xff\x00\x00\x00\x00\x00\x00\x00\x00\xed\xff\xf9\xff\x92\xff\xee\xff\xdb\xff\x00\x00\x00\x00\xd6\xff\x00\x00\xd2\xff\x00\x00\xc1\xff\x8a\xff\x8c\xff\x00\x00\xa2\xff\xaf\xff\xae\xff\xb3\xff\xa5\xff\xa3\xff\xe2\xff\xad\xff\xb4\xff\x87\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfa\xff\x9c\xff\xba\xff\x00\x00\x81\xff\x00\x00\x00\x00\x84\xff\xe5\xff\xbb\xff\x89\xff\xc7\xff\xe9\xff\xe6\xff\x00\x00\x83\xff\x00\x00\x00\x00\x00\x00\x00\x00\x7f\xff\xb5\xff\x7b\xff\x00\x00\xb1\xff\x7b\xff\x00\x00\xac\xff\x79\xff\x86\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd7\xff\xce\xff\xcd\xff\xcc\xff\xcb\xff\xc5\xff\x00\x00\x00\x00\xca\xff\xc3\xff\x90\xff\x00\x00\x00\x00\xc6\xff\xd0\xff\x00\x00\x00\x00\x9b\xff\xaa\xff\xa7\xff\xb0\xff\x00\x00\x87\xff\x00\x00\xab\xff\x00\x00\x71\xff\x7b\xff\x00\x00\xb9\xff\xa4\xff\xe1\xff\x00\x00\x84\xff\x88\xff\x82\xff\x00\x00\x7a\xff\xa6\xff\x00\x00\x7d\xff\x00\x00\x00\x00\xb2\xff\x78\xff\x77\xff\x85\xff\xa0\xff\x00\x00\x00\x00\x00\x00\x00\x00\xf2\xff\x00\x00\x91\xff\x00\x00\x8f\xff\xcf\xff\xd8\xff\x9a\xff\x76\xff\x00\x00\x00\x00\x98\xff\x95\xff\x94\xff\x70\xff\x74\xff\x00\x00\x97\xff\x00\x00\xa9\xff\x71\xff\xa8\xff\x00\x00\xe0\xff\x7c\xff\x9f\xff\x71\xff\x00\x00\x73\xff\x00\x00\x00\x00\x79\xff\x77\xff\x75\xff\x9e\xff\xa1\xff\x96\xff\x74\xff\x00\x00\x00\x00\x99\xff\x93\xff\x72\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x09\x00\x11\x00\x00\x00\x09\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x32\x00\x14\x00\x0d\x00\x03\x00\x17\x00\x35\x00\x01\x00\x03\x00\x08\x00\x0f\x00\x15\x00\x03\x00\x0c\x00\x0f\x00\x03\x00\x0f\x00\x0c\x00\x11\x00\x0e\x00\x08\x00\x09\x00\x1b\x00\x31\x00\x0c\x00\x2c\x00\x1c\x00\x0f\x00\x24\x00\x11\x00\x07\x00\x27\x00\x24\x00\x24\x00\x24\x00\x27\x00\x00\x00\x25\x00\x36\x00\x36\x00\x36\x00\x36\x00\x36\x00\x36\x00\x34\x00\x2f\x00\x2e\x00\x2e\x00\x34\x00\x30\x00\x31\x00\x32\x00\x33\x00\x34\x00\x31\x00\x01\x00\x33\x00\x34\x00\x03\x00\x32\x00\x16\x00\x31\x00\x32\x00\x33\x00\x34\x00\x03\x00\x04\x00\x0c\x00\x0d\x00\x0e\x00\x08\x00\x03\x00\x31\x00\x25\x00\x0c\x00\x0b\x00\x08\x00\x0f\x00\x22\x00\x11\x00\x0c\x00\x03\x00\x2e\x00\x0f\x00\x10\x00\x11\x00\x08\x00\x03\x00\x32\x00\x00\x00\x0c\x00\x00\x00\x30\x00\x0f\x00\x16\x00\x11\x00\x0c\x00\x35\x00\x0e\x00\x06\x00\x07\x00\x02\x00\x0d\x00\x13\x00\x31\x00\x29\x00\x33\x00\x34\x00\x17\x00\x18\x00\x00\x00\x31\x00\x32\x00\x33\x00\x34\x00\x06\x00\x16\x00\x31\x00\x32\x00\x33\x00\x34\x00\x0c\x00\x32\x00\x0e\x00\x31\x00\x03\x00\x00\x00\x31\x00\x32\x00\x33\x00\x34\x00\x2a\x00\x0a\x00\x31\x00\x0c\x00\x33\x00\x34\x00\x0f\x00\x1c\x00\x11\x00\x12\x00\x03\x00\x00\x00\x04\x00\x32\x00\x01\x00\x24\x00\x08\x00\x16\x00\x00\x00\x0c\x00\x1d\x00\x1a\x00\x17\x00\x04\x00\x21\x00\x01\x00\x2f\x00\x31\x00\x32\x00\x33\x00\x34\x00\x0d\x00\x23\x00\x16\x00\x1b\x00\x1c\x00\x04\x00\x1a\x00\x03\x00\x01\x00\x31\x00\x32\x00\x33\x00\x08\x00\x00\x00\x15\x00\x32\x00\x32\x00\x33\x00\x1e\x00\x1f\x00\x20\x00\x00\x00\x22\x00\x23\x00\x24\x00\x31\x00\x26\x00\x27\x00\x15\x00\x2a\x00\x2a\x00\x2b\x00\x1f\x00\x2d\x00\x02\x00\x2f\x00\x23\x00\x31\x00\x31\x00\x26\x00\x27\x00\x05\x00\x02\x00\x2a\x00\x2b\x00\x05\x00\x21\x00\x0b\x00\x2f\x00\x24\x00\x31\x00\x0c\x00\x0d\x00\x0e\x00\x21\x00\x02\x00\x0c\x00\x24\x00\x2d\x00\x0f\x00\x00\x00\x11\x00\x12\x00\x31\x00\x2c\x00\x00\x00\x2d\x00\x02\x00\x03\x00\x00\x00\x00\x00\x02\x00\x03\x00\x1d\x00\x00\x00\x0f\x00\x00\x00\x21\x00\x02\x00\x03\x00\x00\x00\x00\x00\x01\x00\x02\x00\x03\x00\x0f\x00\x0b\x00\x1b\x00\x31\x00\x32\x00\x33\x00\x34\x00\x0c\x00\x31\x00\x32\x00\x33\x00\x0f\x00\x1b\x00\x17\x00\x18\x00\x00\x00\x00\x00\x00\x00\x26\x00\x28\x00\x08\x00\x00\x00\x26\x00\x00\x00\x02\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x26\x00\x0f\x00\x0f\x00\x0f\x00\x25\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x1b\x00\x1b\x00\x1b\x00\x02\x00\x00\x00\x00\x00\x2b\x00\x0f\x00\x02\x00\x00\x00\x00\x00\x0f\x00\x18\x00\x0a\x00\x00\x00\x00\x00\x01\x00\x02\x00\x03\x00\x0f\x00\x0f\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x25\x00\x0f\x00\x1b\x00\x00\x00\x25\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x22\x00\x00\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x05\x00\x0f\x00\x07\x00\x00\x00\x25\x00\x0f\x00\x0b\x00\x0c\x00\x30\x00\x00\x00\x01\x00\x02\x00\x03\x00\x35\x00\x00\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x25\x00\x0f\x00\x00\x00\x0a\x00\x25\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x00\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x00\x00\x0f\x00\x00\x00\x00\x00\x25\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x23\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x1d\x00\x1e\x00\x0f\x00\x20\x00\x25\x00\x00\x00\x0f\x00\x00\x00\x25\x00\x00\x00\x32\x00\x33\x00\x00\x00\x01\x00\x02\x00\x03\x00\x1d\x00\x00\x00\x00\x00\x20\x00\x1d\x00\x00\x00\x0f\x00\x20\x00\x25\x00\x00\x00\x01\x00\x02\x00\x25\x00\x00\x00\x00\x00\x01\x00\x02\x00\x15\x00\x00\x00\x00\x00\x0f\x00\x00\x00\x0e\x00\x00\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x19\x00\x00\x00\x01\x00\x02\x00\x0f\x00\x19\x00\x00\x00\x01\x00\x02\x00\x09\x00\x32\x00\x04\x00\x01\x00\x15\x00\x02\x00\x00\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x19\x00\x00\x00\x01\x00\x02\x00\x0f\x00\x19\x00\x00\x00\x01\x00\x02\x00\x04\x00\x01\x00\x31\x00\x04\x00\x02\x00\x31\x00\x01\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x19\x00\x00\x00\x01\x00\x02\x00\x33\x00\x19\x00\x00\x00\x01\x00\x02\x00\x04\x00\x15\x00\x01\x00\x15\x00\x31\x00\x14\x00\x04\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x19\x00\x00\x00\x01\x00\x02\x00\x17\x00\x19\x00\x00\x00\x01\x00\x02\x00\x06\x00\x01\x00\x22\x00\x0d\x00\x31\x00\x04\x00\x02\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x19\x00\x00\x00\x01\x00\x02\x00\x01\x00\x19\x00\x1e\x00\x33\x00\x20\x00\x0d\x00\x06\x00\x1a\x00\x31\x00\x03\x00\x31\x00\x15\x00\x0f\x00\x14\x00\x0b\x00\x12\x00\x13\x00\x2d\x00\x01\x00\x2f\x00\x04\x00\x03\x00\x19\x00\x31\x00\x0d\x00\x06\x00\x10\x00\x31\x00\x33\x00\x04\x00\x01\x00\x05\x00\x13\x00\x0a\x00\x02\x00\x31\x00\x31\x00\x03\x00\x25\x00\x01\x00\x09\x00\x05\x00\x02\x00\x01\x00\x31\x00\x02\x00\x02\x00\x33\x00\x02\x00\x19\x00\x0b\x00\x06\x00\x01\x00\x33\x00\x31\x00\x29\x00\x31\x00\x05\x00\x31\x00\x25\x00\x07\x00\x29\x00\x08\x00\x02\x00\x05\x00\x05\x00\x02\x00\x28\x00\x28\x00\x02\x00\x05\x00\x02\x00\x01\x00\x28\x00\x1a\x00\x36\x00\x01\x00\xff\xff\x02\x00\x31\x00\x21\x00\xff\xff\xff\xff\xff\xff\x31\x00\xff\xff\x31\x00\xff\xff\xff\xff\xff\xff\xff\xff\x24\x00\xff\xff\xff\xff\xff\xff\x36\x00\xff\xff\xff\xff\x31\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x19\x00\x19\x00\x19\x00\x19\x00\x19\x00\x19\x00\xc8\x00\x7e\x00\x79\x00\x43\x00\x30\x00\x45\x00\x79\x00\x79\x00\x79\x00\x45\x00\xba\x00\x27\x01\x92\x00\xea\x00\xa6\x00\x93\x00\x2c\x01\xfd\x00\x15\x01\xa7\x00\x5b\x00\xbf\x00\xff\x00\xa8\x00\x1f\x01\xa6\x00\xa9\x00\x16\x01\xaa\x00\x17\x01\xa7\x00\x1b\x01\xbf\x00\x04\x00\xa8\x00\xc9\x00\x7a\x00\xa9\x00\x20\x01\xaa\x00\x6f\xff\x21\x01\x20\x01\xe3\x00\x7b\x00\x21\x01\xba\x00\xbb\x00\x31\x00\x31\x00\x6e\x00\x41\x00\x1a\x00\x24\x00\x2f\x01\xc0\x00\xf4\x00\xab\x00\x22\x01\xac\x00\x04\x00\x57\x00\x58\x00\xad\x00\x04\x00\xfd\x00\x58\x00\xad\x00\x15\x01\x57\x00\x79\xff\x04\x00\x57\x00\x58\x00\xad\x00\xa6\x00\xf8\x00\x16\x01\x2e\x01\x17\x01\xa7\x00\xa6\x00\x04\x00\xbb\x00\xa8\x00\xdc\x00\xa7\x00\xa9\x00\xf9\x00\xaa\x00\xa8\x00\xa6\x00\xbc\x00\xa9\x00\xfd\x00\xaa\x00\xa7\x00\x15\x01\x79\xff\x58\x00\xa8\x00\x08\x01\x1d\x01\xa9\x00\x25\x01\xaa\x00\x16\x01\xfb\x00\x17\x01\x1b\x00\x1c\x00\x0c\x01\x59\x00\x18\x01\x04\x00\xdd\x00\x58\x00\xad\x00\xcf\x00\xd0\x00\x79\x00\x04\x00\x57\x00\x58\x00\xad\x00\xd8\x00\x79\xff\x04\x00\x57\x00\x58\x00\xad\x00\xd9\x00\x57\x00\xda\x00\xf8\x00\x4f\x00\x67\x00\x04\x00\x57\x00\x58\x00\xad\x00\x9a\x00\x50\x00\x04\x00\x51\x00\x58\x00\xad\x00\x52\x00\x7a\x00\x53\x00\x54\x00\x5e\x00\x67\x00\x16\x00\x79\xff\xfd\x00\x7b\x00\x17\x00\xb7\x00\x58\x00\x5f\x00\x55\x00\x69\x00\x03\x01\x0a\x00\x56\x00\x1c\x01\x7c\x00\x04\x00\x57\x00\x58\x00\xad\x00\x59\x00\x0d\x01\x68\x00\x60\x00\x61\x00\x06\x01\x69\x00\xec\x00\xbe\x00\x04\x00\x57\x00\x58\x00\xed\x00\x79\x00\xbf\x00\xe8\x00\x0e\x01\x26\x01\x0b\x00\x0c\x00\x0d\x00\x79\x00\x0e\x00\x0f\x00\x10\x00\x04\x00\x11\x00\x12\x00\xbf\x00\x5a\x00\x13\x00\x14\x00\x0c\x00\x15\x00\xe1\x00\x16\x00\x0f\x00\x04\x00\xea\x00\x11\x00\x12\x00\x98\x00\x3c\x00\x13\x00\x14\x00\x3d\x00\xc9\x00\x8b\x00\x07\x01\xca\x00\x04\x00\xd9\x00\x0b\x01\xda\x00\xc9\x00\xe2\x00\x8a\x00\xca\x00\xff\x00\x52\x00\x45\x00\x53\x00\x54\x00\xed\x00\xb9\x00\x10\x01\xcb\x00\x11\x01\x12\x01\x10\x01\x45\x00\x11\x01\x12\x01\x55\x00\xc4\x00\x5b\x00\x10\x01\x56\x00\x11\x01\x12\x01\x04\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\x5b\x00\x8b\x00\xc1\x00\x04\x00\x57\x00\x58\x00\xad\x00\x04\x01\x04\x00\x57\x00\x58\x00\x9f\x00\xc3\x00\xcf\x00\xd0\x00\x45\x00\x45\x00\x45\x00\x13\x01\xdb\x00\x8e\x00\x90\x00\x2e\x01\x91\x00\xad\x00\xa0\x00\xa1\x00\x1c\x01\xa3\x00\x13\x01\x5b\x00\x5b\x00\x5b\x00\xa4\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\x99\x00\x78\x00\x5c\x00\x77\x00\x45\x00\x45\x00\x80\x00\x9f\x00\x81\x00\x82\x00\x86\x00\x9f\x00\x87\x00\x8c\x00\x42\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\x5b\x00\xde\x00\xa0\x00\xa1\x00\x1e\x01\xa3\x00\xa0\x00\xa1\x00\xf5\x00\xa3\x00\xa4\x00\x9f\x00\x61\x00\x44\x00\xa4\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\xf9\x00\x04\x00\xa0\x00\xa1\x00\x00\x01\xa3\x00\x05\x00\x9f\x00\x06\x00\x63\x00\xa4\x00\x9f\x00\x07\x00\x08\x00\xfa\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\xfb\x00\x65\x00\xa0\x00\xa1\x00\xf0\x00\xa3\x00\xa0\x00\xa1\x00\xc6\x00\xa3\x00\xa4\x00\x9f\x00\x66\x00\x6b\x00\xa4\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\x6d\x00\x3d\x00\xa0\x00\xa1\x00\xa2\x00\xa3\x00\x1e\x00\x9f\x00\x1f\x00\x20\x00\xa4\x00\x9f\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\x9b\x00\x9c\x00\x9d\x00\x9e\x00\x0d\x01\xa0\x00\xa1\x00\xb2\x00\xa3\x00\xa0\x00\xef\x00\x9f\x00\xa3\x00\xa4\x00\x21\x00\x9f\x00\x45\x00\xa4\x00\x22\x00\x0e\x01\x0f\x01\xd2\x00\xd3\x00\xd4\x00\xd5\x00\xf6\x00\x23\x00\x25\x00\xa3\x00\xe4\x00\x45\x00\xf3\x00\xa3\x00\xa4\x00\x45\x00\x46\x00\x47\x00\xa4\x00\x26\x00\x45\x00\x46\x00\x47\x00\xd6\x00\x27\x00\x28\x00\xc5\x00\x29\x00\x2d\x00\x45\x00\x48\x00\x49\x00\x0b\x01\x4b\x00\x4c\x00\x48\x00\x49\x00\xdf\x00\x4b\x00\x4c\x00\x4d\x00\x45\x00\x46\x00\x47\x00\x83\x00\x4d\x00\x45\x00\x46\x00\x47\x00\x29\x01\x57\x00\x2a\x01\x2b\x01\xbf\x00\x2c\x01\x45\x00\x48\x00\x49\x00\xd0\x00\x4b\x00\x4c\x00\x48\x00\x49\x00\xd1\x00\x4b\x00\x4c\x00\x4d\x00\x45\x00\x46\x00\x47\x00\x62\x00\x4d\x00\x45\x00\x46\x00\x47\x00\x7e\xff\x26\x01\x04\x00\x24\x01\x3c\x00\x04\x00\x0a\x01\x48\x00\x49\x00\x85\x00\x4b\x00\x4c\x00\x48\x00\x49\x00\xb4\x00\x4b\x00\x4c\x00\x4d\x00\x45\x00\x46\x00\x47\x00\x58\x00\x4d\x00\x84\x00\x46\x00\x47\x00\x19\x01\xbf\x00\x1a\x01\xbf\x00\x04\x00\xcd\x00\x7e\xff\x48\x00\x49\x00\xb5\x00\x4b\x00\x4c\x00\x48\x00\x49\x00\x85\x00\x4b\x00\x4c\x00\x4d\x00\x45\x00\x46\x00\x47\x00\x02\x01\x4d\x00\x45\x00\x46\x00\x47\x00\x03\x01\x08\x01\x0e\x00\xe1\x00\x04\x00\xe6\x00\xe7\x00\x48\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x48\x00\x49\x00\x64\x00\x4b\x00\x4c\x00\x4d\x00\x45\x00\x46\x00\x47\x00\xe8\x00\x4d\x00\x0b\x00\x58\x00\x0d\x00\xef\x00\xf2\x00\xf3\x00\x04\x00\xc3\x00\x04\x00\xbf\x00\x48\x00\xcd\x00\xce\x00\x88\x00\x4c\x00\x15\x00\xdb\x00\x1e\x00\x95\x00\x90\x00\x4d\x00\x04\x00\x97\x00\x96\x00\x99\x00\x04\x00\x58\x00\xaf\x00\xb1\x00\xb0\x00\xb2\x00\xb4\x00\xb7\x00\x04\x00\x04\x00\x70\x00\xb9\x00\x71\x00\x72\x00\x73\x00\x74\x00\x75\x00\x04\x00\x76\x00\x77\x00\x58\x00\x7f\x00\x80\x00\x8b\x00\x8c\x00\x8e\x00\x58\x00\x04\x00\x6d\x00\x04\x00\x3d\x00\x04\x00\x30\x00\x6b\x00\x6d\x00\x33\x00\x35\x00\x36\x00\x38\x00\x39\x00\x34\x00\x37\x00\x3b\x00\x3a\x00\x3f\x00\x2b\x00\x40\x00\x41\x00\xff\xff\x2c\x00\x00\x00\x2d\x00\x04\x00\x2f\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x19\x00\x00\x00\x00\x00\x00\x00\xff\xff\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (2, 146) [
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
	(142 , happyReduce_142),
	(143 , happyReduce_143),
	(144 , happyReduce_144),
	(145 , happyReduce_145),
	(146 , happyReduce_146)
	]

happy_n_terms = 55 :: Int
happy_n_nonterms = 55 :: Int

happyReduce_2 = happySpecReduce_1 0# happyReduction_2
happyReduction_2 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TV happy_var_1)) -> 
	happyIn5
		 (identC happy_var_1 --H
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

happyReduce_5 = happySpecReduce_1 3# happyReduction_5
happyReduction_5 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TD happy_var_1)) -> 
	happyIn8
		 ((read happy_var_1) :: Double
	)}

happyReduce_6 = happyReduce 6# 4# happyReduction_6
happyReduction_6 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut59 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	case happyOut13 happy_x_6 of { happy_var_6 -> 
	happyIn9
		 (MGr happy_var_2 happy_var_4 (reverse happy_var_6)
	) `HappyStk` happyRest}}}

happyReduce_7 = happySpecReduce_1 4# happyReduction_7
happyReduction_7 happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	happyIn9
		 (Gr (reverse happy_var_1)
	)}

happyReduce_8 = happyReduce 5# 5# happyReduction_8
happyReduction_8 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut59 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	happyIn10
		 (LMulti happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_9 = happyReduce 5# 5# happyReduction_9
happyReduction_9 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut12 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_3 of { happy_var_3 -> 
	case happyOut15 happy_x_4 of { happy_var_4 -> 
	happyIn10
		 (LHeader happy_var_1 happy_var_3 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_10 = happySpecReduce_2 5# happyReduction_10
happyReduction_10 happy_x_2
	happy_x_1
	 =  case happyOut16 happy_x_1 of { happy_var_1 -> 
	happyIn10
		 (LFlag happy_var_1
	)}

happyReduce_11 = happySpecReduce_2 5# happyReduction_11
happyReduction_11 happy_x_2
	happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn10
		 (LDef happy_var_1
	)}

happyReduce_12 = happySpecReduce_1 5# happyReduction_12
happyReduction_12 happy_x_1
	 =  happyIn10
		 (LEnd
	)

happyReduce_13 = happyReduce 8# 6# happyReduction_13
happyReduction_13 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut12 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_3 of { happy_var_3 -> 
	case happyOut15 happy_x_4 of { happy_var_4 -> 
	case happyOut45 happy_x_6 of { happy_var_6 -> 
	case happyOut46 happy_x_7 of { happy_var_7 -> 
	happyIn11
		 (Mod happy_var_1 happy_var_3 happy_var_4 (reverse happy_var_6) (reverse happy_var_7)
	) `HappyStk` happyRest}}}}}

happyReduce_14 = happySpecReduce_2 7# happyReduction_14
happyReduction_14 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn12
		 (MTAbs happy_var_2
	)}

happyReduce_15 = happyReduce 4# 7# happyReduction_15
happyReduction_15 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	happyIn12
		 (MTCnc happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_16 = happySpecReduce_2 7# happyReduction_16
happyReduction_16 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn12
		 (MTRes happy_var_2
	)}

happyReduce_17 = happyReduce 6# 7# happyReduction_17
happyReduction_17 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	case happyOut5 happy_x_6 of { happy_var_6 -> 
	happyIn12
		 (MTTrans happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_18 = happySpecReduce_0 8# happyReduction_18
happyReduction_18  =  happyIn13
		 ([]
	)

happyReduce_19 = happySpecReduce_2 8# happyReduction_19
happyReduction_19 happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut11 happy_x_2 of { happy_var_2 -> 
	happyIn13
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_20 = happySpecReduce_2 9# happyReduction_20
happyReduction_20 happy_x_2
	happy_x_1
	 =  case happyOut59 happy_x_1 of { happy_var_1 -> 
	happyIn14
		 (Ext happy_var_1
	)}

happyReduce_21 = happySpecReduce_0 9# happyReduction_21
happyReduction_21  =  happyIn14
		 (NoExt
	)

happyReduce_22 = happySpecReduce_3 10# happyReduction_22
happyReduction_22 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut59 happy_x_2 of { happy_var_2 -> 
	happyIn15
		 (Opens happy_var_2
	)}

happyReduce_23 = happySpecReduce_0 10# happyReduction_23
happyReduction_23  =  happyIn15
		 (NoOpens
	)

happyReduce_24 = happyReduce 4# 11# happyReduction_24
happyReduction_24 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	happyIn16
		 (Flg happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_25 = happyReduce 7# 12# happyReduction_25
happyReduction_25 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut27 happy_x_4 of { happy_var_4 -> 
	case happyOut49 happy_x_7 of { happy_var_7 -> 
	happyIn17
		 (AbsDCat happy_var_2 happy_var_4 (reverse happy_var_7)
	) `HappyStk` happyRest}}}

happyReduce_26 = happyReduce 6# 12# happyReduction_26
happyReduction_26 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut22 happy_x_4 of { happy_var_4 -> 
	case happyOut22 happy_x_6 of { happy_var_6 -> 
	happyIn17
		 (AbsDFun happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_27 = happyReduce 4# 12# happyReduction_27
happyReduction_27 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut22 happy_x_4 of { happy_var_4 -> 
	happyIn17
		 (AbsDTrans happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_28 = happyReduce 4# 12# happyReduction_28
happyReduction_28 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut47 happy_x_4 of { happy_var_4 -> 
	happyIn17
		 (ResDPar happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_29 = happyReduce 6# 12# happyReduction_29
happyReduction_29 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut32 happy_x_4 of { happy_var_4 -> 
	case happyOut36 happy_x_6 of { happy_var_6 -> 
	happyIn17
		 (ResDOper happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_30 = happyReduce 8# 12# happyReduction_30
happyReduction_30 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut32 happy_x_4 of { happy_var_4 -> 
	case happyOut36 happy_x_6 of { happy_var_6 -> 
	case happyOut36 happy_x_8 of { happy_var_8 -> 
	happyIn17
		 (CncDCat happy_var_2 happy_var_4 happy_var_6 happy_var_8
	) `HappyStk` happyRest}}}}

happyReduce_31 = happyReduce 11# 12# happyReduction_31
happyReduction_31 (happy_x_11 `HappyStk`
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
	case happyOut20 happy_x_4 of { happy_var_4 -> 
	case happyOut51 happy_x_7 of { happy_var_7 -> 
	case happyOut36 happy_x_9 of { happy_var_9 -> 
	case happyOut36 happy_x_11 of { happy_var_11 -> 
	happyIn17
		 (CncDFun happy_var_2 happy_var_4 happy_var_7 happy_var_9 happy_var_11
	) `HappyStk` happyRest}}}}}

happyReduce_32 = happyReduce 4# 12# happyReduction_32
happyReduction_32 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_4 of { happy_var_4 -> 
	happyIn17
		 (AnyDInd happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_33 = happySpecReduce_2 13# happyReduction_33
happyReduction_33 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_2 of { happy_var_2 -> 
	happyIn18
		 (ParD happy_var_1 (reverse happy_var_2)
	)}}

happyReduce_34 = happySpecReduce_1 14# happyReduction_34
happyReduction_34 happy_x_1
	 =  happyIn19
		 (Canon
	)

happyReduce_35 = happySpecReduce_0 14# happyReduction_35
happyReduction_35  =  happyIn19
		 (NonCan
	)

happyReduce_36 = happySpecReduce_3 15# happyReduction_36
happyReduction_36 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut5 happy_x_3 of { happy_var_3 -> 
	happyIn20
		 (CIQ happy_var_1 happy_var_3
	)}}

happyReduce_37 = happySpecReduce_2 16# happyReduction_37
happyReduction_37 happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_2 of { happy_var_2 -> 
	happyIn21
		 (EApp happy_var_1 happy_var_2
	)}}

happyReduce_38 = happySpecReduce_1 16# happyReduction_38
happyReduction_38 happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn21
		 (happy_var_1
	)}

happyReduce_39 = happyReduce 7# 17# happyReduction_39
happyReduction_39 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut22 happy_x_4 of { happy_var_4 -> 
	case happyOut22 happy_x_7 of { happy_var_7 -> 
	happyIn22
		 (EProd happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_40 = happyReduce 4# 17# happyReduction_40
happyReduction_40 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut22 happy_x_4 of { happy_var_4 -> 
	happyIn22
		 (EAbs happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_41 = happySpecReduce_3 17# happyReduction_41
happyReduction_41 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_2 of { happy_var_2 -> 
	happyIn22
		 (EEq (reverse happy_var_2)
	)}

happyReduce_42 = happySpecReduce_1 17# happyReduction_42
happyReduction_42 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn22
		 (happy_var_1
	)}

happyReduce_43 = happySpecReduce_1 18# happyReduction_43
happyReduction_43 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn23
		 (EAtom happy_var_1
	)}

happyReduce_44 = happySpecReduce_1 18# happyReduction_44
happyReduction_44 happy_x_1
	 =  happyIn23
		 (EData
	)

happyReduce_45 = happySpecReduce_3 18# happyReduction_45
happyReduction_45 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_2 of { happy_var_2 -> 
	happyIn23
		 (happy_var_2
	)}

happyReduce_46 = happySpecReduce_1 19# happyReduction_46
happyReduction_46 happy_x_1
	 =  happyIn24
		 (SType
	)

happyReduce_47 = happySpecReduce_3 20# happyReduction_47
happyReduction_47 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_3 of { happy_var_3 -> 
	happyIn25
		 (Equ (reverse happy_var_1) happy_var_3
	)}}

happyReduce_48 = happyReduce 4# 21# happyReduction_48
happyReduction_48 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut20 happy_x_2 of { happy_var_2 -> 
	case happyOut28 happy_x_3 of { happy_var_3 -> 
	happyIn26
		 (APC happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_49 = happySpecReduce_1 21# happyReduction_49
happyReduction_49 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 (APV happy_var_1
	)}

happyReduce_50 = happySpecReduce_1 21# happyReduction_50
happyReduction_50 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 (APS happy_var_1
	)}

happyReduce_51 = happySpecReduce_1 21# happyReduction_51
happyReduction_51 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 (API happy_var_1
	)}

happyReduce_52 = happySpecReduce_1 21# happyReduction_52
happyReduction_52 happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 (APF happy_var_1
	)}

happyReduce_53 = happySpecReduce_1 21# happyReduction_53
happyReduction_53 happy_x_1
	 =  happyIn26
		 (APW
	)

happyReduce_54 = happySpecReduce_0 22# happyReduction_54
happyReduction_54  =  happyIn27
		 ([]
	)

happyReduce_55 = happySpecReduce_1 22# happyReduction_55
happyReduction_55 happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 ((:[]) happy_var_1
	)}

happyReduce_56 = happySpecReduce_3 22# happyReduction_56
happyReduction_56 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	case happyOut27 happy_x_3 of { happy_var_3 -> 
	happyIn27
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_57 = happySpecReduce_0 23# happyReduction_57
happyReduction_57  =  happyIn28
		 ([]
	)

happyReduce_58 = happySpecReduce_2 23# happyReduction_58
happyReduction_58 happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_2 of { happy_var_2 -> 
	happyIn28
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_59 = happySpecReduce_0 24# happyReduction_59
happyReduction_59  =  happyIn29
		 ([]
	)

happyReduce_60 = happySpecReduce_3 24# happyReduction_60
happyReduction_60 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	case happyOut25 happy_x_2 of { happy_var_2 -> 
	happyIn29
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_61 = happySpecReduce_1 25# happyReduction_61
happyReduction_61 happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	happyIn30
		 (AC happy_var_1
	)}

happyReduce_62 = happySpecReduce_3 25# happyReduction_62
happyReduction_62 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut20 happy_x_2 of { happy_var_2 -> 
	happyIn30
		 (AD happy_var_2
	)}

happyReduce_63 = happySpecReduce_2 25# happyReduction_63
happyReduction_63 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn30
		 (AV happy_var_2
	)}

happyReduce_64 = happySpecReduce_2 25# happyReduction_64
happyReduction_64 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_2 of { happy_var_2 -> 
	happyIn30
		 (AM happy_var_2
	)}

happyReduce_65 = happySpecReduce_1 25# happyReduction_65
happyReduction_65 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn30
		 (AS happy_var_1
	)}

happyReduce_66 = happySpecReduce_1 25# happyReduction_66
happyReduction_66 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn30
		 (AI happy_var_1
	)}

happyReduce_67 = happySpecReduce_1 25# happyReduction_67
happyReduction_67 happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	happyIn30
		 (AT happy_var_1
	)}

happyReduce_68 = happySpecReduce_3 26# happyReduction_68
happyReduction_68 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_3 of { happy_var_3 -> 
	happyIn31
		 (Decl happy_var_1 happy_var_3
	)}}

happyReduce_69 = happySpecReduce_3 27# happyReduction_69
happyReduction_69 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut52 happy_x_2 of { happy_var_2 -> 
	happyIn32
		 (RecType happy_var_2
	)}

happyReduce_70 = happyReduce 5# 27# happyReduction_70
happyReduction_70 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut32 happy_x_2 of { happy_var_2 -> 
	case happyOut32 happy_x_4 of { happy_var_4 -> 
	happyIn32
		 (Table happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_71 = happySpecReduce_1 27# happyReduction_71
happyReduction_71 happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	happyIn32
		 (Cn happy_var_1
	)}

happyReduce_72 = happySpecReduce_1 27# happyReduction_72
happyReduction_72 happy_x_1
	 =  happyIn32
		 (TStr
	)

happyReduce_73 = happySpecReduce_2 27# happyReduction_73
happyReduction_73 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_2 of { happy_var_2 -> 
	happyIn32
		 (TInts happy_var_2
	)}

happyReduce_74 = happySpecReduce_3 28# happyReduction_74
happyReduction_74 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (Lbg happy_var_1 happy_var_3
	)}}

happyReduce_75 = happySpecReduce_1 29# happyReduction_75
happyReduction_75 happy_x_1
	 =  case happyOut42 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (Arg happy_var_1
	)}

happyReduce_76 = happySpecReduce_1 29# happyReduction_76
happyReduction_76 happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (I happy_var_1
	)}

happyReduce_77 = happyReduce 4# 29# happyReduction_77
happyReduction_77 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut20 happy_x_2 of { happy_var_2 -> 
	case happyOut54 happy_x_3 of { happy_var_3 -> 
	happyIn34
		 (Par happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_78 = happySpecReduce_2 29# happyReduction_78
happyReduction_78 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn34
		 (LI happy_var_2
	)}

happyReduce_79 = happySpecReduce_3 29# happyReduction_79
happyReduction_79 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut50 happy_x_2 of { happy_var_2 -> 
	happyIn34
		 (R happy_var_2
	)}

happyReduce_80 = happySpecReduce_1 29# happyReduction_80
happyReduction_80 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (EInt happy_var_1
	)}

happyReduce_81 = happySpecReduce_1 29# happyReduction_81
happyReduction_81 happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (EFloat happy_var_1
	)}

happyReduce_82 = happySpecReduce_1 29# happyReduction_82
happyReduction_82 happy_x_1
	 =  case happyOut37 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (K happy_var_1
	)}

happyReduce_83 = happySpecReduce_2 29# happyReduction_83
happyReduction_83 happy_x_2
	happy_x_1
	 =  happyIn34
		 (E
	)

happyReduce_84 = happySpecReduce_3 29# happyReduction_84
happyReduction_84 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_2 of { happy_var_2 -> 
	happyIn34
		 (happy_var_2
	)}

happyReduce_85 = happySpecReduce_3 30# happyReduction_85
happyReduction_85 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut41 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (P happy_var_1 happy_var_3
	)}}

happyReduce_86 = happyReduce 5# 30# happyReduction_86
happyReduction_86 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut32 happy_x_2 of { happy_var_2 -> 
	case happyOut53 happy_x_4 of { happy_var_4 -> 
	happyIn35
		 (T happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_87 = happyReduce 5# 30# happyReduction_87
happyReduction_87 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut32 happy_x_2 of { happy_var_2 -> 
	case happyOut54 happy_x_4 of { happy_var_4 -> 
	happyIn35
		 (V happy_var_2 (reverse happy_var_4)
	) `HappyStk` happyRest}}

happyReduce_88 = happySpecReduce_3 30# happyReduction_88
happyReduction_88 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (S happy_var_1 happy_var_3
	)}}

happyReduce_89 = happyReduce 4# 30# happyReduction_89
happyReduction_89 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut54 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (FV (reverse happy_var_3)
	) `HappyStk` happyRest}

happyReduce_90 = happySpecReduce_1 30# happyReduction_90
happyReduction_90 happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 (happy_var_1
	)}

happyReduce_91 = happySpecReduce_3 31# happyReduction_91
happyReduction_91 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 (C happy_var_1 happy_var_3
	)}}

happyReduce_92 = happySpecReduce_1 31# happyReduction_92
happyReduction_92 happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	happyIn36
		 (happy_var_1
	)}

happyReduce_93 = happySpecReduce_1 32# happyReduction_93
happyReduction_93 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn37
		 (KS happy_var_1
	)}

happyReduce_94 = happyReduce 7# 32# happyReduction_94
happyReduction_94 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut55 happy_x_3 of { happy_var_3 -> 
	case happyOut56 happy_x_5 of { happy_var_5 -> 
	happyIn37
		 (KP (reverse happy_var_3) happy_var_5
	) `HappyStk` happyRest}}

happyReduce_95 = happySpecReduce_3 33# happyReduction_95
happyReduction_95 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (Ass happy_var_1 happy_var_3
	)}}

happyReduce_96 = happySpecReduce_3 34# happyReduction_96
happyReduction_96 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut58 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	happyIn39
		 (Cas (reverse happy_var_1) happy_var_3
	)}}

happyReduce_97 = happySpecReduce_3 35# happyReduction_97
happyReduction_97 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut55 happy_x_3 of { happy_var_3 -> 
	happyIn40
		 (Var (reverse happy_var_1) (reverse happy_var_3)
	)}}

happyReduce_98 = happySpecReduce_1 36# happyReduction_98
happyReduction_98 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn41
		 (L happy_var_1
	)}

happyReduce_99 = happySpecReduce_2 36# happyReduction_99
happyReduction_99 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_2 of { happy_var_2 -> 
	happyIn41
		 (LV happy_var_2
	)}

happyReduce_100 = happySpecReduce_3 37# happyReduction_100
happyReduction_100 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut7 happy_x_3 of { happy_var_3 -> 
	happyIn42
		 (A happy_var_1 happy_var_3
	)}}

happyReduce_101 = happyReduce 5# 37# happyReduction_101
happyReduction_101 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut7 happy_x_3 of { happy_var_3 -> 
	case happyOut7 happy_x_5 of { happy_var_5 -> 
	happyIn42
		 (AB happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_102 = happyReduce 4# 38# happyReduction_102
happyReduction_102 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut20 happy_x_2 of { happy_var_2 -> 
	case happyOut58 happy_x_3 of { happy_var_3 -> 
	happyIn43
		 (PC happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_103 = happySpecReduce_1 38# happyReduction_103
happyReduction_103 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn43
		 (PV happy_var_1
	)}

happyReduce_104 = happySpecReduce_1 38# happyReduction_104
happyReduction_104 happy_x_1
	 =  happyIn43
		 (PW
	)

happyReduce_105 = happySpecReduce_3 38# happyReduction_105
happyReduction_105 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut57 happy_x_2 of { happy_var_2 -> 
	happyIn43
		 (PR happy_var_2
	)}

happyReduce_106 = happySpecReduce_1 38# happyReduction_106
happyReduction_106 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn43
		 (PI happy_var_1
	)}

happyReduce_107 = happySpecReduce_1 38# happyReduction_107
happyReduction_107 happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	happyIn43
		 (PF happy_var_1
	)}

happyReduce_108 = happySpecReduce_3 39# happyReduction_108
happyReduction_108 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut43 happy_x_3 of { happy_var_3 -> 
	happyIn44
		 (PAss happy_var_1 happy_var_3
	)}}

happyReduce_109 = happySpecReduce_0 40# happyReduction_109
happyReduction_109  =  happyIn45
		 ([]
	)

happyReduce_110 = happySpecReduce_3 40# happyReduction_110
happyReduction_110 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	case happyOut16 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_111 = happySpecReduce_0 41# happyReduction_111
happyReduction_111  =  happyIn46
		 ([]
	)

happyReduce_112 = happySpecReduce_3 41# happyReduction_112
happyReduction_112 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	case happyOut17 happy_x_2 of { happy_var_2 -> 
	happyIn46
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_113 = happySpecReduce_0 42# happyReduction_113
happyReduction_113  =  happyIn47
		 ([]
	)

happyReduce_114 = happySpecReduce_1 42# happyReduction_114
happyReduction_114 happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	happyIn47
		 ((:[]) happy_var_1
	)}

happyReduce_115 = happySpecReduce_3 42# happyReduction_115
happyReduction_115 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_3 of { happy_var_3 -> 
	happyIn47
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_116 = happySpecReduce_0 43# happyReduction_116
happyReduction_116  =  happyIn48
		 ([]
	)

happyReduce_117 = happySpecReduce_2 43# happyReduction_117
happyReduction_117 happy_x_2
	happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_2 of { happy_var_2 -> 
	happyIn48
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_118 = happySpecReduce_0 44# happyReduction_118
happyReduction_118  =  happyIn49
		 ([]
	)

happyReduce_119 = happySpecReduce_2 44# happyReduction_119
happyReduction_119 happy_x_2
	happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_2 of { happy_var_2 -> 
	happyIn49
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_120 = happySpecReduce_0 45# happyReduction_120
happyReduction_120  =  happyIn50
		 ([]
	)

happyReduce_121 = happySpecReduce_1 45# happyReduction_121
happyReduction_121 happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	happyIn50
		 ((:[]) happy_var_1
	)}

happyReduce_122 = happySpecReduce_3 45# happyReduction_122
happyReduction_122 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn50
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_123 = happySpecReduce_0 46# happyReduction_123
happyReduction_123  =  happyIn51
		 ([]
	)

happyReduce_124 = happySpecReduce_1 46# happyReduction_124
happyReduction_124 happy_x_1
	 =  case happyOut42 happy_x_1 of { happy_var_1 -> 
	happyIn51
		 ((:[]) happy_var_1
	)}

happyReduce_125 = happySpecReduce_3 46# happyReduction_125
happyReduction_125 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut42 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn51
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_126 = happySpecReduce_0 47# happyReduction_126
happyReduction_126  =  happyIn52
		 ([]
	)

happyReduce_127 = happySpecReduce_1 47# happyReduction_127
happyReduction_127 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn52
		 ((:[]) happy_var_1
	)}

happyReduce_128 = happySpecReduce_3 47# happyReduction_128
happyReduction_128 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut52 happy_x_3 of { happy_var_3 -> 
	happyIn52
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_129 = happySpecReduce_0 48# happyReduction_129
happyReduction_129  =  happyIn53
		 ([]
	)

happyReduce_130 = happySpecReduce_1 48# happyReduction_130
happyReduction_130 happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	happyIn53
		 ((:[]) happy_var_1
	)}

happyReduce_131 = happySpecReduce_3 48# happyReduction_131
happyReduction_131 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	case happyOut53 happy_x_3 of { happy_var_3 -> 
	happyIn53
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_132 = happySpecReduce_0 49# happyReduction_132
happyReduction_132  =  happyIn54
		 ([]
	)

happyReduce_133 = happySpecReduce_2 49# happyReduction_133
happyReduction_133 happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn54
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_134 = happySpecReduce_0 50# happyReduction_134
happyReduction_134  =  happyIn55
		 ([]
	)

happyReduce_135 = happySpecReduce_2 50# happyReduction_135
happyReduction_135 happy_x_2
	happy_x_1
	 =  case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_136 = happySpecReduce_0 51# happyReduction_136
happyReduction_136  =  happyIn56
		 ([]
	)

happyReduce_137 = happySpecReduce_1 51# happyReduction_137
happyReduction_137 happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	happyIn56
		 ((:[]) happy_var_1
	)}

happyReduce_138 = happySpecReduce_3 51# happyReduction_138
happyReduction_138 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut56 happy_x_3 of { happy_var_3 -> 
	happyIn56
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_139 = happySpecReduce_0 52# happyReduction_139
happyReduction_139  =  happyIn57
		 ([]
	)

happyReduce_140 = happySpecReduce_1 52# happyReduction_140
happyReduction_140 happy_x_1
	 =  case happyOut44 happy_x_1 of { happy_var_1 -> 
	happyIn57
		 ((:[]) happy_var_1
	)}

happyReduce_141 = happySpecReduce_3 52# happyReduction_141
happyReduction_141 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut44 happy_x_1 of { happy_var_1 -> 
	case happyOut57 happy_x_3 of { happy_var_3 -> 
	happyIn57
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_142 = happySpecReduce_0 53# happyReduction_142
happyReduction_142  =  happyIn58
		 ([]
	)

happyReduce_143 = happySpecReduce_2 53# happyReduction_143
happyReduction_143 happy_x_2
	happy_x_1
	 =  case happyOut58 happy_x_1 of { happy_var_1 -> 
	case happyOut43 happy_x_2 of { happy_var_2 -> 
	happyIn58
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_144 = happySpecReduce_0 54# happyReduction_144
happyReduction_144  =  happyIn59
		 ([]
	)

happyReduce_145 = happySpecReduce_1 54# happyReduction_145
happyReduction_145 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn59
		 ((:[]) happy_var_1
	)}

happyReduce_146 = happySpecReduce_3 54# happyReduction_146
happyReduction_146 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut59 happy_x_3 of { happy_var_3 -> 
	happyIn59
		 ((:) happy_var_1 happy_var_3
	)}}

happyNewToken action sts stk [] =
	happyDoAction 54# (error "reading EOF!") action sts stk []

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
	PT _ (TD happy_dollar_dollar) -> cont 52#;
	_ -> cont 53#;
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
  happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut9 x))

pLine tks = happySomeParser where
  happySomeParser = happyThen (happyParse 1# tks) (\x -> happyReturn (happyOut10 x))

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
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command line>" #-}
{-# LINE 1 "GenericTemplate.hs" #-}
-- $Id$


{-# LINE 28 "GenericTemplate.hs" #-}


data Happy_IntList = HappyCons Int# Happy_IntList






{-# LINE 49 "GenericTemplate.hs" #-}


{-# LINE 59 "GenericTemplate.hs" #-}










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

{-# LINE 170 "GenericTemplate.hs" #-}

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
