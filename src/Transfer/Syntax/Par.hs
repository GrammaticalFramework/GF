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
happyIn8 :: (Module) -> (HappyAbsSyn )
happyIn8 x = unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn ) -> (Module)
happyOut8 x = unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (Import) -> (HappyAbsSyn )
happyIn9 x = unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> (Import)
happyOut9 x = unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: ([Import]) -> (HappyAbsSyn )
happyIn10 x = unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> ([Import])
happyOut10 x = unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: (Decl) -> (HappyAbsSyn )
happyIn11 x = unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> (Decl)
happyOut11 x = unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: ([Decl]) -> (HappyAbsSyn )
happyIn12 x = unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> ([Decl])
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
happyIn15 :: (Pattern) -> (HappyAbsSyn )
happyIn15 x = unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> (Pattern)
happyOut15 x = unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (Pattern) -> (HappyAbsSyn )
happyIn16 x = unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> (Pattern)
happyOut16 x = unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: ([Pattern]) -> (HappyAbsSyn )
happyIn17 x = unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> ([Pattern])
happyOut17 x = unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: (FieldPattern) -> (HappyAbsSyn )
happyIn18 x = unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> (FieldPattern)
happyOut18 x = unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: ([FieldPattern]) -> (HappyAbsSyn )
happyIn19 x = unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> ([FieldPattern])
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
happyIn26 :: (VarOrWild) -> (HappyAbsSyn )
happyIn26 x = unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> (VarOrWild)
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
happyIn29 :: (Exp) -> (HappyAbsSyn )
happyIn29 x = unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> (Exp)
happyOut29 x = unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: (Exp) -> (HappyAbsSyn )
happyIn30 x = unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> (Exp)
happyOut30 x = unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: (Exp) -> (HappyAbsSyn )
happyIn31 x = unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> (Exp)
happyOut31 x = unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: (Exp) -> (HappyAbsSyn )
happyIn32 x = unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> (Exp)
happyOut32 x = unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (Exp) -> (HappyAbsSyn )
happyIn33 x = unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (Exp)
happyOut33 x = unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyIn34 :: (Exp) -> (HappyAbsSyn )
happyIn34 x = unsafeCoerce# x
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> (Exp)
happyOut34 x = unsafeCoerce# x
{-# INLINE happyOut34 #-}
happyIn35 :: (Exp) -> (HappyAbsSyn )
happyIn35 x = unsafeCoerce# x
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> (Exp)
happyOut35 x = unsafeCoerce# x
{-# INLINE happyOut35 #-}
happyIn36 :: (FieldType) -> (HappyAbsSyn )
happyIn36 x = unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> (FieldType)
happyOut36 x = unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: ([FieldType]) -> (HappyAbsSyn )
happyIn37 x = unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> ([FieldType])
happyOut37 x = unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: (FieldValue) -> (HappyAbsSyn )
happyIn38 x = unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> (FieldValue)
happyOut38 x = unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: ([FieldValue]) -> (HappyAbsSyn )
happyIn39 x = unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> ([FieldValue])
happyOut39 x = unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: (Exp) -> (HappyAbsSyn )
happyIn40 x = unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> (Exp)
happyOut40 x = unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyInTok :: Token -> (HappyAbsSyn )
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x91\x02\x2a\x00\x85\x02\x00\x00\x00\x00\x00\x00\x00\x00\x80\x02\x00\x00\xa2\x02\x87\x02\x99\x02\x8b\x02\xe8\x01\x00\x00\x58\x00\x90\x02\x00\x00\x00\x00\x1a\x00\x15\x00\xfb\xff\x53\x00\x00\x00\x2a\x00\x2a\x00\xa1\x02\x00\x00\x00\x00\x66\x02\x8f\x02\x70\x02\x5b\x02\x00\x00\x81\x02\x7e\x02\x00\x00\x45\x02\x45\x02\x47\x02\x40\x02\x1e\x02\x23\x02\x00\x00\x2a\x00\x00\x00\x2e\x02\x00\x00\xfe\xff\x2c\x02\x30\x02\x6e\x00\x0c\x02\xcd\x01\xc0\x01\xad\x01\x00\x00\xfd\x01\x89\x01\x53\x00\x53\x00\x53\x00\x53\x00\x53\x00\x53\x00\x53\x00\x53\x00\x53\x00\x53\x00\x53\x00\x53\x00\x53\x00\x2a\x00\x00\x00\x00\x00\x00\x00\xe8\x01\xe8\x01\x86\x00\x86\x00\x86\x00\x86\x00\x86\x00\x86\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xea\x01\x00\x00\xea\x01\x2a\x00\x2a\x00\x2a\x00\x00\x00\x2a\x00\x8e\x01\x2a\x00\x7f\x01\x70\x01\x5d\x01\x00\x00\xe9\x01\x4f\x01\x70\x02\x44\x00\x2a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcb\x01\x2a\x00\xcb\x01\x00\x00\x00\x00\x00\x00\x2a\x00\x00\x00\x21\x01\xbb\x01\x2a\x00\x14\x01\x4f\x00\x00\x00\x1a\x01\x00\x00\x00\x00\x0f\x01\x00\x00\xfe\x01\x00\x00\xf8\x00\x4f\x00\xe8\x00\x00\x00\xe0\x00\xcd\x00\x2a\x00\xec\x01\x00\x00\x2a\x00\x9d\x00\x00\x00\x00\x00\xd9\x01\xb0\x00\x9b\x00\x00\x00\x6a\x00\x4f\x00\x3a\x00\x92\x00\x00\x00\x2a\x00\x00\x00\x00\x00\x4f\x00\x2a\x00\x00\x00\x2a\x00\x00\x00\x4f\x00\x00\x00\x00\x00\x00\x00\x5b\x00\x00\x00\x00\x00\x00\x00\x79\x00\x57\x00\x73\x00\x00\x00\x05\x00\x2a\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x9e\x02\xbc\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x56\x02\x00\x00\x00\x00\x00\x00\x72\x00\x6d\x00\x1c\x00\x53\x02\x00\x00\xac\x01\x9c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa0\x02\x66\x00\x00\x00\x0e\x00\x00\x00\x00\x00\x5c\x00\x37\x00\x49\x00\x54\x00\x00\x00\x00\x00\x00\x00\x8c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x32\x00\x00\x00\x46\x02\x42\x02\x3e\x02\x1f\x02\x10\x02\x0a\x02\x00\x02\xfa\x01\xeb\x01\x34\x02\x2f\x02\xdb\x01\xcc\x01\x7c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x06\x00\x00\x00\x02\x00\x6c\x01\x5c\x01\x4c\x01\x00\x00\x3c\x01\x00\x00\x2c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x2c\x00\x00\x00\x8d\x02\x86\x02\x1c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe1\x01\x0c\x01\x26\x00\x00\x00\x00\x00\x00\x00\xfc\x00\x00\x00\x00\x00\x35\x00\xec\x00\x00\x00\x77\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x67\x02\x00\x00\x00\x00\x00\x00\x00\x00\xdc\x00\x00\x00\x00\x00\xcc\x00\x00\x00\x0d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2b\x00\x7a\x02\x96\x00\x00\x00\x00\x00\xbc\x00\x00\x00\x00\x00\x6b\x02\xac\x00\xfc\xff\x9c\x00\x00\x00\x96\x00\x00\x00\x00\x00\x00\x00\x8e\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5a\x00\x8c\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xf8\xff\x00\x00\x00\x00\xfd\xff\xae\xff\xac\xff\xab\xff\x00\x00\xa3\xff\xcc\xff\xc8\xff\xc6\xff\xbf\xff\xbc\xff\xb8\xff\xb6\xff\xb4\xff\xb2\xff\xd8\xff\x00\x00\x00\x00\x00\x00\x00\x00\xad\xff\x00\x00\x00\x00\x00\x00\xfc\xff\xfb\xff\x00\x00\xf7\xff\xf1\xff\x00\x00\xf9\xff\xe1\xff\xf0\xff\xfa\xff\x00\x00\x00\x00\xf8\xff\xd6\xff\x00\x00\x00\x00\xb7\xff\x00\x00\xcb\xff\x00\x00\xca\xff\xcb\xff\x00\x00\x00\x00\x00\x00\xa8\xff\x00\x00\xa5\xff\x00\x00\xb1\xff\x00\x00\xb5\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcd\xff\xc9\xff\xc7\xff\xbd\xff\xbe\xff\xc0\xff\xc1\xff\xc2\xff\xc3\xff\xc4\xff\xc5\xff\xb9\xff\xba\xff\xbb\xff\xb3\xff\xaf\xff\x00\x00\xb0\xff\x00\x00\x00\x00\x00\x00\x00\x00\xaa\xff\x00\x00\x00\x00\x00\x00\x00\x00\xd5\xff\x00\x00\xf6\xff\x00\x00\x00\x00\xf1\xff\x00\x00\x00\x00\xf4\xff\xe3\xff\xe5\xff\xe4\xff\xe0\xff\xde\xff\x00\x00\x00\x00\xe2\xff\xe6\xff\xef\xff\x00\x00\xf2\xff\x00\x00\xd6\xff\x00\x00\x00\x00\xd2\xff\xcf\xff\x00\x00\xa6\xff\xa9\xff\x00\x00\xa7\xff\x00\x00\xa4\xff\x00\x00\xe3\xff\x00\x00\xe9\xff\xd1\xff\x00\x00\x00\x00\x00\x00\xd4\xff\x00\x00\x00\x00\xe1\xff\xf3\xff\x00\x00\xdd\xff\x00\x00\xe7\xff\xde\xff\x00\x00\x00\x00\x00\x00\xdb\xff\x00\x00\xd9\xff\xda\xff\xd2\xff\x00\x00\xe1\xff\x00\x00\xce\xff\xea\xff\xd3\xff\xd0\xff\xd7\xff\xed\xff\xe8\xff\xdf\xff\xdc\xff\x00\x00\xec\xff\x00\x00\xf5\xff\xed\xff\x00\x00\xee\xff\xeb\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x03\x00\x00\x00\x08\x00\x06\x00\x07\x00\x00\x00\x09\x00\x0c\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x03\x00\x0c\x00\x0c\x00\x06\x00\x00\x00\x08\x00\x04\x00\x0a\x00\x25\x00\x1f\x00\x20\x00\x25\x00\x26\x00\x27\x00\x00\x00\x21\x00\x22\x00\x14\x00\x25\x00\x00\x00\x00\x00\x03\x00\x19\x00\x1a\x00\x06\x00\x15\x00\x00\x00\x1e\x00\x0a\x00\x00\x00\x21\x00\x00\x00\x0d\x00\x0e\x00\x25\x00\x26\x00\x27\x00\x03\x00\x14\x00\x25\x00\x06\x00\x07\x00\x08\x00\x19\x00\x1a\x00\x10\x00\x11\x00\x03\x00\x1e\x00\x05\x00\x06\x00\x21\x00\x08\x00\x04\x00\x05\x00\x25\x00\x26\x00\x27\x00\x03\x00\x19\x00\x00\x00\x06\x00\x03\x00\x08\x00\x01\x00\x06\x00\x00\x00\x03\x00\x00\x00\x19\x00\x06\x00\x25\x00\x26\x00\x27\x00\x08\x00\x09\x00\x10\x00\x11\x00\x00\x00\x14\x00\x19\x00\x25\x00\x26\x00\x27\x00\x19\x00\x00\x00\x01\x00\x02\x00\x02\x00\x19\x00\x00\x00\x05\x00\x25\x00\x26\x00\x27\x00\x04\x00\x25\x00\x26\x00\x27\x00\x02\x00\x0f\x00\x25\x00\x26\x00\x27\x00\x25\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x25\x00\x23\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x03\x00\x00\x00\x01\x00\x02\x00\x13\x00\x14\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x04\x00\x14\x00\x0b\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x01\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x24\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x04\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x01\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x09\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x09\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x02\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x07\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x1d\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x20\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x02\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x04\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x01\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x02\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x03\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x18\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x04\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x01\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0f\x00\x00\x00\x01\x00\x02\x00\x23\x00\x14\x00\x04\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x05\x00\x23\x00\x25\x00\x00\x00\x16\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x0d\x00\x0e\x00\x25\x00\x05\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x15\x00\x16\x00\x17\x00\x00\x00\x01\x00\x02\x00\x05\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x01\x00\x25\x00\x25\x00\x00\x00\x01\x00\x02\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x25\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x02\x00\x07\x00\x00\x00\x01\x00\x02\x00\x09\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x23\x00\x00\x00\x01\x00\x02\x00\x22\x00\x00\x00\x01\x00\x02\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x00\x00\x01\x00\x02\x00\x00\x00\x01\x00\x02\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x25\x00\x1f\x00\x00\x00\x01\x00\x02\x00\x25\x00\x00\x00\x01\x00\x02\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x0b\x00\x1d\x00\x1e\x00\x0a\x00\x0b\x00\x00\x00\x01\x00\x02\x00\x00\x00\x01\x00\x02\x00\x12\x00\x13\x00\x01\x00\x25\x00\x0a\x00\x0b\x00\x02\x00\x0a\x00\x0b\x00\x00\x00\x01\x00\x02\x00\x12\x00\x13\x00\x1b\x00\x1c\x00\x00\x00\x00\x00\x29\x00\x01\x00\x0b\x00\x0b\x00\x06\x00\x07\x00\x25\x00\x08\x00\x09\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x00\x00\x03\x00\x04\x00\x05\x00\x03\x00\x0c\x00\x06\x00\x07\x00\x18\x00\x29\x00\x25\x00\x09\x00\xff\xff\xff\xff\xff\xff\xff\xff\x1f\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\xae\xff\x82\x00\x30\x00\xae\xff\xae\xff\x84\x00\xae\xff\xa4\x00\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\xae\xff\x14\x00\x99\x00\x6a\x00\x15\x00\x2d\x00\x30\x00\x39\x00\x16\x00\x04\x00\x34\x00\x83\x00\xae\xff\xae\xff\xae\xff\x91\x00\x36\x00\x85\x00\x17\x00\x04\x00\x93\x00\x78\x00\x14\x00\x18\x00\x19\x00\x15\x00\x2e\x00\x57\x00\x1a\x00\x16\x00\x63\x00\x1b\x00\x67\x00\x94\x00\xab\x00\x04\x00\x1c\x00\x1d\x00\x72\x00\x17\x00\x04\x00\x74\x00\xaa\x00\x75\x00\x18\x00\x19\x00\x64\x00\x8e\x00\x72\x00\x1a\x00\x73\x00\x74\x00\x1b\x00\x75\x00\x1e\x00\x66\x00\x04\x00\x1c\x00\x1d\x00\x72\x00\x76\x00\x63\x00\x74\x00\x14\x00\x75\x00\xb1\x00\x2d\x00\xac\x00\x14\x00\x68\x00\x76\x00\x2d\x00\x04\x00\x1c\x00\x1d\x00\xad\x00\xb3\x00\x64\x00\x65\x00\x21\x00\x17\x00\x76\x00\x04\x00\x1c\x00\x1d\x00\x18\x00\x30\x00\x05\x00\x06\x00\x5d\x00\x18\x00\x33\x00\x5e\x00\x04\x00\x1c\x00\x1d\x00\xb0\x00\x04\x00\x1c\x00\x1d\x00\xb2\x00\x31\x00\x04\x00\x1c\x00\x1d\x00\x04\x00\x08\x00\x32\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x05\x00\x06\x00\x04\x00\x12\x00\x34\x00\x35\x00\x36\x00\x37\x00\xa9\x00\x6d\x00\x6e\x00\x6f\x00\x45\x00\x46\x00\xb2\x00\x04\x00\x05\x00\x06\x00\x97\x00\x08\x00\x70\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\xa3\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x98\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\xa5\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x9b\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\xa7\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x9f\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x9b\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\xa0\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x9d\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\xa1\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x8d\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\xa3\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x90\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x5d\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x92\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x87\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x6c\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x8d\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x7c\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x90\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x7e\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x78\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x7f\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x7a\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x80\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x7b\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x81\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x7c\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x49\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x7e\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x31\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x3a\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x29\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x59\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x2a\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x5a\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x07\x00\x04\x00\x05\x00\x06\x00\x12\x00\x08\x00\x5b\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x05\x00\x06\x00\x99\x00\x12\x00\x04\x00\x93\x00\x4a\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x05\x00\x06\x00\x94\x00\x95\x00\x04\x00\x9d\x00\x4b\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x05\x00\x06\x00\x3c\x00\x3d\x00\x3e\x00\x04\x00\x05\x00\x06\x00\x5e\x00\x4e\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x05\x00\x06\x00\x5c\x00\x04\x00\x04\x00\x04\x00\x05\x00\x06\x00\x4f\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x50\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x05\x00\x06\x00\x04\x00\x51\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x52\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x05\x00\x06\x00\x5f\x00\x60\x00\x04\x00\x05\x00\x06\x00\x61\x00\x53\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x05\x00\x06\x00\x63\x00\x04\x00\x05\x00\x06\x00\x62\x00\x04\x00\x05\x00\x06\x00\x4c\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x4d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x05\x00\x06\x00\x04\x00\x05\x00\x06\x00\x54\x00\x0f\x00\x10\x00\x11\x00\x55\x00\x0f\x00\x10\x00\x11\x00\x56\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x21\x00\x6d\x00\x6e\x00\x6f\x00\x04\x00\x87\x00\x6e\x00\x6f\x00\x2b\x00\x0f\x00\x10\x00\x11\x00\xa1\x00\x3a\x00\x11\x00\x88\x00\x89\x00\x87\x00\x6e\x00\x6f\x00\x87\x00\x6e\x00\x6f\x00\x8a\x00\xa6\x00\x6a\x00\x04\x00\x88\x00\x89\x00\x6c\x00\xaa\x00\x89\x00\x6d\x00\x6e\x00\x6f\x00\x8a\x00\x8b\x00\x26\x00\x27\x00\x22\x00\xac\x00\xff\xff\x28\x00\x70\x00\x48\x00\x23\x00\x76\x00\x04\x00\xad\x00\xae\x00\x3f\x00\x40\x00\x41\x00\x42\x00\x43\x00\x44\x00\x45\x00\x46\x00\x22\x00\x1d\x00\x1e\x00\x1f\x00\x29\x00\x47\x00\x23\x00\x24\x00\x3a\x00\xff\xff\x04\x00\x49\x00\x00\x00\x00\x00\x00\x00\x00\x00\x21\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (2, 92) [
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
	(92 , happyReduce_92)
	]

happy_n_terms = 42 :: Int
happy_n_nonterms = 36 :: Int

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

happyReduce_5 = happySpecReduce_2 3# happyReduction_5
happyReduction_5 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut12 happy_x_2 of { happy_var_2 -> 
	happyIn8
		 (Module happy_var_1 happy_var_2
	)}}

happyReduce_6 = happySpecReduce_2 4# happyReduction_6
happyReduction_6 happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	happyIn9
		 (Import happy_var_2
	)}

