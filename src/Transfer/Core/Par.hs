{-# OPTIONS -fglasgow-exts -cpp #-}
module Transfer.Core.Par where
import Transfer.Core.Abs
import Transfer.Core.Lex
import Transfer.ErrM
import Array
#if __GLASGOW_HASKELL__ >= 503
import GHC.Exts
#else
import GlaExts
#endif

-- parser produced by Happy Version 1.15

newtype HappyAbsSyn  = HappyAbsSyn (() -> ())
happyIn5 :: (String) -> (HappyAbsSyn )
happyIn5 x = unsafeCoerce# x
{-# INLINE happyIn5 #-}
happyOut5 :: (HappyAbsSyn ) -> (String)
happyOut5 x = unsafeCoerce# x
{-# INLINE happyOut5 #-}
happyIn6 :: (Integer) -> (HappyAbsSyn )
happyIn6 x = unsafeCoerce# x
{-# INLINE happyIn6 #-}
happyOut6 :: (HappyAbsSyn ) -> (Integer)
happyOut6 x = unsafeCoerce# x
{-# INLINE happyOut6 #-}
happyIn7 :: (Double) -> (HappyAbsSyn )
happyIn7 x = unsafeCoerce# x
{-# INLINE happyIn7 #-}
happyOut7 :: (HappyAbsSyn ) -> (Double)
happyOut7 x = unsafeCoerce# x
{-# INLINE happyOut7 #-}
happyIn8 :: (TMeta) -> (HappyAbsSyn )
happyIn8 x = unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn ) -> (TMeta)
happyOut8 x = unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (CIdent) -> (HappyAbsSyn )
happyIn9 x = unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> (CIdent)
happyOut9 x = unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: (Module) -> (HappyAbsSyn )
happyIn10 x = unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> (Module)
happyOut10 x = unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: ([Decl]) -> (HappyAbsSyn )
happyIn11 x = unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> ([Decl])
happyOut11 x = unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: (Decl) -> (HappyAbsSyn )
happyIn12 x = unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> (Decl)
happyOut12 x = unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: (ConsDecl) -> (HappyAbsSyn )
happyIn13 x = unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn ) -> (ConsDecl)
happyOut13 x = unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: ([ConsDecl]) -> (HappyAbsSyn )
happyIn14 x = unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> ([ConsDecl])
happyOut14 x = unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: ([Pattern]) -> (HappyAbsSyn )
happyIn15 x = unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> ([Pattern])
happyOut15 x = unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (Pattern) -> (HappyAbsSyn )
happyIn16 x = unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> (Pattern)
happyOut16 x = unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: (FieldPattern) -> (HappyAbsSyn )
happyIn17 x = unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> (FieldPattern)
happyOut17 x = unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: ([FieldPattern]) -> (HappyAbsSyn )
happyIn18 x = unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> ([FieldPattern])
happyOut18 x = unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: (PatternVariable) -> (HappyAbsSyn )
happyIn19 x = unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> (PatternVariable)
happyOut19 x = unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: (Exp) -> (HappyAbsSyn )
happyIn20 x = unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> (Exp)
happyOut20 x = unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: (LetDef) -> (HappyAbsSyn )
happyIn21 x = unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> (LetDef)
happyOut21 x = unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyIn22 :: ([LetDef]) -> (HappyAbsSyn )
happyIn22 x = unsafeCoerce# x
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn ) -> ([LetDef])
happyOut22 x = unsafeCoerce# x
{-# INLINE happyOut22 #-}
happyIn23 :: (Case) -> (HappyAbsSyn )
happyIn23 x = unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> (Case)
happyOut23 x = unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: ([Case]) -> (HappyAbsSyn )
happyIn24 x = unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> ([Case])
happyOut24 x = unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: (Exp) -> (HappyAbsSyn )
happyIn25 x = unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> (Exp)
happyOut25 x = unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: (Exp) -> (HappyAbsSyn )
happyIn26 x = unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> (Exp)
happyOut26 x = unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: (Exp) -> (HappyAbsSyn )
happyIn27 x = unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> (Exp)
happyOut27 x = unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: (Exp) -> (HappyAbsSyn )
happyIn28 x = unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> (Exp)
happyOut28 x = unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: (FieldType) -> (HappyAbsSyn )
happyIn29 x = unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> (FieldType)
happyOut29 x = unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: ([FieldType]) -> (HappyAbsSyn )
happyIn30 x = unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> ([FieldType])
happyOut30 x = unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: (FieldValue) -> (HappyAbsSyn )
happyIn31 x = unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> (FieldValue)
happyOut31 x = unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: ([FieldValue]) -> (HappyAbsSyn )
happyIn32 x = unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> ([FieldValue])
happyOut32 x = unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (Exp) -> (HappyAbsSyn )
happyIn33 x = unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (Exp)
happyOut33 x = unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyInTok :: Token -> (HappyAbsSyn )
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x15\x00\x5f\x01\xcd\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd0\x00\x00\x00\x7c\x01\xde\x00\x00\x00\x00\x00\x4a\x01\x09\x00\x00\x00\x5f\x01\xdf\x00\xd7\x00\xd6\x00\x00\x00\x00\x00\x00\x00\x00\x00\x35\x00\xbc\x00\x00\x00\xd1\x00\xc7\x00\xcf\x00\x15\x00\x5f\x01\x5f\x01\xc6\x00\xc6\x00\xc6\x00\xbe\x00\x00\x00\xc5\x00\x00\x00\x74\x01\xcb\x00\xc0\x00\xac\x00\xb9\x00\x5f\x01\x00\x00\x00\x00\x5f\x01\x5f\x01\xc1\x00\xb8\x00\xbb\x00\xb7\x00\xb5\x00\xb3\x00\xaf\x00\xb0\x00\xa9\x00\x9d\x00\x00\x00\x00\x00\x00\x00\x5f\x01\x94\x00\x00\x00\x86\x00\x5f\x01\x00\x00\x86\x00\x5f\x01\x8f\x00\x84\x00\x5f\x01\x99\x01\x00\x00\x90\x00\x8b\x00\x00\x00\x00\x00\x8d\x00\x00\x00\x8c\x00\x8a\x00\x7a\x00\x00\x00\x89\x00\x00\x00\x00\x00\x5f\x01\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x69\x00\x00\x00\x69\x00\x00\x00\x00\x00\x99\x01\x5f\x01\x5f\x01\x00\x00\x71\x00\x00\x00\x91\x01\x75\x00\x78\x00\x74\x00\x6d\x00\x65\x00\x5c\x00\x00\x00\x43\x00\x5f\x01\x00\x00\x43\x00\x99\x01\x00\x00\x00\x00\x5f\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x4e\x00\x31\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x38\x01\x00\x00\x00\x00\x00\x00\x01\x00\x04\x00\x00\x00\x14\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x45\x00\x00\x00\x6a\x00\x0b\x01\xee\x00\x28\x00\x44\x00\x57\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x31\x00\x00\x00\xe5\x00\x00\x00\x00\x00\xc8\x00\xbf\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa2\x00\x00\x00\x00\x00\x02\x00\x99\x00\x00\x00\x1e\x00\x7c\x00\x00\x00\x03\x00\x73\x00\xb5\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x18\x00\x00\x00\x00\x00\x00\x00\x00\x00\x56\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa3\x00\x00\x00\x3e\x00\xff\xff\x00\x00\xa9\x01\x4d\x00\x30\x00\x00\x00\x00\x00\x00\x00\xbe\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7d\x00\x27\x00\x00\x00\x21\x00\x3e\x01\x00\x00\x00\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xf7\xff\x00\x00\x00\x00\xfd\xff\xc9\xff\xc8\xff\xc7\xff\xc6\xff\xcb\xff\x00\x00\xdd\xff\xbc\xff\xd0\xff\xce\xff\xd2\xff\x00\x00\x00\x00\xca\xff\x00\x00\x00\x00\x00\x00\x00\x00\xfc\xff\xfb\xff\xfa\xff\xf9\xff\x00\x00\x00\x00\xf8\xff\xf6\xff\x00\x00\x00\x00\xf7\xff\x00\x00\x00\x00\xc3\xff\xbf\xff\xdb\xff\x00\x00\xe1\xff\x00\x00\xe0\xff\xe1\xff\x00\x00\x00\x00\x00\x00\xd1\xff\x00\x00\xcf\xff\xc5\xff\x00\x00\x00\x00\x00\x00\x00\x00\xda\xff\x00\x00\x00\x00\xbe\xff\x00\x00\x00\x00\xc2\xff\x00\x00\xf2\xff\xf3\xff\xf5\xff\x00\x00\x00\x00\xcd\xff\xc3\xff\x00\x00\xcc\xff\xbf\xff\x00\x00\x00\x00\xdb\xff\x00\x00\xd7\xff\xd4\xff\x00\x00\x00\x00\xe7\xff\xe6\xff\x00\x00\xea\xff\xd6\xff\x00\x00\x00\x00\xe8\xff\x00\x00\xdc\xff\xd9\xff\x00\x00\xc0\xff\xbd\xff\xc4\xff\xc1\xff\x00\x00\xf0\xff\xdf\xff\xe4\xff\xed\xff\xde\xff\xd7\xff\x00\x00\x00\x00\xd3\xff\x00\x00\xd5\xff\x00\x00\x00\x00\xe3\xff\x00\x00\x00\x00\xef\xff\x00\x00\xf4\xff\xf0\xff\x00\x00\xe9\xff\xe4\xff\x00\x00\xec\xff\xeb\xff\x00\x00\xd8\xff\xe5\xff\xe2\xff\xf1\xff\xee\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x04\x00\x04\x00\x04\x00\x0a\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x0e\x00\x0f\x00\x08\x00\x0e\x00\x10\x00\x11\x00\x14\x00\x15\x00\x16\x00\x17\x00\x0f\x00\x18\x00\x19\x00\x04\x00\x1c\x00\x14\x00\x15\x00\x16\x00\x17\x00\x04\x00\x1a\x00\x0f\x00\x04\x00\x1c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x04\x00\x0c\x00\x0d\x00\x1a\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x04\x00\x0f\x00\x02\x00\x1a\x00\x1b\x00\x05\x00\x14\x00\x15\x00\x16\x00\x17\x00\x0f\x00\x18\x00\x19\x00\x04\x00\x1c\x00\x14\x00\x15\x00\x16\x00\x17\x00\x04\x00\x04\x00\x0c\x00\x0d\x00\x1c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x04\x00\x05\x00\x06\x00\x07\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x04\x00\x0f\x00\x1a\x00\x1a\x00\x1b\x00\x04\x00\x14\x00\x15\x00\x16\x00\x17\x00\x0f\x00\x01\x00\x10\x00\x11\x00\x1c\x00\x14\x00\x15\x00\x16\x00\x17\x00\x04\x00\x02\x00\x06\x00\x07\x00\x1c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x04\x00\x01\x00\x05\x00\x0a\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x04\x00\x0f\x00\x1a\x00\x03\x00\x08\x00\x09\x00\x14\x00\x15\x00\x16\x00\x17\x00\x0f\x00\x03\x00\x01\x00\x04\x00\x1c\x00\x14\x00\x15\x00\x16\x00\x17\x00\x1a\x00\x0a\x00\x09\x00\x07\x00\x1c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x1a\x00\x10\x00\x1a\x00\x04\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x04\x00\x0f\x00\x15\x00\x01\x00\x08\x00\x09\x00\x14\x00\x15\x00\x16\x00\x17\x00\x0f\x00\x02\x00\x04\x00\x01\x00\x1c\x00\x14\x00\x15\x00\x16\x00\x17\x00\x05\x00\x04\x00\x01\x00\x05\x00\x1c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x03\x00\x0c\x00\x1a\x00\x07\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x02\x00\x0f\x00\x0a\x00\x12\x00\x02\x00\x01\x00\x14\x00\x15\x00\x16\x00\x17\x00\x0f\x00\x1c\x00\x03\x00\x03\x00\x1c\x00\x14\x00\x15\x00\x16\x00\x17\x00\x1a\x00\x1a\x00\x03\x00\x16\x00\x1c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x0c\x00\xff\xff\x1c\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\x0f\x00\xff\xff\xff\xff\xff\xff\xff\xff\x14\x00\x15\x00\x16\x00\x17\x00\x0f\x00\xff\xff\xff\xff\xff\xff\x1c\x00\x14\x00\x15\x00\x16\x00\x17\x00\xff\xff\xff\xff\xff\xff\xff\xff\x1c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\x0f\x00\xff\xff\xff\xff\xff\xff\xff\xff\x14\x00\x15\x00\x16\x00\x17\x00\x0f\x00\xff\xff\xff\xff\xff\xff\x1c\x00\x14\x00\x15\x00\x16\x00\x17\x00\xff\xff\xff\xff\xff\xff\xff\xff\x1c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\x00\x00\x01\x00\x0f\x00\xff\xff\x04\x00\xff\xff\xff\xff\x14\x00\x15\x00\x16\x00\x17\x00\x0b\x00\xff\xff\xff\xff\x0e\x00\x1c\x00\x16\x00\x17\x00\x06\x00\xff\xff\x08\x00\xff\xff\xff\xff\x0b\x00\xff\xff\x0d\x00\x0e\x00\xff\xff\xff\xff\x11\x00\xff\xff\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x06\x00\xff\xff\xff\xff\xff\xff\xff\xff\x0b\x00\xff\xff\x0d\x00\x0e\x00\xff\xff\xff\xff\x11\x00\xff\xff\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x06\x00\x07\x00\xff\xff\xff\xff\xff\xff\xff\xff\x0c\x00\x0d\x00\x06\x00\xff\xff\xff\xff\xff\xff\xff\xff\x13\x00\x14\x00\x0d\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x13\x00\x14\x00\xff\xff\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x06\x00\x07\x00\x08\x00\xff\xff\xff\xff\xff\xff\xff\xff\x0d\x00\x06\x00\xff\xff\x08\x00\xff\xff\xff\xff\x13\x00\xff\xff\x0d\x00\x16\x00\x17\x00\x00\x00\x01\x00\x1a\x00\x13\x00\x04\x00\xff\xff\x16\x00\x17\x00\xff\xff\xff\xff\x1a\x00\x0b\x00\x00\x00\x01\x00\x0e\x00\xff\xff\x04\x00\xff\xff\x12\x00\x13\x00\xff\xff\x00\x00\x01\x00\x0b\x00\xff\xff\x04\x00\x0e\x00\xff\xff\xff\xff\xff\xff\x12\x00\x13\x00\x0b\x00\xff\xff\xff\xff\x0e\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x2a\x00\x3b\x00\x35\x00\x27\x00\x6c\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x2b\x00\x2c\x00\x2a\x00\x28\x00\x36\x00\x5a\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x7c\x00\x3c\x00\x5f\x00\x64\x00\x0e\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x38\x00\x1a\x00\x1f\x00\x6d\x00\x0e\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x3b\x00\x6e\x00\x7e\x00\x1a\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x30\x00\x7f\x00\x22\x00\x39\x00\x5d\x00\x23\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x69\x00\x3c\x00\x3d\x00\x6d\x00\x0e\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x38\x00\x1f\x00\x6e\x00\x6f\x00\x0e\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x35\x00\x6a\x00\x1a\x00\x39\x00\x3a\x00\x74\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x62\x00\x75\x00\x36\x00\x37\x00\x0e\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x1a\x00\x76\x00\x40\x00\x1d\x00\x0e\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x77\x00\x78\x00\x79\x00\x7c\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x70\x00\x59\x00\x1a\x00\x62\x00\x71\x00\x80\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x5c\x00\x64\x00\x67\x00\x66\x00\x0e\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x1a\x00\x69\x00\x68\x00\x50\x00\x0e\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x1a\x00\x5c\x00\x1a\x00\x44\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x70\x00\x5e\x00\x61\x00\x45\x00\x71\x00\x72\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x42\x00\x46\x00\x47\x00\x48\x00\x0e\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x0e\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x4d\x00\x2e\x00\x1a\x00\x32\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x33\x00\x4d\x00\x34\x00\x35\x00\x42\x00\x21\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x4e\x00\xff\xff\x24\x00\x25\x00\x0e\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x1a\x00\x1a\x00\x26\x00\x04\x00\x0e\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x2e\x00\x00\x00\xff\xff\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x00\x00\x2c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x00\x00\x3f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x26\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x07\x00\x08\x00\x00\x00\x50\x00\x51\x00\x09\x00\x00\x00\x27\x00\x00\x00\x00\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x7d\x00\x00\x00\x00\x00\x53\x00\x0e\x00\x2e\x00\x0d\x00\x10\x00\x00\x00\x2a\x00\x00\x00\x00\x00\x11\x00\x00\x00\x12\x00\x13\x00\x00\x00\x00\x00\x14\x00\x00\x00\x15\x00\x16\x00\x00\x00\x04\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x11\x00\x00\x00\x12\x00\x13\x00\x00\x00\x00\x00\x14\x00\x00\x00\x15\x00\x16\x00\x00\x00\x04\x00\x17\x00\x18\x00\x19\x00\x1a\x00\xcb\xff\xcb\xff\x00\x00\x00\x00\x00\x00\x00\x00\xcb\xff\xcb\xff\x30\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcb\xff\xcb\xff\x12\x00\xcb\xff\xcb\xff\xcb\xff\xcb\xff\xcb\xff\x15\x00\x16\x00\x00\x00\x04\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x57\x00\x7b\x00\x2a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x58\x00\x57\x00\x00\x00\x2a\x00\x00\x00\x00\x00\x59\x00\x00\x00\x58\x00\x04\x00\x17\x00\x50\x00\x51\x00\x1a\x00\x59\x00\x27\x00\x00\x00\x04\x00\x17\x00\x00\x00\x00\x00\x1a\x00\x52\x00\x50\x00\x51\x00\x53\x00\x00\x00\x27\x00\x00\x00\x54\x00\x6b\x00\x00\x00\x50\x00\x51\x00\x52\x00\x00\x00\x27\x00\x53\x00\x00\x00\x00\x00\x00\x00\x54\x00\x55\x00\x79\x00\x00\x00\x00\x00\x53\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (2, 67) [
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
	(67 , happyReduce_67)
	]

happy_n_terms = 29 :: Int
happy_n_nonterms = 29 :: Int

happyReduce_2 = happySpecReduce_1 0# happyReduction_2
happyReduction_2 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TL happy_var_1)) -> 
	happyIn5
		 (happy_var_1
	)}

happyReduce_3 = happySpecReduce_1 1# happyReduction_3
happyReduction_3 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TI happy_var_1)) -> 
	happyIn6
		 ((read happy_var_1) :: Integer
	)}

