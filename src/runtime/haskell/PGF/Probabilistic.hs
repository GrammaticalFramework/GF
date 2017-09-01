module PGF.Probabilistic
         ( Probabilities(..)
         , mkProbabilities                 -- :: PGF -> M.Map CId Double -> Probabilities
         , defaultProbabilities            -- :: PGF -> Probabilities
         , getProbabilities
         , setProbabilities
         , showProbabilities               -- :: Probabilities -> String
         , readProbabilitiesFromFile       -- :: FilePath -> PGF -> IO Probabilities

         , probTree
         , rankTreesByProbs
         , mkProbDefs
         ) where

import PGF.CId
import PGF.Data
import PGF.Macros

import qualified Data.Map as Map
import Data.List (sortBy,partition,nub,mapAccumL)
import Data.Maybe (fromMaybe) --, fromJust

-- | An abstract data structure which represents
-- the probabilities for the different functions in a grammar.
data Probabilities = Probs {
  funProbs :: Map.Map CId Double,
  catProbs :: Map.Map CId (Double, [(Double, CId)])
  }

-- | Renders the probability structure as string
showProbabilities :: Probabilities -> String
showProbabilities = unlines . concatMap prProb . Map.toList . catProbs where
  prProb (c,(p,fns)) = pr (p,c) : map pr fns
  pr (p,f) = showCId f ++ "\t" ++ show p

-- | Reads the probabilities from a file.
-- This should be a text file where on every line
-- there is a function name followed by a real number.
-- The number represents the probability mass allocated for that function.
-- The function name and the probability should be separated by a whitespace.
readProbabilitiesFromFile :: FilePath -> PGF -> IO Probabilities
readProbabilitiesFromFile file pgf = do
  s <- readFile file
  let ps0 = Map.fromList [(mkCId f,read p) | f:p:_ <- map words (lines s)]
  return $ mkProbabilities pgf ps0

-- | Builds probability tables. The second argument is a map
-- which contains the know probabilities. If some function is
-- not in the map then it gets assigned some probability based
-- on the even distribution of the unallocated probability mass
-- for the result category.
mkProbabilities :: PGF -> Map.Map CId Double -> Probabilities
mkProbabilities pgf probs =
  let funs1 = Map.fromList [(f,p) | (_,(_,fns)) <- Map.toList cats1, (p,f) <- fns]
      cats1 = Map.mapWithKey (\c (_,fns,_) -> 
                                 let p'   = fromMaybe 0 (Map.lookup c probs)
                                     fns' = sortBy cmpProb (fill fns)
                                 in (p', fns'))
                             (cats (abstract pgf))
  in Probs funs1 cats1
  where
    cmpProb (p1,_) (p2,_) = compare p2 p1

    fill fs = pad [(Map.lookup f probs,f) | (_,f) <- fs]
      where
        pad :: [(Maybe Double,a)] -> [(Double,a)]
        pad pfs = [(fromMaybe deflt mb_p,f) | (mb_p,f) <- pfs]
          where
            deflt = case length [f | (Nothing,f) <- pfs] of
                      0 -> 0
                      n -> max 0 ((1 - sum [d | (Just d,f) <- pfs]) / fromIntegral n)

-- | Returns the default even distibution.
defaultProbabilities :: PGF -> Probabilities
defaultProbabilities pgf = mkProbabilities pgf Map.empty

getProbabilities :: PGF -> Probabilities
getProbabilities pgf = Probs {
  funProbs = Map.map (\(_,_,_,p) -> p      ) (funs (abstract pgf)),
  catProbs = Map.map (\(_,fns,p) -> (p,fns)) (cats (abstract pgf))
  }

setProbabilities :: Probabilities -> PGF -> PGF
setProbabilities probs pgf = pgf {
  abstract = (abstract pgf) {
    funs = mapUnionWith (\(ty,a,df,_) p       -> (ty,a,df,  p)) (funs (abstract pgf)) (funProbs probs),
    cats = mapUnionWith (\(hypos,_,_) (p,fns) -> (hypos,fns,p)) (cats (abstract pgf)) (catProbs probs)
  }}
  where
    mapUnionWith f map1 map2 = 
      Map.mapWithKey (\k v -> maybe v (f v) (Map.lookup k map2)) map1

-- | compute the probability of a given tree
probTree :: PGF -> Expr -> Double
probTree pgf t = case t of
  EApp f e -> probTree pgf f * probTree pgf e
  EFun f   -> case Map.lookup f (funs (abstract pgf)) of
                Just (_,_,_,p) -> p
                Nothing        -> 1
  _ -> 1

