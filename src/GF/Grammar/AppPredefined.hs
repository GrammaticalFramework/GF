module AppPredefined where

import Operations
import Grammar
import Ident
import PrGrammar (prt)
---- import PGrammar (pTrm)

-- predefined function type signatures and definitions. AR 12/3/2003.

---- typPredefined :: Term -> Err Type

appPredefined :: Term -> Term
appPredefined t = case t of

  App f x -> case f of

    -- one-place functions
    Q (IC "Predef") (IC f) -> case (f, appPredefined x) of
      ("length", K s) -> EInt $ length s
      _ -> t

    -- two-place functions
    App (Q (IC "Predef") (IC f)) z -> case (f, appPredefined z, appPredefined x) of
      ("drop", EInt i, K s) -> K (drop i s)
      ("take", EInt i, K s) -> K (take i s)
      ("tk",   EInt i, K s) -> K (take (max 0 (length s - i)) s)
      ("dp",   EInt i, K s) -> K (drop (max 0 (length s - i)) s)
      ("eqStr",K s,    K t) -> if s == t then predefTrue else predefFalse
      ("occur",K s,    K t) -> if substring s t then predefTrue else predefFalse
      ("eqInt",EInt i, EInt j) -> if i==j then predefTrue else predefFalse
      ("plus", EInt i, EInt j) -> EInt $ i+j
      ("show", _, t) -> K $ prt t
      ("read", _, K s) -> str2tag s --- because of K, only works for atomic tags
      _ -> t
    _ -> t
  _ -> t

-- read makes variables into constants

str2tag :: String -> Term
str2tag s = case s of
----  '\'' : cs -> mkCn $ pTrm $ init cs
  _ -> Cn $ IC s ---
 where
   mkCn t = case t of
     Vr i -> Cn i
     App c a -> App (mkCn c) (mkCn a)
     _ -> t


predefTrue = Q (IC "Predef") (IC "PTrue")
predefFalse = Q (IC "Predef") (IC "PFalse")

substring :: String -> String -> Bool
substring s t = case (s,t) of
  (c:cs, d:ds) -> (c == d && substring cs ds) || substring s ds
  ([],_) -> True
  _ -> False

