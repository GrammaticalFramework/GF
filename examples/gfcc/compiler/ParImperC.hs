{-# OPTIONS -fglasgow-exts -cpp #-}
-- parser produced by Happy Version 1.13

module ParImperC where
import Trees
import LexImperC
import ErrM
import Array
#if __GLASGOW_HASKELL__ >= 503
import GHC.Exts
#else
import GlaExts
#endif

newtype HappyAbsSyn t6 t7 = HappyAbsSyn (() -> ())
happyIn6 :: t6 -> (HappyAbsSyn t6 t7)
happyIn6 x = unsafeCoerce# x
{-# INLINE happyIn6 #-}
happyOut6 :: (HappyAbsSyn t6 t7) -> t6
happyOut6 x = unsafeCoerce# x
{-# INLINE happyOut6 #-}
happyIn7 :: t7 -> (HappyAbsSyn t6 t7)
happyIn7 x = unsafeCoerce# x
{-# INLINE happyIn7 #-}
happyOut7 :: (HappyAbsSyn t6 t7) -> t7
happyOut7 x = unsafeCoerce# x
{-# INLINE happyOut7 #-}
happyIn8 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn8 x = unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut8 x = unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn9 x = unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut9 x = unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn10 x = unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut10 x = unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn11 x = unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut11 x = unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn12 x = unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut12 x = unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn13 x = unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut13 x = unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn14 x = unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut14 x = unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn15 x = unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut15 x = unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn16 x = unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut16 x = unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn17 x = unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut17 x = unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn18 x = unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut18 x = unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn19 x = unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut19 x = unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn20 x = unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut20 x = unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: (CFTree) -> (HappyAbsSyn t6 t7)
happyIn21 x = unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn t6 t7) -> (CFTree)
happyOut21 x = unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyInTok :: Token -> (HappyAbsSyn t6 t7)
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn t6 t7) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x1c\x00\xfc\xff\x05\x00\xc0\x00\x00\x00\xcb\x00\xc2\x00\xbf\x00\x00\x00\x21\x00\xbe\x00\x00\x00\x05\x00\x00\x00\xc7\x00\xba\x00\xb3\x00\xfc\xff\x00\x00\xc5\x00\x00\x00\xc4\x00\x03\x00\xc3\x00\xb1\x00\xaa\x00\xc1\x00\x05\x00\xbd\x00\x00\x00\x0c\x00\x05\x00\xb9\x00\xbc\x00\x05\x00\xbb\x00\x05\x00\x05\x00\x05\x00\x05\x00\xa4\x00\x01\x00\xb7\x00\xb8\x00\x00\x00\x00\x00\xaf\x00\xfb\xff\xaf\x00\x00\x00\x00\x00\xb5\x00\xfc\xff\xfc\xff\xb6\x00\xb0\x00\x00\x00\x00\x00\x00\x00\xb4\x00\x11\x00\x9f\x00\xb2\x00\xae\x00\xfc\xff\x05\x00\xfc\xff\x00\x00\x00\x00\xfc\xff\x00\x00\x05\x00\x00\x00\x00\x00\xa3\x00\xad\x00\xfc\xff\xfc\xff\xa9\x00\xa5\x00\x1c\x00\xfc\xff\x9c\x00\x00\x00\x59\x00\xfc\xff\xfc\xff\xfc\xff\x56\x00\x00\x00\x53\x00\x00\x00\x47\x00\x1c\x00\x00\x00\x00\x00\x00\x00\x1c\x00\x00\x00\x35\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\xa2\x00\x5c\x00\x90\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x89\x00\x00\x00\x00\x00\x00\x00\x4a\x00\x5b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x82\x00\x00\x00\x3c\x00\x00\x00\x00\x00\x7b\x00\x00\x00\x00\x00\x33\x00\x74\x00\x00\x00\x00\x00\x6d\x00\x00\x00\xa7\x00\xa0\x00\x97\x00\x99\x00\x2f\x00\x32\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x58\x00\x57\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x15\x00\x0b\x00\x00\x00\x00\x00\x4d\x00\x66\x00\x4c\x00\x00\x00\x00\x00\x49\x00\x00\x00\x24\x00\x00\x00\x00\x00\x00\x00\x00\x00\x48\x00\x3e\x00\x00\x00\x00\x00\xff\xff\x16\x00\x00\x00\x00\x00\x00\x00\x3d\x00\x3a\x00\x39\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa1\x00\x00\x00\x00\x00\x00\x00\x9a\x00\x00\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xd6\xff\xe9\xff\x00\x00\x00\x00\xfc\xff\xed\xff\xee\xff\x00\x00\xfa\xff\xf9\xff\xf7\xff\xf4\xff\x00\x00\xfb\xff\x00\x00\x00\x00\x00\x00\xe9\xff\xe1\xff\x00\x00\xe0\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe5\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd9\xff\x00\x00\xf0\xff\xef\xff\xf5\xff\xf8\xff\xf6\xff\xf3\xff\xf2\xff\x00\x00\xe9\xff\xe9\xff\x00\x00\x00\x00\xe3\xff\xe2\xff\xe6\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe9\xff\x00\x00\xe9\xff\xeb\xff\xea\xff\xe9\xff\xf1\xff\x00\x00\xda\xff\xec\xff\x00\x00\x00\x00\xe9\xff\xe9\xff\x00\x00\xdc\xff\x00\x00\xe9\xff\x00\x00\xe4\xff\x00\x00\xe9\xff\xe9\xff\xe9\xff\x00\x00\xdb\xff\x00\x00\xdd\xff\x00\x00\xd6\xff\xe7\xff\xe8\xff\xd4\xff\xd6\xff\xd5\xff\xde\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x05\x00\x01\x00\x02\x00\x01\x00\x0a\x00\x01\x00\x04\x00\x09\x00\x0e\x00\x0b\x00\x00\x00\x10\x00\x11\x00\x12\x00\x13\x00\x14\x00\x15\x00\x16\x00\x02\x00\x08\x00\x09\x00\x00\x00\x16\x00\x17\x00\x16\x00\x17\x00\x16\x00\x17\x00\x07\x00\x09\x00\x09\x00\x0b\x00\x10\x00\x0c\x00\x12\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x0a\x00\x10\x00\x0c\x00\x12\x00\x0e\x00\x01\x00\x0d\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x0d\x00\x07\x00\x07\x00\x09\x00\x09\x00\x07\x00\x07\x00\x09\x00\x09\x00\x00\x00\x00\x00\x00\x00\x04\x00\x00\x00\x00\x00\x19\x00\x07\x00\x07\x00\x09\x00\x09\x00\x07\x00\x07\x00\x09\x00\x09\x00\x00\x00\x00\x00\x06\x00\x04\x00\x00\x00\x00\x00\x04\x00\x07\x00\x07\x00\x09\x00\x09\x00\x07\x00\x07\x00\x09\x00\x09\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x05\x00\x06\x00\x00\x00\x01\x00\x00\x00\x01\x00\x04\x00\x05\x00\x06\x00\x05\x00\x06\x00\x00\x00\x01\x00\x06\x00\x09\x00\x0a\x00\x05\x00\x06\x00\x00\x00\x01\x00\x0f\x00\x09\x00\x09\x00\x07\x00\x06\x00\x05\x00\x02\x00\x0f\x00\x0f\x00\x0f\x00\x05\x00\x02\x00\x16\x00\x02\x00\x07\x00\x02\x00\x04\x00\x02\x00\x17\x00\x0d\x00\x02\x00\x07\x00\x06\x00\x04\x00\x04\x00\x01\x00\x19\x00\x01\x00\x01\x00\x01\x00\x16\x00\xff\xff\x16\x00\x03\x00\x0d\x00\x01\x00\x0b\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x19\x00\xff\xff\xff\xff\x16\x00\xff\xff\x19\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x12\x00\x0d\x00\x2d\x00\x0d\x00\x26\x00\x0d\x00\x1e\x00\x3d\x00\x28\x00\x5b\x00\x4f\x00\x13\x00\x14\x00\x15\x00\x16\x00\x17\x00\x18\x00\x05\x00\x40\x00\x39\x00\x3a\x00\x0e\x00\x05\x00\x0e\x00\x05\x00\x0e\x00\x05\x00\x0e\x00\x59\x00\x3d\x00\x10\x00\x3e\x00\x13\x00\x5a\x00\x15\x00\x05\x00\x06\x00\x2a\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x26\x00\x13\x00\x27\x00\x15\x00\x28\x00\x2d\x00\x48\x00\x05\x00\x06\x00\x2a\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x0e\x00\x0e\x00\x37\x00\x1a\x00\x0e\x00\x0e\x00\x2b\x00\x5e\x00\x5f\x00\x10\x00\x10\x00\x56\x00\x52\x00\x10\x00\x10\x00\x0e\x00\x0e\x00\x21\x00\x62\x00\x0e\x00\x0e\x00\xde\xff\x53\x00\x49\x00\x10\x00\x10\x00\x4a\x00\x4c\x00\x10\x00\x10\x00\x0e\x00\x0e\x00\x5d\x00\x5e\x00\x0e\x00\x0e\x00\x58\x00\x43\x00\x44\x00\x10\x00\x10\x00\x20\x00\x0f\x00\x10\x00\x10\x00\x05\x00\x06\x00\x4b\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x05\x00\x06\x00\x33\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x05\x00\x06\x00\x36\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x05\x00\x06\x00\x3b\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x05\x00\x06\x00\x1c\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x05\x00\x06\x00\x23\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x05\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x0b\x00\x05\x00\x06\x00\x05\x00\x06\x00\x2f\x00\x0a\x00\x0b\x00\x2e\x00\x0b\x00\x05\x00\x06\x00\x59\x00\x18\x00\x62\x00\x30\x00\x0b\x00\x05\x00\x06\x00\x63\x00\x18\x00\x18\x00\x51\x00\x31\x00\x52\x00\x55\x00\x60\x00\x19\x00\x56\x00\x4e\x00\x4f\x00\x05\x00\x41\x00\x42\x00\x43\x00\x46\x00\x47\x00\x0e\x00\x25\x00\x33\x00\x48\x00\x36\x00\x35\x00\x3b\x00\x3d\x00\xff\xff\x1c\x00\x1f\x00\x20\x00\x05\x00\x00\x00\x05\x00\x23\x00\x25\x00\x2a\x00\x29\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\xff\x00\x00\x00\x00\x05\x00\x00\x00\xff\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (3, 43) [
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
	(43 , happyReduce_43)
	]

happy_n_terms = 26 :: Int
happy_n_nonterms = 16 :: Int

happyReduce_3 = happySpecReduce_1 0# happyReduction_3
happyReduction_3 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TV happy_var_1)) -> 
	happyIn6
		 (mkAtTree (AV (Ident happy_var_1))
	)}

