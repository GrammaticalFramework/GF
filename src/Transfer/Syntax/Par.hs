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
happyIn17 :: (Pattern) -> (HappyAbsSyn )
happyIn17 x = unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> (Pattern)
happyOut17 x = unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: ([Pattern]) -> (HappyAbsSyn )
happyIn18 x = unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> ([Pattern])
happyOut18 x = unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: (FieldPattern) -> (HappyAbsSyn )
happyIn19 x = unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> (FieldPattern)
happyOut19 x = unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: ([FieldPattern]) -> (HappyAbsSyn )
happyIn20 x = unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> ([FieldPattern])
happyOut20 x = unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: (Exp) -> (HappyAbsSyn )
happyIn21 x = unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> (Exp)
happyOut21 x = unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyIn22 :: (LetDef) -> (HappyAbsSyn )
happyIn22 x = unsafeCoerce# x
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn ) -> (LetDef)
happyOut22 x = unsafeCoerce# x
{-# INLINE happyOut22 #-}
happyIn23 :: ([LetDef]) -> (HappyAbsSyn )
happyIn23 x = unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> ([LetDef])
happyOut23 x = unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: (Case) -> (HappyAbsSyn )
happyIn24 x = unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> (Case)
happyOut24 x = unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: ([Case]) -> (HappyAbsSyn )
happyIn25 x = unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> ([Case])
happyOut25 x = unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: (Bind) -> (HappyAbsSyn )
happyIn26 x = unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> (Bind)
happyOut26 x = unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: ([Bind]) -> (HappyAbsSyn )
happyIn27 x = unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> ([Bind])
happyOut27 x = unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: (Exp) -> (HappyAbsSyn )
happyIn28 x = unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> (Exp)
happyOut28 x = unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: (VarOrWild) -> (HappyAbsSyn )
happyIn29 x = unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> (VarOrWild)
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
happyIn41 :: (FieldType) -> (HappyAbsSyn )
happyIn41 x = unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> (FieldType)
happyOut41 x = unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: ([FieldType]) -> (HappyAbsSyn )
happyIn42 x = unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> ([FieldType])
happyOut42 x = unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyIn43 :: (FieldValue) -> (HappyAbsSyn )
happyIn43 x = unsafeCoerce# x
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> (FieldValue)
happyOut43 x = unsafeCoerce# x
{-# INLINE happyOut43 #-}
happyIn44 :: ([FieldValue]) -> (HappyAbsSyn )
happyIn44 x = unsafeCoerce# x
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> ([FieldValue])
happyOut44 x = unsafeCoerce# x
{-# INLINE happyOut44 #-}
happyIn45 :: (Exp) -> (HappyAbsSyn )
happyIn45 x = unsafeCoerce# x
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> (Exp)
happyOut45 x = unsafeCoerce# x
{-# INLINE happyOut45 #-}
happyIn46 :: ([Exp]) -> (HappyAbsSyn )
happyIn46 x = unsafeCoerce# x
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> ([Exp])
happyOut46 x = unsafeCoerce# x
{-# INLINE happyOut46 #-}
happyInTok :: Token -> (HappyAbsSyn )
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x9b\x01\x29\x00\x92\x01\x00\x00\x00\x00\x00\x00\x00\x00\x90\x01\x00\x00\xfd\xff\x00\x00\xb4\x01\x9a\x01\xac\x01\xe6\x00\x6e\x01\x00\x00\x48\x00\x8f\x01\x00\x00\x00\x00\x12\x00\xf9\xff\x40\x00\x29\x00\x00\x00\x00\x00\x29\x00\xa5\x01\x29\x00\xa3\x01\xa2\x01\xa1\x01\x00\x00\x00\x00\x63\x01\x91\x01\xe5\xff\x61\x01\x00\x00\x8e\x01\x8d\x01\x00\x00\x55\x01\x55\x01\x5c\x01\x41\x01\x41\x01\x41\x01\x45\x01\x00\x00\x43\x01\x50\x01\x4f\x01\x00\x00\x29\x00\x00\x00\x4c\x01\x00\x00\x0f\x00\x64\x01\x4b\x01\x21\x01\x36\x01\x40\x00\x40\x00\x40\x00\x40\x00\x40\x00\x40\x00\x40\x00\x40\x00\x40\x00\x40\x00\x40\x00\x40\x00\x40\x00\x40\x00\x29\x00\x40\x00\x40\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x6e\x01\x6e\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x29\x00\x00\x00\x29\x00\x00\x00\x29\x00\x49\x01\x12\x00\x29\x00\x48\x01\x38\x01\x37\x01\x33\x01\x35\x01\x31\x01\x32\x01\x1d\x01\x15\x01\x00\x00\xea\x00\x13\x01\xe5\xff\xfc\xff\x29\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x29\x00\x55\x00\x00\x00\x00\x00\x11\x01\x00\x00\x29\x00\x00\x00\x00\x00\xd3\x00\x29\x00\x00\x00\xd3\x00\x29\x00\xe9\x00\xd1\x00\x29\x00\xda\x00\xbe\x00\xe7\x00\xcf\x00\x55\x00\x00\x00\x00\x00\xc1\x00\xbd\x00\x55\x00\xb4\x00\xb7\x00\x00\x00\xb8\x00\xb2\x00\x29\x00\x00\x00\x00\x00\x29\x00\xa0\x00\x00\x00\x29\x00\x00\x00\x00\x00\x00\x00\x00\x00\x78\x00\x72\x00\x8b\x00\x00\x00\x00\x00\x85\x00\x76\x00\x6f\x00\x63\x00\x00\x00\x29\x00\x00\x00\x00\x00\x00\x00\x55\x00\x55\x00\x29\x00\x00\x00\x29\x00\x00\x00\x55\x00\x00\x00\x00\x00\x00\x00\x00\x00\x27\x00\x00\x00\x27\x00\x55\x00\x00\x00\x00\x00\x43\x00\x3f\x00\x39\x00\x00\x00\x08\x00\x29\x00\x00\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\xe1\x00\x1b\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7e\x00\x00\x00\x00\x00\x00\x00\xd7\x00\x04\x00\xdf\x03\x8f\x00\x00\x00\x00\x00\x07\x03\x00\x00\xe3\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\x01\x36\x00\x00\x00\x05\x00\x00\x00\x00\x00\x32\x00\x2b\x00\x66\x00\x68\x00\x26\x00\x13\x00\x00\x00\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcf\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\x00\x00\x00\xdb\x03\xcb\x03\xc7\x03\xb2\x03\xc3\x03\xb7\x03\x9f\x03\x8e\x03\x87\x03\x7b\x03\x74\x03\xbf\x00\x63\x03\x50\x03\xab\x02\x3f\x03\x2c\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x97\x02\x00\x00\x73\x02\x00\x00\x7b\x00\x00\x00\xb3\x00\x5f\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x06\x00\x00\x00\xe3\x00\x53\x01\x3b\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x27\x02\x4e\x01\x00\x00\x00\x00\x00\x00\x00\x00\x03\x02\x00\x00\x00\x00\x64\x00\xef\x01\x00\x00\x14\x00\xcb\x01\x00\x00\x10\x00\xb7\x01\x00\x00\x00\x00\x00\x00\x00\x00\x03\x04\x00\x00\x00\x00\x00\x00\x00\x00\x1b\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x93\x01\x00\x00\x00\x00\x7f\x01\x00\x00\x00\x00\x5b\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x60\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x47\x01\x00\x00\x00\x00\x00\x00\x0c\x00\x16\x01\x23\x01\x02\x00\x0f\x01\x00\x00\x82\x00\x00\x00\x00\x00\x00\x00\x00\x00\x82\x01\x00\x00\x54\x00\xba\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x49\x00\xeb\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xf8\xff\x00\x00\x00\x00\xfd\xff\xa2\xff\xa0\xff\x9f\xff\x00\x00\x94\xff\xc5\xff\xc0\xff\xbe\xff\xbc\xff\xb5\xff\xb3\xff\xb0\xff\xac\xff\xaa\xff\xa8\xff\xa6\xff\xd5\xff\x00\x00\x00\x00\x00\x00\x93\xff\x9e\xff\xa1\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfc\xff\xfb\xff\x00\x00\xf7\xff\xf1\xff\x00\x00\xf9\xff\xdf\xff\xf0\xff\xfa\xff\x00\x00\x00\x00\xf8\xff\x9b\xff\x97\xff\xd3\xff\x00\x00\xca\xff\x00\x00\x92\xff\x00\x00\xab\xff\x00\x00\xc4\xff\x00\x00\xc3\xff\xa2\xff\x00\x00\x00\x00\x00\x00\xa9\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc1\xff\xc2\xff\xc6\xff\xbf\xff\xbd\xff\xb6\xff\xb7\xff\xb8\xff\xb9\xff\xba\xff\xbb\xff\xb1\xff\xb2\xff\xb4\xff\xad\xff\xae\xff\xaf\xff\xa7\xff\x00\x00\x9d\xff\x00\x00\xa3\xff\x93\xff\x00\x00\x00\x00\x00\x00\x00\x00\xd2\xff\x00\x00\x00\x00\x96\xff\x00\x00\x00\x00\x9a\xff\x00\x00\xf6\xff\x00\x00\x00\x00\xf1\xff\x00\x00\x00\x00\xf4\xff\xe2\xff\xe4\xff\xe3\xff\xde\xff\x00\x00\x00\x00\xe1\xff\xe5\xff\x00\x00\xef\xff\x00\x00\xf2\xff\xa5\xff\x9b\xff\x00\x00\xa4\xff\x97\xff\x00\x00\x00\x00\xd3\xff\x00\x00\x00\x00\xcb\xff\x00\x00\x00\x00\xcf\xff\x91\xff\xc8\xff\x00\x00\x00\x00\xe2\xff\x00\x00\xe9\xff\xe7\xff\xce\xff\x00\x00\x00\x00\xc9\xff\xd6\xff\x00\x00\x00\x00\xd1\xff\x00\x00\x98\xff\x95\xff\x9c\xff\x99\xff\x00\x00\xdc\xff\x00\x00\xf3\xff\xe0\xff\x00\x00\xdb\xff\x00\x00\x00\x00\xd9\xff\x00\x00\xd7\xff\xcc\xff\xd8\xff\xcf\xff\x00\x00\x00\x00\xdf\xff\x00\x00\xc7\xff\xe8\xff\xd0\xff\xea\xff\xcd\xff\xd4\xff\xed\xff\xe6\xff\xdc\xff\x00\x00\xdd\xff\xda\xff\x00\x00\xec\xff\x00\x00\xf5\xff\xed\xff\x00\x00\xee\xff\xeb\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x05\x00\x09\x00\x07\x00\x00\x00\x09\x00\x00\x00\x0a\x00\x23\x00\x24\x00\x0d\x00\x0e\x00\x00\x00\x01\x00\x02\x00\x0d\x00\x00\x00\x02\x00\x0d\x00\x00\x00\x00\x00\x30\x00\x0a\x00\x0b\x00\x0c\x00\x07\x00\x0b\x00\x09\x00\x18\x00\x21\x00\x0c\x00\x13\x00\x14\x00\x11\x00\x12\x00\x00\x00\x11\x00\x12\x00\x00\x00\x16\x00\x2c\x00\x30\x00\x18\x00\x00\x00\x30\x00\x31\x00\x32\x00\x1d\x00\x07\x00\x1f\x00\x00\x00\x21\x00\x22\x00\x0c\x00\x00\x00\x25\x00\x30\x00\x27\x00\x26\x00\x27\x00\x2a\x00\x04\x00\x2c\x00\x2d\x00\x01\x00\x18\x00\x30\x00\x31\x00\x32\x00\x02\x00\x1d\x00\x07\x00\x1f\x00\x00\x00\x21\x00\x22\x00\x26\x00\x27\x00\x25\x00\x07\x00\x27\x00\x08\x00\x09\x00\x2a\x00\x00\x00\x2c\x00\x2d\x00\x30\x00\x18\x00\x30\x00\x31\x00\x32\x00\x07\x00\x1d\x00\x09\x00\x1f\x00\x00\x00\x21\x00\x0e\x00\x0f\x00\x00\x00\x1d\x00\x03\x00\x1f\x00\x00\x00\x21\x00\x04\x00\x05\x00\x2c\x00\x2d\x00\x0e\x00\x0f\x00\x30\x00\x31\x00\x32\x00\x04\x00\x2c\x00\x2d\x00\x21\x00\x01\x00\x30\x00\x31\x00\x32\x00\x00\x00\x01\x00\x02\x00\x00\x00\x01\x00\x02\x00\x2c\x00\x00\x00\x01\x00\x02\x00\x30\x00\x31\x00\x32\x00\x24\x00\x25\x00\x05\x00\x10\x00\x24\x00\x25\x00\x0c\x00\x00\x00\x01\x00\x02\x00\x17\x00\x08\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\x22\x00\x23\x00\x30\x00\x28\x00\x29\x00\x05\x00\x17\x00\x2f\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\x04\x00\x28\x00\x29\x00\x01\x00\x00\x00\x01\x00\x02\x00\x06\x00\x0a\x00\x00\x00\x01\x00\x02\x00\x04\x00\x10\x00\x0a\x00\x0b\x00\x0c\x00\x0a\x00\x15\x00\x08\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\x0b\x00\x28\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x03\x00\x04\x00\x05\x00\x10\x00\x01\x00\x06\x00\x07\x00\x00\x00\x01\x00\x02\x00\x17\x00\x18\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\x16\x00\x17\x00\x18\x00\x28\x00\x26\x00\x30\x00\x17\x00\x30\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\x29\x00\x28\x00\x03\x00\x02\x00\x00\x00\x01\x00\x02\x00\x04\x00\x30\x00\x00\x00\x01\x00\x02\x00\x01\x00\x10\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x01\x00\x02\x00\x17\x00\x0c\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\x02\x00\x04\x00\x01\x00\x28\x00\x05\x00\x01\x00\x17\x00\x04\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\x02\x00\x28\x00\x03\x00\x02\x00\x00\x00\x01\x00\x02\x00\x30\x00\x1c\x00\x00\x00\x01\x00\x02\x00\x0a\x00\x10\x00\x0a\x00\x0b\x00\x0c\x00\x00\x00\x01\x00\x02\x00\x17\x00\x0c\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\x08\x00\x1e\x00\x2b\x00\x28\x00\x20\x00\x30\x00\x17\x00\x2e\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\x00\x00\x28\x00\x28\x00\x30\x00\x00\x00\x19\x00\x1a\x00\x1b\x00\x08\x00\x09\x00\x06\x00\x07\x00\x01\x00\x10\x00\x02\x00\x30\x00\x01\x00\x00\x00\x01\x00\x02\x00\x17\x00\x34\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\x03\x00\x03\x00\x03\x00\x28\x00\x03\x00\x0f\x00\x17\x00\x1c\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\x06\x00\x28\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x30\x00\x28\x00\x34\x00\xff\xff\xff\xff\x10\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\xff\xff\xff\xff\xff\xff\x28\x00\xff\xff\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x10\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\xff\xff\xff\xff\xff\xff\x28\x00\xff\xff\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x10\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\xff\xff\xff\xff\xff\xff\x28\x00\xff\xff\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x10\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\xff\xff\xff\xff\xff\xff\x28\x00\xff\xff\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x10\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\xff\xff\xff\xff\xff\xff\x28\x00\xff\xff\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x10\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\xff\xff\xff\xff\xff\xff\x28\x00\xff\xff\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\x28\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x10\x00\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x10\x00\x00\x00\x01\x00\x02\x00\x28\x00\xff\xff\xff\xff\x17\x00\xff\xff\x19\x00\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\x28\x00\xff\xff\xff\xff\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\x1a\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x1b\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\x00\x00\x01\x00\x02\x00\xff\xff\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\x00\x00\x01\x00\x02\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x20\x00\x21\x00\x22\x00\x23\x00\x20\x00\x21\x00\x22\x00\x23\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x20\x00\x21\x00\x22\x00\x23\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x02\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x0a\x00\x0b\x00\x0c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x13\x00\x14\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x80\x00\x3b\x00\x81\x00\x38\x00\x82\x00\x86\x00\x4f\x00\x2c\x00\x2d\x00\x50\x00\x51\x00\x99\x00\x7c\x00\x7d\x00\xbe\x00\x6b\x00\xc4\xff\x78\x00\x6b\x00\x6e\x00\x04\x00\x9a\x00\x9b\x00\x9c\x00\x16\x00\xc4\xff\x3b\x00\x39\x00\x83\x00\x17\x00\x9d\x00\xc1\x00\x6c\x00\xa4\x00\x62\x00\x6c\x00\x6d\x00\x6e\x00\x69\x00\x84\x00\x04\x00\x18\x00\x75\x00\x04\x00\x22\x00\x23\x00\x19\x00\x16\x00\x1a\x00\x76\x00\x1b\x00\x1c\x00\x17\x00\x27\x00\x1d\x00\x04\x00\x1e\x00\x6f\x00\xa7\x00\x1f\x00\xcd\x00\x20\x00\x21\x00\xce\x00\x18\x00\x04\x00\x22\x00\x23\x00\xcf\x00\x19\x00\x38\x00\x1a\x00\xc9\x00\x1b\x00\x1c\x00\x6f\x00\x70\x00\x1d\x00\x38\x00\x1e\x00\xca\x00\xd0\x00\x1f\x00\xaf\x00\x20\x00\x21\x00\x04\x00\x18\x00\x04\x00\x22\x00\x23\x00\x81\x00\x19\x00\x82\x00\x1a\x00\xaf\x00\x1b\x00\xb0\x00\xc8\x00\x71\x00\x19\x00\xc4\x00\x1a\x00\x71\x00\x1b\x00\x24\x00\x74\x00\x20\x00\x21\x00\xb0\x00\xb1\x00\x04\x00\x22\x00\x23\x00\xc5\x00\x20\x00\x21\x00\x83\x00\xc6\x00\x04\x00\x22\x00\x23\x00\x04\x00\x05\x00\x06\x00\x04\x00\x05\x00\x06\x00\x84\x00\x7b\x00\x7c\x00\x7d\x00\x04\x00\x22\x00\x23\x00\x72\x00\xa9\x00\xc7\x00\x34\x00\x72\x00\x73\x00\x7e\x00\x04\x00\x05\x00\x06\x00\x08\x00\xaf\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x34\x00\x3f\x00\x13\x00\x04\x00\x14\x00\x95\x00\xb5\x00\x08\x00\xb3\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x3b\x00\x05\x00\x06\x00\xb8\x00\x14\x00\x35\x00\xb9\x00\x99\x00\x7c\x00\x7d\x00\xba\x00\xbb\x00\x04\x00\x05\x00\x06\x00\xa2\x00\x91\x00\xc7\x00\x9b\x00\x9c\x00\xbd\x00\x92\x00\x99\x00\x08\x00\x93\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x3b\x00\x05\x00\x06\x00\xa0\x00\x14\x00\x56\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x28\x00\x23\x00\x24\x00\x25\x00\x3c\x00\xa1\x00\x29\x00\x84\x00\x04\x00\x05\x00\x06\x00\x08\x00\x3d\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\xcf\x00\x44\x00\x45\x00\x46\x00\x14\x00\xa3\x00\x04\x00\x08\x00\x04\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\xa6\x00\x14\x00\xac\x00\x86\x00\x99\x00\x7c\x00\x7d\x00\x88\x00\x04\x00\x7b\x00\x7c\x00\x7d\x00\x89\x00\xbd\x00\xc0\x00\x9b\x00\x9c\x00\x04\x00\x05\x00\x06\x00\x08\x00\xbb\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\xbf\x00\x8a\x00\x8b\x00\x8c\x00\x14\x00\x8d\x00\x8f\x00\x08\x00\x8e\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x90\x00\x14\x00\x95\x00\x64\x00\x99\x00\x7c\x00\x7d\x00\x04\x00\x3f\x00\x7b\x00\x7c\x00\x7d\x00\x66\x00\xc2\x00\xac\x00\x9b\x00\x9c\x00\x04\x00\x05\x00\x06\x00\x08\x00\x7e\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\xb3\x00\x65\x00\x67\x00\x69\x00\x14\x00\x68\x00\x04\x00\x08\x00\x6b\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\xc9\x00\x14\x00\x27\x00\x04\x00\x28\x00\x41\x00\x42\x00\x43\x00\xca\x00\xcb\x00\x29\x00\x2a\x00\x78\x00\xb5\x00\x7a\x00\x04\x00\x2e\x00\x04\x00\x05\x00\x06\x00\x08\x00\xff\xff\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\xb6\x00\x2f\x00\x30\x00\x31\x00\x14\x00\x33\x00\x4d\x00\x08\x00\x3f\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x4e\x00\x14\x00\x47\x00\x48\x00\x49\x00\x4a\x00\x4b\x00\x4c\x00\x04\x00\x27\x00\xff\xff\x00\x00\x00\x00\xa3\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\xa6\x00\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x00\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa8\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\xaa\x00\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x00\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xad\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x7a\x00\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x00\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x90\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x96\x00\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x00\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x97\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x53\x00\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x00\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3c\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x31\x00\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x00\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x33\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x07\x00\x04\x00\x05\x00\x06\x00\x14\x00\x00\x00\x00\x00\x08\x00\x00\x00\x09\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x14\x00\x00\x00\x00\x00\x51\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x52\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x54\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x55\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x00\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x57\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x58\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x00\x00\x59\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x5a\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x00\x00\x04\x00\x05\x00\x06\x00\x00\x00\x00\x00\x5b\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x04\x00\x05\x00\x06\x00\x00\x00\x04\x00\x05\x00\x06\x00\x00\x00\x5e\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x12\x00\x13\x00\x5c\x00\x10\x00\x11\x00\x12\x00\x13\x00\x04\x00\x05\x00\x06\x00\x00\x00\x04\x00\x05\x00\x06\x00\x5d\x00\x10\x00\x11\x00\x12\x00\x13\x00\x5f\x00\x11\x00\x12\x00\x13\x00\x60\x00\x11\x00\x12\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x61\x00\x11\x00\x12\x00\x13\x00\x36\x00\x11\x00\x12\x00\x13\x00\x99\x00\x7c\x00\x7d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9a\x00\x9b\x00\x9c\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9d\x00\x9e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (2, 110) [
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
	(110 , happyReduce_110)
	]

happy_n_terms = 53 :: Int
happy_n_nonterms = 42 :: Int

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
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	case happyOut14 happy_x_7 of { happy_var_7 -> 
	happyIn11
		 (DataDecl happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_11 = happySpecReduce_3 6# happyReduction_11
happyReduction_11 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
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
	case happyOut18 happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
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
	case happyOut21 happy_x_3 of { happy_var_3 -> 
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
	 =  case happyOut16 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_3 of { happy_var_3 -> 
	happyIn15
		 (POr happy_var_1 happy_var_3
	)}}

happyReduce_22 = happySpecReduce_1 10# happyReduction_22
happyReduction_22 happy_x_1
	 =  case happyOut16 happy_x_1 of { happy_var_1 -> 
	happyIn15
		 (happy_var_1
	)}

happyReduce_23 = happySpecReduce_3 11# happyReduction_23
happyReduction_23 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut17 happy_x_2 of { happy_var_2 -> 
	case happyOut18 happy_x_3 of { happy_var_3 -> 
	happyIn16
		 (PConsTop happy_var_1 happy_var_2 (reverse happy_var_3)
	)}}}

happyReduce_24 = happySpecReduce_1 11# happyReduction_24
happyReduction_24 happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (happy_var_1
	)}

happyReduce_25 = happyReduce 4# 12# happyReduction_25
happyReduction_25 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn17
		 (PRec happy_var_3
	) `HappyStk` happyRest}

happyReduce_26 = happySpecReduce_1 12# happyReduction_26
happyReduction_26 happy_x_1
	 =  happyIn17
		 (PType
	)

happyReduce_27 = happySpecReduce_1 12# happyReduction_27
happyReduction_27 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn17
		 (PStr happy_var_1
	)}

happyReduce_28 = happySpecReduce_1 12# happyReduction_28
happyReduction_28 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn17
		 (PInt happy_var_1
	)}

happyReduce_29 = happySpecReduce_1 12# happyReduction_29
happyReduction_29 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn17
		 (PVar happy_var_1
	)}

happyReduce_30 = happySpecReduce_1 12# happyReduction_30
happyReduction_30 happy_x_1
	 =  happyIn17
		 (PWild
	)

happyReduce_31 = happySpecReduce_3 12# happyReduction_31
happyReduction_31 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut15 happy_x_2 of { happy_var_2 -> 
	happyIn17
		 (happy_var_2
	)}

happyReduce_32 = happySpecReduce_0 13# happyReduction_32
happyReduction_32  =  happyIn18
		 ([]
	)

happyReduce_33 = happySpecReduce_2 13# happyReduction_33
happyReduction_33 happy_x_2
	happy_x_1
	 =  case happyOut18 happy_x_1 of { happy_var_1 -> 
	case happyOut17 happy_x_2 of { happy_var_2 -> 
	happyIn18
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_34 = happySpecReduce_3 14# happyReduction_34
happyReduction_34 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_3 of { happy_var_3 -> 
	happyIn19
		 (FieldPattern happy_var_1 happy_var_3
	)}}

happyReduce_35 = happySpecReduce_0 15# happyReduction_35
happyReduction_35  =  happyIn20
		 ([]
	)

happyReduce_36 = happySpecReduce_1 15# happyReduction_36
happyReduction_36 happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	happyIn20
		 ((:[]) happy_var_1
	)}

happyReduce_37 = happySpecReduce_3 15# happyReduction_37
happyReduction_37 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_3 of { happy_var_3 -> 
	happyIn20
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_38 = happyReduce 6# 16# happyReduction_38
happyReduction_38 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut23 happy_x_3 of { happy_var_3 -> 
	case happyOut21 happy_x_6 of { happy_var_6 -> 
	happyIn21
		 (ELet happy_var_3 happy_var_6
	) `HappyStk` happyRest}}

happyReduce_39 = happyReduce 6# 16# happyReduction_39
happyReduction_39 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut21 happy_x_2 of { happy_var_2 -> 
	case happyOut25 happy_x_5 of { happy_var_5 -> 
	happyIn21
		 (ECase happy_var_2 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_40 = happyReduce 6# 16# happyReduction_40
happyReduction_40 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut21 happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	case happyOut21 happy_x_6 of { happy_var_6 -> 
	happyIn21
		 (EIf happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_41 = happyReduce 5# 16# happyReduction_41
happyReduction_41 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut27 happy_x_3 of { happy_var_3 -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	happyIn21
		 (EDo (reverse happy_var_3) happy_var_4
	) `HappyStk` happyRest}}

happyReduce_42 = happySpecReduce_1 16# happyReduction_42
happyReduction_42 happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	happyIn21
		 (happy_var_1
	)}

happyReduce_43 = happyReduce 5# 17# happyReduction_43
happyReduction_43 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	case happyOut21 happy_x_5 of { happy_var_5 -> 
	happyIn22
		 (LetDef happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_44 = happySpecReduce_0 18# happyReduction_44
happyReduction_44  =  happyIn23
		 ([]
	)

happyReduce_45 = happySpecReduce_1 18# happyReduction_45
happyReduction_45 happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	happyIn23
		 ((:[]) happy_var_1
	)}

happyReduce_46 = happySpecReduce_3 18# happyReduction_46
happyReduction_46 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_3 of { happy_var_3 -> 
	happyIn23
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_47 = happySpecReduce_3 19# happyReduction_47
happyReduction_47 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	happyIn24
		 (Case happy_var_1 happy_var_3
	)}}

happyReduce_48 = happySpecReduce_0 20# happyReduction_48
happyReduction_48  =  happyIn25
		 ([]
	)

happyReduce_49 = happySpecReduce_1 20# happyReduction_49
happyReduction_49 happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	happyIn25
		 ((:[]) happy_var_1
	)}

happyReduce_50 = happySpecReduce_3 20# happyReduction_50
happyReduction_50 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	case happyOut25 happy_x_3 of { happy_var_3 -> 
	happyIn25
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_51 = happySpecReduce_3 21# happyReduction_51
happyReduction_51 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	happyIn26
		 (BindVar happy_var_1 happy_var_3
	)}}

happyReduce_52 = happySpecReduce_1 21# happyReduction_52
happyReduction_52 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn26
		 (BindNoVar happy_var_1
	)}

happyReduce_53 = happySpecReduce_0 22# happyReduction_53
happyReduction_53  =  happyIn27
		 ([]
	)

happyReduce_54 = happySpecReduce_3 22# happyReduction_54
happyReduction_54 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut26 happy_x_2 of { happy_var_2 -> 
	happyIn27
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_55 = happyReduce 4# 23# happyReduction_55
happyReduction_55 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut29 happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	happyIn28
		 (EAbs happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_56 = happyReduce 7# 23# happyReduction_56
happyReduction_56 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut29 happy_x_2 of { happy_var_2 -> 
	case happyOut21 happy_x_4 of { happy_var_4 -> 
	case happyOut21 happy_x_7 of { happy_var_7 -> 
	happyIn28
		 (EPi happy_var_2 happy_var_4 happy_var_7
	) `HappyStk` happyRest}}}

happyReduce_57 = happySpecReduce_3 23# happyReduction_57
happyReduction_57 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	happyIn28
		 (EPiNoVar happy_var_1 happy_var_3
	)}}

happyReduce_58 = happySpecReduce_1 23# happyReduction_58
happyReduction_58 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn28
		 (happy_var_1
	)}

happyReduce_59 = happySpecReduce_1 24# happyReduction_59
happyReduction_59 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn29
		 (VVar happy_var_1
	)}

