----------------------------------------------------------------------
-- |
-- Module      : GF.Grammar.Binary
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-----------------------------------------------------------------------------

module GF.Grammar.Binary where

import Data.Binary
import qualified Data.Map as Map
import qualified Data.ByteString.Char8 as BS

import GF.Data.Operations
import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.Modules
import GF.Grammar.Grammar

instance Binary Ident where
  put id = put (ident2bs id)
  get    = do bs <- get
              if bs == BS.pack "_"
                then return identW
                else return (identC bs)

instance (Ord i, Binary i, Binary a) => Binary (MGrammar i a) where
  put (MGrammar ms) = put ms
  get               = fmap MGrammar get

instance (Ord i, Binary i, Binary a) => Binary (ModInfo i a) where
  put mi = do put (mtype mi,mstatus mi,flags mi,extend mi,mwith mi,opens mi,mexdeps mi,jments mi,positions mi)
  get    = do (mtype,mstatus,flags,extend,mwith,opens,med,jments,positions) <- get
              return (ModInfo mtype mstatus flags extend mwith opens med jments positions)

instance (Binary i) => Binary (ModuleType i) where
  put MTAbstract       = putWord8 0
  put (MTTransfer i j) = putWord8 1 >> put (i,j)
  put MTResource       = putWord8 2
  put (MTConcrete i)   = putWord8 3 >> put i
  put MTInterface      = putWord8 4
  put (MTInstance i)   = putWord8 5 >> put i
  get = do tag <- getWord8
           case tag of
             0 -> return MTAbstract
             1 -> get >>= \(i,j) -> return (MTTransfer i j)
             2 -> return MTResource
             3 -> get >>= return . MTConcrete
             4 -> return MTInterface
             5 -> get >>= return . MTInstance

instance (Binary i) => Binary (MInclude i) where
  put MIAll         = putWord8 0
  put (MIOnly xs)   = putWord8 1 >> put xs
  put (MIExcept xs) = putWord8 2 >> put xs
  get = do tag <- getWord8
           case tag of
             0 -> return MIAll
             1 -> fmap MIOnly get
             2 -> fmap MIExcept get

instance Binary i => Binary (OpenSpec i) where
  put (OSimple i)   = putWord8 0 >> put i
  put (OQualif i j) = putWord8 1 >> put (i,j)
  get = do tag <- getWord8
           case tag of
             0 -> get >>= return . OSimple
             1 -> get >>= \(i,j) -> return (OQualif i j)

instance Binary ModuleStatus where
  put MSComplete   = putWord8 0
  put MSIncomplete = putWord8 1
  get = do tag <- getWord8
           case tag of
             0 -> return MSComplete
             1 -> return MSIncomplete

instance Binary Options where
  put = put . optionsGFO
  get = do opts <- get
           case parseModuleOptions ["--" ++ flag ++ "=" ++ value | (flag,value) <- opts] of
             Ok  x   -> return x
             Bad msg -> fail msg

instance Binary Info where
  put (AbsCat x y)     = putWord8 0 >> put (x,y)
  put (AbsFun x y)     = putWord8 1 >> put (x,y)
  put (ResParam x)     = putWord8 2 >> put x
  put (ResValue x)     = putWord8 3 >> put x
  put (ResOper x y)    = putWord8 4 >> put (x,y)
  put (ResOverload x y)= putWord8 5 >> put (x,y)
  put (CncCat x y z)   = putWord8 6 >> put (x,y,z)
  put (CncFun x y z)   = putWord8 7 >> put (x,y,z)
  put (AnyInd x y)     = putWord8 8 >> put (x,y)
  get = do tag <- getWord8
           case tag of
             0 -> get >>= \(x,y)   -> return (AbsCat x y)
             1 -> get >>= \(x,y)   -> return (AbsFun x y)
             2 -> get >>= \x       -> return (ResParam x)
             3 -> get >>= \x       -> return (ResValue x)
             4 -> get >>= \(x,y)   -> return (ResOper x y)
             5 -> get >>= \(x,y)   -> return (ResOverload x y)
             6 -> get >>= \(x,y,z) -> return (CncCat x y z)
             7 -> get >>= \(x,y,z) -> return (CncFun x y z)
             8 -> get >>= \(x,y)   -> return (AnyInd x y)

