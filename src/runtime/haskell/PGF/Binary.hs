module PGF.Binary where

import PGF.CId
import PGF.Data
import PGF.Macros
import Data.Binary
import Data.Binary.Put
import Data.Binary.Get
import Data.Array.IArray
import qualified Data.ByteString as BS
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import qualified Data.Set as Set
import Control.Monad

pgfMajorVersion, pgfMinorVersion :: Word16
(pgfMajorVersion, pgfMinorVersion) = (1,0)

instance Binary PGF where
  put pgf = do putWord16be pgfMajorVersion
               putWord16be pgfMinorVersion
               put (gflags pgf)
               put (absname pgf, abstract pgf)
               put (concretes pgf)
  get = do v1 <- getWord16be
           v2 <- getWord16be
           gflags <- get
           (absname,abstract) <- get
           concretes <- get
           return $ updateProductionIndices $
                      (PGF{ gflags=gflags
                          , absname=absname, abstract=abstract
                          , concretes=concretes
                          })

instance Binary CId where
  put (CId bs) = put bs
  get    = liftM CId get

instance Binary Abstr where
  put abs = put (aflags abs, funs abs, cats abs)
  get = do aflags <- get
           funs <- get
           cats <- get
           return (Abstr{ aflags=aflags
                        , funs=funs, cats=cats
                        , catfuns=Map.empty
                        })
  
instance Binary Concr where
  put cnc = do put (cflags cnc)
               put (printnames cnc)
               putArray2 (sequences cnc)
               putArray (cncfuns cnc)
               put (productions cnc)
               put (cnccats cnc)
               put (totalCats cnc)
  get = do cflags      <- get
           printnames  <- get
           sequences   <- getArray2
           cncfuns     <- getArray
           productions <- get
           cnccats     <- get
           totalCats   <- get
           return (Concr{ cflags=cflags, printnames=printnames
                        , sequences=sequences, cncfuns=cncfuns, productions=productions
                        , pproductions = IntMap.empty
                        , lproductions = Map.empty
                        , cnccats=cnccats, totalCats=totalCats
                        })

instance Binary Alternative where
  put (Alt v x) = put (v,x)
  get = liftM2 Alt get get

instance Binary Term where
  put (R  es) = putWord8 0 >> put es
  put (S  es) = putWord8 1 >> put es
  put (FV es) = putWord8 2 >> put es
  put (P e v) = putWord8 3 >> put (e,v)
  put (W e v) = putWord8 4 >> put (e,v)
  put (C i  ) = putWord8 5 >> put i
  put (TM i ) = putWord8 6 >> put i
  put (F f)   = putWord8 7 >> put f
  put (V i)   = putWord8 8 >> put i
  put (K (KS s))    = putWord8 9  >> put s
  put (K (KP d vs)) = putWord8 10 >> put (d,vs)

  get = do tag <- getWord8
           case tag of
             0 -> liftM  R  get
             1 -> liftM  S  get
             2 -> liftM  FV get
             3 -> liftM2 P  get get
             4 -> liftM2 W  get get
             5 -> liftM  C  get
             6 -> liftM  TM get
             7 -> liftM  F  get
             8 -> liftM  V  get
             9  -> liftM  (K . KS) get
             10 -> liftM2 (\d vs -> K (KP d vs)) get get
             _  -> decodingError

instance Binary Expr where
  put (EAbs b x exp)  = putWord8 0 >> put (b,x,exp)
  put (EApp e1 e2)    = putWord8 1 >> put (e1,e2)
  put (ELit l)        = putWord8 2 >> put l
  put (EMeta i)       = putWord8 3 >> put i
  put (EFun  f)       = putWord8 4 >> put f
  put (EVar  i)       = putWord8 5 >> put i
  put (ETyped e ty)   = putWord8 6 >> put (e,ty)
  put (EImplArg e)    = putWord8 7 >> put e
  get = do tag <- getWord8
           case tag of
             0 -> liftM3 EAbs get get get
             1 -> liftM2 EApp get get
             2 -> liftM  ELit get
             3 -> liftM  EMeta get
             4 -> liftM  EFun get
             5 -> liftM  EVar get
             6 -> liftM2 ETyped get get
             7 -> liftM  EImplArg get
             _ -> decodingError