happyReduce_7 = happySpecReduce_0 5# happyReduction_7
happyReduction_7  =  happyIn10
		 ([]
	)

happyReduce_8 = happySpecReduce_1 5# happyReduction_8
happyReduction_8 happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	happyIn10
		 ((:[]) happy_var_1
	)}

happyReduce_9 = happySpecReduce_3 5# happyReduction_9
happyReduction_9 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	case happyOut10 happy_x_3 of { happy_var_3 -> 
	happyIn10
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_10 = happyReduce 8# 6# happyReduction_10
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
	case happyOut20 happy_x_4 of { happy_var_4 -> 
	case happyOut14 happy_x_7 of { happy_var_7 -> 
	happyIn11
		 (DataDecl happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_11 = happySpecReduce_3 6# happyReduction_11
happyReduction_11 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn11
		 (TypeDecl happy_var_1 happy_var_3
	)}}

happyReduce_12 = happyReduce 4# 6# happyReduction_12
happyReduction_12 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut17 happy_x_2 of { happy_var_2 -> 
	case happyOut20 happy_x_4 of { happy_var_4 -> 
	happyIn11
		 (ValueDecl happy_var_1 (reverse happy_var_2) happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_13 = happySpecReduce_3 6# happyReduction_13
happyReduction_13 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut5 happy_x_3 of { happy_var_3 -> 
	happyIn11
		 (DeriveDecl happy_var_2 happy_var_3
	)}}

happyReduce_14 = happySpecReduce_0 7# happyReduction_14
happyReduction_14  =  happyIn12
		 ([]
	)

happyReduce_15 = happySpecReduce_1 7# happyReduction_15
happyReduction_15 happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	happyIn12
		 ((:[]) happy_var_1
	)}

happyReduce_16 = happySpecReduce_3 7# happyReduction_16
happyReduction_16 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	case happyOut12 happy_x_3 of { happy_var_3 -> 
	happyIn12
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_17 = happySpecReduce_3 8# happyReduction_17
happyReduction_17 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn13
		 (ConsDecl happy_var_1 happy_var_3
	)}}

happyReduce_18 = happySpecReduce_0 9# happyReduction_18
happyReduction_18  =  happyIn14
		 ([]
	)

happyReduce_19 = happySpecReduce_1 9# happyReduction_19
happyReduction_19 happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	happyIn14
		 ((:[]) happy_var_1
	)}

happyReduce_20 = happySpecReduce_3 9# happyReduction_20
happyReduction_20 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_3 of { happy_var_3 -> 
	happyIn14
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_21 = happySpecReduce_3 10# happyReduction_21
happyReduction_21 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut16 happy_x_2 of { happy_var_2 -> 
	case happyOut17 happy_x_3 of { happy_var_3 -> 
	happyIn15
		 (PConsTop happy_var_1 happy_var_2 (reverse happy_var_3)
	)}}}

happyReduce_22 = happySpecReduce_1 10# happyReduction_22
happyReduction_22 happy_x_1
	 =  case happyOut16 happy_x_1 of { happy_var_1 -> 
	happyIn15
		 (happy_var_1
	)}

happyReduce_23 = happyReduce 4# 11# happyReduction_23
happyReduction_23 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_2 of { happy_var_2 -> 
	case happyOut17 happy_x_3 of { happy_var_3 -> 
	happyIn16
		 (PCons happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_24 = happySpecReduce_3 11# happyReduction_24
happyReduction_24 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_2 of { happy_var_2 -> 
	happyIn16
		 (PRec happy_var_2
	)}

happyReduce_25 = happySpecReduce_1 11# happyReduction_25
happyReduction_25 happy_x_1
	 =  happyIn16
		 (PType
	)

happyReduce_26 = happySpecReduce_1 11# happyReduction_26
happyReduction_26 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (PStr happy_var_1
	)}

happyReduce_27 = happySpecReduce_1 11# happyReduction_27
happyReduction_27 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (PInt happy_var_1
	)}

happyReduce_28 = happySpecReduce_1 11# happyReduction_28
happyReduction_28 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (PVar happy_var_1
	)}

happyReduce_29 = happySpecReduce_1 11# happyReduction_29
happyReduction_29 happy_x_1
	 =  happyIn16
		 (PWild
	)

happyReduce_30 = happySpecReduce_0 12# happyReduction_30
happyReduction_30  =  happyIn17
		 ([]
	)

happyReduce_31 = happySpecReduce_2 12# happyReduction_31
happyReduction_31 happy_x_2
	happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	case happyOut16 happy_x_2 of { happy_var_2 -> 
	happyIn17
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_32 = happySpecReduce_3 13# happyReduction_32
happyReduction_32 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_3 of { happy_var_3 -> 
	happyIn18
		 (FieldPattern happy_var_1 happy_var_3
	)}}

happyReduce_33 = happySpecReduce_0 14# happyReduction_33
happyReduction_33  =  happyIn19
		 ([]
	)

happyReduce_34 = happySpecReduce_1 14# happyReduction_34
happyReduction_34 happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	happyIn19
		 ((:[]) happy_var_1
	)}

