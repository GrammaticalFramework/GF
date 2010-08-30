{-# LANGUAGE BangPatterns, RankNTypes, FlexibleInstances, MultiParamTypeClasses, PatternGuards #-}
----------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- Convert PGF grammar to PMCFG grammar.
--
-----------------------------------------------------------------------------

module GF.Compile.GeneratePMCFG
    (convertConcrete) where

import PGF.CId
import PGF.Data hiding (Type)

import GF.Infra.Option
import GF.Grammar hiding (Env, mkRecord, mkTable)
import qualified GF.Infra.Modules as M
import GF.Grammar.Lookup
import GF.Grammar.Predef
import GF.Data.BacktrackM
import GF.Data.Operations
import GF.Data.Utilities (updateNthM, updateNth, sortNub)

import System.IO
import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.List as List
import qualified Data.IntMap as IntMap
import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint hiding (Str)
import Data.Array.IArray
import Data.Maybe
import Data.Char (isDigit)
import Control.Monad
import Control.Monad.Identity
import Control.Exception

----------------------------------------------------------------------
-- main conversion function


convertConcrete :: Options -> SourceGrammar -> SourceModule -> SourceModule -> IO Concr
convertConcrete opts0 gr am cm = do
  let env = emptyGrammarEnv gr cm
  when (flag optProf opts) $ do
    profileGrammar cm env pfrules
  env <- foldM (convertLinDef gr opts) env pflindefs
  env <- foldM (convertRule gr opts) env pfrules
  return $ getConcr flags printnames env
  where
    (m,mo) = cm
    
    opts = addOptions (M.flags (snd am)) opts0

    pflindefs = [
      ((m,id),term,lincat) |
        (id,GF.Grammar.CncCat (Just (L _ lincat)) (Just (L _ term)) _) <- Map.toList (M.jments mo)]

    pfrules = [
      (PFRule id args ([],res) (map (\(_,_,ty) -> ty) cont) val term) |
        (id,GF.Grammar.CncFun (Just (cat,cont,val)) (Just (L _ term)) _) <- Map.toList (M.jments mo),
        let (ctxt,res,_) = err error typeForm (lookupFunType gr (fst am) id)
            args         = [catSkeleton ty | (_,_,ty) <- ctxt]]

    flags   = Map.fromList [(mkCId f,LStr x) | (f,x) <- optionsPGF (M.flags mo)]

    printnames = Map.fromAscList [(i2i id, name) | (id,info) <- Map.toList (M.jments mo), name <- prn info]
      where
        prn (GF.Grammar.CncFun _ _ (Just (L _ tr))) = [flatten tr]
        prn (GF.Grammar.CncCat _ _ (Just (L _ tr))) = [flatten tr]
        prn _                                       = []

        flatten (K s)      = s
        flatten (Alts x _) = flatten x
        flatten (C x y)    = flatten x +++ flatten y

i2i :: Ident -> CId
i2i = CId . ident2bs

profileGrammar (m,mo) env@(GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) pfrules = do
  hPutStrLn stderr ""
  hPutStrLn stderr ("Language: " ++ showIdent m)
  hPutStrLn stderr ""
  hPutStrLn stderr "Categories                 Count"
  hPutStrLn stderr "--------------------------------"
  mapM_ profileCat (Map.toList catSet)
  hPutStrLn stderr "--------------------------------"
  hPutStrLn stderr ""
  hPutStrLn stderr "Rules                      Count"
  hPutStrLn stderr "--------------------------------"
  mapM_ profileRule pfrules
  hPutStrLn stderr "--------------------------------"
  where
    profileCat (cid,(fcat1,fcat2,_)) = do
      hPutStrLn stderr (lformat 23 (showIdent cid) ++ rformat 9 (show (fcat2-fcat1+1)))

    profileRule (PFRule fun args res ctypes ctype term) = do
      let pargs = map (protoFCat env) args
      hPutStrLn stderr (lformat 23 (showIdent fun) ++ rformat 9 (show (product (map (catFactor env) args))))
      where
        catFactor (GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) (n,(_,cat)) =
          case Map.lookup cat catSet of
            Just (s,e,_) -> e-s+1
            Nothing      -> 0

    lformat :: Int -> String -> String
    lformat n s = s ++ replicate (n-length s) ' '

    rformat :: Int -> String -> String
    rformat n s = replicate (n-length s) ' ' ++ s

data ProtoFRule = PFRule Ident         {- function -}
                         [([Cat],Cat)] {- argument types: context size and category -}
                         ([Cat],Cat)   {- result   type : context size (always 0) and category  -}
                         [Type]        {- argument lin-types representation -}
                         Type          {- result   lin-type  representation -}
                         Term          {- body -}

optimize :: [ProtoFCat] -> GrammarEnv -> GrammarEnv
optimize pargs (GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) =
  IntMap.foldWithKey optimize (GrammarEnv last_id catSet seqSet funSet lindefSet crcSet IntMap.empty prodSet) appSet
  where
    optimize cat ps env = IntMap.foldWithKey ff env (IntMap.fromListWith (++) [(funid,[args]) | (funid,args) <- Set.toList ps])
      where
        ff :: FunId -> [[FId]] -> GrammarEnv -> GrammarEnv
        ff funid xs env
          | product (map Set.size ys) == count
                      = case List.mapAccumL (\env c -> addCoercion env (Set.toList c)) env ys of
                          (env,args) -> let xs = sequence (zipWith addContext pargs args)
                                        in List.foldl (\env x -> addProduction env cat (PApply funid x)) env xs
          | otherwise = List.foldl (\env args -> let xs = sequence (zipWith addContext pargs args)
                                                 in List.foldl (\env x -> addProduction env cat (PApply funid x)) env xs) env xs
          where
            count = length xs
            ys    = foldr (zipWith Set.insert) (repeat Set.empty) xs

        addContext (PFCat ctxt _ _) fid = do hyps <- mapM toCncHypo ctxt
                                             return (PArg hyps fid)

        toCncHypo cat =
          case Map.lookup cat catSet of
            Just (s,e,_) -> do fid <- range (s,e)
                               guard (fid `IntMap.member` lindefSet)
                               return (fidVar,fid)
            Nothing      -> mzero

convertRule :: SourceGrammar -> Options -> GrammarEnv -> ProtoFRule -> IO GrammarEnv
convertRule gr opts grammarEnv (PFRule fun args res ctypes ctype term) = do
  let pres  = protoFCat grammarEnv res
      pargs = map (protoFCat grammarEnv) args

      b     = runCnvMonad gr (unfactor term >>= convertTerm opts CNil ctype) (pargs,[])
      (grammarEnv1,b1) = addSequencesB grammarEnv b
      grammarEnv2 = foldBM addRule
                           grammarEnv1
                           (goB b1 CNil [])
                           (pres,pargs)
      grammarEnv3 = optimize pargs grammarEnv2
  when (verbAtLeast opts Verbose) $ hPutStrLn stderr ("+ "++showIdent fun)
  return $! grammarEnv3
  where
    addRule lins (newCat', newArgs') env0 =
      let [newCat]        = getFIds env0 newCat'
          (env1, newArgs) = List.mapAccumL (\env -> addCoercion env . getFIds env) env0 newArgs'

          (env2,funid) = addCncFun env1 (PGF.Data.CncFun (i2i fun) (mkArray lins))

      in addApplication env2 newCat (funid,newArgs)

convertLinDef :: SourceGrammar -> Options -> GrammarEnv -> (Cat,Term,Type) -> IO GrammarEnv
convertLinDef gr opts grammarEnv (cat,lindef,lincat) = do
  let pres = protoFCat grammarEnv ([],cat)
      parg = protoFCat grammarEnv ([],(identW,cVar))

      b     = runCnvMonad gr (unfactor lindef >>= convertTerm opts CNil lincat) ([parg],[])
      (grammarEnv1,b1) = addSequencesB grammarEnv b
      grammarEnv2 = foldBM addRule
                           grammarEnv1
                           (goB b1 CNil [])
                           (pres,[parg])
  when (verbAtLeast opts Verbose) $ hPutStrLn stderr ("+ "++showCId lindefCId)
  return $! grammarEnv2
  where
    lindefCId = mkCId ("lindef "++showIdent (snd cat))

    addRule lins (newCat', newArgs') env0 =
      let [newCat]     = getFIds env0 newCat'
          (env1,funid) = addCncFun env0 (PGF.Data.CncFun lindefCId (mkArray lins))
      in addLinDef env1 newCat funid

unfactor :: Term -> CnvMonad Term
unfactor t = CM (\gr c -> c (unfac gr t))
  where
    unfac gr t = 
      case t of
        T (TTyped ty) [(PV x,u)] -> V ty [restore x v (unfac gr u) | v <- err error id (allParamValues gr ty)]
        _ -> composSafeOp (unfac gr) t
      where
        restore x u t = case t of
                          Vr y | y == x -> u
                          _             -> composSafeOp (restore x u) t

----------------------------------------------------------------------
-- CnvMonad monad
--
-- The branching monad provides backtracking together with
-- recording of the choices made. We have two cases
-- when we have alternative choices:
--
--      * when we have parameter type, then
--        we have to try all possible values
--      * when we have variants we have to try all alternatives
--
-- The conversion monad keeps track of the choices and they are
-- returned as 'Branch' data type.

data Branch a
  = Case Int Path [(Term,Branch a)]
  | Variant [Branch a]
  | Return  a

newtype CnvMonad a = CM {unCM :: SourceGrammar
                              -> forall b . (a -> ([ProtoFCat],[Symbol]) -> Branch b)
                              -> ([ProtoFCat],[Symbol])
                              -> Branch b}

instance Monad CnvMonad where
    return a   = CM (\gr c s -> c a s)
    CM m >>= k = CM (\gr c s -> m gr (\a s -> unCM (k a) gr c s) s)

instance MonadState ([ProtoFCat],[Symbol]) CnvMonad where
    get = CM (\gr c s -> c s s)
    put s = CM (\gr c _ -> c () s)

instance Functor CnvMonad where
    fmap f (CM m) = CM (\gr c s -> m gr (c . f) s)

runCnvMonad :: SourceGrammar -> CnvMonad a -> ([ProtoFCat],[Symbol]) -> Branch a
runCnvMonad gr (CM m) s = m gr (\v s -> Return v) s

-- | backtracking for all variants
variants :: [a] -> CnvMonad a
variants xs = CM (\gr c s -> Variant [c x s | x <- xs])

-- | backtracking for all parameter values that a variable could take
choices :: Int -> Path -> CnvMonad Term
choices nr path = do (args,_) <- get
                     let PFCat _ _ schema = args !! nr
		     descend schema path CNil
  where
    descend (CRec rs)     (CProj lbl path) rpath = case lookup lbl rs of
                                                     Just (Identity t) -> descend t path (CProj lbl rpath)
    descend (CRec rs)     CNil             rpath = do rs <- mapM (\(lbl,Identity t) -> fmap (assign lbl) (descend t CNil (CProj lbl rpath))) rs
                                                      return (R rs)
    descend (CTbl pt cs)  (CSel  trm path) rpath = case lookup trm cs of
                                                     Just (Identity t) -> descend t path (CSel trm rpath)
    descend (CTbl pt cs)  CNil             rpath = do cs <- mapM (\(trm,Identity t) -> descend t CNil (CSel trm rpath)) cs
                                                      return (V pt cs)
    descend (CPar (m,vs)) CNil             rpath = case vs of
                                                     [(value,index)] -> return value
                                                     values          -> let path = reversePath rpath
                                                                        in CM (\gr c s -> Case nr path [(value, updateEnv path value gr c s)
                                                                                                                    | (value,index) <- values])

    updateEnv path value gr c (args,seq) = 
      case updateNthM (restrictProtoFCat path value) nr args of
        Just args -> c value (args,seq)
        Nothing   -> error "conflict in updateEnv"

-- | the argument should be a parameter type and then
-- the function returns all possible values.
getAllParamValues :: Type -> CnvMonad [Term]
getAllParamValues ty = CM (\gr c -> c (err error id (allParamValues gr ty)))

mkRecord :: [(Label,CnvMonad (Schema Branch s c))] -> CnvMonad (Schema Branch s c)
mkRecord xs = CM (\gr c -> foldl (\c (lbl,CM m) bs s -> c ((lbl,m gr (\v s -> Return v) s) : bs) s) (c . CRec) xs [])

mkTable  :: Type -> [(Term ,CnvMonad (Schema Branch s c))] -> CnvMonad (Schema Branch s c)
mkTable pt xs = CM (\gr c -> foldl (\c (trm,CM m) bs s -> c ((trm,m gr (\v s -> Return v) s) : bs) s) (c . CTbl pt) xs [])

----------------------------------------------------------------------
-- Term Schema
--
-- The term schema is a term-like structure, with records, tables,
-- strings and parameters values, but in addition we could add
-- annotations of arbitrary types

-- | Term schema
data Schema b s c
  = CRec      [(Label,b (Schema b s c))]
  | CTbl Type [(Term, b (Schema b s c))]
  | CStr s
  | CPar c

-- | Path into a term or term schema
data Path
  = CProj Label Path
  | CSel  Term  Path
  | CNil
  deriving (Eq,Show)

-- | The ProtoFCat represents a linearization type as term schema.
-- The annotations are as follows: the strings are annotated with
-- their index in the PMCFG tuple, the parameters are annotated
-- with their value both as term and as index.
data ProtoFCat  = PFCat [Ident] Ident Proto
type Env        = (ProtoFCat, [ProtoFCat])

protoFCat :: GrammarEnv -> ([Cat],Cat) -> ProtoFCat
protoFCat (GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) (ctxt,(_,cat)) =
  case Map.lookup cat catSet of
    Just (_,_,proto) -> PFCat (map snd ctxt) cat proto
    Nothing          -> error "unknown category"
  
ppPath (CProj lbl path) = ppLabel lbl              <+> ppPath path
ppPath (CSel  trm path) = ppTerm Unqualified 5 trm <+> ppPath path
ppPath CNil             = empty

reversePath path = rev CNil path
  where
    rev path0 CNil             = path0
    rev path0 (CProj lbl path) = rev (CProj lbl path0) path
    rev path0 (CSel  trm path) = rev (CSel  trm path0) path


----------------------------------------------------------------------
-- term conversion

type Value a = Schema Branch a Term

convertTerm :: Options -> Path -> Type -> Term -> CnvMonad (Value [Symbol])
convertTerm opts sel ctype (Vr x)       = convertArg opts ctype (getVarIndex x) (reversePath sel)
convertTerm opts sel ctype (Abs _ _ t)  = convertTerm opts sel ctype t                -- there are only top-level abstractions and we ignore them !!!
convertTerm opts sel ctype (R record)   = convertRec opts sel ctype record
convertTerm opts sel ctype (P term l)   = convertTerm opts (CProj l sel) ctype term
convertTerm opts sel ctype (V pt ts)    = convertTbl opts sel ctype pt ts
convertTerm opts sel ctype (S term p)   = do v <- evalTerm CNil p
                                             convertTerm opts (CSel v sel) ctype term
convertTerm opts sel ctype (FV vars)    = do term <- variants vars
                                             convertTerm opts sel ctype term
convertTerm opts sel ctype (C t1 t2)    = do v1 <- convertTerm opts sel ctype t1
                                             v2 <- convertTerm opts sel ctype t2
                                             return (CStr (concat [s | CStr s <- [v1,v2]]))
convertTerm opts sel ctype (K t)        = return (CStr [SymKS [t]])
convertTerm opts sel ctype Empty        = return (CStr [])
convertTerm opts sel ctype (Alts s alts)
                                        = return (CStr [SymKP (strings s) [Alt (strings u) (strings v) | (u,v) <- alts]])
                                            where
                                              strings (K s)     = [s]
                                              strings (C u v)   = strings u ++ strings v
                                              strings (Strs ss) = concatMap strings ss
convertTerm opts CNil ctype t           = do v <- evalTerm CNil t
                                             return (CPar v)
convertTerm _    _    _     t           = error (render (text "convertTerm" <+> parens (ppTerm Unqualified 0 t)))

convertArg :: Options -> Term -> Int -> Path -> CnvMonad (Value [Symbol])
convertArg opts (RecType rs)  nr path =
  mkRecord (map (\(lbl,ctype) -> (lbl,convertArg opts ctype nr (CProj lbl path))) rs)
convertArg opts (Table pt vt) nr path = do
  vs <- getAllParamValues pt
  mkTable pt (map (\v -> (v,convertArg opts vt nr (CSel v path))) vs)
convertArg opts (Sort _)      nr path = do
  (args,_) <- get
  let PFCat _ cat schema = args !! nr
      l = index (reversePath path) schema
      sym | CProj (LVar i) CNil <- path = SymVar nr i
          | isLiteralCat opts cat       = SymLit nr l
          | otherwise                   = SymCat nr l
  return (CStr [sym])
  where
    index (CProj lbl path) (CRec   rs) = case lookup lbl rs of
                                           Just (Identity t) -> index path t
    index (CSel  trm path) (CTbl _ rs) = case lookup trm rs of
                                           Just (Identity t) -> index path t
    index CNil             (CStr idx)  = idx
convertArg opts ty nr path              = do
  value <- choices nr (reversePath path)
  return (CPar value)

convertRec opts CNil (RecType rs) record =
  mkRecord (map (\(lbl,ctype) -> (lbl,convertTerm opts CNil ctype (projectRec lbl record))) rs)
convertRec opts (CProj lbl path) ctype record =
  convertTerm opts path ctype (projectRec lbl record)
convertRec opts _ ctype _ = error ("convertRec: "++show ctype)

convertTbl opts CNil (Table _ vt) pt ts = do
  vs <- getAllParamValues pt
  mkTable pt (zipWith (\v t -> (v,convertTerm opts CNil vt t)) vs ts)
convertTbl opts (CSel v sub_sel) ctype pt ts = do
  vs <- getAllParamValues pt
  case lookup v (zip vs ts) of
    Just t  -> convertTerm opts sub_sel ctype t
    Nothing -> error (render (text "convertTbl:" <+> (text "missing value" <+> ppTerm Unqualified 0 v $$
                                                      text "among" <+> vcat (map (ppTerm Unqualified 0) vs))))
convertTbl opts _ ctype _ _ = error ("convertTbl: "++show ctype)


goB :: Branch (Value SeqId) -> Path -> [SeqId] -> BacktrackM Env [SeqId]
goB (Case nr path bs) rpath ss = do (value,b) <- member bs
                                    restrictArg nr path value
                                    goB b rpath ss
goB (Variant bs)      rpath ss = do b <- member bs
                                    goB b rpath ss
goB (Return  v)       rpath ss = goV v rpath ss

goV :: Value SeqId -> Path -> [SeqId] -> BacktrackM Env [SeqId]
goV (CRec xs)    rpath ss = foldM (\ss (lbl,b) -> goB b (CProj lbl rpath) ss) ss (reverse xs)
goV (CTbl _ xs)  rpath ss = foldM (\ss (trm,b) -> goB b (CSel  trm rpath) ss) ss (reverse xs)
goV (CStr seqid) rpath ss = return (seqid : ss)
goV (CPar t)     rpath ss = restrictHead (reversePath rpath) t >> return ss

addSequencesB :: GrammarEnv -> Branch (Value [Symbol]) -> (GrammarEnv, Branch (Value SeqId))
addSequencesB env (Case nr path bs) = let (env1,bs1) = List.mapAccumL (\env (trm,b) -> let (env',b') = addSequencesB env b
                                                                                       in (env',(trm,b'))) env bs
                                      in (env1,Case nr path bs1)