instance Binary Term where
  put (Vr x)        = putWord8 0  >> put x
  put (Cn x)        = putWord8 1  >> put x
  put (Con x)       = putWord8 2  >> put x
  put (EData)       = putWord8 3
  put (Sort x)      = putWord8 4  >> put x
  put (EInt x)      = putWord8 5  >> put x
  put (EFloat x)    = putWord8 6  >> put x
  put (K x)         = putWord8 7  >> put x
  put (Empty)       = putWord8 8
  put (App x y)     = putWord8 9  >> put (x,y)
  put (Abs x y)     = putWord8 10 >> put (x,y)
  put (Meta x)      = putWord8 11 >> put x
  put (Prod x y z)  = putWord8 12 >> put (x,y,z)
  put (Eqs x)       = putWord8 13 >> put x
  put (Typed x y)   = putWord8 14 >> put (x,y)
  put (Example x y) = putWord8 15 >> put (x,y)
  put (RecType x)   = putWord8 16 >> put x
  put (R x)         = putWord8 17 >> put x
  put (P x y)       = putWord8 18 >> put (x,y)
  put (PI x y z)    = putWord8 19 >> put (x,y,z)
  put (ExtR x y)    = putWord8 20 >> put (x,y)
  put (Table x y)   = putWord8 21 >> put (x,y)
  put (T x y)       = putWord8 22 >> put (x,y)
  put (TSh x y)     = putWord8 23 >> put (x,y)
  put (V x y)       = putWord8 24 >> put (x,y)
  put (S x y)       = putWord8 25 >> put (x,y)
  put (Val x y z)   = putWord8 26 >> put (x,y,z)
  put (Let x y)     = putWord8 27 >> put (x,y)
  put (Alias x y z) = putWord8 28 >> put (x,y,z)
  put (Q  x y)      = putWord8 29 >> put (x,y)
  put (QC x y)      = putWord8 30 >> put (x,y)
  put (C x y)       = putWord8 31 >> put (x,y)
  put (Glue x y)    = putWord8 32 >> put (x,y)
  put (EPatt x)     = putWord8 33 >> put x
  put (EPattType x) = putWord8 34 >> put x
  put (FV x)        = putWord8 35 >> put x
  put (Alts x)      = putWord8 36 >> put x
  put (Strs x)      = putWord8 37 >> put x
  get = do tag <- getWord8
           case tag of
             0  -> get >>= \x       -> return (Vr x)
             1  -> get >>= \x       -> return (Cn x)
             2  -> get >>= \x       -> return (Con x)
             3  ->                     return (EData)
             4  -> get >>= \x       -> return (Sort x)
             5  -> get >>= \x       -> return (EInt x)
             6  -> get >>= \x       -> return (EFloat x)
             7  -> get >>= \x       -> return (K x)
             8  ->                     return (Empty)
             9  -> get >>= \(x,y)   -> return (App x y)
             10 -> get >>= \(x,y)   -> return (Abs x y)
             11 -> get >>= \x       -> return (Meta x)
             12 -> get >>= \(x,y,z) -> return (Prod x y z)
             13 -> get >>= \x       -> return (Eqs x)
             14 -> get >>= \(x,y)   -> return (Typed x y)
             15 -> get >>= \(x,y)   -> return (Example x y)
             16 -> get >>= \x       -> return (RecType x)
             17 -> get >>= \x       -> return (R x)
             18 -> get >>= \(x,y)   -> return (P x y)
             19 -> get >>= \(x,y,z) -> return (PI x y z)
             20 -> get >>= \(x,y)   -> return (ExtR x y)
             21 -> get >>= \(x,y)   -> return (Table x y)
             22 -> get >>= \(x,y)   -> return (T x y)
             23 -> get >>= \(x,y)   -> return (TSh x y)
             24 -> get >>= \(x,y)   -> return (V x y)
             25 -> get >>= \(x,y)   -> return (S x y)
             26 -> get >>= \(x,y,z) -> return (Val x y z)
             27 -> get >>= \(x,y)   -> return (Let x y)
             28 -> get >>= \(x,y,z) -> return (Alias x y z)
             29 -> get >>= \(x,y)   -> return (Q  x y)
             30 -> get >>= \(x,y)   -> return (QC x y)
             31 -> get >>= \(x,y)   -> return (C x y)
             32 -> get >>= \(x,y)   -> return (Glue x y)
             33 -> get >>= \x       -> return (EPatt x)
             34 -> get >>= \x       -> return (EPattType x)
             35 -> get >>= \x       -> return (FV x)
             36 -> get >>= \x       -> return (Alts x)
             37 -> get >>= \x       -> return (Strs x)

