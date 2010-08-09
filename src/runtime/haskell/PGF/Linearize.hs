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
linearize pgf lang = concat . take 1 . map (unwords . concatMap flattenBracketedString . snd . untokn "" . firstLin) . linTree pgf lang

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
bracketedLinearize pgf lang = head . concat . map (snd . untokn "" . firstLin) . linTree pgf lang
  where
    head []       = error "cannot linearize"
    head (bs:bss) = bs

firstLin (_,arr)
  | inRange (bounds arr) 0 = arr ! 0
  | otherwise              = LeafKS []

-- | Creates a table from feature name to linearization. 
-- The outher list encodes the variations
tabularLinearizes :: PGF -> CId -> Expr -> [[(String,String)]]
tabularLinearizes pgf lang e = map cnv (linTree pgf lang e)
  where
    cnv ((cat,_),lin) = zip (lbls cat) $ map (unwords . concatMap flattenBracketedString . snd . untokn "") (elems lin)

    lbls cat = case Map.lookup cat (cnccats (lookConcr pgf lang)) of
                 Just (CncCat _ _ lbls) -> elems lbls
                 Nothing                -> error "No labels"

--------------------------------------------------------------------
-- Implementation
--------------------------------------------------------------------

linTree :: PGF -> Language -> Expr -> [(CncType, Array LIndex BracketedTokn)]
linTree pgf lang e = 
  nub [(ct,amapWithIndex (\label -> Bracket_ cat fid label es) lin) | (_,(ct@(cat,fid),es,(xs,lin))) <- lin Nothing 0 e [] [] e []]
  where
    cnc   = lookMap (error "no lang") lang (concretes pgf)
    lp    = lproductions cnc

    lin mb_cty n_fid e0 ys xs (EAbs _ x e) es = lin   mb_cty n_fid e0 ys (x:xs) e      es
    lin mb_cty n_fid e0 ys xs (EApp e1 e2) es = lin   mb_cty n_fid e0 ys    xs  e1 (e2:es)
    lin mb_cty n_fid e0 ys xs (EImplArg e) es = lin   mb_cty n_fid e0 ys    xs  e      es
    lin mb_cty n_fid e0 ys xs (ETyped e _) es = lin   mb_cty n_fid e0 ys    xs  e      es
    lin mb_cty n_fid e0 ys xs (EFun f)     es = apply mb_cty n_fid e0 ys    xs  f      es
    lin mb_cty n_fid e0 ys xs (EMeta i)    es = def   mb_cty n_fid e0 ys    xs  ('?':show i)
    lin mb_cty n_fid e0 ys xs (EVar  i)    [] = def   mb_cty n_fid e0 ys    xs  (showCId ((xs++ys) !! i))
    lin mb_cty n_fid e0 ys xs (ELit l)     [] = case l of
                                                   LStr s -> return (n_fid+1,((cidString,n_fid),[e0],([],ss s)))
                                                   LInt n -> return (n_fid+1,((cidInt,   n_fid),[e0],([],ss (show n))))
                                                   LFlt f -> return (n_fid+1,((cidFloat, n_fid),[e0],([],ss (show f))))

    ss s = listArray (0,0) [[LeafKS [s]]]

    apply :: Maybe CncType -> FId -> Expr -> [CId] -> [CId] -> CId -> [Expr] -> [(FId,(CncType, [Expr], LinTable))]
    apply mb_cty n_fid e0 ys xs f es =
      case Map.lookup f lp of
        Just prods -> do (funid,(cat,fid),ctys) <- getApps prods
                         (n_fid,args) <- descend n_fid (zip ctys es)
                         return (n_fid+1,((cat,n_fid),[e0],mkLinTable cnc (const True) xs funid args))
        Nothing    -> def mb_cty n_fid e0 ys xs ("[" ++ showCId f ++ "]")  -- fun without lin
      where
        getApps prods =
          case mb_cty of
            Just (cat,fid) -> maybe [] (concatMap (toApp fid) . Set.toList) (IntMap.lookup fid prods)
            Nothing        -> concat [toApp fid prod | (fid,set) <- IntMap.toList prods, prod <- Set.toList set]
          where
            toApp fid (PApply funid pargs) =
              let Just (ty,_,_) = Map.lookup f (funs (abstract pgf))
                  (args,res) = catSkeleton ty
              in [(funid,(res,fid),zip args [fid | PArg _ fid <- pargs])]
            toApp _   (PCoerce fid) = 
              maybe [] (concatMap (toApp fid) . Set.toList) (IntMap.lookup fid prods)

        descend n_fid []            = return (n_fid,[])
        descend n_fid ((cty,e):fes) = do (n_fid,arg)  <- lin (Just cty) n_fid e (xs++ys) [] e []
                                         (n_fid,args) <- descend n_fid fes
                                         return (n_fid,arg:args)

    def (Just (cat,fid)) n_fid e0 ys xs s =
      case IntMap.lookup fid (lindefs cnc) of
        Just funs           -> do funid <- funs
                                  let args = [((wildCId, n_fid),[e0],([],ss s))]
                                  return (n_fid+2,((cat,n_fid+1),[e0],mkLinTable cnc (const True) xs funid args))
        Nothing
          | isPredefFId fid -> return (n_fid+2,((cat,n_fid+1),[e0],(xs,listArray (0,0) [[LeafKS [s]]])))
          | otherwise       -> do PCoerce fid <- maybe [] Set.toList (IntMap.lookup fid (pproductions cnc))
                                  def (Just (cat,fid)) n_fid e0 ys xs s
    def Nothing          n_fid e0 ys xs s = []

amapWithIndex :: (IArray a e1, IArray a e2, Ix i) => (i -> e1 -> e2) -> a i e1 -> a i e2
amapWithIndex f arr = listArray (bounds arr) (map (uncurry f) (assocs arr))
