module GF.GFCC.Raw.ConvertGFCC (toGFCC,fromGFCC) where

import GF.GFCC.DataGFCC
import GF.GFCC.Raw.AbsGFCCRaw

import GF.Data.Assoc
import GF.Formalism.FCFG
import GF.Formalism.Utilities (NameProfile(..), Profile(..), SyntaxForest(..))
import GF.Parsing.FCFG.PInfo (FCFPInfo(..), buildFCFPInfo)

import qualified Data.Array as Array
import Data.Map

pgfMajorVersion, pgfMinorVersion :: Integer
(pgfMajorVersion, pgfMinorVersion) = (1,0)

-- convert parsed grammar to internal GFCC

toGFCC :: Grammar -> GFCC
toGFCC (Grm [
  App (CId "pgf") (AInt v1 : AInt v2 : App a []:cs),
  App (CId "flags")     gfs, 
  ab@(
    App (CId "abstract") [
      App (CId "fun")   fs,
      App (CId "cat")   cts
      ]), 
  App (CId "concrete") ccs
  ]) = GFCC {
    absname = a,
    cncnames = [c | App c [] <- cs],
    gflags = fromAscList [(f,v) | App f [AStr v] <- gfs],
    abstract = 
     let
      aflags  = fromAscList [(f,v) | App f [AStr v] <- gfs]
      lfuns   = [(f,(toType typ,toExp def)) | App f [typ, def] <- fs]
      funs    = fromAscList lfuns
      lcats   = [(c, Prelude.map toHypo hyps) | App c hyps <- cts]
      cats    = fromAscList lcats
      catfuns = fromAscList 
        [(cat,[f | (f, (DTyp _ c _,_)) <- lfuns, c==cat]) | (cat,_) <- lcats]
     in Abstr aflags funs cats catfuns,
    concretes = fromAscList [(lang, toConcr ts) | App lang ts <- ccs]
    }
 where

toConcr :: [RExp] -> Concr
toConcr = foldl add (Concr {
               cflags       = empty,
               lins         = empty,
               opers        = empty,
               lincats      = empty,
               lindefs      = empty,
               printnames   = empty,
               paramlincats = empty,
               parser       = Nothing
             })
  where
    add :: Concr -> RExp -> Concr
    add cnc (App (CId "flags") ts)     = cnc { cflags = fromAscList [(f,v) | App f [AStr v] <- ts] }
    add cnc (App (CId "lin") ts)       = cnc { lins = mkTermMap ts }
    add cnc (App (CId "oper") ts)      = cnc { opers = mkTermMap ts }
    add cnc (App (CId "lincat") ts)    = cnc { lincats = mkTermMap ts }
    add cnc (App (CId "lindef") ts)    = cnc { lindefs = mkTermMap ts }
    add cnc (App (CId "printname") ts) = cnc { printnames = mkTermMap ts }
    add cnc (App (CId "param") ts)     = cnc { paramlincats = mkTermMap ts }
    add cnc (App (CId "parser") ts)    = cnc { parser = Just (toPInfo ts) }

toPInfo :: [RExp] -> FCFPInfo
toPInfo [App (CId "rules") rs, App (CId "gfcats") cs] = buildFCFPInfo (rules, cats)
  where 
    rules = lmap toFRule rs
    cats = fromList [(c, lmap expToInt fs) | App c fs <- cs]

    toFRule :: RExp -> FRule
    toFRule (App (CId "rule") 
              [n,                      
               App (CId "cats") (rt:at),
               App (CId "R") ls]) = FRule name args res lins
      where 
        name = toFName n
        args = lmap expToInt at
        res  = expToInt rt
        lins = mkArray [mkArray [toSymbol s | s <- l] | App (CId "S") l <- ls]

toFName :: RExp -> FName
toFName (App (CId "_A") [x]) = Name (CId "_") [Unify [expToInt x]]
toFName (App f ts) = Name f (lmap toProfile ts)
    where
      toProfile :: RExp -> Profile (SyntaxForest CId)
      toProfile AMet = Unify []
      toProfile (App (CId "_A") [t]) = Unify [expToInt t]
      toProfile (App (CId "_U") ts) = Unify [expToInt t | App (CId "_A") [t] <- ts]
      toProfile t = Constant (toSyntaxForest t)

      toSyntaxForest :: RExp -> SyntaxForest CId
      toSyntaxForest AMet = FMeta
      toSyntaxForest (App n ts) = FNode n [lmap toSyntaxForest ts]
      toSyntaxForest (AStr s) = FString s
      toSyntaxForest (AInt i) = FInt i
      toSyntaxForest (AFlt f) = FFloat f

