module PGF.Macros where
import Prelude hiding ((<>)) -- GHC 8.4.1 clash with Text.PrettyPrint

import PGF.CId
import PGF.Data
import Control.Monad
import qualified Data.Map    as Map
--import qualified Data.Set    as Set
--import qualified Data.IntMap as IntMap
--import qualified Data.IntSet as IntSet
import qualified Data.Array  as Array
--import Data.Maybe
import Data.List
import Data.Array.IArray
import Text.PrettyPrint

-- operations for manipulating PGF grammars and objects

mapConcretes :: (Concr -> Concr) -> PGF -> PGF
mapConcretes f pgf = pgf { concretes = Map.map f (concretes pgf) }

lookType :: Abstr -> CId -> Type
lookType abs f = 
  case lookMap (error $ "lookType " ++ show f) f (funs abs) of
    (ty,_,_,_) -> ty

isData :: Abstr -> CId -> Bool
isData abs f =
  case Map.lookup f (funs abs) of
    Just (_,_,Nothing,_) -> True       -- the encoding of data constrs
    _                    -> False

lookValCat :: Abstr -> CId -> CId
lookValCat abs = valCat . lookType abs

lookStartCat :: PGF -> CId
lookStartCat pgf = mkCId $
  case msum $ Data.List.map (Map.lookup (mkCId "startcat")) [gflags pgf, aflags (abstract pgf)] of
    Just (LStr s) -> s
    _             -> "S"

lookGlobalFlag :: PGF -> CId -> Maybe Literal
lookGlobalFlag pgf f = Map.lookup f (gflags pgf)

lookAbsFlag :: PGF -> CId -> Maybe Literal
lookAbsFlag pgf f = Map.lookup f (aflags (abstract pgf))

lookConcr :: PGF -> Language -> Concr
lookConcr pgf cnc = 
    lookMap (error $ "Missing concrete syntax: " ++ showCId cnc) cnc $ concretes pgf

-- use if name fails, use abstract + name; so e.g. "Eng" becomes "DemoEng" 
lookConcrComplete :: PGF -> CId -> Concr
lookConcrComplete pgf cnc = 
  case Map.lookup cnc (concretes pgf) of
    Just c -> c
    _ -> lookConcr pgf (mkCId (showCId (absname pgf) ++ showCId cnc))

lookConcrFlag :: PGF -> CId -> CId -> Maybe Literal
lookConcrFlag pgf lang f = Map.lookup f $ cflags $ lookConcr pgf lang

functionsToCat :: PGF -> CId -> [(CId,Type)]
functionsToCat pgf cat =
  [(f,ty) | (_,f) <- fs, Just (ty,_,_,_) <- [Map.lookup f $ funs $ abstract pgf]]
 where 
   (_,fs,_) = lookMap ([],[],0) cat $ cats $ abstract pgf

-- | List of functions that lack linearizations in the given language.
missingLins :: PGF -> Language -> [CId]
missingLins pgf lang = [c | c <- fs, not (hasl c)] where
  fs = Map.keys $ funs $ abstract pgf
  hasl = hasLin pgf lang

hasLin :: PGF -> Language -> CId -> Bool
hasLin pgf lang f = Map.member f $ lproductions $ lookConcr pgf lang

restrictPGF :: (CId -> Bool) -> PGF -> PGF
restrictPGF cond pgf = pgf {
  abstract = abstr {
    funs = Map.filterWithKey (\c _ -> cond c) (funs abstr),
    cats = Map.map (\(hyps,fs,p) -> (hyps,filter (cond . snd) fs,p)) (cats abstr)
    }
  }  ---- restrict concrs also, might be needed
 where
  abstr = abstract pgf

depth :: Expr -> Int
depth (EAbs _ _ t) = depth t
depth (EApp e1 e2) = max (depth e1) (depth e2) + 1
depth _            = 1

cftype :: [CId] -> CId -> Type
cftype args val = DTyp [(Explicit,wildCId,cftype [] arg) | arg <- args] val []

typeOfHypo :: Hypo -> Type
typeOfHypo (_,_,ty) = ty

catSkeleton :: Type -> ([CId],CId)
catSkeleton ty = case ty of
  DTyp hyps val _ -> ([valCat (typeOfHypo h) | h <- hyps],val)

typeSkeleton :: Type -> ([(Int,CId)],CId)
typeSkeleton ty = case ty of
  DTyp hyps val _ -> ([(contextLength ty, valCat ty) | h <- hyps, let ty = typeOfHypo h],val)

valCat :: Type -> CId
valCat ty = case ty of
  DTyp _ val _ -> val

contextLength :: Type -> Int
contextLength ty = case ty of
  DTyp hyps _ _ -> length hyps

-- | Show the printname of function or category
showPrintName :: PGF -> Language -> CId -> String
showPrintName pgf lang id = lookMap (showCId id) id $ printnames $ lookMap (error "no lang") lang $ concretes pgf

-- lookup with default value
lookMap :: Ord i => a -> i -> Map.Map i a -> a 
lookMap d c m = Map.findWithDefault d c m

--- from Operations
combinations :: [[a]] -> [[a]]
combinations t = case t of 
  []    -> [[]]
  aa:uu -> [a:u | a <- aa, u <- combinations uu]

