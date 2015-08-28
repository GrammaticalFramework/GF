-- | Read PGF files created with GF 3.5 and a few older releases
module PGF.OldBinary(getPGF,getPGF',version) where

import PGF.CId
import PGF.Data
import PGF.Optimize
import Data.Binary
import Data.Binary.Get
import Data.Array.IArray
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import qualified Data.Set as Set
import Control.Monad

pgfMajorVersion, pgfMinorVersion :: Word16
version@(pgfMajorVersion, pgfMinorVersion) = (1,0)

getPGF = do v1 <- getWord16be
            v2 <- getWord16be
            let v=(v1,v2)
            if v==version 
              then getPGF'
              else decodingError ("version "++show v++"/="++show version)

getPGF'=do gflags <- getFlags
           absname <- getCId
           abstract <- getAbstract
           concretes <- getMap getCId getConcr
           return $ updateProductionIndices $
                      (PGF{ gflags=gflags
                          , absname=absname, abstract=abstract
                          , concretes=concretes
                          })

getCId = liftM CId get

getAbstract =
        do aflags <- getFlags
           funs <- getMap getCId getFun
           cats <- getMap getCId getCat
           return (Abstr{ aflags=aflags
                        , funs=fmap (\(w,x,y,z) -> (w,x,fmap (flip (,) []) y,z)) funs
                        , cats=fmap (\(x,y) -> (x,y,0)) cats
                        })
getFun :: Get (Type,Int,Maybe [Equation],Double)
getFun = (,,,) `fmap` getType `ap` get `ap` getMaybe (getList getEquation) `ap` get

getCat :: Get ([Hypo],[(Double, CId)])
getCat = getPair (getList getHypo) (getList (getPair get getCId))

getFlags = getMap getCId getLiteral

getConcr =
        do cflags      <- getFlags
           printnames  <- getMap getCId get
           (scnt,seqs) <- getList' getSequence
           (fcnt,cncfuns) <- getList' getCncFun
           lindefs     <- get
           productions <- getIntMap (getSet getProduction)
           cnccats     <- getMap getCId getCncCat
           totalCats   <- get
           let rseq    = listToArray [SymCat 0 0]
               rfun    = CncFun (mkCId "linref") (listToArray [scnt])
               linrefs = IntMap.fromList [(i,[fcnt])|i<-[0..totalCats-1]]
           return (Concr{ cflags=cflags, printnames=printnames
                        , sequences=toArray (scnt+1,seqs++[rseq])
                        , cncfuns=toArray (fcnt+1,cncfuns++[rfun])
                        , lindefs=lindefs, linrefs=linrefs
                        , productions=productions
                        , pproductions = IntMap.empty
                        , lproductions = Map.empty
                        , lexicon = IntMap.empty
                        , cnccats=cnccats, totalCats=totalCats
                        })

getExpr =
        do tag <- getWord8
           case tag of
             0 -> liftM3 EAbs getBindType getCId getExpr
             1 -> liftM2 EApp getExpr getExpr
             2 -> liftM  ELit getLiteral
             3 -> liftM  EMeta get
             4 -> liftM  EFun getCId
             5 -> liftM  EVar get
             6 -> liftM2 ETyped getExpr getType
             7 -> liftM  EImplArg getExpr
             _ -> decodingError "getExpr"

getPatt =
        do tag <- getWord8
           case tag of
             0 -> liftM2 PApp getCId (getList getPatt)
             1 -> liftM  PVar getCId
             2 -> liftM2 PAs getCId getPatt
             3 -> return PWild
             4 -> liftM  PLit getLiteral
             5 -> liftM  PImplArg getPatt
             6 -> liftM  PTilde getExpr
             _ -> decodingError "getPatt"

getEquation = liftM2 Equ (getList getPatt) getExpr

getType = liftM3 DTyp (getList getHypo) getCId (getList getExpr)
getHypo = (,,) `fmap` getBindType `ap` getCId `ap` getType

getBindType =
        do tag <- getWord8
           case tag of
             0 -> return Explicit
             1 -> return Implicit
             _ -> decodingError "getBindType"

getCncFun = liftM2 CncFun getCId (getArray get)

getCncCat = liftM3 CncCat get get (getArray get)

getSequence = listToArray `fmap` getSymbols

getSymbols = concat `fmap` getList getSymbol

getSymbol :: Get [Symbol]
getSymbol =
        do tag <- getWord8
           case tag of
             0 -> (:[]) `fmap` liftM2 SymCat get get
             1 -> (:[]) `fmap` liftM2 SymLit get get
             2 -> (:[]) `fmap` liftM2 SymVar get get
             3 -> liftM  (map SymKS) get
             4 -> (:[]) `fmap` liftM2 SymKP (getList getTokenSymbol) getAlternatives
             _ -> decodingError ("getSymbol "++show tag)

getAlternatives = getList (getPair (getList getTokenSymbol) get)
                  :: Get [([Symbol],[String])]
getTokenSymbol = fmap SymKS get

--getTokens = unwords `fmap` get

getPArg = get >>= \(hypos,fid) -> return (PArg (zip (repeat fidVar) hypos) fid)

getProduction =
        do tag <- getWord8
           case tag of
             0 -> liftM2 PApply  get (getList getPArg)
             1 -> liftM  PCoerce get
             _ -> decodingError "getProduction"

getLiteral =
        do tag <- getWord8
           case tag of
             0 -> liftM  LStr get
             1 -> liftM  LInt get
             2 -> liftM  LFlt get
             _ -> decodingError "getLiteral"


getArray :: IArray a e => Get e -> Get (a Int e)
getArray get1 = toArray `fmap` getList' get1

toArray (n,xs) = listArray (0::Int,n-1) xs
listToArray xs = toArray (length xs,xs)

--getArray2 :: (IArray a1 (a2 Int e), IArray a2 e) => Get e -> Get (a1 Int (a2 Int e))
--getArray2 get1 = getArray (getArray get1)

getList get1 = snd `fmap` getList' get1

getList' get1 = do n <- get :: Get Int
                   xs <- replicateM n get1
                   return (n,xs)

getMaybe get1 =
    do isJust <- get
       if isJust then fmap Just get1 else return Nothing

getMap getK getV = Map.fromDistinctAscList `fmap` getList (getPair getK getV)
getIntMap getV = IntMap.fromDistinctAscList `fmap` getList (getPair get getV)
getSet getV = Set.fromDistinctAscList `fmap` getList getV

getPair get1 get2 = (,) `fmap` get1 `ap` get2

decodingError explain = fail $ "Unable to read PGF file ("++explain++")"