happyReduce_60 = happySpecReduce_1 24# happyReduction_60
happyReduction_60 happy_x_1
	 =  happyIn29
		 (VWild
	)

happyReduce_61 = happySpecReduce_3 25# happyReduction_61
happyReduction_61 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn30
		 (EBind happy_var_1 happy_var_3
	)}}

happyReduce_62 = happySpecReduce_3 25# happyReduction_62
happyReduction_62 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn30
		 (EBindC happy_var_1 happy_var_3
	)}}

happyReduce_63 = happySpecReduce_1 25# happyReduction_63
happyReduction_63 happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	happyIn30
		 (happy_var_1
	)}

happyReduce_64 = happySpecReduce_3 26# happyReduction_64
happyReduction_64 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn31
		 (EOr happy_var_1 happy_var_3
	)}}

happyReduce_65 = happySpecReduce_1 26# happyReduction_65
happyReduction_65 happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	happyIn31
		 (happy_var_1
	)}

happyReduce_66 = happySpecReduce_3 27# happyReduction_66
happyReduction_66 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 (EAnd happy_var_1 happy_var_3
	)}}

happyReduce_67 = happySpecReduce_1 27# happyReduction_67
happyReduction_67 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn32
		 (happy_var_1
	)}

happyReduce_68 = happySpecReduce_3 28# happyReduction_68
happyReduction_68 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (EEq happy_var_1 happy_var_3
	)}}

