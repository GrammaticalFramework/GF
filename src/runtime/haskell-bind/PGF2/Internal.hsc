{-# LANGUAGE ImplicitParams, RankNTypes #-}

module PGF2.Internal(-- * Access the internal structures
                     FId,isPredefFId,
                     FunId,SeqId,Token,Production(..),PArg(..),Symbol(..),Literal(..),
                     globalFlags, abstrFlags, concrFlags,
                     concrTotalCats, concrCategories, concrProductions,
                     concrTotalFuns, concrFunction,
                     concrTotalSeqs, concrSequence,

                     -- * Byte code
                     CodeLabel, Instr(..), IVal(..), TailInfo(..),

                     -- * Building new PGFs in memory
                     build, Builder, B,
                     eAbs, eApp, eMeta, eFun, eVar, eLit, eTyped, eImplArg, dTyp, hypo,
                     AbstrInfo, newAbstr, ConcrInfo, newConcr, newPGF,
                     
                     -- * Write an in-memory PGF to a file
                     unionPGF, writePGF, writeConcr,
                     
                     -- * Predefined concrete categories
                     fidString, fidInt, fidFloat, fidVar, fidStart
                    ) where

#include <pgf/data.h>

import PGF2
import PGF2.FFI
import PGF2.Expr
import PGF2.Type
import System.IO.Unsafe(unsafePerformIO)
import Foreign
import Foreign.C
import Data.IORef
import Data.Maybe(fromMaybe)
import Data.List(sortBy)
import Control.Exception(Exception,throwIO)
import Control.Monad(foldM,when)
import qualified Data.Map as Map

type Token = String
data Symbol
  = SymCat {-# UNPACK #-} !Int {-# UNPACK #-} !LIndex
  | SymLit {-# UNPACK #-} !Int {-# UNPACK #-} !LIndex
  | SymVar {-# UNPACK #-} !Int {-# UNPACK #-} !Int
  | SymKS Token
  | SymKP [Symbol] [([Symbol],[String])]
  | SymBIND                         -- the special BIND token
  | SymNE                           -- non exist
  | SymSOFT_BIND                    -- the special SOFT_BIND token
  | SymSOFT_SPACE                   -- the special SOFT_SPACE token
  | SymCAPIT                        -- the special CAPIT token
  | SymALL_CAPIT                    -- the special ALL_CAPIT token
  deriving (Eq,Ord,Show)
data Production
  = PApply  {-# UNPACK #-} !FunId [PArg]
  | PCoerce {-# UNPACK #-} !FId
  deriving (Eq,Ord,Show)
data PArg = PArg [(FId,FId)] {-# UNPACK #-} !FId deriving (Eq,Ord,Show)
type FunId = Int
type SeqId = Int
data Literal =
   LStr String                      -- ^ a string constant
 | LInt Int                         -- ^ an integer constant
 | LFlt Double                      -- ^ a floating point constant
 deriving (Eq,Ord,Show)

type CodeLabel = Int

data Instr
  = CHECK_ARGS {-# UNPACK #-} !Int
  | CASE Fun  {-# UNPACK #-} !CodeLabel
  | CASE_LIT Literal  {-# UNPACK #-} !CodeLabel
  | SAVE {-# UNPACK #-} !Int
  | ALLOC  {-# UNPACK #-} !Int
  | PUT_CONSTR Fun
  | PUT_CLOSURE   {-# UNPACK #-} !CodeLabel
  | PUT_LIT Literal
  | SET IVal
  | SET_PAD
  | PUSH_FRAME
  | PUSH IVal
  | TUCK IVal {-# UNPACK #-} !Int
  | EVAL IVal TailInfo
  | DROP {-# UNPACK #-} !Int
  | JUMP {-# UNPACK #-} !CodeLabel
  | FAIL
  | PUSH_ACCUM Literal
  | POP_ACCUM
  | ADD

data IVal
  = HEAP     {-# UNPACK #-} !Int
  | ARG_VAR  {-# UNPACK #-} !Int
  | FREE_VAR {-# UNPACK #-} !Int
  | GLOBAL   Fun
  deriving Eq

data TailInfo
  = RecCall
  | TailCall {-# UNPACK #-} !Int
  | UpdateCall


-----------------------------------------------------------------------
-- Access the internal structures
-----------------------------------------------------------------------

globalFlags :: PGF -> [(String,Literal)]
globalFlags p = unsafePerformIO $ do
  c_flags <- (#peek PgfPGF, gflags) (pgf p)
  flags   <- peekFlags c_flags
  touchPGF p
  return flags

abstrFlags :: PGF -> [(String,Literal)]
abstrFlags p = unsafePerformIO $ do
  c_flags <- (#peek PgfPGF, abstract.aflags) (pgf p)
  flags   <- peekFlags c_flags
  touchPGF p
  return flags

concrFlags :: Concr -> [(String,Literal)]
concrFlags c = unsafePerformIO $ do
  c_flags <- (#peek PgfConcr, cflags) (concr c)
  flags   <- peekFlags c_flags
  touchConcr c
  return flags

peekFlags :: Ptr GuSeq -> IO [(String,Literal)]
peekFlags c_flags = do
  c_len <- (#peek GuSeq, len) c_flags
  peekFlags (c_len :: CInt) (c_flags `plusPtr` (#offset GuSeq, data))
  where
    peekFlags 0     ptr = return []
    peekFlags c_len ptr = do
      name  <- (#peek PgfFlag, name)  ptr >>= peekUtf8CString
      value <- (#peek PgfFlag, value) ptr >>= peekLiteral
      flags <- peekFlags (c_len-1) (ptr `plusPtr` (#size PgfFlag))
      return ((name,value):flags)

peekLiteral :: GuVariant -> IO Literal
peekLiteral p = do
  tag <- gu_variant_tag  p
  ptr <- gu_variant_data p
  case tag of
    (#const PGF_LITERAL_STR) -> do { val <- peekUtf8CString (ptr `plusPtr` (#offset PgfLiteralStr, val));
                                     return (LStr val) }
    (#const PGF_LITERAL_INT) -> do { val <- peek (ptr `plusPtr` (#offset PgfLiteralInt, val));
                                     return (LInt (fromIntegral (val :: CInt))) }
    (#const PGF_LITERAL_FLT) -> do { val <- peek (ptr `plusPtr` (#offset PgfLiteralFlt, val));
                                     return (LFlt (realToFrac (val :: CDouble))) }
    _                        -> error "Unknown literal type in the grammar"

concrTotalCats :: Concr -> FId
concrTotalCats c = unsafePerformIO $ do
  c_total_cats <- (#peek PgfConcr, total_cats) (concr c)
  touchConcr c
  return (fromIntegral (c_total_cats :: CInt))

concrCategories :: Concr -> [(Cat,FId,FId,[String])]
concrCategories c = 
  unsafePerformIO $
    withGuPool $ \tmpPl ->
    allocaBytes (#size GuMapItor) $ \itor -> do
      exn <- gu_new_exn tmpPl
      ref <- newIORef []
      fptr <- wrapMapItorCallback (getCategories ref)
      (#poke GuMapItor, fn) itor fptr
      c_cnccats <- (#peek PgfConcr, cnccats) (concr c)
      gu_map_iter c_cnccats itor exn
      touchConcr c
      freeHaskellFunPtr fptr
      cs <- readIORef ref
      return (reverse cs)
  where
    getCategories ref itor key value exn = do
      names <- readIORef ref
      name  <- peekUtf8CString (castPtr key)
      c_cnccat <- peek (castPtr value)
      c_cats <- (#peek PgfCncCat, cats) c_cnccat
      c_len <- (#peek GuSeq, len) c_cats
      first <- peek (c_cats `plusPtr` (#offset GuSeq, data)) >>= peekFId
      last  <- peek (c_cats `plusPtr` ((#offset GuSeq, data) + (fromIntegral (c_len-1::CSizeT))*(#size PgfCCat*))) >>= peekFId
      c_n_lins <- (#peek PgfCncCat, n_lins) c_cnccat
      arr <- peekArray (fromIntegral (c_n_lins :: CSizeT)) (c_cnccat `plusPtr` (#offset PgfCncCat, labels))
      labels <- mapM peekUtf8CString arr
      writeIORef ref ((name,first,last,labels) : names)

concrProductions :: Concr -> FId -> [Production]
concrProductions c fid = unsafePerformIO $ do
  c_ccats <- (#peek PgfConcr, ccats) (concr c)
  res <- alloca $ \pfid -> do
           poke pfid (fromIntegral fid :: CInt)
           gu_map_find_default c_ccats pfid >>= peek
  if res == nullPtr
    then do touchConcr c
            return []
    else do c_prods <- (#peek PgfCCat, prods) res
            if c_prods == nullPtr
              then do touchConcr c
                      return []
              else do res <- peekSequence (deRef peekProduction) (#size GuVariant) c_prods
                      touchConcr c
                      return res
  where
    peekProduction p = do
      tag <- gu_variant_tag  p
      dt  <- gu_variant_data p
      case tag of
        (#const PGF_PRODUCTION_APPLY) -> do { c_cncfun <- (#peek PgfProductionApply, fun) dt ;
                                              c_funid  <- (#peek PgfCncFun, funid) c_cncfun ;
                                              c_args   <- (#peek PgfProductionApply, args) dt ;
                                              pargs <- peekSequence peekPArg (#size PgfPArg) c_args ;
                                              return (PApply (fromIntegral (c_funid :: CInt)) pargs) }
        (#const PGF_PRODUCTION_COERCE)-> do { c_coerce <- (#peek PgfProductionCoerce, coerce) dt ;
                                              fid <- peekFId c_coerce ;
                                              return (PCoerce fid) }
        _                             -> error "Unknown production type in the grammar"
      where
        peekPArg ptr = do
          c_hypos <- (#peek PgfPArg, hypos) ptr
          hypos <- peekSequence (deRef peekFId) (#size int) c_hypos
          c_ccat <- (#peek PgfPArg, ccat) ptr
          fid  <- peekFId c_ccat
          return (PArg [(fid,fid) | fid <- hypos] fid)

peekFId c_ccat = do
  c_fid <- (#peek PgfCCat, fid) c_ccat
  return (fromIntegral (c_fid :: CInt))

concrTotalFuns :: Concr -> FunId
concrTotalFuns c = unsafePerformIO $ do
  c_cncfuns <- (#peek PgfConcr, cncfuns) (concr c)
  c_len <- (#peek GuSeq, len) c_cncfuns
  touchConcr c
  return (fromIntegral (c_len :: CSizeT))

concrFunction :: Concr -> FunId -> (Fun,[SeqId])
concrFunction c funid = unsafePerformIO $ do
  c_cncfuns <- (#peek PgfConcr, cncfuns) (concr c)
  c_len <- (#peek GuSeq, len) c_cncfuns
  when (funid >= fromIntegral (c_len :: CSizeT)) $
    throwIO (PGFError ("Invalid concrete function: F"++show funid))
  c_cncfun <- peek (c_cncfuns `plusPtr` ((#offset GuSeq, data)+funid*(#size PgfCncFun*)))
  c_absfun <- (#peek PgfCncFun, absfun) c_cncfun
  c_name <- (#peek PgfAbsFun, name) c_absfun
  name <- peekUtf8CString c_name
  c_n_lins <- (#peek PgfCncFun, n_lins) c_cncfun
  arr <- peekArray (fromIntegral (c_n_lins :: CSizeT)) (c_cncfun `plusPtr` (#offset PgfCncFun, lins))
  seqs_seq <- (#peek PgfConcr, sequences) (concr c)
  touchConcr c
  let seqs = seqs_seq `plusPtr` (#offset GuSeq, data)
  return (name, map (toSeqId seqs) arr)
  where
    toSeqId seqs seq = minusPtr seq seqs `div` (#size PgfSequence)

concrTotalSeqs :: Concr -> SeqId
concrTotalSeqs c = unsafePerformIO $ do
  seq <- (#peek PgfConcr, sequences) (concr c)
  c_len <- (#peek GuSeq, len) seq
  touchConcr c
  return (fromIntegral (c_len :: CSizeT))

concrSequence :: Concr -> SeqId -> [Symbol]
concrSequence c seqid = unsafePerformIO $ do
  c_sequences <- (#peek PgfConcr, sequences) (concr c)
  c_len <- (#peek GuSeq, len) c_sequences
  when (seqid >= fromIntegral (c_len :: CSizeT)) $
    throwIO (PGFError ("Invalid concrete sequence: S"++show seqid))
  let c_sequence = c_sequences `plusPtr` ((#offset GuSeq, data)+seqid*(#size PgfSequence))
  c_syms <- (#peek PgfSequence, syms) c_sequence
  res <- peekSequence (deRef peekSymbol) (#size GuVariant) c_syms
  touchConcr c
  return res
  where
    peekSymbol p = do
      tag <- gu_variant_tag  p
      dt  <- gu_variant_data p
      case tag of
        (#const PGF_SYMBOL_CAT)        -> peekSymbolIdx SymCat dt
        (#const PGF_SYMBOL_LIT)        -> peekSymbolIdx SymLit dt
        (#const PGF_SYMBOL_VAR)        -> peekSymbolIdx SymVar dt
        (#const PGF_SYMBOL_KS)         -> peekSymbolKS dt
        (#const PGF_SYMBOL_KP)         -> peekSymbolKP dt
        (#const PGF_SYMBOL_BIND)       -> return SymBIND
        (#const PGF_SYMBOL_SOFT_BIND)  -> return SymSOFT_BIND
        (#const PGF_SYMBOL_NE)         -> return SymNE
        (#const PGF_SYMBOL_SOFT_SPACE) -> return SymSOFT_SPACE
        (#const PGF_SYMBOL_CAPIT)      -> return SymCAPIT
        (#const PGF_SYMBOL_ALL_CAPIT)  -> return SymALL_CAPIT
        _                              -> error "Unknown symbol type in the grammar"

    peekSymbolIdx constr dt = do
      c_d <- (#peek PgfSymbolIdx, d) dt
      c_r <- (#peek PgfSymbolIdx, r) dt
      return (constr (fromIntegral (c_d :: CInt)) (fromIntegral (c_r :: CInt)))

    peekSymbolKS dt = do
      token <- peekUtf8CString (dt `plusPtr` (#offset PgfSymbolKS, token))
      return (SymKS token)

    peekSymbolKP dt = do
      c_default_form <- (#peek PgfSymbolKP, default_form) dt
      default_form <- peekSequence (deRef peekSymbol) (#size GuVariant) c_default_form
      c_n_forms <- (#peek PgfSymbolKP, n_forms) dt
      forms <- peekForms (c_n_forms :: CSizeT) (dt `plusPtr` (#offset PgfSymbolKP, forms))
      return (SymKP default_form forms)

    peekForms 0   ptr = return []
    peekForms len ptr = do
      c_form <- (#peek PgfAlternative, form) ptr
      form <- peekSequence (deRef peekSymbol) (#size GuVariant) c_form
      c_prefixes <- (#peek PgfAlternative, prefixes) ptr
      prefixes <- peekSequence (deRef peekUtf8CString) (#size GuString*) c_prefixes
      forms <- peekForms (len-1) (ptr `plusPtr` (#size PgfAlternative))
      return ((form,prefixes):forms)

deRef peekValue ptr = peek ptr >>= peekValue

fidString, fidInt, fidFloat, fidVar, fidStart :: FId
fidString = (-1)
fidInt    = (-2)
fidFloat  = (-3)
fidVar    = (-4)
fidStart  = (-5)

isPredefFId :: FId -> Bool
isPredefFId = (`elem` [fidString, fidInt, fidFloat, fidVar])


-----------------------------------------------------------------------
-- Building new PGFs in memory
-----------------------------------------------------------------------

data Builder s = Builder (Ptr GuPool) Touch
newtype B s a = B a

instance Functor (B s) where
  fmap f (B x) = B (f x)

build :: (forall s . (?builder :: Builder s) => B s a) -> a
build f =
  unsafePerformIO $ do
    pool <- gu_new_pool
    poolFPtr <- newForeignPtr gu_pool_finalizer pool
    let ?builder = Builder pool (touchForeignPtr poolFPtr)
    let B res = f
    return res

eAbs :: (?builder :: Builder s) => BindType -> String -> B s Expr -> B s Expr
eAbs bind_type var (B (Expr body _)) =
  unsafePerformIO $
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_EXPR_ABS)
                            (#size PgfExprAbs)
                            (#const gu_alignof(PgfExprAbs))
                            pptr pool
    cvar <- newUtf8CString var pool
    (#poke PgfExprAbs, bind_type) ptr (cbind_type :: PgfBindType)
    (#poke PgfExprAbs, id) ptr cvar
    (#poke PgfExprAbs, body) ptr body
    e <- peek pptr
    return (B (Expr e touch))
  where
    (Builder pool touch) = ?builder

    cbind_type =
      case bind_type of
        Explicit -> (#const PGF_BIND_TYPE_EXPLICIT)
        Implicit -> (#const PGF_BIND_TYPE_IMPLICIT)

eApp :: (?builder :: Builder s) => B s Expr -> B s Expr -> B s Expr
eApp (B (Expr fun _)) (B (Expr arg _)) =
  unsafePerformIO $
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_EXPR_APP)
                            (#size PgfExprApp)
                            (#const gu_alignof(PgfExprApp))
                            pptr pool
    (#poke PgfExprApp, fun) ptr fun
    (#poke PgfExprApp, arg) ptr arg
    e <- peek pptr
    return (B (Expr e touch))
  where
    (Builder pool touch) = ?builder

eMeta :: (?builder :: Builder s) => Int -> B s Expr
eMeta id =
  unsafePerformIO $
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_EXPR_META)
                            (fromIntegral (#size PgfExprMeta))
                            (#const gu_alignof(PgfExprMeta))
                            pptr pool
    (#poke PgfExprMeta, id) ptr (fromIntegral id :: CInt)
    e <- peek pptr
    return (B (Expr e touch))
  where
    (Builder pool touch) = ?builder

eFun :: (?builder :: Builder s) => Fun -> B s Expr
eFun fun =
  unsafePerformIO $
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_EXPR_FUN)
                            (fromIntegral ((#size PgfExprFun)+utf8Length fun))
                            (#const gu_flex_alignof(PgfExprFun))
                            pptr pool
    pokeUtf8CString fun (ptr `plusPtr` (#offset PgfExprFun, fun))
    e <- peek pptr
    return (B (Expr e touch))
  where
    (Builder pool touch) = ?builder

eVar :: (?builder :: Builder s) => Int -> B s Expr
eVar var =
  unsafePerformIO $
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_EXPR_VAR)
                            (#size PgfExprVar)
                            (#const gu_alignof(PgfExprVar))
                            pptr pool
    (#poke PgfExprVar, var) ptr (fromIntegral var :: CInt)
    e <- peek pptr
    return (B (Expr e touch))
  where
    (Builder pool touch) = ?builder

eLit :: (?builder :: Builder s) => Literal -> B s Expr
eLit value =
  unsafePerformIO $
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_EXPR_LIT)
                            (fromIntegral (#size PgfExprLit))
                            (#const gu_alignof(PgfExprLit))
                            pptr pool
    c_value <- newLiteral value pool
    (#poke PgfExprLit, lit) ptr c_value
    e <- peek pptr
    return (B (Expr e touch))
  where
    (Builder pool touch) = ?builder

eTyped :: (?builder :: Builder s) => B s Expr -> B s Type -> B s Expr
eTyped (B (Expr e _)) (B (Type ty _)) =
  unsafePerformIO $
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_EXPR_TYPED)
                            (#size PgfExprTyped)
                            (#const gu_alignof(PgfExprTyped))
                            pptr pool
    (#poke PgfExprTyped, expr) ptr e
    (#poke PgfExprTyped, type) ptr ty
    e <- peek pptr
    return (B (Expr e touch))
  where
    (Builder pool touch) = ?builder

eImplArg :: (?builder :: Builder s) => B s Expr -> B s Expr
eImplArg (B (Expr e _)) =
  unsafePerformIO $
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_EXPR_IMPL_ARG)
                            (#size PgfExprImplArg)
                            (#const gu_alignof(PgfExprImplArg))
                            pptr pool
    (#poke PgfExprImplArg, expr) ptr e
    e <- peek pptr
    return (B (Expr e touch))
  where
    (Builder pool touch) = ?builder

hypo :: BindType -> String -> B s Type -> (B s Hypo)
hypo bind_type var (B ty) = B (bind_type,var,ty)

dTyp :: (?builder :: Builder s) => [B s Hypo] -> Cat -> [B s Expr] -> B s Type
dTyp hypos cat es =
  unsafePerformIO $ do
    ptr <- gu_malloc_aligned pool 
                             ((#size PgfType)+n_exprs*(#size GuVariant))
                             (#const gu_flex_alignof(PgfType))
    c_hypos <- newHypos hypos pool
    c_cat <- newUtf8CString cat pool
    (#poke PgfType, hypos)   ptr c_hypos
    (#poke PgfType, cid)     ptr c_cat
    (#poke PgfType, n_exprs) ptr n_exprs
    pokeArray (ptr `plusPtr` (#offset PgfType, exprs)) [e | B (Expr e _) <- es]
    return (B (Type ptr touch))
  where
    (Builder pool touch) = ?builder
    n_exprs = fromIntegral (length es) :: CSizeT

newHypos :: [B s Hypo] -> Ptr GuPool -> IO (Ptr GuSeq)
newHypos hypos pool = do
  c_hypos <- gu_make_seq (#size PgfHypo) (fromIntegral (length hypos)) pool
  pokeHypos (c_hypos `plusPtr` (#offset GuSeq, data)) hypos
  return c_hypos
  where
    pokeHypos ptr []                                  = return ()
    pokeHypos ptr (B (bind_type,var,Type ty _):hypos) = do
      c_var <- newUtf8CString var pool
      (#poke PgfHypo, bind_type) ptr (cbind_type :: PgfBindType)
      (#poke PgfHypo, cid)       ptr c_var
      (#poke PgfHypo, type)      ptr ty
      pokeHypos (ptr `plusPtr` (#size PgfHypo)) hypos
      where
        cbind_type =
          case bind_type of
            Explicit -> (#const PGF_BIND_TYPE_EXPLICIT)
            Implicit -> (#const PGF_BIND_TYPE_IMPLICIT)


data AbstrInfo = AbstrInfo (Ptr GuSeq) (Ptr GuSeq) (Map.Map String (Ptr PgfAbsCat)) (Ptr GuSeq) (Map.Map String (Ptr PgfAbsFun)) (Ptr PgfAbsFun) (Ptr GuBuf) Touch

newAbstr :: (?builder :: Builder s) => [(String,Literal)] ->
                                       [(Cat,[B s Hypo],Float)] ->
                                       [(Fun,B s Type,Int,Float)] ->
                                       B s AbstrInfo
newAbstr aflags cats funs = unsafePerformIO $ do
  c_aflags <- newFlags aflags pool
  (c_cats,abscats) <- newAbsCats (sortByFst3 cats) pool
  (c_funs,absfuns) <- newAbsFuns (sortByFst4 funs) pool
  c_abs_lin_fun <- newAbsLinFun
  c_non_lexical_buf <- gu_make_buf (#size PgfProductionIdxEntry) pool
  return (B (AbstrInfo c_aflags c_cats abscats c_funs absfuns c_abs_lin_fun c_non_lexical_buf touch))
  where
    (Builder pool touch) = ?builder

    newAbsCats values pool = do
      c_seq <- gu_make_seq (#size PgfAbsCat) (fromIntegral (length values)) pool
      abscats <- pokeElems (c_seq `plusPtr` (#offset GuSeq, data)) Map.empty values
      return (c_seq,abscats)
      where
        pokeElems ptr abscats []     = return abscats
        pokeElems ptr abscats (x:xs) = do
          abscats <- pokeAbsCat ptr abscats x
          pokeElems (ptr `plusPtr` (#size PgfAbsCat)) abscats xs

    pokeAbsCat ptr abscats (name,hypos,prob) = do
      c_name  <- newUtf8CString name pool
      c_hypos <- newHypos hypos pool
      (#poke PgfAbsCat, name) ptr c_name
      (#poke PgfAbsCat, context) ptr c_hypos
      (#poke PgfAbsCat, prob) ptr (realToFrac prob :: CFloat)
      return (Map.insert name ptr abscats)

    newAbsFuns values pool = do
      c_seq <- gu_make_seq (#size PgfAbsFun) (fromIntegral (length values)) pool
      absfuns <- pokeElems (c_seq `plusPtr` (#offset GuSeq, data)) Map.empty values
      return (c_seq,absfuns)
      where
        pokeElems ptr absfuns []     = return absfuns
        pokeElems ptr absfuns (x:xs) = do
          absfuns <- pokeAbsFun ptr absfuns x
          pokeElems (ptr `plusPtr` (#size PgfAbsFun)) absfuns xs

    pokeAbsFun ptr absfuns (name,B (Type c_ty _),arity,prob) = do
      pfun <- gu_alloc_variant (#const PGF_EXPR_FUN)
                               (fromIntegral ((#size PgfExprFun)+utf8Length name))
                               (#const gu_flex_alignof(PgfExprFun))
                               (ptr `plusPtr` (#offset PgfAbsFun, ep.expr)) pool
      let c_name = (pfun `plusPtr` (#offset PgfExprFun, fun))
      pokeUtf8CString name c_name
      (#poke PgfAbsFun, name) ptr c_name
      (#poke PgfAbsFun, type) ptr c_ty
      (#poke PgfAbsFun, arity) ptr (fromIntegral arity :: CInt)
      (#poke PgfAbsFun, defns) ptr nullPtr
      (#poke PgfAbsFun, ep.prob) ptr (realToFrac prob :: CFloat)
      return (Map.insert name ptr absfuns)

    newAbsLinFun = do
      ptr <- gu_malloc_aligned pool
                               (#size PgfAbsFun)
                               (#const gu_alignof(PgfAbsFun))
      c_wild <- newUtf8CString "_" pool
      c_ty   <- gu_malloc_aligned pool
                                  (#size PgfType)
                                  (#const gu_alignof(PgfType))
      (#poke PgfType, hypos)   c_ty nullPtr
      (#poke PgfType, cid)     c_ty c_wild
      (#poke PgfType, n_exprs) c_ty (0 :: CSizeT)
      (#poke PgfAbsFun, name)    ptr c_wild
      (#poke PgfAbsFun, type)    ptr c_ty
      (#poke PgfAbsFun, arity)   ptr (0 :: CSizeT)
      (#poke PgfAbsFun, defns)   ptr nullPtr
      (#poke PgfAbsFun, ep.prob) ptr (- log 0 :: CFloat)
      (#poke PgfAbsFun, ep.expr) ptr nullPtr
      return ptr


data ConcrInfo = ConcrInfo (Ptr GuSeq) (Ptr GuMap) (Ptr GuMap) (Ptr GuSeq) (Ptr GuSeq) (Ptr GuMap) (Ptr PgfConcr -> Ptr GuPool -> IO ()) CInt

newConcr :: (?builder :: Builder s) => B s AbstrInfo ->
                                       [(String,Literal)] ->       -- ^ Concrete syntax flags
                                       [(String,String)] ->        -- ^ Printnames
                                       [(FId,[FunId])] ->          -- ^ Lindefs
                                       [(FId,[FunId])] ->          -- ^ Linrefs
                                       [(FId,[Production])] ->     -- ^ Productions
                                       [(Fun,[SeqId])] ->          -- ^ Concrete functions   (must be sorted by Fun)
                                       [[Symbol]] ->               -- ^ Sequences            (must be sorted)
                                       [(Cat,FId,FId,[String])] -> -- ^ Concrete categories
                                       FId ->                      -- ^ The total count of the categories
                                       B s ConcrInfo
newConcr (B (AbstrInfo _ _ abscats  _ absfuns c_abs_lin_fun c_non_lexical_buf _)) cflags printnames lindefs linrefs prods cncfuns sequences cnccats total_cats = unsafePerformIO $ do
  c_cflags <- newFlags cflags pool
  c_printname <- newMap (#size GuString) gu_string_hasher newUtf8CString 
                        (#size GuString) (pokeString pool)
                        printnames pool
  c_seqs <- newSequence (#size PgfSequence) pokeSequence sequences pool
  let seqs_ptr = c_seqs `plusPtr` (#offset GuSeq, data)
  c_cncfuns <- newSequence (#size PgfCncFun*) (pokeCncFun seqs_ptr) (zip [0..] cncfuns) pool
  let funs_ptr = c_cncfuns `plusPtr` (#offset GuSeq, data)
  c_ccats <- gu_make_map (#size int) gu_int_hasher
                         (#size PgfCCat*) gu_null_struct
                         (#const GU_MAP_DEFAULT_INIT_SIZE)
                         pool
  mapM_ (addLindefs c_ccats funs_ptr) lindefs
  mapM_ (addLinrefs c_ccats funs_ptr) linrefs
  mk_index <- foldM (addProductions c_ccats funs_ptr c_non_lexical_buf) (\concr pool -> return ()) prods
  c_cnccats <- newMap (#size GuString) gu_string_hasher newUtf8CString (#size PgfCncCat*) (pokeCncCat c_ccats) (map (\v@(k,_,_,_) -> (k,v)) cnccats) pool
  return (B (ConcrInfo c_cflags c_printname c_ccats c_cncfuns c_seqs c_cnccats mk_index (fromIntegral total_cats)))
  where
    (Builder pool touch) = ?builder

    pokeCncFun seqs_ptr ptr cncfun@(funid,_) = do
      c_cncfun <- newCncFun absfuns seqs_ptr cncfun pool
      poke ptr c_cncfun

    pokeSequence c_seq syms = do
      c_syms <- newSymbols syms pool
      (#poke PgfSequence, syms) c_seq c_syms
      (#poke PgfSequence, idx)  c_seq nullPtr

    addLindefs c_ccats funs_ptr (fid,funids) = do
      c_ccat <- getCCat c_ccats fid pool
      c_funs <- newSequence (#size PgfCncFun*) (pokeRefDefFunId funs_ptr) funids pool
      (#poke PgfCCat, lindefs) c_ccat c_funs

    addLinrefs c_ccats funs_ptr (fid,funids) = do
      c_ccat <- getCCat c_ccats fid pool
      c_funs <- newSequence (#size PgfCncFun*) (pokeRefDefFunId funs_ptr) funids pool
      (#poke PgfCCat, linrefs) c_ccat c_funs

    addProductions c_ccats funs_ptr c_non_lexical_buf mk_index (fid,prods) = do
      c_ccat <- getCCat c_ccats fid pool
      let n_prods = length prods
      c_prods <- gu_make_seq (#size PgfProduction) (fromIntegral n_prods) pool
      (#poke PgfCCat, prods) c_ccat c_prods
      pokeProductions c_ccat (c_prods `plusPtr` (#offset GuSeq, data)) 0 (n_prods-1) mk_index prods
      where
        pokeProductions c_ccat ptr top bot mk_index []           = do
          (#poke PgfCCat, n_synprods) c_ccat (fromIntegral top :: CSizeT)
          return mk_index
        pokeProductions c_ccat ptr top bot mk_index (prod:prods) = do
          (is_lexical,c_prod) <- newProduction c_ccats funs_ptr c_non_lexical_buf prod pool
          let mk_index' = \concr pool -> do pgf_parser_index concr c_ccat c_prod is_lexical pool
                                            pgf_lzr_index    concr c_ccat c_prod is_lexical pool
                                            mk_index concr pool
          if is_lexical == 0
            then do poke (ptr `plusPtr` ((#size PgfProduction)*top)) c_prod
                    pokeProductions c_ccat ptr (top+1) bot mk_index' prods
            else do poke (ptr `plusPtr` ((#size PgfProduction)*bot)) c_prod
                    pokeProductions c_ccat ptr top (bot-1) mk_index' prods

    pokeRefDefFunId funs_ptr ptr funid = do
      c_fun <- peek (funs_ptr `plusPtr` (funid * (#size PgfCncFun*)))
      (#poke PgfCncFun, absfun) c_fun c_abs_lin_fun
      poke ptr c_fun

    pokeCncCat c_ccats ptr (name,start,end,labels) = do
      let n_lins = fromIntegral (length labels) :: CSizeT
      c_cnccat <- gu_malloc_aligned pool
                                    ((#size PgfCncCat)+n_lins*(#size GuString))
                                    (#const gu_flex_alignof(PgfCncCat))
      case Map.lookup name abscats of
        Just c_abscat -> (#poke PgfCncCat, abscat) c_cnccat c_abscat
        Nothing       -> throwIO (PGFError ("The category "++name++" is not in the abstract syntax"))
      c_ccats <- newSequence (#size PgfCCat*) (pokeFId c_cnccat) [start..end] pool
      (#poke PgfCncCat, cats) c_cnccat c_ccats
      (#poke PgfCncCat, n_lins) c_cnccat n_lins
      pokeLabels (c_cnccat `plusPtr` (#offset PgfCncCat, labels)) labels
      poke ptr c_cnccat
      where
        pokeFId c_cnccat ptr fid = do
          c_ccat <- getCCat c_ccats fid pool
          (#poke PgfCCat, cnccat) c_ccat c_cnccat
          poke ptr c_ccat

        pokeLabels ptr []     = return []
        pokeLabels ptr (l:ls) = do
          c_l <- newUtf8CString l pool
          poke ptr c_l
          pokeLabels (ptr `plusPtr` (#size GuString)) ls


newPGF :: (?builder :: Builder s) => [(String,Literal)] ->
                                     AbsName ->
                                     B s AbstrInfo ->
                                     [(ConcName,B s ConcrInfo)] ->
                                     B s PGF
newPGF gflags absname (B (AbstrInfo c_aflags c_cats _ c_funs _ c_abs_lin_fun _ _)) concrs =
  unsafePerformIO $ do
    ptr <- gu_malloc_aligned pool
                             (#size PgfPGF)
                             (#const gu_alignof(PgfPGF))
    c_gflags  <- newFlags gflags pool
    c_absname <- newUtf8CString absname pool
    let c_abstr = ptr `plusPtr` (#offset PgfPGF, abstract)
    c_concrs <- gu_make_seq (#size PgfConcr) (fromIntegral (length concrs)) pool
    langs <- pokeConcrs c_abstr (c_concrs `plusPtr` (#offset GuSeq, data)) Map.empty concrs
    (#poke PgfPGF, major_version)   ptr (2 :: (#type uint16_t))
    (#poke PgfPGF, minor_version)   ptr (0 :: (#type uint16_t))
    (#poke PgfPGF, gflags)          ptr c_gflags
    (#poke PgfPGF, abstract.name)   ptr c_absname
    (#poke PgfPGF, abstract.aflags) ptr c_aflags
    (#poke PgfPGF, abstract.funs)   ptr c_funs
    (#poke PgfPGF, abstract.cats)   ptr c_cats
    (#poke PgfPGF, abstract.abs_lin_fun) ptr c_abs_lin_fun
    (#poke PgfPGF, concretes)       ptr c_concrs
    (#poke PgfPGF, pool)            ptr pool
    return (B (PGF ptr langs touch))
  where
    (Builder pool touch) = ?builder

    pokeConcrs c_abstr ptr langs []                  = return langs
    pokeConcrs c_abstr ptr langs ((name, B info):xs) = do
      pokeConcr c_abstr ptr name info
      pokeConcrs c_abstr (ptr `plusPtr` (fromIntegral (#size PgfConcr)))
                         (Map.insert name (Concr ptr touch) langs)
                         xs

    pokeConcr c_abstr ptr name (ConcrInfo c_cflags c_printnames c_ccats c_cncfuns c_seqs c_cnccats mk_index c_total_cats) = do
      c_name <- newUtf8CString name pool
      c_fun_indices <- gu_make_map (#size GuString) gu_string_hasher
                                   (#size PgfCncOverloadMap*) gu_null_struct
                                   (#const GU_MAP_DEFAULT_INIT_SIZE)
                                   pool
      c_coerce_idx  <- gu_make_map (#size PgfCCat*) gu_addr_hasher
                                   (#size GuBuf*) gu_null_struct
                                   (#const GU_MAP_DEFAULT_INIT_SIZE)
                                   pool
      (#poke PgfConcr, name)        ptr c_name
      (#poke PgfConcr, abstr)       ptr c_abstr
      (#poke PgfConcr, cflags)      ptr c_cflags
      (#poke PgfConcr, printnames)  ptr c_printnames
      (#poke PgfConcr, ccats)       ptr c_ccats
      (#poke PgfConcr, fun_indices) ptr c_fun_indices
      (#poke PgfConcr, coerce_idx)  ptr c_coerce_idx
      (#poke PgfConcr, cncfuns)     ptr c_cncfuns
      (#poke PgfConcr, sequences)   ptr c_seqs
      (#poke PgfConcr, cnccats)     ptr c_cnccats
      (#poke PgfConcr, total_cats)  ptr c_total_cats
      (#poke PgfConcr, pool)        ptr nullPtr

      mk_index ptr pool
      pgf_concrete_fix_internals ptr


newFlags :: [(String,Literal)] -> Ptr GuPool -> IO (Ptr GuSeq)
newFlags flags pool = newSequence (#size PgfFlag) pokeFlag (sortByFst flags) pool
  where
    pokeFlag c_flag (name,value) = do
      c_name  <- newUtf8CString name pool
      c_value <- newLiteral value pool
      (#poke PgfFlag, name)  c_flag c_name
      (#poke PgfFlag, value) c_flag c_value


newLiteral :: Literal -> Ptr GuPool -> IO GuVariant
newLiteral (LStr val) pool =
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_LITERAL_STR)
                            (fromIntegral ((#size PgfLiteralStr)+utf8Length val))
                            (#const gu_flex_alignof(PgfLiteralStr))
                            pptr pool
    pokeUtf8CString val (ptr `plusPtr` (#offset PgfLiteralStr, val))
    peek pptr
newLiteral (LInt val) pool =
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_LITERAL_INT)
                            (fromIntegral (#size PgfLiteralInt))
                            (#const gu_alignof(PgfLiteralInt))
                            pptr pool
    (#poke PgfLiteralInt, val) ptr (fromIntegral val :: CInt)
    peek pptr
newLiteral (LFlt val) pool =
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_LITERAL_FLT)
                            (fromIntegral (#size PgfLiteralFlt))
                            (#const gu_alignof(PgfLiteralFlt))
                            pptr pool
    (#poke PgfLiteralFlt, val) ptr (realToFrac val :: CDouble)
    peek pptr


newProduction :: Ptr GuMap -> Ptr PgfCncFun -> Ptr GuBuf -> Production -> Ptr GuPool -> IO ((#type bool), GuVariant)
newProduction c_ccats funs_ptr c_non_lexical_buf (PApply funid args) pool =
  alloca $ \pptr -> do
    c_fun <- peek (funs_ptr `plusPtr` (funid * (#size PgfCncFun*)))
    c_args <- newSequence (#size PgfPArg) pokePArg args pool
    ptr <- gu_alloc_variant (#const PGF_PRODUCTION_APPLY)
                            (fromIntegral (#size PgfProductionApply))
                            (#const gu_alignof(PgfProductionApply))
                            pptr pool
    (#poke PgfProductionApply, fun)  ptr (c_fun :: Ptr PgfCncFun)
    (#poke PgfProductionApply, args) ptr c_args
    is_lexical <- pgf_production_is_lexical ptr c_non_lexical_buf pool
    c_prod <- peek pptr
    return (is_lexical,c_prod)
  where
    pokePArg ptr (PArg hypos ccat) = do
      c_ccat <- getCCat c_ccats ccat pool
      (#poke PgfPArg, ccat) ptr c_ccat
      c_hypos <- newSequence (#size PgfCCat*) pokeCCat (map snd hypos) pool
      (#poke PgfPArg, hypos) ptr c_hypos

    pokeCCat ptr ccat = do
      c_ccat <- getCCat c_ccats ccat pool
      poke ptr c_ccat

newProduction c_ccats funs_ptr c_non_lexical_buf (PCoerce fid) pool =
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_PRODUCTION_COERCE)
                            (fromIntegral (#size PgfProductionCoerce))
                            (#const gu_alignof(PgfProductionCoerce))
                            pptr pool
    c_ccat <- getCCat c_ccats fid pool
    (#poke PgfProductionCoerce, coerce) ptr c_ccat
    c_prod <- peek pptr
    return (0,c_prod)


newCncFun absfuns seqs_ptr (funid,(fun,seqids)) pool =
  do let c_absfun = fromMaybe nullPtr (Map.lookup fun absfuns)
         c_ep     = if c_absfun == nullPtr
                      then nullPtr
                      else c_absfun `plusPtr` (#offset PgfAbsFun, ep)
         n_lins   = fromIntegral (length seqids) :: CSizeT
     ptr <- gu_malloc_aligned pool
                              ((#size PgfCncFun)+n_lins*(#size PgfSequence*))
                              (#const gu_flex_alignof(PgfCncFun))
     (#poke PgfCncFun, absfun) ptr c_absfun
     (#poke PgfCncFun, ep)     ptr c_ep
     (#poke PgfCncFun, funid)  ptr (funid :: CInt)
     (#poke PgfCncFun, n_lins) ptr n_lins
     pokeSequences seqs_ptr (ptr `plusPtr` (#offset PgfCncFun, lins)) seqids
     return ptr
  where
    pokeSequences seqs_ptr ptr []             = return ()
    pokeSequences seqs_ptr ptr (seqid:seqids) = do
      poke ptr (seqs_ptr `plusPtr` (seqid * (#size PgfSequence)))
      pokeSequences seqs_ptr (ptr `plusPtr` (#size PgfSequence*)) seqids

getCCat c_ccats fid pool =
  alloca $ \pfid -> do
    poke pfid (fromIntegral fid :: CInt)
    ptr <- gu_map_find_default c_ccats pfid
    c_ccat <- peek ptr
    if c_ccat /= nullPtr
      then return c_ccat
      else do c_ccat <- gu_malloc_aligned pool
                                          (#size PgfCCat)
                                          (#const gu_alignof(PgfCCat))
              (#poke PgfCCat, cnccat) c_ccat nullPtr
              (#poke PgfCCat, lindefs) c_ccat nullPtr
              (#poke PgfCCat, linrefs) c_ccat nullPtr
              (#poke PgfCCat, n_synprods) c_ccat (0 :: CSizeT)
              (#poke PgfCCat, prods) c_ccat nullPtr
              (#poke PgfCCat, viterbi_prob) c_ccat (0 :: CFloat)
              (#poke PgfCCat, fid) c_ccat fid
              (#poke PgfCCat, conts) c_ccat nullPtr
              (#poke PgfCCat, answers) c_ccat nullPtr
              ptr <- gu_map_insert c_ccats pfid
              poke ptr c_ccat
              return c_ccat

newSymbol :: Symbol -> Ptr GuPool -> IO GuVariant
newSymbol (SymCat d r)     pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_CAT)
                                                            (fromIntegral (#size PgfSymbolCat))
                                                            (#const gu_alignof(PgfSymbolCat))
                                                            pptr pool
                                    (#poke PgfSymbolCat, d) ptr (fromIntegral d :: CInt)
                                    (#poke PgfSymbolCat, r) ptr (fromIntegral r :: CInt)
                                    peek pptr
newSymbol (SymLit d r)     pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_LIT)
                                                            (fromIntegral (#size PgfSymbolLit))
                                                            (#const gu_alignof(PgfSymbolLit))
                                                            pptr pool
                                    (#poke PgfSymbolLit, d) ptr (fromIntegral d :: CInt)
                                    (#poke PgfSymbolLit, r) ptr (fromIntegral r :: CInt)
                                    peek pptr
newSymbol (SymVar d r)     pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_VAR)
                                                            (fromIntegral (#size PgfSymbolVar))
                                                            (#const gu_alignof(PgfSymbolVar))
                                                            pptr pool
                                    (#poke PgfSymbolVar, d) ptr (fromIntegral d :: CInt)
                                    (#poke PgfSymbolVar, r) ptr (fromIntegral r :: CInt)
                                    peek pptr
newSymbol (SymKS t)        pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_KS)
                                                            (fromIntegral ((#size PgfSymbolKS)+utf8Length t))
                                                            (#const gu_flex_alignof(PgfSymbolKS))
                                                            pptr pool
                                    pokeUtf8CString t (ptr `plusPtr` (#offset PgfSymbolKS, token))
                                    peek pptr
newSymbol (SymKP def alts) pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_KP)
                                                            (fromIntegral ((#size PgfSymbolKP)+(length alts * (#size PgfAlternative))))
                                                            (#const gu_flex_alignof(PgfSymbolKP))
                                                            pptr pool
                                    c_def <- newSymbols def pool
                                    (#poke PgfSymbolKP, default_form) ptr c_def
                                    pokeAlternatives (ptr `plusPtr` (#offset PgfSymbolKP, forms)) alts pool
                                    peek pptr
newSymbol SymBIND          pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_BIND)
                                                            (fromIntegral (#size PgfSymbolBIND))
                                                            (#const gu_alignof(PgfSymbolBIND))
                                                            pptr pool
                                    peek pptr
newSymbol SymNE            pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_NE)
                                                            (fromIntegral (#size PgfSymbolNE))
                                                            (#const gu_alignof(PgfSymbolNE))
                                                            pptr pool
                                    peek pptr
newSymbol SymSOFT_BIND     pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_SOFT_BIND)
                                                            (fromIntegral (#size PgfSymbolBIND))
                                                            (#const gu_alignof(PgfSymbolBIND))
                                                            pptr pool
                                    peek pptr
newSymbol SymSOFT_SPACE    pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_SOFT_SPACE)
                                                            (fromIntegral (#size PgfSymbolBIND))
                                                            (#const gu_alignof(PgfSymbolBIND))
                                                            pptr pool
                                    peek pptr
newSymbol SymCAPIT         pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_CAPIT)
                                                            (fromIntegral (#size PgfSymbolCAPIT))
                                                            (#const gu_alignof(PgfSymbolCAPIT))
                                                            pptr pool
                                    peek pptr
newSymbol SymALL_CAPIT     pool = alloca $ \pptr -> do
                                    ptr <- gu_alloc_variant (#const PGF_SYMBOL_ALL_CAPIT)
                                                            (fromIntegral (#size PgfSymbolCAPIT))
                                                            (#const gu_alignof(PgfSymbolCAPIT))
                                                            pptr pool
                                    peek pptr

newSymbols syms pool = newSequence (#size PgfSymbol) pokeSymbol syms pool
  where
    pokeSymbol p_sym sym = do
      c_sym <- newSymbol sym pool
      poke p_sym c_sym

pokeAlternatives ptr []                     pool = return ()
pokeAlternatives ptr ((syms,prefixes):alts) pool = do
  c_syms     <- newSymbols syms pool
  c_prefixes <- newSequence (#size GuString) (pokeString pool) prefixes pool
  (#poke PgfAlternative, form)     ptr c_syms
  (#poke PgfAlternative, prefixes) ptr c_prefixes
  pokeAlternatives (ptr `plusPtr` (#size PgfAlternative)) alts pool

pokeString pool c_elem str = do
  c_str <- newUtf8CString str pool
  poke c_elem c_str

newMap key_size hasher newKey elem_size pokeElem values pool = do
  map <- gu_make_map key_size hasher
                     elem_size gu_null_struct
                     (#const GU_MAP_DEFAULT_INIT_SIZE)
                     pool
  insert map values pool
  return map
  where
    insert map []                  pool = return ()
    insert map ((key,elem):values) pool = do
      c_key  <- newKey key pool
      c_elem <- gu_map_insert map c_key
      pokeElem c_elem elem
      insert map values pool


unionPGF :: PGF -> PGF -> Maybe PGF
unionPGF one@(PGF ptr1 langs1 touch1) two@(PGF ptr2 langs2 touch2)
  | pgf_have_same_abstract ptr1 ptr2 /= 0 = Just (PGF ptr1 (Map.union langs1 langs2) (touch1 >> touch2))
  | otherwise                             = Nothing

writePGF :: FilePath -> PGF -> IO ()
writePGF fpath p = do
  pool <- gu_new_pool
  exn <- gu_new_exn pool
  withArrayLen ((map concr . Map.elems . languages) p) $ \n_concrs concrs ->
   withCString fpath $ \c_fpath ->
     pgf_write (pgf p) (fromIntegral n_concrs) concrs c_fpath exn
  touchPGF p
  failed <- gu_exn_is_raised exn
  if failed
    then do is_errno <- gu_exn_caught exn gu_exn_type_GuErrno
            if is_errno
              then do perrno <- (#peek GuExn, data.data) exn
                      errno  <- peek perrno
                      gu_pool_free pool
                      ioError (errnoToIOError "writePGF" (Errno errno) Nothing (Just fpath))
              else do gu_pool_free pool
                      throwIO (PGFError "The grammar cannot be stored")
    else do gu_pool_free pool
            return ()

writeConcr :: FilePath -> Concr -> IO ()
writeConcr fpath c = do
  pool <- gu_new_pool
  exn <- gu_new_exn pool
  withCString fpath $ \c_fpath ->
    pgf_concrete_save (concr c) c_fpath exn
  touchConcr c
  failed <- gu_exn_is_raised exn
  if failed
    then do is_errno <- gu_exn_caught exn gu_exn_type_GuErrno
            if is_errno
              then do perrno <- (#peek GuExn, data.data) exn
                      errno  <- peek perrno
                      gu_pool_free pool
                      ioError (errnoToIOError "writeConcr" (Errno errno) Nothing (Just fpath))
              else do gu_pool_free pool
                      throwIO (PGFError "The grammar cannot be stored")
    else do gu_pool_free pool
            return ()

sortByFst  = sortBy (\(x,_)     (y,_)     -> compare x y)
sortByFst3 = sortBy (\(x,_,_)   (y,_,_)   -> compare x y)
sortByFst4 = sortBy (\(x,_,_,_) (y,_,_,_) -> compare x y)