happyReduce_4 = happySpecReduce_1 2# happyReduction_4
happyReduction_4 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TD happy_var_1)) -> 
	happyIn7
		 ((read happy_var_1) :: Double
	)}

happyReduce_5 = happySpecReduce_1 3# happyReduction_5
happyReduction_5 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (T_TMeta happy_var_1)) -> 
	happyIn8
		 (TMeta (happy_var_1)
	)}

happyReduce_6 = happySpecReduce_1 4# happyReduction_6
happyReduction_6 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (T_CIdent happy_var_1)) -> 
	happyIn9
		 (CIdent (happy_var_1)
	)}

happyReduce_7 = happySpecReduce_1 5# happyReduction_7
happyReduction_7 happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	happyIn10
		 (Module happy_var_1
	)}

happyReduce_8 = happySpecReduce_0 6# happyReduction_8
happyReduction_8  =  happyIn11
		 ([]
	)

happyReduce_9 = happySpecReduce_1 6# happyReduction_9
happyReduction_9 happy_x_1
	 =  case happyOut12 happy_x_1 of { happy_var_1 -> 
	happyIn11
		 ((:[]) happy_var_1
	)}

happyReduce_10 = happySpecReduce_3 6# happyReduction_10
happyReduction_10 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut12 happy_x_1 of { happy_var_1 -> 
	case happyOut11 happy_x_3 of { happy_var_3 -> 
	happyIn11
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_11 = happyReduce 8# 7# happyReduction_11
happyReduction_11 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut9 happy_x_2 of { happy_var_2 -> 
	case happyOut20 happy_x_4 of { happy_var_4 -> 
	case happyOut14 happy_x_7 of { happy_var_7 -> 
	happyIn12
		 (DataDecl happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_12 = happySpecReduce_3 7# happyReduction_12
happyReduction_12 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn12
		 (TypeDecl happy_var_1 happy_var_3
	)}}

happyReduce_13 = happySpecReduce_3 7# happyReduction_13
happyReduction_13 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn12
		 (ValueDecl happy_var_1 happy_var_3
	)}}

happyReduce_14 = happySpecReduce_3 8# happyReduction_14
happyReduction_14 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (ConsDecl happy_var_1 happy_var_3
	)}}

