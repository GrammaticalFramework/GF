----------------------------------------------------------------------
-- |
-- Module      : GrammarToSource
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/04 11:05:07 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.23 $
--
-- From internal source syntax to BNFC-generated (used for printing).
-----------------------------------------------------------------------------

module GF.Source.GrammarToSource ( trGrammar,
			 trModule,
			 trAnyDef,
			 trLabel,
			 trt, tri, trp
		       ) where

import GF.Data.Operations
import GF.Grammar.Grammar
import GF.Infra.Modules
import GF.Infra.Option
import qualified GF.Source.AbsGF as P
import GF.Infra.Ident

-- | AR 13\/5\/2003
--
-- translate internal to parsable and printable source
trGrammar :: SourceGrammar -> P.Grammar
trGrammar (MGrammar ms) = P.Gr (map trModule ms) -- no includes

trModule :: (Ident,SourceModInfo) -> P.ModDef
trModule (i,mo) = case mo of
  ModMod m -> P.MModule compl typ body where
    compl = case mstatus m of
      MSIncomplete -> P.CMIncompl
      _ -> P.CMCompl
    i' = tri i
    typ = case typeOfModule mo of
      MTResource -> P.MTResource i'
      MTAbstract -> P.MTAbstract i'
      MTConcrete a -> P.MTConcrete i' (tri a)
      MTTransfer a b -> P.MTTransfer i' (trOpen a) (trOpen b)
      MTInstance a -> P.MTInstance i' (tri a)
      MTInterface -> P.MTInterface i'
    body = P.MBody 
             (trExtends (extend m)) 
             (mkOpens (map trOpen (opens m)))
             (mkTopDefs (concatMap trAnyDef (tree2list (jments m)) ++ map trFlag (flags m)))

trExtends :: [(Ident,MInclude Ident)] -> P.Extend
trExtends [] = P.NoExt 
trExtends es = (P.Ext $ map tre es) where
  tre (i,c) = case c of 
    MIAll       -> P.IAll   (tri i)
    MIOnly is   -> P.ISome  (tri i) (map tri is)
    MIExcept is -> P.IMinus (tri i) (map tri is)

---- this has to be completed with other mtys
forName (MTConcrete a) = tri a

trOpen :: OpenSpec Ident -> P.Open
trOpen o = case o of
  OSimple OQNormal i -> P.OName (tri i)
  OSimple q i -> P.OQualQO (trQualOpen q) (tri i)
  OQualif q i j -> P.OQual (trQualOpen q) (tri i) (tri j)

trQualOpen q = case q of
  OQNormal -> P.QOCompl
  OQIncomplete -> P.QOIncompl
  OQInterface -> P.QOInterface


mkOpens ds = if null ds then P.NoOpens else P.OpenIn ds
mkTopDefs ds = ds

