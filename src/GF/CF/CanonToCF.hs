----------------------------------------------------------------------
-- |
-- Module      : CanonToCF
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/31 12:47:52 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.14 $
--
-- AR 27\/1\/2000 -- 3\/12\/2001 -- 8\/6\/2003 
-----------------------------------------------------------------------------

module GF.CF.CanonToCF (canon2cf) where

import GF.System.Tracing -- peb 8/6-04

import GF.Data.Operations
import GF.Infra.Option
import GF.Infra.Ident
import GF.Canon.AbsGFC
import GF.Grammar.LookAbs (allBindCatsOf)
import GF.Canon.GFC
import GF.Grammar.Values (isPredefCat,cPredefAbs)
import GF.Grammar.PrGrammar
import GF.Canon.CMacros
import qualified GF.Infra.Modules as M
import GF.CF.CF
import GF.CF.CFIdent
import GF.UseGrammar.Morphology
import GF.Data.Trie2
import Data.List (nub,partition)
import Control.Monad

-- | The main function: for a given cnc module 'm', build the CF grammar with all the
-- rules coming from modules that 'm' extends. The categories are qualified by
-- the abstract module name 'a' that 'm' is of.
canon2cf :: Options -> CanonGrammar -> Ident -> Err CF
canon2cf opts gr c = tracePrt "#size of CF" (err id (show.length.rulesOfCF)) $ do -- peb 8/6-04
  let ms = M.allExtends gr c
  a <- M.abstractOfConcrete gr c
  let cncs = [m | (n, M.ModMod m) <- M.modules gr, elem n ms]
  let mms  = [(a, tree2list (M.jments m)) | m <- cncs]
  cnc <- liftM M.jments $ M.lookupModMod gr c
  rules0 <- liftM concat $ mapM (uncurry (cnc2cfCond opts cnc)) mms
  let bindcats = map snd $ allBindCatsOf gr 
  let rules = filter (not . isCircularCF) rules0 ---- temporarily here
  let grules = groupCFRules rules
  let predef = mkCFPredef opts bindcats grules
  return $ CF predef

cnc2cfCond :: Options -> BinTree Ident Info -> 
              Ident -> [(Ident,Info)] -> Err [CFRule]
cnc2cfCond opts cnc m gr = 
  liftM concat $ 
  mapM lin2cf [(m,fun,cat,args,lin) | 
                 (fun, CncFun cat args lin _) <- gr, is fun] 
 where
   is f = isInBinTree f cnc

type IFun = Ident
type ICat = CIdent

-- | all CF rules corresponding to a linearization rule
lin2cf :: (Ident, IFun, ICat, [ArgVar], Term) -> Err [CFRule]
lin2cf (m,fun,cat,args,lin) = errIn ("building CF rule for" +++ prt fun) $ do
  rhss0  <- allLinValues lin                   -- :: [(Label, [([Patt],Term)])]
  rhss1  <- mapM (mkCFItems m) (concat rhss0)  -- :: [(Label, [[PreCFItem]])]
  mapM (mkCfRules m fun cat args) rhss1 >>= return . nub . concat

-- | making sequences of CF items from every branch in a linearization
mkCFItems :: Ident -> (Label, [([Patt],Term)]) -> Err (Label, [[PreCFItem]])
mkCFItems m (lab,pts) = do
  itemss <- mapM (term2CFItems m) (map snd pts)
  return (lab, concat itemss) ---- combinations? (test!)

-- | making CF rules from sequences of CF items
mkCfRules :: Ident -> IFun -> ICat -> [ArgVar] -> (Label, [[PreCFItem]]) -> Err [CFRule]
mkCfRules m fun cat args (lab, itss) = mapM mkOneRule itss
 where
  mkOneRule its = do
    let nonterms = zip [0..] [(pos,d,v) | PNonterm _ pos d v <- its]
        profile  = mkProfile nonterms
	cfcat    = CFCat (redirectIdent m cat,lab)
        cffun    = CFFun (AC (CIQ m fun), profile)
        cfits    = map precf2cf its
    return (cffun,(cfcat,cfits))
  mkProfile nonterms = map mkOne args 
    where
      mkOne (A  c i) = mkOne (AB c 0 i)
      mkOne (AB _ b i) = (map mkB [0..b-1], [k | (k,(j,_,True)) <- nonterms, j==i])
        where
          mkB x = [k | (k,(j, LV y,False)) <- nonterms, j == i, y == x]

-- | intermediate data structure of CFItems with information for profiles
data PreCFItem = 
    PTerm RegExp                       -- ^ like ordinary Terminal 
  | PNonterm CIdent Integer Label Bool -- ^ cat, position, part\/bind, whether arg
   deriving Eq                    

precf2cf :: PreCFItem -> CFItem
precf2cf (PTerm r) = CFTerm r
precf2cf (PNonterm cm _ (L c) True) = CFNonterm (ident2CFCat cm c)
precf2cf (PNonterm _ _ _ False) = CFNonterm catVarCF


