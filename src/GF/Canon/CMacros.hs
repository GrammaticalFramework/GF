module CMacros where

import AbsGFC
import GFC
import qualified Ident as A ---- no need to qualif? 21/9
import qualified Values as V
import qualified MMacros as M
import PrGrammar
import Str

import Operations

import Char
import Monad

-- macros for concrete syntax in GFC that do not need lookup in a grammar

-- how to mark subtrees, dep. on node, position, whether focus
type Marker = V.TrNode -> [Int] -> Bool -> (String, String)

markSubtree :: Marker -> V.TrNode -> [Int] -> Bool -> Term -> Term
markSubtree mk n is = markSubterm . mk n is

-- if no marking is wanted, use the following
noMark :: Marker
noMark _ _ _ = ("","")

-- for vanilla brackets, focus, and position, use
markBracket :: Marker
markBracket n p b = if b then ("[*" ++ show p,"*]") else ("[" ++ show p,"]")

-- for focus only
markFocus :: Marker
markFocus n p b = if b then ("[*","*]") else ("","")

-- for XML, use
markXML :: Marker
markXML n i b = 
  if b 
    then ("<focus" +++ p +++ c ++ ">", "</focus>") 
    else ("<subtree" +++ p +++ c ++ ">", "</subtree>") 
   where 
     c = "type=" ++ prt (M.valNode n)
     p = "position=" ++ (show $ reverse i)

-- for XML in JGF 1, use
markXMLjgf :: Marker
markXMLjgf n p b = 
  if b 
    then ("<focus" +++ c ++ ">", "</focus>") 
    else ("","")
   where 
     c = "type=" ++ prt (M.valNode n)

-- the marking engine
markSubterm :: (String,String) -> Term -> Term
markSubterm (beg, end) t = case t of
  R rs -> R $ map markField rs 
  T ty cs -> T ty [Cas p (mark v) | Cas p v <- cs]
  FV ts -> FV $ map mark ts
  _    -> foldr1 C (tk beg ++ [t] ++ tk end)  -- t : Str guaranteed?
 where
   mark = markSubterm (beg, end)
   markField lt@(Ass l t) = if isLinLabel l then (Ass l (mark t)) else lt
   tk s = if null s then [] else [tK s]

tK :: String -> Term
tK = K . KS

