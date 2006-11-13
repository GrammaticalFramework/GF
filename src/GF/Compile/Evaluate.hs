----------------------------------------------------------------------
-- |
-- Module      : Evaluate
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

module GF.Compile.Evaluate (appEvalConcrete, EEnv, emptyEEnv) where

import GF.Data.Operations
import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Data.Str
import GF.Grammar.PrGrammar
import GF.Infra.Modules
import GF.Infra.Option
import GF.Grammar.Macros
import GF.Grammar.Lookup
import GF.Grammar.Refresh
import GF.Grammar.PatternMatch
import GF.Grammar.Lockfield (isLockLabel) ----

import GF.Grammar.AppPredefined

import qualified Data.Map as Map

import Data.List (nub,intersperse)
import Control.Monad (liftM2, liftM)
import Debug.Trace


data EEnv = EEnv {
  computd :: Map.Map (Ident,Ident) FTerm,
  temp :: Int
  }

emptyEEnv = EEnv Map.empty 0

lookupComputed :: (Ident,Ident) -> STM EEnv (Maybe FTerm)
lookupComputed mc = do
  env <- readSTM
  return $ Map.lookup mc $ computd env

updateComputed :: (Ident,Ident) -> FTerm -> STM EEnv ()
updateComputed mc t = 
  updateSTM (\e -> e{computd = Map.insert mc t (computd e)})

getTemp :: STM EEnv Ident
getTemp = do
  env <- readSTM
  updateSTM (\e -> e{temp = temp e + 1})
  return $ identC ("#" ++ show (temp env))

data FTerm = 
    FTC Term
  | FTF (Term -> FTerm)

prFTerm :: Integer -> FTerm -> String
prFTerm i t = case t of
  FTC t -> prt t
  FTF f -> show i +++ "->" +++ prFTerm (i + 1) (f (EInt i))

term2fterm t = case t of
  Abs x b -> FTF (\t -> term2fterm (subst [(x,t)] b))
  _ -> FTC t

traceFTerm c ft = ft ----
----trace ("\n" ++ prt c +++ "=" +++ take 60 (prFTerm 0 ft)) ft

fterm2term :: FTerm -> STM EEnv Term
fterm2term t = case t of
  FTC t -> return t
  FTF f -> do
    x <- getTemp
    b <- fterm2term $ f (Vr x)
    return $ Abs x b

subst g t = case t of
  Vr x -> maybe t id $ lookup x g
  _ -> composSafeOp (subst g) t


appFTerm :: FTerm -> [Term] -> FTerm
appFTerm ft ts = case (ft,ts) of
  (FTF f, x:xs) -> appFTerm (f x) xs 
  (FTC c, _:_) -> FTC $ foldl App c ts
  _ -> ft

apps :: Term -> (Term,[Term])
apps t = case t of
  App f a -> (f',xs ++ [a]) where (f',xs) = apps f
  _ -> (t,[])

appEvalConcrete gr bt env = appSTM (evalConcrete gr bt) env

