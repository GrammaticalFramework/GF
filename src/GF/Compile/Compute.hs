----------------------------------------------------------------------
-- |
-- Module      : Compute
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/01 15:39:12 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.19 $
--
-- Computation of source terms. Used in compilation and in @cc@ command.
-----------------------------------------------------------------------------

module GF.Compile.Compute (computeConcrete, computeTerm,computeConcreteRec) where

import GF.Data.Operations
import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.Modules
import GF.Data.Str
import GF.Grammar.Printer
import GF.Grammar.Predef
import GF.Grammar.Macros
import GF.Grammar.Lookup
import GF.Compile.Refresh
import GF.Grammar.PatternMatch
import GF.Grammar.Lockfield (isLockLabel,unlockRecord) ----

import GF.Grammar.AppPredefined

import Data.List (nub,intersperse)
import Control.Monad (liftM2, liftM)
import Text.PrettyPrint

-- | computation of concrete syntax terms into normal form
-- used mainly for partial evaluation
computeConcrete :: SourceGrammar -> Term -> Err Term
computeConcrete    g t = {- refreshTerm t >>= -} computeTerm g [] t
computeConcreteRec g t = {- refreshTerm t >>= -} computeTermOpt True g [] t

computeTerm :: SourceGrammar -> Substitution -> Term -> Err Term
computeTerm = computeTermOpt False

-- rec=True is used if it cannot be assumed that looked-up constants
-- have already been computed (mainly with -optimize=noexpand in .gfr)