happyReduce_35 = happySpecReduce_3 14# happyReduction_35
happyReduction_35 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_3 of { happy_var_3 -> 
	happyIn19
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_36 = happyReduce 6# 15# happyReduction_36
happyReduction_36 (happy_x_6 `HappyStk`
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

happyReduce_37 = happyReduce 6# 15# happyReduction_37
happyReduction_37 (happy_x_6 `HappyStk`
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

happyReduce_38 = happyReduce 6# 15# happyReduction_38
happyReduction_38 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut20 happy_x_2 of { happy_var_2 -> 
	case happyOut20 happy_x_4 of { happy_var_4 -> 
	case happyOut20 happy_x_6 of { happy_var_6 -> 
	happyIn20
		 (EIf happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_39 = happySpecReduce_1 15# happyReduction_39
happyReduction_39 happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 (happy_var_1
	)}

happyReduce_40 = happyReduce 5# 16# happyReduction_40
happyReduction_40 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	case happyOut20 happy_x_5 of { happy_var_5 -> 
	happyIn21
		 (LetDef happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_41 = happySpecReduce_0 17# happyReduction_41
happyReduction_41  =  happyIn22
		 ([]
	)

happyReduce_42 = happySpecReduce_1 17# happyReduction_42
happyReduction_42 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn22
		 ((:[]) happy_var_1
	)}

happyReduce_43 = happySpecReduce_3 17# happyReduction_43
happyReduction_43 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut22 happy_x_3 of { happy_var_3 -> 
	happyIn22
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_44 = happySpecReduce_3 18# happyReduction_44
happyReduction_44 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn23
		 (Case happy_var_1 happy_var_3
	)}}

happyReduce_45 = happySpecReduce_0 19# happyReduction_45
happyReduction_45  =  happyIn24
		 ([]
	)

happyReduce_46 = happySpecReduce_1 19# happyReduction_46
happyReduction_46 happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn24
		 ((:[]) happy_var_1
	)}

happyReduce_47 = happySpecReduce_3 19# happyReduction_47
happyReduction_47 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	case happyOut24 happy_x_3 of { happy_var_3 -> 
	happyIn24
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_48 = happyReduce 4# 20# happyReduction_48
happyReduction_48 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut26 happy_x_2 of { happy_var_2 -> 
	case happyOut20 happy_x_4 of { happy_var_4 -> 
	happyIn25
		 (EAbs happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_49 = happyReduce 7# 20# happyReduction_49
happyReduction_49 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut26 happy_x_2 of { happy_var_2 -> 
	case happyOut20 happy_x_4 of { happy_var_4 -> 
	case happyOut20 happy_x_7 of { happy_var_7 -> 
	happyIn25
		 (EPi happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_50 = happySpecReduce_3 20# happyReduction_50
happyReduction_50 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn25
		 (EPiNoVar happy_var_1 happy_var_3
	)}}

happyReduce_51 = happySpecReduce_1 20# happyReduction_51
happyReduction_51 happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	happyIn25
		 (happy_var_1
	)}

happyReduce_52 = happySpecReduce_1 21# happyReduction_52
happyReduction_52 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 (VVar happy_var_1
	)}

happyReduce_53 = happySpecReduce_1 21# happyReduction_53
happyReduction_53 happy_x_1
	 =  happyIn26
		 (VWild
	)

happyReduce_54 = happySpecReduce_3 22# happyReduction_54
happyReduction_54 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	case happyOut27 happy_x_3 of { happy_var_3 -> 
	happyIn27
		 (EOr happy_var_1 happy_var_3
	)}}

happyReduce_55 = happySpecReduce_1 22# happyReduction_55
happyReduction_55 happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	happyIn27
		 (happy_var_1
	)}

happyReduce_56 = happySpecReduce_3 23# happyReduction_56
happyReduction_56 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	case happyOut28 happy_x_3 of { happy_var_3 -> 
	happyIn28
		 (EAnd happy_var_1 happy_var_3
	)}}

happyReduce_57 = happySpecReduce_1 23# happyReduction_57
happyReduction_57 happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	happyIn28
		 (happy_var_1
	)}

happyReduce_58 = happySpecReduce_3 24# happyReduction_58
happyReduction_58 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn29
		 (EEq happy_var_1 happy_var_3
	)}}

happyReduce_59 = happySpecReduce_3 24# happyReduction_59
happyReduction_59 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn29
		 (ENe happy_var_1 happy_var_3
	)}}

happyReduce_60 = happySpecReduce_3 24# happyReduction_60
happyReduction_60 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn29
		 (ELt happy_var_1 happy_var_3
	)}}