term2patt :: Term -> Err Patt
term2patt trm = case trm of
  Con c aa -> do
    aa' <- mapM term2patt aa
    return (PC c aa')
  R r -> do
    let (ll,aa) = unzip [(l,a) | Ass l a <- r]
    aa' <- mapM term2patt aa
    return (PR (map (uncurry PAss) (zip ll aa')))
  LI x -> return $ PV x
  EInt i -> return $ PI i
  _ -> prtBad "no pattern corresponds to term" trm

patt2term :: Patt -> Term
patt2term p = case p of
  PC x ps -> Con x (map patt2term ps)
  PV x    -> LI x
  PW      -> anyTerm ----
  PR pas  -> R [ Ass lbl (patt2term q) | PAss lbl q <- pas ]
  PI i    -> EInt i

anyTerm :: Term
anyTerm  = LI (A.identC "_") --- should not happen

matchPatt cs0 (FV ts) = liftM FV $ mapM (matchPatt cs0) ts
matchPatt cs0 trm = term2patt trm >>= match cs0 where
  match cs t = 
    case cs of
      Cas ps b  :_ | elem t ps -> return b 
      _:cs'                    -> match cs' t
      []                       -> Bad $ "pattern not found for" +++ prt t 
              +++ "among" ++++ unlines (map prt cs0)  ---- debug 

defLinType :: CType
defLinType = RecType [Lbg (L (A.identC "s")) TStr]

defLindef :: Term
defLindef = R [Ass (L (A.identC "s")) (Arg (A (A.identC "str") 0))]

isDiscontinuousCType :: CType -> Bool
isDiscontinuousCType t = case t of
  RecType rs -> length [t | Lbg _ t <- rs, valTableType t == TStr] > 1
  _ -> True --- does not occur; would not behave well in lin commands

valTableType :: CType -> CType
valTableType t = case t of
  Table _ v -> valTableType v
  _ -> t

strsFromTerm :: Term -> Err [Str]
strsFromTerm t = case t of
  K (KS s) -> return [str s]
  K (KP d vs) -> return $ [Str [TN d [(s,v) | Var s v <- vs]]]
  C s t -> do
    s' <- strsFromTerm s
    t' <- strsFromTerm t
    return [plusStr x y | x <- s', y <- t']
  FV ts -> liftM concat $ mapM strsFromTerm ts
  E -> return [str []]
  _ -> return [str ("BUG[" ++ prt t ++ "]")] ---- debug
----  _ -> prtBad "cannot get Str from term " t

-- recursively collect all branches in a table
allInTable :: Term -> [Term]
allInTable t =  case t of
  T _ ts -> concatMap (\ (Cas _ v) -> allInTable v) ts --- expand ?
  _    -> [t]

-- to gather s-fields; assumes term in normal form, preserves label
allLinFields :: Term -> Err [[(Label,Term)]]
allLinFields trm = case trm of
----  R rs  -> return [[(l,t) | (l,(Just ty,t)) <- rs, isStrType ty]] -- good
  R rs  -> return [[(l,t) | Ass l t <- rs, isLinLabel l]] ---- bad
  FV ts -> do
    lts <- mapM allLinFields ts
    return $ concat lts
  _ -> prtBad "fields can only be sought in a record not in" trm

---- deprecated
isLinLabel l = case l of
     L (A.IC ('s':cs)) | all isDigit cs -> True
     -- peb (28/4-04), for MCFG grammars to work:
     L (A.IC cs) | null cs || head cs `elem` ".!" -> True
     _ -> False

-- to gather ultimate cases in a table; preserves pattern list
allCaseValues :: Term -> [([Patt],Term)]
allCaseValues trm = case trm of
  T _ cs -> [(p:ps, t) | Cas pp t0 <- cs, p <- pp, (ps,t) <- allCaseValues t0]
  _      -> [([],trm)]

-- to gather all linearizations; assumes normal form, preserves label and args
allLinValues :: Term -> Err [[(Label,[([Patt],Term)])]]
allLinValues trm = do
  lts <- allLinFields trm
  mapM (mapPairsM (return . allCaseValues)) lts

redirectIdent n f@(CIQ _ c) = CIQ n c

ciq n f = CIQ n f

wordsInTerm :: Term -> [String]
wordsInTerm trm = filter (not . null) $ case trm of
   K (KS s) -> [s]
   S c _   -> wo c
   R rs    -> concat [wo t | Ass _ t <- rs]
   T _ cs  -> concat [wo t | Cas _ t <- cs]
   C s t   -> wo s ++ wo t
   FV ts   -> concatMap wo ts
   K (KP ss vs) -> ss ++ concat [s | Var s _ <- vs]
   P t _   -> wo t --- not needed ?
   _       -> []
 where wo = wordsInTerm

onTokens :: (String -> String) -> Term -> Term
onTokens f t = case t of
   K (KS s) -> K (KS (f s))
   K (KP ss vs) -> K (KP (map f ss) [Var (map f x) (map f y) | Var x y <- vs])
   _ -> composSafeOp (onTokens f) t


-- to define compositional term functions

composSafeOp :: (Term -> Term) -> Term -> Term
composSafeOp op trm = case composOp (mkMonadic op) trm of
  Ok t -> t
  _ -> error "the operation is safe isn't it ?"
 where
 mkMonadic f = return . f

composOp :: Monad m => (Term -> m Term) -> Term -> m Term
composOp co trm = 
 case trm of
  Con x as ->
      do
      as' <- mapM co as
      return (Con x as')
  R as -> 
      do
      let onAss (Ass l t) = liftM (Ass l) (co t)
      as' <- mapM onAss as
      return (R as')
  P a x ->
      do
      a' <- co a
      return (P a' x)
  T x as ->
      do
      let onCas (Cas ps t) = liftM (Cas ps) (co t)
      as' <- mapM onCas as
      return (T x as')
  S a b ->
      do
      a' <- co a
      b' <- co b
      return (S a' b')
  C a b ->
      do
      a' <- co a
      b' <- co b
      return (C a' b')
  FV as -> 
      do
      as' <- mapM co as
      return (FV as')
  _ -> return trm -- covers Arg, I, LI, K, E
