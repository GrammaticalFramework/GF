{-# OPTIONS -fglasgow-exts -cpp #-}
module Transfer.Syntax.Par where
import Transfer.Syntax.Abs
import Transfer.Syntax.Lex
import Transfer.ErrM
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
happyIn9 :: (Module) -> (HappyAbsSyn )
happyIn9 x = unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> (Module)
happyOut9 x = unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: (Import) -> (HappyAbsSyn )
happyIn10 x = unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> (Import)
happyOut10 x = unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: ([Import]) -> (HappyAbsSyn )
happyIn11 x = unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> ([Import])
happyOut11 x = unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: (Decl) -> (HappyAbsSyn )
happyIn12 x = unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> (Decl)
happyOut12 x = unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: ([Decl]) -> (HappyAbsSyn )
happyIn13 x = unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn ) -> ([Decl])
happyOut13 x = unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: (ConsDecl) -> (HappyAbsSyn )
happyIn14 x = unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> (ConsDecl)
happyOut14 x = unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: ([ConsDecl]) -> (HappyAbsSyn )
happyIn15 x = unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> ([ConsDecl])
happyOut15 x = unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (Guard) -> (HappyAbsSyn )
happyIn16 x = unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> (Guard)
happyOut16 x = unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: (Pattern) -> (HappyAbsSyn )
happyIn17 x = unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> (Pattern)
happyOut17 x = unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: (Pattern) -> (HappyAbsSyn )
happyIn18 x = unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> (Pattern)
happyOut18 x = unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: (Pattern) -> (HappyAbsSyn )
happyIn19 x = unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> (Pattern)
happyOut19 x = unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: (Pattern) -> (HappyAbsSyn )
happyIn20 x = unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> (Pattern)
happyOut20 x = unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: (CommaPattern) -> (HappyAbsSyn )
happyIn21 x = unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> (CommaPattern)
happyOut21 x = unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyIn22 :: ([CommaPattern]) -> (HappyAbsSyn )
happyIn22 x = unsafeCoerce# x
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn ) -> ([CommaPattern])
happyOut22 x = unsafeCoerce# x
{-# INLINE happyOut22 #-}
happyIn23 :: ([Pattern]) -> (HappyAbsSyn )
happyIn23 x = unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> ([Pattern])
happyOut23 x = unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: (FieldPattern) -> (HappyAbsSyn )
happyIn24 x = unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> (FieldPattern)
happyOut24 x = unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: ([FieldPattern]) -> (HappyAbsSyn )
happyIn25 x = unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> ([FieldPattern])
happyOut25 x = unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: (Exp) -> (HappyAbsSyn )
happyIn26 x = unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> (Exp)
happyOut26 x = unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: (VarOrWild) -> (HappyAbsSyn )
happyIn27 x = unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> (VarOrWild)
happyOut27 x = unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: (Exp) -> (HappyAbsSyn )
happyIn28 x = unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> (Exp)
happyOut28 x = unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: (LetDef) -> (HappyAbsSyn )
happyIn29 x = unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> (LetDef)
happyOut29 x = unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: ([LetDef]) -> (HappyAbsSyn )
happyIn30 x = unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> ([LetDef])
happyOut30 x = unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: (Case) -> (HappyAbsSyn )
happyIn31 x = unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> (Case)
happyOut31 x = unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: ([Case]) -> (HappyAbsSyn )
happyIn32 x = unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> ([Case])
happyOut32 x = unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (Bind) -> (HappyAbsSyn )
happyIn33 x = unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (Bind)
happyOut33 x = unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyIn34 :: ([Bind]) -> (HappyAbsSyn )
happyIn34 x = unsafeCoerce# x
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> ([Bind])
happyOut34 x = unsafeCoerce# x
{-# INLINE happyOut34 #-}
happyIn35 :: (Exp) -> (HappyAbsSyn )
happyIn35 x = unsafeCoerce# x
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> (Exp)
happyOut35 x = unsafeCoerce# x
{-# INLINE happyOut35 #-}
happyIn36 :: (Exp) -> (HappyAbsSyn )
happyIn36 x = unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> (Exp)
happyOut36 x = unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: (Exp) -> (HappyAbsSyn )
happyIn37 x = unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> (Exp)
happyOut37 x = unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: (Exp) -> (HappyAbsSyn )
happyIn38 x = unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> (Exp)
happyOut38 x = unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: (Exp) -> (HappyAbsSyn )
happyIn39 x = unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> (Exp)
happyOut39 x = unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: (Exp) -> (HappyAbsSyn )
happyIn40 x = unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> (Exp)
happyOut40 x = unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyIn41 :: (Exp) -> (HappyAbsSyn )
happyIn41 x = unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> (Exp)
happyOut41 x = unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: (Exp) -> (HappyAbsSyn )
happyIn42 x = unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> (Exp)
happyOut42 x = unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyIn43 :: (Exp) -> (HappyAbsSyn )
happyIn43 x = unsafeCoerce# x
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> (Exp)
happyOut43 x = unsafeCoerce# x
{-# INLINE happyOut43 #-}
happyIn44 :: (Exp) -> (HappyAbsSyn )
happyIn44 x = unsafeCoerce# x
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> (Exp)
happyOut44 x = unsafeCoerce# x
{-# INLINE happyOut44 #-}
happyIn45 :: (Exp) -> (HappyAbsSyn )
happyIn45 x = unsafeCoerce# x
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> (Exp)
happyOut45 x = unsafeCoerce# x
{-# INLINE happyOut45 #-}
happyIn46 :: (FieldType) -> (HappyAbsSyn )
happyIn46 x = unsafeCoerce# x
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> (FieldType)
happyOut46 x = unsafeCoerce# x
{-# INLINE happyOut46 #-}
happyIn47 :: ([FieldType]) -> (HappyAbsSyn )
happyIn47 x = unsafeCoerce# x
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn ) -> ([FieldType])
happyOut47 x = unsafeCoerce# x
{-# INLINE happyOut47 #-}
happyIn48 :: (FieldValue) -> (HappyAbsSyn )
happyIn48 x = unsafeCoerce# x
{-# INLINE happyIn48 #-}
happyOut48 :: (HappyAbsSyn ) -> (FieldValue)
happyOut48 x = unsafeCoerce# x
{-# INLINE happyOut48 #-}
happyIn49 :: ([FieldValue]) -> (HappyAbsSyn )
happyIn49 x = unsafeCoerce# x
{-# INLINE happyIn49 #-}
happyOut49 :: (HappyAbsSyn ) -> ([FieldValue])
happyOut49 x = unsafeCoerce# x
{-# INLINE happyOut49 #-}
happyIn50 :: (Exp) -> (HappyAbsSyn )
happyIn50 x = unsafeCoerce# x
{-# INLINE happyIn50 #-}
happyOut50 :: (HappyAbsSyn ) -> (Exp)
happyOut50 x = unsafeCoerce# x
{-# INLINE happyOut50 #-}
happyIn51 :: ([Exp]) -> (HappyAbsSyn )
happyIn51 x = unsafeCoerce# x
{-# INLINE happyIn51 #-}
happyOut51 :: (HappyAbsSyn ) -> ([Exp])
happyOut51 x = unsafeCoerce# x
{-# INLINE happyOut51 #-}
happyInTok :: Token -> (HappyAbsSyn )
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x00\x00\x48\x03\x90\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x84\x01\xa8\x01\x34\x00\x00\x00\xaf\x01\xa1\x01\x6c\x00\x9f\x00\xb6\x00\x00\x00\x64\x03\x7d\x01\x00\x00\x00\x00\xd4\x02\xb8\x02\xf9\xff\x50\x03\x00\x00\x00\x00\x48\x03\xb1\x01\x48\x03\xa5\x01\xa0\x01\x9e\x01\x00\x00\x00\x00\x00\x00\x68\x01\x73\x01\x9a\x01\x7d\x00\x5e\x01\x5e\x01\x5e\x01\x5e\x01\x5b\x01\x00\x00\x5c\x01\x00\x00\x48\x03\x00\x00\x75\x01\x00\x00\x78\x01\x77\x01\x00\x00\x03\x00\x41\x00\x80\x01\x45\x01\x51\x01\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x50\x03\x48\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb6\x00\xb6\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x48\x03\x00\x00\x48\x03\x00\x00\x48\x03\x34\x03\x6c\x01\xa4\x02\x18\x03\x67\x01\x6a\x01\x66\x01\x58\x01\x57\x01\x65\x01\x54\x01\x52\x01\x4e\x01\x00\x00\x4f\x01\x3e\x01\x1f\x01\x1f\x01\x00\x00\x1f\x01\x3b\x01\x00\x00\x8c\x02\x18\x03\x00\x00\x13\x01\x18\x03\x00\x00\x13\x01\x18\x03\x10\x01\x08\x01\x18\x03\x04\x01\x34\x01\x26\x01\x20\x01\x85\x03\x00\x00\x00\x00\x1c\x01\x1a\x01\x11\x01\x00\x00\x85\x03\x00\x00\x00\x00\x19\x01\x17\x01\x0a\x01\x00\x00\x0c\x01\x07\x01\x85\x03\x7e\x03\x00\x00\x05\x01\x00\x00\x18\x03\x00\x00\x04\x03\x00\x00\x00\x00\x04\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x01\x00\x00\x04\x03\xe8\x02\x00\x00\xd6\x00\x00\x00\xe8\x02\x00\x00\x00\x00\x00\x00\xd4\x00\x00\x00\xec\x00\xe6\x00\x00\x00\xea\x00\xe2\x00\x00\x00\x85\x03\x85\x03\x85\x03\xde\x00\x00\x00\xe8\x02\x00\x00\x85\x03\xe8\x02\x00\x00\x00\x00\x00\x00\x85\x03\x00\x00\x00\x00\x85\x03\xe9\x00\xdf\x00\xe8\x00\x00\x00\xd8\x00\xa8\x00\x00\x00\xa8\x00\x85\x03\x00\x00\xcc\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc5\x00\xbb\x00\xa5\x00\x00\x00\x8c\x00\xe8\x02\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\xbc\x00\x21\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6b\x04\x00\x00\x00\x00\x00\x00\x78\x00\x35\x00\x17\x00\x67\x04\x00\x00\x00\x00\x08\x02\x00\x00\xef\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x00\x00\x0a\x00\x95\x00\x60\x00\x19\x00\x67\x00\x00\x00\x6f\x00\x00\x00\x00\x00\xd6\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8b\x00\x00\x00\x63\x04\x5f\x04\x5b\x04\x29\x04\x57\x04\x52\x04\x22\x04\x1b\x04\x14\x04\x0d\x04\xe4\x03\xdd\x03\xd6\x03\xcd\x03\xa4\x03\x9a\x03\xbd\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa4\x01\x00\x00\x1b\x00\x00\x00\x01\x00\x81\x02\x00\x00\x4f\x00\x8b\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5a\x00\x00\x00\x61\x00\x4d\x00\x00\x00\x0e\x00\x00\x00\x00\x00\xe5\x04\x72\x01\x00\x00\x5e\x00\x59\x01\x00\x00\x08\x00\x40\x01\x00\x00\x13\x00\x27\x01\x00\x00\x00\x00\x00\x00\x00\x00\x98\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9b\x02\x00\x00\x00\x00\x26\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcc\x04\xba\x04\x00\x00\x00\x00\x00\x00\x0e\x01\x00\x00\x69\x02\x00\x00\x00\x00\x51\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x39\x02\xf5\x00\x00\x00\x00\x00\x00\x00\xdc\x00\x00\x00\x00\x00\x00\x00\x90\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x94\x04\x9f\x03\xd5\x04\x00\x00\xf7\xff\xc3\x00\x00\x00\x0b\x00\xaa\x00\x00\x00\x00\x00\x00\x00\xb4\x04\x00\x00\x00\x00\x9c\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5f\x00\x00\x00\x6a\x00\xd1\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x06\x00\x91\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xf7\xff\x00\x00\x00\x00\xfd\xff\x98\xff\x96\xff\x95\xff\x94\xff\x00\x00\xcf\xff\x89\xff\xb8\xff\xb6\xff\xb4\xff\xad\xff\xab\xff\xa8\xff\xa4\xff\xa2\xff\xa0\xff\x9e\xff\xc7\xff\x00\x00\x00\x00\x00\x00\x00\x00\x93\xff\x97\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\xff\xfb\xff\xfa\xff\x00\x00\xf1\xff\x00\x00\xf9\xff\x00\x00\x90\xff\x8c\xff\xc5\xff\x00\x00\xbc\xff\x00\x00\xa3\xff\x00\x00\xce\xff\x00\x00\xcd\xff\x88\xff\x00\x00\x9b\xff\x98\xff\x00\x00\x00\x00\x00\x00\xa1\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd0\xff\xb9\xff\xba\xff\xb7\xff\xb5\xff\xae\xff\xaf\xff\xb0\xff\xb1\xff\xb2\xff\xb3\xff\xa9\xff\xaa\xff\xac\xff\xa5\xff\xa6\xff\xa7\xff\x9f\xff\x00\x00\x92\xff\x00\x00\x9a\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc4\xff\x00\x00\x00\x00\x8b\xff\x00\x00\x00\x00\x8f\xff\x00\x00\xf8\xff\xd7\xff\x00\x00\x00\x00\x00\x00\xf6\xff\x00\x00\x00\x00\xf0\xff\xea\xff\x00\x00\x9d\xff\x90\xff\x00\x00\x9c\xff\x8c\xff\x00\x00\x00\x00\xc5\xff\x00\x00\x00\x00\xbd\xff\x00\x00\x00\x00\xc1\xff\xcc\xff\x87\xff\x00\x00\x00\x00\x00\x00\x99\xff\xdd\xff\xdf\xff\xde\xff\xea\xff\xe8\xff\xe6\xff\xe4\xff\xc0\xff\x00\x00\x00\x00\x00\x00\xdc\xff\x00\x00\xbb\xff\x00\x00\xc8\xff\x00\x00\xc6\xff\xc3\xff\x00\x00\x8d\xff\x8a\xff\x91\xff\x8e\xff\xf4\xff\xdd\xff\x00\x00\xd6\xff\x00\x00\x00\x00\xf2\xff\x00\x00\xeb\xff\x00\x00\xcb\xff\xc9\xff\xbe\xff\xd4\xff\xda\xff\xd9\xff\x00\x00\xe2\xff\xda\xff\x00\x00\xca\xff\xc1\xff\x00\x00\x00\x00\x00\x00\xd7\xff\x00\x00\xd1\xff\xe5\xff\x00\x00\xe9\xff\xe7\xff\xbf\xff\x00\x00\xdb\xff\xe1\xff\x00\x00\x00\x00\xd3\xff\x00\x00\xf3\xff\x00\x00\xee\xff\xe3\xff\xd4\xff\x00\x00\xd8\xff\x00\x00\xc2\xff\xe0\xff\xd5\xff\xd2\xff\x00\x00\xed\xff\x00\x00\xf5\xff\xee\xff\x00\x00\xef\xff\xec\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x02\x00\x00\x00\x0e\x00\x00\x00\x12\x00\x00\x00\x00\x00\x01\x00\x02\x00\x00\x00\x09\x00\x0a\x00\x07\x00\x05\x00\x00\x00\x11\x00\x08\x00\x15\x00\x00\x00\x17\x00\x00\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x03\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x31\x00\x18\x00\x19\x00\x16\x00\x2d\x00\x2e\x00\x15\x00\x0b\x00\x17\x00\x2b\x00\x2c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x2b\x00\x2c\x00\x12\x00\x13\x00\x2d\x00\x2e\x00\x15\x00\x0a\x00\x17\x00\x00\x00\x0d\x00\x00\x00\x01\x00\x02\x00\x03\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2d\x00\x2e\x00\x15\x00\x16\x00\x17\x00\x00\x00\x09\x00\x0a\x00\x00\x00\x1c\x00\x12\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x00\x00\x01\x00\x02\x00\x03\x00\x2d\x00\x13\x00\x14\x00\x18\x00\x19\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x29\x00\x2a\x00\x29\x00\x2a\x00\x00\x00\x1d\x00\x15\x00\x16\x00\x17\x00\x00\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x24\x00\x25\x00\x13\x00\x14\x00\x2d\x00\x15\x00\x08\x00\x17\x00\x04\x00\x00\x00\x01\x00\x02\x00\x03\x00\x31\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x1b\x00\x1c\x00\x01\x00\x31\x00\x2d\x00\x15\x00\x04\x00\x17\x00\x06\x00\x00\x00\x01\x00\x02\x00\x03\x00\x02\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x1d\x00\x1e\x00\x1f\x00\x0a\x00\x2d\x00\x15\x00\x31\x00\x17\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x01\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x04\x00\x0f\x00\x05\x00\x0d\x00\x2d\x00\x15\x00\x0c\x00\x17\x00\x0a\x00\x00\x00\x01\x00\x02\x00\x03\x00\x0d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x31\x00\x30\x00\x05\x00\x03\x00\x2d\x00\x15\x00\x04\x00\x17\x00\x01\x00\x00\x00\x01\x00\x02\x00\x03\x00\x08\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x07\x00\x06\x00\x0f\x00\x01\x00\x2d\x00\x15\x00\x0a\x00\x17\x00\x0a\x00\x00\x00\x01\x00\x02\x00\x03\x00\x27\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x11\x00\x04\x00\x31\x00\x2a\x00\x2d\x00\x15\x00\x02\x00\x17\x00\x01\x00\x00\x00\x01\x00\x02\x00\x03\x00\x31\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x31\x00\x02\x00\x04\x00\x01\x00\x2d\x00\x15\x00\x02\x00\x17\x00\x01\x00\x00\x00\x01\x00\x02\x00\x03\x00\x05\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x04\x00\x04\x00\x01\x00\x05\x00\x2d\x00\x15\x00\x03\x00\x17\x00\x20\x00\x00\x00\x01\x00\x02\x00\x03\x00\x31\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x02\x00\x0c\x00\x0f\x00\x0d\x00\x2d\x00\x15\x00\x2c\x00\x17\x00\x2f\x00\x00\x00\x01\x00\x02\x00\x03\x00\x31\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x01\x00\x29\x00\x20\x00\x36\x00\x2d\x00\x15\x00\x03\x00\x17\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x03\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x03\x00\x14\x00\x07\x00\x0f\x00\x2d\x00\x15\x00\x36\x00\x17\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x31\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\x15\x00\xff\xff\x17\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\x15\x00\xff\xff\x17\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\x15\x00\xff\xff\x17\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\x15\x00\xff\xff\x17\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\x15\x00\xff\xff\x17\x00\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\x17\x00\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\x17\x00\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\x17\x00\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x06\x00\xff\xff\xff\xff\x09\x00\x2d\x00\x0b\x00\x17\x00\xff\xff\x0e\x00\x00\x00\x01\x00\x02\x00\xff\xff\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x0f\x00\xff\xff\xff\xff\x09\x00\x2d\x00\x0b\x00\xff\xff\xff\xff\x0e\x00\xff\xff\x10\x00\xff\xff\xff\xff\xff\xff\xff\xff\x2d\x00\xff\xff\xff\xff\xff\xff\x31\x00\x32\x00\x33\x00\x1c\x00\x09\x00\xff\xff\x0b\x00\x0c\x00\x21\x00\x22\x00\x23\x00\x10\x00\xff\xff\x26\x00\xff\xff\x28\x00\xff\xff\xff\xff\x2b\x00\xff\xff\x2d\x00\x2e\x00\xff\xff\x1c\x00\x31\x00\x32\x00\x33\x00\x34\x00\x21\x00\x22\x00\x23\x00\xff\xff\x09\x00\x26\x00\x0b\x00\x28\x00\xff\xff\x0e\x00\x2b\x00\x10\x00\x2d\x00\x2e\x00\xff\xff\xff\xff\x31\x00\x32\x00\x33\x00\x34\x00\xff\xff\xff\xff\xff\xff\x1c\x00\x09\x00\xff\xff\x0b\x00\xff\xff\x21\x00\x22\x00\x23\x00\x10\x00\xff\xff\x26\x00\xff\xff\x28\x00\xff\xff\xff\xff\x2b\x00\xff\xff\x2d\x00\x2e\x00\xff\xff\x1c\x00\x31\x00\x32\x00\x33\x00\x34\x00\x21\x00\x22\x00\x23\x00\xff\xff\x09\x00\x26\x00\x0b\x00\x28\x00\xff\xff\xff\xff\x2b\x00\x10\x00\x2d\x00\x2e\x00\xff\xff\xff\xff\x31\x00\x32\x00\x33\x00\x34\x00\xff\xff\xff\xff\xff\xff\x1c\x00\x09\x00\xff\xff\x0b\x00\xff\xff\x21\x00\x22\x00\x23\x00\x10\x00\xff\xff\x26\x00\xff\xff\x28\x00\xff\xff\xff\xff\x2b\x00\xff\xff\x2d\x00\x2e\x00\xff\xff\x1c\x00\x31\x00\x32\x00\x33\x00\x34\x00\x21\x00\x22\x00\x23\x00\xff\xff\x09\x00\x26\x00\x0b\x00\x28\x00\xff\xff\xff\xff\x2b\x00\x10\x00\x2d\x00\x2e\x00\xff\xff\xff\xff\x31\x00\x32\x00\x33\x00\x34\x00\xff\xff\xff\xff\xff\xff\x1c\x00\x09\x00\xff\xff\x0b\x00\xff\xff\x21\x00\x22\x00\x23\x00\x10\x00\x09\x00\x26\x00\x0b\x00\x28\x00\xff\xff\xff\xff\x2b\x00\xff\xff\x2d\x00\x2e\x00\xff\xff\x1c\x00\x31\x00\x32\x00\x33\x00\x34\x00\x21\x00\x22\x00\x23\x00\x1c\x00\x09\x00\x26\x00\x0b\x00\x28\x00\x21\x00\x22\x00\x2b\x00\xff\xff\x2d\x00\x2e\x00\xff\xff\xff\xff\x31\x00\x32\x00\x33\x00\x34\x00\x2d\x00\x2e\x00\xff\xff\xff\xff\x31\x00\x32\x00\x33\x00\x34\x00\x21\x00\x22\x00\x09\x00\xff\xff\x0b\x00\x0c\x00\xff\xff\x0e\x00\xff\xff\x09\x00\xff\xff\x0b\x00\x2d\x00\x2e\x00\x0e\x00\xff\xff\x31\x00\x32\x00\x33\x00\x34\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\xff\xff\x2d\x00\x0d\x00\x0e\x00\x0f\x00\x31\x00\x32\x00\x33\x00\x2d\x00\xff\xff\xff\xff\xff\xff\x31\x00\x32\x00\x33\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\xff\xff\xff\xff\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x22\x00\x23\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x24\x00\x25\x00\x26\x00\x27\x00\x28\x00\x25\x00\x26\x00\x27\x00\x28\x00\x25\x00\x26\x00\x27\x00\x28\x00\x25\x00\x26\x00\x27\x00\x28\x00\x25\x00\x26\x00\x27\x00\x28\x00\xff\xff\xff\xff\x27\x00\x28\x00\x00\x00\x01\x00\x02\x00\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x1a\x00\x1b\x00\xff\xff\xff\xff\x1a\x00\x1b\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\x00\x00\x01\x00\x02\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x0b\x00\xff\xff\xff\xff\xff\xff\x0f\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\xce\xff\xdd\x00\x35\x00\x6c\x00\xc5\x00\x73\x00\xaa\x00\x92\x00\x93\x00\xaf\x00\xde\x00\xe4\x00\x74\x00\x27\x00\x69\x00\xce\xff\x28\x00\x35\x00\x32\x00\x09\x00\x6c\x00\xac\x00\x04\x00\x05\x00\x06\x00\x07\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x04\x00\x6a\x00\xa3\x00\x33\x00\x15\x00\x8c\x00\x35\x00\xc1\x00\x09\x00\x6d\x00\xa6\x00\x04\x00\x05\x00\x06\x00\x07\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x6d\x00\x6e\x00\x4c\x00\x4d\x00\x15\x00\x8d\x00\x35\x00\x62\x00\x09\x00\x78\x00\x63\x00\x38\x00\x05\x00\x06\x00\x07\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x6f\x00\xdd\x00\x6f\x00\x79\x00\x15\x00\x36\x00\x87\x00\x88\x00\x09\x00\x69\x00\xde\x00\xdf\x00\xce\x00\x89\x00\x7b\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x38\x00\x05\x00\x06\x00\x07\x00\x15\x00\xcf\x00\xdc\x00\x6a\x00\x6b\x00\x44\x00\x45\x00\x46\x00\x47\x00\x48\x00\x49\x00\x70\x00\xa8\x00\x70\x00\x71\x00\x5f\x00\x67\x00\x39\x00\x3a\x00\x09\x00\xce\x00\x04\x00\x05\x00\x06\x00\x07\x00\x72\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x76\x00\x77\x00\xcf\x00\xd0\x00\x15\x00\xe3\x00\x41\x00\x09\x00\xe1\x00\x04\x00\x05\x00\x06\x00\x07\x00\x04\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x42\x00\x43\x00\xe2\x00\x04\x00\x15\x00\xd9\x00\x25\x00\x09\x00\x26\x00\x04\x00\x05\x00\x06\x00\x07\x00\xe3\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x3e\x00\x3f\x00\x40\x00\xdb\x00\x15\x00\xc4\x00\x04\x00\x09\x00\xd4\x00\x04\x00\x05\x00\x06\x00\x07\x00\xd6\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\xd5\x00\xc7\x00\xd7\x00\xcb\x00\x15\x00\xd1\x00\xcd\x00\x09\x00\xcc\x00\x04\x00\x05\x00\x06\x00\x07\x00\xce\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x04\x00\xd3\x00\xb3\x00\xb7\x00\x15\x00\xb0\x00\xbe\x00\x09\x00\xbf\x00\x04\x00\x05\x00\x06\x00\x07\x00\xc0\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\xc1\x00\xae\x00\xc4\x00\x9f\x00\x15\x00\xb5\x00\x90\x00\x09\x00\x91\x00\x04\x00\x05\x00\x06\x00\x07\x00\xa2\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\xa0\x00\xa1\x00\x04\x00\xa5\x00\x15\x00\xa2\x00\xaf\x00\x09\x00\x7b\x00\x04\x00\x05\x00\x06\x00\x07\x00\x04\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x04\x00\x7d\x00\x7e\x00\x7f\x00\x15\x00\xa5\x00\x80\x00\x09\x00\x82\x00\x04\x00\x05\x00\x06\x00\x07\x00\x83\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x81\x00\x84\x00\x85\x00\x86\x00\x15\x00\xa7\x00\x8b\x00\x09\x00\x3c\x00\x04\x00\x05\x00\x06\x00\x07\x00\x04\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x61\x00\x64\x00\x66\x00\x65\x00\x15\x00\xa9\x00\x67\x00\x09\x00\x69\x00\x04\x00\x05\x00\x06\x00\x07\x00\x04\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x78\x00\x2a\x00\x3c\x00\xff\xff\x15\x00\x86\x00\x2b\x00\x09\x00\x2c\x00\x04\x00\x05\x00\x06\x00\x07\x00\x2d\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x2f\x00\x4a\x00\x4b\x00\x4e\x00\x15\x00\x8e\x00\xff\xff\x09\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x04\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x4e\x00\x00\x00\x09\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x39\x00\x00\x00\x09\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x2d\x00\x00\x00\x09\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x2f\x00\x00\x00\x09\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x08\x00\x00\x00\x09\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\xb1\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\xb3\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x00\x00\xb4\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\xae\x00\x00\x00\x00\x00\x9b\x00\x15\x00\x9c\x00\x8b\x00\x00\x00\x9d\x00\xaa\x00\x92\x00\x93\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\xc2\x00\x00\x00\x00\x00\x17\x00\x15\x00\x18\x00\x00\x00\x00\x00\x35\x00\x00\x00\x19\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9e\x00\x00\x00\x00\x00\x00\x00\x04\x00\x23\x00\x24\x00\x1a\x00\x17\x00\x00\x00\x18\x00\x38\x00\x1b\x00\x1c\x00\x1d\x00\x19\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x00\x00\x00\x00\x20\x00\x00\x00\x21\x00\x22\x00\x00\x00\x1a\x00\x04\x00\x23\x00\x24\x00\x25\x00\x1b\x00\x1c\x00\x1d\x00\x00\x00\x17\x00\x1e\x00\x18\x00\x1f\x00\x00\x00\x35\x00\x20\x00\x19\x00\x21\x00\x22\x00\x00\x00\x00\x00\x04\x00\x23\x00\x24\x00\x25\x00\x00\x00\x00\x00\x00\x00\x1a\x00\x17\x00\x00\x00\x18\x00\x00\x00\x1b\x00\x1c\x00\x1d\x00\x19\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x00\x00\x00\x00\x20\x00\x00\x00\x21\x00\x22\x00\x00\x00\x1a\x00\x04\x00\x23\x00\x24\x00\x25\x00\x1b\x00\x1c\x00\x1d\x00\x00\x00\x32\x00\x1e\x00\x18\x00\x1f\x00\x00\x00\x00\x00\x20\x00\x19\x00\x21\x00\x22\x00\x00\x00\x00\x00\x04\x00\x23\x00\x24\x00\x25\x00\x00\x00\x00\x00\x00\x00\x1a\x00\x17\x00\x00\x00\x18\x00\x00\x00\x1b\x00\x1c\x00\x1d\x00\x19\x00\x00\x00\x1e\x00\x00\x00\x1f\x00\x00\x00\x00\x00\x20\x00\x00\x00\x21\x00\x22\x00\x00\x00\x1a\x00\x04\x00\x23\x00\x24\x00\x25\x00\x1b\x00\x1c\x00\x1d\x00\x00\x00\x32\x00\x1e\x00\x18\x00\x1f\x00\x00\x00\x00\x00\x20\x00\x19\x00\x21\x00\x22\x00\x00\x00\x00\x00\x04\x00\x23\x00\x24\x00\x25\x00\x00\x00\x00\x00\x00\x00\x1a\x00\x17\x00\x00\x00\x18\x00\x00\x00\x1b\x00\x1c\x00\x1d\x00\x19\x00\x32\x00\x1e\x00\x18\x00\x1f\x00\x00\x00\x00\x00\x20\x00\x00\x00\x21\x00\x22\x00\x00\x00\x1a\x00\x04\x00\x23\x00\x24\x00\x25\x00\x1b\x00\x1c\x00\x1d\x00\x1a\x00\x32\x00\x1e\x00\x18\x00\x1f\x00\x1b\x00\x1c\x00\x20\x00\x00\x00\x21\x00\x22\x00\x00\x00\x00\x00\x04\x00\x23\x00\x24\x00\x25\x00\x21\x00\x22\x00\x00\x00\x00\x00\x04\x00\x23\x00\x24\x00\x25\x00\x1b\x00\x1c\x00\x9b\x00\x00\x00\x9c\x00\xbb\x00\x00\x00\x9d\x00\x00\x00\x9b\x00\x00\x00\x9c\x00\x21\x00\x22\x00\x9d\x00\x00\x00\x04\x00\x23\x00\x24\x00\x25\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x91\x00\x92\x00\x93\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x00\x00\x9e\x00\xc8\x00\x96\x00\x97\x00\x04\x00\x23\x00\x24\x00\x9e\x00\x00\x00\x00\x00\x00\x00\x04\x00\x23\x00\x24\x00\x4f\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x50\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x51\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x52\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x53\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x54\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x55\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x56\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x57\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x58\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x5b\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x04\x00\x05\x00\x06\x00\x07\x00\x04\x00\x05\x00\x06\x00\x07\x00\x04\x00\x05\x00\x06\x00\x07\x00\x04\x00\x05\x00\x06\x00\x07\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x59\x00\x11\x00\x12\x00\x13\x00\x14\x00\x5a\x00\x11\x00\x12\x00\x13\x00\x14\x00\x5c\x00\x12\x00\x13\x00\x14\x00\x5d\x00\x12\x00\x13\x00\x14\x00\x5e\x00\x12\x00\x13\x00\x14\x00\x30\x00\x12\x00\x13\x00\x14\x00\x00\x00\x00\x00\x3c\x00\x14\x00\x91\x00\x92\x00\x93\x00\x00\x00\x91\x00\x92\x00\x93\x00\x00\x00\x91\x00\x92\x00\x93\x00\x00\x00\x94\x00\x95\x00\x96\x00\x97\x00\x94\x00\x95\x00\x96\x00\x97\x00\xb7\x00\x95\x00\x96\x00\x97\x00\xb8\x00\xd7\x00\x98\x00\xc9\x00\x00\x00\x00\x00\x98\x00\x99\x00\x91\x00\x92\x00\x93\x00\x00\x00\x00\x00\x00\x00\x91\x00\x92\x00\x93\x00\x00\x00\x00\x00\x00\x00\xb7\x00\x95\x00\x96\x00\x97\x00\xb8\x00\xd8\x00\xb7\x00\x95\x00\x96\x00\x97\x00\xb8\x00\xb9\x00\x91\x00\x92\x00\x93\x00\x00\x00\x00\x00\x91\x00\x92\x00\x93\x00\x00\x00\x91\x00\x92\x00\x93\x00\xbb\x00\x95\x00\x96\x00\x97\x00\xbc\x00\xdb\x00\x95\x00\x96\x00\x97\x00\xc7\x00\x95\x00\x96\x00\x97\x00\xaa\x00\x92\x00\x93\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xab\x00\x00\x00\x00\x00\x00\x00\xac\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (2, 120) [
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
	(120 , happyReduce_120)
	]

happy_n_terms = 55 :: Int
happy_n_nonterms = 47 :: Int

happyReduce_2 = happySpecReduce_1 0# happyReduction_2
happyReduction_2 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TV happy_var_1)) -> 
	happyIn5
		 (Ident happy_var_1
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

happyReduce_6 = happySpecReduce_2 4# happyReduction_6
happyReduction_6 happy_x_2
	happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	case happyOut13 happy_x_2 of { happy_var_2 -> 
	happyIn9
		 (Module (reverse happy_var_1) (reverse happy_var_2)
	)}}

happyReduce_7 = happySpecReduce_2 5# happyReduction_7
happyReduction_7 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn10
		 (Import happy_var_2
	)}

happyReduce_8 = happySpecReduce_0 6# happyReduction_8
happyReduction_8  =  happyIn11
		 ([]
	)

happyReduce_9 = happySpecReduce_3 6# happyReduction_9
happyReduction_9 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn11
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_10 = happyReduce 8# 7# happyReduction_10
happyReduction_10 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut26 happy_x_4 of { happy_var_4 -> 
	case happyOut15 happy_x_7 of { happy_var_7 -> 
	happyIn12
		 (DataDecl happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_11 = happySpecReduce_3 7# happyReduction_11
happyReduction_11 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn12
		 (TypeDecl happy_var_1 happy_var_3
	)}}

happyReduce_12 = happyReduce 5# 7# happyReduction_12
happyReduction_12 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_2 of { happy_var_2 -> 
	case happyOut16 happy_x_3 of { happy_var_3 -> 
	case happyOut26 happy_x_5 of { happy_var_5 -> 
	happyIn12
		 (ValueDecl happy_var_1 (reverse happy_var_2) happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}}

happyReduce_13 = happySpecReduce_3 7# happyReduction_13
happyReduction_13 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_3 of { happy_var_3 -> 
	happyIn12
		 (DeriveDecl happy_var_2 happy_var_3
	)}}

happyReduce_14 = happySpecReduce_0 8# happyReduction_14
happyReduction_14  =  happyIn13
		 ([]
	)

happyReduce_15 = happySpecReduce_3 8# happyReduction_15
happyReduction_15 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut12 happy_x_2 of { happy_var_2 -> 
	happyIn13
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_16 = happySpecReduce_3 9# happyReduction_16
happyReduction_16 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn14
		 (ConsDecl happy_var_1 happy_var_3
	)}}

happyReduce_17 = happySpecReduce_0 10# happyReduction_17
happyReduction_17  =  happyIn15
		 ([]
	)

happyReduce_18 = happySpecReduce_1 10# happyReduction_18
happyReduction_18 happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	happyIn15
		 ((:[]) happy_var_1
	)}

happyReduce_19 = happySpecReduce_3 10# happyReduction_19
happyReduction_19 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_3 of { happy_var_3 -> 
	happyIn15
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_20 = happySpecReduce_2 11# happyReduction_20
happyReduction_20 happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_2 of { happy_var_2 -> 
	happyIn16
		 (GuardExp happy_var_2
	)}

happyReduce_21 = happySpecReduce_0 11# happyReduction_21
happyReduction_21  =  happyIn16
		 (GuardNo
	)

happyReduce_22 = happySpecReduce_3 12# happyReduction_22
happyReduction_22 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	case happyOut17 happy_x_3 of { happy_var_3 -> 
	happyIn17
		 (POr happy_var_1 happy_var_3
	)}}

happyReduce_23 = happySpecReduce_1 12# happyReduction_23
happyReduction_23 happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	happyIn17
		 (happy_var_1
	)}

happyReduce_24 = happySpecReduce_3 13# happyReduction_24
happyReduction_24 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOut18 happy_x_3 of { happy_var_3 -> 
	happyIn18
		 (PListCons happy_var_1 happy_var_3
	)}}

happyReduce_25 = happySpecReduce_1 13# happyReduction_25
happyReduction_25 happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	happyIn18
		 (happy_var_1
	)}

happyReduce_26 = happySpecReduce_3 14# happyReduction_26
happyReduction_26 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_2 of { happy_var_2 -> 
	case happyOut23 happy_x_3 of { happy_var_3 -> 
	happyIn19
		 (PConsTop happy_var_1 happy_var_2 (reverse happy_var_3)
	)}}}

happyReduce_27 = happySpecReduce_1 14# happyReduction_27
happyReduction_27 happy_x_1
	 =  case happyOut20 happy_x_1 of { happy_var_1 -> 
	happyIn19
		 (happy_var_1
	)}

happyReduce_28 = happyReduce 4# 15# happyReduction_28
happyReduction_28 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut25 happy_x_3 of { happy_var_3 -> 
	happyIn20
		 (PRec happy_var_3
	) `HappyStk` happyRest}

happyReduce_29 = happySpecReduce_2 15# happyReduction_29
happyReduction_29 happy_x_2
	happy_x_1
	 =  happyIn20
		 (PEmptyList
	)

happyReduce_30 = happySpecReduce_3 15# happyReduction_30
happyReduction_30 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_2 of { happy_var_2 -> 
	happyIn20
		 (PList happy_var_2
	)}

happyReduce_31 = happyReduce 5# 15# happyReduction_31
happyReduction_31 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut21 happy_x_2 of { happy_var_2 -> 
	case happyOut22 happy_x_4 of { happy_var_4 -> 
	happyIn20
		 (PTuple happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_32 = happySpecReduce_1 15# happyReduction_32
happyReduction_32 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 (PStr happy_var_1
	)}

happyReduce_33 = happySpecReduce_1 15# happyReduction_33
happyReduction_33 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 (PInt happy_var_1
	)}

happyReduce_34 = happySpecReduce_1 15# happyReduction_34
happyReduction_34 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 (PVar happy_var_1
	)}

happyReduce_35 = happySpecReduce_1 15# happyReduction_35
happyReduction_35 happy_x_1
	 =  happyIn20
		 (PWild
	)

happyReduce_36 = happySpecReduce_3 15# happyReduction_36
happyReduction_36 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut17 happy_x_2 of { happy_var_2 -> 
	happyIn20
		 (happy_var_2
	)}

happyReduce_37 = happySpecReduce_1 16# happyReduction_37
happyReduction_37 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn21
		 (CommaPattern happy_var_1
	)}

happyReduce_38 = happySpecReduce_1 17# happyReduction_38
happyReduction_38 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn22
		 ((:[]) happy_var_1
	)}

happyReduce_39 = happySpecReduce_3 17# happyReduction_39
happyReduction_39 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_3 of { happy_var_3 -> 
	happyIn22
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_40 = happySpecReduce_0 18# happyReduction_40
happyReduction_40  =  happyIn23
		 ([]
	)

happyReduce_41 = happySpecReduce_2 18# happyReduction_41
happyReduction_41 happy_x_2
	happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_2 of { happy_var_2 -> 
	happyIn23
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_42 = happySpecReduce_3 19# happyReduction_42
happyReduction_42 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut17 happy_x_3 of { happy_var_3 -> 
	happyIn24
		 (FieldPattern happy_var_1 happy_var_3
	)}}

happyReduce_43 = happySpecReduce_0 20# happyReduction_43
happyReduction_43  =  happyIn25
		 ([]
	)

happyReduce_44 = happySpecReduce_1 20# happyReduction_44
happyReduction_44 happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	happyIn25
		 ((:[]) happy_var_1
	)}

happyReduce_45 = happySpecReduce_3 20# happyReduction_45
happyReduction_45 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	case happyOut25 happy_x_3 of { happy_var_3 -> 
	happyIn25
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_46 = happyReduce 7# 21# happyReduction_46
happyReduction_46 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut27 happy_x_2 of { happy_var_2 -> 
	case happyOut26 happy_x_4 of { happy_var_4 -> 
	case happyOut26 happy_x_7 of { happy_var_7 -> 
	happyIn26
		 (EPi happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_47 = happySpecReduce_3 21# happyReduction_47
happyReduction_47 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn26
		 (EPiNoVar happy_var_1 happy_var_3
	)}}

happyReduce_48 = happySpecReduce_1 21# happyReduction_48
happyReduction_48 happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 (happy_var_1
	)}

happyReduce_49 = happySpecReduce_1 22# happyReduction_49
happyReduction_49 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 (VVar happy_var_1
	)}

happyReduce_50 = happySpecReduce_1 22# happyReduction_50
happyReduction_50 happy_x_1
	 =  happyIn27
		 (VWild
	)

happyReduce_51 = happyReduce 4# 23# happyReduction_51
happyReduction_51 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut27 happy_x_2 of { happy_var_2 -> 
	case happyOut28 happy_x_4 of { happy_var_4 -> 
	happyIn28
		 (EAbs happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_52 = happyReduce 6# 23# happyReduction_52
happyReduction_52 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut30 happy_x_3 of { happy_var_3 -> 
	case happyOut28 happy_x_6 of { happy_var_6 -> 
	happyIn28
		 (ELet happy_var_3 happy_var_6
	) `HappyStk` happyRest}}

happyReduce_53 = happyReduce 6# 23# happyReduction_53
happyReduction_53 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut26 happy_x_2 of { happy_var_2 -> 
	case happyOut32 happy_x_5 of { happy_var_5 -> 
	happyIn28
		 (ECase happy_var_2 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_54 = happyReduce 6# 23# happyReduction_54
happyReduction_54 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut26 happy_x_2 of { happy_var_2 -> 
	case happyOut26 happy_x_4 of { happy_var_4 -> 
	case happyOut28 happy_x_6 of { happy_var_6 -> 
	happyIn28
		 (EIf happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_55 = happyReduce 5# 23# happyReduction_55
happyReduction_55 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut34 happy_x_3 of { happy_var_3 -> 
	case happyOut26 happy_x_4 of { happy_var_4 -> 
	happyIn28
		 (EDo (reverse happy_var_3) happy_var_4
	) `HappyStk` happyRest}}

happyReduce_56 = happySpecReduce_1 23# happyReduction_56
happyReduction_56 happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	happyIn28
		 (happy_var_1
	)}

happyReduce_57 = happySpecReduce_3 24# happyReduction_57
happyReduction_57 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn29
		 (LetDef happy_var_1 happy_var_3
	)}}

happyReduce_58 = happySpecReduce_0 25# happyReduction_58
happyReduction_58  =  happyIn30
		 ([]
	)

happyReduce_59 = happySpecReduce_1 25# happyReduction_59
happyReduction_59 happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	happyIn30
		 ((:[]) happy_var_1
	)}

happyReduce_60 = happySpecReduce_3 25# happyReduction_60
happyReduction_60 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn30
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_61 = happyReduce 4# 26# happyReduction_61
happyReduction_61 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut17 happy_x_1 of { happy_var_1 -> 
	case happyOut16 happy_x_2 of { happy_var_2 -> 
	case happyOut26 happy_x_4 of { happy_var_4 -> 
	happyIn31
		 (Case happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_62 = happySpecReduce_0 27# happyReduction_62
happyReduction_62  =  happyIn32
		 ([]
	)

happyReduce_63 = happySpecReduce_1 27# happyReduction_63
happyReduction_63 happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	happyIn32
		 ((:[]) happy_var_1
	)}

happyReduce_64 = happySpecReduce_3 27# happyReduction_64
happyReduction_64 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_65 = happySpecReduce_3 28# happyReduction_65
happyReduction_65 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (BindVar happy_var_1 happy_var_3
	)}}

happyReduce_66 = happySpecReduce_1 28# happyReduction_66
happyReduction_66 happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (BindNoVar happy_var_1
	)}

happyReduce_67 = happySpecReduce_0 29# happyReduction_67
happyReduction_67  =  happyIn34
		 ([]
	)

happyReduce_68 = happySpecReduce_3 29# happyReduction_68
happyReduction_68 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut33 happy_x_2 of { happy_var_2 -> 
	happyIn34
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_69 = happySpecReduce_3 30# happyReduction_69
happyReduction_69 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (EBind happy_var_1 happy_var_3
	)}}

happyReduce_70 = happySpecReduce_3 30# happyReduction_70
happyReduction_70 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (EBindC happy_var_1 happy_var_3
	)}}

happyReduce_71 = happySpecReduce_1 30# happyReduction_71
happyReduction_71 happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 (happy_var_1
	)}

happyReduce_72 = happySpecReduce_3 31# happyReduction_72
happyReduction_72 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut37 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 (EOr happy_var_1 happy_var_3
	)}}

happyReduce_73 = happySpecReduce_1 31# happyReduction_73
happyReduction_73 happy_x_1
	 =  case happyOut37 happy_x_1 of { happy_var_1 -> 
	happyIn36
		 (happy_var_1
	)}

happyReduce_74 = happySpecReduce_3 32# happyReduction_74
happyReduction_74 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_3 of { happy_var_3 -> 
	happyIn37
		 (EAnd happy_var_1 happy_var_3
	)}}

happyReduce_75 = happySpecReduce_1 32# happyReduction_75
happyReduction_75 happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	happyIn37
		 (happy_var_1
	)}

happyReduce_76 = happySpecReduce_3 33# happyReduction_76
happyReduction_76 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (EEq happy_var_1 happy_var_3
	)}}

happyReduce_77 = happySpecReduce_3 33# happyReduction_77
happyReduction_77 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (ENe happy_var_1 happy_var_3
	)}}

happyReduce_78 = happySpecReduce_3 33# happyReduction_78
happyReduction_78 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (ELt happy_var_1 happy_var_3
	)}}