happyReduce_69 = happySpecReduce_3 28# happyReduction_69
happyReduction_69 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (ENe happy_var_1 happy_var_3
	)}}

happyReduce_70 = happySpecReduce_3 28# happyReduction_70
happyReduction_70 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (ELt happy_var_1 happy_var_3
	)}}

happyReduce_71 = happySpecReduce_3 28# happyReduction_71
happyReduction_71 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (ELe happy_var_1 happy_var_3
	)}}

happyReduce_72 = happySpecReduce_3 28# happyReduction_72
happyReduction_72 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (EGt happy_var_1 happy_var_3
	)}}

happyReduce_73 = happySpecReduce_3 28# happyReduction_73
happyReduction_73 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn33
		 (EGe happy_var_1 happy_var_3
	)}}

happyReduce_74 = happySpecReduce_1 28# happyReduction_74
happyReduction_74 happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	happyIn33
		 (happy_var_1
	)}

happyReduce_75 = happySpecReduce_3 29# happyReduction_75
happyReduction_75 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn34
		 (EListCons happy_var_1 happy_var_3
	)}}

happyReduce_76 = happySpecReduce_1 29# happyReduction_76
happyReduction_76 happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 (happy_var_1
	)}

happyReduce_77 = happySpecReduce_3 30# happyReduction_77
happyReduction_77 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (EAdd happy_var_1 happy_var_3
	)}}

