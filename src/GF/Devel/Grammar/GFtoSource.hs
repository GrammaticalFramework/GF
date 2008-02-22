module GF.Devel.Grammar.GFtoSource ( 
  trGrammar,
  trModule,
  trAnyDef,
  trLabel,
  trt, 
  tri, 
  trp
  ) where


import GF.Devel.Grammar.Grammar
import GF.Devel.Grammar.Construct
import GF.Devel.Grammar.Macros (contextOfType)
import qualified GF.Devel.Compile.AbsGF as P
import GF.Infra.Ident

import GF.Data.Operations

import qualified Data.Map as Map

-- From internal source syntax to BNFC-generated (used for printing).
-- | AR 13\/5\/2003
--
-- translate internal to parsable and printable source

trGrammar :: GF -> P.Grammar
trGrammar = P.Gr . map trModule . listModules -- no includes

trModule :: (Ident,Module) -> P.ModDef
trModule (i,mo) = P.MModule compl typ body where
    compl = case isCompleteModule mo of
      False -> P.CMIncompl
      _ -> P.CMCompl
    i' = tri i
    typ = case mtype mo of
      MTGrammar -> P.MGrammar i'
      MTAbstract -> P.MAbstract i'
      MTConcrete a -> P.MConcrete i' (tri a)
      MTInterface -> P.MInterface i'
      MTInstance a -> P.MInstance i' (tri a)
    body = P.MBody 
             (trExtends (mextends mo)) 
             (mkOpens (map trOpen (mopens mo)))
             (concatMap trAnyDef [(c,j) | (c,j) <- listJudgements mo] ++ 
                        map trFlag (Map.assocs (mflags mo)))

trExtends :: [(Ident,MInclude)] -> P.Extend
trExtends [] = P.NoExt 
trExtends es = (P.Ext $ map tre es) where
  tre (i,c) = case c of 
    MIAll       -> P.IAll   (tri i)
    MIOnly is   -> P.ISome  (tri i) (map tri is)
    MIExcept is -> P.IMinus (tri i) (map tri is)

trOpen :: (Ident,Ident) -> P.Open
trOpen (i,j) = P.OQual (tri i) (tri j)

mkOpens ds = if null ds then P.NoOpens else P.OpenIn ds

trAnyDef :: (Ident,Judgement) -> [P.TopDef]
trAnyDef (i,ju) = let 
   i' = mkName i
   i0 = tri i 
 in case jform ju of
  JCat -> [P.DefCat [P.SimpleCatDef i0 []]] ---- (map trDecl co)]]
  JFun -> [P.DefFun [P.FDecl [i'] (trt (jtype ju))]] 
    ---- ++ case pt of
    ---- Yes t -> [P.DefDef [P.DDef [mkName i'] (trt t)]]
    ---- _ -> []
  ----  JFun ty EData -> [P.DefFunData [P.FunDef [i'] (trt ty)]]
  JParam -> [P.DefPar [
    P.ParDefDir i0 [
      P.ParConstr (tri c) (map trDecl co) | let EParam cos = jdef ju, (c,co) <- cos]
    ]] 
  JOper -> case jdef ju of 
    Overload tysts -> 
      [P.DefOper [P.DDef [i'] (
        P.EApp (P.EPIdent $ ppIdent "overload") 
          (P.ERecord [P.LDFull [i0] (trt ty) (trt fu) | (ty,fu) <- tysts]))]]
    tr -> [P.DefOper [trDef i (jtype ju) tr]]
  JLincat -> [P.DefLincat [P.DDef [i'] (trt (jtype ju))]] 
  ---- CncCat pty ptr ppr -> 
  ----  [P.DefLindef [trDef i' pty ptr]] 
    ---- ++ [P.DefPrintCat [P.DDef [mkName i] (trt pr)] | Yes pr <- [ppr]]
  JLin -> 
    [P.DefLin [trDef i (Meta 0) (jdef ju)]] 
    ---- ++ [P.DefPrintFun [P.DDef [mkName i] (trt pr)] | Yes pr <- [ppr]]
  JLink -> []

trDef :: Ident -> Type -> Term -> P.Def
trDef i pty ptr = case (pty,ptr) of
  (Meta _, Meta _) -> P.DDef  [mkName i] (P.EMeta) ---
  (_,      Meta _) -> P.DDecl [mkName i] (trPerh pty)
  (Meta _,      _) -> P.DDef  [mkName i] (trPerh ptr)
  (_,           _) -> P.DFull [mkName i] (trPerh pty) (trPerh ptr)

trPerh p = case p of
  Meta _ -> P.EMeta
  _ -> trt p

trFlag :: (Ident,String) -> P.TopDef
trFlag (f,x) = P.DefFlag [P.DDef [mkName f] (P.EString x)]

trt :: Term -> P.Exp 
trt trm = case trm of
    Vr s -> P.EPIdent $ tri s
----    Cn s -> P.ECons $ tri s
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
    T (TTyped ty) cc -> P.ETTable (trt ty) (map trCase cc)
    T (TComp ty) cc -> P.ETTable (trt ty) (map trCase cc)
    T (TWild ty) cc -> P.ETTable (trt ty) (map trCase cc)
    T _ cc -> P.ETable (map trCase cc)
    V ty cc -> P.EVTable (trt ty) (map trt cc)

    Typed tr ty -> P.ETyped (trt tr) (trt ty)
    Table x v -> P.ETType (trt x) (trt v)
    S f x -> P.ESelect  (trt f) (trt x)
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

    EPatt p -> P.EPatt (trp p)
    EPattType t -> P.EPattType (trt t)

    Glue a b -> P.EGlue (trt a) (trt b)
    Alts (t, tt) -> P.EPre (trt t) [P.Alt (trt v) (trt c) | (v,c) <- tt]
    FV ts -> P.EVariants $ map trt ts
    EData -> P.EData
    _ -> error $ "not yet" +++ show trm ----

trp :: Patt -> P.Patt
trp p = case p of
    PChar -> P.PChar
    PChars s -> P.PChars s
    PM m c -> P.PM (tri m) (tri c)
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

tri :: Ident -> P.PIdent
tri i = ppIdent (prIdent i)

ppIdent i = P.PIdent ((0,0),i)
  
trb i = if isWildIdent i then P.BWild else P.BPIdent (tri i)

trLabel :: Label -> P.Label
trLabel i = case i of
  LIdent s -> P.LPIdent $ ppIdent s
  LVar i -> P.LVar $ toInteger i

trLabelIdent i = ppIdent $ case i of
  LIdent s -> s
  LVar i -> "v" ++ show i --- should not happen

mkName :: Ident -> P.Name
mkName = P.PIdentName . tri