happyReduce_4 = happySpecReduce_1 1# happyReduction_4
happyReduction_4 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TI happy_var_1)) -> 
	happyIn7
		 (mkAtTree (AI ((read happy_var_1) :: Integer))
	)}

happyReduce_5 = happySpecReduce_1 2# happyReduction_5
happyReduction_5 happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	happyIn8
		 (happy_var_1
	)}

happyReduce_6 = happySpecReduce_1 3# happyReduction_6
happyReduction_6 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn9
		 (happy_var_1
	)}

happyReduce_7 = happySpecReduce_3 3# happyReduction_7
happyReduction_7 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut10 happy_x_3 of { happy_var_3 -> 
	happyIn9
		 (mkFunTree "ELt" [([],[]),([],[]),([],[0]),([],[1])] [ happy_var_1 , happy_var_3 ]
	)}}

happyReduce_8 = happySpecReduce_1 4# happyReduction_8
happyReduction_8 happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	happyIn10
		 (happy_var_1
	)}

happyReduce_9 = happySpecReduce_3 4# happyReduction_9
happyReduction_9 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut11 happy_x_3 of { happy_var_3 -> 
	happyIn10
		 (mkFunTree "EAdd" [([],[]),([],[]),([],[0]),([],[1])] [ happy_var_1 , happy_var_3 ]
	)}}

