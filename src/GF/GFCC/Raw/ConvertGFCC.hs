module GF.GFCC.Raw.ConvertGFCC where

import GF.GFCC.DataGFCC
import GF.GFCC.Raw.AbsGFCCRaw

import Data.Map

-- convert parsed grammar to internal GFCC

mkGFCC :: Grammar -> GFCC
mkGFCC (Grm [
  App (CId "abstract")  [AId a], 
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
    App (CId "concrete") [
      AId lang,
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
  App cat [App (CId "hypo") hypos, App (CId "arg") exps] -> 
    DTyp (lmap toHypo hypos) cat (lmap toExp exps) 
  _ -> error $ "type " ++ show e

toHypo :: RExp -> Hypo
toHypo e = case e of
  App x [typ] -> Hyp x (toType typ)
  _ -> error $ "hypo " ++ show e

toExp :: RExp -> Exp
toExp e = case e of
  App fun [App (CId "abs") xs, App (CId "arg") exps] ->
    DTr [x | AId x <- xs] (AC fun) (lmap toExp exps) 
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


{-
-- convert internal GFCC and pretty-print it

printGFCC :: GFCC -> String
printGFCC gfcc0 = compactPrintGFCC $ printTree $ Grm
  (absname gfcc) 
  (cncnames gfcc)
  [Flg f v | (f,v) <- assocs (gflags gfcc)]
  (Abs
    [Flg f v     | (f,v) <- assocs (aflags (abstract gfcc))]
    [Fun f ty df | (f,(ty,df)) <- assocs (funs (abstract gfcc))]
    [Cat f v     | (f,v) <- assocs (cats (abstract gfcc))]
    )
  [fromCnc lang cnc | (lang,cnc) <- assocs (concretes gfcc)]
 where
   fromCnc lang cnc = Cnc lang 
     [Flg f v | (f,v) <- assocs (cflags cnc)]
     [Lin f v | (f,v) <- assocs (lins cnc)]
     [Lin f v | (f,v) <- assocs (opers cnc)]
     [Lin f v | (f,v) <- assocs (lincats cnc)]
     [Lin f v | (f,v) <- assocs (lindefs cnc)]
     [Lin f v | (f,v) <- assocs (printnames cnc)]
     [Lin f v | (f,v) <- assocs (paramlincats cnc)]
   gfcc = utf8GFCC gfcc0
-}
