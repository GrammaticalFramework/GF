module PGF.Binary where

import PGF.CId
import PGF.Data
import Data.Binary
import Data.Binary.Put
import Data.Binary.Get
import qualified Data.ByteString as BS
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import qualified Data.Set as Set
import Control.Monad

pgfMajorVersion, pgfMinorVersion :: Word16
(pgfMajorVersion, pgfMinorVersion) = (1,0)

instance Binary PGF where
  put pgf = putWord16be pgfMajorVersion >>
            putWord16be pgfMinorVersion >>
            put ( absname pgf, cncnames pgf
                , gflags pgf
                , abstract pgf, concretes pgf
                )
  get = do v1 <- getWord16be
           v2 <- getWord16be
           absname <- get
           cncnames <- get
           gflags <- get
           abstract <- get
           concretes <- get
           return (PGF{ absname=absname, cncnames=cncnames
                      , gflags=gflags
                      , abstract=abstract, concretes=concretes
                      })

instance Binary CId where
  put (CId bs) = put bs
  get    = liftM CId get

instance Binary Abstr where
  put abs = put (aflags abs, funs abs, cats abs)
  get = do aflags <- get
           funs <- get
           cats <- get
           let catfuns = Map.mapWithKey (\cat _ -> [f | (f, (DTyp _ c _,_,_)) <- Map.toList funs, c==cat]) cats
           return (Abstr{ aflags=aflags
                        , funs=funs, cats=cats
                        , catfuns=catfuns
                        })
  
instance Binary Concr where
  put cnc = put ( cflags cnc, lins cnc, opers cnc
                , lincats cnc, lindefs cnc
                , printnames cnc, paramlincats cnc
                , parser cnc
                )
  get = do cflags <- get
           lins <- get
           opers <- get
           lincats <- get
           lindefs <- get
           printnames <- get
           paramlincats <- get
           parser <- get
           return (Concr{ cflags=cflags, lins=lins, opers=opers
                        , lincats=lincats, lindefs=lindefs
                        , printnames=printnames
                        , paramlincats=paramlincats
                        , parser=parser
                        })

instance Binary Alternative where
  put (Alt v x) = put v >> put x
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
  put (ELit (LStr s)) = putWord8 2 >> put s
  put (ELit (LFlt d)) = putWord8 3 >> put d
  put (ELit (LInt i)) = putWord8 4 >> put i
  put (EMeta i)       = putWord8 5 >> put i
  put (EFun  f)       = putWord8 6 >> put f
  put (EVar  i)       = putWord8 7 >> put i
  put (ETyped e ty)   = putWord8 8 >> put (e,ty)
  get = do tag <- getWord8
           case tag of
             0 -> liftM3 EAbs get get get
             1 -> liftM2 EApp get get
             2 -> liftM  (ELit . LStr) get
             3 -> liftM  (ELit . LFlt) get
             4 -> liftM  (ELit . LInt) get
             5 -> liftM  EMeta get
             6 -> liftM  EFun get
             7 -> liftM  EVar get
             8 -> liftM2 ETyped get get
             _ -> decodingError

instance Binary Patt where
  put (PApp f ps)     = putWord8 0 >> put (f,ps)
  put (PVar   x)      = putWord8 1 >> put x
  put PWild           = putWord8 2
  put (PLit (LStr s)) = putWord8 3 >> put s
  put (PLit (LFlt d)) = putWord8 4 >> put d
  put (PLit (LInt i)) = putWord8 5 >> put i
  get = do tag <- getWord8
           case tag of
             0 -> liftM2 PApp get get
             1 -> liftM  PVar get
             2 -> return PWild
             3 -> liftM  (PLit . LStr) get
             4 -> liftM  (PLit . LFlt) get
             5 -> liftM  (PLit . LInt) get
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

instance Binary FFun where
  put (FFun fun prof lins) = put (fun,prof,lins)
  get = liftM3 FFun get get get

instance Binary FSymbol where
  put (FSymCat n l)       = putWord8 0 >> put (n,l)
  put (FSymLit n l)       = putWord8 1 >> put (n,l)
  put (FSymKS ts)         = putWord8 2 >> put ts
  put (FSymKP d vs)       = putWord8 3 >> put (d,vs)
  get = do tag <- getWord8
           case tag of
             0 -> liftM2 FSymCat get get
             1 -> liftM2 FSymLit get get
             2 -> liftM  FSymKS  get
             3 -> liftM2 (\d vs -> FSymKP d vs) get get
             _ -> decodingError

instance Binary Production where
  put (FApply ruleid args) = putWord8 0 >> put (ruleid,args)
  put (FCoerce fcat)       = putWord8 1 >> put fcat
  get = do tag <- getWord8
           case tag of
             0 -> liftM2 FApply  get get
             1 -> liftM  FCoerce get
             _ -> decodingError

instance Binary ParserInfo where
  put p = put (functions p, sequences p, productions0 p, totalCats p, startCats p)
  get = do functions   <- get
           sequences   <- get
           productions0<- get
           totalCats   <- get
           startCats   <- get
           return (ParserInfo{functions=functions,sequences=sequences
                             ,productions0=productions0
                             ,productions =filterProductions productions0
                             ,totalCats=totalCats,startCats=startCats})

decodingError = fail "This PGF file was compiled with different version of GF"