happyReduce_15 = happySpecReduce_0 9# happyReduction_15
happyReduction_15  =  happyIn14
		 ([]
	)

happyReduce_16 = happySpecReduce_1 9# happyReduction_16
happyReduction_16 happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	happyIn14
		 ((:[]) happy_var_1
	)}

happyReduce_17 = happySpecReduce_3 9# happyReduction_17
happyReduction_17 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_3 of { happy_var_3 -> 
	happyIn14
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_18 = happySpecReduce_0 10# happyReduction_18
happyReduction_18  =  happyIn15
		 ([]
	)

happyReduce_19 = happySpecReduce_2 10# happyReduction_19
happyReduction_19 happy_x_2
	happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut16 happy_x_2 of { happy_var_2 -> 
	happyIn15
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_20 = happyReduce 4# 11# happyReduction_20
happyReduction_20 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut9 happy_x_2 of { happy_var_2 -> 
	case happyOut15 happy_x_3 of { happy_var_3 -> 
	happyIn16
		 (PCons happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_21 = happySpecReduce_1 11# happyReduction_21
happyReduction_21 happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (PVar happy_var_1
	)}

happyReduce_22 = happyReduce 4# 11# happyReduction_22
happyReduction_22 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut18 happy_x_3 of { happy_var_3 -> 
	happyIn16
		 (PRec happy_var_3
	) `HappyStk` happyRest}

happyReduce_23 = happySpecReduce_1 11# happyReduction_23
happyReduction_23 happy_x_1
	 =  happyIn16
		 (PType
	)

happyReduce_24 = happySpecReduce_1 11# happyReduction_24
happyReduction_24 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (PStr happy_var_1
	)}

happyReduce_25 = happySpecReduce_1 11# happyReduction_25
happyReduction_25 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (PInt happy_var_1
	)}

happyReduce_26 = happySpecReduce_3 12# happyReduction_26
happyReduction_26 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut16 happy_x_3 of { happy_var_3 -> 
	happyIn17
		 (FieldPattern happy_var_1 happy_var_3
	)}}

happyReduce_27 = happySpecReduce_0 13# happyReduction_27
happyReduction_27  =  happyIn18
		 ([]
	)

happyReduce_28 = happySpecReduce_1 13# happyReduction_28
happyReduction_28 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn18
		 ((:[]) happy_var_1
	)}