happyReduce_78 = happySpecReduce_3 30# happyReduction_78
happyReduction_78 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 (ESub happy_var_1 happy_var_3
	)}}

happyReduce_79 = happySpecReduce_1 30# happyReduction_79
happyReduction_79 happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 (happy_var_1
	)}

happyReduce_80 = happySpecReduce_3 31# happyReduction_80
happyReduction_80 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 (EMul happy_var_1 happy_var_3
	)}}

happyReduce_81 = happySpecReduce_3 31# happyReduction_81
happyReduction_81 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 (EDiv happy_var_1 happy_var_3
	)}}

happyReduce_82 = happySpecReduce_3 31# happyReduction_82
happyReduction_82 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 (EMod happy_var_1 happy_var_3
	)}}

happyReduce_83 = happySpecReduce_1 31# happyReduction_83
happyReduction_83 happy_x_1
	 =  case happyOut37 happy_x_1 of { happy_var_1 -> 
	happyIn36
		 (happy_var_1
	)}

happyReduce_84 = happySpecReduce_2 32# happyReduction_84
happyReduction_84 happy_x_2
	happy_x_1
	 =  case happyOut37 happy_x_2 of { happy_var_2 -> 
	happyIn37
		 (ENeg happy_var_2
	)}

happyReduce_85 = happySpecReduce_1 32# happyReduction_85
happyReduction_85 happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	happyIn37
		 (happy_var_1
	)}