happyReduce_79 = happySpecReduce_3 33# happyReduction_79
happyReduction_79 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (ELe happy_var_1 happy_var_3
	)}}

happyReduce_80 = happySpecReduce_3 33# happyReduction_80
happyReduction_80 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (EGt happy_var_1 happy_var_3
	)}}

happyReduce_81 = happySpecReduce_3 33# happyReduction_81
happyReduction_81 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (EGe happy_var_1 happy_var_3
	)}}

happyReduce_82 = happySpecReduce_1 33# happyReduction_82
happyReduction_82 happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	happyIn38
		 (happy_var_1
	)}

happyReduce_83 = happySpecReduce_3 34# happyReduction_83
happyReduction_83 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn39
		 (EListCons happy_var_1 happy_var_3
	)}}

happyReduce_84 = happySpecReduce_1 34# happyReduction_84
happyReduction_84 happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	happyIn39
		 (happy_var_1
	)}

happyReduce_85 = happySpecReduce_3 35# happyReduction_85
happyReduction_85 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut41 happy_x_3 of { happy_var_3 -> 
	happyIn40
		 (EAdd happy_var_1 happy_var_3
	)}}

happyReduce_86 = happySpecReduce_3 35# happyReduction_86
happyReduction_86 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut41 happy_x_3 of { happy_var_3 -> 
	happyIn40
		 (ESub happy_var_1 happy_var_3
	)}}

