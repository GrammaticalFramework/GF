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
    (generatePMCFG, pgfCncCat, addPMCFG, resourceValues
    ) where

import PGF.CId
import PGF.Data(Alternative(..),CncCat(..),Symbol(..),fidVar)

import GF.Infra.Option
import GF.Grammar hiding (Env, mkRecord, mkTable)
import GF.Grammar.Lookup
import GF.Grammar.Predef
import GF.Data.BacktrackM
import GF.Data.Operations
import GF.Infra.UseIO (IOE)
import GF.Data.Utilities (updateNthM, updateNth)
import GF.Compile.Compute.ConcreteNew(GlobalEnv,normalForm,resourceValues,ppL)
import System.IO(hPutStr,hPutStrLn,stderr)
import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.List as List
import qualified Data.IntMap as IntMap
import qualified Data.IntSet as IntSet
import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint hiding (Str)
import Data.Array.IArray
import Data.Array.Unboxed
import Data.Maybe
import Data.Char (isDigit)
import Control.Monad
import Control.Monad.Identity
import Control.Monad.Trans (liftIO)
import Control.Exception

----------------------------------------------------------------------
-- main conversion function

generatePMCFG :: Options -> SourceGrammar -> Maybe FilePath -> SourceModule -> IOE SourceModule
generatePMCFG opts sgr opath cmo@(cm,cmi) = do
  (seqs,js) <- mapAccumWithKeyM (addPMCFG opts gr cenv opath am cm) Map.empty (jments cmi)
  when (verbAtLeast opts Verbose) $ liftIO $ hPutStrLn stderr ""
  return (cm,cmi{mseqs = Just (mkSetArray seqs), jments = js})
  where
    cenv = resourceValues gr
    gr = prependModule sgr cmo
    MTConcrete am = mtype cmi

mapAccumWithKeyM :: (Monad m, Ord k) => (a -> k -> b -> m (a,c)) -> a
                                     -> Map.Map k b -> m (a,Map.Map k c)
mapAccumWithKeyM f a m = do let xs = Map.toAscList m
                            (a,ys) <- mapAccumM f a xs
                            return (a,Map.fromAscList ys)
  where
    mapAccumM f a []          = return (a,[])
    mapAccumM f a ((k,x):kxs) = do (a,y ) <- f a k x
                                   (a,kys) <- mapAccumM f a kxs
                                   return (a,(k,y):kys)


addPMCFG :: Options -> SourceGrammar -> GlobalEnv -> Maybe FilePath -> Ident -> Ident -> SeqSet -> Ident -> Info -> IOE (SeqSet, Info)
addPMCFG opts gr cenv opath am cm seqs id (GF.Grammar.CncFun mty@(Just (cat,cont,val)) mlin@(Just (L loc term)) mprn Nothing) = do
  let pres  = protoFCat gr res val
      pargs = [protoFCat gr (snd $ catSkeleton ty) lincat | ((_,_,ty),(_,_,lincat)) <- zip ctxt cont]

      pmcfgEnv0   = emptyPMCFGEnv

  b             <- convert opts gr cenv (floc opath loc id) term val pargs
  let (seqs1,b1) = addSequencesB seqs b
      pmcfgEnv1  = foldBM addRule
                          pmcfgEnv0
                          (goB b1 CNil [])
                          (pres,pargs)
      pmcfg      = getPMCFG pmcfgEnv1
      
      stats      = let PMCFG prods funs = pmcfg
                       (s,e)            = bounds funs
                       !prods_cnt       = length prods
                       !funs_cnt        = e-s+1
                   in (prods_cnt,funs_cnt)

  when (verbAtLeast opts Verbose) $ liftIO $ hPutStr stderr ("\n+ "++showIdent id ++ " " ++ show (product (map catFactor pargs)))
  seqs1 `seq` stats `seq` return ()
  when (verbAtLeast opts Verbose) $ liftIO $ hPutStr stderr (" "++show stats)
  return (seqs1,GF.Grammar.CncFun mty mlin mprn (Just pmcfg))
  where
    (ctxt,res,_) = err bug typeForm (lookupFunType gr am id)

    addRule lins (newCat', newArgs') env0 =
      let [newCat] = getFIds newCat'
          !fun     = mkArray lins
          newArgs  = map getFIds newArgs'
      in addFunction env0 newCat fun newArgs

