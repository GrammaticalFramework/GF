module PGF.Linearize(linearizes,markLinearizes,tabularLinearizes) where

import PGF.CId
import PGF.Data
import PGF.Macros
import Data.Array.IArray
import Data.List
import Control.Monad
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import qualified Data.Set as Set

-- linearization and computation of concrete PGF Terms

type LinTable = Array LIndex [Tokn]

linearizes :: PGF -> CId -> Expr -> [String]
linearizes pgf lang = map (unwords . untokn . (! 0)) . linTree pgf lang (\_ _ lint -> lint)

linTree :: PGF -> Language -> (Maybe CId -> [Int] -> LinTable -> LinTable) -> Expr -> [LinTable]
linTree pgf lang mark e = lin0 [] [] [] Nothing e
  where
    cnc   = lookMap (error "no lang") lang (concretes pgf)
    lp    = lproductions cnc

    lin0 path xs ys mb_fid (EAbs _ x e)  = lin0 path (showCId x:xs) ys mb_fid e
    lin0 path xs ys mb_fid (ETyped e _)  = lin0 path xs ys mb_fid e
    lin0 path xs ys mb_fid e | null xs   = lin path ys mb_fid e []
                             | otherwise = apply path (xs ++ ys) mb_fid _B (e:[ELit (LStr x) | x <- xs])

    lin path xs mb_fid (EApp e1 e2) es = lin path xs mb_fid e1 (e2:es)
    lin path xs mb_fid (ELit l)     [] = case l of
                                           LStr s -> return (mark Nothing path (ss s))
                                           LInt n -> return (mark Nothing path (ss (show n)))
                                           LFlt f -> return (mark Nothing path (ss (show f)))
    lin path xs mb_fid (EMeta i)    es = apply path xs mb_fid _V (ELit (LStr ('?':show i)):es)
    lin path xs mb_fid (EFun f)     es = map (mark (Just f) path) (apply path xs mb_fid f  es)
    lin path xs mb_fid (EVar  i)    es = apply path xs mb_fid _V (ELit (LStr (xs !! i))   :es)
    lin path xs mb_fid (ETyped e _) es = lin path xs mb_fid e es
    lin path xs mb_fid (EImplArg e) es = lin path xs mb_fid e es

    ss s = listArray (0,0) [[KS s]]

    apply path xs mb_fid f es =
      case Map.lookup f lp of
        Just prods -> case lookupProds mb_fid prods of
                        Just set -> do prod <- Set.toList set
                                       case prod of
                                         PApply funid fids -> do guard (length fids == length es)
                                                                 args <- sequence (zipWith3 (\i fid e -> lin0 (sub i path) [] xs (Just fid) e) [0..] fids es)
                                                                 let (CncFun _ lins) = cncfuns cnc ! funid
                                                                 return (listArray (bounds lins) [computeSeq seqid args | seqid <- elems lins])
                                         PCoerce fid       -> apply path xs (Just fid) f es
                        Nothing  -> mzero
        Nothing    -> apply path xs mb_fid _V [ELit (LStr ("[" ++ showCId f ++ "]"))]  -- fun without lin
      where
        lookupProds (Just fid) prods = IntMap.lookup fid prods
        lookupProds Nothing    prods
            | f == _B || f == _V     = Nothing
            | otherwise              = Just (Set.filter isApp (Set.unions (IntMap.elems prods)))

        sub i path
          | f == _B || f == _V =   path
          | otherwise          = i:path

        isApp (PApply _ _) = True
        isApp _            = False

        computeSeq seqid args = concatMap compute (elems seq)
          where
            seq = sequences cnc ! seqid

            compute (SymCat d r)    = (args !! d) ! r
            compute (SymLit d r)    = (args !! d) ! r
            compute (SymKS ts)      = map KS ts
            compute (SymKP ts alts) = [KP ts alts]

untokn :: [Tokn] -> [String]
untokn ts = case ts of
  KP d _  : [] -> d
  KP d vs : ws -> let ss@(s:_) = untokn ws in sel d vs s ++ ss
  KS s    : ws -> s : untokn ws
  []           -> []
 where
   sel d vs w = case [v | Alt v cs <- vs, any (\c -> isPrefixOf c w) cs] of
     v:_ -> v
     _   -> d

-- create a table from labels+params to variants
tabularLinearizes :: PGF -> CId -> Expr -> [[(String,String)]]
tabularLinearizes pgf lang e = map (zip lbls . map (unwords . untokn) . elems) (linTree pgf lang (\_ _ lint -> lint) e)
  where
    lbls = case unApp e of
             Just (f,_) -> let cat = valCat (lookType pgf f)
                           in case Map.lookup cat (cnccats (lookConcr pgf lang)) of
                                Just (CncCat _ _ lbls) -> elems lbls
                                Nothing                -> error "No labels"
             Nothing    -> error "Not function application"


-- show bracketed markup with references to tree structure
markLinearizes :: PGF -> CId -> Expr -> [String]
markLinearizes pgf lang = map (unwords . untokn . (! 0)) . linTree pgf lang mark
  where
    mark mb_f path lint = amap (bracket mb_f path) lint

    bracket Nothing  path ts = [KS ("("++show (reverse path))] ++ ts ++ [KS ")"]
    bracket (Just f) path ts = [KS ("(("++showCId f++","++show (reverse path)++")")] ++ ts ++ [KS ")"]
