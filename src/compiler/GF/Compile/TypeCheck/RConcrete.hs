{-# LANGUAGE PatternGuards #-}
module GF.Compile.TypeCheck.RConcrete( checkLType, inferLType, computeLType, ppType ) where

import GF.Infra.CheckM
import GF.Data.Operations

import GF.Grammar
import GF.Grammar.Lookup
import GF.Grammar.Predef
import GF.Grammar.PatternMatch
import GF.Grammar.Lockfield (isLockLabel, lockRecType, unlockRecord)
import GF.Compile.TypeCheck.Primitives

import Data.List
import Control.Monad
import GF.Text.Pretty

computeLType :: SourceGrammar -> Context -> Type -> Check Type
computeLType gr g0 t = comp (reverse [(b,x, Vr x) | (b,x,_) <- g0] ++ g0) t
 where
  comp g ty = case ty of
    _ | Just _ <- isTypeInts ty -> return ty ---- shouldn't be needed
      | isPredefConstant ty     -> return ty ---- shouldn't be needed

    Q (m,ident) -> checkIn ("module" <+> m) $ do
      ty' <- lookupResDef gr (m,ident)
      if ty' == ty then return ty else comp g ty' --- is this necessary to test?

    AdHocOverload ts -> do
     over <- getOverload gr g (Just typeType) t
     case over of
       Just (tr,_) -> return tr
       _ -> checkError ("unresolved overloading of constants" <+> ppTerm Qualified 0 t) 

    Vr ident  -> checkLookup ident g -- never needed to compute!

    App f a -> do
      f' <- comp g f
      a' <- comp g a
      case f' of
        Abs b x t -> comp ((b,x,a'):g) t
        _ -> return $ App f' a'

    Prod bt x a b -> do
      a' <- comp g a
      b' <- comp ((bt,x,Vr x) : g) b
      return $ Prod bt x a' b'

    Abs bt x b -> do
      b' <- comp ((bt,x,Vr x):g) b
      return $ Abs bt x b'

    Let (x,(_,a)) b -> comp ((Explicit,x,a):g) b

    ExtR r s -> do
      r' <- comp g r
      s' <- comp g s
      case (r',s') of
        (RecType rs, RecType ss) -> plusRecType r' s' >>= comp g
        _ -> return $ ExtR r' s'

    RecType fs -> do
      let fs' = sortRec fs
      liftM RecType $ mapPairsM (comp g) fs'

    ELincat c t -> do
      t' <- comp g t
      lockRecType c t' ---- locking to be removed AR 20/6/2009

    _ | ty == typeTok -> return typeStr
    _ | isPredefConstant ty -> return ty

    _ -> composOp (comp g) ty

-- the underlying algorithms

inferLType :: SourceGrammar -> Context -> Term -> Check (Term, Type)
inferLType gr g trm = case trm of

   Q (m,ident) | isPredef m -> termWith trm $ case typPredefined ident of
                                                Just ty -> return ty
                                                Nothing -> checkError ("unknown in Predef:" <+> ident)

   Q ident -> checks [
     termWith trm $ lookupResType gr ident >>= computeLType gr g
     ,
     lookupResDef gr ident >>= inferLType gr g
     ,
     checkError ("cannot infer type of constant" <+> ppTerm Unqualified 0 trm)
     ]

   QC (m,ident) | isPredef m -> termWith trm $ case typPredefined ident of
                                                 Just ty -> return ty
                                                 Nothing -> checkError ("unknown in Predef:" <+> ident)

   QC ident -> checks [
       termWith trm $ lookupResType gr ident >>= computeLType gr g
       ,
       lookupResDef gr ident >>= inferLType gr g
       ,
       checkError ("cannot infer type of canonical constant" <+> ppTerm Unqualified 0 trm)
       ]

   Vr ident -> termWith trm $ checkLookup ident g

   Typed e t -> do
     t' <- computeLType gr g t
     checkLType gr g e t'

   AdHocOverload ts -> do
     over <- getOverload gr g Nothing trm
     case over of
       Just trty -> return trty
       _ -> checkError ("unresolved overloading of constants" <+> ppTerm Qualified 0 trm) 

   App f a -> do
     over <- getOverload gr g Nothing trm
     case over of
       Just trty -> return trty
       _ -> do
         (f',fty) <- inferLType gr g f
         fty' <- computeLType gr g fty
         case fty' of
           Prod bt z arg val -> do 
             a' <- justCheck g a arg
             ty <- if isWildIdent z 
                      then return val
                      else substituteLType [(bt,z,a')] val
             return (App f' a',ty) 
           _ -> checkError ("A function type is expected for" <+> ppTerm Unqualified 0 f <+> "instead of type" <+> ppType fty)

   S f x -> do
     (f', fty) <- inferLType gr g f
     case fty of
       Table arg val -> do
         x'<- justCheck g x arg
         return (S f' x', val)
       _ -> checkError ("table lintype expected for the table in" $$ nest 2 (ppTerm Unqualified 0 trm))

   P t i -> do
     (t',ty) <- inferLType gr g t   --- ??
     ty' <- computeLType gr g ty
     let tr2 = P t' i
     termWith tr2 $ case ty' of
       RecType ts -> case lookup i ts of
                       Nothing -> checkError ("unknown label" <+> i <+> "in" $$ nest 2 (ppTerm Unqualified 0 ty'))
                       Just x  -> return x
       _          -> checkError ("record type expected for:" <+> ppTerm Unqualified 0 t $$
                                 " instead of the inferred:" <+> ppTerm Unqualified 0 ty')

   R r -> do
     let (ls,fs) = unzip r
     fsts <- mapM inferM fs
     let ts = [ty | (Just ty,_) <- fsts]
     checkCond ("cannot infer type of record" $$ nest 2 (ppTerm Unqualified 0 trm)) (length ts == length fsts)
     return $ (R (zip ls fsts), RecType (zip ls ts))

   T (TTyped arg) pts -> do
     (_,val) <- checks $ map (inferCase (Just arg)) pts
     checkLType gr g trm (Table arg val)
   T (TComp arg) pts -> do
     (_,val) <- checks $ map (inferCase (Just arg)) pts
     checkLType gr g trm (Table arg val)
   T ti pts -> do  -- tries to guess: good in oper type inference
     let pts' = [pt | pt@(p,_) <- pts, isConstPatt p]
     case pts' of 
       [] -> checkError ("cannot infer table type of" <+> ppTerm Unqualified 0 trm)
----       PInt k : _ -> return $ Ints $ max [i | PInt i <- pts'] 
       _  -> do 
         (arg,val) <- checks $ map (inferCase Nothing) pts'
         checkLType gr g trm (Table arg val)
   V arg pts -> do
     (_,val) <- checks $ map (inferLType gr g) pts
--   return (trm, Table arg val) -- old, caused issue 68
     checkLType gr g trm (Table arg val)

   K s  -> do
     if elem ' ' s
        then do
          let ss = foldr C Empty (map K (words s))  
          ----- removed irritating warning AR 24/5/2008
          ----- checkWarn ("token \"" ++ s ++ 
          -----              "\" converted to token list" ++ prt ss)
          return (ss, typeStr)
        else return (trm, typeStr)

   EInt i -> return (trm, typeInt)

   EFloat i -> return (trm, typeFloat)

   Empty -> return (trm, typeStr)

   C s1 s2 -> 
     check2 (flip (justCheck g) typeStr) C s1 s2 typeStr

   Glue s1 s2 -> 
     check2 (flip (justCheck g) typeStr) Glue s1 s2 typeStr ---- typeTok

---- hack from Rename.identRenameTerm, to live with files with naming conflicts 18/6/2007
   Strs (Cn c : ts) | c == cConflict -> do
     checkWarn ("unresolved constant, could be any of" <+> hcat (map (ppTerm Unqualified 0) ts))
     inferLType gr g (head ts)

   Strs ts -> do
     ts' <- mapM (\t -> justCheck g t typeStr) ts 
     return (Strs ts', typeStrs)

   Alts t aa -> do
     t'  <- justCheck g t typeStr
     aa' <- flip mapM aa (\ (c,v) -> do
        c' <- justCheck g c typeStr 
        v' <- checks $ map (justCheck g v) [typeStrs, EPattType typeStr]
        return (c',v'))
     return (Alts t' aa', typeStr)

   RecType r -> do
     let (ls,ts) = unzip r
     ts' <- mapM (flip (justCheck g) typeType) ts 
     return (RecType (zip ls ts'), typeType)

   ExtR r s -> do
     (r',rT) <- inferLType gr g r 
     rT'     <- computeLType gr g rT
     (s',sT) <- inferLType gr g s
     sT'     <- computeLType gr g sT

     let trm' = ExtR r' s'
     case (rT', sT') of
       (RecType rs, RecType ss) -> do
         let rt = RecType ([field | field@(l,_) <- rs, notElem l (map fst ss)] ++ ss) -- select types of later fields 
         checkLType gr g trm' rt ---- return (trm', rt)
       _ | rT' == typeType && sT' == typeType -> do
         return (trm', typeType)
       _ -> checkError ("records or record types expected in" <+> ppTerm Unqualified 0 trm)

   Sort _     -> 
     termWith trm $ return typeType

   Prod bt x a b -> do
     a' <- justCheck g a typeType
     b' <- justCheck ((bt,x,a'):g) b typeType
     return (Prod bt x a' b', typeType)

   Table p t  -> do
     p' <- justCheck g p typeType --- check p partype! 
     t' <- justCheck g t typeType
     return $ (Table p' t', typeType)

   FV vs -> do
     (_,ty) <- checks $ map (inferLType gr g) vs
---     checkIfComplexVariantType trm ty
     checkLType gr g trm ty

   EPattType ty -> do
     ty' <- justCheck g ty typeType
     return (EPattType ty',typeType)
   EPatt p -> do
     ty <- inferPatt p
     return (trm, EPattType ty)

   ELin c trm -> do
     (trm',ty) <- inferLType gr g trm
     ty' <- lockRecType c ty ---- lookup c; remove lock AR 20/6/2009
     return $ (ELin c trm', ty') 

   _ -> checkError ("cannot infer lintype of" <+> ppTerm Unqualified 0 trm)

 where
   isPredef m = elem m [cPredef,cPredefAbs]

   justCheck g ty te = checkLType gr g ty te >>= return . fst

   -- for record fields, which may be typed
   inferM (mty, t) = do
     (t', ty') <- case mty of
       Just ty -> checkLType gr g t ty
       _ -> inferLType gr g t
     return (Just ty',t')

   inferCase mty (patt,term) = do
     arg  <- maybe (inferPatt patt) return mty
     cont <- pattContext gr g arg patt
     (_,val) <- inferLType gr (reverse cont ++ g) term
     return (arg,val)
   isConstPatt p = case p of
     PC _ ps -> True --- all isConstPatt ps
     PP _ ps -> True --- all isConstPatt ps
     PR ps -> all (isConstPatt . snd) ps
     PT _ p -> isConstPatt p
     PString _ -> True
     PInt _ -> True
     PFloat _ -> True
     PChar -> True
     PChars _ -> True
     PSeq p q -> isConstPatt p && isConstPatt q
     PAlt p q -> isConstPatt p && isConstPatt q
     PRep p -> isConstPatt p
     PNeg p -> isConstPatt p
     PAs _ p -> isConstPatt p
     _ -> False

   inferPatt p = case p of
     PP (q,c) ps | q /= cPredef -> liftM valTypeCnc (lookupResType gr (q,c))
     PAs _ p  -> inferPatt p
     PNeg p   -> inferPatt p
     PAlt p q -> checks [inferPatt p, inferPatt q]
     PSeq _ _ -> return $ typeStr
     PRep _   -> return $ typeStr
     PChar    -> return $ typeStr
     PChars _ -> return $ typeStr
     _ -> inferLType gr g (patt2term p) >>= return . snd

-- type inference: Nothing, type checking: Just t
-- the latter permits matching with value type
getOverload :: SourceGrammar -> Context -> Maybe Type -> Term -> Check (Maybe (Term,Type))
getOverload gr g mt ot = case appForm ot of
     (f@(Q c), ts) -> case lookupOverload gr c of
       Ok typs -> do
         ttys <- mapM (inferLType gr g) ts
         v <- matchOverload f typs ttys
         return $ Just v
       _ -> return Nothing
     (AdHocOverload cs@(f:_), ts) -> do     --- the function name f is only used in error messages
       let typs = concatMap collectOverloads cs
       ttys <- mapM (inferLType gr g) ts
       v <- matchOverload f typs ttys
       return $ Just v
     _ -> return Nothing

 where
   collectOverloads tr@(Q c) = case lookupOverload gr c of 
     Ok typs -> typs
     _ -> case lookupResType gr c of
       Ok ty -> let (args,val) = typeFormCnc ty in [(map (\(b,x,t) -> t) args,(val,tr))]
       _ -> []
   collectOverloads _ = [] --- constructors QC

   matchOverload f typs ttys = do
     let (tts,tys) = unzip ttys
     let vfs = lookupOverloadInstance tys typs
     let matches = [vf | vf@((_,v,_),_) <- vfs, matchVal mt v]
     let showTypes ty = hsep (map ppType ty)

    
     let (stys,styps) = (showTypes tys, [showTypes ty | (ty,_) <- typs])

     -- to avoid strange error msg e.g. in case of unmatch record extension, show whole types if needed AR 28/1/2013
     let (stysError,stypsError) = if elem (render stys) (map render styps)
            then (hsep (map (ppTerm Unqualified 0) tys), [hsep (map (ppTerm Unqualified 0) ty) | (ty,_) <- typs])
            else (stys,styps)

     case ([vf | (vf,True) <- matches],[vf | (vf,False) <- matches]) of
       ([(_,val,fun)],_) -> return (mkApp fun tts, val)
       ([],[(pre,val,fun)]) -> do
         checkWarn $  "ignoring lock fields in resolving" <+> ppTerm Unqualified 0 ot $$
                      "for" $$
                      nest 2 (showTypes tys) $$
                      "using" $$
                      nest 2 (showTypes pre)
         return (mkApp fun tts, val)
       ([],[]) -> do
         checkError $ "no overload instance of" <+> ppTerm Unqualified 0 f $$
                      "for" $$
                      nest 2 stysError $$
                      "among" $$
                      nest 2 (vcat stypsError) $$
                      maybe empty (\x -> "with value type" <+> ppType x) mt

       (vfs1,vfs2) -> case (noProds vfs1,noProds vfs2) of
         ([(val,fun)],_) -> do
           return (mkApp fun tts, val)
         ([],[(val,fun)]) -> do
           checkWarn ("ignoring lock fields in resolving" <+> ppTerm Unqualified 0 ot) 
           return (mkApp fun tts, val)

----- unsafely exclude irritating warning AR 24/5/2008
-----           checkWarn $ "overloading of" +++ prt f +++ 
-----             "resolved by excluding partial applications:" ++++
-----             unlines [prtType env ty | (ty,_) <- vfs', not (noProd ty)]

--- now forgiving ambiguity with a warning AR 1/2/2014
--  This gives ad hoc overloading the same behaviour as the choice of the first match in renaming did before. 
--  But it also gives a chance to ambiguous overloadings that were banned before. 
         (nps1,nps2) -> do 
              checkWarn $  "ambiguous overloading of" <+> ppTerm Unqualified 0 f <+>
                  ----     "with argument types" <+> hsep (map (ppTerm Qualified 0) tys) $$ 
                           "resolved by selecting the first of the alternatives" $$
                           nest 2 (vcat [ppTerm Qualified 0 fun | (_,ty,fun) <- vfs1 ++ if null vfs1 then vfs2 else []])
              case [(mkApp fun tts,val) | (val,fun) <- nps1 ++ nps2] of
                 [] -> checkError $ "no alternatives left when resolving" <+> ppTerm Unqualified 0 f
                 h:_ -> return h

   matchVal mt v = elem mt [Nothing,Just v,Just (unlocked v)]

   unlocked v = case v of
     RecType fs -> RecType $ filter (not . isLockLabel . fst) fs
     _ -> v
   ---- TODO: accept subtypes
   ---- TODO: use a trie
   lookupOverloadInstance tys typs = 
     [((pre,mkFunType rest val, t),isExact) | 
       let lt = length tys,
       (ty,(val,t)) <- typs, length ty >= lt,
       let (pre,rest) = splitAt lt ty, 
       let isExact = pre == tys,
       isExact || map unlocked pre == map unlocked tys
     ]

   noProds vfs = [(v,f) | (_,v,f) <- vfs, noProd v]

   noProd ty = case ty of
     Prod _ _ _ _ -> False
     _ -> True

checkLType :: SourceGrammar -> Context -> Term -> Type -> Check (Term, Type)
checkLType gr g trm typ0 = do
  typ <- computeLType gr g typ0

  case trm of

    Abs bt x c -> do
      case typ of
        Prod bt' z a b -> do 
          (c',b') <- if isWildIdent z
                       then checkLType gr ((bt,x,a):g) c b
                       else do b' <- checkIn (pp "abs") $ substituteLType [(bt',z,Vr x)] b
                               checkLType gr ((bt,x,a):g) c b'
          return $ (Abs bt x c', Prod bt' z a b')
        _ -> checkError $ "function type expected instead of" <+> ppType typ

    App f a -> do
       over <- getOverload gr g (Just typ) trm
       case over of
         Just trty -> return trty
         _ -> do
          (trm',ty') <- inferLType gr g trm
          termWith trm' $ checkEqLType gr g typ ty' trm'

    AdHocOverload ts -> do
      over <- getOverload gr g Nothing trm
      case over of
        Just trty -> return trty
        _ -> checkError ("unresolved overloading of constants" <+> ppTerm Qualified 0 trm) 

    Q _ -> do
       over <- getOverload gr g (Just typ) trm
       case over of
         Just trty -> return trty
         _ -> do
          (trm',ty') <- inferLType gr g trm
          termWith trm' $ checkEqLType gr g typ ty' trm'

    T _ [] ->
      checkError ("found empty table in type" <+> ppTerm Unqualified 0 typ)
    T _ cs -> case typ of 
      Table arg val -> do 
        case allParamValues gr arg of
          Ok vs -> do
            let ps0 = map fst cs
            ps <- testOvershadow ps0 vs
            if null ps 
              then return () 
              else checkWarn ("patterns never reached:" $$
                              nest 2 (vcat (map (ppPatt Unqualified 0) ps)))
          _ -> return () -- happens with variable types
        cs' <- mapM (checkCase arg val) cs
        return (T (TTyped arg) cs', typ)
      _ -> checkError $ "table type expected for table instead of" $$ nest 2 (ppType typ)
    V arg0 vs ->
      case typ of
        Table arg1 val ->
           do arg' <- checkEqLType gr g arg0 arg1 trm
              vs1 <- allParamValues gr arg1
              if length vs1 == length vs
                 then return ()
                 else checkError $ "wrong number of values in table" <+> ppTerm Unqualified 0 trm
              vs' <- map fst `fmap` sequence [checkLType gr g v val|v<-vs]
              return (V arg' vs',typ)

    R r -> case typ of --- why needed? because inference may be too difficult
       RecType rr -> do
       --let (ls,_) = unzip rr        -- labels of expected type
         fsts <- mapM (checkM r) rr   -- check that they are found in the record
         return $ (R fsts, typ)       -- normalize record

       _ -> checkError ("record type expected in type checking instead of" $$ nest 2 (ppTerm Unqualified 0 typ))

    ExtR r s -> case typ of
       _ | typ == typeType -> do
         trm' <- computeLType gr g trm
         case trm' of
           RecType _ -> termWith trm' $ return typeType
           ExtR (Vr _) (RecType _) -> termWith trm' $ return typeType 
                                      -- ext t = t ** ...
           _ -> checkError ("invalid record type extension" <+> nest 2 (ppTerm Unqualified 0 trm))

       RecType rr -> do

         ll2 <- case s of
           R ss -> return $ map fst ss
           _ -> do
             (s',typ2) <- inferLType gr g s
             case typ2 of
               RecType ss -> return $ map fst ss
               _ ->  checkError ("cannot get labels from" $$ nest 2 (ppTerm Unqualified 0 typ2))
         let ll1 = [l | (l,_) <- rr, notElem l ll2]
         (r',_) <- checkLType gr g r (RecType [field | field@(l,_) <- rr, elem l ll1])
         (s',_) <- checkLType gr g s (RecType [field | field@(l,_) <- rr, elem l ll2])

         let rec = R ([(l,(Nothing,P r' l)) | l <- ll1] ++ [(l,(Nothing,P s' l)) | l <- ll2])
         return (rec, typ)

       ExtR ty ex -> do
         r' <- justCheck g r ty
         s' <- justCheck g s ex
         return $ (ExtR r' s', typ) --- is this all? it assumes the same division in trm and typ

       _ -> checkError ("record extension not meaningful for" <+> ppTerm Unqualified 0 typ)

    FV vs -> do
      ttys <- mapM (flip (checkLType gr g) typ) vs
---      checkIfComplexVariantType trm typ
      return (FV (map fst ttys), typ) --- typ' ?

    S tab arg -> checks [ do
      (tab',ty) <- inferLType gr g tab
      ty'       <- computeLType gr g ty
      case ty' of
        Table p t -> do
          (arg',val) <- checkLType gr g arg p
          checkEqLType gr g typ t trm
          return (S tab' arg', t)
        _ -> checkError ("table type expected for applied table instead of" <+> ppType ty')
     , do
      (arg',ty) <- inferLType gr g arg
      ty'       <- computeLType gr g ty
      (tab',_)  <- checkLType gr g tab (Table ty' typ)
      return (S tab' arg', typ)
      ]
    Let (x,(mty,def)) body -> case mty of
      Just ty -> do
        (ty0,_)    <- checkLType gr g ty typeType
        (def',ty') <- checkLType gr g def ty0
        body' <- justCheck ((Explicit,x,ty'):g) body typ
        return (Let (x,(Just ty',def')) body', typ)
      _ -> do
        (def',ty) <- inferLType gr g def  -- tries to infer type of local constant
        checkLType gr g (Let (x,(Just ty,def')) body) typ

    ELin c tr -> do
      tr1 <- unlockRecord c tr
      checkLType gr g tr1 typ

    _ -> do
      (trm',ty') <- inferLType gr g trm
      termWith trm' $ checkEqLType gr g typ ty' trm'
 where
   justCheck g ty te = checkLType gr g ty te >>= return . fst
{-
   recParts rr t = (RecType rr1,RecType rr2) where 
     (rr1,rr2) = partition (flip elem (map fst t) . fst) rr 
-}
   checkM rms (l,ty) = case lookup l rms of
     Just (Just ty0,t) -> do
       checkEqLType gr g ty ty0 t
       (t',ty') <- checkLType gr g t ty
       return (l,(Just ty',t'))
     Just (_,t) -> do
       (t',ty') <- checkLType gr g t ty
       return (l,(Just ty',t'))
     _ -> checkError $ 
            if isLockLabel l 
              then let cat = drop 5 (showIdent (label2ident l))
                   in ppTerm Unqualified 0 (R rms) <+> "is not in the lincat of" <+> cat <> 
                      "; try wrapping it with lin" <+> cat
              else "cannot find value for label" <+> l <+> "in" <+> ppTerm Unqualified 0 (R rms)

   checkCase arg val (p,t) = do
     cont <- pattContext gr g arg p
     t' <- justCheck (reverse cont ++ g) t val
     return (p,t')

pattContext :: SourceGrammar -> Context -> Type -> Patt -> Check Context
pattContext env g typ p = case p of
  PV x -> return [(Explicit,x,typ)]
  PP (q,c) ps | q /= cPredef -> do ---- why this /=? AR 6/1/2006
    t <- lookupResType env (q,c)
    let (cont,v) = typeFormCnc t
    checkCond ("wrong number of arguments for constructor in" <+> ppPatt Unqualified 0 p) 
              (length cont == length ps)
    checkEqLType env g typ v (patt2term p)
    mapM (\((_,_,ty),p) -> pattContext env g ty p) (zip cont ps) >>= return . concat
  PR r -> do
    typ' <- computeLType env g typ
    case typ' of
      RecType t -> do
        let pts = [(ty,tr) | (l,tr) <- r, Just ty <- [lookup l t]]
        ----- checkWarn $ prt p ++++ show pts ----- debug
        mapM (uncurry (pattContext env g)) pts >>= return . concat
      _ -> checkError ("record type expected for pattern instead of" <+> ppTerm Unqualified 0 typ')
  PT t p' -> do
    checkEqLType env g typ t (patt2term p')
    pattContext env g typ p'

  PAs x p -> do
    g' <- pattContext env g typ p
    return ((Explicit,x,typ):g')

  PAlt p' q -> do
    g1 <- pattContext env g typ p'
    g2 <- pattContext env g typ q
    let pts = nub ([x | pt@(_,x,_) <- g1, notElem pt g2] ++ [x | pt@(_,x,_) <- g2, notElem pt g1])
    checkCond 
      ("incompatible bindings of" <+>
       fsep pts <+> 
       "in pattern alterantives" <+> ppPatt Unqualified 0 p) (null pts) 
    return g1 -- must be g1 == g2
  PSeq p q -> do
    g1 <- pattContext env g typ p
    g2 <- pattContext env g typ q
    return $ g1 ++ g2
  PRep p' -> noBind typeStr p'
  PNeg p' -> noBind typ p'

  _ -> return [] ---- check types!
 where 
   noBind typ p' = do
    co <- pattContext env g typ p'
    if not (null co)
      then checkWarn ("no variable bound inside pattern" <+> ppPatt Unqualified 0 p) 
           >> return []
      else return []

checkEqLType :: SourceGrammar -> Context -> Type -> Type -> Term -> Check Type
checkEqLType gr g t u trm = do
  (b,t',u',s) <- checkIfEqLType gr g t u trm
  case b of
    True  -> return t'
    False -> checkError $ s <+> "type of" <+> ppTerm Unqualified 0 trm $$
                          "expected:" <+> ppTerm Qualified 0 t $$ -- ppqType t u $$
                          "inferred:" <+> ppTerm Qualified 0 u -- ppqType u t

checkIfEqLType :: SourceGrammar -> Context -> Type -> Type -> Term -> Check (Bool,Type,Type,String)
checkIfEqLType gr g t u trm = do
  t' <- computeLType gr g t
  u' <- computeLType gr g u
  case t' == u' || alpha [] t' u' of
    True -> return (True,t',u',[])
    -- forgive missing lock fields by only generating a warning.
    --- better: use a flag to forgive? (AR 31/1/2006)
    _ -> case missingLock [] t' u' of
      Ok lo -> do
        checkWarn $ "missing lock field" <+> fsep lo
        return (True,t',u',[])
      Bad s -> return (False,t',u',s)

  where

   -- check that u is a subtype of t
   --- quick hack version of TC.eqVal
   alpha g t u = case (t,u) of  

     -- error (the empty type!) is subtype of any other type
     (_,u) | u == typeError -> True

     -- contravariance
     (Prod _ x a b, Prod _ y c d) -> alpha g c a && alpha ((x,y):g) b d 
                              
     -- record subtyping
     (RecType rs, RecType ts) -> all (\ (l,a) -> 
                                   any (\ (k,b) -> l == k && alpha g a b) ts) rs
     (ExtR r s, ExtR r' s') -> alpha g r r' && alpha g s s'
     (ExtR r s, t) -> alpha g r t || alpha g s t

     -- the following say that Ints n is a subset of Int and of Ints m >= n
     -- But why does it also allow Int as a subtype of Ints m? /TH 2014-04-04
     (t,u) | Just m <- isTypeInts t, Just n <- isTypeInts u -> m >= n
           | Just _ <- isTypeInts t, u == typeInt           -> True ---- check size!
           | t == typeInt,           Just _ <- isTypeInts u -> True ---- why this ???? AR 11/12/2005

     ---- this should be made in Rename
     (Q  (m,a), Q  (n,b)) | a == b -> elem m (allExtendsPlus gr n) 
                                   || elem n (allExtendsPlus gr m)
                                   || m == n --- for Predef
     (QC (m,a), QC (n,b)) | a == b -> elem m (allExtendsPlus gr n) 
                                   || elem n (allExtendsPlus gr m)
     (QC (m,a), Q  (n,b)) | a == b -> elem m (allExtendsPlus gr n) 
                                   || elem n (allExtendsPlus gr m)
     (Q  (m,a), QC (n,b)) | a == b -> elem m (allExtendsPlus gr n) 
                                   || elem n (allExtendsPlus gr m)

     -- contravariance
     (Table a b,  Table c d)  -> alpha g c a && alpha g b d
     (Vr x,       Vr y)       -> x == y || elem (x,y) g || elem (y,x) g
     _                        -> t == u 
     --- the following should be one-way coercions only. AR 4/1/2001
                                  || elem t sTypes && elem u sTypes
                                  || (t == typeType && u == typePType) 
                                  || (u == typeType && t == typePType) 

   missingLock g t u = case (t,u) of  
     (RecType rs, RecType ts) -> 
       let 
         ls = [l | (l,a) <- rs, 
                   not (any (\ (k,b) -> alpha g a b && l == k) ts)]
         (locks,others) = partition isLockLabel ls
       in case others of
         _:_ -> Bad $ render ("missing record fields:" <+> fsep (punctuate ',' (others)))
         _ -> return locks
     -- contravariance
     (Prod _ x a b, Prod _ y c d) -> do
        ls1 <- missingLock g c a
        ls2 <- missingLock g b d
        return $ ls1 ++ ls2

     _ -> Bad ""

   sTypes = [typeStr, typeTok, typeString]

-- auxiliaries

-- | light-weight substitution for dep. types
substituteLType :: Context -> Type -> Check Type
substituteLType g t = case t of
  Vr x -> return $ maybe t id $ lookup x [(x,t) | (_,x,t) <- g]
  _ -> composOp (substituteLType g) t

termWith :: Term -> Check Type -> Check (Term, Type)
termWith t ct = do
  ty <- ct
  return (t,ty)

-- | compositional check\/infer of binary operations
check2 :: (Term -> Check Term) -> (Term -> Term -> Term) -> 
          Term -> Term -> Type -> Check (Term,Type)
check2 chk con a b t = do
  a' <- chk a
  b' <- chk b
  return (con a' b', t)

-- printing a type with a lock field lock_C as C
ppType :: Type -> Doc
ppType ty =
  case ty of
    RecType fs   -> case filter isLockLabel $ map fst fs of
                      [lock] -> pp (drop 5 (showIdent (label2ident lock)))
                      _      -> ppTerm Unqualified 0 ty
    Prod _ x a b -> ppType a <+> "->" <+> ppType b
    _            -> ppTerm Unqualified 0 ty
{-
ppqType :: Type -> Type -> Doc
ppqType t u = case (ppType t, ppType u) of
  (pt,pu) | render pt == render pu -> ppTerm Qualified 0 t
  (pt,_) -> pt
-}
checkLookup :: Ident -> Context -> Check Type
checkLookup x g =
  case [ty | (b,y,ty) <- g, x == y] of
    []     -> checkError ("unknown variable" <+> x)
    (ty:_) -> return ty