happyReduce_87 = happySpecReduce_1 35# happyReduction_87
happyReduction_87 happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	happyIn40
		 (happy_var_1
	)}

happyReduce_88 = happySpecReduce_3 36# happyReduction_88
happyReduction_88 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_3 of { happy_var_3 -> 
	happyIn41
		 (EMul happy_var_1 happy_var_3
	)}}

happyReduce_89 = happySpecReduce_3 36# happyReduction_89
happyReduction_89 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_3 of { happy_var_3 -> 
	happyIn41
		 (EDiv happy_var_1 happy_var_3
	)}}

happyReduce_90 = happySpecReduce_3 36# happyReduction_90
happyReduction_90 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_3 of { happy_var_3 -> 
	happyIn41
		 (EMod happy_var_1 happy_var_3
	)}}

happyReduce_91 = happySpecReduce_1 36# happyReduction_91
happyReduction_91 happy_x_1
	 =  case happyOut42 happy_x_1 of { happy_var_1 -> 
	happyIn41
		 (happy_var_1
	)}

happyReduce_92 = happySpecReduce_2 37# happyReduction_92
happyReduction_92 happy_x_2
	happy_x_1
	 =  case happyOut42 happy_x_2 of { happy_var_2 -> 
	happyIn42
		 (ENeg happy_var_2
	)}