-- | rank from highest to lowest probability
rankTreesByProbs :: PGF -> [Expr] -> [(Expr,Double)]
rankTreesByProbs pgf ts = sortBy (\ (_,p) (_,q) -> compare q p) 
  [(t, probTree pgf t) | t <- ts]


mkProbDefs :: PGF -> ([[CId]],[(CId,Type,[Equation])])
mkProbDefs pgf =
  let cs = [(c,hyps,fns) | (c,(hyps0,fs,_)) <- Map.toList (cats (abstract pgf)),
                           not (elem c [cidString,cidInt,cidFloat]),
                           let hyps = zipWith (\(bt,_,ty) n -> (bt,mkCId ('v':show n),ty))
                                              hyps0
                                              [1..]
                               fns  = [(f,ty) | (_,f) <- fs, 
                                               let Just (ty,_,_,_) = Map.lookup f (funs (abstract pgf))]
           ]
      ((_,css),eqss) = mapAccumL (\(ngen,css) (c,hyps,fns) -> 
              let st0      = (1,Map.empty)
                  ((_,eqs_map),cs) = computeConstrs pgf st0 [(fn,[],es) | (fn,(DTyp _ _ es)) <- fns]
                  (ngen', eqs) = mapAccumL (mkEquation eqs_map hyps) ngen fns
                  ceqs     = [(id,DTyp [] cidFloat [],reverse eqs) | (id,eqs) <- Map.toList eqs_map, not (null eqs)]
              in ((ngen',cs:css),(p_f c, mkType c hyps, eqs):ceqs)) (1,[]) cs
  in (reverse (concat css),concat eqss)
  where
    mkEImplArg bt e
      | bt == Explicit = e
      | otherwise      = EImplArg e
      
    mkPImplArg bt p
      | bt == Explicit = p
      | otherwise      = PImplArg p

    mkType c hyps =
      DTyp (hyps++[mkHypo (DTyp [] c es)]) cidFloat []
      where
        is = reverse [0..length hyps-1]
        es = [mkEImplArg bt (EVar i) | (i,(bt,_,_)) <- zip is hyps]

    sig = (funs (abstract pgf), \_ -> Nothing)
    
    mkEquation ceqs hyps ngen (fn,ty@(DTyp args _ es)) =
      let fs1         = case Map.lookup (p_f fn) ceqs of
                          Nothing              -> [mkApp (k_f fn) (map (\(i,_) -> EVar (k-i-1)) vs1)]
                          Just eqs | null eqs  -> []
                                   | otherwise -> [mkApp (p_f fn) (map (\(i,_) -> EVar (k-i-1)) vs1)]
          (ngen',fs2) = mapAccumL mkFactor2 ngen vs2
          fs3         = map mkFactor3 vs3
          eq = Equ (map mkTildeP xes++[PApp fn (zipWith mkArgP [1..] args)])
                   (mkMult (fs1++fs2++fs3))
      in (ngen',eq)
      where
        xes = map (normalForm sig k env) es

        mkTildeP e =
          case e of
            EImplArg e -> PImplArg (PTilde e)
            e          ->           PTilde e

        mkArgP n (bt,_,_) = mkPImplArg bt (PVar (mkCId ('v':show n)))

        mkMult []  = ELit (LFlt 1)
        mkMult [e] = e
        mkMult es  = mkApp (mkCId "mult") es

        mkFactor2 ngen (src,dst) =
          let vs = [EVar (k-i-1) | (i,ty) <- src]
          in (ngen+1,mkApp (p_i ngen) vs)

        mkFactor3 (i,DTyp _ c es) =
          let v = EVar (k-i-1)
          in mkApp (p_f c) (map (normalForm sig k env) es++[v])

        (k,env,vs1,vs2,vs3) = mkDeps ty

        mkDeps (DTyp args _ es) =
          let (k,env,dep1) = updateArgs 0 [] [] args
              dep2         = foldl (update k env) dep1 es
              (vs2,vs3)    = closure k dep2 [] []
              vs1          = concat [src | (src,dst) <- dep2, elem k dst]
          in (k,map (\k -> VGen k []) env,vs1,reverse vs2,vs3)
          where
            updateArgs k env dep []                              = (k,env,dep)
            updateArgs k env dep ((_,x,ty@(DTyp _ _ es)) : args) =
              let dep1 = foldl (update k env) dep es ++ [([(k,ty)],[])]
                  env1 | x == wildCId =     env
                       | otherwise    = k : env
              in updateArgs (k+1) env1 dep1 args

            update k env dep e =
              case e of
                EApp e1 e2 -> update k env (update k env dep e1) e2
                EFun _     -> dep
                EVar i     -> let (dep1,(src,dst):dep2) = splitAt (env !! i) dep
                              in dep1++(src,k:dst):dep2

            closure k []               vs2 vs3 = (vs2,vs3)
            closure k ((src,dst):deps) vs2 vs3
              | null dst   = closure k deps vs2 (vs3++src)
              | otherwise  =
                  let (deps1,deps2) = partition (\(src',dst') -> not (null [v1 | v1 <- dst, v2 <- dst', v1 == v2])) deps
                      deps3 = (src,dst):deps1
                      src2  = concatMap fst deps3
                      dst2  = [v | v <- concatMap snd deps3
                                 , lookup v src2 == Nothing]
                      dep2  = (src2,dst2)
                      dst'  = nub dst
                  in if null deps1
                       then if dst' == [k]
                              then closure k deps2 vs2 vs3
                              else closure k deps2 ((src,dst') : vs2) vs3
                       else closure k (dep2 : deps2) vs2 vs3
{-
        mkNewSig src =
          DTyp (mkArgs 0 0 [] src) cidFloat []
          where
            mkArgs k l env []                      = []
            mkArgs k l env ((i,DTyp _ c es) : src)
               | i == k    = let ty = DTyp [] c (map (normalForm sig k env) es)
                             in (Explicit,wildCId,ty) : mkArgs (k+1) (l+1) (VGen l [] : env) src
               | otherwise = mkArgs (k+1) l (VMeta 0 env [] : env) src
-}
type CState = (Int,Map.Map CId [Equation])

computeConstrs :: PGF -> CState -> [(CId,[Patt],[Expr])] -> (CState,[[CId]])
computeConstrs pgf (ngen,eqs_map) fns@((id,pts,[]):rest)
  | null rest =
     let eqs_map' = 
           Map.insertWith (++) (p_f id)
                               (if null pts
                                  then []
                                  else [Equ pts (ELit (LFlt 1.0))])
                               eqs_map
     in ((ngen,eqs_map'),[])
  | otherwise =
     let (st,ks) = mapAccumL mk_k (ngen,eqs_map) fns

         mk_k (ngen,eqs_map) (id,pts,[])
           | null pts  = ((ngen,eqs_map),k_f id)
           | otherwise = let eqs_map' = 
                               Map.insertWith (++) 
                                              (p_f id) 
                                              [Equ pts (EFun (k_i ngen))]
                                              eqs_map
                         in ((ngen+1,eqs_map'),k_i ngen)

     in (st,[ks])
computeConstrs pgf st fns =
  let (st',res) = mapAccumL (\st (p,fns) -> computeConstrs pgf st fns)
                            st
                            (computeConstr fns)
  in (st',concat res)
  where
    computeConstr fns = merge (split fns (Map.empty,[]))

    merge (cns,vrs) =
      [(p,fns++[(id,ps++[p],es) | (id,ps,es) <- vrs])
                                | (p,fns) <- concatMap addArgs (Map.toList cns)]
      ++
      if null vrs 
        then []
        else [(PWild,[(id,ps++[PWild],es) | (id,ps,es) <- vrs])]
      where
        addArgs (cn,fns) = addArg (length args) cn [] fns
          where
            Just (DTyp args _ _es,_,_,_) = Map.lookup cn (funs (abstract pgf))

        addArg 0 cn ps fns = [(PApp cn (reverse ps),fns)]
        addArg n cn ps fns = concat [addArg (n-1) cn (arg:ps) fns' | (arg,fns') <- computeConstr fns]

    split []                   (cns,vrs) = (cns,vrs)
    split ((id, ps, e:es):fns) (cns,vrs) = split fns (extract e [])
      where
        extract (EFun cn)     args = (Map.insertWith (++) cn [(id,ps,args++es)] cns, vrs)
        extract (EVar i)      args = (cns, (id,ps,es):vrs)
        extract (EApp e1 e2)  args = extract e1 (e2:args)
        extract (ETyped e ty) args = extract e args
        extract (EImplArg e)  args = extract e args

p_f c = mkCId ("p_"++showCId c)
p_i i = mkCId ("p_"++show i)
k_f f = mkCId ("k_"++showCId f)
k_i i = mkCId ("k_"++show i)
