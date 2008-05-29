module PGF.Raw.Convert (toGFCC,fromGFCC) where

import PGF.CId
import PGF.Data
import PGF.Raw.Abstract
import PGF.BuildParser (buildParserInfo)
import PGF.Parsing.FCFG.Utilities

import qualified Data.Array as Array
import qualified Data.Map   as Map

pgfMajorVersion, pgfMinorVersion :: Integer
(pgfMajorVersion, pgfMinorVersion) = (1,0)

-- convert parsed grammar to internal GFCC

toGFCC :: Grammar -> GFCC
toGFCC (Grm [
  App "pgf" (AInt v1 : AInt v2 : App a []:cs),
  App "flags"     gfs, 
  ab@(
    App "abstract" [
      App "fun"   fs,
      App "cat"   cts
      ]), 
  App "concrete" ccs
  ]) = GFCC {
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
    concretes = Map.fromAscList [(mkCId lang, toConcr ts) | App lang ts <- ccs]
    }
 where

toConcr :: [RExp] -> Concr
toConcr = foldl add (Concr {
               cflags       = Map.empty,
               lins         = Map.empty,
               opers        = Map.empty,
               lincats      = Map.empty,
               lindefs      = Map.empty,
               printnames   = Map.empty,
               paramlincats = Map.empty,
               parser       = Nothing
             })
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
toPInfo [App "rules" rs, App "startupcats" cs] = buildParserInfo (rules, cats)
  where 
    rules = map toFRule rs
    cats = Map.fromList [(mkCId c, map expToInt fs) | App c fs <- cs]

    toFRule :: RExp -> FRule
    toFRule (App "rule"
              [n,                      
               App "cats" (rt:at),
               App "R" ls]) = FRule fun prof args res lins
      where 
        (fun,prof) = toFName n
        args = map expToInt at
        res  = expToInt rt
        lins = mkArray [mkArray [toSymbol s | s <- l] | App "S" l <- ls]

toFName :: RExp -> (CId,[Profile])
toFName (App "_A" [x]) = (wildCId, [[expToInt x]])
toFName (App f ts)     = (mkCId f, map toProfile ts)
    where
      toProfile :: RExp -> Profile
      toProfile AMet           = []
      toProfile (App "_A" [t]) = [expToInt t]
      toProfile (App "_U" ts)  = [expToInt t | App "_A" [t] <- ts]

toSymbol :: RExp -> FSymbol
toSymbol (App "P" [n,l]) = FSymCat (expToInt l) (expToInt n)
toSymbol (AStr t) = FSymTok t

toType :: RExp -> Type
toType e = case e of
  App cat [App "H" hypos, App "X" exps] -> 
    DTyp (map toHypo hypos) (mkCId cat) (map toExp exps) 
  _ -> error $ "type " ++ show e

toHypo :: RExp -> Hypo
toHypo e = case e of
  App x [typ] -> Hyp (mkCId x) (toType typ)
  _ -> error $ "hypo " ++ show e

toExp :: RExp -> Exp
toExp e = case e of
  App "App" [App fun [], App "B" xs, App "X" exps] ->
    DTr [mkCId x | App x [] <- xs] (AC (mkCId fun)) (map toExp exps)
  App "Eq" eqs -> 
    EEq [Equ (map toExp ps) (toExp v) | App "E" (v:ps) <- eqs]
  App "Var" [App i []] -> DTr [] (AV (mkCId i)) []
  AMet -> DTr [] (AM 0) []
  AInt i -> DTr [] (AI i) []
  AFlt i -> DTr [] (AF i) []
  AStr i -> DTr [] (AS i) []
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
  AStr s -> K (KS s) ----
  _ -> error $ "term " ++ show e

------------------------------
--- from internal to parser --
------------------------------

fromGFCC :: GFCC -> Grammar
fromGFCC gfcc0 = Grm [
  App "pgf" (AInt pgfMajorVersion:AInt pgfMinorVersion
             : App (prCId (absname gfcc)) [] : map (flip App [] . prCId) (cncnames gfcc)), 
  App "flags" [App (prCId f) [AStr v] | (f,v) <- Map.toList (gflags gfcc `Map.union` aflags agfcc)],
  App "abstract" [
    App "fun"   [App (prCId f) [fromType t,fromExp d] | (f,(t,d)) <- Map.toList (funs agfcc)],
    App "cat"   [App (prCId f) (map fromHypo hs) | (f,hs) <- Map.toList (cats agfcc)]
    ],
  App "concrete" [App (prCId lang) (fromConcrete c) | (lang,c) <- Map.toList (concretes gfcc)]
  ]
 where
  gfcc = utf8GFCC gfcc0
  agfcc = abstract gfcc
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

fromExp :: Exp -> RExp
fromExp e = case e of
  DTr xs (AC fun) exps ->
    App "App" [App (prCId fun) [], App "B" (map (flip App [] . prCId) xs), App "X" (map fromExp exps)]
  DTr [] (AV x) [] -> App "Var" [App (prCId x) []]
  DTr [] (AS s) [] -> AStr s
  DTr [] (AF d) [] -> AFlt d
  DTr [] (AI i) [] -> AInt (toInteger i)
  DTr [] (AM _) [] -> AMet ----
  EEq eqs -> 
    App "Eq" [App "E" (map fromExp (v:ps)) | Equ ps v <- eqs]
  _ -> error $ "exp " ++ show e

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
  K (KS s) -> AStr s ----
  K (KP d vs) -> App "FV" (str d : [str v | Var v _ <- vs]) ----
 where
   str v = App "S" (map AStr v)

-- ** Parsing info

fromPInfo :: ParserInfo -> RExp
fromPInfo p = App "parser" [
          App "rules"         [fromFRule rule | rule <- Array.elems (allRules p)],
          App "startupcats"   [App (prCId f) (map intToExp cs) | (f,cs) <- Map.toList (startupCats p)]
        ]

fromFRule :: FRule -> RExp
fromFRule (FRule fun prof args res lins) = 
    App "rule" [fromFName (fun,prof),
                App "cats" (intToExp res:map intToExp args),
                App "R" [App "S" [fromSymbol s | s <- Array.elems l] | l <- Array.elems lins]
               ]

fromFName :: (CId,[Profile]) -> RExp
fromFName (f,ps) | f == wildCId = fromProfile (head ps)
                 | otherwise    = App (prCId f) (map fromProfile ps)
  where
    fromProfile :: Profile -> RExp
    fromProfile []   = AMet
    fromProfile [x]  = daughter x
    fromProfile args = App "_U" (map daughter args)

    daughter n = App "_A" [intToExp n]

fromSymbol :: FSymbol -> RExp
fromSymbol (FSymCat l n) = App "P" [intToExp n, intToExp l]
fromSymbol (FSymTok t) = AStr t

-- ** Utilities

mkTermMap :: [RExp] -> Map.Map CId Term
mkTermMap ts = Map.fromAscList [(mkCId f,toTerm v) | App f [v] <- ts]

mkArray :: [a] -> Array.Array Int a
mkArray xs = Array.listArray (0, length xs - 1) xs

expToInt :: Integral a => RExp -> a
expToInt (App "neg" [AInt i]) = fromIntegral (negate i)
expToInt (AInt i) = fromIntegral i

expToStr :: RExp -> String
expToStr (AStr s) = s

intToExp :: Integral a => a -> RExp
intToExp x | x < 0 = App "neg" [AInt (fromIntegral (negate x))]
           | otherwise =  AInt (fromIntegral x)