happyReduce_29 = happySpecReduce_3 13# happyReduction_29
happyReduction_29 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	case happyOut18 happy_x_3 of { happy_var_3 -> 
	happyIn18
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_30 = happySpecReduce_1 14# happyReduction_30
happyReduction_30 happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	happyIn19
		 (PVVar happy_var_1
	)}

happyReduce_31 = happySpecReduce_1 14# happyReduction_31
happyReduction_31 happy_x_1
	 =  happyIn19
		 (PVWild
	)

happyReduce_32 = happyReduce 6# 15# happyReduction_32
happyReduction_32 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut22 happy_x_3 of { happy_var_3 -> 
	case happyOut20 happy_x_6 of { happy_var_6 -> 
	happyIn20
		 (ELet happy_var_3 happy_var_6
	) `HappyStk` happyRest}}

happyReduce_33 = happyReduce 6# 15# happyReduction_33
happyReduction_33 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut20 happy_x_2 of { happy_var_2 -> 
	case happyOut24 happy_x_5 of { happy_var_5 -> 
	happyIn20
		 (ECase happy_var_2 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_34 = happySpecReduce_1 15# happyReduction_34
happyReduction_34 happy_x_1
	 =  case happyOut25 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 (happy_var_1
	)}

happyReduce_35 = happySpecReduce_3 16# happyReduction_35
happyReduction_35 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn21
		 (LetDef happy_var_1 happy_var_3
	)}}