happyReduce_10 = happySpecReduce_3 4# happyReduction_10
happyReduction_10 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut11 happy_x_3 of { happy_var_3 -> 
	happyIn10
		 (mkFunTree "ESub" [([],[]),([],[]),([],[0]),([],[1])] [ happy_var_1 , happy_var_3 ]
	)}}

happyReduce_11 = happySpecReduce_1 5# happyReduction_11
happyReduction_11 happy_x_1
	 =  case happyOut12 happy_x_1 of { happy_var_1 -> 
	happyIn11
		 (happy_var_1
	)}

happyReduce_12 = happySpecReduce_3 5# happyReduction_12
happyReduction_12 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	case happyOut12 happy_x_3 of { happy_var_3 -> 
	happyIn11
		 (mkFunTree "EMul" [([],[]),([],[]),([],[0]),([],[1])] [ happy_var_1 , happy_var_3 ]
	)}}

happyReduce_13 = happySpecReduce_3 6# happyReduction_13
happyReduction_13 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut8 happy_x_2 of { happy_var_2 -> 
	happyIn12
		 (happy_var_2
	)}

happyReduce_14 = happyReduce 4# 6# happyReduction_14
happyReduction_14 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_3 of { happy_var_3 -> 
	happyIn12
		 (mkFunTree "EApp" [([],[]),([],[]),([],[0]),([],[1])] [ happy_var_1 , happy_var_3 ]
	) `HappyStk` happyRest}}