happyReduce_61 = happySpecReduce_3 24# happyReduction_61
happyReduction_61 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn29
		 (ELe happy_var_1 happy_var_3
	)}}

happyReduce_62 = happySpecReduce_3 24# happyReduction_62
happyReduction_62 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn29
		 (EGt happy_var_1 happy_var_3
	)}}

happyReduce_63 = happySpecReduce_3 24# happyReduction_63
happyReduction_63 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn29
		 (EGe happy_var_1 happy_var_3
	)}}

happyReduce_64 = happySpecReduce_1 24# happyReduction_64
happyReduction_64 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn29
		 (happy_var_1
	)}

happyReduce_65 = happySpecReduce_3 25# happyReduction_65
happyReduction_65 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn30
		 (EAdd happy_var_1 happy_var_3
	)}}

happyReduce_66 = happySpecReduce_3 25# happyReduction_66
happyReduction_66 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn30
		 (ESub happy_var_1 happy_var_3
	)}}

happyReduce_67 = happySpecReduce_1 25# happyReduction_67
happyReduction_67 happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	happyIn30
		 (happy_var_1
	)}

happyReduce_68 = happySpecReduce_3 26# happyReduction_68
happyReduction_68 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn31
		 (EMul happy_var_1 happy_var_3
	)}}

