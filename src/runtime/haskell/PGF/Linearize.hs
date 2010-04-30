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

linTree :: PGF -> Language -> Expr -> [Array LIndex BracketedTokn]
linTree pgf lang e = 
  [amapWithIndex (\label -> Bracket_ fid label cat) lin | (_,(fid,cat,lin)) <- lin0 [] [] Nothing 0 e]
  where
    cnc   = lookMap (error "no lang") lang (concretes pgf)
    lp    = lproductions cnc
  
    lin0 xs ys mb_fid n_fid (EAbs _ x e)  = lin0 (showCId x:xs) ys mb_fid n_fid e
    lin0 xs ys mb_fid n_fid (ETyped e _)  = lin0 xs ys mb_fid n_fid e
    lin0 xs ys mb_fid n_fid e | null xs   = lin ys mb_fid n_fid e []
                              | otherwise = apply (xs ++ ys) mb_fid n_fid _B (e:[ELit (LStr x) | x <- xs])

    lin xs mb_fid n_fid (EApp e1 e2) es = lin xs mb_fid n_fid e1 (e2:es)
    lin xs mb_fid n_fid (ELit l)     [] = case l of
                                            LStr s -> return (n_fid+1,(n_fid,cidString,ss s))
                                            LInt n -> return (n_fid+1,(n_fid,cidInt   ,ss (show n)))
                                            LFlt f -> return (n_fid+1,(n_fid,cidFloat ,ss (show f)))
    lin xs mb_fid n_fid (EMeta i)    es = apply xs mb_fid n_fid _V (ELit (LStr ('?':show i)):es)
    lin xs mb_fid n_fid (EFun f)     es = apply xs mb_fid n_fid f  es
    lin xs mb_fid n_fid (EVar  i)    es = apply xs mb_fid n_fid _V (ELit (LStr (xs !! i))   :es)
    lin xs mb_fid n_fid (ETyped e _) es = lin xs mb_fid n_fid e es
    lin xs mb_fid n_fid (EImplArg e) es = lin xs mb_fid n_fid e es

    ss s = listArray (0,0) [[LeafKS [s]]]

    apply :: [String] -> Maybe FId -> FId -> CId -> [Expr] -> [(FId,(FId, CId, LinTable))]
    apply xs mb_fid n_fid f es =
      case Map.lookup f lp of
        Just prods -> do prod <- lookupProds mb_fid prods
                         case prod of
                           PApply funid fids -> do guard (length fids == length es)
                                                   (n_fid,args) <- descend n_fid (zip fids es)
                                                   let (CncFun fun lins) = cncfuns cnc ! funid
                                                       Just (DTyp _ cat _,_,_) = Map.lookup fun (funs (abstract pgf))
                                                   return (n_fid+1,(n_fid,cat,listArray (bounds lins) [computeSeq seqid args | seqid <- elems lins]))
                           PCoerce fid       -> apply xs (Just fid) n_fid f es
        Nothing    -> apply xs mb_fid n_fid _V [ELit (LStr ("[" ++ showCId f ++ "]"))]  -- fun without lin
      where
        lookupProds (Just fid) prods = maybe [] Set.toList (IntMap.lookup fid prods)
        lookupProds Nothing    prods
          | f == _B || f == _V       = []
          | otherwise                = [prod | (fid,set) <- IntMap.toList prods, prod <- Set.toList set]

        descend n_fid []            = return (n_fid,[])
        descend n_fid ((fid,e):fes) = do (n_fid,xx) <- lin0 [] xs (Just fid) n_fid e
                                         (n_fid,xxs) <- descend n_fid fes
                                         return (n_fid,xx:xxs)

        isApp (PApply _ _) = True
        isApp _            = False

        computeSeq :: SeqId -> [(FId,CId,LinTable)] -> [BracketedTokn]
        computeSeq seqid args = concatMap compute (elems seq)
          where
            seq = sequences cnc ! seqid

            compute (SymCat d r)    = getArg d r
            compute (SymLit d r)    = getArg d r
            compute (SymKS ts)      = [LeafKS ts]
            compute (SymKP ts alts) = [LeafKP ts alts]

            getArg d r
              | not (null arg_lin) = [Bracket_ fid r cat arg_lin]
              | otherwise          = arg_lin
              where
                arg_lin       = lin ! r
                (fid,cat,lin) = args !! d

amapWithIndex :: (IArray a e1, IArray a e2, Ix i) => (i -> e1 -> e2) -> a i e1 -> a i e2
amapWithIndex f arr = listArray (bounds arr) (map (uncurry f) (assocs arr))
