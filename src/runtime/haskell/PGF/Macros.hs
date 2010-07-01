module PGF.Macros where

import PGF.CId
import PGF.Data
import Control.Monad
import qualified Data.Map    as Map
import qualified Data.Set    as Set
import qualified Data.IntMap as IntMap
import qualified Data.IntSet as IntSet
import qualified Data.Array  as Array
import Data.Maybe
import Data.List
import Text.PrettyPrint

-- operations for manipulating PGF grammars and objects

mapConcretes :: (Concr -> Concr) -> PGF -> PGF
mapConcretes f pgf = pgf { concretes = Map.map f (concretes pgf) }

lookType :: PGF -> CId -> Type
lookType pgf f = 
  case lookMap (error $ "lookType " ++ show f) f (funs (abstract pgf)) of
    (ty,_,_) -> ty

lookDef :: PGF -> CId -> Maybe [Equation]
lookDef pgf f = 
  case lookMap (error $ "lookDef " ++ show f) f (funs (abstract pgf)) of
    (_,a,eqs) -> eqs

isData :: PGF -> CId -> Bool
isData pgf f =
  case Map.lookup f (funs (abstract pgf)) of
    Just (_,_,Nothing) -> True             -- the encoding of data constrs
    _                  -> False

lookValCat :: PGF -> CId -> CId
lookValCat pgf = valCat . lookType pgf

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
  [(f,ty) | f <- fs, Just (ty,_,_) <- [Map.lookup f $ funs $ abstract pgf]]
 where 
   (_,fs) = lookMap ([],[]) cat $ cats $ abstract pgf

missingLins :: PGF -> CId -> [CId]
missingLins pgf lang = [c | c <- fs, not (hasl c)] where
  fs = Map.keys $ funs $ abstract pgf
  hasl = hasLin pgf lang

hasLin :: PGF -> CId -> CId -> Bool
hasLin pgf lang f = Map.member f $ lproductions $ lookConcr pgf lang

restrictPGF :: (CId -> Bool) -> PGF -> PGF
restrictPGF cond pgf = pgf {
  abstract = abstr {
    funs = Map.filterWithKey (\c _ -> cond c) (funs abstr),
    cats = Map.map (\(hyps,fs) -> (hyps,filter cond fs)) (cats abstr)
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
lookMap :: (Show i, Ord i) => a -> i -> Map.Map i a -> a 
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

_B = mkCId "__gfB"
_V = mkCId "__gfV"


-- Utilities for doing linearization

-- | BracketedString represents a sentence that is linearized
-- as usual but we also want to retain the ''brackets'' that
-- mark the beginning and the end of each constituent.
data BracketedString
  = Leaf Token                                                                -- ^ this is the leaf i.e. a single token
  | Bracket CId {-# UNPACK #-} !FId {-# UNPACK #-} !LIndex [Expr] [BracketedString]   
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
  = LeafKS [Token]
  | LeafKP [Token] [Alternative]
  | Bracket_ CId {-# UNPACK #-} !FId {-# UNPACK #-} !LIndex [Expr] [BracketedTokn]    -- Invariant: the list is not empty
  deriving Eq

type LinTable = Array.Array LIndex [BracketedTokn]

-- | Renders the bracketed string as string where 
-- the brackets are shown as @(S ...)@ where
-- @S@ is the category.
showBracketedString :: BracketedString -> String
showBracketedString = render . ppBracketedString

ppBracketedString (Leaf t) = text t
ppBracketedString (Bracket cat fcat index _ bss) = parens (ppCId cat <+> hsep (map ppBracketedString bss))

-- | The length of the bracketed string in number of tokens.
lengthBracketedString :: BracketedString -> Int
lengthBracketedString (Leaf _)              = 1
lengthBracketedString (Bracket _ _ _ _ bss) = sum (map lengthBracketedString bss)

untokn :: String -> BracketedTokn -> (String,[BracketedString])
untokn nw (LeafKS ts)   = (head ts,map Leaf ts)
untokn nw (LeafKP d vs) = let ts = sel d vs nw
                          in (head ts,map Leaf ts)
                          where
                            sel d vs nw =
                              case [v | Alt v cs <- vs, any (\c -> isPrefixOf c nw) cs] of
                                v:_ -> v
                                _   -> d
untokn nw (Bracket_ cat fid index es bss) =
  let (nw',bss') = mapAccumR untokn nw bss
  in (nw',[Bracket cat fid index es (concat bss')])

flattenBracketedString :: BracketedString -> [String]
flattenBracketedString (Leaf w)              = [w]
flattenBracketedString (Bracket _ _ _ _ bss) = concatMap flattenBracketedString bss
