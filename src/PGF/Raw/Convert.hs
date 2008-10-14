module PGF.Raw.Convert (toPGF,fromPGF) where

import PGF.CId
import PGF.Data
import PGF.Raw.Abstract
import qualified GF.Compile.GeneratePMCFG as PMCFG

import Data.Array.IArray
import qualified Data.Map    as Map
import qualified Data.Set    as Set
import qualified Data.IntMap as IntMap

pgfMajorVersion, pgfMinorVersion :: Integer
(pgfMajorVersion, pgfMinorVersion) = (1,0)

-- convert parsed grammar to internal PGF

toPGF :: Grammar -> PGF
toPGF (Grm [
  App "pgf" (AInt v1 : AInt v2 : App a []:cs),
  App "flags"     gfs, 
  ab@(
    App "abstract" [
      App "fun"   fs,
      App "cat"   cts
      ]), 
  App "concrete" ccs
  ]) = let pgf = PGF {
    absname = mkCId a,
    cncnames = [mkCId c | App c [] <- cs],
    gflags = Map.fromAscList [(mkCId f,v) | App f [AStr v] <- gfs],
    abstract = 
     let
      aflags  = Map.fromAscList [(mkCId f,v) | App f [AStr v] <- gfs]
      lfuns   = [(mkCId f,(toType typ,toExp def)) | App f [typ, def] <- fs]
      funs    = Map.fromAscList lfuns
      lcats   = [(mkCId c, Prelude.map toHypo hyps) | App c hyps <- cts]
      cats    = Map.fromAscList lcats
      catfuns = Map.fromAscList 
        [(cat,[f | (f, (DTyp _ c _,_)) <- lfuns, c==cat]) | (cat,_) <- lcats]
     in Abstr aflags funs cats catfuns,
    concretes = Map.fromAscList [(mkCId lang, toConcr pgf ts) | App lang ts <- ccs]
    }
    in pgf
 where

toConcr :: PGF -> [RExp] -> Concr
toConcr pgf rexp = 
  let cnc = foldl add (Concr {cflags       = Map.empty,
                              lins         = Map.empty,
                              opers        = Map.empty,
                              lincats      = Map.empty,
                              lindefs      = Map.empty,
                              printnames   = Map.empty,
                              paramlincats = Map.empty,
                              parser       = Just (PMCFG.convertConcrete (abstract pgf) cnc)
                                                                              -- This thunk will be overwritten if there is a parser
                                                                              -- compiled in the PGF file. We use lazy evaluation here
                                                                              -- to make sure that buildParserOnDemand is called only
                                                                              -- if it is needed.
                             }) rexp
  in cnc
  where
    add :: Concr -> RExp -> Concr
    add cnc (App "flags" ts)     = cnc { cflags = Map.fromAscList [(mkCId f,v) | App f [AStr v] <- ts] }
    add cnc (App "lin" ts)       = cnc { lins = mkTermMap ts }
    add cnc (App "oper" ts)      = cnc { opers = mkTermMap ts }
    add cnc (App "lincat" ts)    = cnc { lincats = mkTermMap ts }
    add cnc (App "lindef" ts)    = cnc { lindefs = mkTermMap ts }
    add cnc (App "printname" ts) = cnc { printnames = mkTermMap ts }
    add cnc (App "param" ts)     = cnc { paramlincats = mkTermMap ts }
    add cnc (App "parser" ts)    = cnc { parser = Just (toPInfo ts) }

toPInfo :: [RExp] -> ParserInfo
toPInfo [App "functions" fs, App "sequences" ss, App "productions" ps,App "startcats" cs] = 
  ParserInfo { functions   = functions
             , sequences   = seqs
	     , productions = productions
	     , startCats   = cats
	     }
  where 
    functions   = mkArray (map toFFun fs)
    seqs        = mkArray (map toFSeq ss)
    productions = IntMap.fromList (map toProductionSet ps)
    cats        = Map.fromList [(mkCId c, (map expToInt xs)) | App c xs <- cs]

    toFFun :: RExp -> FFun
    toFFun (App f [App "P" ts,App "R" ls]) = FFun fun prof lins
      where
        fun  = mkCId f
        prof = map toProfile ts
        lins = mkArray [fromIntegral seqid | AInt seqid <- ls]

    toProfile :: RExp -> Profile
    toProfile AMet           = []
    toProfile (App "_A" [t]) = [expToInt t]
    toProfile (App "_U" ts)  = [expToInt t | App "_A" [t] <- ts]

    toFSeq :: RExp -> FSeq
    toFSeq (App "seq" ss) = mkArray [toSymbol s | s <- ss]

    toProductionSet :: RExp -> (FCat,Set.Set Production)
    toProductionSet (App "td" (rt : xs)) = (expToInt rt, Set.fromList (map toProduction xs))
      where 
        toProduction (App "A" (ruleid : at)) = FApply (expToInt ruleid) (map expToInt at)
        toProduction (App "C" [fcat])        = FCoerce (expToInt fcat)