happyReduce_86 = happySpecReduce_2 33# happyReduction_86
happyReduction_86 happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_2 of { happy_var_2 -> 
	happyIn38
		 (EApp happy_var_1 happy_var_2
	)}}

happyReduce_87 = happySpecReduce_1 33# happyReduction_87
happyReduction_87 happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	happyIn38
		 (happy_var_1
	)}

happyReduce_88 = happySpecReduce_3 34# happyReduction_88
happyReduction_88 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut39 happy_x_1 of { happy_var_1 -> 
	case happyOut5 happy_x_3 of { happy_var_3 -> 
	happyIn39
		 (EProj happy_var_1 happy_var_3
	)}}

happyReduce_89 = happySpecReduce_1 34# happyReduction_89
happyReduction_89 happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	happyIn39
		 (happy_var_1
	)}

happyReduce_90 = happyReduce 4# 35# happyReduction_90
happyReduction_90 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut42 happy_x_3 of { happy_var_3 -> 
	happyIn40
		 (ERecType happy_var_3
	) `HappyStk` happyRest}

happyReduce_91 = happyReduce 4# 35# happyReduction_91
happyReduction_91 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut44 happy_x_3 of { happy_var_3 -> 
	happyIn40
		 (ERec happy_var_3
	) `HappyStk` happyRest}

