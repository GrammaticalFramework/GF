{-# LANGUAGE ExistentialQuantification, DeriveDataTypeable, ScopedTypeVariables #-}
-------------------------------------------------
-- |
-- Module      : PGF2
-- Maintainer  : Krasimir Angelov
-- Stability   : stable
-- Portability : portable
--
-- This module is an Application Programming Interface to
-- load and interpret grammars compiled in the Portable Grammar Format (PGF).
-- The PGF format is produced as the final output from the GF compiler.
-- The API is meant to be used for embedding GF grammars in Haskell
-- programs
-------------------------------------------------

#include <pgf/pgf.h>
#include <pgf/linearizer.h>
#include <gu/enum.h>
#include <gu/exn.h>

module PGF2 (-- * PGF
             PGF,readPGF,showPGF,

             -- * Abstract syntax
             AbsName,abstractName,
             -- ** Categories
             Cat,categories,categoryContext,categoryProbability,
             -- ** Functions
             Fun, functions, functionsByCat,
             functionType, functionIsDataCon, hasLinearization,
             -- ** Expressions
             Expr,showExpr,readExpr,pExpr,pIdent,
             mkAbs,unAbs,
             mkApp,unApp,unapply,
             mkStr,unStr,
             mkInt,unInt,
             mkFloat,unFloat,
             mkMeta,unMeta,
             exprHash, exprSize, exprFunctions, exprSubstitute,
             treeProbability,

             -- ** Types
             Type, Hypo, BindType(..), startCat,
             readType, showType, showContext,
             mkType, unType,

             -- ** Type checking
             checkExpr, inferExpr, checkType,

             -- ** Computing
             compute,

             -- * Concrete syntax
             ConcName,Concr,languages,concreteName,languageCode,

             -- ** Linearization
             linearize,linearizeAll,tabularLinearize,tabularLinearizeAll,bracketedLinearize,
             FId, LIndex, BracketedString(..), showBracketedString, flattenBracketedString,
             printName,

             alignWords,
             -- ** Parsing
             ParseOutput(..), parse, parseWithHeuristics, complete,
             -- ** Sentence Lookup
             lookupSentence,
             -- ** Generation
             generateAll,
             -- ** Morphological Analysis
             MorphoAnalysis, lookupMorpho, fullFormLexicon,
             -- ** Visualizations
             GraphvizOptions(..), graphvizDefaults,
             graphvizAbstractTree, graphvizParseTree,
             graphvizDependencyTree, conlls2latexDoc, getCncDepLabels,
             graphvizWordAlignment,

             -- * Exceptions
             PGFError(..),

             -- * Grammar specific callbacks
             LiteralCallback,literalCallbacks
            ) where

import Prelude hiding (fromEnum)
import Control.Exception(Exception,throwIO)
import Control.Monad(forM_)
import System.IO.Unsafe(unsafePerformIO,unsafeInterleaveIO)
import Text.PrettyPrint
import PGF2.Expr
import PGF2.Type
import PGF2.FFI

import Foreign hiding ( Pool, newPool, unsafePerformIO )
import Foreign.C
import Data.Typeable
import qualified Data.Map as Map
import Data.IORef
import Data.Char(isUpper,isSpace)
import Data.List(isSuffixOf,maximumBy,nub,mapAccumL,intersperse,groupBy,find)
import Data.Maybe(fromMaybe)
import Data.Function(on)

 
-----------------------------------------------------------------------
-- Functions that take a PGF.
-- PGF has many Concrs.
--
-- A Concr retains its PGF in a field in order to retain a reference to
-- the foreign pointer in case if the application still has a reference
-- to Concr but has lost its reference to PGF.


type AbsName  = String -- ^ Name of abstract syntax
type ConcName = String -- ^ Name of concrete syntax

-- | Reads file in Portable Grammar Format and produces
-- 'PGF' structure. The file is usually produced with:
--
-- > $ gf -make <grammar file name>
readPGF :: FilePath -> IO PGF
readPGF fpath =
  do pool <- gu_new_pool
     pgf  <- withCString fpath $ \c_fpath ->
               withGuPool $ \tmpPl -> do
                 exn <- gu_new_exn tmpPl
                 pgf <- pgf_read c_fpath pool exn
                 failed <- gu_exn_is_raised exn
                 if failed
                   then do is_errno <- gu_exn_caught exn gu_exn_type_GuErrno
                           if is_errno
                             then do perrno <- (#peek GuExn, data.data) exn
                                     errno  <- peek perrno
                                     gu_pool_free pool
                                     ioError (errnoToIOError "readPGF" (Errno errno) Nothing (Just fpath))
                             else do gu_pool_free pool
                                     throwIO (PGFError "The grammar cannot be loaded")
                   else return pgf
     pgfFPtr <- newForeignPtr gu_pool_finalizer pool
     let touch = touchForeignPtr pgfFPtr
     ref <- newIORef Map.empty
     allocaBytes (#size GuMapItor) $ \itor ->
        do fptr <- wrapMapItorCallback (getLanguages ref touch)
           (#poke GuMapItor, fn) itor fptr
           pgf_iter_languages pgf itor nullPtr
           freeHaskellFunPtr fptr
     langs <- readIORef ref
     return (PGF pgf langs touch)
  where
    getLanguages :: IORef (Map.Map String Concr) -> Touch -> MapItorCallback
    getLanguages ref touch itor key value exn = do
      langs <- readIORef ref
      name  <- peekUtf8CString (castPtr key)
      concr <- fmap (\ptr -> Concr ptr touch) $ peek (castPtr value)
      writeIORef ref $! Map.insert name concr langs

showPGF :: PGF -> String
showPGF p =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do (sb,out) <- newOut tmpPl
         exn <- gu_new_exn tmpPl
         withArrayLen ((map concr . Map.elems . languages) p) $ \n_concrs concrs ->
           pgf_print (pgf p) (fromIntegral n_concrs) concrs out exn
         touchPGF p
         s <- gu_string_buf_freeze sb tmpPl
         peekUtf8CString s

-- | List of all languages available in the grammar.
languages :: PGF -> Map.Map ConcName Concr
languages p = langs p

-- | The abstract language name is the name of the top-level
-- abstract module
concreteName :: Concr -> ConcName
concreteName c = unsafePerformIO (peekUtf8CString =<< pgf_concrete_name (concr c))

languageCode :: Concr -> String
languageCode c = unsafePerformIO (peekUtf8CString =<< pgf_language_code (concr c))


-- | Generates an exhaustive possibly infinite list of
-- all abstract syntax expressions of the given type. 
-- The expressions are ordered by their probability.
generateAll :: PGF -> Type -> [(Expr,Float)]
generateAll p (Type ctype _) =
  unsafePerformIO $
    do genPl  <- gu_new_pool
       exprPl <- gu_new_pool
       exn    <- gu_new_exn genPl
       enum   <- pgf_generate_all (pgf p) ctype exn genPl exprPl
       genFPl  <- newForeignPtr gu_pool_finalizer genPl
       exprFPl <- newForeignPtr gu_pool_finalizer exprPl
       fromPgfExprEnum enum genFPl (touchPGF p >> touchForeignPtr exprFPl)

-- | The abstract language name is the name of the top-level
-- abstract module
abstractName :: PGF -> AbsName
abstractName p = unsafePerformIO (peekUtf8CString =<< pgf_abstract_name (pgf p))

-- | The start category is defined in the grammar with
-- the \'startcat\' flag. This is usually the sentence category
-- but it is not necessary. Despite that there is a start category
-- defined you can parse with any category. The start category
-- definition is just for convenience.
startCat :: PGF -> Type
startCat p = unsafePerformIO $ do
  typPl <- gu_new_pool
  c_type <- pgf_start_cat (pgf p) typPl
  typeFPl <- newForeignPtr gu_pool_finalizer typPl
  return (Type c_type (touchForeignPtr typeFPl))

loadConcr :: Concr -> FilePath -> IO ()
loadConcr c fpath =
  withCString fpath $ \c_fpath ->
  withCString "rb" $ \c_mode ->
  withGuPool $ \tmpPl -> do
    file <- fopen c_fpath c_mode
    inp <- gu_file_in file tmpPl
    exn <- gu_new_exn tmpPl
    pgf_concrete_load (concr c) inp exn
    failed <- gu_exn_is_raised exn
    if failed
      then do is_errno <- gu_exn_caught exn gu_exn_type_GuErrno
              if is_errno
                then do perrno <- (#peek GuExn, data.data) exn
                        errno  <- peek perrno
                        ioError (errnoToIOError "loadConcr" (Errno errno) Nothing (Just fpath))
                else do throwIO (PGFError "The language cannot be loaded")
      else return ()

unloadConcr :: Concr -> IO ()
unloadConcr c = pgf_concrete_unload (concr c)

-- | The type of a function
functionType :: PGF -> Fun -> Maybe Type
functionType p fn =
  unsafePerformIO $
  withGuPool $ \tmpPl -> do
    c_fn <- newUtf8CString fn tmpPl
    c_type <- pgf_function_type (pgf p) c_fn
    return (if c_type == nullPtr
              then Nothing
              else Just (Type c_type (touchPGF p)))

-- | The type of a function
functionIsDataCon :: PGF -> Fun -> Bool
functionIsDataCon p fn =
  unsafePerformIO $
  withGuPool $ \tmpPl -> do
    c_fn <- newUtf8CString fn tmpPl
    res <- pgf_function_is_constructor (pgf p) c_fn
    touchPGF p
    return (res /= 0)

-- | Checks an expression against a specified type.
checkExpr :: PGF -> Expr -> Type -> Either String Expr
checkExpr p (Expr c_expr touch1) (Type c_ty touch2) =
  unsafePerformIO $
  alloca $ \pexpr ->
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    exprPl <- gu_new_pool
    poke pexpr c_expr
    pgf_check_expr (pgf p) pexpr c_ty exn exprPl
    touchPGF p >> touch1 >> touch2
    status <- gu_exn_is_raised exn
    if not status
      then do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
              c_expr <- peek pexpr
              return (Right (Expr c_expr (touchForeignPtr exprFPl)))
      else do is_tyerr <- gu_exn_caught exn gu_exn_type_PgfTypeError
              c_msg <- (#peek GuExn, data.data) exn
              msg <- peekUtf8CString c_msg
              gu_pool_free exprPl
              if is_tyerr
                then return (Left msg)
                else throwIO (PGFError msg)

-- | Tries to infer the type of an expression. Note that
-- even if the expression is type correct it is not always
-- possible to infer its type in the GF type system.
-- In this case the function returns an error.
inferExpr :: PGF -> Expr -> Either String (Expr, Type)
inferExpr p (Expr c_expr touch1) =
  unsafePerformIO $
  alloca $ \pexpr ->
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    exprPl <- gu_new_pool
    poke pexpr c_expr
    c_ty <- pgf_infer_expr (pgf p) pexpr exn exprPl
    touchPGF p >> touch1
    status <- gu_exn_is_raised exn
    if not status
      then do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
              let touch = touchForeignPtr exprFPl
              c_expr <- peek pexpr
              return (Right (Expr c_expr touch, Type c_ty touch))
      else do is_tyerr <- gu_exn_caught exn gu_exn_type_PgfTypeError
              c_msg <- (#peek GuExn, data.data) exn
              msg <- peekUtf8CString c_msg
              gu_pool_free exprPl
              if is_tyerr
                then return (Left msg)
                else throwIO (PGFError msg)

-- | Check whether a type is consistent with the abstract
-- syntax of the grammar.
checkType :: PGF -> Type -> Either String Type
checkType p (Type c_ty touch1) =
  unsafePerformIO $
  alloca $ \pty ->
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    typePl <- gu_new_pool
    poke pty c_ty
    pgf_check_type (pgf p) pty exn typePl
    touchPGF p >> touch1
    status <- gu_exn_is_raised exn
    if not status
      then do typeFPl <- newForeignPtr gu_pool_finalizer typePl
              c_ty <- peek pty
              return (Right (Type c_ty (touchForeignPtr typeFPl)))
      else do is_tyerr <- gu_exn_caught exn gu_exn_type_PgfTypeError
              c_msg <- (#peek GuExn, data.data) exn
              msg <- peekUtf8CString c_msg
              gu_pool_free typePl
              if is_tyerr
                then return (Left msg)
                else throwIO (PGFError msg)

compute :: PGF -> Expr -> Expr
compute p (Expr c_expr touch1) =
  unsafePerformIO $
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    exprPl <- gu_new_pool
    c_expr <- pgf_compute (pgf p) c_expr exn tmpPl exprPl
    touchPGF p >> touch1
    status <- gu_exn_is_raised exn
    if not status
      then do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
              return (Expr c_expr (touchForeignPtr exprFPl))
      else do c_msg <- (#peek GuExn, data.data) exn
              msg <- peekUtf8CString c_msg
              gu_pool_free exprPl
              throwIO (PGFError msg)

treeProbability :: PGF -> Expr -> Float
treeProbability p (Expr c_expr touch1) =
  unsafePerformIO $ do
    res <- pgf_compute_tree_probability (pgf p) c_expr
    touchPGF p >> touch1
    return (realToFrac res)

exprHash :: Int32 -> Expr -> Int32
exprHash h (Expr c_expr touch1) =
  unsafePerformIO $ do
    h <- pgf_expr_hash (fromIntegral h) c_expr
    touch1
    return (fromIntegral h)

exprSize :: Expr -> Int
exprSize (Expr c_expr touch1) =
  unsafePerformIO $ do
    size <- pgf_expr_size c_expr
    touch1
    return (fromIntegral size)

exprFunctions :: Expr -> [Fun]
exprFunctions (Expr c_expr touch) =
  unsafePerformIO $
  withGuPool $ \tmpPl -> do
    seq <- pgf_expr_functions c_expr tmpPl
    len <- (#peek GuSeq, len) seq
    arr <- peekArray (fromIntegral (len :: CInt)) (seq `plusPtr` (#offset GuSeq, data))
    funs <- mapM peekUtf8CString arr
    touch
    return funs

exprSubstitute :: Expr -> [Expr] -> Expr
exprSubstitute (Expr c_expr touch) meta_values =
  unsafePerformIO $
  withGuPool $ \tmpPl -> do
    c_meta_values <- newSequence (#size PgfExpr) pokeExpr meta_values tmpPl
    exprPl <- gu_new_pool
    c_expr <- pgf_expr_substitute c_expr c_meta_values exprPl
    touch
    exprFPl <- newForeignPtr gu_pool_finalizer exprPl
    let touch' = sequence_ (touchForeignPtr exprFPl : map touchExpr meta_values)
    return (Expr c_expr touch')
  where
    pokeExpr ptr (Expr c_expr _) = poke ptr c_expr

-----------------------------------------------------------------------------
-- Graphviz

data GraphvizOptions = GraphvizOptions {noLeaves :: Bool,
                                        noFun :: Bool,
                                        noCat :: Bool,
                                        noDep :: Bool,
                                        nodeFont :: String,
                                        leafFont :: String,
                                        nodeColor :: String,
                                        leafColor :: String,
                                        nodeEdgeStyle :: String,
                                        leafEdgeStyle :: String
                                       }

graphvizDefaults = GraphvizOptions False False False True "" "" "" "" "" ""

-- | Renders an abstract syntax tree in a Graphviz format.
graphvizAbstractTree :: PGF -> GraphvizOptions -> Expr -> String
graphvizAbstractTree p opts e =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do (sb,out) <- newOut tmpPl
         exn <- gu_new_exn tmpPl
         c_opts <- newGraphvizOptions tmpPl opts
         pgf_graphviz_abstract_tree (pgf p) (expr e) c_opts out exn
         touchExpr e
         s <- gu_string_buf_freeze sb tmpPl
         peekUtf8CString s


graphvizParseTree :: Concr -> GraphvizOptions -> Expr -> String
graphvizParseTree c opts e =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do (sb,out) <- newOut tmpPl
         exn <- gu_new_exn tmpPl
         c_opts <- newGraphvizOptions tmpPl opts
         pgf_graphviz_parse_tree (concr c) (expr e) c_opts out exn
         touchExpr e
         s <- gu_string_buf_freeze sb tmpPl
         peekUtf8CString s

graphvizWordAlignment :: [Concr] -> GraphvizOptions -> Expr -> String
graphvizWordAlignment cs opts e =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
    withArrayLen (map concr cs) $ \n_concrs ptr ->
      do (sb,out) <- newOut tmpPl
         exn <- gu_new_exn tmpPl
         c_opts <- newGraphvizOptions tmpPl opts
         pgf_graphviz_word_alignment ptr (fromIntegral n_concrs) (expr e) c_opts out exn
         touchExpr e
         s <- gu_string_buf_freeze sb tmpPl
         peekUtf8CString s


type Labels = Map.Map Fun [String]

-- | Visualize word dependency tree.
graphvizDependencyTree
  :: String -- ^ Output format: @"latex"@, @"conll"@, @"malt_tab"@, @"malt_input"@ or @"dot"@
  -> Bool -- ^ Include extra information (debug)
  -> Maybe Labels -- ^ abstract label information obtained with 'getDepLabels'
  -> Maybe CncLabels -- ^ concrete label information obtained with ' ' (was: unused (was: @Maybe String@))
  -> Concr
  -> Expr
  -> String -- ^ Rendered output in the specified format
graphvizDependencyTree format debug mlab mclab concr t =
  case format of
    "latex"      -> render . ppLaTeX $ conll2latex' conll
    "svg"        -> render . ppSVG . toSVG $ conll2latex' conll
    "conll"      -> printCoNLL conll
    "malt_tab"   -> render $ vcat (map (hcat . intersperse (char '\t') . (\ws -> [ws !! 0,ws !! 1,ws !! 3,ws !! 6,ws !! 7])) wnodes)
    "malt_input" -> render $ vcat (map (hcat . intersperse (char '\t') . take 6) wnodes)
    _            -> render $ text "digraph {" $$
                    space $$
                    nest 2 (text "rankdir=LR ;" $$
                            text "node [shape = plaintext] ;" $$
                            vcat nodes $$
                            vcat links) $$
                    text "}"
  where
    conll  = maybe conll0 (\ls -> fixCoNLL ls conll0) mclab
    conll0 = (map.map) render wnodes
    nodes  = map mkNode leaves
    links  = map mkLink [(fid, fromMaybe (dep_lbl,nil) (lookup fid deps)) | ((cat,fid,fun),_,w) <- tail leaves]

-- CoNLL format: ID FORM LEMMA PLEMMA POS PPOS FEAT PFEAT HEAD PHEAD DEPREL PDEPREL
-- P variants are automatically predicted rather than gold standard

    wnodes = [[int i, maltws ws, text fun, text (posCat cat), text cat, unspec, int parent, text lab, unspec, unspec] |
              ((cat,fid,fun),i,ws) <- tail leaves,
              let (lab,parent) = fromMaybe (dep_lbl,0)
                                           (do (lbl,fid) <- lookup fid deps
                                               (_,i,_) <- find (\((_,fid1,_),i,_) -> fid == fid1) leaves
                                               return (lbl,i))
             ]
    maltws = text . concat . intersperse "+" . words  -- no spaces in column 2

    nil = -1

    bss = bracketedLinearize concr t

    root = ("_",nil,"_")

    leaves = (root,0,root_lbl) : (groupAndIndexIt 1 . concatMap (getLeaves root)) bss
    deps   = let (_,(h,deps)) = getDeps 0 [] t
             in (h,(dep_lbl,nil)):deps

    groupAndIndexIt id []          = []
    groupAndIndexIt id ((p,w):pws) = (p,id,w) : groupAndIndexIt (id+1) pws
---    groupAndIndexIt id ((p,w):pws) = let (ws,pws1) = collect pws
---                                     in (p,id,unwords (w:ws)) : groupAndIndexIt (id+1) pws1
      where
        collect pws@((p1,w):pws1)
          | p == p1   = let (ws,pws2) = collect pws1
                        in (w:ws,pws2)
        collect pws   = ([],pws)

    getLeaves parent bs =
      case bs of
        Leaf w                      -> [(parent,w)]
        Bracket cat fid _ fun bss -> concatMap (getLeaves (cat,fid,fun)) bss

    mkNode ((_,p,_),i,w) =
      tag p <+> brackets (text "label = " <> doubleQuotes (int i <> char '.' <+> text w)) <+> semi

    mkLink (x,(lbl,y)) = tag y <+> text "->" <+> tag x  <+> text "[label = " <> doubleQuotes (text lbl) <> text "] ;"

    labels  = maybe Map.empty id mlab
    clabels = maybe [] id mclab

    posCat cat = case Map.lookup cat labels of
        Just [p] -> p
        _        -> cat

    getDeps n_fid xs e =
      case unAbs e of
        Just (_, x, e) -> getDeps n_fid (x:xs) e
        Nothing        -> case unApp e of
                            Just (f,es) -> let (n_fid_1,ds) = descend n_fid xs es
                                               (mb_h, deps) = selectHead f ds
                                           in case mb_h of
                                                Just (fid,deps0) -> (n_fid_1+1,(fid,deps0++
                                                                                    [(n_fid_1,(dep_lbl,fid))]++
                                                                                    concat [(m,(lbl,fid)):ds | (lbl,(m,ds)) <- deps]))
                                                Nothing          -> (n_fid_1+1,(n_fid_1,concat [(m,(lbl,n_fid_1)):ds | (lbl,(m,ds)) <- deps]))
                            Nothing     -> (n_fid+1,(n_fid,[]))

    descend n_fid xs es = mapAccumL (\n_fid e -> getDeps n_fid xs e) n_fid es

    selectHead f ds =
      case Map.lookup f labels of
        Just lbls -> extractHead (zip lbls ds)
        Nothing   -> extractLast ds
      where
        extractHead []    = (Nothing, [])
        extractHead (ld@(l,d):lds)
          | l == head_lbl = (Just d,lds)
          | otherwise     = let (mb_h,deps) = extractHead lds
                            in (mb_h,ld:deps)

        extractLast []    = (Nothing, [])
        extractLast (d:ds)
          | null ds       = (Just d,[])
          | otherwise     = let (mb_h,deps) = extractLast ds
                            in (mb_h,(dep_lbl,d):deps)

    dep_lbl  = "dep"
    head_lbl = "head"
    root_lbl = "ROOT"
    unspec   = text "_"


---------------------- should be a separate module?

-- visualization with latex output. AR Nov 2015

conlls2latexDoc :: [String] -> String
conlls2latexDoc =
  render .
  latexDoc .
  vcat .
  intersperse (text "" $+$ app "vspace" (text "4mm")) .
  map conll2latex .
  filter (not . null)

conll2latex :: String -> Doc
conll2latex = ppLaTeX . conll2latex' . parseCoNLL

conll2latex' :: CoNLL -> [LaTeX]
conll2latex' = dep2latex . conll2dep'

data Dep = Dep {
    wordLength  :: Int -> Double        -- length of word at position int       -- was: fixed width, millimetres (>= 20.0)
  , tokens      :: [(String,String)]    -- word, pos (0..)
  , deps        :: [((Int,Int),String)] -- from, to, label
  , root        :: Int                  -- root word position
  }

-- some general measures
defaultWordLength = 20.0  -- the default fixed width word length, making word 100 units
defaultUnit       = 0.2   -- unit in latex pictures, 0.2 millimetres
spaceLength       = 10.0
charWidth = 1.8

wsize rwld  w  = 100 * rwld w + spaceLength                   -- word length, units
wpos rwld i    = sum [wsize rwld j | j <- [0..i-1]]           -- start position of the i'th word
wdist rwld x y = sum [wsize rwld i | i <- [min x y .. max x y - 1]]    -- distance between words x and y
labelheight h  = h + arcbase + 3    -- label just above arc; 25 would put it just below
labelstart c   = c - 15.0           -- label starts 15u left of arc centre
arcbase        = 30.0               -- arcs start and end 40u above the bottom
arcfactor r    = r * 600            -- reduction of arc size from word distance
xyratio        = 3                  -- width/height ratio of arcs

putArc :: (Int -> Double) -> Int -> Int -> Int -> String -> [DrawingCommand]
putArc frwld height x y label = [oval,arrowhead,labelling] where
  oval = Put (ctr,arcbase) (OvalTop (wdth,hght))
  arrowhead = Put (endp,arcbase + 5) (ArrowDown 5)   -- downgoing arrow 5u above the arc base
  labelling = Put (labelstart ctr,labelheight (hght/2)) (TinyText label)
  dxy  = wdist frwld x y             -- distance between words, >>= 20.0
  ndxy = 100 * rwld * fromIntegral height  -- distance that is indep of word length
  hdxy = dxy / 2                     -- half the distance
  wdth = dxy - (arcfactor rwld)/dxy  -- longer arcs are wider in proportion
  hght = ndxy / (xyratio * rwld)      -- arc height is independent of word length
  begp = min x y                     -- begin position of oval
  ctr  = wpos frwld begp + hdxy + (if x < y then 20 else  10)  -- LR arcs are farther right from center of oval
  endp = (if x < y then (+) else (-)) ctr (wdth/2)            -- the point of the arrow
  rwld = 0.5 ----

dep2latex :: Dep -> [LaTeX]
dep2latex d =
  [Comment (unwords (map fst (tokens d))),
   Picture defaultUnit (width,height) (
     [Put (wpos rwld i,0) (Text w) | (i,w) <- zip [0..] (map fst (tokens d))]   -- words
  ++ [Put (wpos rwld i,15) (TinyText w) | (i,w) <- zip [0..] (map snd (tokens d))]   -- pos tags 15u above bottom
  ++ concat [putArc rwld (aheight x y) x y label | ((x,y),label) <- deps d]    -- arcs and labels
  ++ [Put (wpos rwld (root d) + 15,height) (ArrowDown (height-arcbase))]
  ++ [Put (wpos rwld (root d) + 20,height - 10) (TinyText "ROOT")]
  )]
 where
   wld i  = wordLength d i  -- >= 20.0
   rwld i = (wld i) / defaultWordLength       -- >= 1.0
   aheight x y = depth (min x y) (max x y) + 1    ---- abs (x-y)
   arcs = [(min u v, max u v) | ((u,v),_) <- deps d]
   depth x y = case [(u,v) | (u,v) <- arcs, (x < u && v <= y) || (x == u && v < y)] of ---- only projective arcs counted
     [] -> 0
     uvs -> 1 + maximum (0:[depth u v | (u,v) <- uvs])
   width = {-round-} (sum [wsize rwld w | (w,_) <- zip [0..] (tokens d)]) + {-round-} spaceLength * fromIntegral ((length (tokens d)) - 1)
   height = 50 + 20 * {-round-} (maximum (0:[aheight x y | ((x,y),_) <- deps d]))

type CoNLL = [[String]]
parseCoNLL :: String -> CoNLL
parseCoNLL = map words . lines

--conll2dep :: String -> Dep
--conll2dep = conll2dep' . parseCoNLL

conll2dep' :: CoNLL -> Dep
conll2dep' ls = Dep {
    wordLength = wld 
  , tokens = toks
  , deps = dps
  , root = head $ [read x-1 | x:_:_:_:_:_:"0":_ <- ls] ++ [1]
  }
 where
   wld i = maximum (0:[charWidth * fromIntegral (length w) | w <- let (tok,pos) = toks !! i in [tok,pos]])
   toks = [(w,c) | _:w:_:c:_ <- ls]
   dps = [((read y-1, read x-1),lab) | x:_:_:_:_:_:y:lab:_ <- ls, y /="0"]
   --maxdist = maximum [abs (x-y) | ((x,y),_) <- dps]


-- * LaTeX Pictures (see https://en.wikibooks.org/wiki/LaTeX/Picture)

-- We render both LaTeX and SVG from this intermediate representation of
-- LaTeX pictures.

data LaTeX = Comment String | Picture UnitLengthMM Size [DrawingCommand]
data DrawingCommand = Put Position Object
data Object = Text String | TinyText String | OvalTop Size | ArrowDown Length

type UnitLengthMM = Double
type Size = (Double,Double)
type Position = (Double,Double)
type Length = Double


-- * latex formatting
ppLaTeX = vcat . map ppLaTeX1
  where
    ppLaTeX1 el =
      case el of
        Comment s -> comment s
        Picture unit size cmds ->
          app "setlength{\\unitlength}" (text (show unit ++ "mm"))
          $$ hang (app "begin" (text "picture")<>text (show size)) 2
                  (vcat (map ppDrawingCommand cmds))
          $$ app "end" (text "picture")
          $$ text ""

    ppDrawingCommand (Put pos obj) = put pos (ppObject obj)

    ppObject obj =
      case obj of
        Text s -> text s
        TinyText s -> small (text s)
        OvalTop size -> text "\\oval" <> text (show size) <> text "[t]"
        ArrowDown len -> app "vector(0,-1)" (text (show len))

    put p@(_,_) = app ("put" ++ show p)
    small w = text "{\\tiny" <+> w <> text "}"
    comment s = text "%%" <+> text s -- line break show follow
    
app macro arg = text "\\" <> text macro <> text "{" <> arg <> text "}"


latexDoc :: Doc -> Doc
latexDoc body =
  vcat [text "\\documentclass{article}",
        text "\\usepackage[utf8]{inputenc}",
        text "\\begin{document}",
        body,
        text "\\end{document}"]

-- * SVG (see https://www.w3.org/Graphics/SVG/IG/resources/svgprimer.html)

-- | Render LaTeX pictures as SVG
toSVG = concatMap toSVG1
  where
    toSVG1 el =
      case el of
        Comment s -> []
        Picture unit size@(w,h) cmds ->
          [Elem "svg" ["width".=x1,"height".=y0+5,
                       ("viewBox",unwords (map show [0,0,x1,y0+5])),
                       ("version","1.1"),
                       ("xmlns","http://www.w3.org/2000/svg")]
                       (white_bg:concatMap draw cmds)]
          where
            white_bg =
              Elem "rect" ["x".=0,"y".=0,"width".=x1,"height".=y0+5,
                           ("fill","white")] []

            draw (Put pos obj) = objectSVG pos obj

            objectSVG pos obj =
              case obj of
                Text s -> [text 16 pos s]
                TinyText s -> [text 10 pos s]
                OvalTop size -> [ovalTop pos size]
                ArrowDown len -> arrowDown pos len

            text h (x,y) s =
              Elem "text" ["x".=xc x,"y".=yc y-2,"font-size".=h]
                          [CharData s]

            ovalTop (x,y) (w,h) =
              Elem "path" [("d",path),("stroke","black"),("fill","none")] []
              where
                x1 = x-w/2
                x2 = min x (x1+r)
                x3 = max x (x4-r)
                x4 = x+w/2
                y1 = y
                y2 = y+r
                r = h/2
                sx = show . xc
                sy = show . yc
                path = unwords (["M",sx x1,sy y1,"Q",sx x1,sy y2,sx x2,sy y2,
                                 "L",sx x3,sy y2,"Q",sx x4,sy y2,sx x4,sy y1])

            arrowDown (x,y) len =
                [Elem "line" ["x1".=xc x,"y1".=yc y,"x2".=xc x,"y2".=y2,
                              ("stroke","black")] [],
                 Elem "path" [("d",unwords arrowhead)] []]
               where
                 x2 = xc x
                 y2 = yc (y-len)
                 arrowhead = "M":map show [x2,y2,x2-3,y2-6,x2+3,y2-6]

            xc x = num x+5
            yc y = y0-num y
            x1 = num w+10
            y0 = num h+20
            num x = round (scale*x)
            scale = unit*5

            infix 0 .=
            n.=v = (n,show v)

-- * SVG is XML

data SVG = CharData String | Elem TagName Attrs [SVG]
type TagName = String
type Attrs = [(String,String)]

ppSVG svg =
  vcat [text "<?xml version=\"1.0\" standalone=\"no\"?>",
        text "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\"",
        text "\"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">",
        text "",
        vcat (map ppSVG1 svg)] -- It should be a single <svg> element...
  where
    ppSVG1 svg1 =
      case svg1 of
        CharData s -> text (encode s)
        Elem tag attrs [] ->
            text "<"<>text tag<>cat (map attr attrs) <> text "/>"
        Elem tag attrs svg ->
            cat [text "<"<>text tag<>cat (map attr attrs) <> text ">",
                 nest 2 (cat (map ppSVG1 svg)),
                 text "</"<>text tag<>text ">"]

    attr (n,v) = text " "<>text n<>text "=\""<>text (encode v)<>text "\""

    encode s = foldr encodeEntity "" s

    encodeEntity = encodeEntity' (const False)
    encodeEntity' esc c r =
      case c of
        '&' -> "&amp;"++r
        '<' -> "&lt;"++r
        '>' -> "&gt;"++r
        _ -> c:r


----------------------------------
-- concrete syntax annotations (local) on top of conll
-- examples of annotations:
-- UseComp {"not"} PART neg head 
-- UseComp {*} AUX cop head

type CncLabels = [(String, String -> Maybe (String -> String,String,String))]
-- (fun, word -> (pos,label,target))
-- the pos can remain unchanged, as in the current notation in the article

fixCoNLL :: CncLabels -> CoNLL -> CoNLL
fixCoNLL labels conll = map fixc conll where
  fixc row = case row of
    (i:word:fun:pos:cat:x_:"0":"dep":xs) -> (i:word:fun:pos:cat:x_:"0":"root":xs) --- change the root label from dep to root 
    (i:word:fun:pos:cat:x_:j:label:xs) -> case look (fun,word) of
      Just (pos',label',"head") -> (i:word:fun:pos' pos:cat:x_:j :label':xs)
      Just (pos',label',target) -> (i:word:fun:pos' pos:cat:x_: getDep j target:label':xs)
      _ -> row
    _ -> row
    
  look (fun,word) = case lookup fun labels of
    Just relabel -> case relabel word of
      Just row -> Just row
      _ -> case lookup "*" labels of
        Just starlabel -> starlabel word
        _ -> Nothing
    _ -> case lookup "*" labels of
        Just starlabel -> starlabel word
        _ -> Nothing
  
  getDep j label = maybe j id $ lookup (label,j) [((label,j),i) | i:word:fun:pos:cat:x_:j:label:xs <- conll]

getCncDepLabels :: String -> CncLabels
getCncDepLabels = map merge .  groupBy (\ (x,_) (a,_) -> x == a) . concatMap analyse . filter choose . lines where
  --- choose is for compatibility with the general notation
  choose line = notElem '(' line && elem '{' line --- ignoring non-local (with "(") and abstract (without "{") rules
  
  analyse line = case break (=='{') line of
    (beg,_:ws) -> case break (=='}') ws of
      (toks,_:target) -> case (words beg, words target) of
        (fun:_,[    label,j]) -> [(fun, (tok, (id,       label,j))) | tok <- getToks toks]
        (fun:_,[pos,label,j]) -> [(fun, (tok, (const pos,label,j))) | tok <- getToks toks]
        _ -> []
      _ -> []
    _ -> []
  merge rules@((fun,_):_) = (fun, \tok ->
    case lookup tok (map snd rules) of
      Just new -> return new
      _ -> lookup "*"  (map snd rules)
    )
  getToks = words . map (\c -> if elem c "\"," then ' ' else c)

printCoNLL :: CoNLL -> String
printCoNLL = unlines . map (concat . intersperse "\t")


newGraphvizOptions :: Ptr GuPool -> GraphvizOptions -> IO (Ptr PgfGraphvizOptions)
newGraphvizOptions pool opts = do
  c_opts <- gu_malloc pool (#size PgfGraphvizOptions)
  (#poke PgfGraphvizOptions, noLeaves) c_opts (if noLeaves opts then 1 else 0 :: CInt)
  (#poke PgfGraphvizOptions, noFun)    c_opts (if noFun    opts then 1 else 0 :: CInt)
  (#poke PgfGraphvizOptions, noCat)    c_opts (if noCat    opts then 1 else 0 :: CInt)
  (#poke PgfGraphvizOptions, noDep)    c_opts (if noDep    opts then 1 else 0 :: CInt)
  newUtf8CString (nodeFont opts) pool >>= (#poke PgfGraphvizOptions, nodeFont) c_opts
  newUtf8CString (leafFont opts) pool >>= (#poke PgfGraphvizOptions, leafFont) c_opts
  newUtf8CString (nodeColor opts) pool >>= (#poke PgfGraphvizOptions, nodeColor) c_opts
  newUtf8CString (leafColor opts) pool >>= (#poke PgfGraphvizOptions, leafColor) c_opts
  newUtf8CString (nodeEdgeStyle opts) pool >>= (#poke PgfGraphvizOptions, nodeEdgeStyle) c_opts
  newUtf8CString (leafEdgeStyle opts) pool >>= (#poke PgfGraphvizOptions, leafEdgeStyle) c_opts
  return c_opts

-----------------------------------------------------------------------------
-- Functions using Concr
-- Morpho analyses, parsing & linearization

type MorphoAnalysis = (Fun,Cat,Float)

lookupMorpho :: Concr -> String -> [MorphoAnalysis]
lookupMorpho (Concr concr master) sent =
  unsafePerformIO $
     withGuPool $ \tmpPl -> do
       ref <- newIORef []
       cback <- gu_malloc tmpPl (#size PgfMorphoCallback)
       fptr <- wrapLookupMorphoCallback (getAnalysis ref)
       (#poke PgfMorphoCallback, callback) cback fptr
       c_sent <- newUtf8CString sent tmpPl
       pgf_lookup_morpho concr c_sent cback nullPtr
       freeHaskellFunPtr fptr
       readIORef ref

fullFormLexicon :: Concr -> [(String, [MorphoAnalysis])]
fullFormLexicon lang =
  unsafePerformIO $
    do pl <- gu_new_pool
       enum <- pgf_fullform_lexicon (concr lang) pl
       fpl <- newForeignPtr gu_pool_finalizer pl
       fromFullFormEntry enum fpl
  where
    fromFullFormEntry :: Ptr GuEnum -> ForeignPtr GuPool -> IO [(String, [MorphoAnalysis])]
    fromFullFormEntry enum fpl =
      do ffEntry <- alloca $ \ptr ->
                      withForeignPtr fpl $ \pl ->
                        do gu_enum_next enum ptr pl
                           peek ptr
         if ffEntry == nullPtr
           then do finalizeForeignPtr fpl
                   touchConcr lang
                   return []
           else do tok  <- peekUtf8CString =<< pgf_fullform_get_string ffEntry
                   ref  <- newIORef []
                   allocaBytes (#size PgfMorphoCallback) $ \cback ->
                        do fptr <- wrapLookupMorphoCallback (getAnalysis ref)
                           (#poke PgfMorphoCallback, callback) cback fptr
                           pgf_fullform_get_analyses ffEntry cback nullPtr
                   ans  <- readIORef ref
                   toks <- unsafeInterleaveIO (fromFullFormEntry enum fpl)
                   return ((tok,ans) : toks)

getAnalysis :: IORef [MorphoAnalysis] -> LookupMorphoCallback
getAnalysis ref self c_lemma c_anal prob exn = do
  ans <- readIORef ref
  lemma <- peekUtf8CString c_lemma
  anal  <- peekUtf8CString c_anal
  writeIORef ref ((lemma, anal, prob):ans)

-- | This data type encodes the different outcomes which you could get from the parser.
data ParseOutput
  = ParseFailed Int String         -- ^ The integer is the position in number of unicode characters where the parser failed.
                                   -- The string is the token where the parser have failed.
  | ParseOk [(Expr,Float)]         -- ^ If the parsing and the type checking are successful we get a list of abstract syntax trees.
                                   -- The list should be non-empty.
  | ParseIncomplete                -- ^ The sentence is not complete.

parse :: Concr -> Type -> String -> ParseOutput
parse lang ty sent = parseWithHeuristics lang ty sent (-1.0) []

parseWithHeuristics :: Concr      -- ^ the language with which we parse
                    -> Type       -- ^ the start category
                    -> String     -- ^ the input sentence
                    -> Double     -- ^ the heuristic factor. 
                                  -- A negative value tells the parser 
                                  -- to lookup up the default from 
                                  -- the grammar flags
                    -> [(Cat, Int -> Int -> Maybe (Expr,Float,Int))]
                                  -- ^ a list of callbacks for literal categories.
                                  -- The arguments of the callback are:
                                  -- the index of the constituent for the literal category;
                                  -- the input sentence; the current offset in the sentence.
                                  -- If a literal has been recognized then the output should
                                  -- be Just (expr,probability,end_offset)
                    -> ParseOutput
parseWithHeuristics lang (Type ctype _) sent heuristic callbacks =
  unsafePerformIO $
    do exprPl  <- gu_new_pool
       parsePl <- gu_new_pool
       exn     <- gu_new_exn parsePl
       sent    <- newUtf8CString sent parsePl
       callbacks_map <- mkCallbacksMap (concr lang) callbacks parsePl
       enum    <- pgf_parse_with_heuristics (concr lang) ctype sent heuristic callbacks_map exn parsePl exprPl
       failed  <- gu_exn_is_raised exn
       if failed
         then do is_parse_error <- gu_exn_caught exn gu_exn_type_PgfParseError
                 if is_parse_error
                   then do c_err <- (#peek GuExn, data.data) exn
                           c_incomplete <- (#peek PgfParseError, incomplete) c_err
                           if (c_incomplete :: CInt) == 0
                             then do c_offset <- (#peek PgfParseError, offset) c_err
                                     token_ptr <- (#peek PgfParseError, token_ptr) c_err
                                     token_len <- (#peek PgfParseError, token_len) c_err
                                     tok <- peekUtf8CStringLen token_ptr token_len
                                     gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     return (ParseFailed (fromIntegral (c_offset :: CInt)) tok)
                             else do gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     return ParseIncomplete
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- (#peek GuExn, data.data) exn
                                     msg <- peekUtf8CString c_msg
                                     gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     throwIO (PGFError msg)
                             else do gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     throwIO (PGFError "Parsing failed")
         else do parseFPl <- newForeignPtr gu_pool_finalizer parsePl
                 exprFPl  <- newForeignPtr gu_pool_finalizer exprPl
                 exprs    <- fromPgfExprEnum enum parseFPl (touchConcr lang >> touchForeignPtr exprFPl)
                 return (ParseOk exprs)

mkCallbacksMap :: Ptr PgfConcr -> [(String, Int -> Int -> Maybe (Expr,Float,Int))] -> Ptr GuPool -> IO (Ptr PgfCallbacksMap)
mkCallbacksMap concr callbacks pool = do
  callbacks_map <- pgf_new_callbacks_map concr pool
  forM_ callbacks $ \(cat,match) -> do
    ccat     <- newUtf8CString cat pool
    match    <- wrapLiteralMatchCallback (match_callback match)
    predict  <- wrapLiteralPredictCallback predict_callback
    hspgf_callbacks_map_add_literal concr callbacks_map ccat match predict pool
  return callbacks_map
  where
    match_callback match clin_idx poffset out_pool = do
      coffset <- peek poffset
      case match (fromIntegral clin_idx) (fromIntegral coffset) of
        Nothing               -> return nullPtr
        Just (e,prob,offset') -> do poke poffset (fromIntegral offset')

                                    -- here we copy the expression to out_pool
                                    c_e <- withGuPool $ \tmpPl -> do
                                             exn <- gu_new_exn tmpPl
        
                                             (sb,out) <- newOut tmpPl
                                             let printCtxt = nullPtr
                                             pgf_print_expr (expr e) printCtxt 1 out exn
                                             c_str <- gu_string_buf_freeze sb tmpPl

                                             guin <- gu_string_in c_str tmpPl
                                             pgf_read_expr guin out_pool tmpPl exn

                                    ep <- gu_malloc out_pool (#size PgfExprProb)
                                    (#poke PgfExprProb, expr) ep c_e
                                    (#poke PgfExprProb, prob) ep prob
                                    return ep

    predict_callback _ _ _ = return nullPtr

complete :: Concr      -- ^ the language with which we do word completion
         -> Type       -- ^ the start category
         -> String     -- ^ the input sentence
         -> String     -- ^ prefix for the word to be completed
         -> [(String, Cat, Fun, Float)]
complete lang (Type ctype _) sent prefix =
  unsafePerformIO $
    do pl      <- gu_new_pool
       exn     <- gu_new_exn pl
       sent    <- newUtf8CString sent   pl
       prefix  <- newUtf8CString prefix pl
       enum    <- pgf_complete (concr lang) ctype sent prefix exn pl
       failed  <- gu_exn_is_raised exn
       if failed
         then do gu_pool_free pl
                 return []
         else do fpl    <- newForeignPtr gu_pool_finalizer pl
                 tokens <- fromPgfTokenEnum enum fpl
                 return tokens

lookupSentence :: Concr      -- ^ the language with which we parse
               -> Type       -- ^ the start category
               -> String     -- ^ the input sentence
               -> [(Expr,Float)]
lookupSentence lang (Type ctype _) sent =
  unsafePerformIO $
    do exprPl  <- gu_new_pool
       parsePl <- gu_new_pool
       sent    <- newUtf8CString sent parsePl
       enum    <- pgf_lookup_sentence (concr lang) ctype sent parsePl exprPl
       parseFPl <- newForeignPtr gu_pool_finalizer parsePl
       exprFPl  <- newForeignPtr gu_pool_finalizer exprPl
       exprs    <- fromPgfExprEnum enum parseFPl (touchConcr lang >> touchForeignPtr exprFPl)
       return exprs


-- | The oracle is a triple of functions.
-- The first two take a category name and a linearization field name
-- and they should return True/False when the corresponding 
-- prediction or completion is appropriate. The third function
-- is the oracle for literals.
type Oracle = (Maybe (Cat -> String -> Int -> Bool)
              ,Maybe (Cat -> String -> Int -> Bool)
              ,Maybe (Cat -> String -> Int -> Maybe (Expr,Float,Int))
              )

parseWithOracle :: Concr      -- ^ the language with which we parse
                -> Cat        -- ^ the start category
                -> String     -- ^ the input sentence
                -> Oracle
                -> ParseOutput
parseWithOracle lang cat sent (predict,complete,literal) =
  unsafePerformIO $
    do parsePl <- gu_new_pool
       exprPl  <- gu_new_pool
       exn     <- gu_new_exn parsePl
       cat     <- newUtf8CString cat  parsePl
       sent    <- newUtf8CString sent parsePl
       predictPtr  <- maybe (return nullFunPtr) (wrapOracleCallback . oracleWrapper) predict
       completePtr <- maybe (return nullFunPtr) (wrapOracleCallback . oracleWrapper) complete
       literalPtr  <- maybe (return nullFunPtr) (wrapOracleLiteralCallback . oracleLiteralWrapper) literal
       cback <- hspgf_new_oracle_callback sent predictPtr completePtr literalPtr parsePl
       enum    <- pgf_parse_with_oracle (concr lang) cat sent cback exn parsePl exprPl
       failed  <- gu_exn_is_raised exn
       if failed
         then do is_parse_error <- gu_exn_caught exn gu_exn_type_PgfParseError
                 if is_parse_error
                   then do c_err <- (#peek GuExn, data.data) exn
                           c_incomplete <- (#peek PgfParseError, incomplete) c_err
                           if (c_incomplete :: CInt) == 0
                             then do c_offset <- (#peek PgfParseError, offset) c_err
                                     token_ptr <- (#peek PgfParseError, token_ptr) c_err
                                     token_len <- (#peek PgfParseError, token_len) c_err
                                     tok <- peekUtf8CStringLen token_ptr token_len
                                     gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     return (ParseFailed (fromIntegral (c_offset :: CInt)) tok)
                             else do gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     return ParseIncomplete
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- (#peek GuExn, data.data) exn
                                     msg <- peekUtf8CString c_msg
                                     gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     throwIO (PGFError msg)
                             else do gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     throwIO (PGFError "Parsing failed")
         else do parseFPl <- newForeignPtr gu_pool_finalizer parsePl
                 exprFPl  <- newForeignPtr gu_pool_finalizer exprPl
                 exprs    <- fromPgfExprEnum enum parseFPl (touchConcr lang >> touchForeignPtr exprFPl)
                 return (ParseOk exprs)
  where
    oracleWrapper oracle catPtr lblPtr offset = do
      cat <- peekUtf8CString catPtr
      lbl <- peekUtf8CString lblPtr
      return (oracle cat lbl (fromIntegral offset))

    oracleLiteralWrapper oracle catPtr lblPtr poffset out_pool = do
      cat <- peekUtf8CString catPtr
      lbl <- peekUtf8CString lblPtr
      offset <- peek poffset
      case oracle cat lbl (fromIntegral offset) of
        Just (e,prob,offset) ->
                      do poke poffset (fromIntegral offset)

                         -- here we copy the expression to out_pool
                         c_e <- withGuPool $ \tmpPl -> do
                                  exn <- gu_new_exn tmpPl

                                  (sb,out) <- newOut tmpPl
                                  let printCtxt = nullPtr
                                  pgf_print_expr (expr e) printCtxt 1 out exn
                                  c_str <- gu_string_buf_freeze sb tmpPl

                                  guin <- gu_string_in c_str tmpPl
                                  pgf_read_expr guin out_pool tmpPl exn

                         ep <- gu_malloc out_pool (#size PgfExprProb)
                         (#poke PgfExprProb, expr) ep c_e
                         (#poke PgfExprProb, prob) ep prob
                         return ep
        Nothing    -> do return nullPtr

-- | Returns True if there is a linearization defined for that function in that language
hasLinearization :: Concr -> Fun -> Bool
hasLinearization lang id = unsafePerformIO $
  withGuPool $ \pl -> do
    res <- newUtf8CString id pl >>= pgf_has_linearization (concr lang)
    return (res /= 0)

-- | Linearizes an expression as a string in the language
linearize :: Concr -> Expr -> String
linearize lang e = unsafePerformIO $
  withGuPool $ \pl ->
    do (sb,out) <- newOut pl
       exn <- gu_new_exn pl
       pgf_linearize (concr lang) (expr e) out exn
       touchExpr e
       failed <- gu_exn_is_raised exn
       if failed
         then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                 if is_nonexist
                   then return ""
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- (#peek GuExn, data.data) exn
                                     msg <- peekUtf8CString c_msg
                                     throwIO (PGFError msg)
                             else throwIO (PGFError "The abstract tree cannot be linearized")
         else do lin <- gu_string_buf_freeze sb pl
                 peekUtf8CString lin

-- | Generates all possible linearizations of an expression
linearizeAll :: Concr -> Expr -> [String]
linearizeAll lang e = unsafePerformIO $
  do pl <- gu_new_pool
     exn <- gu_new_exn pl
     cts <- pgf_lzr_concretize (concr lang) (expr e) exn pl
     failed <- gu_exn_is_raised exn
     if failed
       then throwExn exn pl
       else collect cts exn pl
  where
    collect cts exn pl = withGuPool $ \tmpPl -> do
      ctree <- alloca $ \ptr -> do gu_enum_next cts ptr tmpPl
                                   peek ptr
      if ctree == nullPtr
        then do gu_pool_free pl
                touchExpr e
                return []
        else do (sb,out) <- newOut tmpPl
                ctree <- pgf_lzr_wrap_linref ctree tmpPl
                pgf_lzr_linearize_simple (concr lang) ctree 0 out exn tmpPl
                failed <- gu_exn_is_raised exn
                if failed
                  then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                          if is_nonexist
                            then collect cts exn pl
                            else throwExn exn pl
                  else do lin <- gu_string_buf_freeze sb tmpPl
                          s <- peekUtf8CString lin
                          ss <- collect cts exn pl
                          return (s:ss)

    throwExn exn pl = do
      is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
      if is_exn
        then do c_msg <- (#peek GuExn, data.data) exn
                msg <- peekUtf8CString c_msg
                gu_pool_free pl
                throwIO (PGFError msg)
        else do gu_pool_free pl
                throwIO (PGFError "The abstract tree cannot be linearized")

-- | Generates a table of linearizations for an expression
tabularLinearize :: Concr -> Expr -> [(String, String)]
tabularLinearize lang e = 
  case tabularLinearizeAll lang e of
    (lins:_) -> lins
    _        -> []

-- | Generates a table of linearizations for an expression
tabularLinearizeAll :: Concr -> Expr -> [[(String, String)]]
tabularLinearizeAll lang e = unsafePerformIO $
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    cts <- pgf_lzr_concretize (concr lang) (expr e) exn tmpPl
    failed <- gu_exn_is_raised exn
    if failed
      then throwExn exn
      else collect cts exn tmpPl
  where
    collect cts exn tmpPl = do
      ctree <- alloca $ \ptr -> do gu_enum_next cts ptr tmpPl
                                   peek ptr
      if ctree == nullPtr
        then do touchExpr e
                return []
        else do labels <- alloca $ \p_n_lins ->
                          alloca $ \p_labels -> do
                            pgf_lzr_get_table (concr lang) ctree p_n_lins p_labels
                            n_lins <- peek p_n_lins
                            labels <- peek p_labels
                            labels <- peekArray (fromIntegral n_lins) labels
                            labels <- mapM peekCString labels
                            return labels
                lins <- collectTable lang ctree 0 labels exn tmpPl
                linss <- collect cts exn tmpPl
                return (lins : linss)

    collectTable lang ctree lin_idx []             exn tmpPl = return []
    collectTable lang ctree lin_idx (label:labels) exn tmpPl = do
      (sb,out) <- newOut tmpPl
      pgf_lzr_linearize_simple (concr lang) ctree lin_idx out exn tmpPl
      failed <- gu_exn_is_raised exn
      if failed
        then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                if is_nonexist
                  then collectTable lang ctree (lin_idx+1) labels exn tmpPl
                  else throwExn exn
        else do lin <- gu_string_buf_freeze sb tmpPl
                s  <- peekUtf8CString lin
                ss <- collectTable lang ctree (lin_idx+1) labels exn tmpPl
                return ((label,s):ss)

    throwExn exn = do
      is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
      if is_exn
        then do c_msg <- (#peek GuExn, data.data) exn
                msg <- peekUtf8CString c_msg
                throwIO (PGFError msg)
        else do throwIO (PGFError "The abstract tree cannot be linearized")

type FId    = Int
type LIndex = Int

-- | BracketedString represents a sentence that is linearized
-- as usual but we also want to retain the ''brackets'' that
-- mark the beginning and the end of each constituent.
data BracketedString
  = Leaf String                                                                -- ^ this is the leaf i.e. a single token
  | Bracket Cat {-# UNPACK #-} !FId {-# UNPACK #-} !LIndex Fun [BracketedString]
                                                                               -- ^ this is a bracket. The 'Cat' is the category of
                                                                               -- the phrase. The 'FId' is an unique identifier for
                                                                               -- every phrase in the sentence. For context-free grammars
                                                                               -- i.e. without discontinuous constituents this identifier
                                                                               -- is also unique for every bracket. When there are discontinuous 
                                                                               -- phrases then the identifiers are unique for every phrase but
                                                                               -- not for every bracket since the bracket represents a constituent.
                                                                               -- The different constituents could still be distinguished by using
                                                                               -- the constituent index i.e. 'LIndex'. If the grammar is reduplicating
                                                                               -- then the constituent indices will be the same for all brackets
                                                                               -- that represents the same constituent.
                                                                               -- The 'Fun' is the name of the abstract function that generated
                                                                               -- this phrase.

-- | Renders the bracketed string as a string where 
-- the brackets are shown as @(S ...)@ where
-- @S@ is the category.
showBracketedString :: BracketedString -> String
showBracketedString = render . ppBracketedString

ppBracketedString (Leaf t) = text t
ppBracketedString (Bracket cat fid index _ bss) = parens (text cat <> colon <> int fid <+> hsep (map ppBracketedString bss))

-- | Extracts the sequence of tokens from the bracketed string
flattenBracketedString :: BracketedString -> [String]
flattenBracketedString (Leaf w)              = [w]
flattenBracketedString (Bracket _ _ _ _ bss) = concatMap flattenBracketedString bss

bracketedLinearize :: Concr -> Expr -> [BracketedString]
bracketedLinearize lang e = unsafePerformIO $
  withGuPool $ \pl -> 
    do exn <- gu_new_exn pl
       cts <- pgf_lzr_concretize (concr lang) (expr e) exn pl
       failed <- gu_exn_is_raised exn
       if failed
         then throwExn exn
         else do ctree <- alloca $ \ptr -> do gu_enum_next cts ptr pl
                                              peek ptr
                 if ctree == nullPtr
                   then do touchExpr e
                           return []
                   else do ctree <- pgf_lzr_wrap_linref ctree pl
                           ref <- newIORef ([],[])
                           allocaBytes (#size PgfLinFuncs) $ \pLinFuncs  ->
                            alloca $ \ppLinFuncs -> do
                              fptr_symbol_token <- wrapSymbolTokenCallback (symbol_token ref)
                              fptr_begin_phrase <- wrapPhraseCallback (begin_phrase ref)
                              fptr_end_phrase   <- wrapPhraseCallback (end_phrase ref)
                              fptr_symbol_ne    <- wrapSymbolNonExistCallback (symbol_ne exn)
                              fptr_symbol_meta  <- wrapSymbolMetaCallback (symbol_meta ref)
                              (#poke PgfLinFuncs, symbol_token) pLinFuncs fptr_symbol_token
                              (#poke PgfLinFuncs, begin_phrase) pLinFuncs fptr_begin_phrase
                              (#poke PgfLinFuncs, end_phrase)   pLinFuncs fptr_end_phrase
                              (#poke PgfLinFuncs, symbol_ne)    pLinFuncs fptr_symbol_ne
                              (#poke PgfLinFuncs, symbol_bind)  pLinFuncs nullPtr
                              (#poke PgfLinFuncs, symbol_capit) pLinFuncs nullPtr
                              (#poke PgfLinFuncs, symbol_meta)  pLinFuncs fptr_symbol_meta
                              poke ppLinFuncs pLinFuncs
                              pgf_lzr_linearize (concr lang) ctree 0 ppLinFuncs pl
                              freeHaskellFunPtr fptr_symbol_token
                              freeHaskellFunPtr fptr_begin_phrase
                              freeHaskellFunPtr fptr_end_phrase
                              freeHaskellFunPtr fptr_symbol_ne
                              freeHaskellFunPtr fptr_symbol_meta
                           failed <- gu_exn_is_raised exn
                           if failed
                             then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                                     if is_nonexist
                                       then return []
                                       else throwExn exn
                             else do (_,bs) <- readIORef ref
                                     return (reverse bs)
  where
    symbol_token ref _ c_token = do
      (stack,bs) <- readIORef ref
      token <- peekUtf8CString c_token
      writeIORef ref (stack,Leaf token : bs)

    begin_phrase ref _ c_cat c_fid c_lindex c_fun = do
      (stack,bs) <- readIORef ref
      writeIORef ref (bs:stack,[])

    end_phrase ref _ c_cat c_fid c_lindex c_fun = do
      (bs':stack,bs) <- readIORef ref
      cat <- peekUtf8CString c_cat
      let fid    = fromIntegral c_fid
      let lindex = fromIntegral c_lindex
      fun <- peekUtf8CString c_fun
      writeIORef ref (stack, Bracket cat fid lindex fun (reverse bs) : bs')

    symbol_ne exn _ = do
      gu_exn_raise exn gu_exn_type_PgfLinNonExist
      return ()

    symbol_meta ref _ meta_id = do
      (stack,bs) <- readIORef ref
      writeIORef ref (stack,Leaf "?" : bs)

    throwExn exn = do
      is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
      if is_exn
        then do c_msg <- (#peek GuExn, data.data) exn
                msg <- peekUtf8CString c_msg
                throwIO (PGFError msg)
        else do throwIO (PGFError "The abstract tree cannot be linearized")

alignWords :: Concr -> Expr -> [(String, [Int])]
alignWords lang e = unsafePerformIO $
  withGuPool $ \pl ->
    do exn <- gu_new_exn pl
       seq <- pgf_align_words (concr lang) (expr e) exn pl
       touchConcr lang
       touchExpr e
       failed <- gu_exn_is_raised exn
       if failed
         then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                 if is_nonexist
                   then return []
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- (#peek GuExn, data.data) exn
                                     msg <- peekUtf8CString c_msg
                                     throwIO (PGFError msg)
                             else throwIO (PGFError "The abstract tree cannot be linearized")
         else do len <- (#peek GuSeq, len) seq
                 arr <- peekArray (fromIntegral (len :: CInt)) (seq `plusPtr` (#offset GuSeq, data))
                 mapM peekAlignmentPhrase arr
  where
    peekAlignmentPhrase :: Ptr () -> IO (String, [Int])
    peekAlignmentPhrase ptr = do
      c_phrase <- (#peek PgfAlignmentPhrase, phrase) ptr
      phrase <- peekUtf8CString c_phrase
      n_fids <- (#peek PgfAlignmentPhrase, n_fids) ptr
      (fids :: [CInt]) <- peekArray (fromIntegral (n_fids :: CInt)) (ptr `plusPtr` (#offset PgfAlignmentPhrase, fids))
      return (phrase, map fromIntegral fids)

printName :: Concr -> Fun -> Maybe String
printName lang fun =
  unsafePerformIO $
  withGuPool $ \tmpPl -> do
    c_fun  <- newUtf8CString fun tmpPl
    c_name <- pgf_print_name (concr lang) c_fun
    name   <- if c_name == nullPtr
                then return Nothing
                else fmap Just (peekUtf8CString c_name)
    touchConcr lang
    return name

-- | List of all functions defined in the abstract syntax
functions :: PGF -> [Fun]
functions p =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
    allocaBytes (#size GuMapItor) $ \itor -> do
      exn <- gu_new_exn tmpPl
      ref <- newIORef []
      fptr <- wrapMapItorCallback (getFunctions ref)
      (#poke GuMapItor, fn) itor fptr
      pgf_iter_functions (pgf p) itor exn
      touchPGF p
      freeHaskellFunPtr fptr
      fs <- readIORef ref
      return (reverse fs)
  where
    getFunctions :: IORef [String] -> MapItorCallback
    getFunctions ref itor key value exn = do
      names <- readIORef ref
      name  <- peekUtf8CString (castPtr key)
      writeIORef ref $! (name : names)

-- | List of all functions defined for a category
functionsByCat :: PGF -> Cat -> [Fun]
functionsByCat p cat =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
    allocaBytes (#size GuMapItor) $ \itor -> do
      exn <- gu_new_exn tmpPl
      ref <- newIORef []
      fptr <- wrapMapItorCallback (getFunctions ref)
      (#poke GuMapItor, fn) itor fptr
      ccat <- newUtf8CString cat tmpPl
      pgf_iter_functions_by_cat (pgf p) ccat itor exn
      touchPGF p
      freeHaskellFunPtr fptr
      fs <- readIORef ref
      return (reverse fs)
  where
    getFunctions :: IORef [String] -> MapItorCallback
    getFunctions ref itor key value exn = do
      names <- readIORef ref
      name  <- peekUtf8CString (castPtr key)
      writeIORef ref $! (name : names)

-- | List of all categories defined in the grammar.
-- The categories are defined in the abstract syntax
-- with the \'cat\' keyword.
categories :: PGF -> [Cat]
categories p =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
    allocaBytes (#size GuMapItor) $ \itor -> do
      exn <- gu_new_exn tmpPl
      ref <- newIORef []
      fptr <- wrapMapItorCallback (getCategories ref)
      (#poke GuMapItor, fn) itor fptr
      pgf_iter_categories (pgf p) itor exn
      touchPGF p
      freeHaskellFunPtr fptr
      cs <- readIORef ref
      return (reverse cs)
  where
    getCategories :: IORef [String] -> MapItorCallback
    getCategories ref itor key value exn = do
      names <- readIORef ref
      name  <- peekUtf8CString (castPtr key)
      writeIORef ref $! (name : names)

categoryContext :: PGF -> Cat -> Maybe [Hypo]
categoryContext p cat =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do c_cat <- newUtf8CString cat tmpPl
         c_hypos <- pgf_category_context (pgf p) c_cat
         if c_hypos == nullPtr
           then return Nothing
           else do n_hypos <- (#peek GuSeq, len) c_hypos
                   hypos <- peekHypos (c_hypos `plusPtr` (#offset GuSeq, data)) 0 n_hypos
                   return (Just hypos)
  where
    peekHypos :: Ptr a -> Int -> Int -> IO [Hypo]
    peekHypos c_hypo i n
      | i < n     = do cid <- (#peek PgfHypo, cid) c_hypo >>= peekUtf8CString
                       c_ty <- (#peek PgfHypo, type) c_hypo
                       bt  <- fmap toBindType ((#peek PgfHypo, bind_type) c_hypo)
                       hs <- peekHypos (plusPtr c_hypo (#size PgfHypo)) (i+1) n
                       return ((bt,cid,Type c_ty (touchPGF p)) : hs)
      | otherwise = return []

    toBindType :: CInt -> BindType
    toBindType (#const PGF_BIND_TYPE_EXPLICIT) = Explicit
    toBindType (#const PGF_BIND_TYPE_IMPLICIT) = Implicit

categoryProbability :: PGF -> Cat -> Float
categoryProbability p cat =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do c_cat <- newUtf8CString cat tmpPl
         c_prob <- pgf_category_prob (pgf p) c_cat
         touchPGF p
         return (realToFrac c_prob)

-----------------------------------------------------------------------------
-- Helper functions

fromPgfExprEnum :: Ptr GuEnum -> ForeignPtr GuPool -> Touch -> IO [(Expr, Float)]
fromPgfExprEnum enum fpl touch =
  do pgfExprProb <- alloca $ \ptr ->
                      withForeignPtr fpl $ \pl ->
                        do gu_enum_next enum ptr pl
                           peek ptr
     if pgfExprProb == nullPtr
       then do finalizeForeignPtr fpl
               return []
       else do expr <- (#peek PgfExprProb, expr) pgfExprProb
               ts <- unsafeInterleaveIO (fromPgfExprEnum enum fpl touch)
               prob <- (#peek PgfExprProb, prob) pgfExprProb
               return ((Expr expr touch,prob) : ts)

fromPgfTokenEnum :: Ptr GuEnum -> ForeignPtr GuPool -> IO [(String, Cat, Fun, Float)]
fromPgfTokenEnum enum fpl =
  do pgfTokenProb <- alloca $ \ptr ->
                      withForeignPtr fpl $ \pl ->
                        do gu_enum_next enum ptr pl
                           peek ptr
     if pgfTokenProb == nullPtr
       then do finalizeForeignPtr fpl
               return []
       else do tok  <- (#peek PgfTokenProb, tok)  pgfTokenProb >>= peekUtf8CString
               cat  <- (#peek PgfTokenProb, cat)  pgfTokenProb >>= peekUtf8CString
               fun  <- (#peek PgfTokenProb, fun)  pgfTokenProb >>= peekUtf8CString
               prob <- (#peek PgfTokenProb, prob) pgfTokenProb
               ts <- unsafeInterleaveIO (fromPgfTokenEnum enum fpl)
               return ((tok,cat,fun,prob) : ts)

-----------------------------------------------------------------------
-- Exceptions

newtype PGFError = PGFError String
     deriving (Show, Typeable)

instance Exception PGFError

-----------------------------------------------------------------------

type LiteralCallback =
       PGF -> (ConcName,Concr) -> String -> Int -> Int -> Maybe (Expr,Float,Int)

-- | Callbacks for the App grammar
literalCallbacks :: [(AbsName,[(Cat,LiteralCallback)])]
literalCallbacks = [("App",[("PN",nerc),("Symb",chunk)])]

-- | Named entity recognition for the App grammar 
-- (based on ../java/org/grammaticalframework/pgf/NercLiteralCallback.java)
nerc :: LiteralCallback
nerc pgf (lang,concr) sentence lin_idx offset =
  case consume capitalized (drop offset sentence) of
    (capwords@(_:_),rest) |
       not ("Eng" `isSuffixOf` lang && name `elem` ["I","I'm"]) ->
        if null ls
        then pn
        else case cat of
              "PN" -> retLit (mkApp lemma [])
              "WeekDay" -> retLit (mkApp "weekdayPN" [mkApp lemma []])
              "Month" -> retLit (mkApp "monthPN" [mkApp lemma []])
              _ -> Nothing
      where
        retLit e = Just (e,0,end_offset)
          where end_offset = offset+length name
        pn = retLit (mkApp "SymbPN" [mkApp "MkSymb" [mkStr name]])
        ((lemma,cat),_) = maximumBy (compare `on` snd) (reverse ls)
        ls = [((fun,cat),p)
              |(fun,_,p)<-lookupMorpho concr name,
                Just cat <- [functionCat fun],
                cat/="Nationality"]
        name = trimRight (concat capwords)
    _ -> Nothing
  where
    -- | Variant of unfoldr
    consume munch xs =
      case munch xs of
        Nothing -> ([],xs)
        Just (y,xs') -> (y:ys,xs'')
          where (ys,xs'') = consume munch xs'

    functionCat f = fmap ((\(_,c,_) -> c) . unType) (functionType pgf f)

-- | Callback to parse arbitrary words as chunks (from
-- ../java/org/grammaticalframework/pgf/UnknownLiteralCallback.java)
chunk :: LiteralCallback
chunk _ (_,concr) sentence lin_idx offset =
  case uncapitalized (drop offset sentence) of
    Just (word0@(_:_),rest) | null (lookupMorpho concr word) ->
        Just (expr,0,offset+length word)
      where
        word = trimRight word0
        expr = mkApp "MkSymb" [mkStr word]
    _ -> Nothing


-- More helper functions

trimRight = reverse . dropWhile isSpace . reverse

capitalized = capitalized' isUpper
uncapitalized = capitalized' (not.isUpper)

capitalized' test s@(c:_) | test c =
  case span (not.isSpace) s of
    (name,rest1) ->
      case span isSpace rest1 of
        (space,rest2) -> Just (name++space,rest2)
capitalized' not s = Nothing

tag i
  | i < 0     = char 'r' <> int (negate i)
  | otherwise = char 'n' <> int i
