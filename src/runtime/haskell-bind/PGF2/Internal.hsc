module PGF2.Internal(FId,isPredefFId,
                     FunId,Token,Production(..),PArg(..),Symbol(..),
                     concrTotalCats, concrCategories, concrProductions,
                     concrTotalFuns, concrFunction,
                     concrTotalSeqs, concrSequence) where

#include <pgf/data.h>

import PGF2
import PGF2.FFI
import System.IO.Unsafe(unsafePerformIO)
import Foreign
import Foreign.C
import Data.IORef

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
      last  <- peek (c_cats `plusPtr` ((#offset GuSeq, data) + (fromIntegral (c_len-1::CInt))*(#size PgfCCat*))) >>= peekFId
      c_n_lins <- (#peek PgfCncCat, n_lins) c_cnccat
      arr <- peekArray (fromIntegral (c_n_lins :: CInt)) (c_cnccat `plusPtr` (#offset PgfCncCat, labels))
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
  return (fromIntegral (c_len :: CInt))

concrFunction :: Concr -> FunId -> (Fun,[SeqId])
concrFunction c funid = unsafePerformIO $ do
  c_cncfuns <- (#peek PgfConcr, cncfuns) (concr c)
  c_cncfun <- peek (c_cncfuns `plusPtr` ((#offset GuSeq, data)+funid*(#size PgfCncFun*)))
  c_absfun <- (#peek PgfCncFun, absfun) c_cncfun
  c_name <- (#peek PgfAbsFun, name) c_absfun
  name <- peekUtf8CString c_name
  c_n_lins <- (#peek PgfCncFun, n_lins) c_cncfun
  arr <- peekArray (fromIntegral (c_n_lins :: CInt)) (c_cncfun `plusPtr` (#offset PgfCncFun, lins))
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
  return (fromIntegral (c_len :: CInt))

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
      forms <- peekForms (c_n_forms :: CInt) (dt `plusPtr` (#offset PgfSymbolKP, forms))
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
  peekElems (c_len :: CInt) (ptr `plusPtr` (#offset GuSeq, data))
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