instance Binary Patt where
  put (PApp f ps)  = putWord8 0 >> put (f,ps)
  put (PVar   x)   = putWord8 1 >> put x
  put PWild        = putWord8 2
  put (PLit l)     = putWord8 3 >> put l
  put (PImplArg p) = putWord8 4 >> put p
  get = do tag <- getWord8
           case tag of
             0 -> liftM2 PApp get get
             1 -> liftM  PVar get
             2 -> return PWild
             3 -> liftM  PLit get
             4 -> liftM  PImplArg get
             _ -> decodingError

instance Binary Equation where
  put (Equ ps e) = put (ps,e)
  get = liftM2 Equ get get

instance Binary Type where
  put (DTyp hypos cat exps) = put (hypos,cat,exps)
  get = liftM3 DTyp get get get

instance Binary BindType where
  put Explicit = putWord8 0
  put Implicit = putWord8 1
  get = do tag <- getWord8
           case tag of
             0 -> return Explicit
             1 -> return Implicit
             _ -> decodingError

instance Binary CncFun where
  put (CncFun fun lins) = put fun >> putArray lins
  get = liftM2 CncFun get getArray

instance Binary CncCat where
  put (CncCat s e labels) = do put (s,e)
                               putArray labels
  get = liftM3 CncCat get get getArray

instance Binary Symbol where
  put (SymCat n l)       = putWord8 0 >> put (n,l)
  put (SymLit n l)       = putWord8 1 >> put (n,l)
  put (SymKS ts)         = putWord8 2 >> put ts
  put (SymKP d vs)       = putWord8 3 >> put (d,vs)
  get = do tag <- getWord8
           case tag of
             0 -> liftM2 SymCat get get
             1 -> liftM2 SymLit get get
             2 -> liftM  SymKS  get
             3 -> liftM2 (\d vs -> SymKP d vs) get get
             _ -> decodingError

instance Binary Production where
  put (PApply ruleid args) = putWord8 0 >> put (ruleid,args)
  put (PCoerce fcat)       = putWord8 1 >> put fcat
  get = do tag <- getWord8
           case tag of
             0 -> liftM2 PApply  get get
             1 -> liftM  PCoerce get
             _ -> decodingError

instance Binary Literal where
  put (LStr s) = putWord8 0 >> put s
  put (LInt i) = putWord8 1 >> put i
  put (LFlt d) = putWord8 2 >> put d
  get = do tag <- getWord8
           case tag of
             0 -> liftM  LStr get
             1 -> liftM  LFlt get
             2 -> liftM  LInt get
             _ -> decodingError


putArray :: (Binary e, IArray a e) => a Int e -> Put
putArray a = do put (rangeSize $ bounds a) -- write the length
                mapM_ put (elems a)        -- now the elems.

getArray :: (Binary e, IArray a e) => Get (a Int e)
getArray = do n  <- get                  -- read the length
              xs <- replicateM n get     -- now the elems.
              return (listArray (0,n-1) xs)

putArray2 :: (Binary e, IArray a1 (a2 Int e), IArray a2 e) => a1 Int (a2 Int e) -> Put
putArray2 a = do put (rangeSize $ bounds a) -- write the length
                 mapM_ putArray (elems a)        -- now the elems.

getArray2 :: (Binary e, IArray a1 (a2 Int e), IArray a2 e) => Get (a1 Int (a2 Int e))
getArray2 = do n  <- get                       -- read the length
               xs <- replicateM n getArray     -- now the elems.
               return (listArray (0,n-1) xs)

decodingError = fail "This PGF file was compiled with different version of GF"