toSymbol :: RExp -> FSymbol
toSymbol (App "P" [n,l]) = FSymCat (expToInt n) (expToInt l)
toSymbol (App "KP" (d:alts)) = FSymTok (toKP d alts)
toSymbol (AStr t) = FSymTok (KS t)

toType :: RExp -> Type
toType e = case e of
  App cat [App "H" hypos, App "X" exps] -> 
    DTyp (map toHypo hypos) (mkCId cat) (map toExp exps) 
  _ -> error $ "type " ++ show e

toHypo :: RExp -> Hypo
toHypo e = case e of
  App x [typ] -> Hyp (mkCId x) (toType typ)
  _ -> error $ "hypo " ++ show e

toExp :: RExp -> Expr
toExp e = case e of
  App "Abs" [App x [], exp] -> EAbs (mkCId x) (toExp exp)
  App "App" [e1,e2] -> EApp (toExp e1) (toExp e2)
  App "Eq" eqs -> EEq [Equ (map toExp ps) (toExp v) | App "E" (v:ps) <- eqs]
  App "Var" [App i []] -> EVar (mkCId i)
  AMet   -> EMeta  0
  AInt i -> ELit (LInt i)
  AFlt i -> ELit (LFlt i)
  AStr i -> ELit (LStr i)
  _ -> error $ "exp " ++ show e

toTerm :: RExp -> Term
toTerm e = case e of
  App "R" es    -> R  (map toTerm es)
  App "S" es    -> S  (map toTerm es)
  App "FV" es   -> FV (map toTerm es)
  App "P" [e,v] -> P  (toTerm e) (toTerm v)
  App "W" [AStr s,v] -> W s (toTerm v)
  App "A" [AInt i] -> V (fromInteger i)
  App f []  -> F (mkCId f)
  AInt i -> C (fromInteger i)
  AMet   -> TM "?"
  App "KP" (d:alts) -> K (toKP d alts)
  AStr s -> K (KS s)
  _ -> error $ "term " ++ show e
  
toKP d alts = KP (toStr d) (map toAlt alts)
  where
    toStr (App "S" vs) = [v | AStr v <- vs]
    toAlt (App "A" [x,y]) = Alt (toStr x) (toStr y)


------------------------------
--- from internal to parser --
------------------------------

fromPGF :: PGF -> Grammar
fromPGF pgf = Grm [
  App "pgf" (AInt pgfMajorVersion:AInt pgfMinorVersion
             : App (prCId (absname pgf)) [] : map (flip App [] . prCId) (cncnames pgf)), 
  App "flags" [App (prCId f) [AStr v] | (f,v) <- Map.toList (gflags pgf `Map.union` aflags apgf)],
  App "abstract" [
    App "fun"   [App (prCId f) [fromType t,fromExp d] | (f,(t,d)) <- Map.toList (funs apgf)],
    App "cat"   [App (prCId f) (map fromHypo hs) | (f,hs) <- Map.toList (cats apgf)]
    ],
  App "concrete" [App (prCId lang) (fromConcrete c) | (lang,c) <- Map.toList (concretes pgf)]
  ]
 where
  apgf = abstract pgf
  fromConcrete cnc = [
      App "flags"     [App (prCId f) [AStr v]     | (f,v) <- Map.toList (cflags cnc)],
      App "lin"       [App (prCId f) [fromTerm v] | (f,v) <- Map.toList (lins cnc)],
      App "oper"      [App (prCId f) [fromTerm v] | (f,v) <- Map.toList (opers cnc)],
      App "lincat"    [App (prCId f) [fromTerm v] | (f,v) <- Map.toList (lincats cnc)],
      App "lindef"    [App (prCId f) [fromTerm v] | (f,v) <- Map.toList (lindefs cnc)],
      App "printname" [App (prCId f) [fromTerm v] | (f,v) <- Map.toList (printnames cnc)],
      App "param"     [App (prCId f) [fromTerm v] | (f,v) <- Map.toList (paramlincats cnc)]
     ] ++ maybe [] (\p -> [fromPInfo p]) (parser cnc)