happyReduce_92 = happySpecReduce_3 35# happyReduction_92
happyReduction_92 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_2 of { happy_var_2 -> 
	happyIn40
		 (EList happy_var_2
	)}

happyReduce_93 = happySpecReduce_1 35# happyReduction_93
happyReduction_93 happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	happyIn40
		 (EVar happy_var_1
	)}

happyReduce_94 = happySpecReduce_1 35# happyReduction_94
happyReduction_94 happy_x_1
	 =  happyIn40
		 (EType
	)

happyReduce_95 = happySpecReduce_1 35# happyReduction_95
happyReduction_95 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn40
		 (EStr happy_var_1
	)}

happyReduce_96 = happySpecReduce_1 35# happyReduction_96
happyReduction_96 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn40
		 (EInt happy_var_1
	)}

happyReduce_97 = happySpecReduce_1 35# happyReduction_97
happyReduction_97 happy_x_1
	 =  happyIn40
		 (EMeta
	)

happyReduce_98 = happySpecReduce_3 35# happyReduction_98
happyReduction_98 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_2 of { happy_var_2 -> 
	happyIn40
		 (happy_var_2
	)}

happyReduce_99 = happySpecReduce_3 36# happyReduction_99
happyReduction_99 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	happyIn41
		 (FieldType happy_var_1 happy_var_3
	)}}

