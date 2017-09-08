{-# LANGUAGE ImplicitParams, RankNTypes #-}

module PGF2.Internal(-- * Access the internal structures
                     FId,isPredefFId,
                     FunId,Token,Production(..),PArg(..),Symbol(..),Literal(..),
                     concrTotalCats, concrCategories, concrProductions,
                     concrTotalFuns, concrFunction,
                     concrTotalSeqs, concrSequence,
                     
                     -- * Building new PGFs in memory
                     withBuilder, eAbs, eApp, eMeta, eFun, eVar, eTyped, eImplArg, dTyp, hypo
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
data PArg = PArg [FId] {-# UNPACK #-} !FId deriving (Eq,Ord,Show)
type FunId = Int
type SeqId = Int
data Literal =
   LStr String                      -- ^ a string constant
 | LInt Int                         -- ^ an integer constant
 | LFlt Double                      -- ^ a floating point constant
 deriving (Eq,Ord,Show)


-----------------------------------------------------------------------
-- Access the internal structures
-----------------------------------------------------------------------

concrTotalCats :: Concr -> FId
concrTotalCats c = unsafePerformIO $ do
  c_total_cats <- (#peek PgfConcr, total_cats) (concr c)
  touchConcr c
  return (fromIntegral (c_total_cats :: CInt))

concrCategories :: Concr -> [(CId,FId,FId,[String])]
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
          return (PArg hypos fid)

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

peekSequence peekElem size ptr = do
  c_len <- (#peek GuSeq, len) ptr
  peekElems (c_len :: CSizeT) (ptr `plusPtr` (#offset GuSeq, data))
  where
     peekElems 0   ptr = return []
     peekElems len ptr = do
       e  <- peekElem ptr
       es <- peekElems (len-1) (ptr `plusPtr` size)
       return (e:es)

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

withBuilder :: (forall s . (?builder :: Builder s) => B s a) -> a
withBuilder f =
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
                            (#const gu_flex_alignof(PgfExprMeta))
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

hypo :: BindType -> CId -> B s Type -> (B s Hypo)
hypo bind_type var (B ty) = B (bind_type,var,ty)

dTyp :: (?builder :: Builder s) => [B s Hypo] -> Cat -> [B s Expr] -> B s Type
dTyp hypos cat es =
  unsafePerformIO $ do
    ptr <- gu_malloc_aligned pool 
                             ((#size PgfType)+n_exprs*(#size GuVariant))
                             (#const gu_flex_alignof(PgfType))
    c_hypos <- gu_make_seq (#size PgfHypo) (fromIntegral (length hypos)) pool
    pokeHypos (c_hypos `plusPtr` (#offset GuSeq, data)) hypos
    c_cat <- newUtf8CString cat pool
    (#poke PgfType, hypos)   ptr c_hypos
    (#poke PgfType, cid)     ptr c_cat
    (#poke PgfType, n_exprs) ptr n_exprs
    pokeArray (ptr `plusPtr` (#offset PgfType, exprs)) [e | B (Expr e _) <- es]
    return (B (Type ptr touch))
  where
    (Builder pool touch) = ?builder
    n_exprs = fromIntegral (length es) :: CSizeT

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

newPGF :: (?builder :: Builder s) => Map.Map String Literal ->
                                     AbsName ->
                                     Map.Map String Literal ->
                                     Map.Map Cat ([Hypo],Float) ->
                                     Map.Map Fun (Type,Float) ->
                                     Map.Map ConcName () -> 
                                     B s PGF
newPGF gflags absname aflags cats funs concrs =
  unsafePerformIO $ do
    ptr <- gu_malloc_aligned pool
                             (#size PgfPGF)
                             (#const gu_alignof(PgfPGF))
    c_gflags <- newFlags gflags pool
    c_absname <- newUtf8CString absname pool
    c_aflags <- newFlags aflags pool
    c_concrs <- gu_make_seq (#size PgfConcr) (fromIntegral (Map.size concrs)) pool
    pokeConcrs (c_concrs `plusPtr` (#offset GuSeq, data)) (Map.toList concrs)
    (#poke PgfPGF, major_version)   ptr (2 :: (#type uint16_t))
    (#poke PgfPGF, minor_version)   ptr (0 :: (#type uint16_t))
    (#poke PgfPGF, gflags)          ptr c_gflags
    (#poke PgfPGF, abstract.name)   ptr c_absname
    (#poke PgfPGF, abstract.aflags) ptr c_aflags
    (#poke PgfPGF, concretes)       ptr c_concrs
    (#poke PgfPGF, pool)            ptr pool
    return (B (PGF ptr touch))
  where
    (Builder pool touch) = ?builder

    pokeConcrs ptr []                    = return ()
    pokeConcrs ptr ((name,concr):concrs) = do
      initConcr ptr name concr pool
      pokeConcrs (ptr `plusPtr` (#size PgfConcr)) concrs

newFlags :: Map.Map String Literal -> Ptr GuPool -> IO (Ptr GuSeq)
newFlags flags pool = do
  c_flags <- gu_make_seq (#size PgfFlag) (fromIntegral (Map.size flags)) pool
  pokeFlags (c_flags `plusPtr` (#offset GuSeq, data)) (Map.toList flags)
  return c_flags
  where
    pokeFlags c_flag []                   = return ()
    pokeFlags c_flag ((name,value):flags) = do
      c_name  <- newUtf8CString name pool
      c_value <- newLiteral value pool
      (#poke PgfFlag, name)  c_flag c_name
      (#poke PgfFlag, value) c_flag c_value
      pokeFlags (c_flag `plusPtr` (#size PgfFlag)) flags

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
                            (#const gu_flex_alignof(PgfLiteralInt))
                            pptr pool
    (#poke PgfLiteralInt, val) ptr (fromIntegral val :: CInt)
    peek pptr
newLiteral (LFlt val) pool =
  alloca $ \pptr -> do
    ptr <- gu_alloc_variant (#const PGF_LITERAL_FLT)
                            (fromIntegral (#size PgfLiteralFlt))
                            (#const gu_flex_alignof(PgfLiteralFlt))
                            pptr pool
    (#poke PgfLiteralFlt, val) ptr (realToFrac val :: CDouble)
    peek pptr

initConcr :: Ptr PgfConcr -> ConcName -> () -> Ptr GuPool -> IO ()
initConcr ptr name c pool = do
  return ()

newSymbol :: Symbol -> Ptr GuPool -> IO GuVariant
newSymbol pool = undefined
