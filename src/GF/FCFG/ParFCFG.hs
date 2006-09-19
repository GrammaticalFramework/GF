{-# OPTIONS -fglasgow-exts -cpp #-}
{-# OPTIONS -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module GF.FCFG.ParFCFG where
import GF.FCFG.AbsFCFG
import GF.FCFG.LexFCFG
import GF.Data.ErrM
import Data.Array
#if __GLASGOW_HASKELL__ >= 503
import GHC.Exts
#else
import GlaExts
#endif

-- parser produced by Happy Version 1.15

newtype HappyAbsSyn  = HappyAbsSyn (() -> ())
happyIn32 :: (Integer) -> (HappyAbsSyn )
happyIn32 x = unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> (Integer)
happyOut32 x = unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (String) -> (HappyAbsSyn )
happyIn33 x = unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (String)
happyOut33 x = unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyIn34 :: (Ident) -> (HappyAbsSyn )
happyIn34 x = unsafeCoerce# x
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> (Ident)
happyOut34 x = unsafeCoerce# x
{-# INLINE happyOut34 #-}
happyIn35 :: (Double) -> (HappyAbsSyn )
happyIn35 x = unsafeCoerce# x
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> (Double)
happyOut35 x = unsafeCoerce# x
{-# INLINE happyOut35 #-}
happyIn36 :: (FGrammar) -> (HappyAbsSyn )
happyIn36 x = unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> (FGrammar)
happyOut36 x = unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: (FRule) -> (HappyAbsSyn )
happyIn37 x = unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> (FRule)
happyOut37 x = unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: (Abstract) -> (HappyAbsSyn )
happyIn38 x = unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> (Abstract)
happyOut38 x = unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: (FSymbol) -> (HappyAbsSyn )
happyIn39 x = unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> (FSymbol)
happyOut39 x = unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: (FCat) -> (HappyAbsSyn )
happyIn40 x = unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> (FCat)
happyOut40 x = unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyIn41 :: (PathEl) -> (HappyAbsSyn )
happyIn41 x = unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> (PathEl)
happyOut41 x = unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: (PathTerm) -> (HappyAbsSyn )
happyIn42 x = unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> (PathTerm)
happyOut42 x = unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyIn43 :: (Name) -> (HappyAbsSyn )
happyIn43 x = unsafeCoerce# x
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> (Name)
happyOut43 x = unsafeCoerce# x
{-# INLINE happyOut43 #-}
happyIn44 :: (Profile) -> (HappyAbsSyn )
happyIn44 x = unsafeCoerce# x
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> (Profile)
happyOut44 x = unsafeCoerce# x
{-# INLINE happyOut44 #-}
happyIn45 :: (Forest) -> (HappyAbsSyn )
happyIn45 x = unsafeCoerce# x
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> (Forest)
happyOut45 x = unsafeCoerce# x
{-# INLINE happyOut45 #-}
happyIn46 :: (Term) -> (HappyAbsSyn )
happyIn46 x = unsafeCoerce# x
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> (Term)
happyOut46 x = unsafeCoerce# x
{-# INLINE happyOut46 #-}
happyIn47 :: (Case) -> (HappyAbsSyn )
happyIn47 x = unsafeCoerce# x
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn ) -> (Case)
happyOut47 x = unsafeCoerce# x
{-# INLINE happyOut47 #-}
happyIn48 :: (Assoc) -> (HappyAbsSyn )
happyIn48 x = unsafeCoerce# x
{-# INLINE happyIn48 #-}
happyOut48 :: (HappyAbsSyn ) -> (Assoc)
happyOut48 x = unsafeCoerce# x
{-# INLINE happyOut48 #-}
happyIn49 :: (Label) -> (HappyAbsSyn )
happyIn49 x = unsafeCoerce# x
{-# INLINE happyIn49 #-}
happyOut49 :: (HappyAbsSyn ) -> (Label)
happyOut49 x = unsafeCoerce# x
{-# INLINE happyOut49 #-}
happyIn50 :: (CIdent) -> (HappyAbsSyn )
happyIn50 x = unsafeCoerce# x
{-# INLINE happyIn50 #-}
happyOut50 :: (HappyAbsSyn ) -> (CIdent)
happyOut50 x = unsafeCoerce# x
{-# INLINE happyOut50 #-}
happyIn51 :: ([FRule]) -> (HappyAbsSyn )
happyIn51 x = unsafeCoerce# x
{-# INLINE happyIn51 #-}
happyOut51 :: (HappyAbsSyn ) -> ([FRule])
happyOut51 x = unsafeCoerce# x
{-# INLINE happyOut51 #-}
happyIn52 :: ([[FSymbol]]) -> (HappyAbsSyn )
happyIn52 x = unsafeCoerce# x
{-# INLINE happyIn52 #-}
happyOut52 :: (HappyAbsSyn ) -> ([[FSymbol]])
happyOut52 x = unsafeCoerce# x
{-# INLINE happyOut52 #-}
happyIn53 :: ([FSymbol]) -> (HappyAbsSyn )
happyIn53 x = unsafeCoerce# x
{-# INLINE happyIn53 #-}
happyOut53 :: (HappyAbsSyn ) -> ([FSymbol])
happyOut53 x = unsafeCoerce# x
{-# INLINE happyOut53 #-}
happyIn54 :: ([FCat]) -> (HappyAbsSyn )
happyIn54 x = unsafeCoerce# x
{-# INLINE happyIn54 #-}
happyOut54 :: (HappyAbsSyn ) -> ([FCat])
happyOut54 x = unsafeCoerce# x
{-# INLINE happyOut54 #-}
happyIn55 :: ([[Forest]]) -> (HappyAbsSyn )
happyIn55 x = unsafeCoerce# x
{-# INLINE happyIn55 #-}
happyOut55 :: (HappyAbsSyn ) -> ([[Forest]])
happyOut55 x = unsafeCoerce# x
{-# INLINE happyOut55 #-}
happyIn56 :: ([Forest]) -> (HappyAbsSyn )
happyIn56 x = unsafeCoerce# x
{-# INLINE happyIn56 #-}
happyOut56 :: (HappyAbsSyn ) -> ([Forest])
happyOut56 x = unsafeCoerce# x
{-# INLINE happyOut56 #-}
happyIn57 :: ([PathTerm]) -> (HappyAbsSyn )
happyIn57 x = unsafeCoerce# x
{-# INLINE happyIn57 #-}
happyOut57 :: (HappyAbsSyn ) -> ([PathTerm])
happyOut57 x = unsafeCoerce# x
{-# INLINE happyOut57 #-}
happyIn58 :: ([Profile]) -> (HappyAbsSyn )
happyIn58 x = unsafeCoerce# x
{-# INLINE happyIn58 #-}
happyOut58 :: (HappyAbsSyn ) -> ([Profile])
happyOut58 x = unsafeCoerce# x
{-# INLINE happyOut58 #-}
happyIn59 :: ([Integer]) -> (HappyAbsSyn )
happyIn59 x = unsafeCoerce# x
{-# INLINE happyIn59 #-}
happyOut59 :: (HappyAbsSyn ) -> ([Integer])
happyOut59 x = unsafeCoerce# x
{-# INLINE happyOut59 #-}
happyIn60 :: ([Term]) -> (HappyAbsSyn )
happyIn60 x = unsafeCoerce# x
{-# INLINE happyIn60 #-}
happyOut60 :: (HappyAbsSyn ) -> ([Term])
happyOut60 x = unsafeCoerce# x
{-# INLINE happyOut60 #-}
happyIn61 :: ([Assoc]) -> (HappyAbsSyn )
happyIn61 x = unsafeCoerce# x
{-# INLINE happyIn61 #-}
happyOut61 :: (HappyAbsSyn ) -> ([Assoc])
happyOut61 x = unsafeCoerce# x
{-# INLINE happyOut61 #-}
happyIn62 :: ([Case]) -> (HappyAbsSyn )
happyIn62 x = unsafeCoerce# x
{-# INLINE happyIn62 #-}
happyOut62 :: (HappyAbsSyn ) -> ([Case])
happyOut62 x = unsafeCoerce# x
{-# INLINE happyOut62 #-}
happyIn63 :: ([[PathEl]]) -> (HappyAbsSyn )
happyIn63 x = unsafeCoerce# x
{-# INLINE happyIn63 #-}
happyOut63 :: (HappyAbsSyn ) -> ([[PathEl]])
happyOut63 x = unsafeCoerce# x
{-# INLINE happyOut63 #-}
happyIn64 :: ([PathEl]) -> (HappyAbsSyn )
happyIn64 x = unsafeCoerce# x
{-# INLINE happyIn64 #-}
happyOut64 :: (HappyAbsSyn ) -> ([PathEl])
happyOut64 x = unsafeCoerce# x
{-# INLINE happyOut64 #-}
happyInTok :: Token -> (HappyAbsSyn )
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x00\x00\x47\x01\x47\x01\x2f\x00\x47\x01\x82\x00\x46\x01\x3c\x01\x37\x00\x3f\x00\xb2\x00\xb2\x00\xd8\x00\xd8\x00\x3c\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3b\x01\x00\x00\xfd\xff\x3a\x01\x1d\x00\xd2\x00\x1d\x00\x1a\x00\x03\x00\x0a\x00\x09\x00\x3a\x01\x02\x00\x0f\x00\x3a\x01\x02\x00\x39\x01\x38\x01\x00\x00\x00\x00\x38\x01\x36\x01\x35\x01\x37\x01\x00\x00\x34\x01\x33\x01\x74\x00\x00\x00\x00\x00\x00\x00\x00\x00\x33\x01\x00\x00\x00\x00\x00\x00\x33\x01\x2e\x01\x00\x00\x00\x00\x2d\x01\x00\x00\x00\x00\x32\x01\x2c\x01\x2c\x01\x00\x00\x2c\x01\x00\x00\x00\x00\x2c\x01\x2b\x01\x00\x00\x29\x01\x30\x01\x28\x01\x31\x01\x27\x01\x2f\x01\x17\x01\x2a\x01\x26\x01\x00\x00\x00\x00\x1b\x01\x15\x01\x69\x00\x00\x00\x4c\x00\x00\x00\xa5\x00\x9a\x00\x5d\x00\x15\x01\xd0\x00\x25\x01\x00\x00\xb2\x00\xb2\x00\x00\x00\x13\x01\x12\x00\x00\x00\x00\x00\x2e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x24\x01\x22\x01\x21\x01\x5b\x00\x07\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf2\xff\xb2\x00\xb2\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\x01\x00\x00\x28\x00\xb2\x00\x20\x01\x11\x01\xf7\x00\x6a\x00\x00\x00\x0d\x01\x1f\x01\x00\x00\x1e\x01\x00\x00\x00\x00\x46\x00\x1d\x01\x1c\x01\x1a\x01\x8d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x19\x01\x00\x00\x00\x00\x18\x01\x00\x00\x63\x00\x14\x01\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\xfe\xff\xf0\x00\xf1\x00\xa0\x00\x10\x01\xb9\x00\x0c\x01\xb3\x00\xcb\x00\xd9\x00\xe1\x00\x88\x00\x9d\x00\x38\x00\x40\x00\xfb\x00\x09\x01\x05\x01\x06\x01\x04\x01\xff\x00\xf6\x00\xf9\x00\xfa\x00\xf8\x00\xf3\x00\xf4\x00\xf2\x00\xed\x00\x00\x00\x00\x00\xa1\x00\xeb\x00\x75\x00\x8c\x00\xe0\x00\x08\x01\xc3\x00\x02\x01\xd1\x00\xee\x00\x01\x01\x64\x00\xef\x00\xec\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x03\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x5a\x00\xea\x00\xe7\x00\xe4\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\xe6\x00\x00\x00\x00\x00\x00\x00\xdf\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfe\x00\x00\x00\x00\x00\xf5\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xec\x00\x00\x00\xe8\x00\xdd\x00\xe9\x00\xe5\x00\xa1\x00\xca\x00\xcd\x00\xae\x00\xe0\x00\x75\x00\x8c\x00\xbf\x00\x00\x00\x00\x00\x00\x00\xde\x00\xda\x00\x00\x00\xbd\x00\x64\x00\x00\x00\x00\x00\xd1\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa1\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x9b\x00\x2b\x00\xd5\x00\xc7\x00\x6f\x00\x00\x00\x00\x00\x00\x00\x65\x00\x00\x00\xc3\x00\xab\x00\x00\x00\x7b\x00\x47\x00\x24\x00\x00\x00\x55\x00\x00\x00\xfc\xff\x00\x00\x00\x00\x00\x00\xa1\x00\x00\x00\x00\x00\x00\x00\x86\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf7\xff\x00\x00\x00\x00\x00\x00\xf6\xff\xfa\xff\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xbe\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xbe\xff\xbc\xff\xba\xff\xb8\xff\xb6\xff\xb4\xff\xb2\xff\xb0\xff\xae\xff\xac\xff\xaa\xff\xa8\xff\xa6\xff\xa4\xff\x00\x00\xe2\xff\x00\x00\xa4\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xb4\xff\x00\x00\x00\x00\xba\xff\x00\x00\x00\x00\x00\x00\xe0\xff\xc1\xff\x00\x00\x00\x00\x00\x00\x00\x00\xc5\xff\x00\x00\x00\x00\x00\x00\xaa\xff\xa8\xff\xac\xff\xe1\xff\x00\x00\xcf\xff\xd0\xff\xce\xff\x00\x00\x00\x00\xd2\xff\xdf\xff\x00\x00\xd3\xff\xae\xff\x00\x00\x00\x00\x00\x00\xa4\xff\x00\x00\xd7\xff\xd8\xff\x00\x00\x00\x00\xda\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xde\xff\x00\x00\xbc\xff\xb8\xff\x00\x00\x00\x00\x00\x00\xb0\xff\x00\x00\xb6\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc4\xff\x00\x00\x00\x00\xc0\xff\x00\x00\x00\x00\xb9\xff\xb7\xff\x00\x00\xb3\xff\xb1\xff\xaf\xff\xad\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa3\xff\xa5\xff\xa7\xff\xa9\xff\xab\xff\xb5\xff\xbb\xff\xbf\xff\xc2\xff\xc3\xff\xac\xff\x00\x00\x00\x00\x00\x00\xa4\xff\xcb\xff\xc9\xff\xc7\xff\xb4\xff\xd4\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xba\xff\xbd\xff\x00\x00\x00\x00\xa6\xff\x00\x00\xd5\xff\xd1\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xcc\xff\xca\xff\xc8\xff\xc6\xff\xcd\xff\xd6\xff\xa4\xff\xdb\xff\xdc\xff\x00\x00\xb2\xff\x00\x00\x00\x00\xd9\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x04\x00\x04\x00\x06\x00\x0a\x00\x13\x00\x04\x00\x04\x00\x0b\x00\x06\x00\x18\x00\x0e\x00\x09\x00\x04\x00\x04\x00\x19\x00\x13\x00\x13\x00\x09\x00\x04\x00\x17\x00\x18\x00\x04\x00\x20\x00\x1b\x00\x16\x00\x17\x00\x1f\x00\x19\x00\x1b\x00\x1b\x00\x16\x00\x17\x00\x04\x00\x19\x00\x06\x00\x1b\x00\x1b\x00\x17\x00\x15\x00\x0b\x00\x17\x00\x1b\x00\x0e\x00\x04\x00\x02\x00\x06\x00\x07\x00\x16\x00\x09\x00\x04\x00\x04\x00\x17\x00\x1b\x00\x08\x00\x09\x00\x1b\x00\x15\x00\x02\x00\x04\x00\x11\x00\x06\x00\x16\x00\x17\x00\x09\x00\x19\x00\x02\x00\x04\x00\x16\x00\x17\x00\x17\x00\x19\x00\x09\x00\x11\x00\x04\x00\x05\x00\x06\x00\x16\x00\x17\x00\x08\x00\x19\x00\x0b\x00\x12\x00\x07\x00\x0e\x00\x16\x00\x17\x00\x02\x00\x19\x00\x13\x00\x00\x00\x01\x00\x02\x00\x17\x00\x18\x00\x04\x00\x0b\x00\x06\x00\x16\x00\x08\x00\x07\x00\x01\x00\x0b\x00\x04\x00\x0e\x00\x0e\x00\x07\x00\x07\x00\x12\x00\x04\x00\x13\x00\x06\x00\x13\x00\x08\x00\x17\x00\x18\x00\x0b\x00\x18\x00\x01\x00\x0e\x00\x04\x00\x05\x00\x06\x00\x00\x00\x13\x00\x18\x00\x14\x00\x0b\x00\x17\x00\x18\x00\x0e\x00\x0e\x00\x0f\x00\x1b\x00\x04\x00\x01\x00\x06\x00\x01\x00\x16\x00\x17\x00\x18\x00\x0b\x00\x02\x00\x20\x00\x0e\x00\x04\x00\x05\x00\x06\x00\x0e\x00\x13\x00\x0e\x00\x0f\x00\x0b\x00\x17\x00\x18\x00\x0e\x00\x10\x00\x11\x00\x04\x00\x02\x00\x06\x00\x01\x00\x01\x00\x02\x00\x17\x00\x0b\x00\x0c\x00\x07\x00\x0e\x00\x04\x00\x09\x00\x06\x00\x01\x00\x10\x00\x11\x00\x0e\x00\x0b\x00\x17\x00\x11\x00\x0e\x00\x0f\x00\x02\x00\x04\x00\x1c\x00\x06\x00\x0e\x00\x01\x00\x02\x00\x17\x00\x0b\x00\x0b\x00\x02\x00\x0e\x00\x02\x00\x09\x00\x00\x00\x01\x00\x17\x00\x03\x00\x0e\x00\x01\x00\x17\x00\x11\x00\x00\x00\x01\x00\x00\x00\x03\x00\x0c\x00\x0d\x00\x00\x00\x01\x00\x03\x00\x03\x00\x0e\x00\x01\x00\x0c\x00\x0d\x00\x00\x00\x01\x00\x01\x00\x03\x00\x0d\x00\x0d\x00\x01\x00\x10\x00\x01\x00\x01\x00\x0e\x00\x1a\x00\x13\x00\x0d\x00\x02\x00\x0e\x00\x00\x00\x18\x00\x13\x00\x0e\x00\x1b\x00\x0e\x00\x0e\x00\x18\x00\x05\x00\x06\x00\x16\x00\x08\x00\x05\x00\x06\x00\x06\x00\x08\x00\x08\x00\x03\x00\x04\x00\x14\x00\x08\x00\x00\x00\x20\x00\x1c\x00\x1b\x00\x02\x00\x00\x00\x15\x00\x1e\x00\x18\x00\x1d\x00\x00\x00\x08\x00\x03\x00\x20\x00\x0a\x00\x20\x00\x13\x00\x19\x00\x1d\x00\x1f\x00\x1e\x00\x1a\x00\x1c\x00\x1b\x00\x0a\x00\x18\x00\x08\x00\x05\x00\x15\x00\x17\x00\x16\x00\x14\x00\x06\x00\x05\x00\x07\x00\x05\x00\x05\x00\x05\x00\x05\x00\x18\x00\x06\x00\x16\x00\x05\x00\x08\x00\x08\x00\x18\x00\x08\x00\x18\x00\x04\x00\x0a\x00\x01\x00\x16\x00\x1b\x00\x02\x00\x04\x00\xff\xff\xff\xff\xff\xff\x06\x00\xff\xff\x14\x00\xff\xff\x03\x00\xff\xff\xff\xff\xff\xff\xff\xff\x16\x00\x1b\x00\x1b\x00\x1b\x00\x11\x00\x18\x00\x1b\x00\x1b\x00\x12\x00\x04\x00\x04\x00\x16\x00\xff\xff\x1b\x00\xff\xff\x1b\x00\x16\x00\xff\xff\x1b\x00\x18\x00\x1b\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x39\x00\x58\x00\x3a\x00\x73\x00\x33\x00\x51\x00\x43\x00\x3b\x00\x48\x00\x30\x00\x3c\x00\x44\x00\x43\x00\x4c\x00\xac\x00\x33\x00\x59\x00\x44\x00\x54\x00\x3d\x00\x30\x00\x54\x00\x79\x00\xff\xff\x1f\x00\x3d\x00\xa7\x00\x45\x00\xff\xff\xff\xff\x1f\x00\x3d\x00\x39\x00\x45\x00\x3a\x00\xff\xff\xff\xff\x3d\x00\x82\x00\x3b\x00\x3d\x00\xff\xff\x3c\x00\x43\x00\x30\x00\x48\x00\x9b\x00\x1f\x00\x44\x00\x43\x00\x54\x00\x3d\x00\xff\xff\x81\x00\x44\x00\xff\xff\x6e\x00\x30\x00\x43\x00\x9f\x00\x48\x00\x1f\x00\x3d\x00\x44\x00\x45\x00\x2d\x00\x43\x00\x1f\x00\x3d\x00\x3d\x00\x45\x00\x44\x00\x31\x00\x39\x00\xa6\x00\x3a\x00\x1f\x00\x3d\x00\x70\x00\x45\x00\x3b\x00\x2e\x00\x8f\x00\x3c\x00\x1f\x00\x3d\x00\x48\x00\x45\x00\x33\x00\x66\x00\x35\x00\x2d\x00\x3d\x00\x30\x00\x39\x00\xa9\x00\x3a\x00\x1f\x00\x7d\x00\x8b\x00\x51\x00\x3b\x00\x4c\x00\x67\x00\x3c\x00\xae\x00\x6f\x00\x68\x00\x39\x00\x33\x00\x3a\x00\x33\x00\x91\x00\x3d\x00\x30\x00\x3b\x00\x30\x00\x35\x00\x3c\x00\x39\x00\x6a\x00\x3a\x00\x97\x00\x33\x00\x71\x00\xdd\xff\x3b\x00\x3d\x00\x30\x00\x3c\x00\x36\x00\x78\x00\xdd\xff\x39\x00\x35\x00\x3a\x00\x35\x00\x1f\x00\x3d\x00\x30\x00\x3b\x00\x30\x00\x9c\x00\x3c\x00\x39\x00\xa2\x00\x3a\x00\x76\x00\x33\x00\x36\x00\x37\x00\x3b\x00\x3d\x00\x30\x00\x3c\x00\x77\x00\x34\x00\x39\x00\x30\x00\x3a\x00\x51\x00\x35\x00\x30\x00\x3d\x00\x3b\x00\x8c\x00\x52\x00\x3c\x00\x39\x00\x7a\x00\x3a\x00\x35\x00\x33\x00\x34\x00\x4d\x00\x3b\x00\x3d\x00\x4e\x00\x3c\x00\x8d\x00\x48\x00\x39\x00\xa0\x00\x3a\x00\x99\x00\x35\x00\x30\x00\x3d\x00\x3b\x00\x49\x00\x82\x00\x3c\x00\x89\x00\x4c\x00\x3e\x00\x3f\x00\x8d\x00\x40\x00\x4d\x00\x35\x00\x3d\x00\x4e\x00\x3e\x00\x3f\x00\x75\x00\x40\x00\x74\x00\x46\x00\x3e\x00\x3f\x00\x87\x00\x40\x00\x9d\x00\x35\x00\x45\x00\x46\x00\x3e\x00\x3f\x00\x35\x00\x40\x00\x88\x00\x72\x00\x35\x00\x89\x00\x35\x00\x35\x00\x9e\x00\x8f\x00\x33\x00\x41\x00\x91\x00\x83\x00\x92\x00\x30\x00\x33\x00\x84\x00\xff\xff\x76\x00\x3d\x00\x30\x00\x5a\x00\x57\x00\x93\x00\x55\x00\x56\x00\x57\x00\x54\x00\x55\x00\x55\x00\x97\x00\x51\x00\x94\x00\x5d\x00\x5e\x00\x5f\x00\x63\x00\x61\x00\x62\x00\x6c\x00\x6e\x00\x64\x00\x71\x00\x65\x00\x75\x00\x70\x00\x7c\x00\x79\x00\x73\x00\x1f\x00\x2c\x00\x26\x00\x22\x00\x20\x00\x21\x00\x25\x00\x23\x00\x24\x00\x4a\x00\x27\x00\x4f\x00\xaf\x00\x2a\x00\x28\x00\x29\x00\x2b\x00\xac\x00\xa3\x00\xab\x00\xa4\x00\xa5\x00\xa7\x00\xa9\x00\x30\x00\x99\x00\x1f\x00\x9c\x00\x7e\x00\x7f\x00\x30\x00\x80\x00\x30\x00\x51\x00\x86\x00\x5c\x00\x1f\x00\xff\xff\x5d\x00\x51\x00\x00\x00\x00\x00\x00\x00\x61\x00\x00\x00\x96\x00\x00\x00\x6e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x1f\x00\xff\xff\xff\xff\xff\xff\x6b\x00\x30\x00\xff\xff\xff\xff\x6c\x00\x4c\x00\x51\x00\x1f\x00\x00\x00\xff\xff\x00\x00\xff\xff\x1f\x00\x00\x00\xff\xff\x30\x00\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (29, 92) [
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

happy_n_terms = 28 :: Int
happy_n_nonterms = 33 :: Int

happyReduce_29 = happySpecReduce_1 0# happyReduction_29
happyReduction_29 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TI happy_var_1)) -> 
	happyIn32
		 ((read happy_var_1) :: Integer
	)}

happyReduce_30 = happySpecReduce_1 1# happyReduction_30
happyReduction_30 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TL happy_var_1)) -> 
	happyIn33
		 (happy_var_1
	)}

happyReduce_31 = happySpecReduce_1 2# happyReduction_31
happyReduction_31 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TV happy_var_1)) -> 
	happyIn34
		 (Ident happy_var_1
	)}

happyReduce_32 = happySpecReduce_1 3# happyReduction_32
happyReduction_32 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TD happy_var_1)) -> 
	happyIn35
		 ((read happy_var_1) :: Double
	)}

happyReduce_33 = happySpecReduce_1 4# happyReduction_33
happyReduction_33 happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	happyIn36
		 (FGr (reverse happy_var_1)
	)}

happyReduce_34 = happySpecReduce_3 5# happyReduction_34
happyReduction_34 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_1 of { happy_var_1 -> 
	case happyOut52 happy_x_3 of { happy_var_3 -> 
	happyIn37
		 (FR happy_var_1 (reverse happy_var_3)
	)}}

happyReduce_35 = happyReduce 5# 6# happyReduction_35
happyReduction_35 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut54 happy_x_3 of { happy_var_3 -> 
	case happyOut43 happy_x_5 of { happy_var_5 -> 
	happyIn38
		 (Abs happy_var_1 (reverse happy_var_3) happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_36 = happyReduce 5# 7# happyReduction_36
happyReduction_36 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut40 happy_x_2 of { happy_var_2 -> 
	case happyOut32 happy_x_3 of { happy_var_3 -> 
	case happyOut32 happy_x_4 of { happy_var_4 -> 
	happyIn39
		 (FSymCat happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_37 = happySpecReduce_1 7# happyReduction_37
happyReduction_37 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn39
		 (FSymTok happy_var_1
	)}

happyReduce_38 = happyReduce 10# 8# happyReduction_38
happyReduction_38 (happy_x_10 `HappyStk`
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
	 = case happyOut32 happy_x_2 of { happy_var_2 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	case happyOut63 happy_x_5 of { happy_var_5 -> 
	case happyOut57 happy_x_8 of { happy_var_8 -> 
	happyIn40
		 (FC happy_var_2 happy_var_3 (reverse happy_var_5) (reverse happy_var_8)
	) `HappyStk` happyRest}}}}

happyReduce_39 = happySpecReduce_1 9# happyReduction_39
happyReduction_39 happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	happyIn41
		 (PLabel happy_var_1
	)}

happyReduce_40 = happySpecReduce_1 9# happyReduction_40
happyReduction_40 happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	happyIn41
		 (PTerm happy_var_1
	)}

happyReduce_41 = happyReduce 5# 10# happyReduction_41
happyReduction_41 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut64 happy_x_2 of { happy_var_2 -> 
	case happyOut46 happy_x_4 of { happy_var_4 -> 
	happyIn42
		 (PtT (reverse happy_var_2) happy_var_4
	) `HappyStk` happyRest}}

happyReduce_42 = happyReduce 4# 11# happyReduction_42
happyReduction_42 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut58 happy_x_3 of { happy_var_3 -> 
	happyIn43
		 (Nm happy_var_1 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_43 = happySpecReduce_3 12# happyReduction_43
happyReduction_43 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut59 happy_x_2 of { happy_var_2 -> 
	happyIn44
		 (Unify (reverse happy_var_2)
	)}

happyReduce_44 = happySpecReduce_1 12# happyReduction_44
happyReduction_44 happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 (Const happy_var_1
	)}

happyReduce_45 = happySpecReduce_1 13# happyReduction_45
happyReduction_45 happy_x_1
	 =  happyIn45
		 (FMeta
	)

happyReduce_46 = happyReduce 4# 13# happyReduction_46
happyReduction_46 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut34 happy_x_2 of { happy_var_2 -> 
	case happyOut55 happy_x_3 of { happy_var_3 -> 
	happyIn45
		 (FNode happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_47 = happySpecReduce_1 13# happyReduction_47
happyReduction_47 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (FString happy_var_1
	)}

happyReduce_48 = happySpecReduce_1 13# happyReduction_48
happyReduction_48 happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (FInt happy_var_1
	)}

happyReduce_49 = happySpecReduce_1 13# happyReduction_49
happyReduction_49 happy_x_1
	 =  case happyOut35 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (FFloat happy_var_1
	)}

happyReduce_50 = happyReduce 5# 14# happyReduction_50
happyReduction_50 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut32 happy_x_2 of { happy_var_2 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	case happyOut64 happy_x_4 of { happy_var_4 -> 
	happyIn46
		 (Arg happy_var_2 happy_var_3 (reverse happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_51 = happyReduce 5# 14# happyReduction_51
happyReduction_51 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut50 happy_x_2 of { happy_var_2 -> 
	case happyOut60 happy_x_4 of { happy_var_4 -> 
	happyIn46
		 (Constr happy_var_2 (reverse happy_var_4)
	) `HappyStk` happyRest}}

happyReduce_52 = happySpecReduce_3 14# happyReduction_52
happyReduction_52 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut61 happy_x_2 of { happy_var_2 -> 
	happyIn46
		 (Rec (reverse happy_var_2)
	)}

happyReduce_53 = happyReduce 5# 14# happyReduction_53
happyReduction_53 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut46 happy_x_2 of { happy_var_2 -> 
	case happyOut49 happy_x_4 of { happy_var_4 -> 
	happyIn46
		 (Proj happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_54 = happySpecReduce_3 14# happyReduction_54
happyReduction_54 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut62 happy_x_2 of { happy_var_2 -> 
	happyIn46
		 (Tbl (reverse happy_var_2)
	)}

happyReduce_55 = happyReduce 5# 14# happyReduction_55
happyReduction_55 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut46 happy_x_2 of { happy_var_2 -> 
	case happyOut46 happy_x_4 of { happy_var_4 -> 
	happyIn46
		 (Select happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_56 = happySpecReduce_3 14# happyReduction_56
happyReduction_56 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_2 of { happy_var_2 -> 
	happyIn46
		 (Vars (reverse happy_var_2)
	)}

happyReduce_57 = happyReduce 5# 14# happyReduction_57
happyReduction_57 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut46 happy_x_2 of { happy_var_2 -> 
	case happyOut46 happy_x_4 of { happy_var_4 -> 
	happyIn46
		 (Concat happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_58 = happySpecReduce_1 14# happyReduction_58
happyReduction_58 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn46
		 (Tok happy_var_1
	)}

happyReduce_59 = happySpecReduce_2 14# happyReduction_59
happyReduction_59 happy_x_2
	happy_x_1
	 =  happyIn46
		 (Empty
	)

happyReduce_60 = happySpecReduce_3 15# happyReduction_60
happyReduction_60 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	case happyOut46 happy_x_3 of { happy_var_3 -> 
	happyIn47
		 (Cas happy_var_1 happy_var_3
	)}}

happyReduce_61 = happySpecReduce_3 16# happyReduction_61
happyReduction_61 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	case happyOut46 happy_x_3 of { happy_var_3 -> 
	happyIn48
		 (Ass happy_var_1 happy_var_3
	)}}

happyReduce_62 = happySpecReduce_1 17# happyReduction_62
happyReduction_62 happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	happyIn49
		 (L happy_var_1
	)}

happyReduce_63 = happySpecReduce_2 17# happyReduction_63
happyReduction_63 happy_x_2
	happy_x_1
	 =  case happyOut32 happy_x_2 of { happy_var_2 -> 
	happyIn49
		 (LV happy_var_2
	)}

happyReduce_64 = happySpecReduce_3 18# happyReduction_64
happyReduction_64 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn50
		 (CIQ happy_var_1 happy_var_3
	)}}

happyReduce_65 = happySpecReduce_0 19# happyReduction_65
happyReduction_65  =  happyIn51
		 ([]
	)

happyReduce_66 = happySpecReduce_3 19# happyReduction_66
happyReduction_66 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_2 of { happy_var_2 -> 
	happyIn51
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_67 = happySpecReduce_0 20# happyReduction_67
happyReduction_67  =  happyIn52
		 ([]
	)

happyReduce_68 = happySpecReduce_3 20# happyReduction_68
happyReduction_68 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut52 happy_x_1 of { happy_var_1 -> 
	case happyOut53 happy_x_2 of { happy_var_2 -> 
	happyIn52
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_69 = happySpecReduce_0 21# happyReduction_69
happyReduction_69  =  happyIn53
		 ([]
	)

happyReduce_70 = happySpecReduce_2 21# happyReduction_70
happyReduction_70 happy_x_2
	happy_x_1
	 =  case happyOut53 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_2 of { happy_var_2 -> 
	happyIn53
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_71 = happySpecReduce_0 22# happyReduction_71
happyReduction_71  =  happyIn54
		 ([]
	)

happyReduce_72 = happySpecReduce_2 22# happyReduction_72
happyReduction_72 happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut40 happy_x_2 of { happy_var_2 -> 
	happyIn54
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_73 = happySpecReduce_0 23# happyReduction_73
happyReduction_73  =  happyIn55
		 ([]
	)

happyReduce_74 = happySpecReduce_3 23# happyReduction_74
happyReduction_74 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut55 happy_x_1 of { happy_var_1 -> 
	case happyOut56 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_75 = happySpecReduce_0 24# happyReduction_75
happyReduction_75  =  happyIn56
		 ([]
	)

happyReduce_76 = happySpecReduce_2 24# happyReduction_76
happyReduction_76 happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_1 of { happy_var_1 -> 
	case happyOut45 happy_x_2 of { happy_var_2 -> 
	happyIn56
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_77 = happySpecReduce_0 25# happyReduction_77
happyReduction_77  =  happyIn57
		 ([]
	)

happyReduce_78 = happySpecReduce_2 25# happyReduction_78
happyReduction_78 happy_x_2
	happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_2 of { happy_var_2 -> 
	happyIn57
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_79 = happySpecReduce_0 26# happyReduction_79
happyReduction_79  =  happyIn58
		 ([]
	)

happyReduce_80 = happySpecReduce_2 26# happyReduction_80
happyReduction_80 happy_x_2
	happy_x_1
	 =  case happyOut58 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_2 of { happy_var_2 -> 
	happyIn58
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_81 = happySpecReduce_0 27# happyReduction_81
happyReduction_81  =  happyIn59
		 ([]
	)

happyReduce_82 = happySpecReduce_2 27# happyReduction_82
happyReduction_82 happy_x_2
	happy_x_1
	 =  case happyOut59 happy_x_1 of { happy_var_1 -> 
	case happyOut32 happy_x_2 of { happy_var_2 -> 
	happyIn59
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_83 = happySpecReduce_0 28# happyReduction_83
happyReduction_83  =  happyIn60
		 ([]
	)

happyReduce_84 = happySpecReduce_3 28# happyReduction_84
happyReduction_84 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_1 of { happy_var_1 -> 
	case happyOut46 happy_x_2 of { happy_var_2 -> 
	happyIn60
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_85 = happySpecReduce_0 29# happyReduction_85
happyReduction_85  =  happyIn61
		 ([]
	)

happyReduce_86 = happySpecReduce_3 29# happyReduction_86
happyReduction_86 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut61 happy_x_1 of { happy_var_1 -> 
	case happyOut48 happy_x_2 of { happy_var_2 -> 
	happyIn61
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_87 = happySpecReduce_0 30# happyReduction_87
happyReduction_87  =  happyIn62
		 ([]
	)

happyReduce_88 = happySpecReduce_3 30# happyReduction_88
happyReduction_88 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_2 of { happy_var_2 -> 
	happyIn62
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_89 = happySpecReduce_0 31# happyReduction_89
happyReduction_89  =  happyIn63
		 ([]
	)

happyReduce_90 = happySpecReduce_3 31# happyReduction_90
happyReduction_90 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut63 happy_x_1 of { happy_var_1 -> 
	case happyOut64 happy_x_2 of { happy_var_2 -> 
	happyIn63
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_91 = happySpecReduce_0 32# happyReduction_91
happyReduction_91  =  happyIn64
		 ([]
	)

happyReduce_92 = happySpecReduce_3 32# happyReduction_92
happyReduction_92 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut64 happy_x_1 of { happy_var_1 -> 
	case happyOut41 happy_x_2 of { happy_var_2 -> 
	happyIn64
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyNewToken action sts stk [] =
	happyDoAction 27# (error "reading EOF!") action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	PT _ (TS ":=") -> cont 1#;
	PT _ (TS "->") -> cont 2#;
	PT _ (TS ".") -> cont 3#;
	PT _ (TS "(") -> cont 4#;
	PT _ (TS ")") -> cont 5#;
	PT _ (TS "[") -> cont 6#;
	PT _ (TS "]") -> cont 7#;
	PT _ (TS ",") -> cont 8#;
	PT _ (TS "?") -> cont 9#;
	PT _ (TS "-") -> cont 10#;
	PT _ (TS "[-") -> cont 11#;
	PT _ (TS "-]") -> cont 12#;
	PT _ (TS "!") -> cont 13#;
	PT _ (TS "[|") -> cont 14#;
	PT _ (TS "|]") -> cont 15#;
	PT _ (TS "++") -> cont 16#;
	PT _ (TS "=>") -> cont 17#;
	PT _ (TS "=") -> cont 18#;
	PT _ (TS "$") -> cont 19#;
	PT _ (TS ";") -> cont 20#;
	PT _ (TS "|") -> cont 21#;
	PT _ (TI happy_dollar_dollar) -> cont 22#;
	PT _ (TL happy_dollar_dollar) -> cont 23#;
	PT _ (TV happy_dollar_dollar) -> cont 24#;
	PT _ (TD happy_dollar_dollar) -> cont 25#;
	_ -> cont 26#;
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

pFGrammar tks = happySomeParser where
  happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut36 x))

pFRule tks = happySomeParser where
  happySomeParser = happyThen (happyParse 1# tks) (\x -> happyReturn (happyOut37 x))

pAbstract tks = happySomeParser where
  happySomeParser = happyThen (happyParse 2# tks) (\x -> happyReturn (happyOut38 x))

pFSymbol tks = happySomeParser where
  happySomeParser = happyThen (happyParse 3# tks) (\x -> happyReturn (happyOut39 x))

pFCat tks = happySomeParser where
  happySomeParser = happyThen (happyParse 4# tks) (\x -> happyReturn (happyOut40 x))

pPathEl tks = happySomeParser where
  happySomeParser = happyThen (happyParse 5# tks) (\x -> happyReturn (happyOut41 x))

pPathTerm tks = happySomeParser where
  happySomeParser = happyThen (happyParse 6# tks) (\x -> happyReturn (happyOut42 x))

pName tks = happySomeParser where
  happySomeParser = happyThen (happyParse 7# tks) (\x -> happyReturn (happyOut43 x))

pProfile tks = happySomeParser where
  happySomeParser = happyThen (happyParse 8# tks) (\x -> happyReturn (happyOut44 x))

pForest tks = happySomeParser where
  happySomeParser = happyThen (happyParse 9# tks) (\x -> happyReturn (happyOut45 x))

pTerm tks = happySomeParser where
  happySomeParser = happyThen (happyParse 10# tks) (\x -> happyReturn (happyOut46 x))

pCase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 11# tks) (\x -> happyReturn (happyOut47 x))

pAssoc tks = happySomeParser where
  happySomeParser = happyThen (happyParse 12# tks) (\x -> happyReturn (happyOut48 x))

pLabel tks = happySomeParser where
  happySomeParser = happyThen (happyParse 13# tks) (\x -> happyReturn (happyOut49 x))

pCIdent tks = happySomeParser where
  happySomeParser = happyThen (happyParse 14# tks) (\x -> happyReturn (happyOut50 x))

pListFRule tks = happySomeParser where
  happySomeParser = happyThen (happyParse 15# tks) (\x -> happyReturn (happyOut51 x))

pListListFSymbol tks = happySomeParser where
  happySomeParser = happyThen (happyParse 16# tks) (\x -> happyReturn (happyOut52 x))

pListFSymbol tks = happySomeParser where
  happySomeParser = happyThen (happyParse 17# tks) (\x -> happyReturn (happyOut53 x))

pListFCat tks = happySomeParser where
  happySomeParser = happyThen (happyParse 18# tks) (\x -> happyReturn (happyOut54 x))

pListListForest tks = happySomeParser where
  happySomeParser = happyThen (happyParse 19# tks) (\x -> happyReturn (happyOut55 x))

pListForest tks = happySomeParser where
  happySomeParser = happyThen (happyParse 20# tks) (\x -> happyReturn (happyOut56 x))

pListPathTerm tks = happySomeParser where
  happySomeParser = happyThen (happyParse 21# tks) (\x -> happyReturn (happyOut57 x))

pListProfile tks = happySomeParser where
  happySomeParser = happyThen (happyParse 22# tks) (\x -> happyReturn (happyOut58 x))

pListInteger tks = happySomeParser where
  happySomeParser = happyThen (happyParse 23# tks) (\x -> happyReturn (happyOut59 x))

pListTerm tks = happySomeParser where
  happySomeParser = happyThen (happyParse 24# tks) (\x -> happyReturn (happyOut60 x))

pListAssoc tks = happySomeParser where
  happySomeParser = happyThen (happyParse 25# tks) (\x -> happyReturn (happyOut61 x))

pListCase tks = happySomeParser where
  happySomeParser = happyThen (happyParse 26# tks) (\x -> happyReturn (happyOut62 x))

pListListPathEl tks = happySomeParser where
  happySomeParser = happyThen (happyParse 27# tks) (\x -> happyReturn (happyOut63 x))

pListPathEl tks = happySomeParser where
  happySomeParser = happyThen (happyParse 28# tks) (\x -> happyReturn (happyOut64 x))

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