happyReduce_36 = happySpecReduce_0 17# happyReduction_36
happyReduction_36  =  happyIn22
		 ([]
	)

happyReduce_37 = happySpecReduce_1 17# happyReduction_37
happyReduction_37 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn22
		 ((:[]) happy_var_1
	)}

happyReduce_38 = happySpecReduce_3 17# happyReduction_38
happyReduction_38 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_3 of { happy_var_3 -> 
	happyIn22
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_39 = happyReduce 5# 18# happyReduction_39
happyReduction_39 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut16 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	case happyOut20 happy_x_5 of { happy_var_5 -> 
	happyIn23
		 (Case happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_40 = happySpecReduce_0 19# happyReduction_40
happyReduction_40  =  happyIn24
		 ([]
	)

happyReduce_41 = happySpecReduce_1 19# happyReduction_41
happyReduction_41 happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn24
		 ((:[]) happy_var_1
	)}

happyReduce_42 = happySpecReduce_3 19# happyReduction_42
happyReduction_42 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	case happyOut24 happy_x_3 of { happy_var_3 -> 
	happyIn24
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_43 = happyReduce 4# 20# happyReduction_43
happyReduction_43 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut19 happy_x_2 of { happy_var_2 -> 
	case happyOut20 happy_x_4 of { happy_var_4 -> 
	happyIn25
		 (EAbs happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_44 = happyReduce 7# 20# happyReduction_44
happyReduction_44 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut19 happy_x_2 of { happy_var_2 -> 
	case happyOut20 happy_x_4 of { happy_var_4 -> 
	case happyOut20 happy_x_7 of { happy_var_7 -> 
	happyIn25
		 (EPi happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_45 = happySpecReduce_1 20# happyReduction_45
happyReduction_45 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn25
		 (happy_var_1
	)}

happyReduce_46 = happySpecReduce_2 21# happyReduction_46
happyReduction_46 happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	case happyOut27 happy_x_2 of { happy_var_2 -> 
	happyIn26
		 (EApp happy_var_1 happy_var_2
	)}}

happyReduce_47 = happySpecReduce_1 21# happyReduction_47
happyReduction_47 happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 (happy_var_1
	)}

happyReduce_48 = happySpecReduce_3 22# happyReduction_48
happyReduction_48 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut9 happy_x_3 of { happy_var_3 -> 
	happyIn27
		 (EProj happy_var_1 happy_var_3
	)}}

happyReduce_49 = happySpecReduce_1 22# happyReduction_49
happyReduction_49 happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 (happy_var_1
	)}

happyReduce_50 = happyReduce 4# 23# happyReduction_50
happyReduction_50 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn28
		 (ERecType happy_var_3
	) `HappyStk` happyRest}

happyReduce_51 = happyReduce 4# 23# happyReduction_51
happyReduction_51 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn28
		 (ERec happy_var_3
	) `HappyStk` happyRest}

happyReduce_52 = happySpecReduce_1 23# happyReduction_52
happyReduction_52 happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	happyIn28
		 (EVar happy_var_1
	)}

happyReduce_53 = happySpecReduce_1 23# happyReduction_53
happyReduction_53 happy_x_1
	 =  happyIn28
		 (EType
	)

happyReduce_54 = happySpecReduce_1 23# happyReduction_54
happyReduction_54 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn28
		 (EStr happy_var_1
	)}

happyReduce_55 = happySpecReduce_1 23# happyReduction_55
happyReduction_55 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn28
		 (EInteger happy_var_1
	)}