happyReduce_100 = happySpecReduce_0 37# happyReduction_100
happyReduction_100  =  happyIn42
		 ([]
	)

happyReduce_101 = happySpecReduce_1 37# happyReduction_101
happyReduction_101 happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	happyIn42
		 ((:[]) happy_var_1
	)}

happyReduce_102 = happySpecReduce_3 37# happyReduction_102
happyReduction_102 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_3 of { happy_var_3 -> 
	happyIn42
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_103 = happySpecReduce_3 38# happyReduction_103
happyReduction_103 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut5 happy_x_1 of { happy_var_1 -> 
	case happyOut21 happy_x_3 of { happy_var_3 -> 
	happyIn43
		 (FieldValue happy_var_1 happy_var_3
	)}}

happyReduce_104 = happySpecReduce_0 39# happyReduction_104
happyReduction_104  =  happyIn44
		 ([]
	)

happyReduce_105 = happySpecReduce_1 39# happyReduction_105
happyReduction_105 happy_x_1
	 =  case happyOut43 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 ((:[]) happy_var_1
	)}

happyReduce_106 = happySpecReduce_3 39# happyReduction_106
happyReduction_106 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut43 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_3 of { happy_var_3 -> 
	happyIn44
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_107 = happySpecReduce_1 40# happyReduction_107
happyReduction_107 happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (happy_var_1
	)}

