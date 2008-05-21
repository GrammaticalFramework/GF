{-# OPTIONS -fglasgow-exts -cpp #-}
{-# OPTIONS -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module GF.Devel.Compile.ParGF where
import GF.Devel.Compile.AbsGF
import GF.Devel.Compile.LexGF
import GF.Devel.Compile.ErrM
#if __GLASGOW_HASKELL__ >= 503
import Data.Array
#else
import Array
#endif
#if __GLASGOW_HASKELL__ >= 503
import GHC.Exts
#else
import GlaExts
#endif

-- parser produced by Happy Version 1.16

newtype HappyAbsSyn  = HappyAbsSyn (() -> ())
happyIn7 :: (Integer) -> (HappyAbsSyn )
happyIn7 x = unsafeCoerce# x
{-# INLINE happyIn7 #-}
happyOut7 :: (HappyAbsSyn ) -> (Integer)
happyOut7 x = unsafeCoerce# x
{-# INLINE happyOut7 #-}
happyIn8 :: (String) -> (HappyAbsSyn )
happyIn8 x = unsafeCoerce# x
{-# INLINE happyIn8 #-}
happyOut8 :: (HappyAbsSyn ) -> (String)
happyOut8 x = unsafeCoerce# x
{-# INLINE happyOut8 #-}
happyIn9 :: (Double) -> (HappyAbsSyn )
happyIn9 x = unsafeCoerce# x
{-# INLINE happyIn9 #-}
happyOut9 :: (HappyAbsSyn ) -> (Double)
happyOut9 x = unsafeCoerce# x
{-# INLINE happyOut9 #-}
happyIn10 :: (PIdent) -> (HappyAbsSyn )
happyIn10 x = unsafeCoerce# x
{-# INLINE happyIn10 #-}
happyOut10 :: (HappyAbsSyn ) -> (PIdent)
happyOut10 x = unsafeCoerce# x
{-# INLINE happyOut10 #-}
happyIn11 :: (LString) -> (HappyAbsSyn )
happyIn11 x = unsafeCoerce# x
{-# INLINE happyIn11 #-}
happyOut11 :: (HappyAbsSyn ) -> (LString)
happyOut11 x = unsafeCoerce# x
{-# INLINE happyOut11 #-}
happyIn12 :: (Grammar) -> (HappyAbsSyn )
happyIn12 x = unsafeCoerce# x
{-# INLINE happyIn12 #-}
happyOut12 :: (HappyAbsSyn ) -> (Grammar)
happyOut12 x = unsafeCoerce# x
{-# INLINE happyOut12 #-}
happyIn13 :: ([ModDef]) -> (HappyAbsSyn )
happyIn13 x = unsafeCoerce# x
{-# INLINE happyIn13 #-}
happyOut13 :: (HappyAbsSyn ) -> ([ModDef])
happyOut13 x = unsafeCoerce# x
{-# INLINE happyOut13 #-}
happyIn14 :: (ModDef) -> (HappyAbsSyn )
happyIn14 x = unsafeCoerce# x
{-# INLINE happyIn14 #-}
happyOut14 :: (HappyAbsSyn ) -> (ModDef)
happyOut14 x = unsafeCoerce# x
{-# INLINE happyOut14 #-}
happyIn15 :: (ModType) -> (HappyAbsSyn )
happyIn15 x = unsafeCoerce# x
{-# INLINE happyIn15 #-}
happyOut15 :: (HappyAbsSyn ) -> (ModType)
happyOut15 x = unsafeCoerce# x
{-# INLINE happyOut15 #-}
happyIn16 :: (ModBody) -> (HappyAbsSyn )
happyIn16 x = unsafeCoerce# x
{-# INLINE happyIn16 #-}
happyOut16 :: (HappyAbsSyn ) -> (ModBody)
happyOut16 x = unsafeCoerce# x
{-# INLINE happyOut16 #-}
happyIn17 :: ([TopDef]) -> (HappyAbsSyn )
happyIn17 x = unsafeCoerce# x
{-# INLINE happyIn17 #-}
happyOut17 :: (HappyAbsSyn ) -> ([TopDef])
happyOut17 x = unsafeCoerce# x
{-# INLINE happyOut17 #-}
happyIn18 :: (Extend) -> (HappyAbsSyn )
happyIn18 x = unsafeCoerce# x
{-# INLINE happyIn18 #-}
happyOut18 :: (HappyAbsSyn ) -> (Extend)
happyOut18 x = unsafeCoerce# x
{-# INLINE happyOut18 #-}
happyIn19 :: ([Open]) -> (HappyAbsSyn )
happyIn19 x = unsafeCoerce# x
{-# INLINE happyIn19 #-}
happyOut19 :: (HappyAbsSyn ) -> ([Open])
happyOut19 x = unsafeCoerce# x
{-# INLINE happyOut19 #-}
happyIn20 :: (Opens) -> (HappyAbsSyn )
happyIn20 x = unsafeCoerce# x
{-# INLINE happyIn20 #-}
happyOut20 :: (HappyAbsSyn ) -> (Opens)
happyOut20 x = unsafeCoerce# x
{-# INLINE happyOut20 #-}
happyIn21 :: (Open) -> (HappyAbsSyn )
happyIn21 x = unsafeCoerce# x
{-# INLINE happyIn21 #-}
happyOut21 :: (HappyAbsSyn ) -> (Open)
happyOut21 x = unsafeCoerce# x
{-# INLINE happyOut21 #-}
happyIn22 :: (ComplMod) -> (HappyAbsSyn )
happyIn22 x = unsafeCoerce# x
{-# INLINE happyIn22 #-}
happyOut22 :: (HappyAbsSyn ) -> (ComplMod)
happyOut22 x = unsafeCoerce# x
{-# INLINE happyOut22 #-}
happyIn23 :: ([Included]) -> (HappyAbsSyn )
happyIn23 x = unsafeCoerce# x
{-# INLINE happyIn23 #-}
happyOut23 :: (HappyAbsSyn ) -> ([Included])
happyOut23 x = unsafeCoerce# x
{-# INLINE happyOut23 #-}
happyIn24 :: (Included) -> (HappyAbsSyn )
happyIn24 x = unsafeCoerce# x
{-# INLINE happyIn24 #-}
happyOut24 :: (HappyAbsSyn ) -> (Included)
happyOut24 x = unsafeCoerce# x
{-# INLINE happyOut24 #-}
happyIn25 :: (TopDef) -> (HappyAbsSyn )
happyIn25 x = unsafeCoerce# x
{-# INLINE happyIn25 #-}
happyOut25 :: (HappyAbsSyn ) -> (TopDef)
happyOut25 x = unsafeCoerce# x
{-# INLINE happyOut25 #-}
happyIn26 :: (Def) -> (HappyAbsSyn )
happyIn26 x = unsafeCoerce# x
{-# INLINE happyIn26 #-}
happyOut26 :: (HappyAbsSyn ) -> (Def)
happyOut26 x = unsafeCoerce# x
{-# INLINE happyOut26 #-}
happyIn27 :: (FunDef) -> (HappyAbsSyn )
happyIn27 x = unsafeCoerce# x
{-# INLINE happyIn27 #-}
happyOut27 :: (HappyAbsSyn ) -> (FunDef)
happyOut27 x = unsafeCoerce# x
{-# INLINE happyOut27 #-}
happyIn28 :: (CatDef) -> (HappyAbsSyn )
happyIn28 x = unsafeCoerce# x
{-# INLINE happyIn28 #-}
happyOut28 :: (HappyAbsSyn ) -> (CatDef)
happyOut28 x = unsafeCoerce# x
{-# INLINE happyOut28 #-}
happyIn29 :: (DataDef) -> (HappyAbsSyn )
happyIn29 x = unsafeCoerce# x
{-# INLINE happyIn29 #-}
happyOut29 :: (HappyAbsSyn ) -> (DataDef)
happyOut29 x = unsafeCoerce# x
{-# INLINE happyOut29 #-}
happyIn30 :: (DataConstr) -> (HappyAbsSyn )
happyIn30 x = unsafeCoerce# x
{-# INLINE happyIn30 #-}
happyOut30 :: (HappyAbsSyn ) -> (DataConstr)
happyOut30 x = unsafeCoerce# x
{-# INLINE happyOut30 #-}
happyIn31 :: ([DataConstr]) -> (HappyAbsSyn )
happyIn31 x = unsafeCoerce# x
{-# INLINE happyIn31 #-}
happyOut31 :: (HappyAbsSyn ) -> ([DataConstr])
happyOut31 x = unsafeCoerce# x
{-# INLINE happyOut31 #-}
happyIn32 :: (ParDef) -> (HappyAbsSyn )
happyIn32 x = unsafeCoerce# x
{-# INLINE happyIn32 #-}
happyOut32 :: (HappyAbsSyn ) -> (ParDef)
happyOut32 x = unsafeCoerce# x
{-# INLINE happyOut32 #-}
happyIn33 :: (ParConstr) -> (HappyAbsSyn )
happyIn33 x = unsafeCoerce# x
{-# INLINE happyIn33 #-}
happyOut33 :: (HappyAbsSyn ) -> (ParConstr)
happyOut33 x = unsafeCoerce# x
{-# INLINE happyOut33 #-}
happyIn34 :: ([Def]) -> (HappyAbsSyn )
happyIn34 x = unsafeCoerce# x
{-# INLINE happyIn34 #-}
happyOut34 :: (HappyAbsSyn ) -> ([Def])
happyOut34 x = unsafeCoerce# x
{-# INLINE happyOut34 #-}
happyIn35 :: ([FunDef]) -> (HappyAbsSyn )
happyIn35 x = unsafeCoerce# x
{-# INLINE happyIn35 #-}
happyOut35 :: (HappyAbsSyn ) -> ([FunDef])
happyOut35 x = unsafeCoerce# x
{-# INLINE happyOut35 #-}
happyIn36 :: ([CatDef]) -> (HappyAbsSyn )
happyIn36 x = unsafeCoerce# x
{-# INLINE happyIn36 #-}
happyOut36 :: (HappyAbsSyn ) -> ([CatDef])
happyOut36 x = unsafeCoerce# x
{-# INLINE happyOut36 #-}
happyIn37 :: ([DataDef]) -> (HappyAbsSyn )
happyIn37 x = unsafeCoerce# x
{-# INLINE happyIn37 #-}
happyOut37 :: (HappyAbsSyn ) -> ([DataDef])
happyOut37 x = unsafeCoerce# x
{-# INLINE happyOut37 #-}
happyIn38 :: ([ParDef]) -> (HappyAbsSyn )
happyIn38 x = unsafeCoerce# x
{-# INLINE happyIn38 #-}
happyOut38 :: (HappyAbsSyn ) -> ([ParDef])
happyOut38 x = unsafeCoerce# x
{-# INLINE happyOut38 #-}
happyIn39 :: ([ParConstr]) -> (HappyAbsSyn )
happyIn39 x = unsafeCoerce# x
{-# INLINE happyIn39 #-}
happyOut39 :: (HappyAbsSyn ) -> ([ParConstr])
happyOut39 x = unsafeCoerce# x
{-# INLINE happyOut39 #-}
happyIn40 :: ([PIdent]) -> (HappyAbsSyn )
happyIn40 x = unsafeCoerce# x
{-# INLINE happyIn40 #-}
happyOut40 :: (HappyAbsSyn ) -> ([PIdent])
happyOut40 x = unsafeCoerce# x
{-# INLINE happyOut40 #-}
happyIn41 :: (Name) -> (HappyAbsSyn )
happyIn41 x = unsafeCoerce# x
{-# INLINE happyIn41 #-}
happyOut41 :: (HappyAbsSyn ) -> (Name)
happyOut41 x = unsafeCoerce# x
{-# INLINE happyOut41 #-}
happyIn42 :: ([Name]) -> (HappyAbsSyn )
happyIn42 x = unsafeCoerce# x
{-# INLINE happyIn42 #-}
happyOut42 :: (HappyAbsSyn ) -> ([Name])
happyOut42 x = unsafeCoerce# x
{-# INLINE happyOut42 #-}
happyIn43 :: (LocDef) -> (HappyAbsSyn )
happyIn43 x = unsafeCoerce# x
{-# INLINE happyIn43 #-}
happyOut43 :: (HappyAbsSyn ) -> (LocDef)
happyOut43 x = unsafeCoerce# x
{-# INLINE happyOut43 #-}
happyIn44 :: ([LocDef]) -> (HappyAbsSyn )
happyIn44 x = unsafeCoerce# x
{-# INLINE happyIn44 #-}
happyOut44 :: (HappyAbsSyn ) -> ([LocDef])
happyOut44 x = unsafeCoerce# x
{-# INLINE happyOut44 #-}
happyIn45 :: (Exp) -> (HappyAbsSyn )
happyIn45 x = unsafeCoerce# x
{-# INLINE happyIn45 #-}
happyOut45 :: (HappyAbsSyn ) -> (Exp)
happyOut45 x = unsafeCoerce# x
{-# INLINE happyOut45 #-}
happyIn46 :: (Exp) -> (HappyAbsSyn )
happyIn46 x = unsafeCoerce# x
{-# INLINE happyIn46 #-}
happyOut46 :: (HappyAbsSyn ) -> (Exp)
happyOut46 x = unsafeCoerce# x
{-# INLINE happyOut46 #-}
happyIn47 :: (Exp) -> (HappyAbsSyn )
happyIn47 x = unsafeCoerce# x
{-# INLINE happyIn47 #-}
happyOut47 :: (HappyAbsSyn ) -> (Exp)
happyOut47 x = unsafeCoerce# x
{-# INLINE happyOut47 #-}
happyIn48 :: (Exp) -> (HappyAbsSyn )
happyIn48 x = unsafeCoerce# x
{-# INLINE happyIn48 #-}
happyOut48 :: (HappyAbsSyn ) -> (Exp)
happyOut48 x = unsafeCoerce# x
{-# INLINE happyOut48 #-}
happyIn49 :: (Exp) -> (HappyAbsSyn )
happyIn49 x = unsafeCoerce# x
{-# INLINE happyIn49 #-}
happyOut49 :: (HappyAbsSyn ) -> (Exp)
happyOut49 x = unsafeCoerce# x
{-# INLINE happyOut49 #-}
happyIn50 :: (Exp) -> (HappyAbsSyn )
happyIn50 x = unsafeCoerce# x
{-# INLINE happyIn50 #-}
happyOut50 :: (HappyAbsSyn ) -> (Exp)
happyOut50 x = unsafeCoerce# x
{-# INLINE happyOut50 #-}
happyIn51 :: (Exp) -> (HappyAbsSyn )
happyIn51 x = unsafeCoerce# x
{-# INLINE happyIn51 #-}
happyOut51 :: (HappyAbsSyn ) -> (Exp)
happyOut51 x = unsafeCoerce# x
{-# INLINE happyOut51 #-}
happyIn52 :: ([Exp]) -> (HappyAbsSyn )
happyIn52 x = unsafeCoerce# x
{-# INLINE happyIn52 #-}
happyOut52 :: (HappyAbsSyn ) -> ([Exp])
happyOut52 x = unsafeCoerce# x
{-# INLINE happyOut52 #-}
happyIn53 :: (Exps) -> (HappyAbsSyn )
happyIn53 x = unsafeCoerce# x
{-# INLINE happyIn53 #-}
happyOut53 :: (HappyAbsSyn ) -> (Exps)
happyOut53 x = unsafeCoerce# x
{-# INLINE happyOut53 #-}
happyIn54 :: (Patt) -> (HappyAbsSyn )
happyIn54 x = unsafeCoerce# x
{-# INLINE happyIn54 #-}
happyOut54 :: (HappyAbsSyn ) -> (Patt)
happyOut54 x = unsafeCoerce# x
{-# INLINE happyOut54 #-}
happyIn55 :: (Patt) -> (HappyAbsSyn )
happyIn55 x = unsafeCoerce# x
{-# INLINE happyIn55 #-}
happyOut55 :: (HappyAbsSyn ) -> (Patt)
happyOut55 x = unsafeCoerce# x
{-# INLINE happyOut55 #-}
happyIn56 :: (Patt) -> (HappyAbsSyn )
happyIn56 x = unsafeCoerce# x
{-# INLINE happyIn56 #-}
happyOut56 :: (HappyAbsSyn ) -> (Patt)
happyOut56 x = unsafeCoerce# x
{-# INLINE happyOut56 #-}
happyIn57 :: (PattAss) -> (HappyAbsSyn )
happyIn57 x = unsafeCoerce# x
{-# INLINE happyIn57 #-}
happyOut57 :: (HappyAbsSyn ) -> (PattAss)
happyOut57 x = unsafeCoerce# x
{-# INLINE happyOut57 #-}
happyIn58 :: (Label) -> (HappyAbsSyn )
happyIn58 x = unsafeCoerce# x
{-# INLINE happyIn58 #-}
happyOut58 :: (HappyAbsSyn ) -> (Label)
happyOut58 x = unsafeCoerce# x
{-# INLINE happyOut58 #-}
happyIn59 :: (Sort) -> (HappyAbsSyn )
happyIn59 x = unsafeCoerce# x
{-# INLINE happyIn59 #-}
happyOut59 :: (HappyAbsSyn ) -> (Sort)
happyOut59 x = unsafeCoerce# x
{-# INLINE happyOut59 #-}
happyIn60 :: ([PattAss]) -> (HappyAbsSyn )
happyIn60 x = unsafeCoerce# x
{-# INLINE happyIn60 #-}
happyOut60 :: (HappyAbsSyn ) -> ([PattAss])
happyOut60 x = unsafeCoerce# x
{-# INLINE happyOut60 #-}
happyIn61 :: ([Patt]) -> (HappyAbsSyn )
happyIn61 x = unsafeCoerce# x
{-# INLINE happyIn61 #-}
happyOut61 :: (HappyAbsSyn ) -> ([Patt])
happyOut61 x = unsafeCoerce# x
{-# INLINE happyOut61 #-}
happyIn62 :: (Bind) -> (HappyAbsSyn )
happyIn62 x = unsafeCoerce# x
{-# INLINE happyIn62 #-}
happyOut62 :: (HappyAbsSyn ) -> (Bind)
happyOut62 x = unsafeCoerce# x
{-# INLINE happyOut62 #-}
happyIn63 :: ([Bind]) -> (HappyAbsSyn )
happyIn63 x = unsafeCoerce# x
{-# INLINE happyIn63 #-}
happyOut63 :: (HappyAbsSyn ) -> ([Bind])
happyOut63 x = unsafeCoerce# x
{-# INLINE happyOut63 #-}
happyIn64 :: (Decl) -> (HappyAbsSyn )
happyIn64 x = unsafeCoerce# x
{-# INLINE happyIn64 #-}
happyOut64 :: (HappyAbsSyn ) -> (Decl)
happyOut64 x = unsafeCoerce# x
{-# INLINE happyOut64 #-}
happyIn65 :: (TupleComp) -> (HappyAbsSyn )
happyIn65 x = unsafeCoerce# x
{-# INLINE happyIn65 #-}
happyOut65 :: (HappyAbsSyn ) -> (TupleComp)
happyOut65 x = unsafeCoerce# x
{-# INLINE happyOut65 #-}
happyIn66 :: (PattTupleComp) -> (HappyAbsSyn )
happyIn66 x = unsafeCoerce# x
{-# INLINE happyIn66 #-}
happyOut66 :: (HappyAbsSyn ) -> (PattTupleComp)
happyOut66 x = unsafeCoerce# x
{-# INLINE happyOut66 #-}
happyIn67 :: ([TupleComp]) -> (HappyAbsSyn )
happyIn67 x = unsafeCoerce# x
{-# INLINE happyIn67 #-}
happyOut67 :: (HappyAbsSyn ) -> ([TupleComp])
happyOut67 x = unsafeCoerce# x
{-# INLINE happyOut67 #-}
happyIn68 :: ([PattTupleComp]) -> (HappyAbsSyn )
happyIn68 x = unsafeCoerce# x
{-# INLINE happyIn68 #-}
happyOut68 :: (HappyAbsSyn ) -> ([PattTupleComp])
happyOut68 x = unsafeCoerce# x
{-# INLINE happyOut68 #-}
happyIn69 :: (Case) -> (HappyAbsSyn )
happyIn69 x = unsafeCoerce# x
{-# INLINE happyIn69 #-}
happyOut69 :: (HappyAbsSyn ) -> (Case)
happyOut69 x = unsafeCoerce# x
{-# INLINE happyOut69 #-}
happyIn70 :: ([Case]) -> (HappyAbsSyn )
happyIn70 x = unsafeCoerce# x
{-# INLINE happyIn70 #-}
happyOut70 :: (HappyAbsSyn ) -> ([Case])
happyOut70 x = unsafeCoerce# x
{-# INLINE happyOut70 #-}
happyIn71 :: (Equation) -> (HappyAbsSyn )
happyIn71 x = unsafeCoerce# x
{-# INLINE happyIn71 #-}
happyOut71 :: (HappyAbsSyn ) -> (Equation)
happyOut71 x = unsafeCoerce# x
{-# INLINE happyOut71 #-}
happyIn72 :: ([Equation]) -> (HappyAbsSyn )
happyIn72 x = unsafeCoerce# x
{-# INLINE happyIn72 #-}
happyOut72 :: (HappyAbsSyn ) -> ([Equation])
happyOut72 x = unsafeCoerce# x
{-# INLINE happyOut72 #-}
happyIn73 :: (Altern) -> (HappyAbsSyn )
happyIn73 x = unsafeCoerce# x
{-# INLINE happyIn73 #-}
happyOut73 :: (HappyAbsSyn ) -> (Altern)
happyOut73 x = unsafeCoerce# x
{-# INLINE happyOut73 #-}
happyIn74 :: ([Altern]) -> (HappyAbsSyn )
happyIn74 x = unsafeCoerce# x
{-# INLINE happyIn74 #-}
happyOut74 :: (HappyAbsSyn ) -> ([Altern])
happyOut74 x = unsafeCoerce# x
{-# INLINE happyOut74 #-}
happyIn75 :: (DDecl) -> (HappyAbsSyn )
happyIn75 x = unsafeCoerce# x
{-# INLINE happyIn75 #-}
happyOut75 :: (HappyAbsSyn ) -> (DDecl)
happyOut75 x = unsafeCoerce# x
{-# INLINE happyOut75 #-}
happyIn76 :: ([DDecl]) -> (HappyAbsSyn )
happyIn76 x = unsafeCoerce# x
{-# INLINE happyIn76 #-}
happyOut76 :: (HappyAbsSyn ) -> ([DDecl])
happyOut76 x = unsafeCoerce# x
{-# INLINE happyOut76 #-}
happyIn77 :: (OldGrammar) -> (HappyAbsSyn )
happyIn77 x = unsafeCoerce# x
{-# INLINE happyIn77 #-}
happyOut77 :: (HappyAbsSyn ) -> (OldGrammar)
happyOut77 x = unsafeCoerce# x
{-# INLINE happyOut77 #-}
happyIn78 :: (Include) -> (HappyAbsSyn )
happyIn78 x = unsafeCoerce# x
{-# INLINE happyIn78 #-}
happyOut78 :: (HappyAbsSyn ) -> (Include)
happyOut78 x = unsafeCoerce# x
{-# INLINE happyOut78 #-}
happyIn79 :: (FileName) -> (HappyAbsSyn )
happyIn79 x = unsafeCoerce# x
{-# INLINE happyIn79 #-}
happyOut79 :: (HappyAbsSyn ) -> (FileName)
happyOut79 x = unsafeCoerce# x
{-# INLINE happyOut79 #-}
happyIn80 :: ([FileName]) -> (HappyAbsSyn )
happyIn80 x = unsafeCoerce# x
{-# INLINE happyIn80 #-}
happyOut80 :: (HappyAbsSyn ) -> ([FileName])
happyOut80 x = unsafeCoerce# x
{-# INLINE happyOut80 #-}
happyInTok :: Token -> (HappyAbsSyn )
happyInTok x = unsafeCoerce# x
{-# INLINE happyInTok #-}
happyOutTok :: (HappyAbsSyn ) -> Token
happyOutTok x = unsafeCoerce# x
{-# INLINE happyOutTok #-}

happyActOffsets :: HappyAddr
happyActOffsets = HappyA# "\x00\x00\x34\x04\x2a\x04\xe9\x00\x0d\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x45\x04\x90\x01\x6f\x00\x37\x04\xfa\x03\x35\x04\x00\x00\x31\x04\xe7\x03\xfe\xff\x1c\x00\xe7\x03\x00\x00\xe9\x00\x29\x00\xe7\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe9\x00\x00\x00\x30\x04\x63\x02\x06\x00\x00\x03\x2f\x04\x2e\x04\x58\x02\x2d\x04\x00\x00\x00\x00\x00\x00\x00\x00\xdc\x03\x00\x00\xf9\xff\x01\x00\x6e\x08\x00\x00\xdc\x03\x4e\x00\x2c\x04\x1c\x04\xc6\x03\xc6\x03\xc6\x03\xc6\x03\xc6\x03\xc6\x03\x00\x00\x00\x00\xf9\xff\x13\x04\x00\x00\xf9\xff\xf9\xff\xf9\xff\xf6\x07\xe9\x00\x17\x01\xeb\x02\x9b\x00\xc4\x03\x4d\x00\x4d\x00\x00\x00\x00\x00\x00\x00\x03\x04\x00\x00\xc3\x03\xeb\x02\xc1\x03\x00\x00\xeb\x02\xc0\x03\x00\x00\x0a\x02\x06\x04\x39\x00\x0a\x04\xdb\x03\xb1\x03\x1b\x00\x16\x03\xd4\x03\x00\x00\x00\x00\xf3\x03\xdf\x03\x77\x00\x00\x00\xee\x03\xf0\x03\xe2\x03\x43\x02\xeb\x03\xff\x01\x00\x00\xd6\x00\xea\x03\xe5\x03\xf4\x01\x8d\x02\xe8\x03\x4d\x00\x37\x01\x4d\x00\x37\x01\x37\x01\x37\x01\x4d\x00\xe1\x03\xd6\x03\xef\xff\x00\x00\x00\x00\x96\x03\x8d\x03\x00\x00\xf4\x01\xf4\x01\xf4\x01\x00\x00\xf4\x01\x7b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x8d\x03\x8d\x03\xd3\x03\x4d\x00\x00\x00\xa6\x01\xd0\x03\x89\x03\x00\x00\x89\x03\x00\x00\x00\x00\x4d\x00\x4d\x00\xbe\x03\x4d\x00\x77\x00\xd2\x03\x16\x03\xbc\x03\xd1\x03\xcc\x03\x00\x00\xc7\x03\x4d\x00\x84\x03\x4d\x00\x4d\x00\xbd\x03\xa7\x03\xb1\x02\xa3\x03\x00\x00\xf9\x00\xad\x03\x99\x03\x16\x03\xa8\x03\x7a\x02\xe8\x01\xae\x03\xa9\x03\xa0\x03\x54\x03\xa1\x03\x9e\x03\x93\x03\x83\x03\x87\x02\x5f\x01\x8a\x03\x86\x03\xeb\x02\x4d\x00\x81\x03\x00\x00\x2b\x00\x28\x00\x28\x00\x28\x00\x28\x00\x28\x00\x28\x00\x28\x00\x28\x00\x28\x00\x34\x03\x34\x03\x28\x00\x02\x00\x34\x03\x28\x00\x00\x00\x00\x00\x00\x00\xf9\xff\x00\x00\x00\x00\x00\x00\x4b\x03\x00\x00\x49\x03\x00\x00\x18\x00\x2f\x02\x00\x00\x46\x03\x78\x03\x30\x00\x32\x03\x32\x03\x32\x03\x32\x03\x00\x00\x00\x00\x76\x03\x00\x00\xd6\x02\x33\x00\x25\x03\x72\x03\x00\x00\x28\x00\x28\x00\x00\x00\x6e\x03\x6a\x03\x00\x00\x57\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x56\x03\x00\x00\x64\x03\x4a\x03\x00\x00\x00\x00\x53\x03\x00\x00\x00\x00\x87\x00\x00\x00\x4f\x03\x00\x00\xfc\x02\x00\x00\x40\x03\x44\x03\x00\x00\xc7\x02\xc7\x02\xc7\x02\x4d\x00\x00\x00\xf6\x02\x16\x03\x00\x00\x4d\x00\x4d\x00\x00\x00\x00\x00\xf6\x02\xc7\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc7\x02\x00\x00\xf6\x02\x42\x03\x00\x00\x00\x00\x00\x00\x14\x03\x00\x00\x16\x03\x4d\x00\x00\x00\xc7\x02\x00\x00\x00\x00\x4d\x00\x24\x03\x00\x00\x00\x00\x00\x00\xb4\x01\x00\x00\x00\x00\x38\x03\x00\x00\x30\x03\x00\x00\x2e\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x26\x03\x00\x00\x00\x00\x4d\x00\x4d\x00\x00\x00\x00\x00\xf9\x00\x00\x00\x0b\x03\x20\x03\x1a\x03\x00\x00\x00\x00\x16\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x23\x00\x9b\x01\xe4\x02\xfa\xff\xfa\xff\x4d\x00\xfa\xff\x19\x03\xd9\x02\xd9\x02\x00\x00\x00\x00\x00\x00\x0e\x03\x4d\x00\x4d\x00\x10\x03\xfa\xff\x00\x00\x00\x00\x00\x00\x11\x03\x00\x00\xbc\x02\x0a\x00\xbc\x02\x07\x03\x0a\x00\xb9\x02\xfb\x02\xb3\x02\xf7\x02\x00\x00\xcb\x02\xf3\x02\xa9\x02\x00\x00\xaa\x02\xee\x02\x00\x00\x00\x00\x4d\x00\xe3\x02\x00\x00\x00\x00\x00\x00\xda\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe1\x02\x00\x00\xd7\x02\xd2\x02\x00\x00\x00\x00\x00\x00\xfe\xff\x00\x00\x42\x01\x00\x00\x00\x00\x4d\x00\x4d\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xdb\x02\xcf\x02\x82\x02\x82\x02\x91\x03\x82\x02\x9b\x01\x4d\x00\x00\x00\xa0\x02\x0a\x00\x71\x03\xcd\x02\x0a\x00\x00\x00\x00\x00\xbe\x02\x00\x00\x00\x00\x6e\x02\x00\x00\xc4\x02\xb8\x02\x00\x00\x00\x00\xb5\x02\x00\x00\x00\x00\x4d\x00\x69\x02\xa7\x02\xa2\x02\x00\x00\x00\x00\x6f\x02\x97\x02\x00\x00\x9a\x02\x51\x03\x00\x00\x00\x00\x00\x00\x00\x00\x31\x03\x00\x00\x00\x00"#

happyGotoOffsets :: HappyAddr
happyGotoOffsets = HappyA# "\x78\x00\x22\x02\x8b\x01\x9e\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7c\x03\x54\x04\x3c\x01\x96\x02\x00\x00\x17\x04\xca\x00\x93\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x80\x07\x00\x00\x00\x00\xf2\x07\x6f\x03\x3c\x02\x00\x00\x00\x00\xd3\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x88\x02\x19\x00\x00\x00\x81\x02\x00\x00\x00\x00\x24\x00\x00\x00\x00\x00\x6d\x02\x6b\x02\x6a\x02\x5f\x02\x5d\x02\x5b\x02\x00\x00\x00\x00\x2d\x00\x00\x00\x00\x00\x22\x00\x13\x00\x07\x00\x4b\x02\xc8\x04\x00\x00\x4d\x01\x64\x07\x59\x02\xac\x04\x46\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfd\x01\x46\x02\x50\x02\x00\x00\x0c\x03\x47\x02\x00\x00\xe7\x07\x00\x00\x00\x00\x00\x00\x00\x00\x3c\x03\x44\x02\xf3\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x60\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xd8\x07\x00\x00\x00\x00\x00\x00\x00\x00\x44\x04\x00\x00\x00\x00\x2a\x07\xc3\x02\x0c\x07\xbc\x07\xad\x07\x2b\x03\xf0\x06\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x1c\x02\x1d\x03\x00\x00\x28\x04\x28\x04\x28\x04\x00\x00\x28\x04\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xce\x00\x08\x02\x00\x00\xd2\x06\x00\x00\xcb\x07\x00\x00\x9b\x02\x00\x00\x07\x02\x00\x00\x00\x00\xfb\x03\xb6\x06\x00\x00\x98\x06\x5d\x00\x00\x00\xcb\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7c\x06\x00\x01\x5e\x06\x42\x06\x00\x00\x00\x00\x67\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe3\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf9\x01\x00\x00\x00\x00\x00\x00\x00\x00\x67\x01\x00\x00\x00\x00\x00\x00\xc0\x01\x8e\x04\x00\x00\x00\x00\x91\x01\xf4\x07\x77\x08\x75\x08\x69\x08\x64\x08\x5e\x08\x53\x08\x50\x08\x47\x08\xea\x01\x69\x01\x42\x08\x3d\x08\xdf\x01\x39\x08\x00\x00\x00\x00\x00\x00\x0f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0e\x01\x00\x00\x00\x00\xd4\x01\x00\x00\x00\x00\xd5\x01\x8a\x01\xc2\x01\xa0\x01\x00\x00\x00\x00\x00\x00\x00\x00\x41\x01\x00\x00\x95\x01\x00\x00\x00\x00\x2c\x08\xa0\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x50\x01\x00\x00\x00\x00\x87\x01\x00\x00\x00\x00\x00\x00\x00\x00\xd5\x00\xed\x03\x7d\x02\x24\x06\x00\x00\x7c\x01\x37\x00\x00\x00\x72\x04\xdd\x03\x00\x00\x00\x00\xd7\x01\x24\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x34\x02\x00\x00\x5e\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa5\x00\x08\x06\x00\x00\x84\x00\x00\x00\x00\x00\xea\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xce\x05\xb0\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfb\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x01\x6c\x01\xad\x00\x47\x01\xa6\x00\x0d\x01\x94\x05\x26\x08\x00\x00\xb3\x00\x59\x01\x00\x00\x00\x00\x00\x00\x00\x00\x76\x05\x5a\x05\x00\x00\xa2\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x2b\x01\xab\x02\x90\x00\x00\x00\x2d\x02\xcd\x00\x00\x00\xc2\x00\x00\x00\x00\x00\x00\x00\x00\x00\x51\x01\x26\x01\x00\x00\x00\x00\x00\x00\x00\x00\x3c\x05\x00\x00\x00\x00\x00\x00\xe1\x00\x00\x00\x00\x00\x00\x00\x11\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x38\x04\x00\x00\xad\x00\x00\x00\x00\x00\xbf\x03\x20\x05\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xa0\x00\xf4\x00\xdb\x00\xfc\x00\xad\x00\x02\x05\x00\x00\xd3\x00\xcd\x01\xbc\x00\x00\x00\x99\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xda\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xe6\x04\xcb\x00\x00\x00\x00\x00\x00\x00\xb6\x00\x7d\x00\x00\x00\x00\x00\x00\x00\x8d\x00\x00\x00\x00\x00\x00\x00\x0e\x00\x53\x00\x00\x00\x00\x00"#

happyDefActions :: HappyAddr
happyDefActions = HappyA# "\xf5\xff\xd8\xff\x17\xff\x00\x00\x00\x00\xfb\xff\x8e\xff\x8f\xff\x8d\xff\x93\xff\x82\xff\x7e\xff\x73\xff\x6e\xff\x60\xff\x61\xff\x00\x00\x6c\xff\x90\xff\x00\x00\x96\xff\x34\xff\x00\x00\x00\x00\x8c\xff\x2d\xff\x34\xff\x00\x00\x3f\xff\x3d\xff\x3c\xff\x3e\xff\x40\xff\x00\x00\x8a\xff\x00\x00\x00\x00\x96\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xfa\xff\xf9\xff\xf8\xff\xf7\xff\x00\x00\xe3\xff\x00\x00\x00\x00\x00\x00\xd7\xff\x00\x00\xd8\xff\xf4\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xf3\xff\x15\xff\x14\xff\x00\x00\x16\xff\x00\x00\x00\x00\x00\x00\x18\xff\x5f\xff\x00\x00\x96\xff\x00\x00\x00\x00\x5f\xff\x00\x00\x52\xff\x50\xff\x51\xff\x55\xff\x75\xff\x3b\xff\x00\x00\x00\x00\x5a\xff\x2a\xff\x00\x00\x56\xff\x00\x00\x9f\xff\x00\x00\x95\xff\x00\x00\x96\xff\x00\x00\x23\xff\x00\x00\x72\xff\x36\xff\x33\xff\x00\x00\x34\xff\x35\xff\x2f\xff\x2c\xff\x00\x00\x00\x00\x00\x00\x5c\xff\x8b\xff\x93\xff\x00\x00\x00\x00\x00\x00\x9f\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x7d\xff\x00\x00\x42\xff\x81\xff\x00\x00\x96\xff\x67\xff\x70\xff\x71\xff\x6f\xff\x6b\xff\x6e\xff\x60\xff\x6d\xff\x68\xff\x87\xff\x92\xff\x00\x00\x00\x00\x93\xff\x00\x00\x83\xff\x5c\xff\x00\x00\x96\xff\x88\xff\x00\x00\x91\xff\x86\xff\x2d\xff\x00\x00\x00\x00\x00\x00\x34\xff\x00\x00\x38\xff\x00\x00\x22\xff\x00\x00\x62\xff\x00\x00\x00\x00\x96\xff\x00\x00\x00\x00\x74\xff\x58\xff\x55\xff\x47\xff\x44\xff\x2e\xff\x29\xff\x00\x00\x00\x00\x00\x00\x00\x00\x9f\xff\x00\x00\x3a\xff\x00\x00\x00\x00\x00\x00\x5e\xff\x00\x00\x00\x00\x9f\xff\x00\x00\x26\xff\x00\x00\x00\x00\x5f\xff\x00\x00\xe2\xff\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\xff\x12\xff\x11\xff\x0f\xff\x10\xff\xf0\xff\xee\xff\x00\x00\xef\xff\x00\x00\xf1\xff\xd6\xff\xd3\xff\xf2\xff\xdc\xff\xea\xff\xd5\xff\x00\x00\xd6\xff\x00\x00\x00\x00\x0e\xff\x9d\xff\x00\x00\xbf\xff\x9b\xff\x00\x00\x00\x00\x00\x00\xc3\xff\x00\x00\x00\x00\xc1\xff\xae\xff\x00\x00\xcb\xff\x00\x00\xca\xff\xc2\xff\xc8\xff\xc9\xff\xc7\xff\x00\x00\xcf\xff\x9b\xff\x00\x00\xc4\xff\xcd\xff\x00\x00\xce\xff\xcc\xff\x9b\xff\x1a\xff\x00\x00\xd0\xff\x00\x00\x78\xff\x00\x00\x00\x00\x7c\xff\x00\x00\x00\x00\x00\x00\x00\x00\x4c\xff\x00\x00\x00\x00\x76\xff\x5f\xff\x1f\xff\x53\xff\x4f\xff\x3b\xff\x00\x00\x54\xff\x4d\xff\x59\xff\x48\xff\x4e\xff\x2a\xff\x4a\xff\x00\x00\x99\xff\x98\xff\x94\xff\x65\xff\x00\x00\x63\xff\x23\xff\x00\x00\x37\xff\x00\x00\x32\xff\x6a\xff\x00\x00\x00\x00\x2f\xff\x2b\xff\x7f\xff\x9f\xff\x89\xff\x5b\xff\x00\x00\x85\xff\x00\x00\x9e\xff\x00\x00\x41\xff\x64\xff\x80\xff\x31\xff\x84\xff\x69\xff\x00\x00\x24\xff\x21\xff\x00\x00\x00\x00\x57\xff\x28\xff\x43\xff\x39\xff\x00\x00\x1e\xff\x00\x00\x5d\xff\x49\xff\x53\xff\x27\xff\x45\xff\x46\xff\x25\xff\x7b\xff\x7a\xff\x1a\xff\xa8\xff\xb8\xff\xb2\xff\x00\x00\xa6\xff\x00\x00\xaa\xff\x00\x00\xa4\xff\xa2\xff\xc5\xff\xc6\xff\xbe\xff\x00\x00\x00\x00\x00\x00\x00\x00\xac\xff\xec\xff\xed\xff\xe4\xff\xd5\xff\xe5\xff\xd6\xff\xdf\xff\xe1\xff\x00\x00\xdf\xff\x00\x00\x00\x00\x00\x00\x00\x00\xda\xff\x00\x00\xde\xff\x00\x00\xe3\xff\x00\x00\xe9\xff\xd4\xff\xab\xff\x00\x00\xbd\xff\xbc\xff\x9c\xff\x1a\xff\xa1\xff\xaf\xff\xa3\xff\xe3\xff\xa9\xff\xb9\xff\xa5\xff\x00\x00\x9a\xff\xb4\xff\xb1\xff\xb5\xff\x1b\xff\x19\xff\x34\xff\xa7\xff\x00\x00\x4b\xff\x77\xff\x1f\xff\x00\x00\x97\xff\x66\xff\x79\xff\x20\xff\x1d\xff\xb7\xff\x00\x00\xb2\xff\x00\x00\x00\x00\xa2\xff\xad\xff\x00\x00\xbb\xff\xdc\xff\xdf\xff\x00\x00\x00\x00\xdf\xff\xdb\xff\xd2\xff\x00\x00\xd1\xff\xdd\xff\x00\x00\xeb\xff\xe7\xff\x00\x00\xba\xff\xa0\xff\x00\x00\xb3\xff\xb0\xff\x00\x00\x00\x00\x00\x00\x00\x00\xc0\xff\xe3\xff\xdc\xff\x00\x00\xd9\xff\x00\x00\x00\x00\x1c\xff\xb6\xff\xe8\xff\xe3\xff\x00\x00\xe6\xff"#

happyCheck :: HappyAddr
happyCheck = HappyA# "\xff\xff\x03\x00\x01\x00\x09\x00\x0b\x00\x07\x00\x0d\x00\x09\x00\x01\x00\x03\x00\x03\x00\x09\x00\x1d\x00\x0f\x00\x10\x00\x11\x00\x01\x00\x07\x00\x03\x00\x03\x00\x01\x00\x17\x00\x03\x00\x1e\x00\x0a\x00\x1b\x00\x01\x00\x03\x00\x03\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x01\x00\x26\x00\x03\x00\x0a\x00\x29\x00\x0d\x00\x27\x00\x2c\x00\x07\x00\x09\x00\x2f\x00\x01\x00\x2d\x00\x03\x00\x09\x00\x34\x00\x0f\x00\x09\x00\x02\x00\x06\x00\x00\x00\x01\x00\x02\x00\x03\x00\x02\x00\x3e\x00\x3f\x00\x4f\x00\x0c\x00\x17\x00\x43\x00\x44\x00\x33\x00\x1b\x00\x0c\x00\x4d\x00\x49\x00\x4f\x00\x4f\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x48\x00\x03\x00\x4f\x00\x3a\x00\x52\x00\x07\x00\x4f\x00\x09\x00\x48\x00\x49\x00\x4f\x00\x42\x00\x48\x00\x0f\x00\x10\x00\x11\x00\x47\x00\x03\x00\x48\x00\x49\x00\x03\x00\x17\x00\x12\x00\x2f\x00\x4f\x00\x4d\x00\x4d\x00\x48\x00\x4f\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x4f\x00\x26\x00\x05\x00\x48\x00\x29\x00\x4f\x00\x4f\x00\x2c\x00\x4f\x00\x4b\x00\x2f\x00\x05\x00\x06\x00\x31\x00\x05\x00\x34\x00\x13\x00\x14\x00\x00\x00\x01\x00\x02\x00\x03\x00\x19\x00\x02\x00\x0d\x00\x3e\x00\x3f\x00\x06\x00\x13\x00\x14\x00\x43\x00\x44\x00\x1b\x00\x03\x00\x37\x00\x38\x00\x49\x00\x37\x00\x38\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x03\x00\x12\x00\x52\x00\x11\x00\x07\x00\x03\x00\x09\x00\x00\x00\x01\x00\x02\x00\x03\x00\x03\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x17\x00\x2f\x00\x30\x00\x31\x00\x03\x00\x17\x00\x18\x00\x4a\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x0a\x00\x26\x00\x3e\x00\x3f\x00\x29\x00\x03\x00\x4f\x00\x2c\x00\x22\x00\x23\x00\x2f\x00\x00\x00\x19\x00\x03\x00\x12\x00\x34\x00\x03\x00\x03\x00\x1f\x00\x26\x00\x2f\x00\x00\x00\x01\x00\x02\x00\x03\x00\x3e\x00\x3f\x00\x36\x00\x06\x00\x03\x00\x43\x00\x44\x00\x0d\x00\x34\x00\x0c\x00\x21\x00\x49\x00\x40\x00\x41\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x03\x00\x12\x00\x21\x00\x21\x00\x07\x00\x44\x00\x09\x00\x00\x00\x01\x00\x02\x00\x03\x00\x03\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x03\x00\x03\x00\x17\x00\x37\x00\x38\x00\x03\x00\x2f\x00\x30\x00\x31\x00\x0e\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x15\x00\x26\x00\x03\x00\x03\x00\x29\x00\x3e\x00\x3f\x00\x2c\x00\x1a\x00\x09\x00\x2f\x00\x0b\x00\x03\x00\x0a\x00\x20\x00\x34\x00\x10\x00\x11\x00\x09\x00\x21\x00\x2f\x00\x16\x00\x24\x00\x25\x00\x45\x00\x3e\x00\x3f\x00\x36\x00\x2f\x00\x1e\x00\x43\x00\x44\x00\x03\x00\x22\x00\x0a\x00\x36\x00\x49\x00\x40\x00\x41\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x03\x00\x10\x00\x11\x00\x01\x00\x07\x00\x03\x00\x09\x00\x00\x00\x01\x00\x02\x00\x03\x00\x03\x00\x0f\x00\x10\x00\x11\x00\x07\x00\x03\x00\x09\x00\x0a\x00\x00\x00\x01\x00\x02\x00\x03\x00\x0f\x00\x10\x00\x11\x00\x03\x00\x45\x00\x1f\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x03\x00\x26\x00\x17\x00\x18\x00\x29\x00\x03\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x00\x00\x01\x00\x02\x00\x03\x00\x29\x00\x03\x00\x0e\x00\x21\x00\x03\x00\x2f\x00\x24\x00\x25\x00\x1a\x00\x15\x00\x3e\x00\x3f\x00\x36\x00\x19\x00\x20\x00\x43\x00\x44\x00\x2f\x00\x30\x00\x31\x00\x03\x00\x49\x00\x15\x00\x19\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x1f\x00\x1d\x00\x03\x00\x3e\x00\x3f\x00\x03\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x03\x00\x03\x00\x45\x00\x2f\x00\x07\x00\x03\x00\x09\x00\x10\x00\x11\x00\x03\x00\x36\x00\x03\x00\x0f\x00\x10\x00\x11\x00\x07\x00\x03\x00\x09\x00\x0c\x00\x15\x00\x0e\x00\x18\x00\x03\x00\x0f\x00\x10\x00\x11\x00\x07\x00\x1d\x00\x09\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x0f\x00\x10\x00\x11\x00\x04\x00\x29\x00\x06\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x00\x00\x01\x00\x02\x00\x03\x00\x29\x00\x03\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x00\x00\x01\x00\x02\x00\x03\x00\x29\x00\x03\x00\x46\x00\x47\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x03\x00\x0c\x00\x03\x00\x0e\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x0d\x00\x03\x00\x00\x00\x01\x00\x02\x00\x03\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x04\x00\x03\x00\x06\x00\x2f\x00\x30\x00\x31\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x03\x00\x21\x00\x26\x00\x2f\x00\x07\x00\x03\x00\x09\x00\x3e\x00\x3f\x00\x03\x00\x36\x00\x03\x00\x0f\x00\x10\x00\x11\x00\x07\x00\x34\x00\x09\x00\x32\x00\x03\x00\x03\x00\x35\x00\x03\x00\x0f\x00\x10\x00\x11\x00\x07\x00\x2f\x00\x09\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x0f\x00\x10\x00\x11\x00\x00\x00\x29\x00\x21\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x00\x00\x01\x00\x02\x00\x03\x00\x29\x00\x07\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x32\x00\x03\x00\x0f\x00\x35\x00\x29\x00\x00\x00\x01\x00\x02\x00\x03\x00\x09\x00\x0c\x00\x0b\x00\x0e\x00\x00\x00\x01\x00\x02\x00\x03\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x01\x00\x00\x00\x01\x00\x02\x00\x03\x00\x03\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x0d\x00\x01\x00\x0f\x00\x2f\x00\x30\x00\x31\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x03\x00\x03\x00\x12\x00\x03\x00\x07\x00\x03\x00\x09\x00\x03\x00\x2f\x00\x30\x00\x31\x00\x03\x00\x0f\x00\x10\x00\x11\x00\x07\x00\x2f\x00\x09\x00\x03\x00\x03\x00\x3b\x00\x03\x00\x3d\x00\x0f\x00\x10\x00\x11\x00\x2f\x00\x30\x00\x31\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x00\x00\x01\x00\x02\x00\x03\x00\x29\x00\x08\x00\x20\x00\x21\x00\x22\x00\x23\x00\x24\x00\x0e\x00\x08\x00\x03\x00\x04\x00\x29\x00\x06\x00\x07\x00\x15\x00\x09\x00\x04\x00\x0a\x00\x06\x00\x0d\x00\x0e\x00\x03\x00\x10\x00\x11\x00\x03\x00\x0d\x00\x14\x00\x15\x00\x03\x00\x03\x00\x08\x00\x19\x00\x1a\x00\x1b\x00\x1c\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x3a\x00\x08\x00\x04\x00\x2f\x00\x30\x00\x03\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x50\x00\x03\x00\x4c\x00\x01\x00\x0c\x00\x07\x00\x0e\x00\x09\x00\x03\x00\x21\x00\x4f\x00\x0d\x00\x24\x00\x25\x00\x10\x00\x11\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x0a\x00\x05\x00\x03\x00\x1a\x00\x1b\x00\x1c\x00\x07\x00\x02\x00\x09\x00\x4f\x00\x0b\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x10\x00\x11\x00\x03\x00\x3a\x00\x0c\x00\x06\x00\x07\x00\x03\x00\x09\x00\x0e\x00\x1a\x00\x1b\x00\x02\x00\x0d\x00\x02\x00\x10\x00\x11\x00\x0e\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x03\x00\x2c\x00\x1a\x00\x1b\x00\x07\x00\x05\x00\x09\x00\x4b\x00\x0b\x00\x34\x00\x4f\x00\x06\x00\x2f\x00\x10\x00\x11\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x0a\x00\x4f\x00\x03\x00\x09\x00\x1a\x00\x1b\x00\x07\x00\x4f\x00\x09\x00\x03\x00\x4f\x00\x00\x00\x01\x00\x02\x00\x03\x00\x10\x00\x11\x00\x02\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x06\x00\x0a\x00\x03\x00\x1a\x00\x1b\x00\x03\x00\x07\x00\x04\x00\x09\x00\x03\x00\x01\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x10\x00\x11\x00\x4f\x00\x1e\x00\x04\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x1a\x00\x1b\x00\x04\x00\x4f\x00\x04\x00\x04\x00\x12\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x2f\x00\x30\x00\x31\x00\x21\x00\x03\x00\x08\x00\x24\x00\x25\x00\x2f\x00\x02\x00\x4f\x00\x46\x00\x3b\x00\x04\x00\x3d\x00\x0a\x00\x4f\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x01\x00\x26\x00\x27\x00\x28\x00\x01\x00\x04\x00\x0c\x00\x01\x00\x27\x00\x02\x00\x29\x00\x2a\x00\x2b\x00\x21\x00\x2d\x00\x34\x00\x24\x00\x25\x00\x4c\x00\x4d\x00\x4e\x00\x4f\x00\x35\x00\x36\x00\x37\x00\x38\x00\x06\x00\x01\x00\x3b\x00\x3c\x00\x3d\x00\x3e\x00\x02\x00\x40\x00\x03\x00\x01\x00\x4f\x00\x04\x00\x45\x00\x01\x00\x27\x00\x48\x00\x29\x00\x2a\x00\x2b\x00\x05\x00\x2d\x00\x03\x00\x3a\x00\x4f\x00\x39\x00\x4f\x00\x39\x00\x04\x00\x35\x00\x36\x00\x37\x00\x38\x00\x04\x00\x01\x00\x3b\x00\x3c\x00\x3d\x00\x3e\x00\x21\x00\x40\x00\x0f\x00\x24\x00\x25\x00\x04\x00\x45\x00\x04\x00\x27\x00\x48\x00\x29\x00\x2a\x00\x2b\x00\x21\x00\x2d\x00\x01\x00\x24\x00\x25\x00\x01\x00\x4f\x00\x04\x00\x03\x00\x35\x00\x36\x00\x37\x00\x38\x00\x01\x00\x12\x00\x3b\x00\x3c\x00\x3d\x00\x3e\x00\x02\x00\x40\x00\x0a\x00\x06\x00\x0d\x00\x13\x00\x45\x00\x14\x00\x27\x00\x48\x00\x29\x00\x2a\x00\x2b\x00\x1b\x00\x2d\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x22\x00\x23\x00\x35\x00\x36\x00\x37\x00\x38\x00\x0d\x00\x04\x00\x3b\x00\x3c\x00\x3d\x00\x3e\x00\x04\x00\x40\x00\x01\x00\x4f\x00\x18\x00\x03\x00\x45\x00\x19\x00\x4f\x00\x48\x00\x0a\x00\x08\x00\x4f\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x4c\x00\x0d\x00\x03\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x04\x00\x00\x00\x01\x00\x02\x00\x03\x00\x0c\x00\x08\x00\x34\x00\x12\x00\x0a\x00\x06\x00\x18\x00\x39\x00\x06\x00\x0c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x4f\x00\x42\x00\x43\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2f\x00\x01\x00\x06\x00\x39\x00\x4d\x00\x4f\x00\x0d\x00\x34\x00\x4f\x00\x4f\x00\x01\x00\x4f\x00\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x2f\x00\x30\x00\x02\x00\x42\x00\x43\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x01\x00\x52\x00\x34\x00\x03\x00\x03\x00\x03\x00\x03\x00\x39\x00\x3a\x00\x4f\x00\x3c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x18\x00\x15\x00\x34\x00\x52\x00\x16\x00\x26\x00\x27\x00\x39\x00\x3a\x00\x0d\x00\x3c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x4c\x00\x30\x00\xff\xff\x34\x00\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x31\x00\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x34\x00\xff\xff\xff\xff\x37\x00\x38\x00\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\x34\x00\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\x37\x00\x38\x00\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x2d\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x03\x00\xff\xff\xff\xff\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\x13\x00\x34\x00\xff\xff\xff\xff\xff\xff\xff\xff\x39\x00\xff\xff\x1b\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\x22\x00\x23\x00\x26\x00\x27\x00\x28\x00\x29\x00\x2a\x00\x2b\x00\x2c\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\x34\x00\x26\x00\x27\x00\x28\x00\xff\xff\x39\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\x26\x00\x27\x00\x28\x00\xff\xff\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\xff\xff\xff\xff\xff\xff\xff\xff\x34\x00\x26\x00\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x03\x00\xff\xff\x2e\x00\xff\xff\xff\xff\xff\xff\xff\xff\x26\x00\x34\x00\xff\xff\x00\x00\x01\x00\x02\x00\x03\x00\x04\x00\x2e\x00\xff\xff\x14\x00\xff\xff\x16\x00\xff\xff\x34\x00\x26\x00\x27\x00\xff\xff\x1c\x00\xff\xff\x1e\x00\xff\xff\xff\xff\xff\xff\x22\x00\x23\x00\x26\x00\x27\x00\xff\xff\x34\x00\xff\xff\x27\x00\xff\xff\x29\x00\x2a\x00\x2b\x00\xff\xff\x2d\x00\xff\xff\xff\xff\x34\x00\x26\x00\x27\x00\x03\x00\xff\xff\x35\x00\x36\x00\x37\x00\x38\x00\x03\x00\xff\xff\x3b\x00\x3c\x00\x3d\x00\x3e\x00\x34\x00\x40\x00\xff\xff\xff\xff\xff\xff\x14\x00\x45\x00\x03\x00\xff\xff\x48\x00\x13\x00\x03\x00\xff\xff\x1c\x00\xff\xff\xff\xff\x03\x00\xff\xff\x1b\x00\x22\x00\x23\x00\x03\x00\xff\xff\x13\x00\xff\xff\x22\x00\x23\x00\x13\x00\xff\xff\xff\xff\x03\x00\x1b\x00\x13\x00\x03\x00\xff\xff\x1b\x00\xff\xff\x13\x00\x22\x00\x23\x00\x1b\x00\xff\xff\x22\x00\x23\x00\x03\x00\x1b\x00\x13\x00\x22\x00\x23\x00\x13\x00\x03\x00\xff\xff\x22\x00\x23\x00\x1b\x00\x03\x00\xff\xff\x1b\x00\xff\xff\xff\xff\x13\x00\x22\x00\x23\x00\xff\xff\x22\x00\x23\x00\x13\x00\x03\x00\x1b\x00\x03\x00\xff\xff\xff\xff\x14\x00\xff\xff\x1b\x00\x22\x00\x23\x00\xff\xff\xff\xff\xff\xff\x1c\x00\x22\x00\x23\x00\x13\x00\xff\xff\x13\x00\x22\x00\x23\x00\xff\xff\xff\xff\xff\xff\x1b\x00\xff\xff\x1b\x00\x25\x00\xff\xff\xff\xff\x28\x00\x22\x00\x23\x00\x22\x00\x23\x00\xff\xff\x2e\x00\xff\xff\xff\xff\xff\xff\x32\x00\x33\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x41\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"#

happyTable :: HappyAddr
happyTable = HappyA# "\x00\x00\x15\x00\x40\x00\xf4\x00\x45\x00\x16\x00\x46\x00\x17\x00\x40\x00\x61\x00\x41\x00\xf4\x00\x84\x00\x18\x00\x19\x00\x1a\x00\x40\x00\x83\x01\x41\x00\x81\x00\x40\x00\x1b\x00\x41\x00\x47\x00\xd2\x01\x6a\x00\x40\x00\xe0\xff\x41\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x40\x00\x22\x00\x41\x00\x71\x00\x23\x00\x81\x00\xf7\x00\x24\x00\x37\x00\x10\x01\x75\x00\x40\x00\xf8\x00\x41\x00\xf4\x00\x26\x00\x33\x00\x10\x01\x6e\x01\x77\x01\x4f\x00\x50\x00\x51\x00\x52\x00\xab\x00\x27\x00\x28\x00\x2e\x00\x6f\x01\x69\x00\x29\x00\x2a\x00\x82\x00\x6a\x00\xac\x00\x2c\x00\x2b\x00\x2e\x00\x2e\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\xd8\x00\x15\x00\x2e\x00\xe0\xff\xff\xff\x16\x00\x2e\x00\x17\x00\x42\x00\xed\x00\x2e\x00\xea\x00\xd9\x00\x18\x00\x19\x00\x1a\x00\xeb\x00\x65\x00\x42\x00\x43\x00\x65\x00\x1b\x00\xc7\x00\x56\x01\x2e\x00\x2c\x00\x2c\x00\xda\x00\x2e\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x2e\x00\x22\x00\x7b\x00\xdc\x00\x23\x00\x2e\x00\x2e\x00\x24\x00\x2e\x00\x78\x01\x25\x00\x35\x00\x36\x00\x35\x00\x7b\x00\x26\x00\x7c\x00\x7d\x00\x4f\x00\x50\x00\x51\x00\xae\x00\x7e\x00\x62\x01\xcc\x01\x27\x00\x28\x00\x63\x01\x7c\x00\x7d\x00\x29\x00\x2a\x00\x6a\x00\xe4\x00\x66\x00\x34\x01\x2b\x00\x66\x00\x9e\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x15\x00\xc7\x00\xf6\xff\x84\x01\x16\x00\x96\x01\x17\x00\x4f\x00\x50\x00\x51\x00\x52\x00\xee\x00\x18\x00\x19\x00\x1a\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x1b\x00\xaf\x00\xb0\x00\xc1\x00\xf9\x00\x97\x01\xc2\x01\x7f\x00\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\xcd\x01\x22\x00\xc2\x00\x49\x01\x23\x00\x5c\x00\x2e\x00\x24\x00\x04\x01\x95\x01\x75\x00\xc5\x01\xfa\x00\x65\x00\xc7\x00\x26\x00\x5c\x00\x5c\x00\x8f\x01\x99\x01\xa2\x00\x4f\x00\x50\x00\x51\x00\xae\x00\x27\x00\x28\x00\xa3\x00\x36\xff\xca\x01\x29\x00\x2a\x00\xbd\x01\x12\x00\x36\xff\xb7\x01\x2b\x00\xa4\x00\x4b\x01\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x15\x00\xc7\x00\x7e\x01\x41\x01\x16\x00\x9a\x01\x17\x00\x4f\x00\x50\x00\x51\x00\x52\x00\xc1\x01\x18\x00\x19\x00\x1a\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x8c\x01\x1b\x00\x66\x00\x67\x00\x5c\x00\xaf\x00\xb0\x00\xc1\x00\x16\x01\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x17\x01\x22\x00\xee\x00\xe4\x00\x23\x00\xc2\x00\x5b\x01\x24\x00\x8d\x01\xe5\x00\x25\x00\xe6\x00\xc5\x00\xab\x01\xbf\x01\x26\x00\xe7\x00\xe8\x00\xc6\x00\x5d\x00\xa2\x00\x08\x01\x5e\x00\x2c\x01\xad\x01\x27\x00\x28\x00\xa3\x00\xa2\x00\x93\x01\x29\x00\x2a\x00\xe4\x00\x94\x01\xb2\x01\x9e\x01\x2b\x00\xa4\x00\xa5\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x15\x00\x86\x01\x74\x01\x6e\x00\x4c\x00\x6f\x00\x17\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x98\x00\x18\x00\x19\x00\x1a\x00\x9c\x01\x96\x01\x17\x00\xa8\x01\x4f\x00\x50\x00\x51\x00\xc0\x00\x4d\x00\x19\x00\x1a\x00\xb3\x01\x9d\x01\x1c\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x8c\x01\x22\x00\x97\x01\x98\x01\x23\x00\x4e\x01\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x23\x00\xf9\x00\x16\x01\x5d\x00\x0c\x01\xa2\x00\x5e\x00\x76\x00\x8d\x01\x17\x01\x27\x00\x28\x00\x6f\x01\x18\x01\x8e\x01\x29\x00\x2a\x00\xaf\x00\xb0\x00\xc1\x00\x57\x01\x2b\x00\x0d\x01\xfa\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\xfb\x00\x9c\x01\x5e\x01\xc2\x00\xc3\x00\xe4\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x15\x00\x0c\x01\x60\x01\xa2\x00\x4c\x00\x6c\x01\x17\x00\x73\x01\x74\x01\x7f\x01\x18\x01\x98\x00\x18\x00\x19\x00\x1a\x00\x9c\x01\x71\x01\x17\x00\xb9\x01\x0d\x01\x81\x01\x30\xff\x98\x00\x4d\x00\x19\x00\x1a\x00\x4c\x00\x0e\x01\x17\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x4d\x00\x19\x00\x1a\x00\x90\x00\x23\x00\x91\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x4f\x00\x50\x00\x51\x00\xae\x00\x23\x00\x72\x01\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x23\x00\x7f\x01\x2f\x00\x30\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x75\x01\xbc\x01\x5c\x00\x81\x01\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x79\x01\xf4\x00\x4f\x00\x50\x00\x51\x00\x52\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x23\x01\xfc\x00\x91\x00\xaf\x00\xb0\x00\xc1\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x15\x00\xb8\x00\x49\x00\xa2\x00\x4c\x00\x1e\x01\x17\x00\xc2\x00\x12\x01\xb7\x00\x32\x01\x98\x00\x18\x00\x19\x00\x1a\x00\x4c\x00\x12\x00\x17\x00\xb9\x00\x3a\x01\x40\x01\x51\x01\x15\x00\x4d\x00\x19\x00\x1a\x00\x4c\x00\x25\x01\x17\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x18\x00\x19\x00\x1a\x00\x43\x01\x23\x00\xb8\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x4f\x00\x50\x00\x51\x00\xae\x00\x23\x00\x32\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\xb9\x00\x7f\x01\x33\x00\xba\x00\x23\x00\x4f\x00\x50\x00\x51\x00\xae\x00\x7c\x01\x80\x01\x7d\x01\x81\x01\x4f\x00\x50\x00\x51\x00\x52\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\xa6\x00\x4f\x00\x50\x00\x51\x00\xae\x00\xad\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x9a\x00\xb5\x00\x9b\x00\xaf\x00\xb0\x00\x50\x01\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x4b\x00\xbf\x00\xc7\x00\xdd\x00\x4c\x00\xde\x00\x17\x00\xdf\x00\xaf\x00\xb0\x00\xb1\x00\x15\x00\x4d\x00\x19\x00\x1a\x00\x4c\x00\x53\x00\x17\x00\xe0\x00\xe1\x00\xb2\x00\xe2\x00\x4f\x01\x18\x00\x19\x00\x1a\x00\xaf\x00\xb0\x00\xb6\x00\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x4f\x00\x50\x00\x51\x00\xae\x00\x23\x00\x24\x01\x1d\x00\x1e\x00\x1f\x00\x20\x00\x21\x00\x16\x01\x38\x00\x55\x00\x90\x00\x23\x00\x91\x00\x56\x00\x17\x01\x57\x00\x90\x00\x47\x00\x91\x00\x1a\x01\x55\xff\x64\x00\x58\x00\x59\x00\x6d\x00\x92\x00\x55\xff\x55\xff\xd2\x01\x3b\x01\xcc\x01\x55\xff\x5a\x00\x5b\x00\x1b\x01\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x7b\x01\xcf\x01\xd0\x01\xaf\x00\x59\x01\x7f\x01\x06\x00\x2c\x00\x2d\x00\x2e\x00\x2f\x00\x55\x00\x06\x00\xc8\x01\x85\x01\x56\x00\x81\x01\x57\x00\xc9\x01\x5d\x00\x2e\x00\x1a\x01\x5e\x00\x76\x00\x58\x00\x59\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\xb9\x01\xca\x01\x55\x00\x5a\x00\x5b\x00\x1b\x01\x56\x00\xbb\x01\x57\x00\x2e\x00\xb5\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x58\x00\x59\x00\x55\x00\x7b\x01\xc4\x01\x63\x01\x56\x00\xc5\x01\x57\x00\xaa\x01\x5a\x00\x5b\x00\x62\x01\xab\x01\xaf\x01\x58\x00\x59\x00\xad\x01\x0b\x00\x0c\x00\x8a\x00\x8b\x00\x8c\x00\x55\x00\x11\x00\x5a\x00\x5b\x00\x56\x00\xb1\x01\x57\x00\xb2\x01\xb5\x00\x12\x00\x2e\x00\xb5\x01\xb6\x01\x58\x00\x59\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\xb7\x01\x2e\x00\x55\x00\x7e\x01\x5a\x00\x5b\x00\x56\x00\x2e\x00\x57\x00\x84\x01\x2e\x00\x4f\x00\x50\x00\x51\x00\xae\x00\x58\x00\x59\x00\x89\x01\x06\x00\x2c\x00\x2d\x00\x2e\x00\x77\x01\x8c\x01\x55\x00\x5a\x00\x5b\x00\x91\x01\x56\x00\xa0\x01\x57\x00\x5c\x00\xa1\x01\x06\x00\x2c\x00\x2d\x00\x2e\x00\x58\x00\x59\x00\x2e\x00\xa2\x01\xa5\x01\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x5a\x00\x5b\x00\x45\x01\x2e\x00\x46\x01\xd4\x01\x48\x01\x06\x00\x2c\x00\x2d\x00\x2e\x00\xaf\x00\xb0\x00\xb1\x00\x5d\x00\x5c\x00\x47\x01\x5e\x00\x42\x01\x4d\x01\x4e\x01\x2e\x00\x5c\x00\xb2\x00\x5d\x01\xb3\x00\x5e\x01\x2e\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\x60\x01\x0b\x00\x0c\x00\x86\x00\x64\x01\xd1\x01\x65\x01\x66\x01\xc9\x00\x67\x01\xca\x00\xcb\x00\xcc\x00\x5d\x00\xcd\x00\x12\x00\x5e\x00\xa7\x00\x06\x00\x2c\x00\x2d\x00\x2e\x00\xce\x00\xcf\x00\xd0\x00\xd1\x00\x63\x01\x68\x01\xd2\x00\xd3\x00\xd4\x00\xd5\x00\x69\x01\xd6\x00\x5c\x00\x6c\x01\x2e\x00\xbc\x01\xd7\x00\x71\x01\xc9\x00\xd8\x00\xca\x00\xcb\x00\xcc\x00\x79\x01\xcd\x00\x75\x00\x7b\x01\x2e\x00\xec\x00\x2e\x00\xed\x00\x11\x01\xce\x00\xcf\x00\xd0\x00\xd1\x00\x14\x01\x15\x01\xd2\x00\xd3\x00\xd4\x00\xd5\x00\x5d\x00\xd6\x00\x9b\x00\x5e\x00\x5f\x00\xc1\x01\xd7\x00\x1c\x01\xc9\x00\xd8\x00\xca\x00\xcb\x00\xcc\x00\x5d\x00\xcd\x00\x1d\x01\x5e\x00\x76\x00\x1e\x01\x2e\x00\x20\x01\xee\x00\xce\x00\xcf\x00\xd0\x00\xd1\x00\x21\x01\x27\x01\xd2\x00\xd3\x00\xd4\x00\xd5\x00\x22\x01\xd6\x00\x25\x01\x28\x01\x2a\x01\xef\x00\xd7\x00\x29\x01\xc9\x00\xd8\x00\xca\x00\xcb\x00\xcc\x00\x87\x01\xcd\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\xf1\x00\xf2\x00\xce\x00\xcf\x00\xd0\x00\xd1\x00\x81\x00\x2f\x01\xd2\x00\xd3\x00\xd4\x00\xd5\x00\x30\x01\xd6\x00\x31\x01\x2e\x00\x32\x01\x34\x01\xd7\x00\x37\x01\x2e\x00\xd8\x00\x3d\x01\x40\x01\x2e\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x06\x00\x81\x00\x85\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x52\x01\x11\x00\x8f\x00\x4f\x00\x50\x00\x51\x00\xae\x00\x94\x00\x95\x00\x12\x00\x9c\x00\x99\x00\x9d\x00\xa0\x00\x13\x00\xa1\x00\x9e\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x2e\x00\x53\x01\xa6\x01\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x52\x01\x11\x00\xa9\x00\xaa\x00\x91\x00\xa2\x00\x2c\x00\x2e\x00\xbc\x00\x12\x00\x2e\x00\x2e\x00\xdc\x00\x2e\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\xaf\x00\x5a\x01\xe4\x00\x53\x01\x54\x01\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x38\x01\x11\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x40\x00\xff\xff\x12\x00\x49\x00\x4e\x00\x4f\x00\x63\x00\x13\x00\x6b\x00\x2e\x00\x39\x01\x06\x00\x07\x00\x08\x00\x71\x00\x0a\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x6a\x00\x11\x00\x06\x00\x07\x00\x08\x00\x92\x00\x0a\x00\x78\x00\x79\x00\x12\x00\xff\xff\x7a\x00\x0b\x00\x7f\x00\x13\x00\x6b\x00\x81\x00\x6c\x00\x06\x00\x07\x00\x08\x00\x71\x00\x0a\x00\x06\x00\x32\x00\x00\x00\x12\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x72\x00\x11\x00\x35\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x61\x00\x12\x00\x00\x00\x00\x00\x66\x00\xa8\x01\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x12\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x72\x00\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x66\x00\x73\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xbd\x00\x11\x00\x55\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xbd\x00\x11\x00\x11\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xbd\x00\x11\x00\xbe\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xbd\x00\x11\x00\xc6\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xc6\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xbe\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xa5\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xaf\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x89\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x8a\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x92\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xa2\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xa3\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x48\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x4a\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x58\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x2a\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x2b\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x2d\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x35\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x37\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x3e\x01\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x85\x00\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x89\x00\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x8d\x00\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\xbc\x00\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x72\x00\x11\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\xee\x00\x00\x00\x00\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x63\x00\x11\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\xef\x00\x12\x00\x00\x00\x00\x00\x00\x00\x00\x00\x13\x00\x00\x00\x69\x01\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\xf1\x00\xf2\x00\x0b\x00\x0c\x00\x0d\x00\x0e\x00\x0f\x00\x10\x00\x11\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x12\x00\x0b\x00\x0c\x00\x87\x00\x00\x00\x13\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x0b\x00\x0c\x00\x88\x00\x00\x00\x00\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x00\x00\x00\x00\x00\x00\x00\x00\x12\x00\x95\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\xee\x00\x00\x00\x3d\x01\x00\x00\x00\x00\x00\x00\x00\x00\x95\x00\x12\x00\x00\x00\x06\x00\x07\x00\x08\x00\x09\x00\x0a\x00\x96\x00\x00\x00\x02\x01\x00\x00\x08\x01\x00\x00\x12\x00\x0b\x00\xac\x00\x00\x00\x09\x01\x00\x00\x0a\x01\x00\x00\x00\x00\x00\x00\x0b\x01\x05\x01\x0b\x00\x61\x00\x00\x00\x12\x00\x00\x00\xc9\x00\x00\x00\xca\x00\xcb\x00\xcc\x00\x00\x00\xcd\x00\x00\x00\x00\x00\x12\x00\x0b\x00\x7f\x00\xee\x00\x00\x00\xce\x00\xcf\x00\xd0\x00\xd1\x00\xee\x00\x00\x00\xd2\x00\xd3\x00\xd4\x00\xd5\x00\x12\x00\xd6\x00\x00\x00\x00\x00\x00\x00\x02\x01\xd7\x00\xee\x00\x00\x00\xd8\x00\xef\x00\xee\x00\x00\x00\x91\x01\x00\x00\x00\x00\xee\x00\x00\x00\x6a\x01\x04\x01\x05\x01\xee\x00\x00\x00\xef\x00\x00\x00\xf1\x00\xf2\x00\xef\x00\x00\x00\x00\x00\xee\x00\xf0\x00\xef\x00\xee\x00\x00\x00\xf5\x00\x00\x00\xef\x00\xf1\x00\xf2\x00\xf8\x00\x00\x00\xf1\x00\xf2\x00\xee\x00\xfd\x00\xef\x00\xf1\x00\xf2\x00\xef\x00\xee\x00\x00\x00\xf1\x00\xf2\x00\xfe\x00\xee\x00\x00\x00\xff\x00\x00\x00\x00\x00\xef\x00\xf1\x00\xf2\x00\x00\x00\xf1\x00\xf2\x00\xef\x00\xee\x00\x00\x01\xee\x00\x00\x00\x00\x00\x02\x01\x00\x00\x01\x01\xf1\x00\xf2\x00\x00\x00\x00\x00\x00\x00\x03\x01\xf1\x00\xf2\x00\xef\x00\x00\x00\xef\x00\x04\x01\x05\x01\x00\x00\x00\x00\x00\x00\x06\x01\x00\x00\x07\x01\x3a\x00\x00\x00\x00\x00\x3b\x00\xf1\x00\xf2\x00\xf1\x00\xf2\x00\x00\x00\x3c\x00\x00\x00\x00\x00\x00\x00\x3d\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x3f\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"#

happyReduceArr = array (4, 241) [
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
	(146 , happyReduce_146),
	(147 , happyReduce_147),
	(148 , happyReduce_148),
	(149 , happyReduce_149),
	(150 , happyReduce_150),
	(151 , happyReduce_151),
	(152 , happyReduce_152),
	(153 , happyReduce_153),
	(154 , happyReduce_154),
	(155 , happyReduce_155),
	(156 , happyReduce_156),
	(157 , happyReduce_157),
	(158 , happyReduce_158),
	(159 , happyReduce_159),
	(160 , happyReduce_160),
	(161 , happyReduce_161),
	(162 , happyReduce_162),
	(163 , happyReduce_163),
	(164 , happyReduce_164),
	(165 , happyReduce_165),
	(166 , happyReduce_166),
	(167 , happyReduce_167),
	(168 , happyReduce_168),
	(169 , happyReduce_169),
	(170 , happyReduce_170),
	(171 , happyReduce_171),
	(172 , happyReduce_172),
	(173 , happyReduce_173),
	(174 , happyReduce_174),
	(175 , happyReduce_175),
	(176 , happyReduce_176),
	(177 , happyReduce_177),
	(178 , happyReduce_178),
	(179 , happyReduce_179),
	(180 , happyReduce_180),
	(181 , happyReduce_181),
	(182 , happyReduce_182),
	(183 , happyReduce_183),
	(184 , happyReduce_184),
	(185 , happyReduce_185),
	(186 , happyReduce_186),
	(187 , happyReduce_187),
	(188 , happyReduce_188),
	(189 , happyReduce_189),
	(190 , happyReduce_190),
	(191 , happyReduce_191),
	(192 , happyReduce_192),
	(193 , happyReduce_193),
	(194 , happyReduce_194),
	(195 , happyReduce_195),
	(196 , happyReduce_196),
	(197 , happyReduce_197),
	(198 , happyReduce_198),
	(199 , happyReduce_199),
	(200 , happyReduce_200),
	(201 , happyReduce_201),
	(202 , happyReduce_202),
	(203 , happyReduce_203),
	(204 , happyReduce_204),
	(205 , happyReduce_205),
	(206 , happyReduce_206),
	(207 , happyReduce_207),
	(208 , happyReduce_208),
	(209 , happyReduce_209),
	(210 , happyReduce_210),
	(211 , happyReduce_211),
	(212 , happyReduce_212),
	(213 , happyReduce_213),
	(214 , happyReduce_214),
	(215 , happyReduce_215),
	(216 , happyReduce_216),
	(217 , happyReduce_217),
	(218 , happyReduce_218),
	(219 , happyReduce_219),
	(220 , happyReduce_220),
	(221 , happyReduce_221),
	(222 , happyReduce_222),
	(223 , happyReduce_223),
	(224 , happyReduce_224),
	(225 , happyReduce_225),
	(226 , happyReduce_226),
	(227 , happyReduce_227),
	(228 , happyReduce_228),
	(229 , happyReduce_229),
	(230 , happyReduce_230),
	(231 , happyReduce_231),
	(232 , happyReduce_232),
	(233 , happyReduce_233),
	(234 , happyReduce_234),
	(235 , happyReduce_235),
	(236 , happyReduce_236),
	(237 , happyReduce_237),
	(238 , happyReduce_238),
	(239 , happyReduce_239),
	(240 , happyReduce_240),
	(241 , happyReduce_241)
	]

happy_n_terms = 83 :: Int
happy_n_nonterms = 74 :: Int

happyReduce_4 = happySpecReduce_1  0# happyReduction_4
happyReduction_4 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TI happy_var_1)) -> 
	happyIn7
		 ((read happy_var_1) :: Integer
	)}

happyReduce_5 = happySpecReduce_1  1# happyReduction_5
happyReduction_5 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TL happy_var_1)) -> 
	happyIn8
		 (happy_var_1
	)}

happyReduce_6 = happySpecReduce_1  2# happyReduction_6
happyReduction_6 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (TD happy_var_1)) -> 
	happyIn9
		 ((read happy_var_1) :: Double
	)}

happyReduce_7 = happySpecReduce_1  3# happyReduction_7
happyReduction_7 happy_x_1
	 =  case happyOutTok happy_x_1 of { happy_var_1 -> 
	happyIn10
		 (PIdent (mkPosToken happy_var_1)
	)}

happyReduce_8 = happySpecReduce_1  4# happyReduction_8
happyReduction_8 happy_x_1
	 =  case happyOutTok happy_x_1 of { (PT _ (T_LString happy_var_1)) -> 
	happyIn11
		 (LString (happy_var_1)
	)}

happyReduce_9 = happySpecReduce_1  5# happyReduction_9
happyReduction_9 happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	happyIn12
		 (Gr (reverse happy_var_1)
	)}

happyReduce_10 = happySpecReduce_0  6# happyReduction_10
happyReduction_10  =  happyIn13
		 ([]
	)

happyReduce_11 = happySpecReduce_2  6# happyReduction_11
happyReduction_11 happy_x_2
	happy_x_1
	 =  case happyOut13 happy_x_1 of { happy_var_1 -> 
	case happyOut14 happy_x_2 of { happy_var_2 -> 
	happyIn13
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_12 = happySpecReduce_2  7# happyReduction_12
happyReduction_12 happy_x_2
	happy_x_1
	 =  case happyOut14 happy_x_1 of { happy_var_1 -> 
	happyIn14
		 (happy_var_1
	)}

happyReduce_13 = happyReduce 4# 7# happyReduction_13
happyReduction_13 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut22 happy_x_1 of { happy_var_1 -> 
	case happyOut15 happy_x_2 of { happy_var_2 -> 
	case happyOut16 happy_x_4 of { happy_var_4 -> 
	happyIn14
		 (MModule happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_14 = happySpecReduce_2  8# happyReduction_14
happyReduction_14 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn15
		 (MAbstract happy_var_2
	)}

happyReduce_15 = happySpecReduce_2  8# happyReduction_15
happyReduction_15 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn15
		 (MResource happy_var_2
	)}

happyReduce_16 = happySpecReduce_2  8# happyReduction_16
happyReduction_16 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn15
		 (MGrammar happy_var_2
	)}

happyReduce_17 = happySpecReduce_2  8# happyReduction_17
happyReduction_17 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn15
		 (MInterface happy_var_2
	)}

happyReduce_18 = happyReduce 4# 8# happyReduction_18
happyReduction_18 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut10 happy_x_4 of { happy_var_4 -> 
	happyIn15
		 (MConcrete happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_19 = happyReduce 4# 8# happyReduction_19
happyReduction_19 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut10 happy_x_4 of { happy_var_4 -> 
	happyIn15
		 (MInstance happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_20 = happyReduce 5# 9# happyReduction_20
happyReduction_20 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut18 happy_x_1 of { happy_var_1 -> 
	case happyOut20 happy_x_2 of { happy_var_2 -> 
	case happyOut17 happy_x_4 of { happy_var_4 -> 
	happyIn16
		 (MBody happy_var_1 happy_var_2 (reverse happy_var_4)
	) `HappyStk` happyRest}}}

happyReduce_21 = happySpecReduce_1  9# happyReduction_21
happyReduction_21 happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn16
		 (MNoBody happy_var_1
	)}

happyReduce_22 = happySpecReduce_3  9# happyReduction_22
happyReduction_22 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_3 of { happy_var_3 -> 
	happyIn16
		 (MWith happy_var_1 happy_var_3
	)}}

happyReduce_23 = happyReduce 8# 9# happyReduction_23
happyReduction_23 (happy_x_8 `HappyStk`
	happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut24 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_3 of { happy_var_3 -> 
	case happyOut20 happy_x_5 of { happy_var_5 -> 
	case happyOut17 happy_x_7 of { happy_var_7 -> 
	happyIn16
		 (MWithBody happy_var_1 happy_var_3 happy_var_5 (reverse happy_var_7)
	) `HappyStk` happyRest}}}}

happyReduce_24 = happyReduce 5# 9# happyReduction_24
happyReduction_24 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut23 happy_x_1 of { happy_var_1 -> 
	case happyOut24 happy_x_3 of { happy_var_3 -> 
	case happyOut19 happy_x_5 of { happy_var_5 -> 
	happyIn16
		 (MWithE happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_25 = happyReduce 10# 9# happyReduction_25
happyReduction_25 (happy_x_10 `HappyStk`
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
	 = case happyOut23 happy_x_1 of { happy_var_1 -> 
	case happyOut24 happy_x_3 of { happy_var_3 -> 
	case happyOut19 happy_x_5 of { happy_var_5 -> 
	case happyOut20 happy_x_7 of { happy_var_7 -> 
	case happyOut17 happy_x_9 of { happy_var_9 -> 
	happyIn16
		 (MWithEBody happy_var_1 happy_var_3 happy_var_5 happy_var_7 (reverse happy_var_9)
	) `HappyStk` happyRest}}}}}

happyReduce_26 = happySpecReduce_2  9# happyReduction_26
happyReduction_26 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn16
		 (MReuse happy_var_2
	)}

happyReduce_27 = happySpecReduce_2  9# happyReduction_27
happyReduction_27 happy_x_2
	happy_x_1
	 =  case happyOut23 happy_x_2 of { happy_var_2 -> 
	happyIn16
		 (MUnion happy_var_2
	)}

happyReduce_28 = happySpecReduce_0  10# happyReduction_28
happyReduction_28  =  happyIn17
		 ([]
	)

happyReduce_29 = happySpecReduce_2  10# happyReduction_29
happyReduction_29 happy_x_2
	happy_x_1
	 =  case happyOut17 happy_x_1 of { happy_var_1 -> 
	case happyOut25 happy_x_2 of { happy_var_2 -> 
	happyIn17
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_30 = happySpecReduce_2  11# happyReduction_30
happyReduction_30 happy_x_2
	happy_x_1
	 =  case happyOut23 happy_x_1 of { happy_var_1 -> 
	happyIn18
		 (Ext happy_var_1
	)}

happyReduce_31 = happySpecReduce_0  11# happyReduction_31
happyReduction_31  =  happyIn18
		 (NoExt
	)

happyReduce_32 = happySpecReduce_0  12# happyReduction_32
happyReduction_32  =  happyIn19
		 ([]
	)

happyReduce_33 = happySpecReduce_1  12# happyReduction_33
happyReduction_33 happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	happyIn19
		 ((:[]) happy_var_1
	)}

happyReduce_34 = happySpecReduce_3  12# happyReduction_34
happyReduction_34 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut21 happy_x_1 of { happy_var_1 -> 
	case happyOut19 happy_x_3 of { happy_var_3 -> 
	happyIn19
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_35 = happySpecReduce_0  13# happyReduction_35
happyReduction_35  =  happyIn20
		 (NoOpens
	)

happyReduce_36 = happySpecReduce_3  13# happyReduction_36
happyReduction_36 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut19 happy_x_2 of { happy_var_2 -> 
	happyIn20
		 (OpenIn happy_var_2
	)}

happyReduce_37 = happySpecReduce_1  14# happyReduction_37
happyReduction_37 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn21
		 (OName happy_var_1
	)}

happyReduce_38 = happyReduce 5# 14# happyReduction_38
happyReduction_38 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut10 happy_x_4 of { happy_var_4 -> 
	happyIn21
		 (OQual happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_39 = happySpecReduce_0  15# happyReduction_39
happyReduction_39  =  happyIn22
		 (CMCompl
	)

happyReduce_40 = happySpecReduce_1  15# happyReduction_40
happyReduction_40 happy_x_1
	 =  happyIn22
		 (CMIncompl
	)

happyReduce_41 = happySpecReduce_0  16# happyReduction_41
happyReduction_41  =  happyIn23
		 ([]
	)

happyReduce_42 = happySpecReduce_1  16# happyReduction_42
happyReduction_42 happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	happyIn23
		 ((:[]) happy_var_1
	)}

happyReduce_43 = happySpecReduce_3  16# happyReduction_43
happyReduction_43 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut24 happy_x_1 of { happy_var_1 -> 
	case happyOut23 happy_x_3 of { happy_var_3 -> 
	happyIn23
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_44 = happySpecReduce_1  17# happyReduction_44
happyReduction_44 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn24
		 (IAll happy_var_1
	)}

happyReduce_45 = happyReduce 4# 17# happyReduction_45
happyReduction_45 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut40 happy_x_3 of { happy_var_3 -> 
	happyIn24
		 (ISome happy_var_1 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_46 = happyReduce 5# 17# happyReduction_46
happyReduction_46 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut40 happy_x_4 of { happy_var_4 -> 
	happyIn24
		 (IMinus happy_var_1 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_47 = happySpecReduce_2  18# happyReduction_47
happyReduction_47 happy_x_2
	happy_x_1
	 =  case happyOut36 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefCat happy_var_2
	)}

happyReduce_48 = happySpecReduce_2  18# happyReduction_48
happyReduction_48 happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefFun happy_var_2
	)}

happyReduce_49 = happySpecReduce_2  18# happyReduction_49
happyReduction_49 happy_x_2
	happy_x_1
	 =  case happyOut35 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefFunData happy_var_2
	)}

happyReduce_50 = happySpecReduce_2  18# happyReduction_50
happyReduction_50 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefDef happy_var_2
	)}

happyReduce_51 = happySpecReduce_2  18# happyReduction_51
happyReduction_51 happy_x_2
	happy_x_1
	 =  case happyOut37 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefData happy_var_2
	)}

happyReduce_52 = happySpecReduce_2  18# happyReduction_52
happyReduction_52 happy_x_2
	happy_x_1
	 =  case happyOut38 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefPar happy_var_2
	)}

happyReduce_53 = happySpecReduce_2  18# happyReduction_53
happyReduction_53 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefOper happy_var_2
	)}

happyReduce_54 = happySpecReduce_2  18# happyReduction_54
happyReduction_54 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefLincat happy_var_2
	)}

happyReduce_55 = happySpecReduce_2  18# happyReduction_55
happyReduction_55 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefLindef happy_var_2
	)}

happyReduce_56 = happySpecReduce_2  18# happyReduction_56
happyReduction_56 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefLin happy_var_2
	)}

happyReduce_57 = happySpecReduce_3  18# happyReduction_57
happyReduction_57 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn25
		 (DefPrintCat happy_var_3
	)}

happyReduce_58 = happySpecReduce_3  18# happyReduction_58
happyReduction_58 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn25
		 (DefPrintFun happy_var_3
	)}

happyReduce_59 = happySpecReduce_2  18# happyReduction_59
happyReduction_59 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefFlag happy_var_2
	)}

happyReduce_60 = happySpecReduce_2  18# happyReduction_60
happyReduction_60 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefPrintOld happy_var_2
	)}

happyReduce_61 = happySpecReduce_2  18# happyReduction_61
happyReduction_61 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefLintype happy_var_2
	)}

happyReduce_62 = happySpecReduce_2  18# happyReduction_62
happyReduction_62 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefPattern happy_var_2
	)}

happyReduce_63 = happyReduce 7# 18# happyReduction_63
happyReduction_63 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut17 happy_x_5 of { happy_var_5 -> 
	happyIn25
		 (DefPackage happy_var_2 (reverse happy_var_5)
	) `HappyStk` happyRest}}

happyReduce_64 = happySpecReduce_2  18# happyReduction_64
happyReduction_64 happy_x_2
	happy_x_1
	 =  case happyOut34 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefVars happy_var_2
	)}

happyReduce_65 = happySpecReduce_3  18# happyReduction_65
happyReduction_65 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn25
		 (DefTokenizer happy_var_2
	)}

happyReduce_66 = happySpecReduce_3  19# happyReduction_66
happyReduction_66 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut42 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn26
		 (DDecl happy_var_1 happy_var_3
	)}}

happyReduce_67 = happySpecReduce_3  19# happyReduction_67
happyReduction_67 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut42 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn26
		 (DDef happy_var_1 happy_var_3
	)}}

happyReduce_68 = happyReduce 4# 19# happyReduction_68
happyReduction_68 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut61 happy_x_2 of { happy_var_2 -> 
	case happyOut50 happy_x_4 of { happy_var_4 -> 
	happyIn26
		 (DPatt happy_var_1 happy_var_2 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_69 = happyReduce 5# 19# happyReduction_69
happyReduction_69 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut42 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	case happyOut50 happy_x_5 of { happy_var_5 -> 
	happyIn26
		 (DFull happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_70 = happySpecReduce_3  20# happyReduction_70
happyReduction_70 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut42 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn27
		 (FDecl happy_var_1 happy_var_3
	)}}

happyReduce_71 = happySpecReduce_2  21# happyReduction_71
happyReduction_71 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut76 happy_x_2 of { happy_var_2 -> 
	happyIn28
		 (SimpleCatDef happy_var_1 (reverse happy_var_2)
	)}}

happyReduce_72 = happyReduce 4# 21# happyReduction_72
happyReduction_72 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut76 happy_x_3 of { happy_var_3 -> 
	happyIn28
		 (ListCatDef happy_var_2 (reverse happy_var_3)
	) `HappyStk` happyRest}}

happyReduce_73 = happyReduce 7# 21# happyReduction_73
happyReduction_73 (happy_x_7 `HappyStk`
	happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut76 happy_x_3 of { happy_var_3 -> 
	case happyOut7 happy_x_6 of { happy_var_6 -> 
	happyIn28
		 (ListSizeCatDef happy_var_2 (reverse happy_var_3) happy_var_6
	) `HappyStk` happyRest}}}

happyReduce_74 = happySpecReduce_3  22# happyReduction_74
happyReduction_74 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn29
		 (DataDef happy_var_1 happy_var_3
	)}}

happyReduce_75 = happySpecReduce_1  23# happyReduction_75
happyReduction_75 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn30
		 (DataId happy_var_1
	)}

happyReduce_76 = happySpecReduce_3  23# happyReduction_76
happyReduction_76 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut10 happy_x_3 of { happy_var_3 -> 
	happyIn30
		 (DataQId happy_var_1 happy_var_3
	)}}

happyReduce_77 = happySpecReduce_0  24# happyReduction_77
happyReduction_77  =  happyIn31
		 ([]
	)

happyReduce_78 = happySpecReduce_1  24# happyReduction_78
happyReduction_78 happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	happyIn31
		 ((:[]) happy_var_1
	)}

happyReduce_79 = happySpecReduce_3  24# happyReduction_79
happyReduction_79 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut30 happy_x_1 of { happy_var_1 -> 
	case happyOut31 happy_x_3 of { happy_var_3 -> 
	happyIn31
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_80 = happySpecReduce_3  25# happyReduction_80
happyReduction_80 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn32
		 (ParDefDir happy_var_1 happy_var_3
	)}}

happyReduce_81 = happySpecReduce_1  25# happyReduction_81
happyReduction_81 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn32
		 (ParDefAbs happy_var_1
	)}

happyReduce_82 = happySpecReduce_2  26# happyReduction_82
happyReduction_82 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut76 happy_x_2 of { happy_var_2 -> 
	happyIn33
		 (ParConstr happy_var_1 (reverse happy_var_2)
	)}}

happyReduce_83 = happySpecReduce_2  27# happyReduction_83
happyReduction_83 happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	happyIn34
		 ((:[]) happy_var_1
	)}

happyReduce_84 = happySpecReduce_3  27# happyReduction_84
happyReduction_84 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut26 happy_x_1 of { happy_var_1 -> 
	case happyOut34 happy_x_3 of { happy_var_3 -> 
	happyIn34
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_85 = happySpecReduce_2  28# happyReduction_85
happyReduction_85 happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	happyIn35
		 ((:[]) happy_var_1
	)}

happyReduce_86 = happySpecReduce_3  28# happyReduction_86
happyReduction_86 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut27 happy_x_1 of { happy_var_1 -> 
	case happyOut35 happy_x_3 of { happy_var_3 -> 
	happyIn35
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_87 = happySpecReduce_2  29# happyReduction_87
happyReduction_87 happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	happyIn36
		 ((:[]) happy_var_1
	)}

happyReduce_88 = happySpecReduce_3  29# happyReduction_88
happyReduction_88 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut28 happy_x_1 of { happy_var_1 -> 
	case happyOut36 happy_x_3 of { happy_var_3 -> 
	happyIn36
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_89 = happySpecReduce_2  30# happyReduction_89
happyReduction_89 happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	happyIn37
		 ((:[]) happy_var_1
	)}

happyReduce_90 = happySpecReduce_3  30# happyReduction_90
happyReduction_90 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut29 happy_x_1 of { happy_var_1 -> 
	case happyOut37 happy_x_3 of { happy_var_3 -> 
	happyIn37
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_91 = happySpecReduce_2  31# happyReduction_91
happyReduction_91 happy_x_2
	happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	happyIn38
		 ((:[]) happy_var_1
	)}

happyReduce_92 = happySpecReduce_3  31# happyReduction_92
happyReduction_92 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut32 happy_x_1 of { happy_var_1 -> 
	case happyOut38 happy_x_3 of { happy_var_3 -> 
	happyIn38
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_93 = happySpecReduce_0  32# happyReduction_93
happyReduction_93  =  happyIn39
		 ([]
	)

happyReduce_94 = happySpecReduce_1  32# happyReduction_94
happyReduction_94 happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	happyIn39
		 ((:[]) happy_var_1
	)}

happyReduce_95 = happySpecReduce_3  32# happyReduction_95
happyReduction_95 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut33 happy_x_1 of { happy_var_1 -> 
	case happyOut39 happy_x_3 of { happy_var_3 -> 
	happyIn39
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_96 = happySpecReduce_1  33# happyReduction_96
happyReduction_96 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn40
		 ((:[]) happy_var_1
	)}

happyReduce_97 = happySpecReduce_3  33# happyReduction_97
happyReduction_97 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut40 happy_x_3 of { happy_var_3 -> 
	happyIn40
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_98 = happySpecReduce_1  34# happyReduction_98
happyReduction_98 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn41
		 (PIdentName happy_var_1
	)}

happyReduce_99 = happySpecReduce_3  34# happyReduction_99
happyReduction_99 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn41
		 (ListName happy_var_2
	)}

happyReduce_100 = happySpecReduce_1  35# happyReduction_100
happyReduction_100 happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	happyIn42
		 ((:[]) happy_var_1
	)}

happyReduce_101 = happySpecReduce_3  35# happyReduction_101
happyReduction_101 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut41 happy_x_1 of { happy_var_1 -> 
	case happyOut42 happy_x_3 of { happy_var_3 -> 
	happyIn42
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_102 = happySpecReduce_3  36# happyReduction_102
happyReduction_102 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn43
		 (LDDecl happy_var_1 happy_var_3
	)}}

happyReduce_103 = happySpecReduce_3  36# happyReduction_103
happyReduction_103 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn43
		 (LDDef happy_var_1 happy_var_3
	)}}

happyReduce_104 = happyReduce 5# 36# happyReduction_104
happyReduction_104 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	case happyOut50 happy_x_5 of { happy_var_5 -> 
	happyIn43
		 (LDFull happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest}}}

happyReduce_105 = happySpecReduce_0  37# happyReduction_105
happyReduction_105  =  happyIn44
		 ([]
	)

happyReduce_106 = happySpecReduce_1  37# happyReduction_106
happyReduction_106 happy_x_1
	 =  case happyOut43 happy_x_1 of { happy_var_1 -> 
	happyIn44
		 ((:[]) happy_var_1
	)}

happyReduce_107 = happySpecReduce_3  37# happyReduction_107
happyReduction_107 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut43 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_3 of { happy_var_3 -> 
	happyIn44
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_108 = happySpecReduce_1  38# happyReduction_108
happyReduction_108 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (EPIdent happy_var_1
	)}

happyReduce_109 = happySpecReduce_3  38# happyReduction_109
happyReduction_109 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (EConstr happy_var_2
	)}

happyReduce_110 = happySpecReduce_3  38# happyReduction_110
happyReduction_110 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (ECons happy_var_2
	)}

happyReduce_111 = happySpecReduce_1  38# happyReduction_111
happyReduction_111 happy_x_1
	 =  case happyOut59 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (ESort happy_var_1
	)}

happyReduce_112 = happySpecReduce_1  38# happyReduction_112
happyReduction_112 happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (EString happy_var_1
	)}

happyReduce_113 = happySpecReduce_1  38# happyReduction_113
happyReduction_113 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (EInt happy_var_1
	)}

happyReduce_114 = happySpecReduce_1  38# happyReduction_114
happyReduction_114 happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (EFloat happy_var_1
	)}

happyReduce_115 = happySpecReduce_1  38# happyReduction_115
happyReduction_115 happy_x_1
	 =  happyIn45
		 (EMeta
	)

happyReduce_116 = happySpecReduce_2  38# happyReduction_116
happyReduction_116 happy_x_2
	happy_x_1
	 =  happyIn45
		 (EEmpty
	)

happyReduce_117 = happySpecReduce_1  38# happyReduction_117
happyReduction_117 happy_x_1
	 =  happyIn45
		 (EData
	)

happyReduce_118 = happyReduce 4# 38# happyReduction_118
happyReduction_118 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut53 happy_x_3 of { happy_var_3 -> 
	happyIn45
		 (EList happy_var_2 happy_var_3
	) `HappyStk` happyRest}}

happyReduce_119 = happySpecReduce_3  38# happyReduction_119
happyReduction_119 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut8 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (EStrings happy_var_2
	)}

happyReduce_120 = happySpecReduce_3  38# happyReduction_120
happyReduction_120 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut44 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (ERecord happy_var_2
	)}

happyReduce_121 = happySpecReduce_3  38# happyReduction_121
happyReduction_121 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut67 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (ETuple happy_var_2
	)}

happyReduce_122 = happyReduce 4# 38# happyReduction_122
happyReduction_122 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_3 of { happy_var_3 -> 
	happyIn45
		 (EIndir happy_var_3
	) `HappyStk` happyRest}

happyReduce_123 = happyReduce 5# 38# happyReduction_123
happyReduction_123 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut50 happy_x_2 of { happy_var_2 -> 
	case happyOut50 happy_x_4 of { happy_var_4 -> 
	happyIn45
		 (ETyped happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_124 = happySpecReduce_3  38# happyReduction_124
happyReduction_124 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut50 happy_x_2 of { happy_var_2 -> 
	happyIn45
		 (happy_var_2
	)}

happyReduce_125 = happySpecReduce_1  38# happyReduction_125
happyReduction_125 happy_x_1
	 =  case happyOut11 happy_x_1 of { happy_var_1 -> 
	happyIn45
		 (ELString happy_var_1
	)}

happyReduce_126 = happySpecReduce_3  39# happyReduction_126
happyReduction_126 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	case happyOut58 happy_x_3 of { happy_var_3 -> 
	happyIn46
		 (EProj happy_var_1 happy_var_3
	)}}

happyReduce_127 = happyReduce 5# 39# happyReduction_127
happyReduction_127 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut10 happy_x_4 of { happy_var_4 -> 
	happyIn46
		 (EQConstr happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_128 = happyReduce 4# 39# happyReduction_128
happyReduction_128 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut10 happy_x_4 of { happy_var_4 -> 
	happyIn46
		 (EQCons happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_129 = happySpecReduce_1  39# happyReduction_129
happyReduction_129 happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	happyIn46
		 (happy_var_1
	)}

happyReduce_130 = happySpecReduce_2  40# happyReduction_130
happyReduction_130 happy_x_2
	happy_x_1
	 =  case happyOut47 happy_x_1 of { happy_var_1 -> 
	case happyOut46 happy_x_2 of { happy_var_2 -> 
	happyIn47
		 (EApp happy_var_1 happy_var_2
	)}}

happyReduce_131 = happyReduce 4# 40# happyReduction_131
happyReduction_131 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut70 happy_x_3 of { happy_var_3 -> 
	happyIn47
		 (ETable happy_var_3
	) `HappyStk` happyRest}

happyReduce_132 = happyReduce 5# 40# happyReduction_132
happyReduction_132 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut45 happy_x_2 of { happy_var_2 -> 
	case happyOut70 happy_x_4 of { happy_var_4 -> 
	happyIn47
		 (ETTable happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_133 = happyReduce 5# 40# happyReduction_133
happyReduction_133 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut45 happy_x_2 of { happy_var_2 -> 
	case happyOut52 happy_x_4 of { happy_var_4 -> 
	happyIn47
		 (EVTable happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_134 = happyReduce 6# 40# happyReduction_134
happyReduction_134 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut50 happy_x_2 of { happy_var_2 -> 
	case happyOut70 happy_x_5 of { happy_var_5 -> 
	happyIn47
		 (ECase happy_var_2 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_135 = happyReduce 4# 40# happyReduction_135
happyReduction_135 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut52 happy_x_3 of { happy_var_3 -> 
	happyIn47
		 (EVariants happy_var_3
	) `HappyStk` happyRest}

happyReduce_136 = happyReduce 6# 40# happyReduction_136
happyReduction_136 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut50 happy_x_3 of { happy_var_3 -> 
	case happyOut74 happy_x_5 of { happy_var_5 -> 
	happyIn47
		 (EPre happy_var_3 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_137 = happyReduce 4# 40# happyReduction_137
happyReduction_137 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut52 happy_x_3 of { happy_var_3 -> 
	happyIn47
		 (EStrs happy_var_3
	) `HappyStk` happyRest}

happyReduce_138 = happySpecReduce_2  40# happyReduction_138
happyReduction_138 happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_2 of { happy_var_2 -> 
	happyIn47
		 (EPatt happy_var_2
	)}

happyReduce_139 = happySpecReduce_3  40# happyReduction_139
happyReduction_139 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_3 of { happy_var_3 -> 
	happyIn47
		 (EPattType happy_var_3
	)}

happyReduce_140 = happySpecReduce_1  40# happyReduction_140
happyReduction_140 happy_x_1
	 =  case happyOut46 happy_x_1 of { happy_var_1 -> 
	happyIn47
		 (happy_var_1
	)}

happyReduce_141 = happySpecReduce_2  40# happyReduction_141
happyReduction_141 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn47
		 (ELin happy_var_2
	)}

happyReduce_142 = happySpecReduce_3  41# happyReduction_142
happyReduction_142 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_3 of { happy_var_3 -> 
	happyIn48
		 (ESelect happy_var_1 happy_var_3
	)}}

happyReduce_143 = happySpecReduce_3  41# happyReduction_143
happyReduction_143 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_3 of { happy_var_3 -> 
	happyIn48
		 (ETupTyp happy_var_1 happy_var_3
	)}}

happyReduce_144 = happySpecReduce_3  41# happyReduction_144
happyReduction_144 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	case happyOut47 happy_x_3 of { happy_var_3 -> 
	happyIn48
		 (EExtend happy_var_1 happy_var_3
	)}}

happyReduce_145 = happySpecReduce_1  41# happyReduction_145
happyReduction_145 happy_x_1
	 =  case happyOut47 happy_x_1 of { happy_var_1 -> 
	happyIn48
		 (happy_var_1
	)}

happyReduce_146 = happySpecReduce_3  42# happyReduction_146
happyReduction_146 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	case happyOut49 happy_x_3 of { happy_var_3 -> 
	happyIn49
		 (EGlue happy_var_1 happy_var_3
	)}}

happyReduce_147 = happySpecReduce_1  42# happyReduction_147
happyReduction_147 happy_x_1
	 =  case happyOut51 happy_x_1 of { happy_var_1 -> 
	happyIn49
		 (happy_var_1
	)}

happyReduce_148 = happySpecReduce_3  43# happyReduction_148
happyReduction_148 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn50
		 (EConcat happy_var_1 happy_var_3
	)}}

happyReduce_149 = happyReduce 4# 43# happyReduction_149
happyReduction_149 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut63 happy_x_2 of { happy_var_2 -> 
	case happyOut50 happy_x_4 of { happy_var_4 -> 
	happyIn50
		 (EAbstr happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_150 = happyReduce 5# 43# happyReduction_150
happyReduction_150 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut63 happy_x_3 of { happy_var_3 -> 
	case happyOut50 happy_x_5 of { happy_var_5 -> 
	happyIn50
		 (ECTable happy_var_3 happy_var_5
	) `HappyStk` happyRest}}

happyReduce_151 = happySpecReduce_3  43# happyReduction_151
happyReduction_151 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut64 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn50
		 (EProd happy_var_1 happy_var_3
	)}}

happyReduce_152 = happySpecReduce_3  43# happyReduction_152
happyReduction_152 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn50
		 (ETType happy_var_1 happy_var_3
	)}}

happyReduce_153 = happyReduce 6# 43# happyReduction_153
happyReduction_153 (happy_x_6 `HappyStk`
	happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut44 happy_x_3 of { happy_var_3 -> 
	case happyOut50 happy_x_6 of { happy_var_6 -> 
	happyIn50
		 (ELet happy_var_3 happy_var_6
	) `HappyStk` happyRest}}

happyReduce_154 = happyReduce 4# 43# happyReduction_154
happyReduction_154 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut44 happy_x_2 of { happy_var_2 -> 
	case happyOut50 happy_x_4 of { happy_var_4 -> 
	happyIn50
		 (ELetb happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_155 = happyReduce 5# 43# happyReduction_155
happyReduction_155 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut48 happy_x_1 of { happy_var_1 -> 
	case happyOut44 happy_x_4 of { happy_var_4 -> 
	happyIn50
		 (EWhere happy_var_1 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_156 = happyReduce 4# 43# happyReduction_156
happyReduction_156 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut72 happy_x_3 of { happy_var_3 -> 
	happyIn50
		 (EEqs happy_var_3
	) `HappyStk` happyRest}

happyReduce_157 = happySpecReduce_3  43# happyReduction_157
happyReduction_157 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut46 happy_x_2 of { happy_var_2 -> 
	case happyOut8 happy_x_3 of { happy_var_3 -> 
	happyIn50
		 (EExample happy_var_2 happy_var_3
	)}}

happyReduce_158 = happySpecReduce_1  43# happyReduction_158
happyReduction_158 happy_x_1
	 =  case happyOut49 happy_x_1 of { happy_var_1 -> 
	happyIn50
		 (happy_var_1
	)}

happyReduce_159 = happySpecReduce_1  44# happyReduction_159
happyReduction_159 happy_x_1
	 =  case happyOut48 happy_x_1 of { happy_var_1 -> 
	happyIn51
		 (happy_var_1
	)}

happyReduce_160 = happySpecReduce_0  45# happyReduction_160
happyReduction_160  =  happyIn52
		 ([]
	)

happyReduce_161 = happySpecReduce_1  45# happyReduction_161
happyReduction_161 happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	happyIn52
		 ((:[]) happy_var_1
	)}

happyReduce_162 = happySpecReduce_3  45# happyReduction_162
happyReduction_162 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	case happyOut52 happy_x_3 of { happy_var_3 -> 
	happyIn52
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_163 = happySpecReduce_0  46# happyReduction_163
happyReduction_163  =  happyIn53
		 (NilExp
	)

happyReduce_164 = happySpecReduce_2  46# happyReduction_164
happyReduction_164 happy_x_2
	happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	case happyOut53 happy_x_2 of { happy_var_2 -> 
	happyIn53
		 (ConsExp happy_var_1 happy_var_2
	)}}

happyReduce_165 = happySpecReduce_1  47# happyReduction_165
happyReduction_165 happy_x_1
	 =  happyIn54
		 (PChar
	)

happyReduce_166 = happySpecReduce_3  47# happyReduction_166
happyReduction_166 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut8 happy_x_2 of { happy_var_2 -> 
	happyIn54
		 (PChars happy_var_2
	)}

happyReduce_167 = happySpecReduce_2  47# happyReduction_167
happyReduction_167 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn54
		 (PMacro happy_var_2
	)}

happyReduce_168 = happyReduce 4# 47# happyReduction_168
happyReduction_168 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_2 of { happy_var_2 -> 
	case happyOut10 happy_x_4 of { happy_var_4 -> 
	happyIn54
		 (PM happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_169 = happySpecReduce_1  47# happyReduction_169
happyReduction_169 happy_x_1
	 =  happyIn54
		 (PW
	)

happyReduce_170 = happySpecReduce_1  47# happyReduction_170
happyReduction_170 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn54
		 (PV happy_var_1
	)}

happyReduce_171 = happySpecReduce_3  47# happyReduction_171
happyReduction_171 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_2 of { happy_var_2 -> 
	happyIn54
		 (PCon happy_var_2
	)}

happyReduce_172 = happySpecReduce_3  47# happyReduction_172
happyReduction_172 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut10 happy_x_3 of { happy_var_3 -> 
	happyIn54
		 (PQ happy_var_1 happy_var_3
	)}}

happyReduce_173 = happySpecReduce_1  47# happyReduction_173
happyReduction_173 happy_x_1
	 =  case happyOut7 happy_x_1 of { happy_var_1 -> 
	happyIn54
		 (PInt happy_var_1
	)}

happyReduce_174 = happySpecReduce_1  47# happyReduction_174
happyReduction_174 happy_x_1
	 =  case happyOut9 happy_x_1 of { happy_var_1 -> 
	happyIn54
		 (PFloat happy_var_1
	)}

happyReduce_175 = happySpecReduce_1  47# happyReduction_175
happyReduction_175 happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	happyIn54
		 (PStr happy_var_1
	)}

happyReduce_176 = happySpecReduce_3  47# happyReduction_176
happyReduction_176 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut60 happy_x_2 of { happy_var_2 -> 
	happyIn54
		 (PR happy_var_2
	)}

happyReduce_177 = happySpecReduce_3  47# happyReduction_177
happyReduction_177 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut68 happy_x_2 of { happy_var_2 -> 
	happyIn54
		 (PTup happy_var_2
	)}

happyReduce_178 = happySpecReduce_3  47# happyReduction_178
happyReduction_178 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_2 of { happy_var_2 -> 
	happyIn54
		 (happy_var_2
	)}

happyReduce_179 = happySpecReduce_2  48# happyReduction_179
happyReduction_179 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut61 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (PC happy_var_1 happy_var_2
	)}}

happyReduce_180 = happyReduce 4# 48# happyReduction_180
happyReduction_180 (happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut10 happy_x_3 of { happy_var_3 -> 
	case happyOut61 happy_x_4 of { happy_var_4 -> 
	happyIn55
		 (PQC happy_var_1 happy_var_3 happy_var_4
	) `HappyStk` happyRest}}}

happyReduce_181 = happySpecReduce_2  48# happyReduction_181
happyReduction_181 happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	happyIn55
		 (PRep happy_var_1
	)}

happyReduce_182 = happySpecReduce_3  48# happyReduction_182
happyReduction_182 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut54 happy_x_3 of { happy_var_3 -> 
	happyIn55
		 (PAs happy_var_1 happy_var_3
	)}}

happyReduce_183 = happySpecReduce_2  48# happyReduction_183
happyReduction_183 happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_2 of { happy_var_2 -> 
	happyIn55
		 (PNeg happy_var_2
	)}

happyReduce_184 = happySpecReduce_1  48# happyReduction_184
happyReduction_184 happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	happyIn55
		 (happy_var_1
	)}

happyReduce_185 = happySpecReduce_3  49# happyReduction_185
happyReduction_185 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_1 of { happy_var_1 -> 
	case happyOut55 happy_x_3 of { happy_var_3 -> 
	happyIn56
		 (PDisj happy_var_1 happy_var_3
	)}}

happyReduce_186 = happySpecReduce_3  49# happyReduction_186
happyReduction_186 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_1 of { happy_var_1 -> 
	case happyOut55 happy_x_3 of { happy_var_3 -> 
	happyIn56
		 (PSeq happy_var_1 happy_var_3
	)}}

happyReduce_187 = happySpecReduce_1  49# happyReduction_187
happyReduction_187 happy_x_1
	 =  case happyOut55 happy_x_1 of { happy_var_1 -> 
	happyIn56
		 (happy_var_1
	)}

happyReduce_188 = happySpecReduce_3  50# happyReduction_188
happyReduction_188 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut40 happy_x_1 of { happy_var_1 -> 
	case happyOut56 happy_x_3 of { happy_var_3 -> 
	happyIn57
		 (PA happy_var_1 happy_var_3
	)}}

happyReduce_189 = happySpecReduce_1  51# happyReduction_189
happyReduction_189 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn58
		 (LPIdent happy_var_1
	)}

happyReduce_190 = happySpecReduce_2  51# happyReduction_190
happyReduction_190 happy_x_2
	happy_x_1
	 =  case happyOut7 happy_x_2 of { happy_var_2 -> 
	happyIn58
		 (LVar happy_var_2
	)}

happyReduce_191 = happySpecReduce_1  52# happyReduction_191
happyReduction_191 happy_x_1
	 =  happyIn59
		 (Sort_Type
	)

happyReduce_192 = happySpecReduce_1  52# happyReduction_192
happyReduction_192 happy_x_1
	 =  happyIn59
		 (Sort_PType
	)

happyReduce_193 = happySpecReduce_1  52# happyReduction_193
happyReduction_193 happy_x_1
	 =  happyIn59
		 (Sort_Tok
	)

happyReduce_194 = happySpecReduce_1  52# happyReduction_194
happyReduction_194 happy_x_1
	 =  happyIn59
		 (Sort_Str
	)

happyReduce_195 = happySpecReduce_1  52# happyReduction_195
happyReduction_195 happy_x_1
	 =  happyIn59
		 (Sort_Strs
	)

happyReduce_196 = happySpecReduce_0  53# happyReduction_196
happyReduction_196  =  happyIn60
		 ([]
	)

happyReduce_197 = happySpecReduce_1  53# happyReduction_197
happyReduction_197 happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	happyIn60
		 ((:[]) happy_var_1
	)}

happyReduce_198 = happySpecReduce_3  53# happyReduction_198
happyReduction_198 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut57 happy_x_1 of { happy_var_1 -> 
	case happyOut60 happy_x_3 of { happy_var_3 -> 
	happyIn60
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_199 = happySpecReduce_1  54# happyReduction_199
happyReduction_199 happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	happyIn61
		 ((:[]) happy_var_1
	)}

happyReduce_200 = happySpecReduce_2  54# happyReduction_200
happyReduction_200 happy_x_2
	happy_x_1
	 =  case happyOut54 happy_x_1 of { happy_var_1 -> 
	case happyOut61 happy_x_2 of { happy_var_2 -> 
	happyIn61
		 ((:) happy_var_1 happy_var_2
	)}}

happyReduce_201 = happySpecReduce_1  55# happyReduction_201
happyReduction_201 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn62
		 (BPIdent happy_var_1
	)}

happyReduce_202 = happySpecReduce_1  55# happyReduction_202
happyReduction_202 happy_x_1
	 =  happyIn62
		 (BWild
	)

happyReduce_203 = happySpecReduce_0  56# happyReduction_203
happyReduction_203  =  happyIn63
		 ([]
	)

happyReduce_204 = happySpecReduce_1  56# happyReduction_204
happyReduction_204 happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	happyIn63
		 ((:[]) happy_var_1
	)}

happyReduce_205 = happySpecReduce_3  56# happyReduction_205
happyReduction_205 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut62 happy_x_1 of { happy_var_1 -> 
	case happyOut63 happy_x_3 of { happy_var_3 -> 
	happyIn63
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_206 = happyReduce 5# 57# happyReduction_206
happyReduction_206 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut63 happy_x_2 of { happy_var_2 -> 
	case happyOut50 happy_x_4 of { happy_var_4 -> 
	happyIn64
		 (DDec happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_207 = happySpecReduce_1  57# happyReduction_207
happyReduction_207 happy_x_1
	 =  case happyOut47 happy_x_1 of { happy_var_1 -> 
	happyIn64
		 (DExp happy_var_1
	)}

happyReduce_208 = happySpecReduce_1  58# happyReduction_208
happyReduction_208 happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	happyIn65
		 (TComp happy_var_1
	)}

happyReduce_209 = happySpecReduce_1  59# happyReduction_209
happyReduction_209 happy_x_1
	 =  case happyOut56 happy_x_1 of { happy_var_1 -> 
	happyIn66
		 (PTComp happy_var_1
	)}

happyReduce_210 = happySpecReduce_0  60# happyReduction_210
happyReduction_210  =  happyIn67
		 ([]
	)

happyReduce_211 = happySpecReduce_1  60# happyReduction_211
happyReduction_211 happy_x_1
	 =  case happyOut65 happy_x_1 of { happy_var_1 -> 
	happyIn67
		 ((:[]) happy_var_1
	)}

happyReduce_212 = happySpecReduce_3  60# happyReduction_212
happyReduction_212 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut65 happy_x_1 of { happy_var_1 -> 
	case happyOut67 happy_x_3 of { happy_var_3 -> 
	happyIn67
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_213 = happySpecReduce_0  61# happyReduction_213
happyReduction_213  =  happyIn68
		 ([]
	)

happyReduce_214 = happySpecReduce_1  61# happyReduction_214
happyReduction_214 happy_x_1
	 =  case happyOut66 happy_x_1 of { happy_var_1 -> 
	happyIn68
		 ((:[]) happy_var_1
	)}

happyReduce_215 = happySpecReduce_3  61# happyReduction_215
happyReduction_215 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut66 happy_x_1 of { happy_var_1 -> 
	case happyOut68 happy_x_3 of { happy_var_3 -> 
	happyIn68
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_216 = happySpecReduce_3  62# happyReduction_216
happyReduction_216 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut56 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn69
		 (Case happy_var_1 happy_var_3
	)}}

happyReduce_217 = happySpecReduce_1  63# happyReduction_217
happyReduction_217 happy_x_1
	 =  case happyOut69 happy_x_1 of { happy_var_1 -> 
	happyIn70
		 ((:[]) happy_var_1
	)}

happyReduce_218 = happySpecReduce_3  63# happyReduction_218
happyReduction_218 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut69 happy_x_1 of { happy_var_1 -> 
	case happyOut70 happy_x_3 of { happy_var_3 -> 
	happyIn70
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_219 = happySpecReduce_3  64# happyReduction_219
happyReduction_219 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut61 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn71
		 (Equ happy_var_1 happy_var_3
	)}}

happyReduce_220 = happySpecReduce_0  65# happyReduction_220
happyReduction_220  =  happyIn72
		 ([]
	)

happyReduce_221 = happySpecReduce_1  65# happyReduction_221
happyReduction_221 happy_x_1
	 =  case happyOut71 happy_x_1 of { happy_var_1 -> 
	happyIn72
		 ((:[]) happy_var_1
	)}

happyReduce_222 = happySpecReduce_3  65# happyReduction_222
happyReduction_222 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut71 happy_x_1 of { happy_var_1 -> 
	case happyOut72 happy_x_3 of { happy_var_3 -> 
	happyIn72
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_223 = happySpecReduce_3  66# happyReduction_223
happyReduction_223 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut50 happy_x_1 of { happy_var_1 -> 
	case happyOut50 happy_x_3 of { happy_var_3 -> 
	happyIn73
		 (Alt happy_var_1 happy_var_3
	)}}

happyReduce_224 = happySpecReduce_0  67# happyReduction_224
happyReduction_224  =  happyIn74
		 ([]
	)

happyReduce_225 = happySpecReduce_1  67# happyReduction_225
happyReduction_225 happy_x_1
	 =  case happyOut73 happy_x_1 of { happy_var_1 -> 
	happyIn74
		 ((:[]) happy_var_1
	)}

happyReduce_226 = happySpecReduce_3  67# happyReduction_226
happyReduction_226 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut73 happy_x_1 of { happy_var_1 -> 
	case happyOut74 happy_x_3 of { happy_var_3 -> 
	happyIn74
		 ((:) happy_var_1 happy_var_3
	)}}

happyReduce_227 = happyReduce 5# 68# happyReduction_227
happyReduction_227 (happy_x_5 `HappyStk`
	happy_x_4 `HappyStk`
	happy_x_3 `HappyStk`
	happy_x_2 `HappyStk`
	happy_x_1 `HappyStk`
	happyRest)
	 = case happyOut63 happy_x_2 of { happy_var_2 -> 
	case happyOut50 happy_x_4 of { happy_var_4 -> 
	happyIn75
		 (DDDec happy_var_2 happy_var_4
	) `HappyStk` happyRest}}

happyReduce_228 = happySpecReduce_1  68# happyReduction_228
happyReduction_228 happy_x_1
	 =  case happyOut45 happy_x_1 of { happy_var_1 -> 
	happyIn75
		 (DDExp happy_var_1
	)}

happyReduce_229 = happySpecReduce_0  69# happyReduction_229
happyReduction_229  =  happyIn76
		 ([]
	)

happyReduce_230 = happySpecReduce_2  69# happyReduction_230
happyReduction_230 happy_x_2
	happy_x_1
	 =  case happyOut76 happy_x_1 of { happy_var_1 -> 
	case happyOut75 happy_x_2 of { happy_var_2 -> 
	happyIn76
		 (flip (:) happy_var_1 happy_var_2
	)}}

happyReduce_231 = happySpecReduce_2  70# happyReduction_231
happyReduction_231 happy_x_2
	happy_x_1
	 =  case happyOut78 happy_x_1 of { happy_var_1 -> 
	case happyOut17 happy_x_2 of { happy_var_2 -> 
	happyIn77
		 (OldGr happy_var_1 (reverse happy_var_2)
	)}}

happyReduce_232 = happySpecReduce_0  71# happyReduction_232
happyReduction_232  =  happyIn78
		 (NoIncl
	)

happyReduce_233 = happySpecReduce_2  71# happyReduction_233
happyReduction_233 happy_x_2
	happy_x_1
	 =  case happyOut80 happy_x_2 of { happy_var_2 -> 
	happyIn78
		 (Incl happy_var_2
	)}

happyReduce_234 = happySpecReduce_1  72# happyReduction_234
happyReduction_234 happy_x_1
	 =  case happyOut8 happy_x_1 of { happy_var_1 -> 
	happyIn79
		 (FString happy_var_1
	)}

happyReduce_235 = happySpecReduce_1  72# happyReduction_235
happyReduction_235 happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	happyIn79
		 (FPIdent happy_var_1
	)}

happyReduce_236 = happySpecReduce_2  72# happyReduction_236
happyReduction_236 happy_x_2
	happy_x_1
	 =  case happyOut79 happy_x_2 of { happy_var_2 -> 
	happyIn79
		 (FSlash happy_var_2
	)}

happyReduce_237 = happySpecReduce_2  72# happyReduction_237
happyReduction_237 happy_x_2
	happy_x_1
	 =  case happyOut79 happy_x_2 of { happy_var_2 -> 
	happyIn79
		 (FDot happy_var_2
	)}

happyReduce_238 = happySpecReduce_2  72# happyReduction_238
happyReduction_238 happy_x_2
	happy_x_1
	 =  case happyOut79 happy_x_2 of { happy_var_2 -> 
	happyIn79
		 (FMinus happy_var_2
	)}

happyReduce_239 = happySpecReduce_2  72# happyReduction_239
happyReduction_239 happy_x_2
	happy_x_1
	 =  case happyOut10 happy_x_1 of { happy_var_1 -> 
	case happyOut79 happy_x_2 of { happy_var_2 -> 
	happyIn79
		 (FAddId happy_var_1 happy_var_2
	)}}

happyReduce_240 = happySpecReduce_2  73# happyReduction_240
happyReduction_240 happy_x_2
	happy_x_1
	 =  case happyOut79 happy_x_1 of { happy_var_1 -> 
	happyIn80
		 ((:[]) happy_var_1
	)}

happyReduce_241 = happySpecReduce_3  73# happyReduction_241
happyReduction_241 happy_x_3
	happy_x_2
	happy_x_1
	 =  case happyOut79 happy_x_1 of { happy_var_1 -> 
	case happyOut80 happy_x_3 of { happy_var_3 -> 
	happyIn80
		 ((:) happy_var_1 happy_var_3
	)}}

happyNewToken action sts stk [] =
	happyDoAction 82# notHappyAtAll action sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = happyDoAction i tk action sts stk tks in
	case tk of {
	PT _ (TS ";") -> cont 1#;
	PT _ (TS "=") -> cont 2#;
	PT _ (TS "{") -> cont 3#;
	PT _ (TS "}") -> cont 4#;
	PT _ (TS "**") -> cont 5#;
	PT _ (TS ",") -> cont 6#;
	PT _ (TS "(") -> cont 7#;
	PT _ (TS ")") -> cont 8#;
	PT _ (TS "[") -> cont 9#;
	PT _ (TS "]") -> cont 10#;
	PT _ (TS "-") -> cont 11#;
	PT _ (TS ":") -> cont 12#;
	PT _ (TS ".") -> cont 13#;
	PT _ (TS "|") -> cont 14#;
	PT _ (TS "%") -> cont 15#;
	PT _ (TS "?") -> cont 16#;
	PT _ (TS "<") -> cont 17#;
	PT _ (TS ">") -> cont 18#;
	PT _ (TS "!") -> cont 19#;
	PT _ (TS "*") -> cont 20#;
	PT _ (TS "+") -> cont 21#;
	PT _ (TS "++") -> cont 22#;
	PT _ (TS "\\") -> cont 23#;
	PT _ (TS "->") -> cont 24#;
	PT _ (TS "=>") -> cont 25#;
	PT _ (TS "#") -> cont 26#;
	PT _ (TS "_") -> cont 27#;
	PT _ (TS "@") -> cont 28#;
	PT _ (TS "$") -> cont 29#;
	PT _ (TS "/") -> cont 30#;
	PT _ (TS "Lin") -> cont 31#;
	PT _ (TS "PType") -> cont 32#;
	PT _ (TS "Str") -> cont 33#;
	PT _ (TS "Strs") -> cont 34#;
	PT _ (TS "Tok") -> cont 35#;
	PT _ (TS "Type") -> cont 36#;
	PT _ (TS "abstract") -> cont 37#;
	PT _ (TS "case") -> cont 38#;
	PT _ (TS "cat") -> cont 39#;
	PT _ (TS "concrete") -> cont 40#;
	PT _ (TS "data") -> cont 41#;
	PT _ (TS "def") -> cont 42#;
	PT _ (TS "flags") -> cont 43#;
	PT _ (TS "fn") -> cont 44#;
	PT _ (TS "fun") -> cont 45#;
	PT _ (TS "grammar") -> cont 46#;
	PT _ (TS "in") -> cont 47#;
	PT _ (TS "include") -> cont 48#;
	PT _ (TS "incomplete") -> cont 49#;
	PT _ (TS "instance") -> cont 50#;
	PT _ (TS "interface") -> cont 51#;
	PT _ (TS "let") -> cont 52#;
	PT _ (TS "lin") -> cont 53#;
	PT _ (TS "lincat") -> cont 54#;
	PT _ (TS "lindef") -> cont 55#;
	PT _ (TS "lintype") -> cont 56#;
	PT _ (TS "of") -> cont 57#;
	PT _ (TS "open") -> cont 58#;
	PT _ (TS "oper") -> cont 59#;
	PT _ (TS "package") -> cont 60#;
	PT _ (TS "param") -> cont 61#;
	PT _ (TS "pattern") -> cont 62#;
	PT _ (TS "pre") -> cont 63#;
	PT _ (TS "printname") -> cont 64#;
	PT _ (TS "resource") -> cont 65#;
	PT _ (TS "reuse") -> cont 66#;
	PT _ (TS "strs") -> cont 67#;
	PT _ (TS "table") -> cont 68#;
	PT _ (TS "tokenizer") -> cont 69#;
	PT _ (TS "type") -> cont 70#;
	PT _ (TS "union") -> cont 71#;
	PT _ (TS "var") -> cont 72#;
	PT _ (TS "variants") -> cont 73#;
	PT _ (TS "where") -> cont 74#;
	PT _ (TS "with") -> cont 75#;
	PT _ (TI happy_dollar_dollar) -> cont 76#;
	PT _ (TL happy_dollar_dollar) -> cont 77#;
	PT _ (TD happy_dollar_dollar) -> cont 78#;
	PT _ (T_PIdent _) -> cont 79#;
	PT _ (T_LString happy_dollar_dollar) -> cont 80#;
	_ -> cont 81#;
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
  happySomeParser = happyThen (happyParse 0# tks) (\x -> happyReturn (happyOut12 x))

pModDef tks = happySomeParser where
  happySomeParser = happyThen (happyParse 1# tks) (\x -> happyReturn (happyOut14 x))

pOldGrammar tks = happySomeParser where
  happySomeParser = happyThen (happyParse 2# tks) (\x -> happyReturn (happyOut77 x))

pExp tks = happySomeParser where
  happySomeParser = happyThen (happyParse 3# tks) (\x -> happyReturn (happyOut50 x))

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
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 28 "GenericTemplate.hs" #-}


data Happy_IntList = HappyCons Int# Happy_IntList





{-# LINE 49 "GenericTemplate.hs" #-}

{-# LINE 59 "GenericTemplate.hs" #-}

{-# LINE 68 "GenericTemplate.hs" #-}

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

{-# LINE 127 "GenericTemplate.hs" #-}


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
        happyThen1 (fn stk tk) (\r -> happyGoto nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@((HappyCons (st1@(action)) (_))) = happyDrop k (HappyCons (st) (sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn 0# tk st sts stk
     = happyFail 0# tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where sts1@((HappyCons (st1@(action)) (_))) = happyDrop k (HappyCons (st) (sts))
             drop_stk = happyDropStk k stk

             off    = indexShortOffAddr happyGotoOffsets st1
             off_i  = (off +# nt)
             new_state = indexShortOffAddr happyTable off_i




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