trAnyDef :: (Ident,Info) -> [P.TopDef]
trAnyDef (i,info) = let i' = tri i in case info of
  AbsCat (Yes co) pd -> [P.DefCat [P.SimpleCatDef i' (map trDecl co)]]
  AbsFun (Yes ty) (Yes EData) -> [P.DefFunData [P.FunDef [i'] (trt ty)]]
  AbsFun (Yes ty) pt -> [P.DefFun [P.FunDef [i'] (trt ty)]] ++ case pt of
    Yes t -> [P.DefDef [P.DDef [mkName i'] (trt t)]]
    _ -> []
  AbsFun (May b)  _ -> [P.DefFun [P.FunDef [i'] (P.EIndir (tri b))]]
  ---- don't destroy definitions!
  AbsTrans f -> [P.DefTrans [P.DDef [mkName i'] (trt f)]]

  ResOper pty ptr -> [P.DefOper [trDef i' pty ptr]]
  ResParam pp -> [P.DefPar [case pp of
    Yes (ps,_) -> P.ParDefDir i' [P.ParConstr (tri c) (map trDecl co) | (c,co) <- ps]
    May b  -> P.ParDefIndir i' $ tri b
    _      -> P.ParDefAbs i']]

  ResOverload tysts -> 
    [P.DefOper [P.DDef [mkName i'] (
      P.EApp (P.EIdent $ identC "overload") 
        (P.ERecord [P.LDFull [i'] (trt ty) (trt fu) | (ty,fu) <- tysts]))]]

  CncCat (Yes ty) Nope _ -> 
    [P.DefLincat [P.PrintDef [mkName i'] (trt ty)]] 
  CncCat pty ptr ppr -> 
    [P.DefLindef [trDef i' pty ptr]] ++
    [P.DefPrintCat [P.PrintDef [mkName i] (trt pr)] | Yes pr <- [ppr]]
  CncFun _ ptr ppr -> 
    [P.DefLin [trDef i' nope ptr]] ++ 
    [P.DefPrintFun [P.PrintDef [mkName i] (trt pr)] | Yes pr <- [ppr]]
{-
  ---- encoding of AnyInd without changing syntax. AR 20/9/2007
  AnyInd s b -> 
    [P.DefOper [P.DDef [mkName i] 
      (P.EApp (P.EInt (if s then 1 else 0)) (P.EIdent (tri b)))]]
-}
  _ -> [] 


trDef :: Ident -> Perh Type -> Perh Term -> P.Def
trDef i pty ptr = case (pty,ptr) of
  (Nope,     Nope) -> P.DDef  [mkName i] (P.EMeta) ---
  (_,        Nope) -> P.DDecl [mkName i] (trPerh pty)
  (Nope,     _   ) -> P.DDef  [mkName i] (trPerh ptr)
  (_,        _   ) -> P.DFull [mkName i] (trPerh pty) (trPerh ptr)

trPerh p = case p of
  Yes t -> trt t
  May b -> P.EIndir $ tri b
  _ -> P.EMeta ---


trFlag :: Option -> P.TopDef
trFlag o = case o of
  Opt (f,[x]) -> P.DefFlag [P.FlagDef (identC f) (identC x)]
  _ -> P.DefFlag [] --- warning?

trt :: Term -> P.Exp 
trt trm = case trm of
    Vr s -> P.EIdent $ tri s
    Cn s -> P.ECons $ tri s
    Con s -> P.EConstr $ tri s
    Sort s -> P.ESort $ case s of
      "Type" -> P.Sort_Type
      "PType" -> P.Sort_PType
      "Tok" -> P.Sort_Tok
      "Str" -> P.Sort_Str
      "Strs" -> P.Sort_Strs
      _ -> error $ "not yet sort " +++ show trm ----

    App c a -> P.EApp (trt c) (trt a)
    Abs x b -> P.EAbstr [trb x] (trt b)
    Eqs pts -> P.EEqs [P.Equ (map trp ps) (trt t) | (ps,t) <- pts]
    Meta m  -> P.EMeta
    Prod x a b | isWildIdent x -> P.EProd (P.DExp (trt a)) (trt b)
    Prod x a b -> P.EProd (P.DDec [trb x] (trt a)) (trt b)

    Example t s -> P.EExample (trt t) s
    R [] -> P.ETuple [] --- to get correct parsing when read back
    R r -> P.ERecord $ map trAssign r
    RecType r -> P.ERecord $ map trLabelling r
    ExtR x y -> P.EExtend (trt x) (trt y)
    P t l -> P.EProj (trt t) (trLabel l)
    PI t l _ -> P.EProj (trt t) (trLabel l)
    Q t l -> P.EQCons (tri t) (tri l)
    QC t l -> P.EQConstr (tri t) (tri l)
    TSh (TComp ty) cc -> P.ETTable (trt ty) (map trCases cc)
    TSh (TTyped ty) cc -> P.ETTable (trt ty) (map trCases cc)
    TSh (TWild ty) cc -> P.ETTable (trt ty) (map trCases cc)
    T (TTyped ty) cc -> P.ETTable (trt ty) (map trCase cc)
    T (TComp ty) cc -> P.ETTable (trt ty) (map trCase cc)
    T (TWild ty) cc -> P.ETTable (trt ty) (map trCase cc)
    T _ cc -> P.ETable (map trCase cc)
    V ty cc -> P.EVTable (trt ty) (map trt cc)

    Table x v -> P.ETType (trt x) (trt v)
    S f x -> P.ESelect  (trt f) (trt x)
----    Alias c a t -> "{-" +++ prt c +++ "=" +++ "-}" +++ prt t
--    Alias c a t -> prt (Let (c,(Just a,t)) (Vr c))  -- thus Alias is only internal

    Let (x,(ma,b)) t -> 
      P.ELet [maybe (P.LDDef x' b') (\ty -> P.LDFull x' (trt ty) b')  ma] (trt t)
                          where 
                            b' = trt b
                            x' = [tri x]

    Empty -> P.EEmpty
    K [] -> P.EEmpty
    K a -> P.EString a
    C a b -> P.EConcat (trt a) (trt b)

    EInt i -> P.EInt i
    EFloat i -> P.EFloat i

    Glue a b -> P.EGlue (trt a) (trt b)
    Alts (t, tt) -> P.EPre (trt t) [P.Alt (trt v) (trt c) | (v,c) <- tt]
    FV ts -> P.EVariants $ map trt ts
    Strs tt -> P.EStrs $ map trt tt
    EData -> P.EData
    _ -> error $ "not yet" +++ show trm ----

trp :: Patt -> P.Patt
trp p = case p of
    PW -> P.PW
    PV s | isWildIdent s -> P.PW
    PV s -> P.PV $ tri s
    PC c [] -> P.PCon $ tri c
    PC c a -> P.PC (tri c) (map trp a)
    PP p c [] -> P.PQ (tri p) (tri c)
    PP p c a -> P.PQC (tri p) (tri c) (map trp a)
    PR r -> P.PR [P.PA [trLabelIdent l] (trp p) | (l,p) <- r]
    PString s -> P.PStr s
    PInt i -> P.PInt i
    PFloat i -> P.PFloat i
    PT t p -> trp p ---- prParenth (prt p +++ ":" +++ prt t)

    PAs  x p -> P.PAs (tri x) (trp p)

    PAlt p q -> P.PDisj (trp p) (trp q)
    PSeq p q -> P.PSeq (trp p) (trp q)
    PRep p   -> P.PRep (trp p)
    PNeg p   -> P.PNeg (trp p)


trAssign (lab, (mty, t)) = maybe (P.LDDef x t') (\ty -> P.LDFull x (trt ty) t') mty
  where 
    t' = trt t
    x  = [trLabelIdent lab]

trLabelling (lab,ty) = P.LDDecl [trLabelIdent lab] (trt ty)

trCase  (patt, trm) = P.Case (trp patt) (trt trm)
trCases (patts,trm) = P.Case (foldl1 P.PDisj (map trp patts)) (trt trm)

trDecl (x,ty) = P.DDDec [trb x] (trt ty)

tri :: Ident -> Ident
tri i = case prIdent i of
  s@('_':_:_) -> identC $ 'h':s ---- unsafe; needed since _3 etc are generated 
  s -> identC $ s
  
trb i = if isWildIdent i then P.BWild else P.BIdent (tri i)

trLabel :: Label -> P.Label
trLabel i = case i of
  LIdent s -> P.LIdent $ identC s
  LVar i -> P.LVar $ toInteger i

trLabelIdent i = identC $ case i of
  LIdent s -> s
  LVar i -> "v" ++ show i --- should not happen

mkName :: Ident -> P.Name
mkName = P.IdentName
