----------------------------------------------------------------------
-- |
-- Module      : CMacros
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/16 13:56:12 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.28 $
--
-- Macros for building and analysing terms in GFC concrete syntax.
--
-- macros for concrete syntax in GFC that do not need lookup in a grammar
-----------------------------------------------------------------------------

module GF.Canon.CMacros where

import GF.Infra.Ident
import GF.Canon.AbsGFC
import GF.Canon.GFC
import qualified GF.Infra.Ident as A ---- no need to qualif? 21/9
import qualified GF.Grammar.Values as V
import qualified GF.Grammar.MMacros as M
import GF.Grammar.PrGrammar
import GF.Data.Str

import GF.Data.Operations

import Data.Char
import Control.Monad

-- | how to mark subtrees, dep. on node, position, whether focus
type JustMarker = V.TrNode -> [Int] -> Bool -> (String, String)

-- | also to process the text (needed for escapes e.g. in XML)
type Marker = (JustMarker, Maybe (String -> String))

defTMarker :: JustMarker -> Marker
defTMarker = flip (curry id) Nothing

markSubtree :: Marker -> V.TrNode -> [Int] -> Bool -> Term -> Term
markSubtree (mk,esc) n is = markSubterm esc . mk n is

escapeMkString :: Marker -> Maybe (String -> String)
escapeMkString = snd

-- | if no marking is wanted, use the following
noMark :: Marker
noMark = defTMarker mk where
  mk _ _ _ = ("","")

-- | for vanilla brackets, focus, and position, use
markBracket :: Marker
markBracket = defTMarker mk where
  mk n p b = if b then ("[*" ++ show p,"*]") else ("[" ++ show p,"]")

-- | for focus only
markFocus :: Marker
markFocus = defTMarker mk where
  mk n p b = if b then ("[*","*]") else ("","")

-- | for XML, use
markJustXML :: JustMarker
markJustXML n i b = 
  if b 
    then ("<focus"   +++ p +++ c ++ s ++ ">", "</focus>") 
    else ("<subtree" +++ p +++ c ++ s ++ ">", "</subtree>") 
   where 
     c = "type=" ++ prt (M.valNode n)
     p = "position=" ++ (show $ reverse i)
     s = if (null (M.constrsNode n)) then "" else " status=incorrect"

markXML :: Marker
markXML = (markJustXML, Just esc) where
  esc s = case s of
   '\\':'<':cs  -> '\\':'<':esc cs
   '\\':'>':cs  -> '\\':'>':esc cs
   '\\':'\\':cs -> '\\':'\\':esc cs
   ----- the first 3 needed because marking may revisit; needs to be fixed

   '<':cs  -> '\\':'<':esc cs
   '>':cs  -> '\\':'>':esc cs
   '\\':cs -> '\\':'\\':esc cs
   c  :cs  -> c     :esc cs
   _ -> s

-- | for XML in JGF 1, use
markXMLjgf :: Marker
markXMLjgf = defTMarker mk where
 mk n p b = 
  if b 
    then ("<focus" +++ c ++ ">", "</focus>") 
    else ("","")
   where 
     c = "type=" ++ prt (M.valNode n)

-- | the marking engine
markSubterm :: Maybe (String -> String) -> (String,String) -> Term -> Term
markSubterm esc (beg, end) t = case t of
  R rs -> R $ map markField rs 
  T ty cs -> T ty [Cas p (mark v) | Cas p v <- cs]
  FV ts -> FV $ map mark ts
  _    -> foldr1 C (tm beg ++ [mkEscIf t] ++ tm end)  -- t : Str guaranteed?
 where
   mark = markSubterm esc (beg, end)
   markField lt@(Ass l t) = if isLinLabel l then (Ass l (mark t)) else lt
   tm s = if null s then [] else [tM s]
   mkEscIf t = case esc of
     Just f -> mkEsc f t
     _ -> t
   mkEsc f t = case t of
     K (KS s) -> K (KS (f s))
     C u v    -> C (mkEsc f u) (mkEsc f v)
     FV ts    -> FV (map (mkEsc f) ts)
     _ -> t ---- do we need to look at other cases?

tK,tM :: String -> Term
tK = K . KS
tM = K . KM

