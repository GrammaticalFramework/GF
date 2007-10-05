{-# OPTIONS -fglasgow-exts -cpp #-}
{-# OPTIONS -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module GF.GFCC.ParGFCC where
import GF.GFCC.AbsGFCC
import GF.GFCC.LexGFCC
import GF.GFCC.ErrM
import Array
#if __GLASGOW_HASKELL__ >= 503
import GHC.Exts
#else
import GlaExts
#endif

-- parser produced by Happy Version 1.15

newtype HappyAbsSyn  = HappyAbsSyn (() -> ())
happyIn30 :: (String) -> (HappyAbsSyn )
happyIn30 x = unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> (String)
happyOut30 x = unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: (Integer) -> (HappyAbsSyn )
happyIn31 x = unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> (Integer)
happyOut31 x = unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: (Double) -> (HappyAbsSyn )
happyIn32 x = unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> (Double)
happyOut32 x = unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (CId) -> (HappyAbsSyn )
happyIn33 x = unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (CId)
happyOut33 x = unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyIn34 :: (Grammar) -> (HappyAbsSyn )
happyIn34 x = unsafeCoerce# x
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> (Grammar)
happyOut34 x = unsafeCoerce# x
{-# INLINE happyOut34 #-}
happyIn35 :: (Abstract) -> (HappyAbsSyn )
happyIn35 x = unsafeCoerce# x
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> (Abstract)
happyOut35 x = unsafeCoerce# x
{-# INLINE happyOut35 #-}
happyIn36 :: (Concrete) -> (HappyAbsSyn )
happyIn36 x = unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> (Concrete)
happyOut36 x = unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: (Flag) -> (HappyAbsSyn )
happyIn37 x = unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> (Flag)
happyOut37 x = unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: (CatDef) -> (HappyAbsSyn )
happyIn38 x = unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> (CatDef)
happyOut38 x = unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: (FunDef) -> (HappyAbsSyn )
happyIn39 x = unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> (FunDef)
happyOut39 x = unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: (LinDef) -> (HappyAbsSyn )
happyIn40 x = unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> (LinDef)
happyOut40 x = unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyIn41 :: (Type) -> (HappyAbsSyn )
happyIn41 x = unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> (Type)
happyOut41 x = unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: (Exp) -> (HappyAbsSyn )
happyIn42 x = unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> (Exp)
happyOut42 x = unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyIn43 :: (Atom) -> (HappyAbsSyn )
happyIn43 x = unsafeCoerce# x
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> (Atom)
happyOut43 x = unsafeCoerce# x
{-# INLINE happyOut43 #-}
happyIn44 :: (Term) -> (HappyAbsSyn )
happyIn44 x = unsafeCoerce# x
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> (Term)
happyOut44 x = unsafeCoerce# x
{-# INLINE happyOut44 #-}
happyIn45 :: (Tokn) -> (HappyAbsSyn )
happyIn45 x = unsafeCoerce# x
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> (Tokn)
happyOut45 x = unsafeCoerce# x
{-# INLINE happyOut45 #-}
happyIn46 :: (Variant) -> (HappyAbsSyn )
happyIn46 x = unsafeCoerce# x
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> (Variant)
happyOut46 x = unsafeCoerce# x
{-# INLINE happyOut46 #-}
happyIn47 :: ([Concrete]) -> (HappyAbsSyn )
happyIn47 x = unsafeCoerce# x
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn ) -> ([Concrete])
happyOut47 x = unsafeCoerce# x
{-# INLINE happyOut47 #-}
happyIn48 :: ([Flag]) -> (HappyAbsSyn )
happyIn48 x = unsafeCoerce# x
{-# INLINE happyIn48 #-}
happyOut48 :: (HappyAbsSyn ) -> ([Flag])
happyOut48 x = unsafeCoerce# x
{-# INLINE happyOut48 #-}
happyIn49 :: ([CatDef]) -> (HappyAbsSyn )
happyIn49 x = unsafeCoerce# x
{-# INLINE happyIn49 #-}
happyOut49 :: (HappyAbsSyn ) -> ([CatDef])
happyOut49 x = unsafeCoerce# x
{-# INLINE happyOut49 #-}
happyIn50 :: ([FunDef]) -> (HappyAbsSyn )
happyIn50 x = unsafeCoerce# x
{-# INLINE happyIn50 #-}
happyOut50 :: (HappyAbsSyn ) -> ([FunDef])
happyOut50 x = unsafeCoerce# x
{-# INLINE happyOut50 #-}
happyIn51 :: ([LinDef]) -> (HappyAbsSyn )
happyIn51 x = unsafeCoerce# x
{-# INLINE happyIn51 #-}
happyOut51 :: (HappyAbsSyn ) -> ([LinDef])
happyOut51 x = unsafeCoerce# x
{-# INLINE happyOut51 #-}
happyIn52 :: ([CId]) -> (HappyAbsSyn )
happyIn52 x = unsafeCoerce# x
{-# INLINE happyIn52 #-}
happyOut52 :: (HappyAbsSyn ) -> ([CId])
happyOut52 x = unsafeCoerce# x
{-# INLINE happyOut52 #-}
happyIn53 :: ([Term]) -> (HappyAbsSyn )
happyIn53 x = unsafeCoerce# x
{-# INLINE happyIn53 #-}
happyOut53 :: (HappyAbsSyn ) -> ([Term])
happyOut53 x = unsafeCoerce# x
{-# INLINE happyOut53 #-}
happyIn54 :: ([Exp]) -> (HappyAbsSyn )
happyIn54 x = unsafeCoerce# x
{-# INLINE happyIn54 #-}
happyOut54 :: (HappyAbsSyn ) -> ([Exp])
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
happyIn57 :: (Hypo) -> (HappyAbsSyn )
happyIn57 x = unsafeCoerce# x
{-# INLINE happyIn57 #-}
happyOut57 :: (HappyAbsSyn ) -> (Hypo)
happyOut57 x = unsafeCoerce# x
{-# INLINE happyOut57 #-}
happyIn58 :: (Equation) -> (HappyAbsSyn )
happyIn58 x = unsafeCoerce# x
{-# INLINE happyIn58 #-}
happyOut58 :: (HappyAbsSyn ) -> (Equation)
happyOut58 x = unsafeCoerce# x
{-# INLINE happyOut58 #-}
happyIn59 :: ([Hypo]) -> (HappyAbsSyn )
happyIn59 x = unsafeCoerce# x
{-# INLINE happyIn59 #-}
happyOut59 :: (HappyAbsSyn ) -> ([Hypo])
happyOut59 x = unsafeCoerce# x
{-# INLINE happyOut59 #-}
happyIn60 :: ([Equation]) -> (HappyAbsSyn )
happyIn60 x = unsafeCoerce# x
{-# INLINE happyIn60 #-}
happyOut60 :: (HappyAbsSyn ) -> ([Equation])
happyOut60 x = unsafeCoerce# x
{-# INLINE happyOut60 #-}
happyInTok :: Token -> (HappyAbsSyn )
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x37\x01\x39\x01\x35\x01\x33\x01\x33\x01\x33\x01\x33\x01\x41\x01\xc4\x00\x1f\x00\x05\x00\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x31\x01\x05\x00\x00\x00\x00\x00\x30\x01\x2f\x01\x00\x00\x2f\x01\x00\x00\x2e\x01\x00\x00\x2c\x01\x2d\x01\x2b\x01\x2a\x01\x00\x00\x83\x00\x2a\x01\x2a\x01\x29\x01\x2d\x00\x27\x01\x99\x00\x0c\x00\x00\x00\x00\x00\x00\x00\x28\x01\x00\x00\x25\x01\x05\x00\x01\x00\x00\x00\x24\x01\x05\x00\x00\x00\x23\x01\x22\x01\x50\x00\x50\x00\x50\x00\x50\x00\x4f\x00\x22\x01\x22\x01\x26\x01\x21\x01\x00\x00\x00\x00\x00\x00\x00\x00\x21\x01\x20\x01\x1f\x01\x00\x00\x1e\x01\x00\x00\x1d\x01\x1b\x01\x1c\x01\x1a\x01\x19\x01\x18\x01\x17\x01\x16\x01\x14\x01\x15\x01\x13\x01\x13\x01\x10\x01\x0f\x01\x11\x01\x0d\x01\x0c\x01\x12\x01\x0b\x01\x0e\x01\x09\x01\x02\x01\x0a\x01\x05\x00\x07\x01\xf7\x00\xff\x00\x00\x00\x00\x00\x00\x00\x08\x01\x06\x01\x05\x01\x04\x01\x03\x01\xf3\x00\x00\x01\x00\x00\xfd\x00\xed\x00\x4a\x00\x01\x01\x05\x00\x00\x00\x00\x00\x00\x00\x25\x00\xc4\x00\xf1\x00\xfb\x00\xfe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf0\x00\x00\x00\x00\x00\x05\x00\x05\x00\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfd\xff\x00\x00\xfc\x00\xea\x00\x00\x00\xfa\x00\xf5\x00\x00\x00\xe8\x00\x00\x00\xe7\x00\xf9\x00\x1b\x00\x00\x00\x00\x00\xc4\x00\x00\x00\x1f\x00\x25\x00\xf8\x00\xf6\x00\xf4\x00\x00\x00\x00\x00\x00\x00\xef\x00\x00\x00\xc4\x00\x00\x00\x8b\x00\x00\x00\xf2\x00\xe5\x00\x09\x00\x00\x00\xb8\x00\xeb\x00\x00\x00\x00\x00\x93\x00\x00\x00\xee\x00\x00\x00\x0f\x00\x00\x00\x44\x00\x00\x00\xd2\x00\x00\x00\x72\x00\x00\x00\xa6\x00\x00\x00\x04\x00\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\xec\x00\xe9\x00\xe6\x00\xbf\x00\xb0\x00\xac\x00\xaa\x00\xe4\x00\xe1\x00\x9b\x00\x85\x00\x5d\x00\x79\x00\xe3\x00\xe0\x00\xd6\x00\xd7\x00\xd1\x00\x48\x00\x63\x00\xcf\x00\xcc\x00\x92\x00\x1d\x00\xab\x00\x19\x00\xc6\x00\x00\x00\x00\x00\xa5\x00\x00\x00\x00\x00\x00\x00\x00\x00\xde\x00\x00\x00\x00\x00\x00\x00\xe2\x00\x00\x00\xe2\x00\xd5\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x53\x00\x49\x00\x00\x00\xdf\x00\x43\x00\x00\x00\x00\x00\x00\x00\x9c\x00\x9e\x00\xaf\x00\x8a\x00\xdd\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdc\x00\xdb\x00\x00\x00\x00\x00\xc1\x00\x00\x00\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd9\x00\x00\x00\x00\x00\x00\x00\xd8\x00\x00\x00\x00\x00\x00\x00\xda\x00\x12\x00\xcd\x00\x81\x00\x00\x00\x38\x00\xeb\xff\x00\x00\x00\x00\xc0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x14\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x39\x00\x00\x00\x00\x00\xbd\x00\x90\x00\xcb\x00\xfe\xff\xca\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd4\x00\x00\x00\x00\x00\x7d\x00\x6d\x00\x68\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd4\x00\x00\x00\x00\x00\xce\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbe\x00\x02\x00\x00\x00\x7c\x00\xb2\x00\x00\x00\xc3\x00\xbb\x00\x97\x00\x5f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xba\x00\xc2\x00\x00\x00\x7c\x00\xb9\x00\x00\x00\xb6\x00\x9e\x00\xb7\x00\x4d\x00\x00\x00\x00\x00\x00\x00\x9c\x00\x07\x00\x00\x00\xa0\x00\xaf\x00\xb5\x00\x9c\x00\x00\x00\xb4\x00\x8e\x00\x9c\x00\x3a\x00\x9c\x00\x22\x00\x9c\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb0\xff\xc2\xff\xc0\xff\xbe\xff\xbc\xff\xba\xff\xb8\xff\xb5\xff\xb2\xff\xb0\xff\xb0\xff\x00\x00\xb2\xff\xa9\xff\xa6\xff\x00\x00\xe4\xff\xb2\xff\x00\x00\xa8\xff\x00\x00\xe1\xff\x00\x00\x00\x00\x00\x00\xad\xff\x00\x00\x00\x00\x00\x00\x00\x00\xc5\xff\xcb\xff\xca\xff\xb4\xff\xcd\xff\x00\x00\xb5\xff\xb5\xff\xc7\xff\x00\x00\xb5\xff\xe3\xff\xb7\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd5\xff\xd4\xff\xd3\xff\xd6\xff\x00\x00\x00\x00\x00\x00\xe2\xff\x00\x00\xa6\xff\x00\x00\x00\x00\xa9\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa9\xff\x00\x00\x00\x00\x00\x00\xb8\xff\xb2\xff\xd1\xff\xd2\xff\xb0\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb8\xff\x00\x00\xcc\xff\x00\x00\xc5\xff\xb4\xff\x00\x00\xb5\xff\xb1\xff\xaf\xff\xb0\xff\xae\xff\x00\x00\xa9\xff\x00\x00\x00\x00\xa5\xff\xab\xff\xa7\xff\xaa\xff\xac\xff\xc3\xff\xb3\xff\xce\xff\x00\x00\x00\x00\x00\x00\xd0\xff\xc9\xff\xb6\xff\xb9\xff\xbb\xff\xbd\xff\xbf\xff\xc1\xff\x00\x00\xd7\xff\x00\x00\x00\x00\xda\xff\x00\x00\x00\x00\xdd\xff\x00\x00\xc0\xff\xb8\xff\x00\x00\x00\x00\xc0\xff\xdc\xff\x00\x00\xb2\xff\x00\x00\xae\xff\x00\x00\x00\x00\x00\x00\xcf\xff\xc6\xff\xc8\xff\x00\x00\xb2\xff\xd9\xff\xdb\xff\x00\x00\xbc\xff\x00\x00\x00\x00\x00\x00\xba\xff\x00\x00\x00\x00\xc4\xff\xd8\xff\x00\x00\xbe\xff\x00\x00\xc2\xff\x00\x00\xba\xff\x00\x00\xdf\xff\xe0\xff\xba\xff\x00\x00\xba\xff\x00\x00\xba\xff\x00\x00\xde\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x03\x00\x01\x00\x18\x00\x07\x00\x03\x00\x01\x00\x1c\x00\x07\x00\x05\x00\x07\x00\x0a\x00\x07\x00\x0c\x00\x0d\x00\x0a\x00\x04\x00\x0c\x00\x0d\x00\x07\x00\x05\x00\x03\x00\x03\x00\x03\x00\x16\x00\x1b\x00\x13\x00\x1d\x00\x03\x00\x20\x00\x15\x00\x1e\x00\x03\x00\x20\x00\x21\x00\x20\x00\x23\x00\x20\x00\x21\x00\x23\x00\x23\x00\x0a\x00\x16\x00\x0c\x00\x23\x00\x1b\x00\x1b\x00\x1d\x00\x1d\x00\x25\x00\x23\x00\x18\x00\x1b\x00\x10\x00\x1d\x00\x15\x00\x1b\x00\x00\x00\x01\x00\x03\x00\x03\x00\x10\x00\x23\x00\x20\x00\x21\x00\x22\x00\x23\x00\x00\x00\x01\x00\x20\x00\x03\x00\x0e\x00\x0f\x00\x00\x00\x01\x00\x03\x00\x03\x00\x20\x00\x16\x00\x15\x00\x17\x00\x0e\x00\x0f\x00\x00\x00\x01\x00\x0b\x00\x03\x00\x0e\x00\x0f\x00\x0c\x00\x17\x00\x11\x00\x12\x00\x00\x00\x16\x00\x1b\x00\x17\x00\x0e\x00\x0f\x00\x00\x00\x01\x00\x16\x00\x03\x00\x23\x00\x00\x00\x01\x00\x17\x00\x03\x00\x0f\x00\x00\x00\x01\x00\x10\x00\x03\x00\x0e\x00\x0f\x00\x23\x00\x25\x00\x25\x00\x0e\x00\x0f\x00\x19\x00\x1a\x00\x17\x00\x0e\x00\x0f\x00\x00\x00\x01\x00\x03\x00\x03\x00\x00\x00\x01\x00\x07\x00\x03\x00\x00\x00\x01\x00\x04\x00\x03\x00\x10\x00\x07\x00\x0e\x00\x0f\x00\x03\x00\x1c\x00\x0e\x00\x0f\x00\x07\x00\x19\x00\x0e\x00\x0f\x00\x23\x00\x13\x00\x00\x00\x01\x00\x02\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x03\x00\x10\x00\x03\x00\x10\x00\x15\x00\x0d\x00\x1a\x00\x0a\x00\x09\x00\x0d\x00\x19\x00\x1a\x00\x19\x00\x1a\x00\x03\x00\x23\x00\x03\x00\x1d\x00\x11\x00\x03\x00\x03\x00\x0a\x00\x09\x00\x23\x00\x08\x00\x08\x00\x20\x00\x06\x00\x05\x00\x04\x00\x18\x00\x25\x00\x07\x00\x08\x00\x1c\x00\x03\x00\x18\x00\x12\x00\x1f\x00\x07\x00\x1c\x00\x04\x00\x23\x00\x15\x00\x07\x00\x15\x00\x14\x00\x0c\x00\x0c\x00\x12\x00\x03\x00\x18\x00\x18\x00\x00\x00\x0b\x00\x19\x00\x0c\x00\x0b\x00\x19\x00\x00\x00\x03\x00\x03\x00\x01\x00\x03\x00\x1e\x00\x01\x00\x0c\x00\x00\x00\x06\x00\x1e\x00\x19\x00\x15\x00\x18\x00\x16\x00\x13\x00\x0c\x00\x14\x00\x06\x00\x0c\x00\x05\x00\x0b\x00\x04\x00\x03\x00\x12\x00\x08\x00\x11\x00\x03\x00\x02\x00\x08\x00\x02\x00\x14\x00\x02\x00\x02\x00\x0f\x00\x08\x00\x02\x00\x17\x00\x06\x00\x03\x00\x07\x00\x02\x00\x05\x00\x08\x00\x03\x00\x03\x00\x03\x00\x03\x00\x23\x00\x03\x00\xff\xff\x23\x00\x0e\x00\x08\x00\x20\x00\x07\x00\x04\x00\x01\x00\x23\x00\x04\x00\x23\x00\xff\xff\xff\xff\xff\xff\x23\x00\x06\x00\xff\xff\x07\x00\x01\x00\xff\xff\x06\x00\x09\x00\x17\x00\xff\xff\xff\xff\x23\x00\xff\xff\xff\xff\xff\xff\x20\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x23\x00\xff\xff\xff\xff\x25\x00\x23\x00\x25\x00\x12\x00\x09\x00\xff\xff\x25\x00\x25\x00\x12\x00\x12\x00\x25\x00\x12\x00\x25\x00\x23\x00\x25\x00\x21\x00\x23\x00\x25\x00\x1e\x00\x21\x00\x25\x00\x25\x00\x07\x00\xff\xff\x25\x00\x16\x00\x25\x00\x14\x00\x20\x00\x25\x00\x19\x00\x25\x00\x23\x00\xff\xff\x23\x00\x25\x00\x23\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x1e\x00\x31\x00\x22\x00\xa4\x00\x36\x00\x31\x00\x7d\x00\x32\x00\xc8\x00\x40\x00\x33\x00\x32\x00\x34\x00\x35\x00\x33\x00\x4b\x00\x34\x00\x35\x00\x4c\x00\xc0\x00\x1e\x00\x1e\x00\x36\x00\x9c\x00\x1f\x00\xbc\x00\x80\x00\x1e\x00\x1d\x00\xba\x00\x69\x00\x1e\x00\x1d\x00\x36\x00\x1d\x00\x22\x00\x1d\x00\x36\x00\x22\x00\x22\x00\x47\x00\x8b\x00\x48\x00\x22\x00\x1f\x00\x1f\x00\x97\x00\x63\x00\xff\xff\x22\x00\xb0\x00\x1f\x00\xb0\xff\x20\x00\xc6\x00\x24\x00\x2a\x00\x2b\x00\x36\x00\x2c\x00\x79\x00\x22\x00\x1d\x00\x36\x00\x49\x00\x22\x00\x2a\x00\x2b\x00\xb0\xff\x2c\x00\x2d\x00\x2e\x00\x2a\x00\x2b\x00\x36\x00\x2c\x00\x1d\x00\x93\x00\xc4\x00\x84\x00\x2d\x00\x2e\x00\x72\x00\x2b\x00\x87\x00\x2c\x00\x2d\x00\x2e\x00\x76\x00\x6f\x00\x88\x00\x76\x00\x2a\x00\x37\x00\xc2\x00\x71\x00\x73\x00\x2e\x00\x2a\x00\x2b\x00\x58\x00\x2c\x00\x22\x00\x2a\x00\x2b\x00\x74\x00\x2c\x00\x3e\x00\x2a\x00\x2b\x00\x25\x00\x2c\x00\x2d\x00\x2e\x00\x22\x00\xff\xff\xff\xff\xa4\x00\x2e\x00\x26\x00\xaa\x00\x2f\x00\xa5\x00\x2e\x00\x2a\x00\x2b\x00\x54\x00\x2c\x00\x2a\x00\x2b\x00\x6a\x00\x2c\x00\x2a\x00\x2b\x00\x4b\x00\x2c\x00\x3d\x00\x4c\x00\xa6\x00\x2e\x00\x54\x00\xc4\x00\x95\x00\x2e\x00\x6a\x00\x26\x00\x40\x00\x2e\x00\x22\x00\x7b\x00\x41\x00\x42\x00\x43\x00\x44\x00\x41\x00\x42\x00\x43\x00\x44\x00\x4e\x00\x25\x00\x50\x00\x25\x00\xc2\x00\xab\x00\xb4\x00\x6d\x00\x6c\x00\x45\x00\x26\x00\x82\x00\x26\x00\x27\x00\x4e\x00\x22\x00\x50\x00\xbe\x00\xc0\x00\x52\x00\x52\x00\x4f\x00\x51\x00\x22\x00\x6b\x00\x53\x00\x1d\x00\x69\x00\xba\x00\x4b\x00\x22\x00\xff\xff\x4c\x00\xb8\x00\x7d\x00\x54\x00\x22\x00\xae\x00\xc6\x00\x55\x00\x23\x00\x4b\x00\x22\x00\xbe\x00\x4c\x00\xb8\x00\xb2\x00\x76\x00\xad\x00\x9d\x00\xa1\x00\xb4\x00\xac\x00\x77\x00\x7f\x00\x83\x00\x81\x00\x96\x00\x91\x00\x98\x00\x5c\x00\x5e\x00\x67\x00\x66\x00\x65\x00\x70\x00\x76\x00\x77\x00\x69\x00\x1d\x00\x28\x00\x38\x00\x29\x00\x58\x00\x3a\x00\x76\x00\x39\x00\x56\x00\x49\x00\x58\x00\x4c\x00\x5a\x00\xbc\x00\x3b\x00\xb7\x00\x3c\x00\xb2\x00\xa8\x00\xb6\x00\xa9\x00\x5a\x00\xaa\x00\xb1\x00\x89\x00\xa0\x00\xa3\x00\x9f\x00\xa1\x00\x7f\x00\x4e\x00\x86\x00\x93\x00\x8a\x00\x8d\x00\x8e\x00\x8f\x00\x90\x00\x22\x00\x91\x00\x00\x00\x22\x00\x8b\x00\x95\x00\x1d\x00\x4e\x00\x9a\x00\x9c\x00\x22\x00\x5e\x00\x22\x00\x00\x00\x00\x00\x00\x00\x22\x00\x60\x00\x00\x00\x61\x00\x65\x00\x00\x00\x63\x00\x62\x00\x9b\x00\x00\x00\x00\x00\x22\x00\x00\x00\x00\x00\x00\x00\x1d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x22\x00\x00\x00\x00\x00\xff\xff\x22\x00\xff\xff\x6f\x00\x7d\x00\x00\x00\xff\xff\xff\xff\x76\x00\x7a\x00\xff\xff\x7c\x00\xff\xff\x22\x00\xff\xff\x36\x00\x22\x00\xff\xff\x69\x00\x36\x00\xff\xff\xff\xff\x4e\x00\x00\x00\xff\xff\x58\x00\xff\xff\x5a\x00\x1d\x00\xff\xff\x5c\x00\xff\xff\x22\x00\x00\x00\x22\x00\xae\xff\x22\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (27, 90) [
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
	(90 , happyReduce_90)
	]

happy_n_terms = 38 :: Int
happy_n_nonterms = 31 :: Int

happyReduce_27 = happySpecReduce_1 0# happyReduction_27
happyReduction_27 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TL happy_var_1)) -> 
	happyIn30
		 (happy_var_1
	)}

happyReduce_28 = happySpecReduce_1 1# happyReduction_28
happyReduction_28 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TI happy_var_1)) -> 
	happyIn31
		 ((read happy_var_1) :: Integer
	)}

happyReduce_29 = happySpecReduce_1 2# happyReduction_29
happyReduction_29 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TD happy_var_1)) -> 
	happyIn32
		 ((read happy_var_1) :: Double
	)}

happyReduce_30 = happySpecReduce_1 3# happyReduction_30
happyReduction_30 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (T_CId happy_var_1)) -> 
	happyIn33
		 (CId (happy_var_1)
	)}

happyReduce_31 = happyReduce 9# 4# happyReduction_31
happyReduction_31 (happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut33 happy_x_2 of { happy_var_2 -> 
	case happyOut52 happy_x_4 of { happy_var_4 -> 
	case happyOut35 happy_x_7 of { happy_var_7 -> 
	case happyOut47 happy_x_9 of { happy_var_9 -> 
	happyIn34
		 (Grm happy_var_2 happy_var_4 happy_var_7 (reverse happy_var_9)
	) `HappyStk` happyRest}}}}

happyReduce_32 = happyReduce 9# 5# happyReduction_32
happyReduction_32 (happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut48 happy_x_4 of { happy_var_4 -> 
	case happyOut50 happy_x_6 of { happy_var_6 -> 
	case happyOut49 happy_x_8 of { happy_var_8 -> 
	happyIn35
		 (Abs (reverse happy_var_4) (reverse happy_var_6) (reverse happy_var_8)
	) `HappyStk` happyRest}}}

happyReduce_33 = happyReduce 16# 6# happyReduction_33
happyReduction_33 (happy_x_16 `HappyStk`
	happy_x_15 `HappyStk`
	happy_x_14 `HappyStk`
	happy_x_13 `HappyStk`
	happy_x_12 `HappyStk`
	happy_x_11 `HappyStk`
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
	 = case happyOut33 happy_x_2 of { happy_var_2 -> 
	case happyOut48 happy_x_5 of { happy_var_5 -> 
	case happyOut51 happy_x_7 of { happy_var_7 -> 
	case happyOut51 happy_x_9 of { happy_var_9 -> 
	case happyOut51 happy_x_11 of { happy_var_11 -> 
	case happyOut51 happy_x_13 of { happy_var_13 -> 
	case happyOut51 happy_x_15 of { happy_var_15 -> 
	happyIn36
		 (Cnc happy_var_2 (reverse happy_var_5) (reverse happy_var_7) (reverse happy_var_9) (reverse happy_var_11) (reverse happy_var_13) (reverse happy_var_15)
	) `HappyStk` happyRest}}}}}}}

happyReduce_34 = happySpecReduce_3 7# happyReduction_34
happyReduction_34 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_3 of { happy_var_3 -> 
	happyIn37
		 (Flg happy_var_1 happy_var_3
	)}}

happyReduce_35 = happyReduce 4# 8# happyReduction_35
happyReduction_35 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut59 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 (Cat happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_36 = happyReduce 5# 9# happyReduction_36
happyReduction_36 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut41 happy_x_3 of { happy_var_3 -> 
	case happyOut42 happy_x_5 of { happy_var_5 -> 
	happyIn39
		 (Fun happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_37 = happySpecReduce_3 10# happyReduction_37
happyReduction_37 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_3 of { happy_var_3 -> 
	happyIn40
		 (Lin happy_var_1 happy_var_3
	)}}

happyReduce_38 = happyReduce 5# 11# happyReduction_38
happyReduction_38 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut59 happy_x_2 of { happy_var_2 -> 
	case happyOut33 happy_x_4 of { happy_var_4 -> 
	case happyOut54 happy_x_5 of { happy_var_5 -> 
	happyIn41
		 (DTyp happy_var_2 happy_var_4 (reverse happy_var_5)
	) `HappyStk` happyRest}}}

happyReduce_39 = happyReduce 7# 12# happyReduction_39
happyReduction_39 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut52 happy_x_3 of { happy_var_3 -> 
	case happyOut43 happy_x_5 of { happy_var_5 -> 
	case happyOut54 happy_x_6 of { happy_var_6 -> 
	happyIn42
		 (DTr happy_var_3 happy_var_5 (reverse happy_var_6)
	) `HappyStk` happyRest}}}

happyReduce_40 = happySpecReduce_3 12# happyReduction_40
happyReduction_40 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_2 of { happy_var_2 -> 
	happyIn42
		 (EEq (reverse happy_var_2)
	)}

happyReduce_41 = happySpecReduce_1 13# happyReduction_41
happyReduction_41 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn43
		 (AC happy_var_1
	)}

happyReduce_42 = happySpecReduce_1 13# happyReduction_42
happyReduction_42 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn43
		 (AS happy_var_1
	)}

happyReduce_43 = happySpecReduce_1 13# happyReduction_43
happyReduction_43 happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	happyIn43
		 (AI happy_var_1
	)}

happyReduce_44 = happySpecReduce_1 13# happyReduction_44
happyReduction_44 happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	happyIn43
		 (AF happy_var_1
	)}

happyReduce_45 = happySpecReduce_2 13# happyReduction_45
happyReduction_45 happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_2 of { happy_var_2 -> 
	happyIn43
		 (AM happy_var_2
	)}

happyReduce_46 = happySpecReduce_2 13# happyReduction_46
happyReduction_46 happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_2 of { happy_var_2 -> 
	happyIn43
		 (AV happy_var_2
	)}

happyReduce_47 = happySpecReduce_3 14# happyReduction_47
happyReduction_47 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut53 happy_x_2 of { happy_var_2 -> 
	happyIn44
		 (R happy_var_2
	)}

happyReduce_48 = happyReduce 5# 14# happyReduction_48
happyReduction_48 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut44 happy_x_2 of { happy_var_2 -> 
	case happyOut44 happy_x_4 of { happy_var_4 -> 
	happyIn44
		 (P happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_49 = happySpecReduce_3 14# happyReduction_49
happyReduction_49 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut53 happy_x_2 of { happy_var_2 -> 
	happyIn44
		 (S happy_var_2
	)}

happyReduce_50 = happySpecReduce_1 14# happyReduction_50
happyReduction_50 happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 (K happy_var_1
	)}

happyReduce_51 = happySpecReduce_2 14# happyReduction_51
happyReduction_51 happy_x_2
	happy_x_1
	 =  case happyOut31 happy_x_2 of { happy_var_2 -> 
	happyIn44
		 (V (fromInteger happy_var_2) --H
	)}

happyReduce_52 = happySpecReduce_1 14# happyReduction_52
happyReduction_52 happy_x_1
	 =  case happyOut31 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 (C (fromInteger happy_var_1) --H
	)}

happyReduce_53 = happySpecReduce_1 14# happyReduction_53
happyReduction_53 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 (F happy_var_1
	)}

happyReduce_54 = happySpecReduce_3 14# happyReduction_54
happyReduction_54 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut53 happy_x_2 of { happy_var_2 -> 
	happyIn44
		 (FV happy_var_2
	)}

happyReduce_55 = happyReduce 5# 14# happyReduction_55
happyReduction_55 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut30 happy_x_2 of { happy_var_2 -> 
	case happyOut44 happy_x_4 of { happy_var_4 -> 
	happyIn44
		 (W happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_56 = happySpecReduce_1 14# happyReduction_56
happyReduction_56 happy_x_1
	 =  happyIn44
		 (TM
	)

happyReduce_57 = happyReduce 5# 14# happyReduction_57
happyReduction_57 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut44 happy_x_2 of { happy_var_2 -> 
	case happyOut44 happy_x_4 of { happy_var_4 -> 
	happyIn44
		 (RP happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_58 = happySpecReduce_1 15# happyReduction_58
happyReduction_58 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (KS happy_var_1
	)}

happyReduce_59 = happyReduce 7# 15# happyReduction_59
happyReduction_59 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut55 happy_x_3 of { happy_var_3 -> 
	case happyOut56 happy_x_5 of { happy_var_5 -> 
	happyIn45
		 (KP (reverse happy_var_3) happy_var_5
	) `HappyStk` happyRest}}

happyReduce_60 = happySpecReduce_3 16# happyReduction_60
happyReduction_60 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut55 happy_x_3 of { happy_var_3 -> 
	happyIn46
		 (Var (reverse happy_var_1) (reverse happy_var_3)
	)}}

happyReduce_61 = happySpecReduce_0 17# happyReduction_61
happyReduction_61  =  happyIn47
		 ([]
	)

happyReduce_62 = happySpecReduce_3 17# happyReduction_62
happyReduction_62 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut47 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_2 of { happy_var_2 -> 
	happyIn47
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_63 = happySpecReduce_0 18# happyReduction_63
happyReduction_63  =  happyIn48
		 ([]
	)

happyReduce_64 = happySpecReduce_3 18# happyReduction_64
happyReduction_64 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_2 of { happy_var_2 -> 
	happyIn48
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_65 = happySpecReduce_0 19# happyReduction_65
happyReduction_65  =  happyIn49
		 ([]
	)

happyReduce_66 = happySpecReduce_3 19# happyReduction_66
happyReduction_66 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_2 of { happy_var_2 -> 
	happyIn49
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_67 = happySpecReduce_0 20# happyReduction_67
happyReduction_67  =  happyIn50
		 ([]
	)

happyReduce_68 = happySpecReduce_3 20# happyReduction_68
happyReduction_68 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_2 of { happy_var_2 -> 
	happyIn50
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_69 = happySpecReduce_0 21# happyReduction_69
happyReduction_69  =  happyIn51
		 ([]
	)

happyReduce_70 = happySpecReduce_3 21# happyReduction_70
happyReduction_70 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	case happyOut40 happy_x_2 of { happy_var_2 -> 
	happyIn51
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_71 = happySpecReduce_0 22# happyReduction_71
happyReduction_71  =  happyIn52
		 ([]
	)

happyReduce_72 = happySpecReduce_1 22# happyReduction_72
happyReduction_72 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn52
		 ((:[]) happy_var_1
	)}

happyReduce_73 = happySpecReduce_3 22# happyReduction_73
happyReduction_73 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut52 happy_x_3 of { happy_var_3 -> 
	happyIn52
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_74 = happySpecReduce_0 23# happyReduction_74
happyReduction_74  =  happyIn53
		 ([]
	)

happyReduce_75 = happySpecReduce_1 23# happyReduction_75
happyReduction_75 happy_x_1
	 =  case happyOut44 happy_x_1 of { happy_var_1 -> 
	happyIn53
		 ((:[]) happy_var_1
	)}

happyReduce_76 = happySpecReduce_3 23# happyReduction_76
happyReduction_76 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut44 happy_x_1 of { happy_var_1 -> 
	case happyOut53 happy_x_3 of { happy_var_3 -> 
	happyIn53
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_77 = happySpecReduce_0 24# happyReduction_77
happyReduction_77  =  happyIn54
		 ([]
	)

happyReduce_78 = happySpecReduce_2 24# happyReduction_78
happyReduction_78 happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_2 of { happy_var_2 -> 
	happyIn54
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_79 = happySpecReduce_0 25# happyReduction_79
happyReduction_79  =  happyIn55
		 ([]
	)

happyReduce_80 = happySpecReduce_2 25# happyReduction_80
happyReduction_80 happy_x_2
	happy_x_1
	 =  case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut30 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_81 = happySpecReduce_0 26# happyReduction_81
happyReduction_81  =  happyIn56
		 ([]
	)

happyReduce_82 = happySpecReduce_1 26# happyReduction_82
happyReduction_82 happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	happyIn56
		 ((:[]) happy_var_1
	)}

happyReduce_83 = happySpecReduce_3 26# happyReduction_83
happyReduction_83 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	case happyOut56 happy_x_3 of { happy_var_3 -> 
	happyIn56
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_84 = happySpecReduce_3 27# happyReduction_84
happyReduction_84 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut41 happy_x_3 of { happy_var_3 -> 
	happyIn57
		 (Hyp happy_var_1 happy_var_3
	)}}

happyReduce_85 = happySpecReduce_3 28# happyReduction_85
happyReduction_85 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_3 of { happy_var_3 -> 
	happyIn58
		 (Equ (reverse happy_var_1) happy_var_3
	)}}

happyReduce_86 = happySpecReduce_0 29# happyReduction_86
happyReduction_86  =  happyIn59
		 ([]
	)

happyReduce_87 = happySpecReduce_1 29# happyReduction_87
happyReduction_87 happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	happyIn59
		 ((:[]) happy_var_1
	)}

happyReduce_88 = happySpecReduce_3 29# happyReduction_88
happyReduction_88 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	case happyOut59 happy_x_3 of { happy_var_3 -> 
	happyIn59
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_89 = happySpecReduce_0 30# happyReduction_89
happyReduction_89  =  happyIn60
		 ([]
	)

happyReduce_90 = happySpecReduce_3 30# happyReduction_90
happyReduction_90 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_1 of { happy_var_1 -> 
	case happyOut58 happy_x_2 of { happy_var_2 -> 
	happyIn60
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyNewToken action sts stk [] =
	happyDoAction 37# (error "reading EOF!") action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	PT _ (TS "(") -> cont 1#;
	PT _ (TS ")") -> cont 2#;
	PT _ (TS ";") -> cont 3#;
	PT _ (TS "{") -> cont 4#;
	PT _ (TS "}") -> cont 5#;
	PT _ (TS "=") -> cont 6#;
	PT _ (TS "[") -> cont 7#;
	PT _ (TS "]") -> cont 8#;
	PT _ (TS ":") -> cont 9#;
	PT _ (TS "?") -> cont 10#;
	PT _ (TS "!") -> cont 11#;
	PT _ (TS "$") -> cont 12#;
	PT _ (TS "[|") -> cont 13#;
	PT _ (TS "|]") -> cont 14#;
	PT _ (TS "+") -> cont 15#;
	PT _ (TS "/") -> cont 16#;
	PT _ (TS "@") -> cont 17#;
	PT _ (TS ",") -> cont 18#;
	PT _ (TS "->") -> cont 19#;
	PT _ (TS "abstract") -> cont 20#;
	PT _ (TS "cat") -> cont 21#;
	PT _ (TS "concrete") -> cont 22#;
	PT _ (TS "flags") -> cont 23#;
	PT _ (TS "fun") -> cont 24#;
	PT _ (TS "grammar") -> cont 25#;
	PT _ (TS "lin") -> cont 26#;
	PT _ (TS "lincat") -> cont 27#;
	PT _ (TS "lindef") -> cont 28#;
	PT _ (TS "oper") -> cont 29#;
	PT _ (TS "pre") -> cont 30#;
	PT _ (TS "printname") -> cont 31#;
	PT _ (TL happy_dollar_dollar) -> cont 32#;
	PT _ (TI happy_dollar_dollar) -> cont 33#;
	PT _ (TD happy_dollar_dollar) -> cont 34#;
	PT _ (T_CId happy_dollar_dollar) -> cont 35#;
	_ -> cont 36#;
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

pGrammar tks = happySomeParser where
  happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut34 x))

pAbstract tks = happySomeParser where
  happySomeParser = happyThen (happyParse 1# tks) (\x -> happyReturn (happyOut35 x))

pConcrete tks = happySomeParser where
  happySomeParser = happyThen (happyParse 2# tks) (\x -> happyReturn (happyOut36 x))

pFlag tks = happySomeParser where
  happySomeParser = happyThen (happyParse 3# tks) (\x -> happyReturn (happyOut37 x))

pCatDef tks = happySomeParser where
  happySomeParser = happyThen (happyParse 4# tks) (\x -> happyReturn (happyOut38 x))

pFunDef tks = happySomeParser where
  happySomeParser = happyThen (happyParse 5# tks) (\x -> happyReturn (happyOut39 x))

pLinDef tks = happySomeParser where
  happySomeParser = happyThen (happyParse 6# tks) (\x -> happyReturn (happyOut40 x))

pType tks = happySomeParser where
  happySomeParser = happyThen (happyParse 7# tks) (\x -> happyReturn (happyOut41 x))

pExp tks = happySomeParser where
  happySomeParser = happyThen (happyParse 8# tks) (\x -> happyReturn (happyOut42 x))

pAtom tks = happySomeParser where
  happySomeParser = happyThen (happyParse 9# tks) (\x -> happyReturn (happyOut43 x))

pTerm tks = happySomeParser where
  happySomeParser = happyThen (happyParse 10# tks) (\x -> happyReturn (happyOut44 x))

pTokn tks = happySomeParser where
  happySomeParser = happyThen (happyParse 11# tks) (\x -> happyReturn (happyOut45 x))

pVariant tks = happySomeParser where
  happySomeParser = happyThen (happyParse 12# tks) (\x -> happyReturn (happyOut46 x))

pListConcrete tks = happySomeParser where
  happySomeParser = happyThen (happyParse 13# tks) (\x -> happyReturn (happyOut47 x))

pListFlag tks = happySomeParser where
  happySomeParser = happyThen (happyParse 14# tks) (\x -> happyReturn (happyOut48 x))

pListCatDef tks = happySomeParser where
  happySomeParser = happyThen (happyParse 15# tks) (\x -> happyReturn (happyOut49 x))

pListFunDef tks = happySomeParser where
  happySomeParser = happyThen (happyParse 16# tks) (\x -> happyReturn (happyOut50 x))

pListLinDef tks = happySomeParser where
  happySomeParser = happyThen (happyParse 17# tks) (\x -> happyReturn (happyOut51 x))

pListCId tks = happySomeParser where
  happySomeParser = happyThen (happyParse 18# tks) (\x -> happyReturn (happyOut52 x))

pListTerm tks = happySomeParser where
  happySomeParser = happyThen (happyParse 19# tks) (\x -> happyReturn (happyOut53 x))

pListExp tks = happySomeParser where
  happySomeParser = happyThen (happyParse 20# tks) (\x -> happyReturn (happyOut54 x))

pListString tks = happySomeParser where
  happySomeParser = happyThen (happyParse 21# tks) (\x -> happyReturn (happyOut55 x))

pListVariant tks = happySomeParser where
  happySomeParser = happyThen (happyParse 22# tks) (\x -> happyReturn (happyOut56 x))

pHypo tks = happySomeParser where
  happySomeParser = happyThen (happyParse 23# tks) (\x -> happyReturn (happyOut57 x))

pEquation tks = happySomeParser where
  happySomeParser = happyThen (happyParse 24# tks) (\x -> happyReturn (happyOut58 x))

pListHypo tks = happySomeParser where
  happySomeParser = happyThen (happyParse 25# tks) (\x -> happyReturn (happyOut59 x))

pListEquation tks = happySomeParser where
  happySomeParser = happyThen (happyParse 26# tks) (\x -> happyReturn (happyOut60 x))

happySeq = happyDontSeq

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map prToken (take 4 ts))

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
