module GrammarToSource where

import Operations
import Grammar
import Modules
import Option
import qualified AbsGF as P
import Ident

-- AR 13/5/2003
-- translate internal to parsable and printable source

trGrammar :: SourceGrammar -> P.Grammar
trGrammar (MGrammar ms) = P.Gr (map trModule ms) -- no includes

trModule :: (Ident,SourceModInfo) -> P.ModDef
trModule (i,mo) = case mo of
  ModMod m -> P.MModule compl typ body where
    compl = P.CMCompl -- always complete module
    i' = tri i
    typ = case typeOfModule mo of
      MTResource -> P.MTResource i'
      MTAbstract -> P.MTAbstract i'
      MTConcrete a -> P.MTConcrete i' (tri a)
      MTTransfer a b -> P.MTTransfer i' (trOpen a) (trOpen b)
      MTInstance a -> P.MTInstance i' (tri a)
      MTInterface -> P.MTInterface i'
    body = P.MBody 
             (trExtend (extends m)) 
             (mkOpens (map trOpen (opens m)))
             (mkTopDefs (concatMap trAnyDef (tree2list (jments m)) ++ map trFlag (flags m)))

trExtend :: Maybe Ident -> P.Extend
trExtend i = maybe P.NoExt (P.Ext . tri) i

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


mkOpens ds = if null ds then P.NoOpens else P.Opens ds
mkTopDefs ds = ds

trAnyDef :: (Ident,Info) -> [P.TopDef]
trAnyDef (i,info) = let i' = tri i in case info of
  AbsCat (Yes co) pd -> [P.DefCat [P.CatDef i' (map trDecl co)]] ++ case pd of
    Yes fs -> [P.DefData [P.DataDef i' [P.DataQId (tri m) (tri c) | QC m c <- fs]]]
    _ -> []
  AbsFun (Yes ty) pt -> [P.DefFun [P.FunDef [i'] (trt ty)]] ++ case pt of
    Yes EData -> [] -- keep this information in data defs only
    Yes t -> [P.DefDef [P.DDef [i'] (trt t)]]
    _ -> []
  AbsFun (May b)  _ -> [P.DefFun [P.FunDef [i'] (P.EIndir (tri b))]]
  ---- don't destroy definitions!
  AbsTrans f -> [P.DefTrans [P.DDef [i'] (trt f)]]

  ResOper pty ptr -> [P.DefOper [trDef i' pty ptr]]
  ResParam pp -> [P.DefPar [case pp of
    Yes ps -> P.ParDef i' [P.ParConstr (tri c) (map trDecl co) | (c,co) <- ps]
    May b  -> P.ParDefIndir i' $ tri b
    _      -> P.ParDefAbs i']]

  CncCat (Yes ty) Nope _ -> 
    [P.DefLincat [P.PrintDef [i'] (trt ty)]] 
  CncCat pty ptr ppr -> 
    [P.DefLindef [trDef i' pty ptr]] 
    ---- P.DefPrintCat [P.PrintDef i' (trt pr)]]
  CncFun _ ptr ppr -> 
    [P.DefLin [trDef i' nope ptr]] 
    ---- P.DefPrintFun [P.PrintDef i' (trt pr)]]
  _ -> [] 

trDef :: Ident -> Perh Type -> Perh Term -> P.Def
trDef i pty ptr = case (pty,ptr) of
  (Nope,     Nope) -> P.DDef  [i] (P.EMeta) ---
  (_,        Nope) -> P.DDecl [i] (trPerh pty)
  (Nope,     _   ) -> P.DDef  [i] (trPerh ptr)
  (_,        _   ) -> P.DFull [i] (trPerh pty) (trPerh ptr)

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

    R [] -> P.ETuple [] --- to get correct parsing when read back
    R r -> P.ERecord $ map trAssign r
    RecType r -> P.ERecord $ map trLabelling r
    ExtR x y -> P.EExtend (trt x) (trt y)
    P t l -> P.EProj (trt t) (trLabel l)
    Q t l -> P.EQCons (tri t) (tri l)
    QC t l -> P.EQConstr (tri t) (tri l)
    T (TTyped ty) cc -> P.ETTable (trt ty) (map trCase cc)
    T (TComp ty) cc -> P.ETTable (trt ty) (map trCase cc)
    T (TWild ty) cc -> P.ETTable (trt ty) (map trCase cc)
    T _ cc -> P.ETable (map trCase cc)

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

    EInt i -> P.EInt $ toInteger i

    Glue a b -> P.EGlue (trt a) (trt b)
    Alts (t, tt) -> P.EPre (trt t) [P.Alt (trt v) (trt c) | (v,c) <- tt]
    FV ts -> P.EVariants $ map trt ts
    Strs tt -> P.EStrs $ map trt tt
    _ -> error $ "not yet" +++ show trm ----

trp :: Patt -> P.Patt
trp p = case p of
    PV s | isWildIdent s -> P.PW
    PV s -> P.PV $ tri s
    PC c [] -> P.PCon $ tri c
    PC c a -> P.PC (tri c) (map trp a)
    PP p c [] -> P.PQ (tri p) (tri c)
    PP p c a -> P.PQC (tri p) (tri c) (map trp a)
    PR r -> P.PR [P.PA [trLabelIdent l] (trp p) | (l,p) <- r]
----    PT t p -> prt p ---- prParenth (prt p +++ ":" +++ prt t)


trAssign (lab, (mty, t)) = maybe (P.LDDef x t') (\ty -> P.LDFull x (trt ty) t') mty
  where 
    t' = trt t
    x  = [trLabelIdent lab]

trLabelling (lab,ty) = P.LDDecl [trLabelIdent lab] (trt ty)

trCase (patt,trm) = P.Case [P.AltP (trp patt)] (trt trm)

trDecl (x,ty) = P.DDDec [trb x] (trt ty)

tri :: Ident -> Ident
tri i = case prIdent i of
  s@('_':_:_) -> identC $ 'h':s ---- unsafe; needed since _3 etc are generated 
  s -> identC $ s
  
trb i = if isWildIdent i then P.BWild else P.BIdent (tri i)

trLabel i = case i of
  LIdent s -> P.LIdent $ identC s
  LVar i -> P.LVar $ toInteger i

trLabelIdent i = identC $ case i of
  LIdent s -> s
  LVar i -> "v" ++ show i --- should not happen