happyReduce_69 = happySpecReduce_3 26# happyReduction_69
happyReduction_69 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn31
		 (EDiv happy_var_1 happy_var_3
	)}}

happyReduce_70 = happySpecReduce_3 26# happyReduction_70
happyReduction_70 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn31
		 (EMod happy_var_1 happy_var_3
	)}}

happyReduce_71 = happySpecReduce_1 26# happyReduction_71
happyReduction_71 happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	happyIn31
		 (happy_var_1
	)}

happyReduce_72 = happySpecReduce_2 27# happyReduction_72
happyReduction_72 happy_x_2
	happy_x_1
	 =  case happyOut32 happy_x_2 of { happy_var_2 -> 
	happyIn32
		 (ENeg happy_var_2
	)}

happyReduce_73 = happySpecReduce_1 27# happyReduction_73
happyReduction_73 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn32
		 (happy_var_1
	)}

happyReduce_74 = happySpecReduce_2 28# happyReduction_74
happyReduction_74 happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn33
		 (EApp happy_var_1 happy_var_2
	)}}

happyReduce_75 = happySpecReduce_1 28# happyReduction_75
happyReduction_75 happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (happy_var_1
	)}

happyReduce_76 = happySpecReduce_3 29# happyReduction_76
happyReduction_76 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut5 happy_x_3 of { happy_var_3 -> 
	happyIn34
		 (EProj happy_var_1 happy_var_3
	)}}