happyReduce_56 = happySpecReduce_1 23# happyReduction_56
happyReduction_56 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn28
		 (EDouble happy_var_1
	)}

happyReduce_57 = happySpecReduce_1 23# happyReduction_57
happyReduction_57 happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	happyIn28
		 (EMeta happy_var_1
	)}

happyReduce_58 = happySpecReduce_3 23# happyReduction_58
happyReduction_58 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut20 happy_x_2 of { happy_var_2 -> 
	happyIn28
		 (happy_var_2
	)}

happyReduce_59 = happySpecReduce_3 24# happyReduction_59
happyReduction_59 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn29
		 (FieldType happy_var_1 happy_var_3
	)}}

happyReduce_60 = happySpecReduce_0 25# happyReduction_60
happyReduction_60  =  happyIn30
		 ([]
	)

happyReduce_61 = happySpecReduce_1 25# happyReduction_61
happyReduction_61 happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	happyIn30
		 ((:[]) happy_var_1
	)}

happyReduce_62 = happySpecReduce_3 25# happyReduction_62
happyReduction_62 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn30
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_63 = happySpecReduce_3 26# happyReduction_63
happyReduction_63 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn31
		 (FieldValue happy_var_1 happy_var_3
	)}}

happyReduce_64 = happySpecReduce_0 27# happyReduction_64
happyReduction_64  =  happyIn32
		 ([]
	)