computeTermOpt :: Bool -> SourceGrammar -> Substitution -> Term -> Err Term
computeTermOpt rec gr = comput True where

   comput full g t = ---- errIn ("subterm" +++ prt t) $ --- for debugging 
              case t of

     Q p c | p == cPredef -> return t
           | otherwise    -> look p c 

     Vr x -> do
       t' <- maybe (Bad (render (text "no value given to variable" <+> ppIdent x))) return $ lookup x g
       case t' of 
         _ | t == t' -> return t
         _ -> comp g t'

     -- Abs x@(IA _) b -> do 
     Abs _ _ _ | full -> do 
       let (xs,b1) = termFormCnc t   
       b' <- comp ([(x,Vr x) | (_,x) <- xs] ++ g) b1
       return $ mkAbs xs b'
     --  b' <- comp (ext x (Vr x) g) b
     --  return $ Abs x b'
     Abs _ _ _ -> return t -- hnf

     Let (x,(_,a)) b -> do
       a' <- comp g a
       comp (ext x a' g) b

     Prod b x a t -> do
       a' <- comp g a
       t' <- comp (ext x (Vr x) g) t
       return $ Prod b x a' t'

     -- beta-convert
     App f a -> case appForm t of
      (h,as) | length as > 1 -> do
        h' <- hnf g h
        as' <- mapM (comp g) as
        case h' of
          _ | not (null [() | FV _ <- as']) -> compApp g (mkApp h' as')
          c@(QC _ _) -> do
            return $ mkApp c as'
          Q mod f | mod == cPredef -> do     
            (t',b) <- appPredefined (mkApp h' as')
            if b then return t' else comp g t'

          Abs _ _ _ -> do
            let (xs,b) = termFormCnc h'
            let g' = (zip (map snd xs) as') ++ g
            let as2 = drop (length xs) as'
            let xs2 = drop (length as') xs
            b' <- comp g' (mkAbs xs2 b)
            if null as2 then return b' else comp g (mkApp b' as2)

          _ -> compApp g (mkApp h' as')
      _ -> compApp g t

     P t l | isLockLabel l -> return $ R [] 
     ---- a workaround 18/2/2005: take this away and find the reason
     ---- why earlier compilation destroys the lock field


     P t l  -> do
       t' <- comp g t
       case t' of
         FV rs -> mapM (\c -> comp g (P c l)) rs >>= returnC . variants
         R r   -> maybe (Bad (render (text "no value for label" <+> ppLabel l))) (comp g . snd) $ 
                    lookup l $ reverse r 

         ExtR a (R b) ->                 
           case comp g (P (R b) l) of
             Ok v -> return v
             _ -> comp g (P a l)

--- { - --- this is incorrect, since b can contain the proper value
         ExtR (R a) b ->                 -- NOT POSSIBLE both a and b records!
           case comp g (P (R a) l) of
             Ok v -> return v
             _ -> comp g (P b l)
--- - } ---

         S (T i cs) e -> prawitz g i (flip P l) cs e
         S (V i cs) e -> prawitzV g i (flip P l) cs e

         _   -> returnC $ P t' l

     PI t l i -> comp g $ P t l -----

     S t v -> do
       t' <- compTable g t
       v' <- comp g v
       t1 <- case t' of
----           V (RecType fs) _         -> uncurrySelect g fs t' v'
----           T (TComp (RecType fs)) _ -> uncurrySelect g fs t' v'
           _ -> return $ S t' v'
       compSelect g t1

     -- normalize away empty tokens
     K "" -> return Empty

     -- glue if you can
     Glue x0 y0 -> do
       x <- comp g x0
       y <- comp g y0
       case (x,y) of
         (FV ks,_)         -> do
           kys <- mapM (comp g . flip Glue y) ks
           return $ variants kys
         (_,FV ks)         -> do
           xks <- mapM (comp g . Glue x) ks
           return $ variants xks

         (S (T i cs) e, s) -> prawitz g i (flip Glue s) cs e
         (s, S (T i cs) e) -> prawitz g i (Glue s) cs e
         (S (V i cs) e, s) -> prawitzV g i (flip Glue s) cs e
         (s, S (V i cs) e) -> prawitzV g i (Glue s) cs e
         (_,Empty)         -> return x
         (Empty,_)         -> return y
         (K a, K b)        -> return $ K (a ++ b)
         (_, Alts (d,vs)) -> do
----         (K a, Alts (d,vs)) -> do
            let glx = Glue x
            comp g $ Alts (glx d, [(glx v,c) | (v,c) <- vs])
         (Alts _, ka) -> checks [do
            y' <- strsFromTerm ka
----         (Alts _, K a) -> checks [do
            x' <- strsFromTerm x -- this may fail when compiling opers
            return $ variants [
              foldr1 C (map K (str2strings (glueStr v u))) | v <- x', u <- y']
----              foldr1 C (map K (str2strings (glueStr v (str a)))) | v <- x']
           ,return $ Glue x y
           ]
         (C u v,_) -> comp g $ C u (Glue v y)

         _ -> do
           mapM_ checkNoArgVars [x,y]
           r <- composOp (comp g) t
           returnC r

     Alts (d,aa) -> do
       d' <- comp g d
       aa' <- mapM (compInAlts g) aa
       returnC (Alts (d',aa'))

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
     FV ts -> mapM (comp g) ts >>= returnC . variants

     -- merge record extensions if you can
     ExtR r s -> do
       r' <- comp g r
       s' <- comp g s
       case (r',s') of
         (R rs, R ss) -> plusRecord r' s'
         (RecType rs, RecType ss) -> plusRecType r' s'
         _ -> return $ ExtR r' s'

     ELin c r -> do
       r' <- comp g r
       unlockRecord c r'

     T _ _ -> compTable g t
     V _ _ -> compTable g t

     -- otherwise go ahead
     _ -> composOp (comp g) t >>= returnC

    where

     compApp g (App f a) = do
       f' <- hnf g f
       a' <- comp g a
       case (f',a') of
         (Abs _ x b, FV as) -> 
           mapM (\c -> comp (ext x c g) b) as >>= return . variants
         (_, FV as)  -> mapM (\c -> comp g (App f' c)) as >>= return . variants
         (FV fs, _)  -> mapM (\c -> comp g (App c a')) fs >>= return . variants
         (Abs _ x b,_) -> comp (ext x a' g) b

         (QC _ _,_)  -> returnC $ App f' a'

         (S (T i cs) e,_) -> prawitz g i (flip App a') cs e
         (S (V i cs) e,_) -> prawitzV g i (flip App a') cs e

	 _ -> do
           (t',b) <- appPredefined (App f' a')
           if b then return t' else comp g t'

     hnf  = comput False
     comp = comput True

     look p c
       | rec       = lookupResDef gr p c >>= comp []
       | otherwise = lookupResDef gr p c

     ext x a g = (x,a):g

     returnC = return --- . computed

     variants ts = case nub ts of
       [t] -> t
       ts  -> FV ts

     isCan v = case v of
       Con _    -> True
       QC _ _   -> True
       App f a  -> isCan f && isCan a
       R rs     -> all (isCan . snd . snd) rs
       _        -> False

     compPatternMacro p = case p of
       PM m c -> case look m c of
         Ok (EPatt p') -> compPatternMacro p'
         _ -> Bad (render (text "pattern expected as value of" $$ nest 2 (ppPatt Unqualified 0 p)))
       PAs x p -> do
         p' <- compPatternMacro p
         return $ PAs x p'
       PAlt p q -> do
         p' <- compPatternMacro p
         q' <- compPatternMacro q
         return $ PAlt p' q'
       PSeq p q -> do
         p' <- compPatternMacro p
         q' <- compPatternMacro q
         return $ PSeq p' q'
       PRep p -> do
         p' <- compPatternMacro p
         return $ PRep p'
       PNeg p -> do
         p' <- compPatternMacro p
         return $ PNeg p'
       PR rs -> do
         rs' <- mapPairsM compPatternMacro rs
         return $ PR rs'

       _ -> return p

     compSelect g (S t' v') = case v' of
       FV vs -> mapM (\c -> comp g (S t' c)) vs >>= returnC . variants        
       _ -> case t' of
         FV ccs -> mapM (\c -> comp g (S c v')) ccs >>= returnC . variants

         T _ [(PW,c)] -> comp g c           --- an optimization
         T _ [(PT _ PW,c)] -> comp g c

         T _ [(PV z,c)] -> comp (ext z v' g) c --- another optimization
         T _ [(PT _ (PV z),c)] -> comp (ext z v' g) c

         -- course-of-values table: look up by index, no pattern matching needed

         V ptyp ts -> case v' of
           Val _ _ i -> comp g $ ts !! i
           _ -> do
             vs <- allParamValues gr ptyp
             case lookupR v' (zip vs [0 .. length vs - 1]) of
               Just i -> comp g $ ts !! i
               _ -> return $ S t' v' -- if v' is not canonical
         T _ cc -> do
           let v2 = case v' of
                 Val te _ _ -> te
                 _ -> v'
           case matchPattern cc v2 of
             Ok (c,g') -> comp (g' ++ g) c
             _ | isCan v2 -> Bad (render (text "missing case" <+> ppTerm Unqualified 0 v2 <+> text "in" <+> ppTerm Unqualified 0 t))
             _ -> return $ S t' v' -- if v' is not canonical

         S (T i cs) e -> prawitz g i (flip S v') cs e
         S (V i cs) e -> prawitzV g i (flip S v') cs e
         _    -> returnC $ S t' v'

     --- needed to match records with and without type information
     ---- todo: eliminate linear search in a list of records!
     lookupR v vs = case v of
       R rs -> lookup ([(x,y) | (x,(_,y)) <- rs]) 
                                [([(x,y) | (x,(_,y)) <- rs],v) | (R rs,v) <- vs]
       _ -> lookup v vs

     -- case-expand tables
     -- if already expanded, don't expand again
     compTable g t = case t of
         T i@(TComp ty) cs -> do
           -- if there are no variables, don't even go inside
           cs' <- if (null g) then return cs else mapPairsM (comp g) cs
----           return $ V ty (map snd cs')
           return $ T i cs'
         V ty cs -> do
           ty' <- comp g ty
           -- if there are no variables, don't even go inside
           cs' <- if (null g) then return cs else mapM (comp g) cs
           return $ V ty' cs'

         T i cs -> do
           pty0 <- getTableType i
           ptyp <- comp g pty0
           case allParamValues gr ptyp of
             Ok vs0 -> do
               let vs = vs0 ---- [Val v ptyp i | (v,i) <- zip vs0 [0..]]
               ps0  <- mapM (compPatternMacro . fst) cs
               cs'  <- mapM (compBranchOpt g) (zip ps0 (map snd cs))
               sts  <- mapM (matchPattern cs') vs 
               ts   <- mapM (\ (c,g') -> comp (g' ++ g) c) sts
               ps   <- mapM term2patt vs
               let ps' = ps --- PT ptyp (head ps) : tail ps
----               return $ V ptyp ts -- to save space, just course of values
               return $ T (TComp ptyp) (zip ps' ts)
             _ -> do
               ps0  <- mapM (compPatternMacro . fst) cs
               cs'  <- mapM (compBranch g) (zip ps0 (map snd cs))

----               cs' <- mapM (compBranch g) cs
               return $ T i cs'  -- happens with variable types
         _ -> comp g t

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

       PAs x p -> (x,Vr x) : contP p

       PSeq p q -> concatMap contP [p,q]
       PAlt p q -> concatMap contP [p,q]
       PRep p   -> contP p
       PNeg p   -> contP p

       _ -> []

     prawitz g i f cs e = do
       cs' <- mapM (compBranch g) [(p, f v) | (p,v) <- cs]
       return $ S (T i cs') e
     prawitzV g i f cs e = do
       cs' <- mapM (comp g) [(f v) | v <- cs]
       return $ S (V i cs') e

     compInAlts g (v,c) = do
       v' <- comp g v
       c' <- comp g c
       c2 <- case c' of
         EPatt p -> liftM Strs $ getPatts p
         _ -> return c'
       return (v',c2)
      where
       getPatts p = case p of
         PAlt a b  -> liftM2 (++) (getPatts a) (getPatts b)
         PString s -> return [K s]
         PSeq a b  -> do
           as <- getPatts a
           bs <- getPatts b
           return [K (s ++ t) | K s <- as, K t <- bs]
         _ -> fail (render (text "not valid pattern in pre expression" <+> ppPatt Unqualified 0 p))

{- ----
     uncurrySelect g fs t v = do
       ts <- mapM (allParamValues gr . snd) fs
       vs <- mapM (comp g) [P v r | r <- map fst fs]
       return $ reorderSelect t fs ts vs

     reorderSelect t fs pss vs = case (t,fs,pss,vs) of
       (V _ ts, f:fs1, ps:pss1, v:vs1) -> 
         S (V (snd f) 
             [reorderSelect (V (RecType fs1) t) fs1 pss1 vs1 | 
               t <- segments (length ts `div` length ps) ts]) v 
       (T (TComp _) cs, f:fs1, ps:pss1, v:vs1) -> 
         S (T (TComp (snd f)) 
             [(p,reorderSelect (T (TComp (RecType fs1)) c) fs1 pss1 vs1) | 
               (ep,c) <- zip ps (segments (length cs `div` length ps) cs),
               let Ok p = term2patt ep]) v 
       _ -> t

     segments i xs = 
       let (x0,xs1) = splitAt i xs in x0 : takeWhile (not . null) (segments i xs1)
-}


-- | argument variables cannot be glued
checkNoArgVars :: Term -> Err Term
checkNoArgVars t = case t of
  Vr (IA _ _)    -> Bad $ glueErrorMsg $ ppTerm Unqualified 0 t 
  Vr (IAV _ _ _) -> Bad $ glueErrorMsg $ ppTerm Unqualified 0 t 
  _ -> composOp checkNoArgVars t

glueErrorMsg s = 
  render (text "Cannot glue (+) term with run-time variable" <+> s <> char '.' $$
          text "Use Prelude.bind instead.")

getArgType t = case t of
  V ty _ -> return ty
  T (TComp ty) _ -> return ty
  _ -> Bad (render (text "cannot get argument type of table" $$ nest 2 (ppTerm Unqualified 0 t)))
