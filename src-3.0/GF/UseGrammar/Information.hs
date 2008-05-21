----------------------------------------------------------------------
-- |
-- Module      : Information
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/05 20:02:20 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.7 $
--
-- information on module, category, function, operation, parameter,... 
-- AR 16\/9\/2003.
-- uses source grammar
-----------------------------------------------------------------------------

module GF.UseGrammar.Information (
   showInformation,
   missingLinCanonGrammar
   ) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Modules
import GF.Infra.Option
import GF.CF.CF
import GF.CF.PPrCF
import GF.Compile.ShellState
import GF.Grammar.PrGrammar
import GF.Grammar.Lookup
import GF.Grammar.Macros (zIdent)
import qualified GF.Canon.GFC as GFC
import qualified GF.Canon.AbsGFC as AbsGFC

import GF.Data.Operations
import GF.Infra.UseIO

-- information on module, category, function, operation, parameter,... AR 16/9/2003
-- uses source grammar

-- | the top level function
showInformation :: Options -> ShellState -> Ident -> IOE ()
showInformation opts st c = do
  is <- ioeErr $ getInformation opts st c
  if null is 
     then putStrLnE "Identifier not in scope" 
     else mapM_ (putStrLnE . prInformationM c) is
 where
   prInformationM c (i,m) = prInformation opts c i ++ "file:" +++ m ++ "\n"

-- | the data type of different kinds of information
data Information = 
   IModAbs  SourceAbs
 | IModRes  SourceRes
 | IModCnc  SourceCnc
 | IModule  SourceAbs -- ^ to be deprecated
 | ICatAbs  Ident Context [Ident]
 | ICatCnc  Ident Type    [CFRule] Term
 | IFunAbs  Ident Type    (Maybe Term)
 | IFunCnc  Ident Type    [CFRule] Term
 | IOper    Ident Type    Term
 | IParam   Ident         [Param] [Term]
 | IValue   Ident Type

type CatId = AbsGFC.CIdent
type FunId = AbsGFC.CIdent

prInformation :: Options -> Ident -> Information -> String
prInformation opts c i = unlines $ prt c : case i of
  IModule m -> [
    "module of type" +++ show (mtype m),
    "extends" +++ show (extends m),
    "opens" +++ show (opens m),
    "defines" +++ unwords (map prt (ownConstants (jments m)))
    ]
  ICatAbs m co _ -> [
    "category in abstract module" +++ prt m,
    if null co then "not a dependent type" 
      else "dependent type with context" +++ prContext co
    ]
  ICatCnc m ty cfs tr -> [
    "category in concrete module" +++ prt m,
    "linearization type" +++ prt ty
    ]
  IFunAbs m ty _ -> [
    "function in abstract module" +++ prt m,
    "type" +++ prt ty
    ]
  IFunCnc m ty cfs tr -> [
    "function in concrete module" +++ prt m,
    "linearization" +++ prt tr
   ---    "linearization type" +++ prt ty
    ]
  IOper m ty tr -> [
    "operation in resource module" +++ prt m,
    "type" +++ prt ty,
    "definition" +++ prt tr 
    ]
  IParam m ty ts -> [
    "parameter type in resource module" +++ prt m,
    "constructors" +++ unwords (map prParam ty),
    "values" +++ unwords (map prt ts)
    ]
  IValue m ty -> [
    "parameter constructor in resource module" +++ prt m,
    "type" +++ show ty
    ]

-- | also finds out if an identifier is defined in many places
getInformation :: Options -> ShellState -> Ident -> Err [(Information,FilePath)]
getInformation opts st c = allChecks $ [
  do
    m <- lookupModule src c 
    case m of
      ModMod mo -> returnm c $ IModule mo
      _ -> prtBad "not a source module" c
  ] ++ map lookInSrc ss ++ map lookInCan cs
 where
   lookInSrc (i,m) = do
     j <- lookupInfo m c 
     case j of
       AbsCat (Yes co) _ -> returnm i $ ICatAbs i co [] ---
       AbsFun (Yes ty) _ -> returnm i $ IFunAbs i ty Nothing ---
       CncCat (Yes ty) _ _ -> do
         ---- let cat = ident2CFCat i c
         ---- rs <- concat [rs | (c,rs) <- cf, ]
         returnm i $ ICatCnc i ty [] ty ---       
       CncFun _ (Yes tr) _ -> do
         rs <- return []
         returnm i $ IFunCnc i tr rs tr ---       
       ResOper (Yes ty) (Yes tr) -> returnm i $ IOper i ty tr
       ResParam (Yes (ps,_)) -> do
         ts <- allParamValues src (QC i c)
         returnm i $ IParam i ps ts
       ResValue (Yes (ty,_)) -> returnm i $ IValue i ty ---
       
       _ -> prtBad "nothing available for" i
   lookInCan (i,m) = do
     Bad "nothing available yet in canonical"

   returnm m i = return (i, pathOfModule st m)

   src = srcModules st
   can = canModules st
   ss  = [(i,m) | (i,ModMod m) <- modules src]
   cs  = [(i,m) | (i,ModMod m) <- modules can]
   cf  = concatMap ruleGroupsOfCF $ map snd $ cfs st

ownConstants :: BinTree Ident Info -> [Ident]
ownConstants = map fst . filter isOwn . tree2list where
  isOwn (c,i) = case i of
    AnyInd _ _ -> False
    _ -> True

missingLinCanonGrammar :: GFC.CanonGrammar -> String
missingLinCanonGrammar cgr = 
  unlines $ concat [prt_ c : missing js | (c,js) <- concretes] where
  missing js = map (("  " ++) . prt_) $ filter (not . flip isInBinTree js) abstract
  abstract = err (const []) (map fst . tree2list . jments) $ lookupModMod cgr absId
  absId = maybe (zIdent "") id $ greatestAbstract cgr
  concretes = [(cnc,jments mo) | 
    cnc <- allConcretes cgr absId, Ok mo <- [lookupModMod cgr cnc]]