instance Binary Patt where
  put (PC x y)     = putWord8  0 >> put (x,y)
  put (PP x y z)   = putWord8  1 >> put (x,y,z)
  put (PV x)       = putWord8  2 >> put x
  put (PW)         = putWord8  3
  put (PR x)       = putWord8  4 >> put x
  put (PString x)  = putWord8  5 >> put x
  put (PInt    x)  = putWord8  6 >> put x
  put (PFloat  x)  = putWord8  7 >> put x
  put (PT x y)     = putWord8  8 >> put (x,y)
  put (PVal x y z) = putWord8  9 >> put (x,y,z)
  put (PAs  x y)   = putWord8 10 >> put (x,y)
  put (PNeg x)     = putWord8 11 >> put x
  put (PAlt x y)   = putWord8 12 >> put (x,y)
  put (PSeq x y)   = putWord8 13 >> put (x,y)
  put (PRep x)     = putWord8 14 >> put x
  put (PChar)      = putWord8 15
  put (PChars x)   = putWord8 16 >> put x
  put (PMacro x)   = putWord8 17 >> put x
  put (PM x y)     = putWord8 18 >> put (x,y)
  get = do tag <- getWord8
           case tag of
             0  -> get >>= \(x,y)   -> return (PC x y)
             1  -> get >>= \(x,y,z) -> return (PP x y z)
             2  -> get >>= \x       -> return (PV x)
             3  ->                     return (PW)
             4  -> get >>= \x       -> return (PR x)
             5  -> get >>= \x       -> return (PString x)
             6  -> get >>= \x       -> return (PInt    x)
             7  -> get >>= \x       -> return (PFloat  x)
             8  -> get >>= \(x,y)   -> return (PT x y)
             9  -> get >>= \(x,y,z) -> return (PVal x y z)
             10 -> get >>= \(x,y)   -> return (PAs  x y)
             11 -> get >>= \x       -> return (PNeg x)
             12 -> get >>= \(x,y)   -> return (PAlt x y)
             13 -> get >>= \(x,y)   -> return (PSeq x y)
             14 -> get >>= \x       -> return (PRep x)
             15 ->                     return (PChar)
             16 -> get >>= \x       -> return (PChars x)
             17 -> get >>= \x       -> return (PMacro x)
             18 -> get >>= \(x,y)   -> return (PM x y)

instance (Binary a, Binary b) => Binary (Perhaps a b) where
  put (Yes x) = putWord8 0 >> put x
  put (May y) = putWord8 1 >> put y
  put Nope    = putWord8 2
  get = do tag <- getWord8
           case tag of
             0 -> fmap Yes get
             1 -> fmap May get
             2 -> return Nope

instance Binary TInfo where
  put TRaw       = putWord8 0
  put (TTyped t) = putWord8 1 >> put t
  put (TComp  t) = putWord8 2 >> put t
  put (TWild  t) = putWord8 3 >> put t
  get = do tag <- getWord8
           case tag of
             0 -> return TRaw
             1 -> fmap TTyped get
             2 -> fmap TComp  get
             3 -> fmap TWild  get

instance Binary Label where
  put (LIdent bs) = putWord8 0 >> put bs
  put (LVar i)    = putWord8 1 >> put i
  get = do tag <- getWord8
           case tag of
             0 -> fmap LIdent get
             1 -> fmap LVar   get

instance Binary MetaSymb where
  put (MetaSymb m) = put m
  get = fmap MetaSymb get

decodeModHeader :: FilePath -> IO SourceModule
decodeModHeader fpath = do
  (m,mtype,mstatus,flags,extend,mwith,opens,med) <- decodeFile fpath
  return (m,ModInfo mtype mstatus flags extend mwith opens med Map.empty Map.empty)