happyReduce_108 = happySpecReduce_0 41# happyReduction_108
happyReduction_108  =  happyIn46
		 ([]
	)

happyReduce_109 = happySpecReduce_1 41# happyReduction_109
happyReduction_109 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn46
		 ((:[]) happy_var_1
	)}

happyReduce_110 = happySpecReduce_3 41# happyReduction_110
happyReduction_110 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut46 happy_x_3 of { happy_var_3 -> 
	happyIn46
		 ((:) happy_var_1 happy_var_3
	)}}

happyNewToken action sts stk [] =
	happyDoAction 52# (error "reading EOF!") action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	PT _ (TS ";") -> cont 1#;
	PT _ (TS ":") -> cont 2#;
	PT _ (TS "{") -> cont 3#;
	PT _ (TS "}") -> cont 4#;
	PT _ (TS "=") -> cont 5#;
	PT _ (TS "||") -> cont 6#;
	PT _ (TS "(") -> cont 7#;
	PT _ (TS ")") -> cont 8#;
	PT _ (TS "_") -> cont 9#;
	PT _ (TS "->") -> cont 10#;
	PT _ (TS "<-") -> cont 11#;
	PT _ (TS "\\") -> cont 12#;
	PT _ (TS ">>=") -> cont 13#;
	PT _ (TS ">>") -> cont 14#;
	PT _ (TS "&&") -> cont 15#;
	PT _ (TS "==") -> cont 16#;
	PT _ (TS "/=") -> cont 17#;
	PT _ (TS "<") -> cont 18#;
	PT _ (TS "<=") -> cont 19#;
	PT _ (TS ">") -> cont 20#;
	PT _ (TS ">=") -> cont 21#;
	PT _ (TS "::") -> cont 22#;
	PT _ (TS "+") -> cont 23#;
	PT _ (TS "-") -> cont 24#;
	PT _ (TS "*") -> cont 25#;
	PT _ (TS "/") -> cont 26#;
	PT _ (TS "%") -> cont 27#;
	PT _ (TS ".") -> cont 28#;
	PT _ (TS "[") -> cont 29#;
	PT _ (TS "]") -> cont 30#;
	PT _ (TS "?") -> cont 31#;
	PT _ (TS ",") -> cont 32#;
	PT _ (TS "Type") -> cont 33#;
	PT _ (TS "case") -> cont 34#;
	PT _ (TS "data") -> cont 35#;
	PT _ (TS "derive") -> cont 36#;
	PT _ (TS "do") -> cont 37#;
	PT _ (TS "else") -> cont 38#;
	PT _ (TS "if") -> cont 39#;
	PT _ (TS "import") -> cont 40#;
	PT _ (TS "in") -> cont 41#;
	PT _ (TS "let") -> cont 42#;
	PT _ (TS "of") -> cont 43#;
	PT _ (TS "rec") -> cont 44#;
	PT _ (TS "sig") -> cont 45#;
	PT _ (TS "then") -> cont 46#;
	PT _ (TS "where") -> cont 47#;
	PT _ (TV happy_dollar_dollar) -> cont 48#;
	PT _ (TL happy_dollar_dollar) -> cont 49#;
	PT _ (TI happy_dollar_dollar) -> cont 50#;
	_ -> cont 51#;
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
  happySomeParser = happyThen (happyParse 1# tks) (\x -> happyReturn (happyOut21 x))

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
