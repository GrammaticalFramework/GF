module Compute where

import Operations
import Grammar
import Ident
import Str
import PrGrammar
import Modules
import Macros
import Lookup
import Refresh
import PatternMatch

import AppPredefined

import List (nub,intersperse)
import Monad (liftM2, liftM)

-- computation of concrete syntax terms into normal form
-- used mainly for partial evaluation

computeConcrete :: SourceGrammar -> Term -> Err Term
computeConcrete g t = {- refreshTerm t >>= -} computeTerm g [] t

computeTerm :: SourceGrammar -> Substitution -> Term -> Err Term
computeTerm gr = comp where

   comp g t = ---- errIn ("subterm" +++ prt t) $ --- for debugging 
              case t of

     Q (IC "Predef") _ -> return t
     Q p c -> look p c 

     -- if computed do nothing
     Computed t' -> return $ unComputed t'

     Vr x -> do
       t' <- maybe (prtBad ("no value given to variable") x) return $ lookup x g
       case t' of 
         _ | t == t' -> return t
         _ -> comp g t'

     Abs x b -> do 
       b' <- comp (ext x (Vr x) g) b
       return $ Abs x b'

     Let (x,(_,a)) b -> do
       a' <- comp g a
       comp (ext x a' g) b

     Prod x a b -> do
       a' <- comp g a
       b' <- comp (ext x (Vr x) g) b
       return $ Prod x a' b'

     -- beta-convert
     App f a -> do
       f' <- comp g f
       a' <- comp g a
       case (f',a') of
         (Abs x b,_) -> comp (ext x a' g) b
         (QC _ _,_)  -> returnC $ App f' a'
         (FV fs, _)  -> mapM (\c -> comp g (App c a')) fs >>= return . FV
         (_, FV as)  -> mapM (\c -> comp g (App f' c)) as >>= return . FV

         (Alias _ _ d, _) -> comp g (App d a')

         (S (T i cs) e,_) -> prawitz g i (flip App a') cs e

	 _ -> returnC $ appPredefined $ App f' a'
     P t l  -> do
       t' <- comp g t
       case t' of
         FV rs -> mapM (\c -> comp g (P c l)) rs >>= returnC . FV
         R r   -> maybe (prtBad "no value for label" l) (comp g . snd) $ lookup l r 

         ExtR (R a) b ->                 -- NOT POSSIBLE both a and b records!
           case comp g (P (R a) l) of
             Ok v -> return v
             _ -> comp g (P b l)
         ExtR a (R b) ->                 
           case comp g (P (R b) l) of
             Ok v -> return v
             _ -> comp g (P a l)

         Alias _ _ r -> comp g (P r l)

         S (T i cs) e -> prawitz g i (flip P l) cs e

         _   -> returnC $ P t' l

     S t v -> do
       t'     <- comp g t
       v'     <- comp g v
       case t' of
         T _ [(PV IW,c)] -> comp g c           --- an optimization
         T _ [(PT _ (PV IW),c)] -> comp g c

         T _ [(PV z,c)] -> comp (ext z v' g) c --- another optimization
         T _ [(PT _ (PV z),c)] -> comp (ext z v' g) c

         FV ccs -> mapM (\c -> comp g (S c v')) ccs >>= returnC . FV

         T _ cc -> case v' of
	   FV vs -> mapM (\c -> comp g (S t' c)) vs >>= returnC . FV
           _ -> case matchPattern cc v' of
             Ok (c,g') -> comp (g' ++ g) c
             _ | isCan v' -> prtBad ("missing case" +++ prt v' +++ "in") t 
             _ -> return $ S t' v' -- if v' is not canonical

         Alias _ _ d -> comp g (S d v')

         S (T i cs) e -> prawitz g i (flip S v') cs e

	 _    -> returnC $ S t' v'

     -- normalize away empty tokens
     K "" -> return Empty

     -- glue if you can
     Glue x0 y0 -> do
       x <- comp g x0
       y <- comp g y0
       case (x,y) of
         (Alias _ _ d, y)  -> comp g $ Glue d y
         (x, Alias _ _ d)  -> comp g $ Glue x d

         (S (T i cs) e, s) -> prawitz g i (flip Glue s) cs e
         (s, S (T i cs) e) -> prawitz g i (Glue s) cs e
         (_,Empty)         -> return x
         (Empty,_)         -> return y
         (K a, K b)        -> return $ K (a ++ b)
         (K a, Alts (d,vs)) -> do
            let glx = Glue x
            comp g $ Alts (glx d, [(glx v,c) | (v,c) <- vs])
         (Alts _, K a) -> checks [do
            x' <- strsFromTerm x -- this may fail when compiling opers
            return $ variants [
              foldr1 C (map K (str2strings (glueStr v (str a)))) | v <- x']
           ,return $ Glue x y
           ]
         (FV ks,_)         -> do
           kys <- mapM (comp g . flip Glue y) ks
           return $ FV kys
         (_,FV ks)         -> do
           xks <- mapM (comp g . Glue x) ks
           return $ FV xks

         _ -> do
           mapM_ checkNoArgVars [x,y]
           r <- composOp (comp g) t
           returnC r

     Alts _ -> do
       r <- composOp (comp g) t
       returnC r

     -- remove empty
     C a b    -> do
       a' <- comp g a
       b' <- comp g b
       case (a',b') of
         (Alts _, K a) -> checks [do
            as <- strsFromTerm a' -- this may fail when compiling opers
            return $ variants [
              foldr1 C (map K (str2strings (plusStr v (str a)))) | v <- as]
            ,
            return $ C a' b'
           ]
         (Empty,_) -> returnC b'
         (_,Empty) -> returnC a'
         _     -> returnC $ C a' b'

     -- reduce free variation as much as you can
     FV [t] -> comp g t

     -- merge record extensions if you can
     ExtR r s -> do
       r' <- comp g r
       s' <- comp g s
       case (r',s') of
         (Alias _ _ d, _)  -> comp g $ ExtR d s'
         (_, Alias _ _ d)  -> comp g $ Glue r' d

         (R rs, R ss) -> return $ R (rs ++ ss)
         (RecType rs, RecType ss) -> return $ RecType (rs ++ ss)
         _ -> return $ ExtR r' s'

     -- case-expand tables
     -- if already expanded, don't expand again
     T i@(TComp _) cs -> do
       -- if there are no variables, don't even go inside
       cs' <- if (null g) then return cs else mapPairsM (comp g) cs
       return $ T i cs'

     T i cs -> do
       pty0 <- getTableType i
       ptyp <- comp g pty0
       case allParamValues gr ptyp of
         Ok vs -> do

           cs'  <- mapM (compBranchOpt g) cs
           sts  <- mapM (matchPattern cs') vs 
           ts   <- mapM (\ (c,g') -> comp (g' ++ g) c) sts
           ps   <- mapM term2patt vs
           let ps' = ps --- PT ptyp (head ps) : tail ps
           return $ T (TComp ptyp) (zip ps' ts)
         _ -> do
           cs' <- mapM (compBranch g) cs
           return $ T i cs'  -- happens with variable types

     Alias c a d -> do
       d' <- comp g d
       return $ Alias c a d'  -- alias only disappears in certain redexes

     -- otherwise go ahead
     _ -> composOp (comp g) t >>= returnC

    where

     look = lookupResDef gr

     ext x a g = (x,a):g

     returnC = return --- . computed

     variants [t] = t
     variants ts = FV ts

     isCan v = case v of
       Con _    -> True
       QC _ _   -> True
       App f a  -> isCan f && isCan a
       R rs     -> all (isCan . snd . snd) rs
       _        -> False

     compBranch g (p,v) = do
       let g' = contP p ++ g
       v' <- comp g' v
       return (p,v')

     compBranchOpt g c@(p,v) = case contP p of
       [] -> return c
       _ -> err (const (return c)) return $ compBranch g c

     contP p = case p of
       PV x -> [(x,Vr x)]
       PC _ ps -> concatMap contP ps
       PP _ _ ps -> concatMap contP ps
       PT _ p -> contP p
       PR rs -> concatMap (contP . snd) rs
       _ -> []

     prawitz g i f cs e = do
       cs' <- mapM (compBranch g) [(p, f v) | (p,v) <- cs]
       return $ S (T i cs') e

-- argument variables cannot be glued

checkNoArgVars :: Term -> Err Term
checkNoArgVars t = case t of
  Vr (IA _)  -> Bad $ glueErrorMsg $ prt t 
  Vr (IAV _) -> Bad $ glueErrorMsg $ prt t 
  _ -> composOp checkNoArgVars t

glueErrorMsg s = 
  "Cannot glue (+) term with run-time variable" +++ s ++ "." ++++
  "Use Prelude.bind instead."