addPMCFG opts gr cenv opath am cm seqs id (GF.Grammar.CncCat mty@(Just (L _ lincat)) mdef@(Just (L loc term)) mprn Nothing) = do
  let pres = protoFCat gr (am,id) lincat
      parg = protoFCat gr (identW,cVar) typeStr

      pmcfgEnv0  = emptyPMCFGEnv

  b             <- convert opts gr cenv (floc opath loc id) term lincat [parg]
  let (seqs1,b1) = addSequencesB seqs b
      pmcfgEnv1  = foldBM addRule
                          pmcfgEnv0
                          (goB b1 CNil [])
                          (pres,[parg])
      pmcfg     = getPMCFG pmcfgEnv1
  when (verbAtLeast opts Verbose) $ liftIO $ hPutStr stderr ("\n+ "++showIdent id++" "++show (catFactor pres))
  seqs1 `seq` pmcfg `seq` return (seqs1,GF.Grammar.CncCat mty mdef mprn (Just pmcfg))
  where
    addRule lins (newCat', newArgs') env0 =
      let [newCat] = getFIds newCat'
          !fun     = mkArray lins
      in addFunction env0 newCat fun [[fidVar]]

addPMCFG opts gr cenv opath am cm seqs id info = return (seqs, info)

floc opath loc id = maybe (L loc id) (\path->L (External path loc) id) opath