happyReduce_15 = happySpecReduce_3 6# happyReduction_15
happyReduction_15 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn12
		 (mkFunTree "EAppNil" [([],[]),([],[0])] [ happy_var_1 ]
	)}

happyReduce_16 = happySpecReduce_3 6# happyReduction_16
happyReduction_16 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	case happyOut7 happy_x_3 of { happy_var_3 -> 
	happyIn12
		 (mkFunTree "EFloat" [([],[0]),([],[1])] [ happy_var_1 , happy_var_3 ]
	)}}

happyReduce_17 = happySpecReduce_1 6# happyReduction_17
happyReduction_17 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn12
		 (mkFunTree "EInt" [([],[0])] [ happy_var_1 ]
	)}

happyReduce_18 = happySpecReduce_1 6# happyReduction_18
happyReduction_18 happy_x_1
	 =  case happyOut6 happy_x_1 of { happy_var_1 -> 
	happyIn12
		 (mkFunTree "EVar" [([],[]),([],[0])] [ happy_var_1 ]
	)}

happyReduce_19 = happyReduce 5# 7# happyReduction_19
happyReduction_19 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut6 happy_x_1 of { happy_var_1 -> 
	case happyOut8 happy_x_3 of { happy_var_3 -> 
	case happyOut13 happy_x_5 of { happy_var_5 -> 
	happyIn13
		 (mkFunTree "Assign" [([],[]),([],[0]),([],[1]),([],[2])] [ happy_var_1 , happy_var_3 , happy_var_5 ]
	) `HappyStk` happyRest}}}

happyReduce_20 = happyReduce 4# 7# happyReduction_20
happyReduction_20 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut13 happy_x_2 of { happy_var_2 -> 
	case happyOut13 happy_x_4 of { happy_var_4 -> 
	happyIn13
		 (mkFunTree "Block" [([],[0]),([],[1])] [ happy_var_2 , happy_var_4 ]
	) `HappyStk` happyRest}}

happyReduce_21 = happyReduce 4# 7# happyReduction_21
happyReduction_21 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_2 of { happy_var_2 -> 
	case happyOut13 happy_x_4 of { happy_var_4 -> 
	happyIn13
		 (mkFunTree "Decl" [([],[0]),([[1]],[2])] [ happy_var_1 , happy_var_2 , happy_var_4 ]
	) `HappyStk` happyRest}}}

happyReduce_22 = happySpecReduce_0 7# happyReduction_22
happyReduction_22  =  happyIn13
		 (mkFunTree "End" [] [ ]
	)

happyReduce_23 = happyReduce 8# 7# happyReduction_23
happyReduction_23 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut8 happy_x_3 of { happy_var_3 -> 
	case happyOut13 happy_x_5 of { happy_var_5 -> 
	case happyOut13 happy_x_7 of { happy_var_7 -> 
	case happyOut13 happy_x_8 of { happy_var_8 -> 
	happyIn13
		 (mkFunTree "IfElse" [([],[0]),([],[1]),([],[2]),([],[3])] [ happy_var_3 , happy_var_5 , happy_var_7 , happy_var_8 ]
	) `HappyStk` happyRest}}}}

