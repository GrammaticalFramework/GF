----------------------------------------------------------------------
-- |
-- Module      : MkGFC
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/27 21:05:17 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.13 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Canon.MkGFC (prCanonModInfo, prCanon, prCanonMGr,
	      canon2grammar, grammar2canon, buildCanonGrammar,
	      info2mod,
	      trExp, rtExp, rtQIdent) where

import GF.Canon.GFC
import GF.Canon.AbsGFC
import qualified GF.Grammar.Abstract as A
import GF.Grammar.PrGrammar

import GF.Infra.Ident
import GF.Data.Operations
import qualified GF.Infra.Modules as M

prCanonModInfo :: CanonModule -> String
prCanonModInfo = prt . info2mod

prCanon :: CanonGrammar -> String
prCanon = unlines . map prCanonModInfo . M.modules

prCanonMGr :: CanonGrammar -> String
prCanonMGr g = header ++++ prCanon g where
  header = case M.greatestAbstract g of
    Just a -> prt (MGr (M.allConcretes g a) a [])
    _ -> []

canon2grammar :: Canon -> CanonGrammar
canon2grammar (MGr _ _ modules) = canon2grammar (Gr modules) ---- ignoring the header
canon2grammar (Gr modules) = M.MGrammar $ map mod2info modules

mod2info m = case m of
    Mod mt e os flags defs -> 
      let defs' = buildTree $ map def2info defs
          (a,mt') = case mt of
            MTAbs a -> (a,M.MTAbstract)
            MTRes a -> (a,M.MTResource)
            MTCnc a x -> (a,M.MTConcrete x)
            MTTrans a x y -> (a,M.MTTransfer (M.oSimple x) (M.oSimple y))
      in (a,M.ModMod (M.Module mt' M.MSComplete flags (ee e) (oo os) defs'))
 where
  ee (Ext m) = m
  ee _ = []
  oo (Opens ms) = map M.oSimple ms
  oo _ = []

grammar2canon :: CanonGrammar -> Canon
grammar2canon (M.MGrammar modules) = Gr $ map info2mod modules 

info2mod :: (Ident, M.ModInfo Ident Flag Info) -> Module
info2mod m = case m of
    (a, M.ModMod (M.Module mt _ flags me os defs)) -> 
      let defs' = map info2def $ tree2list defs 
          mt'   = case mt of
             M.MTAbstract -> MTAbs a
             M.MTResource -> MTRes a
             M.MTConcrete x -> MTCnc a x
             M.MTTransfer (M.OSimple _ x) (M.OSimple _ y) -> MTTrans a x y
      in
        Mod mt' (gfcE me) (gfcO os) flags defs'
 where
  gfcE = ifNull NoExt Ext
  gfcO os = if null os then NoOpens else Opens [m | M.OSimple _ m <- os]


-- these translations are meant to be trivial

defs2infos = sorted2tree . map def2info

def2info d = case d of
  AbsDCat c cont fs -> (c,AbsCat (trCont cont) (trFs fs))
  AbsDFun c ty df   -> (c,AbsFun (trExp ty) (trExp df))
  AbsDTrans c t     -> (c,AbsTrans (trExp t))
  ResDPar c    df   -> (c,ResPar df)
  ResDOper c ty df  -> (c,ResOper ty df)
  CncDCat c ty df pr   -> (c, CncCat ty df pr)
  CncDFun f c xs li pr -> (f, CncFun c xs li pr)
  AnyDInd c b m        -> (c, AnyInd (b == Canon) m)

-- from file to internal

trCont cont = [(x,trExp t) | Decl x t <- cont]

trFs = map trQIdent

trExp :: Exp -> A.Term
trExp t = case t of
  EProd x a b -> A.Prod x (trExp a) (trExp b)
  EAbs  x   b -> A.Abs  x (trExp b)
  EApp  f a   -> A.App  (trExp f)  (trExp a)
  EEq eqs     -> A.Eqs [(map trPt ps, trExp e) | Equ ps e <- eqs]
  EData       -> A.EData
  _    -> trAt t
 where
  trAt (EAtom t) = case t of
    AC c   -> (uncurry A.Q)  $ trQIdent c
    AD c   -> (uncurry A.QC) $ trQIdent c
    AV v   -> A.Vr v
    AM i   -> A.Meta $ A.MetaSymb $ fromInteger i
    AT s   -> A.Sort $ prt s
    AS s   -> A.K s
    AI i   -> A.EInt $ fromInteger i
  trPt p = case p of
    APC mc ps -> let (m,c) = trQIdent mc in A.PP m c (map trPt ps)
    APV x -> A.PV x
    APS s -> A.PString s
    API i -> A.PInt $ fromInteger i
    APW   -> A.PW

trQIdent (CIQ m c) = (m,c)

-- from internal to file

infos2defs = map info2def . tree2list

info2def d = case d of
  (c,AbsCat cont fs)    -> AbsDCat c (rtCont cont) (rtFs fs)
  (c,AbsFun ty df)      -> AbsDFun c (rtExp ty) (rtExp df)
  (c,AbsTrans t)        -> AbsDTrans c (rtExp t)
  (c,ResPar    df)      -> ResDPar c df
  (c,ResOper ty df)     -> ResDOper c ty df
  (c,CncCat ty df pr)   -> CncDCat c ty df pr
  (f,CncFun c xs li pr) -> CncDFun f c xs li pr
  (c,AnyInd b m)        -> AnyDInd c (if b then Canon else NonCan) m

rtCont cont = [Decl (rtIdent x) (rtExp t) | (x,t) <- cont]

rtFs = map rtQIdent

rtExp :: A.Term -> Exp
rtExp t = case t of
  A.Prod x a b -> EProd (rtIdent x) (rtExp a) (rtExp b)
  A.Abs  x   b -> EAbs  (rtIdent x) (rtExp b)
  A.App  f a   -> EApp  (rtExp f) (rtExp a)
  A.Eqs eqs    -> EEq   [Equ (map rtPt ps) (rtExp e) | (ps,e) <- eqs]
  A.EData      -> EData
  _ -> EAtom $ rtAt t
 where
  rtAt t = case t of
    A.Q m c        -> AC $ rtQIdent (m,c)
    A.QC m c       -> AD $ rtQIdent (m,c)
    A.Vr v         -> AV v
    A.Meta i       -> AM $ toInteger $ A.metaSymbInt i
    A.Sort "Type"  -> AT SType
    A.K s          -> AS s
    A.EInt i       -> AI $ toInteger i
    _ -> error $ "MkGFC.rt not defined for" +++ show t
  rtPt p = case p of
    A.PP m c ps -> APC (rtQIdent (m,c)) (map rtPt ps)
    A.PV x      -> APV x
    A.PString s -> APS s
    A.PInt i    -> API $ toInteger i
    A.PW        -> APW
    _ -> error $ "MkGFC.rt not defined for" +++ show p


rtQIdent :: (Ident, Ident) -> CIdent
rtQIdent (m,c) = CIQ (rtIdent m) (rtIdent c)
rtIdent x 
  | isWildIdent x = identC "h_" --- needed in declarations
  | otherwise = identC $ prt x ---

-- the following is called in GetGFC to read gfc files line
-- by line. It does not save memory, though, and is therefore
-- not used.

buildCanonGrammar :: Int -> CanonGrammar -> Line -> (CanonGrammar,Int)
buildCanonGrammar n gr0 line = mgr $ case line of
-- LMulti ids id
  LHeader mt ext op -> newModule mt ext op
  LFlag f@(Flg (IC "modulesize") (IC n)) -> initModule f $ read $ tail n
  LFlag flag        -> newFlag flag
  LDef def          -> newDef $ def2info def
  LEnd              -> cleanNames
  _                 -> M.modules gr0
 where
   newModule mt ext op = mod2info (Mod mt ext op [] []) : mods
   initModule f i = case actm of
     (name, M.ModMod (M.Module mt com flags ee oo defs)) ->
       (name, M.ModMod (M.Module mt com (f:flags) ee oo (newtree i))) : tmods
   newFlag f = case actm of
     (name, M.ModMod (M.Module mt com flags ee oo defs)) ->
       (name, M.ModMod (M.Module mt com (f:flags) ee oo defs)) : tmods
   newDef d = case actm of
     (name, M.ModMod (M.Module mt com flags ee oo defs)) ->
       (name, M.ModMod (M.Module mt com flags ee oo 
          (upd (padd 8 n) d defs))) : tmods
   cleanNames = case actm of
     (name, M.ModMod (M.Module mt com flags ee oo defs)) ->
       (name, M.ModMod (M.Module mt com (reverse flags) ee oo 
          (mapTree (\ (IC f,t) -> (IC (drop 8 f),t)) defs))) : tmods

   actm = head mods -- only used when a new mod has been created
   mods = M.modules gr0
   tmods = tail mods

   mgr ms = (M.MGrammar ms, case line of
     LDef _ -> n+1
     LEnd   -> 1
     _ -> n
     )

   -- create an initial tree with who-cares value
   newtree (i :: Int) = sorted2tree [
     (padd 8 k, ResPar []) | 
     k <- [1..i]] --- padd (length (show i))

   padd l k = let sk = show k in identC (replicate (l - length sk) '0' ++ sk)

   upd n d@(f,t) defs = case defs of
     NT -> BT (merg n f,t) NT NT --- should not happen
     BT c@(a,_) left right 
       | n < a  -> let left'  = upd n d left  in BT c left' right 
       | n > a  -> let right' = upd n d right in BT c left right' 
       | otherwise -> BT (merg n f,t) left right
   merg (IC n) (IC f) = IC (n ++ f)