happyReduce_77 = happySpecReduce_1 29# happyReduction_77
happyReduction_77 happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (happy_var_1
	)}

happyReduce_78 = happySpecReduce_2 30# happyReduction_78
happyReduction_78 happy_x_2
	happy_x_1
	 =  happyIn35
		 (EEmptyRec
	)

happyReduce_79 = happySpecReduce_3 30# happyReduction_79
happyReduction_79 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut37 happy_x_2 of { happy_var_2 -> 
	happyIn35
		 (ERecType happy_var_2
	)}

happyReduce_80 = happySpecReduce_3 30# happyReduction_80
happyReduction_80 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_2 of { happy_var_2 -> 
	happyIn35
		 (ERec happy_var_2
	)}

happyReduce_81 = happySpecReduce_1 30# happyReduction_81
happyReduction_81 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 (EVar happy_var_1
	)}

happyReduce_82 = happySpecReduce_1 30# happyReduction_82
happyReduction_82 happy_x_1
	 =  happyIn35
		 (EType
	)

happyReduce_83 = happySpecReduce_1 30# happyReduction_83
happyReduction_83 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 (EStr happy_var_1
	)}

happyReduce_84 = happySpecReduce_1 30# happyReduction_84
happyReduction_84 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 (EInt happy_var_1
	)}