toSymbol :: RExp -> FSymbol
toSymbol (App (CId "P") [c,n,l]) = FSymCat (expToInt c) (expToInt l) (expToInt n)
toSymbol (AStr t) = FSymTok t

toType :: RExp -> Type
toType e = case e of
  App cat [App (CId "H") hypos, App (CId "X") exps] -> 
    DTyp (lmap toHypo hypos) cat (lmap toExp exps) 
  _ -> error $ "type " ++ show e

toHypo :: RExp -> Hypo
toHypo e = case e of
  App x [typ] -> Hyp x (toType typ)
  _ -> error $ "hypo " ++ show e

toExp :: RExp -> Exp
toExp e = case e of
  App (CId "App") [App fun [], App (CId "B") xs, App (CId "X") exps] ->
    DTr [x | App x [] <- xs] (AC fun) (lmap toExp exps)
  App (CId "Eq") eqs -> 
    EEq [Equ (lmap toExp ps) (toExp v) | App (CId "E") (v:ps) <- eqs]
  App (CId "Var") [App i []] -> DTr [] (AV i) []
  AMet -> DTr [] (AM 0) []
  AInt i -> DTr [] (AI i) []
  AFlt i -> DTr [] (AF i) []
  AStr i -> DTr [] (AS i) []
  _ -> error $ "exp " ++ show e

toTerm :: RExp -> Term
toTerm e = case e of
  App (CId "R") es    -> R  (lmap toTerm es)
  App (CId "S") es    -> S  (lmap toTerm es)
  App (CId "FV") es   -> FV (lmap toTerm es)
  App (CId "P") [e,v] -> P  (toTerm e) (toTerm v)
  App (CId "RP") [e,v] -> RP  (toTerm e) (toTerm v) ----
  App (CId "W") [AStr s,v] -> W s (toTerm v)
  App (CId "A") [AInt i] -> V (fromInteger i)
  App f []  -> F f
  AInt i -> C (fromInteger i)
  AMet   -> TM "?"
  AStr s -> K (KS s) ----
  _ -> error $ "term " ++ show e

------------------------------
--- from internal to parser --
------------------------------

fromGFCC :: GFCC -> Grammar
fromGFCC gfcc0 = Grm [
  app "pgf" (AInt pgfMajorVersion:AInt pgfMinorVersion
             : App (absname gfcc) [] : lmap (flip App []) (cncnames gfcc)), 
  app "flags" [App f [AStr v] | (f,v) <- toList (gflags gfcc `union` aflags agfcc)],
  app "abstract" [
    app "fun"   [App f [fromType t,fromExp d] | (f,(t,d)) <- toList (funs agfcc)],
    app "cat"   [App f (lmap fromHypo hs) | (f,hs) <- toList (cats agfcc)]
    ],
  app "concrete" [App lang (fromConcrete c) | (lang,c) <- toList (concretes gfcc)]
  ]
 where
  gfcc = utf8GFCC gfcc0
  app s = App (CId s)
  agfcc = abstract gfcc
  fromConcrete cnc = [
      app "flags"     [App f [AStr v]     | (f,v) <- toList (cflags cnc)],
      app "lin"       [App f [fromTerm v] | (f,v) <- toList (lins cnc)],
      app "oper"      [App f [fromTerm v] | (f,v) <- toList (opers cnc)],
      app "lincat"    [App f [fromTerm v] | (f,v) <- toList (lincats cnc)],
      app "lindef"    [App f [fromTerm v] | (f,v) <- toList (lindefs cnc)],
      app "printname" [App f [fromTerm v] | (f,v) <- toList (printnames cnc)],
      app "param"     [App f [fromTerm v] | (f,v) <- toList (paramlincats cnc)]
     ] ++ maybe [] (\p -> [fromPInfo p]) (parser cnc)

fromType :: Type -> RExp
fromType e = case e of
  DTyp hypos cat exps -> 
    App cat [
      App (CId "H") (lmap fromHypo hypos), 
      App (CId "X") (lmap fromExp exps)] 

