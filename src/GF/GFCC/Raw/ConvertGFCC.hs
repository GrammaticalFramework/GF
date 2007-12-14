module GF.GFCC.Raw.ConvertGFCC (toGFCC,fromGFCC) where

import GF.GFCC.DataGFCC
import GF.GFCC.Raw.AbsGFCCRaw

import Data.Map

-- convert parsed grammar to internal GFCC

toGFCC :: Grammar -> GFCC
toGFCC (Grm [
  AId a, 
  App (CId "concrete") cs, 
  App (CId "flags")     gfs, 
  ab@(
    App (CId "abstract") [
      App (CId "flags") afls,
      App (CId "fun")   fs,
      App (CId "cat")   cts
      ]), 
  App (CId "concrete") ccs
  ]) = GFCC {
    absname = a,
    cncnames = [c | AId c <- cs],
    gflags = fromAscList [(f,v) | App f [AStr v] <- gfs],
    abstract = 
     let
      aflags  = fromAscList [(f,v) | App f [AStr v] <- afls]
      lfuns   = [(f,(toType typ,toExp def)) | App f [typ, def] <- fs]
      funs    = fromAscList lfuns
      lcats   = [(c, Prelude.map toHypo hyps) | App c hyps <- cts]
      cats    = fromAscList lcats
      catfuns = fromAscList 
        [(cat,[f | (f, (DTyp _ c _,_)) <- lfuns, c==cat]) | (cat,_) <- lcats]
     in Abstr aflags funs cats catfuns,
    concretes = fromAscList (lmap mkCnc ccs)
    }
 where
   mkCnc (
    App lang [
      App (CId "flags") fls, 
      App (CId "lin") ls, 
      App (CId "oper") ops, 
      App (CId "lincat") lincs,
      App (CId "lindef") linds, 
      App (CId "printname") prns, 
      App (CId "param") params
      ]) = (lang, 
    Concr {
     cflags       = fromAscList [(f,v) | App f [AStr v] <- afls],
     lins         = fromAscList [(f,toTerm v) | App f [v] <- ls],  
     opers        = fromAscList [(f,toTerm v) | App f [v] <- ops],  
     lincats      = fromAscList [(f,toTerm v) | App f [v] <- lincs],  
     lindefs      = fromAscList [(f,toTerm v) | App f [v] <- linds],  
     printnames   = fromAscList [(f,toTerm v) | App f [v] <- prns],  
     paramlincats = fromAscList [(f,toTerm v) | App f [v] <- params]  
     }
    )

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
  App fun [App (CId "B") xs, App (CId "X") exps] ->
    DTr [x | AId x <- xs] (AC fun) (lmap toExp exps)
  App (CId "Eq") eqs -> 
    EEq [Equ (lmap toExp ps) (toExp v) | App (CId "Case") (v:ps) <- eqs]
  AMet -> DTr [] (AM 0) []
  AInt i -> DTr [] (AI i) []
  AFlt i -> DTr [] (AF i) []
  AStr i -> DTr [] (AS i) []
  AId i  -> DTr [] (AV i) []
  _ -> error $ "exp " ++ show e

toTerm :: RExp -> Term
toTerm e = case e of
  App (CId "R") es    -> R  (lmap toTerm es)
  App (CId "S") es    -> S  (lmap toTerm es)
  App (CId "FV") es   -> FV (lmap toTerm es)
  App (CId "P") [e,v] -> P  (toTerm e) (toTerm v)
  App (CId "RP") [e,v] -> RP  (toTerm e) (toTerm v) ----
  App (CId "W") [AStr s,v] -> W s (toTerm v)
  AInt i -> C (fromInteger i)
  AMet   -> TM
  AId f  -> F f
  App (CId "A") [AInt i] -> V (fromInteger i)
  AStr s -> K (KS s) ----
  _ -> error $ "term " ++ show e

------------------------------
--- from internal to parser --
------------------------------

fromGFCC :: GFCC -> Grammar
fromGFCC gfcc0 = Grm [
  AId (absname gfcc),
  app "concrete" (lmap AId (cncnames gfcc)), 
  app "flags" [App f [AStr v] | (f,v) <- toList (gflags gfcc)],
  app "abstract" [
    app "flags" [App f [AStr v] | (f,v) <- toList (aflags agfcc)],
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
      ] 

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
    App fun [App (CId "B") (lmap AId xs), App (CId "X") (lmap fromExp exps)]  
  DTr [] (AS s) [] -> AStr s
  DTr [] (AF d) [] -> AFlt d
  DTr [] (AV x) [] -> AId x
  DTr [] (AI i) [] -> AInt (toInteger i)
  DTr [] (AM _) [] -> AMet ----
  EEq eqs -> 
    App (CId "Eq") [App (CId "Case") (lmap fromExp (v:ps)) | Equ ps v <- eqs]
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
  TM      -> AMet
  F f     -> AId f
  V i     -> App (CId "A") [AInt (toInteger i)]
  K (KS s) -> AStr s ----
  K (KP d vs) -> app "FV" (str d : [str v | Var v _ <- vs]) ----
 where
   app = App . CId
   str v = app "S" (lmap AStr v)
