module GF.Devel.Macros where

import GF.Devel.Terms
import GF.Devel.Judgements
import GF.Devel.Modules
import GF.Infra.Ident

import GF.Data.Operations

import Data.Map
import Control.Monad (liftM,liftM2)

contextOfType :: Type -> Context
contextOfType ty = co where (co,_,_) = typeForm ty

typeForm :: Type -> (Context,Term,[Term])
typeForm t = (co,f,a) where
  (co,t2) = prodForm t
  (f,a) = appForm t2

prodForm :: Type -> (Context,Term)
prodForm t = case t of
  Prod x ty val -> ((x,ty):co,t2) where (co,t2) = prodForm val
  _ -> ([],t)

appForm :: Term -> (Term,[Term])
appForm tr = (f,reverse xs) where 
  (f,xs) = apps tr
  apps t = case t of
    App f a -> (f2,a:a2) where (f2,a2) = appForm f
    _ -> (t,[])

mkProd :: Context -> Type -> Type
mkProd = flip (foldr (uncurry Prod))

mkApp :: Term -> [Term] -> Term
mkApp = foldl App

mkAbs :: [Ident] -> Term -> Term
mkAbs xs t = foldr Abs t xs

mkDecl :: Term -> Decl
mkDecl typ = (wildIdent, typ)

typeType :: Type
typeType = Sort "Type"

ident2label :: Ident -> Label
ident2label c = LIdent (prIdent c)

----label2ident :: Label -> Ident
----label2ident = identC . prLabel

-- to apply a term operation to every term in a judgement, module, grammar

termOpGF :: Monad m => (Term -> m Term) -> GF -> m GF
termOpGF f g = do 
  ms <- mapMapM fm (gfmodules g)
  return g {gfmodules = ms}
 where
   fm = termOpModule f

termOpModule :: Monad m => (Term -> m Term) -> Module -> m Module
termOpModule f m = do 
  mjs <- mapMapM fj (mjments m)
  return m {mjments = mjs}
 where
   fj = either (liftM Left  . termOpJudgement f) (return . Right)
   
termOpJudgement :: Monad m => (Term -> m Term) -> Judgement -> m Judgement
termOpJudgement f j = do 
  jtyp <- f (jtype j)
  jde <- f (jdef j)
  jpri <- f (jprintname j)
  return $ j {
    jtype = jtyp,
    jdef = jde,
    jprintname = jpri
    }

-- | to define compositional term functions
composSafeOp :: (Term -> Term) -> Term -> Term
composSafeOp op trm = case composOp (mkMonadic op) trm of
  Ok t -> t
  _ -> error "the operation is safe isn't it ?"
 where
 mkMonadic f = return . f

-- | to define compositional monadic term functions
composOp :: Monad m => (Term -> m Term) -> Term -> m Term
composOp co trm = case trm of
   App c a -> 
     do c' <- co c
        a' <- co a
        return (App c' a')
   Abs x b ->
     do b' <- co b
        return (Abs x b')
   Prod x a b -> 
     do a' <- co a
        b' <- co b
        return (Prod x a' b')
   S c a -> 
     do c' <- co c
        a' <- co a
        return (S c' a')
   Table a c -> 
     do a' <- co a
        c' <- co c
        return (Table a' c')
   R r -> 
     do r' <- mapAssignM co r
        return (R r')
   RecType r -> 
     do r' <- mapPairListM (co . snd) r
        return (RecType r')
   P t i ->
     do t' <- co t
        return (P t' i)
   PI t i j ->
     do t' <- co t
        return (PI t' i j)
   ExtR a c -> 
     do a' <- co a
        c' <- co c
        return (ExtR a' c')
   T i cc -> 
     do cc' <- mapPairListM (co . snd) cc
        i'  <- changeTableType co i
        return (T i' cc')
   Eqs cc -> 
     do cc' <- mapPairListM (co . snd) cc
        return (Eqs cc')
   V ty vs ->
     do ty' <- co ty
        vs' <- mapM co vs
        return (V ty' vs')
   Let (x,(mt,a)) b -> 
     do a'  <- co a
        mt' <- case mt of
                 Just t -> co t >>= (return . Just) 
                 _ -> return mt
        b'  <- co b
        return (Let (x,(mt',a')) b')
   C s1 s2 -> 
     do v1 <- co s1 
        v2 <- co s2
        return (C v1 v2)
   Glue s1 s2 -> 
     do v1 <- co s1
        v2 <- co s2
        return (Glue v1 v2)
   Alts (t,aa) ->
     do t' <- co t
        aa' <- mapM (pairM co) aa
        return (Alts (t',aa'))
   FV ts -> mapM co ts >>= return . FV
   _ -> return trm -- covers K, Vr, Cn, Sort

--- just aux to composOp?

mapAssignM :: Monad m => (Term -> m c) -> [Assign] -> m [(Label,(Maybe c,c))]
mapAssignM f = mapM (\ (ls,tv) -> liftM ((,) ls) (g tv))
  where g (t,v) = liftM2 (,) (maybe (return Nothing) (liftM Just . f) t) (f v)

changeTableType :: Monad m => (Type -> m Type) -> TInfo -> m TInfo
changeTableType co i = case i of
    TTyped ty -> co ty >>= return . TTyped
    TComp ty  -> co ty >>= return . TComp
    TWild ty  -> co ty >>= return . TWild
    _ -> return i

---- given in lib?

mapMapM :: (Monad m, Ord k) => (v -> m v) -> Map k v -> m (Map k v)
mapMapM f = 
  liftM fromAscList . mapM (\ (x,y) -> liftM ((,) x) $ f y) . assocs 