happyReduce_93 = happySpecReduce_1 37# happyReduction_93
happyReduction_93 happy_x_1
	 =  case happyOut43 happy_x_1 of { happy_var_1 -> 
	happyIn42
		 (happy_var_1
	)}

happyReduce_94 = happySpecReduce_2 38# happyReduction_94
happyReduction_94 happy_x_2
	happy_x_1
	 =  case happyOut43 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_2 of { happy_var_2 -> 
	happyIn43
		 (EApp happy_var_1 happy_var_2
	)}}

happyReduce_95 = happySpecReduce_1 38# happyReduction_95
happyReduction_95 happy_x_1
	 =  case happyOut44 happy_x_1 of { happy_var_1 -> 
	happyIn43
		 (happy_var_1
	)}

happyReduce_96 = happySpecReduce_3 39# happyReduction_96
happyReduction_96 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut44 happy_x_1 of { happy_var_1 -> 
	case happyOut5 happy_x_3 of { happy_var_3 -> 
	happyIn44
		 (EProj happy_var_1 happy_var_3
	)}}

happyReduce_97 = happySpecReduce_1 39# happyReduction_97
happyReduction_97 happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 (happy_var_1
	)}

happyReduce_98 = happyReduce 4# 40# happyReduction_98
happyReduction_98 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut47 happy_x_3 of { happy_var_3 -> 
	happyIn45
		 (ERecType happy_var_3
	) `HappyStk` happyRest}