addSequencesB env (Variant bs)      = let (env1,bs1) = List.mapAccumL addSequencesB env bs
                                      in (env1,Variant bs1)
addSequencesB env (Return  v)       = let (env1,v1) = addSequencesV env v
                                      in (env1,Return v1)

addSequencesV :: GrammarEnv -> Value [Symbol] -> (GrammarEnv, Value SeqId)
addSequencesV env (CRec vs)  = let (env1,vs1) = List.mapAccumL (\env (lbl,b) -> let (env',b') = addSequencesB env b
                                                                                in (env',(lbl,b'))) env vs
                               in (env1,CRec vs1)
addSequencesV env (CTbl pt vs)=let (env1,vs1) = List.mapAccumL (\env (trm,b) -> let (env',b') = addSequencesB env b
                                                                                in (env',(trm,b'))) env vs
                               in (env1,CTbl pt vs1)
addSequencesV env (CStr lin) = let (env1,seqid) = addSequence env (optimizeLin lin)
                               in (env1,CStr seqid)
addSequencesV env (CPar i)   = (env,CPar i)


optimizeLin [] = []
optimizeLin lin@(SymKS _ : _) = 
  let (ts,lin') = getRest lin
  in SymKS ts : optimizeLin lin'
  where
    getRest (SymKS ts : lin) = let (ts1,lin') = getRest lin
                               in (ts++ts1,lin')
    getRest             lin  = ([],lin)
optimizeLin (sym : lin) = sym : optimizeLin lin


------------------------------------------------------------
-- eval a term to ground terms

evalTerm :: Path -> Term -> CnvMonad Term
evalTerm CNil (QC f)       = return (QC f)
evalTerm CNil (App x y)    = do x <- evalTerm CNil x
                                y <- evalTerm CNil y
                                return (App x y)
evalTerm path (Vr x)       = choices (getVarIndex x) path
evalTerm path (R rs)       = case path of
                               (CProj lbl path) -> evalTerm path (projectRec lbl rs)
                               CNil             -> do rs <- mapM (\(lbl,(_,t)) -> do t <- evalTerm path t
                                                                                     return (assign lbl t)) rs
                                                      return (R rs)
evalTerm path (P term lbl) = evalTerm (CProj lbl path) term
evalTerm path (V pt ts)    = case path of
                               (CSel trm path) -> do vs <- getAllParamValues pt
                                                     case lookup trm (zip vs ts) of
                                                       Just t  -> evalTerm path t
                                                       Nothing -> error "evalTerm: missing value"
                               CNil             -> do ts <- mapM (evalTerm path) ts
                                                      return (V pt ts)
evalTerm path (S term sel) = do v <- evalTerm CNil sel
                                evalTerm (CSel v path) term
evalTerm path (FV terms)   = variants terms >>= evalTerm path
evalTerm path (EInt n)     = return (EInt n)
evalTerm path t            = error (render (text "evalTerm" <+> parens (ppTerm Unqualified 0 t)))

getVarIndex (IA _ i) = i
getVarIndex (IAV _ _ i) = i
getVarIndex (IC s) | isDigit (BS.last s) = (read . BS.unpack . snd . BS.spanEnd isDigit) s

----------------------------------------------------------------------
-- GrammarEnv

data GrammarEnv = GrammarEnv {-# UNPACK #-} !Int CatSet SeqSet FunSet LinDefSet CoerceSet AppSet ProdSet
type Proto    = Schema Identity Int (Int,[(Term,Int)])
type CatSet   = Map.Map Ident (FId,FId,Proto)
type SeqSet   = Map.Map Sequence SeqId
type FunSet   = Map.Map CncFun FunId
type LinDefSet= IntMap.IntMap [FunId]
type CoerceSet= Map.Map [FId] FId
type AppSet   = IntMap.IntMap (Set.Set (FunId,[FId]))
type ProdSet  = IntMap.IntMap (Set.Set Production)

emptyGrammarEnv gr (m,mo) =
  let (last_id,catSet) = Map.mapAccumWithKey computeCatRange 0 lincats
  in GrammarEnv last_id catSet Map.empty Map.empty IntMap.empty Map.empty IntMap.empty IntMap.empty
  where
    computeCatRange index cat ctype
      | cat == cString = (index,(fidString,fidString,CRec [(theLinLabel,Identity (CStr 0))]))
      | cat == cInt    = (index,(fidInt,   fidInt,   CRec [(theLinLabel,Identity (CStr 0))]))
      | cat == cFloat  = (index,(fidFloat, fidFloat, CRec [(theLinLabel,Identity (CStr 0))]))
      | cat == cVar    = (index,(fidFloat, fidFloat, CStr 0))
      | otherwise      = (index+size,(index,index+size-1,schema))
      where
        ((_,size),schema) = compute (0,1) ctype
 
    compute st (RecType  rs) = let (st',rs') = List.mapAccumL (\st (lbl,t) -> let (st',t') = compute st t
                                                                              in (st',(lbl,Identity t'))) st rs
                               in (st',CRec rs')
    compute st (Table pt vt) = let vs        = err error id (allParamValues gr pt)
                                   (st',cs') = List.mapAccumL (\st v       -> let (st',vt') = compute st vt
                                                                              in (st',(v,Identity vt'))) st vs
                               in (st',CTbl pt cs')
    compute st (Sort s)
                   | s == cStr = let (index,m) = st
                                 in ((index+1,m),CStr index)
    compute st t               = let vs = err error id (allParamValues gr t)
                                     (index,m) = st
                                 in ((index,m*length vs),CPar (m,zip vs [0..]))

    lincats =
      Map.insert cVar (Sort cStr) $
      Map.fromAscList 
        [(c, ty) | (c,GF.Grammar.CncCat (Just (L _ ty)) _ _) <- Map.toList (M.jments mo)]

addApplication :: GrammarEnv -> FId -> (FunId,[FId]) -> GrammarEnv
addApplication (GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) fid p =
  GrammarEnv last_id catSet seqSet funSet lindefSet crcSet (IntMap.insertWith Set.union fid (Set.singleton p) appSet) prodSet

addProduction :: GrammarEnv -> FId -> Production -> GrammarEnv
addProduction (GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) cat p =
  GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet (IntMap.insertWith Set.union cat (Set.singleton p) prodSet)

addSequence :: GrammarEnv -> [Symbol] -> (GrammarEnv,SeqId)
addSequence env@(GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) lst =
  case Map.lookup seq seqSet of
    Just id -> (env,id)
    Nothing -> let !last_seq = Map.size seqSet
               in (GrammarEnv last_id catSet (Map.insert seq last_seq seqSet) funSet lindefSet crcSet appSet prodSet,last_seq)
  where
    seq = mkArray lst

addCncFun :: GrammarEnv -> CncFun -> (GrammarEnv,FunId)
addCncFun env@(GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) fun = 
  case Map.lookup fun funSet of
    Just id -> (env,id)
    Nothing -> let !last_funid = Map.size funSet
               in (GrammarEnv last_id catSet seqSet (Map.insert fun last_funid funSet) lindefSet crcSet appSet prodSet,last_funid)

addCoercion :: GrammarEnv -> [FId] -> (GrammarEnv,FId)
addCoercion env@(GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) sub_fcats =
  case sub_fcats of
    [fcat] -> (env,fcat)
    _      -> case Map.lookup sub_fcats crcSet of
                Just fcat -> (env,fcat)
                Nothing   -> let !fcat = last_id+1
                             in (GrammarEnv fcat catSet seqSet funSet lindefSet (Map.insert sub_fcats fcat crcSet) appSet prodSet,fcat)

addLinDef :: GrammarEnv -> FId -> FunId -> GrammarEnv
addLinDef (GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) fid funid =
  GrammarEnv last_id catSet seqSet funSet (IntMap.insertWith (++) fid [funid] lindefSet) crcSet appSet prodSet

getConcr :: Map.Map CId Literal -> Map.Map CId String -> GrammarEnv -> Concr
getConcr flags printnames (GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) =
  Concr { cflags = flags
        , printnames = printnames
        , cncfuns   = mkSetArray funSet
        , lindefs = lindefSet
        , sequences   = mkSetArray seqSet
        , productions = IntMap.union prodSet coercions
        , pproductions = IntMap.empty
        , lproductions = Map.empty
        , cnccats = Map.fromList [(i2i cat,PGF.Data.CncCat start end (mkArray (map (renderStyle style{mode=OneLineMode} . ppPath) (getStrPaths schema))))
                                     | (cat,(start,end,schema)) <- Map.toList catSet]
        , totalCats   = last_id+1
        }
  where
    mkSetArray map = array (0,Map.size map-1) [(v,k) | (k,v) <- Map.toList map]
    
    coercions = IntMap.fromList [(fcat,Set.fromList (map PCoerce sub_fcats)) | (sub_fcats,fcat) <- Map.toList crcSet]

    getStrPaths :: Schema Identity s c -> [Path]
    getStrPaths = collect CNil []
      where
        collect path paths (CRec rs)   = foldr (\(lbl,Identity t) paths -> collect (CProj lbl path) paths t) paths rs
        collect path paths (CTbl _ cs) = foldr (\(trm,Identity t) paths -> collect (CSel  trm path) paths t) paths cs
        collect path paths (CStr _)    = reversePath path : paths
        collect path paths (CPar _)    = paths


getFIds :: GrammarEnv -> ProtoFCat -> [FId]
getFIds (GrammarEnv last_id catSet seqSet funSet lindefSet crcSet appSet prodSet) (PFCat ctxt cat schema) =
  case Map.lookup cat catSet of
    Just (start,end,_) -> reverse (solutions (fmap (start +) $ variants schema) ())
  where
    variants (CRec rs)         = fmap sum $ mapM (\(lbl,Identity t) -> variants t) rs
    variants (CTbl _ cs)       = fmap sum $ mapM (\(trm,Identity t) -> variants t) cs
    variants (CStr _)          = return 0
    variants (CPar (m,values)) = do (value,index) <- member values
                                    return (m*index)

------------------------------------------------------------
-- updating the MCF rule

restrictArg :: LIndex -> Path -> Term -> BacktrackM Env ()
restrictArg nr path index = do
  (head, args) <- get
  args <- updateNthM (restrictProtoFCat path index) nr args
  put (head, args)

restrictHead :: Path -> Term -> BacktrackM Env ()
restrictHead path term = do
  (head, args) <- get
  head <- restrictProtoFCat path term head
  put (head, args)

restrictProtoFCat :: (Functor m, MonadPlus m) => Path -> Term -> ProtoFCat -> m ProtoFCat
restrictProtoFCat path v (PFCat ctxt cat schema) = do
  schema <- addConstraint path v schema
  return (PFCat ctxt cat schema)
  where
    addConstraint (CProj lbl path) v (CRec rs)     = fmap CRec      $ update lbl (addConstraint path v) rs
    addConstraint (CSel  trm path) v (CTbl pt cs)  = fmap (CTbl pt) $ update trm (addConstraint path v) cs
    addConstraint CNil             v (CPar (m,vs)) = case lookup v vs of
                                                       Just index -> return (CPar (m,[(v,index)]))
                                                       Nothing    -> mzero
    addConstraint CNil             v (CStr _)      = error "restrictProtoFCat: string path"
    
    update k0 f [] = return []
    update k0 f (x@(k,Identity v):xs)
      | k0 == k    = do v <- f v
                        return ((k,Identity v):xs)
      | otherwise  = do xs <- update k0 f xs
                        return (x:xs)

mkArray lst = listArray (0,length lst-1) lst