happyReduce_85 = happySpecReduce_3 30# happyReduction_85
happyReduction_85 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut20 happy_x_2 of { happy_var_2 -> 
	happyIn35
		 (happy_var_2
	)}

happyReduce_86 = happySpecReduce_3 31# happyReduction_86
happyReduction_86 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 (FieldType happy_var_1 happy_var_3
	)}}

happyReduce_87 = happySpecReduce_1 32# happyReduction_87
happyReduction_87 happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	happyIn37
		 ((:[]) happy_var_1
	)}

happyReduce_88 = happySpecReduce_3 32# happyReduction_88
happyReduction_88 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_3 of { happy_var_3 -> 
	happyIn37
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_89 = happySpecReduce_3 33# happyReduction_89
happyReduction_89 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (FieldValue happy_var_1 happy_var_3
	)}}

happyReduce_90 = happySpecReduce_1 34# happyReduction_90
happyReduction_90 happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	happyIn39
		 ((:[]) happy_var_1
	)}

happyReduce_91 = happySpecReduce_3 34# happyReduction_91
happyReduction_91 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn39
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_92 = happySpecReduce_1 35# happyReduction_92
happyReduction_92 happy_x_1
	 =  case happyOut25 happy_x_1 of { happy_var_1 -> 
	happyIn40
		 (happy_var_1
	)}