convert opts gr cenv loc term val pargs =
    case term' of
      Error s -> fail $ render $ ppL loc (text $ "Predef.error: "++s)
      _ -> return $ runCnvMonad gr (conv term') (pargs,[])
  where
    conv t = convertTerm opts CNil val =<< unfactor t

    term' = if flag optNewComp opts
            then normalForm cenv loc (recordExpand val term) -- new evaluator
            else term -- old evaluator is invoked from GF.Compile.Optimize

recordExpand :: Type -> Term -> Term
recordExpand typ trm =
  case typ of
     RecType tys -> expand trm
       where
         n = length tys
         expand trm =
           case trm of
             FV ts -> FV (map expand ts)
             R rs | length rs==n -> trm
             _ -> R [assign lab (P trm lab) | (lab,_) <- tys]
     _ -> trm

unfactor :: Term -> CnvMonad Term
unfactor t = CM (\gr c -> c (unfac gr t))
  where
    unfac gr t = 
      case t of
        T (TTyped ty) [(PV x,u)] -> let u' = unfac gr u
                                    in V ty [restore x v u' | v <- allparams ty]
        T (TTyped ty) [(PW  ,u)] -> let u' = unfac gr u
                                    in V ty [u' | _ <- allparams ty]
        T (TTyped ty) _ -> -- convertTerm doesn't handle these tables
                           ppbug $
                           sep [text "unfactor"<+>ppTerm Unqualified 10 t,
                                text (show t){-,
                                fsep (map (ppTerm Unqualified 10) (allparams ty))-}]
        _ -> composSafeOp (unfac gr) t
      where
        allparams ty = err bug id (allParamValues gr ty)

        restore x u t = case t of
                          Vr y | y == x -> u
                          _             -> composSafeOp (restore x u) t

pgfCncCat :: SourceGrammar -> Type -> Int -> PGF.Data.CncCat
pgfCncCat gr lincat index =
  let ((_,size),schema) = computeCatRange gr lincat
  in PGF.Data.CncCat index
                     (index+size-1)
                     (mkArray (map (renderStyle style{mode=OneLineMode} . ppPath) 
                                   (getStrPaths schema)))
  where
    getStrPaths :: Schema Identity s c -> [Path]
    getStrPaths = collect CNil []
      where
        collect path paths (CRec rs)   = foldr (\(lbl,Identity t) paths -> collect (CProj lbl path) paths t) paths rs
        collect path paths (CTbl _ cs) = foldr (\(trm,Identity t) paths -> collect (CSel  trm path) paths t) paths cs
        collect path paths (CStr _)    = reversePath path : paths
        collect path paths (CPar _)    = paths

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
    descend schema       path              rpath = bug $ "descend "++show (schema,path,rpath)

    updateEnv path value gr c (args,seq) = 
      case updateNthM (restrictProtoFCat path value) nr args of
        Just args -> c value (args,seq)
        Nothing   -> bug "conflict in updateEnv"

-- | the argument should be a parameter type and then
-- the function returns all possible values.
getAllParamValues :: Type -> CnvMonad [Term]
getAllParamValues ty = CM (\gr c -> c (err bug id (allParamValues gr ty)))

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
--deriving Show -- doesn't work

instance Show s => Show (Schema b s c) where
  showsPrec _ sch =
      case sch of
        CRec r   -> showString "CRec " . shows (map fst r)
        CTbl t _ -> showString "CTbl " . showsPrec 10 t . showString " _"
        CStr s   -> showString "CStr " . showsPrec 10 s
        CPar c   -> showString "CPar{}"

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
data ProtoFCat  = PFCat Ident Int (Schema Identity Int (Int,[(Term,Int)]))
type Env        = (ProtoFCat, [ProtoFCat])

protoFCat :: SourceGrammar -> Cat -> Type -> ProtoFCat
protoFCat gr cat lincat =
  case computeCatRange gr lincat of
    ((_,f),schema) -> PFCat (snd cat) f schema

getFIds :: ProtoFCat -> [FId]
getFIds (PFCat _ _ schema) =
  reverse (solutions (variants schema) ())
  where
    variants (CRec rs)         = fmap sum $ mapM (\(lbl,Identity t) -> variants t) rs
    variants (CTbl _ cs)       = fmap sum $ mapM (\(trm,Identity t) -> variants t) cs
    variants (CStr _)          = return 0
    variants (CPar (m,values)) = do (value,index) <- member values
                                    return (m*index)

catFactor :: ProtoFCat -> Int
catFactor (PFCat _ f _) = f

computeCatRange gr lincat = compute (0,1) lincat
  where
    compute st (RecType  rs) = let (st',rs') = List.mapAccumL (\st (lbl,t) -> case lbl of
                                                                                LVar _ -> let (st',t') = compute st t
                                                                                          in (st ,(lbl,Identity t'))
                                                                                _      -> let (st',t') = compute st t
                                                                                          in (st',(lbl,Identity t'))) st rs
                               in (st',CRec rs')
    compute st (Table pt vt) = let vs        = err bug id (allParamValues gr pt)
                                   (st',cs') = List.mapAccumL (\st v       -> let (st',vt') = compute st vt
                                                                              in (st',(v,Identity vt'))) st vs
                               in (st',CTbl pt cs')
    compute st (Sort s)
                   | s == cStr = let (index,m) = st
                                 in ((index+1,m),CStr index)
    compute st t               = let vs = err bug id (allParamValues gr t)
                                     (index,m) = st
                                 in ((index,m*length vs),CPar (m,zip vs [0..]))

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
             strings (EPatt p) = getPatts p
             strings Empty = [] -- ??
             strings t = bug $ "strings "++show t

             getPatts p =
               case p of
                 PAlt a b  -> getPatts a ++ getPatts b
                 PString s -> [s]
                 PSeq a b  -> [s ++ t | s <- getPatts a, t <- getPatts b]
                 _ -> ppbug $ hang (text "not valid pattern in pre expression:")
                                   4
                                   (ppPatt Unqualified 0 p)

convertTerm opts sel@(CProj l _) ctype (ExtR t1 t2@(R rs2))
                    | l `elem` map fst rs2 = convertTerm opts sel ctype t2
                    | otherwise            = convertTerm opts sel ctype t1

convertTerm opts sel@(CProj l _) ctype (ExtR t1@(R rs1) t2)
                    | l `elem` map fst rs1 = convertTerm opts sel ctype t1
                    | otherwise            = convertTerm opts sel ctype t2

convertTerm opts CNil ctype t           = do v <- evalTerm CNil t
                                             return (CPar v)
convertTerm _    sel  _     t           = ppbug (text "convertTerm" <+> sep [parens (text (show sel)),ppTerm Unqualified 10 t])

convertArg :: Options -> Term -> Int -> Path -> CnvMonad (Value [Symbol])
convertArg opts (RecType rs)  nr path =
  mkRecord (map (\(lbl,ctype) -> (lbl,convertArg opts ctype nr (CProj lbl path))) rs)
convertArg opts (Table pt vt) nr path = do
  vs <- getAllParamValues pt
  mkTable pt (map (\v -> (v,convertArg opts vt nr (CSel v path))) vs)
convertArg opts (Sort _)      nr path = do
  (args,_) <- get
  let PFCat cat _ schema = args !! nr
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
convertRec opts _ ctype _ = bug ("convertRec: "++show ctype)

convertTbl opts CNil (Table _ vt) pt ts = do
  vs <- getAllParamValues pt
  mkTable pt (zipWith (\v t -> (v,convertTerm opts CNil vt t)) vs ts)
convertTbl opts (CSel v sub_sel) ctype pt ts = do
  vs <- getAllParamValues pt
  case lookup v (zip vs ts) of
    Just t  -> convertTerm opts sub_sel ctype t
    Nothing -> ppbug (text "convertTbl:" <+> (text "missing value" <+> ppTerm Unqualified 0 v $$
                                                      text "among" <+> vcat (map (ppTerm Unqualified 0) vs)))
convertTbl opts _ ctype _ _ = bug ("convertTbl: "++show ctype)


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


----------------------------------------------------------------------
-- SeqSet

type SeqSet   = Map.Map Sequence SeqId

addSequencesB :: SeqSet -> Branch (Value [Symbol]) -> (SeqSet, Branch (Value SeqId))
addSequencesB seqs (Case nr path bs) = let !(seqs1,bs1) = mapAccumL' (\seqs (trm,b) -> let !(seqs',b') = addSequencesB seqs b
                                                                                       in (seqs',(trm,b'))) seqs bs
                                       in (seqs1,Case nr path bs1)
addSequencesB seqs (Variant bs)      = let !(seqs1,bs1) = mapAccumL' addSequencesB seqs bs
                                       in (seqs1,Variant bs1)
addSequencesB seqs (Return  v)       = let !(seqs1,v1) = addSequencesV seqs v
                                       in (seqs1,Return v1)

addSequencesV :: SeqSet -> Value [Symbol] -> (SeqSet, Value SeqId)
addSequencesV seqs (CRec vs)  = let !(seqs1,vs1) = mapAccumL' (\seqs (lbl,b) -> let !(seqs',b') = addSequencesB seqs b
                                                                                in (seqs',(lbl,b'))) seqs vs
                                in (seqs1,CRec vs1)