happyReduce_65 = happySpecReduce_1 27# happyReduction_65
happyReduction_65 happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	happyIn32
		 ((:[]) happy_var_1
	)}

happyReduce_66 = happySpecReduce_3 27# happyReduction_66
happyReduction_66 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_67 = happySpecReduce_1 28# happyReduction_67
happyReduction_67 happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (happy_var_1
	)}

happyNewToken action sts stk [] =
	happyDoAction 28# (error "reading EOF!") action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	PT _ (TS ";") -> cont 1#;
	PT _ (TS ":") -> cont 2#;
	PT _ (TS "{") -> cont 3#;
	PT _ (TS "}") -> cont 4#;
	PT _ (TS "=") -> cont 5#;
	PT _ (TS "(") -> cont 6#;
	PT _ (TS ")") -> cont 7#;
	PT _ (TS "_") -> cont 8#;
	PT _ (TS "|") -> cont 9#;
	PT _ (TS "->") -> cont 10#;
	PT _ (TS "\\") -> cont 11#;
	PT _ (TS ".") -> cont 12#;
	PT _ (TS "Type") -> cont 13#;
	PT _ (TS "case") -> cont 14#;
	PT _ (TS "data") -> cont 15#;
	PT _ (TS "in") -> cont 16#;
	PT _ (TS "let") -> cont 17#;
	PT _ (TS "of") -> cont 18#;
	PT _ (TS "rec") -> cont 19#;
	PT _ (TS "sig") -> cont 20#;
	PT _ (TS "where") -> cont 21#;
	PT _ (TL happy_dollar_dollar) -> cont 22#;
	PT _ (TI happy_dollar_dollar) -> cont 23#;
	PT _ (TD happy_dollar_dollar) -> cont 24#;
	PT _ (T_TMeta happy_dollar_dollar) -> cont 25#;
	PT _ (T_CIdent happy_dollar_dollar) -> cont 26#;
	_ -> cont 27#;
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
  happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut10 x))

pExp tks = happySomeParser where
  happySomeParser = happyThen (happyParse 1# tks) (\x -> happyReturn (happyOut20 x))

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