evalConcrete :: SourceGrammar -> BinTree Ident Info -> STM EEnv (BinTree Ident Info)
evalConcrete gr mo = mapMTree evaldef mo where

  evaldef (f,info) = case info of
    CncFun (mt@(Just (_,ty@(cont,val)))) pde ppr -> 
       evalIn ("\nerror in linearization of function" +++ prt f +++ ":") $ 
      do
      pde' <- case pde of
        Yes de -> do
          liftM yes $ pEval ty de
        _ -> return pde
      --- ppr' <-  liftM yes $ evalPrintname gr c ppr pde'
      return $ (f, CncFun mt pde' ppr) -- only cat in type actually needed

    _ ->  return (f,info)

  pEval (context,val) trm = do ---- errIn ("parteval" +++ prt_ trm) $ do
    let 
      vars  = map fst context
      args  = map Vr vars
      subst = [(v, Vr v) | v <- vars]
      trm1  = mkApp trm args
    trm3 <- recordExpand val trm1 >>= comp subst >>= recomp subst
    return $ mkAbs vars trm3

  ---- temporary hack to ascertain full evaluation, because of bug in comp
  recomp g t = if notReady t then comp g t else return t
  notReady = not . null . redexes
  redexes t = case t of
    Q _ _ -> return [()]
    _ -> collectOp redexes t

  recordExpand typ trm = case unComputed typ of
    RecType tys -> case trm of
      FV rs -> return $ FV [R [assign lab (P r lab) | (lab,_) <- tys] | r <- rs]
      _ -> return $ R [assign lab (P trm lab) | (lab,_) <- tys]
    _ -> return trm

  comp g t = case t of

    Q (IC "Predef") _ -> return t ----trace ("\nPredef:\n" ++ prt t) $ return t

    Q p c -> do
      md <- lookupComputed (p,c) 
      case md of
        Nothing -> do
          d  <- lookRes (p,c)
          updateComputed (p,c) $ traceFTerm c $ term2fterm d
          return d
        Just d -> fterm2term d >>= comp g
    App f a -> case apps t of
      (h@(Q p c),xs) | p == IC "Predef" -> do
        xs' <- mapM (comp g) xs
        (t',b) <- stmErr $ appPredefined (foldl App h xs')
        if b then return t' else comp g t'
      (h@(Q p c),xs) -> do
        xs' <- mapM (comp g) xs
        md <- lookupComputed (p,c) 
        case md of
          Just ft -> do
            t <- fterm2term $ appFTerm ft xs'
            comp g t
          Nothing -> do
            d  <- lookRes (p,c)
            let ft = traceFTerm c $ term2fterm d
            updateComputed (p,c) ft
            t' <- fterm2term $ appFTerm ft xs'
            comp g t'
      _ -> do
        f' <- comp g f
        a' <- comp g a
        case (f',a') of
         (Abs x b,_) -> comp (ext x a' g) b
         (QC _ _,_)  -> returnC $ App f' a'
         (FV fs, _)  -> mapM (\c -> comp g (App c a')) fs >>= return . variants
         (_, FV as)  -> mapM (\c -> comp g (App f' c)) as >>= return . variants

         (Alias _ _ d, _) -> comp g (App d a')

         (S (T i cs) e,_) -> prawitz g i (flip App a') cs e

	 _ -> do
           (t',b) <- stmErr $ appPredefined (App f' a')
           if b then return t' else comp g t'


    Vr x -> do
       t' <- maybe (prtRaise (
         "context" +++ show g +++ ": no value given to variable") x) return $ lookup x g
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

    P t l | isLockLabel l -> return $ R [] 
     ---- a workaround 18/2/2005: take this away and find the reason
     ---- why earlier compilation destroys the lock field


    P t l  -> do
       t' <- comp g t
       case t' of
         FV rs -> mapM (\c -> comp g (P c l)) rs >>= returnC . variants
         R r   -> maybe 
                   (prtRaise (prt t' ++ ": no value for label") l) (comp g . snd) $ 
                    lookup l r 

         ExtR a (R b) -> case lookup l b of  ----comp g (P (R b) l) of
           Just (_,v) -> comp g v
           _ -> comp g (P a l)
         ExtR (R a) b -> case lookup l a of  ----comp g (P (R b) l) of
           Just (_,v) -> comp g v
           _ -> comp g (P b l)

         S (T i cs) e -> prawitz g i (flip P l) cs e

         _   -> returnC $ P t' l

    S t@(T _ cc) v -> do
       v'     <- comp g v
       case v' of
         FV vs -> do
           ts' <- mapM (comp g . S t) vs
           return $ variants ts' 
         _ -> case matchPattern cc v' of
           Ok (c,g') -> comp (g' ++ g) c
           _ | isCan v' -> prtRaise ("missing case" +++ prt v' +++ "in") t 
           _ -> do
             t' <- comp g t
             return $ S t' v' -- if v' is not canonical

    S t v -> do
       t'     <- comp g t
       v'     <- comp g v
       case t' of
         T _ [(PV IW,c)] -> comp g c           --- an optimization
         T _ [(PT _ (PV IW),c)] -> comp g c

         T _ [(PV z,c)] -> comp (ext z v' g) c --- another optimization
         T _ [(PT _ (PV z),c)] -> comp (ext z v' g) c

         FV ccs -> mapM (\c -> comp g (S c v')) ccs >>= returnC . variants

         V ptyp ts -> do
           vs <- stmErr $ allParamValues gr ptyp
           ps <- stmErr $ mapM term2patt vs
           let cc = zip ps ts
           case v' of
             FV vs -> mapM (\c -> comp g (S t' c)) vs >>= returnC . variants
             _ -> case matchPattern cc v' of
               Ok (c,g') -> comp (g' ++ g) c
               _ | isCan v' -> prtRaise ("missing case" +++ prt v' +++ "in") t 
               _ -> return $ S t' v' -- if v' is not canonical

         T _ cc -> case v' of
	   FV vs -> mapM (\c -> comp g (S t' c)) vs >>= returnC . variants
           _ -> case matchPattern cc v' of
             Ok (c,g') -> comp (g' ++ g) c
             _ | isCan v' -> prtRaise ("missing case" +++ prt v' +++ "in") t 
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
         (_, Alts (d,vs)) -> do
----         (K a, Alts (d,vs)) -> do
            let glx = Glue x
            comp g $ Alts (glx d, [(glx v,c) | (v,c) <- vs])
         (Alts _, ka) -> checks [do
            y' <- stmErr $ strsFromTerm ka
----         (Alts _, K a) -> checks [do
            x' <- stmErr $ strsFromTerm x -- this may fail when compiling opers
            return $ variants [
              foldr1 C (map K (str2strings (glueStr v u))) | v <- x', u <- y']
----              foldr1 C (map K (str2strings (glueStr v (str a)))) | v <- x']
           ,return $ Glue x y
           ]
         (FV ks,_)         -> do
           kys <- mapM (comp g . flip Glue y) ks
           return $ variants kys
         (_,FV ks)         -> do
           xks <- mapM (comp g . Glue x) ks
           return $ variants xks

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
            as <- stmErr $ strsFromTerm a' -- this may fail when compiling opers
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
         (Alias _ _ d, _)  -> comp g $ ExtR d s'
         (_, Alias _ _ d)  -> comp g $ Glue r' d

         (R rs, R ss) -> stmErr $ plusRecord r' s'
         (RecType rs, RecType ss) -> stmErr $ plusRecType r' s'

         (_, FV ss) -> liftM FV $ mapM (comp g) [ExtR t u | u <- ss]

         _ -> return $ ExtR r' s'

     -- case-expand tables
     -- if already expanded, don't expand again
    T i@(TComp _) cs -> do
       -- if there are no variables, don't even go inside
       cs' <- {-if (null g) then return cs else-} mapPairsM (comp g) cs
       return $ T i cs'

     --- this means some extra work; should implement TSh directly
    TSh i cs -> comp g $ T i [(p,v) | (ps,v) <- cs, p <- ps]

    T i cs -> do
       pty0 <- stmErr $ getTableType i
       ptyp <- comp g pty0
       case allParamValues gr ptyp of
         Ok vs -> do

           cs'  <- mapM (compBranchOpt g) cs
           sts  <- stmErr $ mapM (matchPattern cs') vs 
           ts   <- mapM (\ (c,g') -> comp (g' ++ g) c) sts
           ps   <- stmErr $ mapM term2patt vs
           let ps' = ps --- PT ptyp (head ps) : tail ps
           return $ --- V ptyp ts -- to save space, just course of values
                    T (TComp ptyp) (zip ps' ts)
         _ -> do
           cs' <- mapM (compBranch g) cs
           return $ T i cs'  -- happens with variable types

     -- otherwise go ahead
    _ -> composOp (comp g) t >>= returnC

  lookRes (p,c) = case lookupResDefKind gr p c of
    Ok (t,_) | noExpand p -> return t
    Ok (t,0) -> comp [] t
    Ok (t,_) -> return t
    Bad s -> raise s

  noExpand p = errVal False $ do
    mo <- lookupModMod gr p
    return $ case getOptVal (iOpts (flags mo)) useOptimizer of
      Just "noexpand" -> True
      _ -> False

  prtRaise s t = raise (s +++ prt t)

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

  compBranch g (p,v) = do
       let g' = contP p ++ g
       v' <- comp g' v
       return (p,v')

  compBranchOpt g c@(p,v) = case contP p of
       [] -> return c
       _ -> compBranch g c
----       _ -> err (const (return c)) return $ compBranch g c

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

-- | argument variables cannot be glued
checkNoArgVars :: Term -> STM EEnv Term
checkNoArgVars t = case t of
  Vr (IA _)  -> raise $ glueErrorMsg $ prt t 
  Vr (IAV _) -> raise $ glueErrorMsg $ prt t 
  _ -> composOp checkNoArgVars t

glueErrorMsg s = 
  "Cannot glue (+) term with run-time variable" +++ s ++ "." ++++
  "Use Prelude.bind instead."

stmErr :: Err a -> STM s a
stmErr e = stm (\s -> do
  v <- e
  return (v,s)
  )

evalIn :: String -> STM s a -> STM s a
evalIn msg st = stm $ \s -> case appSTM st s of
  Bad e -> Bad $ msg ++++ e
  Ok vs -> Ok vs
