module PGF.Linearize
            ( linearize
            , linearizeAll
            , linearizeAllLang
            , bracketedLinearize
            , tabularLinearizes
            ) where

import PGF.CId
import PGF.Data
import PGF.Macros
import PGF.Expr
import Data.Array.IArray
import Data.List
import Control.Monad
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import qualified Data.Set as Set

--------------------------------------------------------------------
-- The API
--------------------------------------------------------------------

-- | Linearizes given expression as string in the language
linearize :: PGF -> Language -> Tree -> String
linearize pgf lang = concat . take 1 . map (unwords . concatMap flattenBracketedString . snd . untokn "" . (!0)) . linTree pgf lang

-- | The same as 'linearizeAllLang' but does not return
-- the language.
linearizeAll :: PGF -> Tree -> [String]
linearizeAll pgf = map snd . linearizeAllLang pgf

-- | Linearizes given expression as string in all languages
-- available in the grammar.
linearizeAllLang :: PGF -> Tree -> [(Language,String)]
linearizeAllLang pgf t = [(lang,linearize pgf lang t) | lang <- Map.keys (concretes pgf)]

-- | Linearizes given expression as a bracketed string in the language
bracketedLinearize :: PGF -> Language -> Tree -> BracketedString
bracketedLinearize pgf lang = head . concat . map (snd . untokn "" . (!0)) . linTree pgf lang
  where
    head []       = error "cannot linearize"
    head (bs:bss) = bs

-- | Creates a table from feature name to linearization. 
-- The outher list encodes the variations
tabularLinearizes :: PGF -> CId -> Expr -> [[(String,String)]]
tabularLinearizes pgf lang e = map (zip lbls . map (unwords . concatMap flattenBracketedString . snd . untokn "") . elems)
                                   (linTree pgf lang e)
  where
    lbls = case unApp e of
             Just (f,_) -> let cat = valCat (lookType pgf f)
                           in case Map.lookup cat (cnccats (lookConcr pgf lang)) of
                                Just (CncCat _ _ lbls) -> elems lbls
                                Nothing                -> error "No labels"
             Nothing    -> error "Not function application"

--------------------------------------------------------------------
-- Implementation
--------------------------------------------------------------------

type CncType = (CId, FId)    -- concrete type is the abstract type (the category) + the forest id

linTree :: PGF -> Language -> Expr -> [Array LIndex BracketedTokn]
linTree pgf lang e = 
  [amapWithIndex (\label -> Bracket_ cat fid label [e]) lin | (_,((cat,fid),e,lin)) <- lin0 [] [] Nothing 0 e e]
  where
    cnc   = lookMap (error "no lang") lang (concretes pgf)
    lp    = lproductions cnc
  
    lin0 xs ys mb_cty n_fid e0 (EAbs _ x e)  = lin0 (showCId x:xs) ys mb_cty n_fid e0 e
    lin0 xs ys mb_cty n_fid e0 (ETyped e _)  = lin0 xs ys mb_cty n_fid e0 e
    lin0 xs ys mb_cty n_fid e0 e | null xs   = lin ys mb_cty n_fid e0 e []
                                 | otherwise = apply (xs ++ ys) mb_cty n_fid e0 _B (e:[ELit (LStr x) | x <- xs])

    lin xs mb_cty n_fid e0 (EApp e1 e2) es = lin xs mb_cty n_fid e0 e1 (e2:es)
    lin xs mb_cty n_fid e0 (ELit l)     [] = case l of
                                               LStr s -> return (n_fid+1,((cidString,n_fid),e0,ss s))
                                               LInt n -> return (n_fid+1,((cidInt,   n_fid),e0,ss (show n)))
                                               LFlt f -> return (n_fid+1,((cidFloat, n_fid),e0,ss (show f)))
    lin xs mb_cty n_fid e0 (EMeta i)    es = apply xs mb_cty n_fid e0 _V (ELit (LStr ('?':show i)):es)
    lin xs mb_cty n_fid e0 (EFun f)     es = apply xs mb_cty n_fid e0 f  es
    lin xs mb_cty n_fid e0 (EVar  i)    es = apply xs mb_cty n_fid e0 _V (ELit (LStr (xs !! i))   :es)
    lin xs mb_cty n_fid e0 (ETyped e _) es = lin xs mb_cty n_fid e0 e es
    lin xs mb_cty n_fid e0 (EImplArg e) es = lin xs mb_cty n_fid e0 e es

    ss s = listArray (0,0) [[LeafKS [s]]]

    apply :: [String] -> Maybe CncType -> FId -> Expr -> CId -> [Expr] -> [(FId,(CncType, Expr, LinTable))]
    apply xs mb_cty n_fid e0 f es =
      case Map.lookup f lp of
        Just prods -> do (funid,(cat,fid),ctys) <- getApps prods
                         guard (length ctys == length es)
                         (n_fid,args) <- descend n_fid (zip ctys es)
                         let (CncFun _ lins) = cncfuns cnc ! funid
                         return (n_fid+1,((cat,n_fid),e0,listArray (bounds lins) [computeSeq seqid args | seqid <- elems lins]))
        Nothing    -> apply xs mb_cty n_fid e0 _V [ELit (LStr ("[" ++ showCId f ++ "]"))]  -- fun without lin
      where
        getApps prods =
          case mb_cty of
            Just cty@(cat,fid)  -> maybe [] (concatMap (toApp cty) . Set.toList) (IntMap.lookup fid prods)
            Nothing |  f == _B
                    || f == _V  -> []
                    | otherwise -> concat [toApp (wildCId,fid) prod | (fid,set) <- IntMap.toList prods, prod <- Set.toList set]
          where
            toApp cty (PApply funid fids)
              | f == _V          = [(funid,cty,zip (          repeat cidVar) fids)]
              | f == _B          = [(funid,cty,zip (fst cty : repeat cidVar) fids)]
              | otherwise        = let Just (ty,_,_) = Map.lookup f (funs (abstract pgf))
                                       (args,res) = catSkeleton ty
                                   in [(funid,(res,snd cty),zip args fids)]
            toApp cty (PCoerce fid) = concatMap (toApp cty) (maybe [] Set.toList (IntMap.lookup fid prods))

        descend n_fid []                  = return (n_fid,[])
        descend n_fid (((cat,fid),e):fes) = do (n_fid,arg)  <- lin0 [] xs (Just (cat,fid)) n_fid e e
                                               (n_fid,args) <- descend n_fid fes
                                               return (n_fid,arg:args)

        computeSeq :: SeqId -> [(CncType,Expr,LinTable)] -> [BracketedTokn]
        computeSeq seqid args = concatMap compute (elems seq)
          where
            seq = sequences cnc ! seqid

            compute (SymCat d r)    = getArg d r
            compute (SymLit d r)    = getArg d r
            compute (SymKS ts)      = [LeafKS ts]
            compute (SymKP ts alts) = [LeafKP ts alts]

            getArg d r
              | not (null arg_lin) = [Bracket_ cat fid r [e] arg_lin]
              | otherwise          = arg_lin
              where
                arg_lin           = lin ! r
                ((cat,fid),e,lin) = args !! d

amapWithIndex :: (IArray a e1, IArray a e2, Ix i) => (i -> e1 -> e2) -> a i e1 -> a i e2
amapWithIndex f arr = listArray (bounds arr) (map (uncurry f) (assocs arr))
