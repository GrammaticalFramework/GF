----------------------------------------------------------------------
-- |
-- Module      : MMacros
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/10 12:49:13 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.9 $
--
-- some more abstractions on grammars, esp. for Edit
-----------------------------------------------------------------------------

module GF.Grammar.MMacros where

import GF.Data.Operations
--import GF.Data.Zipper

import GF.Grammar.Grammar
import GF.Grammar.Printer
import GF.Infra.Ident
import GF.Compile.Refresh
import GF.Grammar.Values
----import GrammarST
import GF.Grammar.Macros

import Control.Monad
import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint

{-
nodeTree :: Tree -> TrNode
argsTree :: Tree -> [Tree]

nodeTree (Tr (n,_)) = n
argsTree (Tr (_,ts)) = ts

isFocusNode    :: TrNode -> Bool
bindsNode      :: TrNode -> Binds
atomNode       :: TrNode -> Atom
valNode        :: TrNode -> Val
constrsNode    :: TrNode -> Constraints
metaSubstsNode :: TrNode -> MetaSubst

isFocusNode    (N (_,_,_,_,b)) = b
bindsNode      (N (b,_,_,_,_)) = b
atomNode       (N (_,a,_,_,_)) = a
valNode        (N (_,_,v,_,_)) = v
constrsNode    (N (_,_,_,(c,_),_)) = c
metaSubstsNode (N (_,_,_,(_,m),_)) = m

atomTree :: Tree -> Atom
valTree  :: Tree -> Val

atomTree = atomNode . nodeTree 
valTree  = valNode  . nodeTree

mkNode :: Binds -> Atom -> Val -> (Constraints, MetaSubst) -> TrNode
mkNode binds atom vtyp cs = N (binds,atom,vtyp,cs,False)

metasTree :: Tree ->  [MetaId]
metasTree = concatMap metasNode . scanTree where
  metasNode n = [m | AtM m <- [atomNode n]] ++ map fst (metaSubstsNode n)

varsTree :: Tree ->  [(Var,Val)]
varsTree t = [(x,v) | N (_,AtV x,v,_,_) <- scanTree t]

constrsTree :: Tree -> Constraints
constrsTree = constrsNode . nodeTree

allConstrsTree :: Tree -> Constraints
allConstrsTree = concatMap constrsNode . scanTree

changeConstrs :: (Constraints -> Constraints) -> TrNode -> TrNode
changeConstrs f (N (b,a,v,(c,m),x)) = N (b,a,v,(f c, m),x)

changeMetaSubst :: (MetaSubst -> MetaSubst) -> TrNode -> TrNode
changeMetaSubst f (N (b,a,v,(c,m),x)) = N (b,a,v,(c, f m),x)

changeAtom :: (Atom -> Atom) -> TrNode -> TrNode
changeAtom f (N (b,a,v,(c,m),x)) = N (b,f a,v,(c, m),x)

-- * on the way to Edit

uTree :: Tree
uTree = Tr (uNode, []) -- unknown tree

uNode :: TrNode
uNode = mkNode [] uAtom uVal ([],[])


uAtom :: Atom
uAtom = AtM meta0

mAtom :: Atom
mAtom = AtM meta0
-}

type Var = Ident

uVal :: Val
uVal = vClos uExp

vClos :: Exp -> Val
vClos = VClos []

uExp :: Exp
uExp = Meta meta0

mExp, mExp0 :: Exp
mExp  = Meta meta0
mExp0 = mExp

meta2exp :: MetaId -> Exp
meta2exp = Meta
{-
atomC :: Fun -> Atom
atomC = AtC

funAtom :: Atom -> Err Fun
funAtom a = case a of
  AtC f -> return f
  _ -> prtBad "not function head" a

atomIsMeta :: Atom -> Bool
atomIsMeta atom = case atom of
  AtM _ -> True
  _   -> False

getMetaAtom :: Atom -> Err MetaId
getMetaAtom a = case a of
  AtM m -> return m
  _ -> Bad "the active node is not meta"
-}
cat2val :: Context -> Cat -> Val
cat2val cont cat = vClos $ mkApp (qq cat) [Meta i | i <- [1..length cont]]

val2cat :: Val -> Err Cat
val2cat v = val2exp v >>= valCat

substTerm  :: [Ident] -> Substitution -> Term -> Term
substTerm ss g c = case c of
  Vr x        -> maybe c id $ lookup x g
  App f a     -> App (substTerm ss g f) (substTerm ss g a)
  Abs b x t   -> let y = mkFreshVarX ss x in 
                   Abs b y (substTerm (y:ss) ((x, Vr y):g) t)
  Prod b x a t  -> let y = mkFreshVarX ss x in 
                   Prod b y (substTerm ss g a) (substTerm (y:ss) ((x,Vr y):g) t)
  _           -> c

metaSubstExp :: MetaSubst -> [(MetaId,Exp)]
metaSubstExp msubst = [(m, errVal (meta2exp m) (val2expSafe v)) | (m,v) <- msubst]

-- * belong here rather than to computation

substitute :: [Var] -> Substitution -> Exp -> Err Exp
substitute v s = return . substTerm v s

