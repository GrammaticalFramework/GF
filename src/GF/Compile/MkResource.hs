module MkResource where

import Grammar
import Ident
import Modules
import Macros
import PrGrammar

import Operations

import Monad

-- extracting resource r from abstract + concrete syntax
-- AR 21/8/2002 -- 22/6/2003 for GF with modules

makeReuse :: SourceGrammar -> Ident -> Maybe Ident -> 
             MReuseType Ident -> Err SourceRes
makeReuse gr r me mrc = do
  flags <- return [] --- no flags are passed: they would not make sense
  case mrc of
    MRResource c -> do
      (ops,jms) <- mkFull True c
      return $ Module MTResource MSComplete flags me ops jms

    MRInstance c a -> do
      (ops,jms) <- mkFull False c
      return $ Module (MTInstance a) MSComplete flags me ops jms

    MRInterface c -> do
      mc <- lookupModule gr c

      (ops,jms) <- case mc of 
        ModMod m -> case mtype m of
          MTAbstract -> liftM ((,) (opens m)) $ 
                          mkResDefs True False gr r c me (extends m) (jments m) NT
          _ -> prtBad "expected abstract to be the type of" c
        _ -> prtBad "expected abstract to be the type of" c

      return $ Module MTInterface MSIncomplete flags me ops jms

 where
    mkFull hasT c = do
      mc <- lookupModule gr c

      case mc of 
        ModMod m -> case mtype m of
          MTConcrete a -> do
            ma <- lookupModule gr a
            jmsA <- case ma of 
               ModMod m' -> return $ jments m'
               _ -> prtBad "expected abstract to be the type of" a
            liftM ((,) (opens m)) $ 
               mkResDefs hasT True gr r a me (extends m) jmsA (jments m)
          _ -> prtBad "expected concrete to be the type of" c
        _ -> prtBad "expected concrete to be the type of" c


-- the first  Boolean indicates if the type needs be given
-- the second Boolean indicates if the definition needs be given

mkResDefs :: Bool -> Bool -> 
             SourceGrammar -> Ident -> Ident -> Maybe Ident -> Maybe Ident -> 
             BinTree (Ident,Info) -> BinTree (Ident,Info) -> 
             Err (BinTree (Ident,Info))
mkResDefs hasT isC gr r a mext maext abs cnc = mapMTree (mkOne a maext) abs where

  ifTyped  = yes --- if hasT then yes else const nope --- needed for TC
  ifCompl  = if isC  then yes else const nope
  doIf b t = if b then t else return typeType -- latter value not used

  mkOne a mae (f,info) = case info of
      AbsCat _ _ -> do
        typ  <- doIf isC $ err (const (return defLinType)) return $ look cnc f
        typ' <- doIf isC $ lockRecType f typ 
        return (f, ResOper (ifTyped typeType) (ifCompl typ'))
      AbsFun (Yes typ0) _ -> do
        trm <- doIf isC $ look cnc f
        testErr (not (isHardType typ0)) 
                ("cannot build reuse for function" +++ prt f +++ ":" +++ prt typ0)
        typ <- redirTyp True a mae typ0
        cat <- valCat typ
        trm' <- doIf isC $ unlockRecord (snd cat) trm 
        return (f, ResOper (ifTyped typ) (ifCompl trm'))
      AnyInd b n -> do
        mo    <- lookupModMod gr n
        info' <- lookupInfo mo f
        mkOne n (extends mo) (f,info')

  look cnc f = do
     info <- lookupTree prt f cnc
     case info of
       CncCat (Yes ty) _ _ -> return ty
       CncCat _ _ _        -> return defLinType
       CncFun _ (Yes tr) _ -> return tr
       AnyInd _ n -> do 
         mo    <- lookupModMod gr n
         t <- look (jments mo) f
         redirTyp False n (extends mo) t
       _ -> prtBad "not enough information to reuse" f

  -- type constant qualifications changed from abstract to resource
  redirTyp always a mae ty = case ty of
    Q _ c | always -> return $ Q r c
    Q n c | n == a || Just n == mae -> return $ Q r c
    _ -> composOp (redirTyp always a mae) ty

lockRecType :: Ident -> Type -> Err Type
lockRecType c t = plusRecType t $ RecType [(lockLabel c,  RecType [])]

unlockRecord :: Ident -> Term -> Err Term
unlockRecord c ft = do
  let (xs,t) = termFormCnc ft
  t' <- plusRecord t $ R [(lockLabel c,  (Just (RecType []),R []))]
  return $ mkAbs xs t'

lockLabel :: Ident -> Label
lockLabel c = LIdent $ "lock_" ++ prt c ----


-- no reuse for functions of HO/dep types

isHardType t = case t of
  Prod x a b -> not (isWild x) || isHardType a || isHardType b
  App _ _    -> True
  _          -> False  
 where 
   isWild x = isWildIdent x || prt x == "h_" --- produced by transl from canon