happyReduce_99 = happyReduce 4# 40# happyReduction_99
happyReduction_99 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut49 happy_x_3 of { happy_var_3 -> 
	happyIn45
		 (ERec happy_var_3
	) `HappyStk` happyRest}

happyReduce_100 = happySpecReduce_2 40# happyReduction_100
happyReduction_100 happy_x_2
	happy_x_1
	 =  happyIn45
		 (EEmptyList
	)

happyReduce_101 = happySpecReduce_3 40# happyReduction_101
happyReduction_101 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut51 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (EList happy_var_2
	)}

happyReduce_102 = happyReduce 5# 40# happyReduction_102
happyReduction_102 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut26 happy_x_2 of { happy_var_2 -> 
	case happyOut51 happy_x_4 of { happy_var_4 -> 
	happyIn45
		 (ETuple happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_103 = happySpecReduce_1 40# happyReduction_103
happyReduction_103 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (EVar happy_var_1
	)}

happyReduce_104 = happySpecReduce_1 40# happyReduction_104
happyReduction_104 happy_x_1
	 =  happyIn45
		 (EType
	)

happyReduce_105 = happySpecReduce_1 40# happyReduction_105
happyReduction_105 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (EStr happy_var_1
	)}

happyReduce_106 = happySpecReduce_1 40# happyReduction_106
happyReduction_106 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (EInteger happy_var_1
	)}