happyNewToken action sts stk [] =
	happyDoAction 41# (error "reading EOF!") action sts stk []

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
	PT _ (TS "->") -> cont 9#;
	PT _ (TS "\\") -> cont 10#;
	PT _ (TS "||") -> cont 11#;
	PT _ (TS "&&") -> cont 12#;
	PT _ (TS "==") -> cont 13#;
	PT _ (TS "/=") -> cont 14#;
	PT _ (TS "<") -> cont 15#;
	PT _ (TS "<=") -> cont 16#;
	PT _ (TS ">") -> cont 17#;
	PT _ (TS ">=") -> cont 18#;
	PT _ (TS "+") -> cont 19#;
	PT _ (TS "-") -> cont 20#;
	PT _ (TS "*") -> cont 21#;
	PT _ (TS "/") -> cont 22#;
	PT _ (TS "%") -> cont 23#;
	PT _ (TS ".") -> cont 24#;
	PT _ (TS "Type") -> cont 25#;
	PT _ (TS "case") -> cont 26#;
	PT _ (TS "data") -> cont 27#;
	PT _ (TS "derive") -> cont 28#;
	PT _ (TS "else") -> cont 29#;
	PT _ (TS "if") -> cont 30#;
	PT _ (TS "import") -> cont 31#;
	PT _ (TS "in") -> cont 32#;
	PT _ (TS "let") -> cont 33#;
	PT _ (TS "of") -> cont 34#;
	PT _ (TS "then") -> cont 35#;
	PT _ (TS "where") -> cont 36#;
	PT _ (TV happy_dollar_dollar) -> cont 37#;
	PT _ (TL happy_dollar_dollar) -> cont 38#;
	PT _ (TI happy_dollar_dollar) -> cont 39#;
	_ -> cont 40#;
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
  happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut8 x))

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