cidString = mkCId "String"
cidInt    = mkCId "Int"
cidFloat  = mkCId "Float"
cidVar    = mkCId "__gfVar"


-- Utilities for doing linearization

-- | BracketedString represents a sentence that is linearized
-- as usual but we also want to retain the ''brackets'' that
-- mark the beginning and the end of each constituent.
data BracketedString
  = Leaf Token                                                                -- ^ this is the leaf i.e. a single token
  | Bracket CId {-# UNPACK #-} !FId {-# UNPACK #-} !LIndex CId [Expr] [BracketedString]
                                                                               -- ^ this is a bracket. The 'CId' is the category of
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

data BracketedTokn
  = Bracket_ CId {-# UNPACK #-} !FId {-# UNPACK #-} !LIndex CId [Expr] [BracketedTokn]    -- Invariant: the list is not empty
  | LeafKS Token
  | LeafNE
  | LeafBIND
  | LeafSOFT_BIND
  | LeafCAPIT
  | LeafKP [BracketedTokn] [([BracketedTokn],[String])]
  deriving Eq

type LinTable = ([CId],Array.Array LIndex [BracketedTokn])

-- | Renders the bracketed string as string where 
-- the brackets are shown as @(S ...)@ where
-- @S@ is the category.
showBracketedString :: BracketedString -> String
showBracketedString = render . ppBracketedString

ppBracketedString (Leaf t) = text t
ppBracketedString (Bracket cat fid index _ _ bss) = parens (ppCId cat <> colon <> int fid <+> hsep (map ppBracketedString bss))

-- | The length of the bracketed string in number of tokens.
lengthBracketedString :: BracketedString -> Int
lengthBracketedString (Leaf _)              = 1
lengthBracketedString (Bracket _ _ _ _ _ bss) = sum (map lengthBracketedString bss)

untokn :: Maybe String -> [BracketedTokn] -> (Maybe String,[BracketedString])
untokn nw bss =
  let (nw',bss') = mapAccumR untokn nw bss
  in case sequence bss' of
       Just bss -> (nw,concat bss)
       Nothing  -> (nw,[])
  where
    untokn nw (Bracket_ cat fid index fun es bss) =
      let (nw',bss') = mapAccumR untokn nw bss
      in case sequence bss' of
           Just bss -> (nw',Just [Bracket cat fid index fun es (concat bss)])
           Nothing  -> (Nothing, Nothing)
    untokn nw (LeafKS t)
      | null t              = (nw,Just [])
      | otherwise           = (Just t,Just [Leaf t])
    untokn nw LeafNE        = (Nothing, Nothing)
    untokn nw (LeafKP d vs) = let (nw',bss') = mapAccumR untokn nw (sel d vs nw)
                              in case sequence bss' of
                                   Just bss -> (nw',Just (concat bss))
                                   Nothing  -> (Nothing, Nothing)
                              where
                                sel d vs Nothing  = d
                                sel d vs (Just w) =
                                  case [v | (v,cs) <- vs, any (\c -> isPrefixOf c w) cs] of
                                    v:_ -> v
                                    _   -> d

type CncType = (CId, FId)    -- concrete type is the abstract type (the category) + the forest id

mkLinTable :: Concr -> (CncType -> Bool) -> [CId] -> FunId -> [(CncType,FId,CId,[Expr],LinTable)] -> LinTable
mkLinTable cnc filter xs funid args = (xs,listArray (bounds lins) [computeSeq filter (elems (sequences cnc ! seqid)) args | seqid <- elems lins])
  where
    (CncFun _ lins) = cncfuns cnc ! funid

computeSeq :: (CncType -> Bool) -> [Symbol] -> [(CncType,FId,CId,[Expr],LinTable)] -> [BracketedTokn]
computeSeq filter seq args = concatMap compute seq
  where
    compute (SymCat d r)      = getArg d r
    compute (SymLit d r)      = getArg d r
    compute (SymVar d r)      = getVar d r
    compute (SymKS t)         = [LeafKS t]
    compute SymNE             = [LeafNE]
    compute SymBIND           = [LeafKS "&+"]
    compute SymSOFT_BIND      = []
    compute SymSOFT_SPACE     = []
    compute SymCAPIT          = [LeafKS "&|"]
    compute SymALL_CAPIT      = [LeafKS "&|"]
    compute (SymKP syms alts) = [LeafKP (concatMap compute syms) [(concatMap compute syms,cs) | (syms,cs) <- alts]]

    getArg d r
      | not (null arg_lin) &&
        filter ct   = [Bracket_ cat fid r fun es arg_lin]
      | otherwise   = arg_lin
      where
        arg_lin                          = lin ! r
        (ct@(cat,fid),_,fun,es,(_xs,lin)) = args !! d

    getVar d r = [LeafKS (showCId (xs !! r))]
      where
        (_ct,_,_fun,_es,(xs,_lin)) = args !! d

flattenBracketedString :: BracketedString -> [String]
flattenBracketedString (Leaf w)              = [w]
flattenBracketedString (Bracket _ _ _ _ _ bss) = concatMap flattenBracketedString bss