addSequencesV seqs (CTbl pt vs)=let !(seqs1,vs1) = mapAccumL' (\seqs (trm,b) -> let !(seqs',b') = addSequencesB seqs b
                                                                                in (seqs',(trm,b'))) seqs vs
                                in (seqs1,CTbl pt vs1)
addSequencesV seqs (CStr lin) = let !(seqs1,seqid) = addSequence seqs (optimizeLin lin)
                                in (seqs1,CStr seqid)
addSequencesV seqs (CPar i)   = (seqs,CPar i)

-- a strict version of Data.List.mapAccumL
mapAccumL' f s []     = (s,[])
mapAccumL' f s (x:xs) = (s'',y:ys)
                        where !(s', y ) = f s x
                              !(s'',ys) = mapAccumL' f s' xs

optimizeLin [] = []
optimizeLin lin@(SymKS _ : _) = 
  let (ts,lin') = getRest lin
  in SymKS ts : optimizeLin lin'
  where
    getRest (SymKS ts : lin) = let (ts1,lin') = getRest lin
                               in (ts++ts1,lin')
    getRest             lin  = ([],lin)
optimizeLin (sym : lin) = sym : optimizeLin lin

addSequence :: SeqSet -> [Symbol] -> (SeqSet,SeqId)
addSequence seqs lst =
  case Map.lookup seq seqs of
    Just id -> (seqs,id)
    Nothing -> let !last_seq = Map.size seqs
               in (Map.insert seq last_seq seqs, last_seq)
  where
    seq = mkArray lst


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
                                                       Nothing -> ppbug $ text "evalTerm: missing value:"<+>ppTerm Unqualified 0 trm $$ text "among:"<+>fsep (map (ppTerm Unqualified 10) vs)
                               CNil             -> do ts <- mapM (evalTerm path) ts
                                                      return (V pt ts)
evalTerm path (S term sel) = do v <- evalTerm CNil sel
                                evalTerm (CSel v path) term
evalTerm path (FV terms)   = variants terms >>= evalTerm path
evalTerm path (EInt n)     = return (EInt n)
evalTerm path t            = ppbug (text "evalTerm" <+> parens (ppTerm Unqualified 0 t))
--evalTerm path t            = ppbug (text "evalTerm" <+> sep [parens (text (show path)),parens (text (show t))])

getVarIndex (IA _ i) = i
getVarIndex (IAV _ _ i) = i
getVarIndex (IC s) | isDigit (BS.last s) = (read . BS.unpack . snd . BS.spanEnd isDigit) s
getVarIndex x = bug ("getVarIndex "++show x)

----------------------------------------------------------------------
-- GrammarEnv

data PMCFGEnv = PMCFGEnv !ProdSet !FunSet
type ProdSet  = Set.Set Production
type FunSet   = Map.Map (UArray LIndex SeqId) FunId

emptyPMCFGEnv =
  PMCFGEnv Set.empty Map.empty

addFunction :: PMCFGEnv -> FId -> UArray LIndex SeqId -> [[FId]] -> PMCFGEnv
addFunction (PMCFGEnv prodSet funSet) !fid fun args =
  case Map.lookup fun funSet of
    Just !funid -> PMCFGEnv (Set.insert (Production fid funid args) prodSet)
                            funSet
    Nothing     -> let !funid = Map.size funSet
                   in PMCFGEnv (Set.insert (Production fid funid args) prodSet)
                               (Map.insert fun funid funSet)

getPMCFG :: PMCFGEnv -> PMCFG
getPMCFG (PMCFGEnv prodSet funSet) =
  PMCFG (optimize prodSet) (mkSetArray funSet)
  where
    optimize ps = Map.foldWithKey ff [] (Map.fromListWith (++) [((fid,funid),[args]) | (Production fid funid args) <- Set.toList ps])
      where
        ff :: (FId,FunId) -> [[[FId]]] -> [Production] -> [Production]
        ff (fid,funid) xs prods
          | product (map IntSet.size ys) == count
                      = (Production fid funid (map IntSet.toList ys)) : prods
          | otherwise = map (Production fid funid) xs ++ prods
          where
            count = sum (map (product . map length) xs)
            ys    = foldl (zipWith (foldr IntSet.insert)) (repeat IntSet.empty) xs

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
restrictProtoFCat path v (PFCat cat f schema) = do
  schema <- addConstraint path v schema
  return (PFCat cat f schema)
  where
    addConstraint (CProj lbl path) v (CRec rs)     = fmap CRec      $ update lbl (addConstraint path v) rs
    addConstraint (CSel  trm path) v (CTbl pt cs)  = fmap (CTbl pt) $ update trm (addConstraint path v) cs
    addConstraint CNil             v (CPar (m,vs)) = case lookup v vs of
                                                       Just index -> return (CPar (m,[(v,index)]))
                                                       Nothing    -> mzero
    addConstraint CNil             v (CStr _)      = bug "restrictProtoFCat: string path"
    
    update k0 f [] = return []
    update k0 f (x@(k,Identity v):xs)
      | k0 == k    = do v <- f v
                        return ((k,Identity v):xs)
      | otherwise  = do xs <- update k0 f xs
                        return (x:xs)

mkArray    lst = listArray (0,length lst-1) lst
mkSetArray map = array (0,Map.size map-1) [(v,k) | (k,v) <- Map.toList map]

bug msg = ppbug (text msg)
ppbug = error . render . hang (text "Internal error in GeneratePMCFG:") 4