alphaConv :: [Var] -> (Var,Var) -> Exp -> Err Exp ---
alphaConv oldvars (x,x') = substitute (x:x':oldvars) [(x,Vr x')]

alphaFresh :: [Var] -> Exp -> Err Exp
alphaFresh vs = refreshTermN $ maxVarIndex vs

-- | done in a state monad
alphaFreshAll :: [Var] -> [Exp] -> Err [Exp]
alphaFreshAll vs = mapM $ alphaFresh vs 

-- | for display
val2exp :: Val -> Err Exp
val2exp = val2expP False 

-- | for type checking
val2expSafe :: Val -> Err Exp
val2expSafe = val2expP True  

val2expP :: Bool -> Val -> Err Exp
val2expP safe v = case v of

  VClos g@(_:_) e@(Meta _) -> if safe 
                              then Bad (render (text "unsafe value substitution" <+> ppValue Unqualified 0 v))
                              else substVal g e
  VClos g e -> substVal g e
  VApp f c  -> liftM2 App (val2expP safe f) (val2expP safe c)
  VCn c     -> return $ qq c
  VGen i x  -> if safe 
               then Bad (render (text "unsafe val2exp" <+> ppValue Unqualified 0 v))
               else return $ Vr $ x  --- in editing, no alpha conversions presentv
  VRecType xs->do xs <- mapM (\(l,v) -> val2expP safe v >>= \e -> return (l,e)) xs
                  return (RecType xs)
  VType     -> return typeType
 where 
   substVal g e = mapPairsM (val2expP safe) g >>= return . (\s -> substTerm [] s e)

isConstVal :: Val -> Bool
isConstVal v = case v of
  VApp f c   -> isConstVal f && isConstVal c
  VCn _      -> True
  VClos [] e -> null $ freeVarsExp e  
  _          -> False --- could be more liberal

mkProdVal :: Binds -> Val -> Err Val ---
mkProdVal bs v = do 
  bs' <- mapPairsM val2exp bs
  v'  <- val2exp v
  return $ vClos $ foldr (uncurry (Prod Explicit)) v' bs'

freeVarsExp :: Exp -> [Ident]
freeVarsExp e = case e of
  Vr x -> [x]
  App f c -> freeVarsExp f ++ freeVarsExp c
  Abs _ x b -> filter (/=x) (freeVarsExp b)
  Prod _ x a b -> freeVarsExp a ++ filter (/=x) (freeVarsExp b)
  _ -> [] --- thus applies to abstract syntax only

mkJustProd :: Context -> Term -> Term
mkJustProd cont typ = mkProd (cont,typ,[])

int2var :: Int -> Ident
int2var = identC . BS.pack . ('$':) . show

meta0 :: MetaId
meta0 = 0

termMeta0 :: Term
termMeta0 = Meta meta0

identVar :: Term -> Err Ident
identVar (Vr x) = return x
identVar _ = Bad "not a variable"


-- | light-weight rename for user interaction; also change names of internal vars
qualifTerm :: Ident -> Term -> Term
qualifTerm m  = qualif [] where
  qualif xs t = case t of
    Abs b x t -> let x' = chV x in Abs b x' $ qualif (x':xs) t
    Prod b x a t -> Prod b x (qualif xs a) $ qualif (x:xs) t
    Vr x -> let x' = chV x in if (elem x' xs) then (Vr x') else (Q m x) 
    Cn c  -> Q m c
    Con c -> QC m c
    _ -> composSafeOp (qualif xs) t
  chV x = string2var $ ident2bs x
    
string2var :: BS.ByteString -> Ident
string2var s = case BS.unpack s of
  c:'_':i -> identV (BS.singleton c) (readIntArg i) ---
  _       -> identC s

-- | reindex variables so that they tell nesting depth level
reindexTerm :: Term -> Term
reindexTerm = qualif (0,[]) where
  qualif dg@(d,g) t = case t of
    Abs b x t    -> let x' = ind x d in Abs b x' $ qualif (d+1, (x,x'):g) t
    Prod b x a t -> let x' = ind x d in Prod b x' (qualif dg a) $ qualif (d+1, (x,x'):g) t
    Vr x       -> Vr $ look x g
    _ -> composSafeOp (qualif dg) t
  look x  = maybe x id . lookup x --- if x is not in scope it is unchanged
  ind x d = identC $ ident2bs x `BS.append` BS.singleton '_' `BS.append` BS.pack (show d)

{-
-- this method works for context-free abstract syntax
-- and is meant to be used in simple embedded GF applications

exp2tree :: Exp -> Err Tree
exp2tree e = do
  (bs,f,xs) <- termForm e
  cont <- case bs of
    [] -> return []
    _  -> prtBad "cannot convert bindings in" e
  at <- case f of
    Q  m c -> return $ AtC (m,c)
    QC m c -> return $ AtC (m,c)
    Meta m -> return $ AtM m
    K s    -> return $ AtL s
    EInt n -> return $ AtI n
    EFloat n -> return $ AtF n
    _ -> prtBad "cannot convert to atom" f
  ts <- mapM exp2tree xs
  return $ Tr (N (cont,at,uVal,([],[]),True),ts)
-}