term2patt :: Term -> Err Patt
term2patt trm = case trm of
  Par c aa -> do
    aa' <- mapM term2patt aa
    return (PC c aa')
  R r -> do
    let (ll,aa) = unzip [(l,a) | Ass l a <- r]
    aa' <- mapM term2patt aa
    return (PR (map (uncurry PAss) (zip ll aa')))
  LI x -> return $ PV x
  EInt i -> return $ PI i
  FV (t:_) -> term2patt t ----
  _ -> prtBad "no pattern corresponds to term" trm

patt2term :: Patt -> Term
patt2term p = case p of
  PC x ps -> Par x (map patt2term ps)
  PV x    -> LI x
  PW      -> anyTerm ----
  PR pas  -> R [ Ass lbl (patt2term q) | PAss lbl q <- pas ]
  PI i    -> EInt i

anyTerm :: Term
anyTerm  = LI (A.identC "_") --- should not happen

matchPatt :: [Case] -> Term -> Err Term
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
  K (KM s) -> return [str s]
  K (KP d vs) -> return $ [Str [TN d [(s,v) | Var s v <- vs]]]
  C s t -> do
    s' <- strsFromTerm s
    t' <- strsFromTerm t
    return [plusStr x y | x <- s', y <- t']
  FV ts -> liftM concat $ mapM strsFromTerm ts
  E -> return [str []]
  _ -> return [str ("BUG[" ++ prt t ++ "]")] ---- debug
----  _ -> prtBad "cannot get Str from term " t

-- | recursively collect all branches in a table
allInTable :: Term -> [Term]
allInTable t =  case t of
  T _ ts -> concatMap (\ (Cas _ v) -> allInTable v) ts --- expand ?
  _    -> [t]

-- | to gather s-fields; assumes term in normal form, preserves label
allLinFields :: Term -> Err [[(Label,Term)]]
allLinFields trm = case trm of
----  R rs  -> return [[(l,t) | (l,(Just ty,t)) <- rs, isStrType ty]] -- good
  R rs  -> return [[(l,t) | Ass l t <- rs, isLinLabel l]] ---- bad
  FV ts -> do
    lts <- mapM allLinFields ts
    return $ concat lts

  T _ ts -> liftM concat $ mapM allLinFields [t | Cas _ t <- ts]
  V _ ts -> liftM concat $ mapM allLinFields ts
  S t _  -> allLinFields t

  _ -> prtBad "fields can only be sought in a record not in" trm

-- | deprecated
isLinLabel :: Label -> Bool
isLinLabel l = case l of
     L (A.IC ('s':cs)) | all isDigit cs -> True
     -- peb (28/4-04), for MCFG grammars to work:
     L (A.IC cs) | null cs || head cs `elem` ".!" -> True
     _ -> False

-- | to gather ultimate cases in a table; preserves pattern list
allCaseValues :: Term -> [([Patt],Term)]
allCaseValues trm = case trm of
  T _ cs -> [(p:ps, t) | Cas pp t0 <- cs, p <- pp, (ps,t) <- allCaseValues t0]
  _      -> [([],trm)]

-- | to gather all linearizations; assumes normal form, preserves label and args
allLinValues :: Term -> Err [[(Label,[([Patt],Term)])]]
allLinValues trm = do
  lts <- allLinFields trm
  mapM (mapPairsM (return . allCaseValues)) lts

redirectIdent :: A.Ident -> CIdent -> CIdent
redirectIdent n f@(CIQ _ c) = CIQ n c

ciq :: A.Ident -> A.Ident -> CIdent
ciq n f = CIQ n f

wordsInTerm :: Term -> [String]
wordsInTerm trm = filter (not . null) $ case trm of
   K (KS s) -> [s]
   S c _   -> wo c
   R rs    -> concat [wo t | Ass _ t <- rs]
   T _ cs  -> concat [wo t | Cas _ t <- cs]
   V _ cs  -> concat [wo t | t <- cs]
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

-- | to define compositional term functions
composSafeOp :: (Term -> Term) -> Term -> Term
composSafeOp op trm = case composOp (mkMonadic op) trm of
  Ok t -> t
  _ -> error "the operation is safe isn't it ?"
 where
 mkMonadic f = return . f

-- | to define compositional term functions
composOp :: Monad m => (Term -> m Term) -> Term -> m Term
composOp co trm = 
 case trm of
  Par x as ->
      do
      as' <- mapM co as
      return (Par x as')
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
  V x as -> 
      do 
      as' <- mapM co as
      return (V x as')
  _ -> return trm -- covers Arg, I, LI, K, E