happyReduce_107 = happySpecReduce_1 40# happyReduction_107
happyReduction_107 happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (EDouble happy_var_1
	)}

happyReduce_108 = happySpecReduce_1 40# happyReduction_108
happyReduction_108 happy_x_1
	 =  happyIn45
		 (EMeta
	)

happyReduce_109 = happySpecReduce_3 40# happyReduction_109
happyReduction_109 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (happy_var_2
	)}

happyReduce_110 = happySpecReduce_3 41# happyReduction_110
happyReduction_110 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn46
		 (FieldType happy_var_1 happy_var_3
	)}}

happyReduce_111 = happySpecReduce_0 42# happyReduction_111
happyReduction_111  =  happyIn47
		 ([]
	)

happyReduce_112 = happySpecReduce_1 42# happyReduction_112
happyReduction_112 happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	happyIn47
		 ((:[]) happy_var_1
	)}

happyReduce_113 = happySpecReduce_3 42# happyReduction_113
happyReduction_113 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_3 of { happy_var_3 -> 
	happyIn47
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_114 = happySpecReduce_3 43# happyReduction_114
happyReduction_114 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_3 of { happy_var_3 -> 
	happyIn48
		 (FieldValue happy_var_1 happy_var_3
	)}}

happyReduce_115 = happySpecReduce_0 44# happyReduction_115
happyReduction_115  =  happyIn49
		 ([]
	)