fromType :: Type -> RExp
fromType e = case e of
  DTyp hypos cat exps -> 
    App (prCId cat) [
      App "H" (map fromHypo hypos), 
      App "X" (map fromExp exps)] 

fromHypo :: Hypo -> RExp
fromHypo e = case e of
  Hyp x typ -> App (prCId x) [fromType typ]

fromExp :: Expr -> RExp
fromExp e = case e of
  EAbs x exp   -> App "Abs" [App (prCId x) [], fromExp exp]
  EApp e1 e2 -> App "App" [fromExp e1, fromExp e2]
  EVar   x -> App "Var" [App (prCId x) []]
  ELit (LStr s) -> AStr s
  ELit (LFlt d) -> AFlt d
  ELit (LInt i) -> AInt (toInteger i)
  EMeta _  -> AMet ----
  EEq eqs  -> App "Eq" [App "E" (map fromExp (v:ps)) | Equ ps v <- eqs]

fromTerm :: Term -> RExp
fromTerm e = case e of
  R es    -> App "R" (map fromTerm es)
  S es    -> App "S" (map fromTerm es)
  FV es   -> App "FV" (map fromTerm es)
  P e v   -> App "P"  [fromTerm e, fromTerm v]
  W s v   -> App "W" [AStr s, fromTerm v]
  C i     -> AInt (toInteger i)
  TM _    -> AMet
  F f     -> App (prCId f) []
  V i     -> App "A" [AInt (toInteger i)]
  K t     -> fromTokn t

fromTokn :: Tokn -> RExp
fromTokn (KS s)    = AStr s
fromTokn (KP d vs) = App "KP" (str d : [App "A" [str v, str x] | Alt v x <- vs])
 where
   str v = App "S" (map AStr v)

-- ** Parsing info

fromPInfo :: ParserInfo -> RExp
fromPInfo p = App "parser" [
          App "functions"   [fromFFun fun | fun <- elems (functions p)],
          App "sequences"   [fromFSeq seq | seq <- elems (sequences p)],
          App "productions" [fromProductionSet xs  | xs <- IntMap.toList (productions p)],
          App "startcats"   [App (prCId f) (map intToExp xs) | (f,xs) <- Map.toList (startCats p)]
        ]

fromFFun :: FFun -> RExp
fromFFun (FFun fun prof lins) = App (prCId fun) [App "P" (map fromProfile prof), App "R" [intToExp seqid | seqid <- elems lins]]
  where
    fromProfile :: Profile -> RExp
    fromProfile []   = AMet
    fromProfile [x]  = daughter x
    fromProfile args = App "_U" (map daughter args)
    
    daughter n = App "_A" [intToExp n]

fromSymbol :: FSymbol -> RExp
fromSymbol (FSymCat n l) = App "P" [intToExp n, intToExp l]
fromSymbol (FSymTok t)   = fromTokn t

fromFSeq :: FSeq -> RExp
fromFSeq seq = App "seq" [fromSymbol s | s <- elems seq]

fromProductionSet :: (FCat,Set.Set Production) -> RExp
fromProductionSet (cat,xs) = App "td" (intToExp cat : map fromPassive (Set.toList xs))
  where
    fromPassive (FApply ruleid args) = App "A" (intToExp ruleid : map intToExp args)
    fromPassive (FCoerce fcat)       = App "C" [intToExp fcat]

-- ** Utilities

mkTermMap :: [RExp] -> Map.Map CId Term
mkTermMap ts = Map.fromAscList [(mkCId f,toTerm v) | App f [v] <- ts]

mkArray :: IArray a e => [e] -> a Int e
mkArray xs = listArray (0, length xs - 1) xs

expToInt :: Integral a => RExp -> a
expToInt (App "neg" [AInt i]) = fromIntegral (negate i)
expToInt (AInt i) = fromIntegral i

expToStr :: RExp -> String
expToStr (AStr s) = s

intToExp :: Integral a => a -> RExp
intToExp x | x < 0 = App "neg" [AInt (fromIntegral (negate x))]
           | otherwise =  AInt (fromIntegral x)
