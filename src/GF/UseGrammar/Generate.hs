----------------------------------------------------------------------
-- |
-- Module      : Generate
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/12 12:38:30 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.16 $
--
-- Generate all trees of given category and depth. AR 30\/4\/2004
--
-- (c) Aarne Ranta 2004 under GNU GPL
--
-- Purpose: to generate corpora. We use simple types and don't
-- guarantee the correctness of bindings\/dependences.
-----------------------------------------------------------------------------

module GF.UseGrammar.Generate (generateTrees,generateAll) where

import GF.Canon.GFC
import GF.Grammar.LookAbs
import GF.Grammar.PrGrammar
import GF.Grammar.Macros
import GF.Grammar.Values
import GF.Grammar.Grammar (Cat)
import GF.Grammar.SGrammar
import GF.Data.Operations
import GF.Data.Zipper
import GF.Infra.Option
import Data.List

-- Generate all trees of given category and depth. AR 30/4/2004
-- (c) Aarne Ranta 2004 under GNU GPL
--
-- Purpose: to generate corpora. We use simple types and don't
-- guarantee the correctness of bindings/dependences.


-- | the main function takes an abstract syntax and returns a list of trees
generateTrees :: Options -> GFCGrammar -> Cat -> Int -> Maybe Int -> Maybe Tree -> [Exp]
generateTrees opts gr cat n mn mt = map str2tr $ generate gr' ifm cat' n mn mt'
  where
    gr'  = gr2sgr opts emptyProbs gr
    cat' = prt $ snd cat
    mt'  = maybe Nothing (return . tr2str) mt
    ifm  = oElem withMetas opts

generateAll :: Options -> (Exp -> IO ()) -> GFCGrammar -> Cat -> IO ()
generateAll opts io gr cat = mapM_ (io . str2tr) $ gen cat'
  where
    gr'  = gr2sgr opts emptyProbs gr
    cat' = prt $ snd cat
    gen c = [SApp (f, xs) | 
      (f,(cs,_)) <- funs c, 
      xs <- combinations (map gen cs)
      ]
    funs c = errVal [] $ lookupTree id c gr'



------------------------------------------
-- do the main thing with a simpler data structure
-- the first Int gives tree depth, the second constrains subtrees
-- chosen for each branch. A small number, such as 2, is a good choice
-- if the depth is large (more than 3)
-- If a tree is given as argument, generation concerns its metavariables.

generate :: SGrammar -> Bool -> SCat -> Int -> Maybe Int -> Maybe STree -> [STree]
generate gr ifm cat i mn mt = case mt of
  Nothing -> gen cat
  Just t  -> genM t
 where

  gen cat = concat $ errVal [] $ lookupTree id cat $ allTrees

  allTrees = genAll i

  -- dynamic generation
  genAll :: Int -> BinTree SCat [[STree]]
  genAll i = iter i genNext (mapTree (\ (c,_) -> (c,[[]])) gr)

  iter 0 f tr = tr
  iter n f tr = iter (n-1) f (f tr)

  genNext tr = mapTree (genNew tr) tr

  genNew tr (cat,ts) = let size = length ts in
    (cat, [SApp (f, xs) | 
            (f,(cs,_)) <- funs cat, 
            xs <- combinations (map look cs),
            let fxs = SApp (f, xs),
            depth fxs == size]
         : ts)
   where
     look c = concat $ errVal [] $ lookupTree id c tr

  funs cat = maybe id take mn $ errVal [] $ lookupTree id cat gr

  genM t = case t of
    SApp (f,ts) -> [SApp (f,ts') | ts' <- combinations (map genM ts)]
    SMeta k     -> gen k 
    _ -> [t]