fromHypo :: Hypo -> RExp
fromHypo e = case e of
  Hyp x typ -> App x [fromType typ]

fromExp :: Exp -> RExp
fromExp e = case e of
  DTr xs (AC fun) exps ->
    App (CId "App") [App fun [], App (CId "B") (lmap (flip App []) xs), App (CId "X") (lmap fromExp exps)]
  DTr [] (AV x) [] -> App (CId "Var") [App x []]
  DTr [] (AS s) [] -> AStr s
  DTr [] (AF d) [] -> AFlt d
  DTr [] (AI i) [] -> AInt (toInteger i)
  DTr [] (AM _) [] -> AMet ----
  EEq eqs -> 
    App (CId "Eq") [App (CId "E") (lmap fromExp (v:ps)) | Equ ps v <- eqs]
  _ -> error $ "exp " ++ show e

fromTerm :: Term -> RExp
fromTerm e = case e of
  R es    -> app "R" (lmap fromTerm es)
  S es    -> app "S" (lmap fromTerm es)
  FV es   -> app "FV" (lmap fromTerm es)
  P e v   -> app "P"  [fromTerm e, fromTerm v]
  RP e v  -> app "RP" [fromTerm e, fromTerm v] ----
  W s v   -> app "W" [AStr s, fromTerm v]
  C i     -> AInt (toInteger i)
  TM _    -> AMet
  F f     -> App f []
  V i     -> App (CId "A") [AInt (toInteger i)]
  K (KS s) -> AStr s ----
  K (KP d vs) -> app "FV" (str d : [str v | Var v _ <- vs]) ----
 where
   app = App . CId
   str v = app "S" (lmap AStr v)

-- ** Parsing info

fromPInfo :: FCFPInfo -> RExp
fromPInfo p = app "parser" [
          app "rules"         [fromFRule rule | rule <- Array.elems (allRules p)],
          app "gfcats"        [App f (lmap intToExp cs) | (f,cs) <- toList (startupCats p)]
        ]

fromFRule :: FRule -> RExp
fromFRule (FRule n args res lins) = 
    app "rule" [fromFName n,
                app "cats" (intToExp res:lmap intToExp args),
                app "R" [app "S" [fromSymbol s | s <- Array.elems l] | l <- Array.elems lins]
               ]

fromFName :: FName -> RExp
fromFName n = case n of
                Name (CId "_") [p] -> fromProfile p
                Name f ps          -> App f (lmap fromProfile ps)
  where
    fromProfile :: Profile (SyntaxForest CId) -> RExp
    fromProfile (Unify []) = AMet
    fromProfile (Unify [x]) = daughter x
    fromProfile (Unify args) = app "_U" (lmap daughter args)
    fromProfile (Constant forest) = fromSyntaxForest forest

    daughter n = app "_A" [intToExp n]

    fromSyntaxForest :: SyntaxForest CId -> RExp
    fromSyntaxForest FMeta = AMet
    -- FIXME: is there always just one element here?
    fromSyntaxForest (FNode n [args]) = App n (lmap fromSyntaxForest args)
    fromSyntaxForest (FString s) = AStr s
    fromSyntaxForest (FInt i) = AInt i
    fromSyntaxForest (FFloat f) = AFlt f

fromSymbol :: FSymbol -> RExp
fromSymbol (FSymCat c l n) = app "P" [intToExp c, intToExp n, intToExp l]
fromSymbol (FSymTok t) = AStr t

-- ** Utilities

mkTermMap :: [RExp] -> Map CId Term
mkTermMap ts = fromAscList [(f,toTerm v) | App f [v] <- ts]

app :: String -> [RExp] -> RExp
app = App . CId

mkArray :: [a] -> Array.Array Int a
mkArray xs = Array.listArray (0, length xs - 1) xs

expToInt :: Integral a => RExp -> a
expToInt (App (CId "neg") [AInt i]) = fromIntegral (negate i)
expToInt (AInt i) = fromIntegral i

expToStr :: RExp -> String
expToStr (AStr s) = s

intToExp :: Integral a => a -> RExp
intToExp x | x < 0 = App (CId "neg") [AInt (fromIntegral (negate x))]
           | otherwise =  AInt (fromIntegral x)