happyReduce_116 = happySpecReduce_1 44# happyReduction_116
happyReduction_116 happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	happyIn49
		 ((:[]) happy_var_1
	)}

happyReduce_117 = happySpecReduce_3 44# happyReduction_117
happyReduction_117 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	case happyOut49 happy_x_3 of { happy_var_3 -> 
	happyIn49
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_118 = happySpecReduce_1 45# happyReduction_118
happyReduction_118 happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (happy_var_1
	)}

happyReduce_119 = happySpecReduce_1 46# happyReduction_119
happyReduction_119 happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	happyIn51
		 ((:[]) happy_var_1
	)}

happyReduce_120 = happySpecReduce_3 46# happyReduction_120
happyReduction_120 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	case happyOut51 happy_x_3 of { happy_var_3 -> 
	happyIn51
		 ((:) happy_var_1 happy_var_3
	)}}

happyNewToken action sts stk [] =
	happyDoAction 54# (error "reading EOF!") action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	PT _ (TS ";") -> cont 1#;
	PT _ (TS ":") -> cont 2#;
	PT _ (TS "{") -> cont 3#;
	PT _ (TS "}") -> cont 4#;
	PT _ (TS "=") -> cont 5#;
	PT _ (TS "|") -> cont 6#;
	PT _ (TS "||") -> cont 7#;
	PT _ (TS "::") -> cont 8#;
	PT _ (TS "(") -> cont 9#;
	PT _ (TS ")") -> cont 10#;
	PT _ (TS "[") -> cont 11#;
	PT _ (TS "]") -> cont 12#;
	PT _ (TS ",") -> cont 13#;
	PT _ (TS "_") -> cont 14#;
	PT _ (TS "->") -> cont 15#;
	PT _ (TS "\\") -> cont 16#;
	PT _ (TS "<-") -> cont 17#;
	PT _ (TS ">>=") -> cont 18#;
	PT _ (TS ">>") -> cont 19#;
	PT _ (TS "&&") -> cont 20#;
	PT _ (TS "==") -> cont 21#;
	PT _ (TS "/=") -> cont 22#;
	PT _ (TS "<") -> cont 23#;
	PT _ (TS "<=") -> cont 24#;
	PT _ (TS ">") -> cont 25#;
	PT _ (TS ">=") -> cont 26#;
	PT _ (TS "+") -> cont 27#;
	PT _ (TS "-") -> cont 28#;
	PT _ (TS "*") -> cont 29#;
	PT _ (TS "/") -> cont 30#;
	PT _ (TS "%") -> cont 31#;
	PT _ (TS ".") -> cont 32#;
	PT _ (TS "?") -> cont 33#;
	PT _ (TS "Type") -> cont 34#;
	PT _ (TS "case") -> cont 35#;
	PT _ (TS "data") -> cont 36#;
	PT _ (TS "derive") -> cont 37#;
	PT _ (TS "do") -> cont 38#;
	PT _ (TS "else") -> cont 39#;
	PT _ (TS "if") -> cont 40#;
	PT _ (TS "import") -> cont 41#;
	PT _ (TS "in") -> cont 42#;
	PT _ (TS "let") -> cont 43#;
	PT _ (TS "of") -> cont 44#;
	PT _ (TS "rec") -> cont 45#;
	PT _ (TS "sig") -> cont 46#;
	PT _ (TS "then") -> cont 47#;
	PT _ (TS "where") -> cont 48#;
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

pModule tks = happySomeParser where
  happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut9 x))

pExp tks = happySomeParser where
  happySomeParser = happyThen (happyParse 1# tks) (\x -> happyReturn (happyOut26 x))

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