happyReduce_24 = happyReduce 8# 7# happyReduction_24
happyReduction_24 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut14 happy_x_3 of { happy_var_3 -> 
	case happyOut8 happy_x_5 of { happy_var_5 -> 
	case happyOut13 happy_x_8 of { happy_var_8 -> 
	happyIn13
		 (mkFunTree "Printf" [([],[0]),([],[1]),([],[2])] [ happy_var_3 , happy_var_5 , happy_var_8 ]
	) `HappyStk` happyRest}}}

happyReduce_25 = happySpecReduce_3 7# happyReduction_25
happyReduction_25 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut8 happy_x_2 of { happy_var_2 -> 
	happyIn13
		 (mkFunTree "Return" [([],[]),([],[0])] [ happy_var_2 ]
	)}

happyReduce_26 = happySpecReduce_2 7# happyReduction_26
happyReduction_26 happy_x_2
	happy_x_1
	 =  happyIn13
		 (mkFunTree "Returnv" [] [ ]
	)

happyReduce_27 = happyReduce 6# 7# happyReduction_27
happyReduction_27 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut8 happy_x_3 of { happy_var_3 -> 
	case happyOut13 happy_x_5 of { happy_var_5 -> 
	case happyOut13 happy_x_6 of { happy_var_6 -> 
	happyIn13
		 (mkFunTree "While" [([],[0]),([],[1]),([],[2])] [ happy_var_3 , happy_var_5 , happy_var_6 ]
	) `HappyStk` happyRest}}}

happyReduce_28 = happySpecReduce_1 8# happyReduction_28
happyReduction_28 happy_x_1
	 =  happyIn14
		 (mkFunTree "TFloat" [] [ ]
	)

happyReduce_29 = happySpecReduce_1 8# happyReduction_29
happyReduction_29 happy_x_1
	 =  happyIn14
		 (mkFunTree "TInt" [] [ ]
	)

happyReduce_30 = happySpecReduce_1 9# happyReduction_30
happyReduction_30 happy_x_1
	 =  happyIn15
		 (mkFunTree "TFloat" [] [ ]
	)

happyReduce_31 = happySpecReduce_1 9# happyReduction_31
happyReduction_31 happy_x_1
	 =  happyIn15
		 (mkFunTree "TInt" [] [ ]
	)

happyReduce_32 = happySpecReduce_1 10# happyReduction_32
happyReduction_32 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (mkFunTree "RecCons" [([],[]),([],[]),([[]],[]),([],[0])] [ happy_var_1 ]
	)}

happyReduce_33 = happySpecReduce_1 10# happyReduction_33
happyReduction_33 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (mkFunTree "RecOne" [([],[]),([[]],[]),([],[0])] [ happy_var_1 ]
	)}

happyReduce_34 = happyReduce 4# 11# happyReduction_34
happyReduction_34 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_2 of { happy_var_2 -> 
	case happyOut17 happy_x_4 of { happy_var_4 -> 
	happyIn17
		 (mkFunTree "RecCons" [([],[0]),([],[]),([[1]],[2]),([],[])] [ happy_var_1 , happy_var_2 , happy_var_4 ]
	) `HappyStk` happyRest}}}

happyReduce_35 = happySpecReduce_2 11# happyReduction_35
happyReduction_35 happy_x_2
	happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_2 of { happy_var_2 -> 
	happyIn17
		 (mkFunTree "RecOne" [([],[0]),([[1]],[]),([],[])] [ happy_var_1 , happy_var_2 ]
	)}}

happyReduce_36 = happySpecReduce_1 12# happyReduction_36
happyReduction_36 happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	happyIn18
		 (mkFunTree "RecOne" [([],[]),([[]],[0]),([],[])] [ happy_var_1 ]
	)}

happyReduce_37 = happySpecReduce_3 13# happyReduction_37
happyReduction_37 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_3 of { happy_var_3 -> 
	happyIn19
		 (mkFunTree "ConsExp" [([],[]),([],[]),([],[0]),([],[1])] [ happy_var_1 , happy_var_3 ]
	)}}

