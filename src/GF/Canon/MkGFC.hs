module MkGFC where

import GFC
import AbsGFC
import qualified Abstract as A
import PrGrammar

import Ident
import Operations
import qualified Modules as M

prCanonModInfo :: CanonModule -> String
prCanonModInfo = prt . info2mod

canon2grammar :: Canon -> CanonGrammar
canon2grammar (Gr modules) = M.MGrammar $ map mod2info modules where
  mod2info m = case m of
    Mod mt e os flags defs -> 
      let defs' = buildTree $ map def2info defs
          (a,mt') = case mt of
            MTAbs a -> (a,M.MTAbstract)
            MTRes a -> (a,M.MTResource)
            MTCnc a x -> (a,M.MTConcrete x)
      in (a,M.ModMod (M.Module mt' flags (ee e) (oo os) defs'))
  ee (Ext m) = Just m
  ee _ = Nothing
  oo (Opens ms) = map M.OSimple ms
  oo _ = []

grammar2canon :: CanonGrammar -> Canon
grammar2canon (M.MGrammar modules) = Gr $ map info2mod modules 

info2mod m = case m of
    (a, M.ModMod (M.Module mt flags me os defs)) -> 
      let defs' = map info2def $ tree2list defs 
          mt'   = case mt of
             M.MTAbstract -> MTAbs a
             M.MTResource -> MTRes a
             M.MTConcrete x -> MTCnc a x
      in
        Mod mt' (gfcE me) (gfcO os) flags defs'
 where
  gfcE = maybe NoExt Ext
  gfcO os = if null os then NoOpens else Opens [m | M.OSimple m <- os]


-- these translations are meant to be trivial

defs2infos = sorted2tree . map def2info

def2info d = case d of
  AbsDCat c cont fs -> (c,AbsCat (trCont cont) (trFs fs))
  AbsDFun c ty df   -> (c,AbsFun (trExp ty) (trExp df))
  ResDPar c    df   -> (c,ResPar df)
  ResDOper c ty df  -> (c,ResOper ty df)
  CncDCat c ty df pr   -> (c, CncCat ty df pr)
  CncDFun f c xs li pr -> (f, CncFun c xs li pr)
  AnyDInd c b m        -> (c, AnyInd (b == Canon) m)

-- from file to internal

trCont cont = [(x,trExp t) | Decl x t <- cont]

trFs = map trQIdent

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
  (c,ResPar    df)      -> ResDPar c df
  (c,ResOper ty df)     -> ResDOper c ty df
  (c,CncCat ty df pr)   -> CncDCat c ty df pr
  (f,CncFun c xs li pr) -> CncDFun f c xs li pr
  (c,AnyInd b m)        -> AnyDInd c (if b then Canon else NonCan) m

rtCont cont = [Decl (rtIdent x) (rtExp t) | (x,t) <- cont]

rtFs = map rtQIdent

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


rtQIdent (m,c) = CIQ (rtIdent m) (rtIdent c)
rtIdent x 
  | isWildIdent x = identC "h_" --- needed in declarations
  | otherwise = identC $ prt x ---
