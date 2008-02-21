module GF.Devel.Grammar.Lookup where

import GF.Devel.Grammar.Grammar
import GF.Devel.Grammar.Construct
import GF.Devel.Grammar.Macros
import GF.Devel.Grammar.PrGF
import GF.Infra.Ident

import GF.Data.Operations

import Control.Monad (liftM)
import Data.Map
import Data.List (sortBy) ----

-- look up fields for a constant in a grammar

lookupJField :: (Judgement -> a) -> GF -> Ident -> Ident -> Err a
lookupJField field gf m c = do
  j <- lookupJudgement gf m c
  return $ field j

lookupJForm :: GF -> Ident -> Ident -> Err JudgementForm
lookupJForm = lookupJField jform

-- the following don't (need to) check that the jment form is adequate
 
lookupCatContext :: GF -> Ident -> Ident -> Err Context
lookupCatContext gf m c = do
  ty <- lookupJField jtype gf m c
  return $ contextOfType ty

lookupFunType :: GF -> Ident -> Ident -> Err Term
lookupFunType = lookupJField jtype 

lookupLin :: GF -> Ident -> Ident -> Err Term
lookupLin = lookupJField jdef

lookupLincat :: GF -> Ident -> Ident -> Err Term
lookupLincat = lookupJField jtype

lookupOperType :: GF -> Ident -> Ident -> Err Term
lookupOperType gr m c = do
  ju <- lookupJudgement gr m c
  case jform ju of
    JParam -> return typePType
    _ -> case jtype ju of
      Meta _ -> fail ("no type given to " ++ prIdent m ++ "." ++ prIdent c)
      ty -> return ty
---- can't be just lookupJField jtype 

lookupOperDef :: GF -> Ident -> Ident -> Err Term
lookupOperDef = lookupJField jdef

lookupOverload :: GF -> Ident -> Ident -> Err [([Type],(Type,Term))]
lookupOverload gr m c = do
  tr <- lookupJField jdef gr m c
  case tr of
    Overload tysts -> return 
      [(lmap snd args,(val,tr)) | (ty,tr) <- tysts, let (args,val) = prodForm ty]
    _   -> Bad $ prt c +++ "is not an overloaded operation"

lookupParams :: GF -> Ident -> Ident -> Err [(Ident,Context)]
lookupParams gf m c = do
  ty <- lookupJField jtype gf m c
  return [(k,contextOfType t) | (k,t) <- contextOfType ty]

lookupParamConstructor :: GF -> Ident -> Ident -> Err Type
lookupParamConstructor = lookupJField jtype

lookupParamValues :: GF -> Ident -> Ident -> Err [Term]
lookupParamValues gf m c = do
  d <- lookupJField jdef gf m c
  case d of
    ---- V _ ts -> return ts
    _ -> do
      ps <- lookupParams gf m c
      liftM concat $ mapM mkPar ps
 where
   mkPar (f,co) = do
     vs <- liftM combinations $ mapM (\ (_,ty) -> allParamValues gf ty) co
     return $ lmap (mkApp (QC m f)) vs

lookupFlags :: GF -> Ident -> [(Ident,String)]
lookupFlags gf m = errVal [] $ do
  mo <- lookupModule gf m
  return $ toList $ mflags mo

allParamValues :: GF -> Type -> Err [Term]
allParamValues cnc ptyp = case ptyp of
     App (Q (IC "Predef") (IC "Ints")) (EInt n) -> 
       return [EInt i | i <- [0..n]]
     QC p c -> lookupParamValues cnc p c
     Q  p c -> lookupParamValues cnc p c ----

     RecType r -> do
       let (ls,tys) = unzip $ sortByFst r
       tss <- mapM allPV tys
       return [R (zipAssign ls ts) | ts <- combinations tss]
     _ -> prtBad "cannot find parameter values for" ptyp
  where
    allPV = allParamValues cnc
    -- to normalize records and record types
    sortByFst = sortBy (\ x y -> compare (fst x) (fst y))

abstractOfConcrete :: GF -> Ident -> Err Ident
abstractOfConcrete gf m = do
  mo <- lookupModule gf m
  case mtype mo of
    MTConcrete a -> return a
    MTInstance a -> return a
    MTGrammar -> return m
    _ -> prtBad "not concrete module" m

allOrigJudgements :: GF -> Ident -> [(Ident,Judgement)]
allOrigJudgements gf m = errVal [] $ do
  mo <- lookupModule gf m
  return [ju | ju@(_,j) <- listJudgements mo, jform j /= JLink]

allConcretes :: GF -> Ident -> [Ident]
allConcretes gf m = 
  [c | (c,mo) <- toList (gfmodules gf), mtype mo == MTConcrete m]

-- | select just those modules that a given one depends on, including itself
partOfGrammar :: GF -> (Ident,Module) -> GF
partOfGrammar gr (i,mo) = gr {
  gfmodules = fromList [m | m@(j,_) <- mos, elem j modsFor]
  } 
  where
    mos = toList $ gfmodules gr
    modsFor = i : allDepsModule gr mo

allDepsModule :: GF -> Module -> [Ident]
allDepsModule gr m = iterFix add os0 where
  os0 = depPathModule m
  add os = [m | o <- os, Just n <- [llookup o mods], m <- depPathModule n]
  mods = toList $ gfmodules gr

-- | initial dependency list
depPathModule :: Module -> [Ident]
depPathModule mo = fors ++ lmap fst (mextends mo) ++ lmap snd (mopens mo) where
  fors = case mtype mo of
    MTConcrete i   -> [i]
    MTInstance i   -> [i]
    _              -> []

-- infrastructure for lookup
    
lookupModule :: GF -> Ident -> Err Module
lookupModule gf m = do
  maybe (raiseIdent "module not found:" m) return $ mlookup m (gfmodules gf)

-- this finds the immediate definition, which can be a link
lookupIdent :: GF -> Ident -> Ident -> Err Judgement
lookupIdent gf m c = do
  mo <- lookupModule gf m
  maybe (raiseIdent "constant not found:" c) return $ mlookup c (mjments mo)

-- this follows the link
lookupJudgement :: GF -> Ident -> Ident -> Err Judgement
lookupJudgement gf m c = do
  ju <- lookupIdent gf m c
  case jform ju of
    JLink -> lookupJudgement gf (jlink ju) c
    _ -> return ju

mlookup = Data.Map.lookup

raiseIdent msg i = raise (msg +++ prIdent i)

lmap = Prelude.map
llookup = Prelude.lookup