happyReduce_38 = happySpecReduce_1 13# happyReduction_38
happyReduction_38 happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	happyIn19
		 (mkFunTree "OneExp" [([],[]),([],[0])] [ happy_var_1 ]
	)}

happyReduce_39 = happySpecReduce_2 14# happyReduction_39
happyReduction_39 happy_x_2
	happy_x_1
	 =  case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_2 of { happy_var_2 -> 
	happyIn20
		 (mkFunTree "ConsTyp" [([],[0]),([],[1])] [ happy_var_1 , happy_var_2 ]
	)}}

happyReduce_40 = happySpecReduce_0 14# happyReduction_40
happyReduction_40  =  happyIn20
		 (mkFunTree "NilTyp" [] [ ]
	)

happyReduce_41 = happySpecReduce_0 15# happyReduction_41
happyReduction_41  =  happyIn21
		 (mkFunTree "Empty" [] [ ]
	)

happyReduce_42 = happyReduce 10# 15# happyReduction_42
happyReduction_42 (happy_x_10 `HappyStk`
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
	 = case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_2 of { happy_var_2 -> 
	case happyOut17 happy_x_4 of { happy_var_4 -> 
	case happyOut18 happy_x_7 of { happy_var_7 -> 
	case happyOut16 happy_x_10 of { happy_var_10 -> 
	happyIn21
		 (mkFunTree "Funct" [([],[]),([],[0]),([[1]],[2,3,4])] [ happy_var_1 , happy_var_2 , happy_var_4 , happy_var_7 , happy_var_10 ]
	) `HappyStk` happyRest}}}}}

happyReduce_43 = happyReduce 9# 15# happyReduction_43
happyReduction_43 (happy_x_9 `HappyStk`
	happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut15 happy_x_1 of { happy_var_1 -> 
	case happyOut6 happy_x_2 of { happy_var_2 -> 
	case happyOut13 happy_x_6 of { happy_var_6 -> 
	case happyOut21 happy_x_9 of { happy_var_9 -> 
	happyIn21
		 (mkFunTree "FunctNil" [([],[0]),([],[2]),([[1]],[3])] [ happy_var_1 , happy_var_2 , happy_var_6 , happy_var_9 ]
	) `HappyStk` happyRest}}}}

happyNewToken action sts stk [] =
	happyDoAction 25# (error "reading EOF!") action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	PT _ (TS "(") -> cont 1#;
	PT _ (TS ")") -> cont 2#;
	PT _ (TS "=") -> cont 3#;
	PT _ (TS ";") -> cont 4#;
	PT _ (TS "{") -> cont 5#;
	PT _ (TS "}") -> cont 6#;
	PT _ (TS ",") -> cont 7#;
	PT _ (TS "\"%f\"") -> cont 8#;
	PT _ (TS "\"%d\"") -> cont 9#;
	PT _ (TS "+") -> cont 10#;
	PT _ (TS ".") -> cont 11#;
	PT _ (TS "<") -> cont 12#;
	PT _ (TS "*") -> cont 13#;
	PT _ (TS "-") -> cont 14#;
	PT _ (TS "else") -> cont 15#;
	PT _ (TS "float") -> cont 16#;
	PT _ (TS "if") -> cont 17#;
	PT _ (TS "int") -> cont 18#;
	PT _ (TS "printf") -> cont 19#;
	PT _ (TS "return") -> cont 20#;
	PT _ (TS "while") -> cont 21#;
	PT _ (TV happy_dollar_dollar) -> cont 22#;
	PT _ (TI happy_dollar_dollar) -> cont 23#;
	_ -> cont 24#;
	_ -> happyError tks
	}

happyThen :: Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 = \a tks -> (returnM) a

pProgram tks = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut21 x))

pStm tks = happyThen (happyParse 1# tks) (\x -> happyReturn (happyOut13 x))

pExp tks = happyThen (happyParse 2# tks) (\x -> happyReturn (happyOut8 x))

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
-- $Id: ParImperC.hs,v 1.3 2004/12/20 08:57:05 aarne Exp $













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