-- | the main job in translating linearization rules into sequences of cf items 
term2CFItems :: Ident -> Term -> Err [[PreCFItem]]
term2CFItems m t = errIn "forming cf items" $ case t of
   S c _ -> t2c c

   T _ cc -> do
     its  <- mapM t2c [t | Cas _ t <- cc]
     tryMkCFTerm (concat its)
   V _ cc -> do
     its  <- mapM t2c [t | t <- cc]
     tryMkCFTerm (concat its)

   C t1 t2 -> do
     its1 <- t2c t1
     its2 <- t2c t2
     return [x ++ y | x <- its1, y <- its2]

   FV ts -> do
     its <- mapM t2c ts
     tryMkCFTerm (concat its)

   P arg s -> extrR arg s

   K (KS s) -> return [[PTerm (RegAlts [s]) | not (null s)]]

   E -> return [[]]

   K (KP d vs) -> do
     let its  =  [PTerm (RegAlts [s]) | s <- d]
     let itss = [[PTerm (RegAlts [s]) | s <- t] | Var t _ <- vs]
     tryMkCFTerm (its : itss)

   _ -> prtBad "no cf for" t ----

  where 

    t2c = term2CFItems m

    -- optimize the number of rules by a factorization
    tryMkCFTerm :: [[PreCFItem]] -> Err [[PreCFItem]]  
    tryMkCFTerm ii@(its:itss) | all (\x -> length x == length its) itss =
      case mapM mkOne (counterparts ii) of
        Ok tt -> return [tt]
        _ -> return ii
       where
         mkOne cfits = case mapM mkOneTerm cfits of
           Ok tt -> return $ PTerm (RegAlts (concat (nub tt)))
           _ -> mkOneNonTerm cfits
         mkOneTerm (PTerm (RegAlts t)) = return t
         mkOneTerm _ = Bad ""
         mkOneNonTerm (n@(PNonterm _ _ _ _) : cc) = 
           if all (== n) cc 
	      then return n
	      else Bad ""
         mkOneNonTerm _ = Bad ""
         counterparts ll = [map (!! i) ll | i <- [0..length (head ll) - 1]]
    tryMkCFTerm itss = return itss

    extrR arg lab = case (arg,lab) of
      (Arg (A  cat pos),   l@(L _))  -> return [[PNonterm (cIQ cat) pos l True]]
      (Arg (A  cat pos),   l@(LV _)) -> return [[PNonterm (cIQ cat) pos l False]]
      (Arg (AB cat b pos), l@(L _))  -> return [[PNonterm (cIQ cat) pos l True]]
      (Arg (AB cat b pos), l@(LV _)) -> return [[PNonterm (cIQ cat) pos l False]]
                                     ---- ??
      _   -> prtBad "cannot extract record field from" arg
    cIQ c = if isPredefCat c then CIQ cPredefAbs c else CIQ m c

mkCFPredef :: Options -> [Ident] -> [CFRuleGroup] -> ([CFRuleGroup],CFPredef)
mkCFPredef opts binds rules = (ruls, \s -> preds0 s ++ look s) where
  (ruls,preds) = if oElem lexerByNeed opts  -- option -cflexer
                   then predefLexer rules 
                   else (rules,emptyTrie)
  preds0 s = 
    [(cat,         metaCFFun)     | TM _ _ <- [s], cat <- cats] ++
    [(cat,         varCFFun x)    | TV x   <- [s], cat <- catVarCF : bindcats] ++
    [(cfCatString, stringCFFun t) | TL t   <- [s]]              ++
    [(cfCatInt,    intCFFun t)    | TI t   <- [s]]
  cats = nub [c | (_,rs) <- rules, (_,(_,its)) <- rs, CFNonterm c <- its]
  bindcats = [c | c <- cats, elem (cfCat2Ident c) binds]
  look = concatMap snd . map (trieLookup preds) . wordsCFTok --- for TC tokens

--- TODO: integrate with morphology
--- predefLexer :: [CFRuleGroup] -> ([CFRuleGroup],BinTree (CFTok,[(CFCat, CFFun)]))
predefLexer groups = (reverse ruls, tcompile preds) where
  (ruls,preds) = foldr mkOne ([],[]) groups
  mkOne group@(cat,rules) (rs,ps) = (rule:rs,pre ++ ps) where
    (rule,pre) = case partition isLexical rules of
      ([],_) -> (group,[])
      (ls,rest) -> ((cat,rest), concatMap mkLexRule ls)
  isLexical (f,(c,its)) = case its of
    [CFTerm (RegAlts ws)] -> True
    _ -> False
  mkLexRule r = case r of
    (fun,(cat,[CFTerm (RegAlts ws)])) -> [(w, [(cat,fun)]) | w <- ws]
    _ -> []
