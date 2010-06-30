{-# LANGUAGE PatternGuards #-}
module GF.Compile.GrammarToPGF (mkCanon2pgf) where

import GF.Compile.Export
import GF.Compile.GeneratePMCFG

import PGF.CId
import PGF.Optimize(updateProductionIndices)
import qualified PGF.Macros as CM
import qualified PGF.Data as C
import qualified PGF.Data as D
import GF.Grammar.Predef
import GF.Grammar.Printer
import GF.Grammar.Grammar
import qualified GF.Grammar.Lookup as Look
import qualified GF.Grammar as A
import qualified GF.Grammar.Macros as GM
import qualified GF.Compile.Concrete.Compute as Compute ---- 
import qualified GF.Infra.Modules as M
import qualified GF.Infra.Option as O

import GF.Infra.Ident
import GF.Infra.Option
import GF.Data.Operations

import Data.List
import Data.Function
import Data.Char (isDigit,isSpace)
import qualified Data.Map as Map
import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint
import Debug.Trace ----

-- when developing, swap commenting
--traceD s t = trace s t 
traceD s t = t 


-- the main function: generate PGF from GF.
mkCanon2pgf :: Options -> Ident -> SourceGrammar -> IO D.PGF
mkCanon2pgf opts cnc gr = (canon2pgf opts gr . reorder abs) gr
  where
    abs = err (const cnc) id $ M.abstractOfConcrete gr cnc

-- Generate PGF from grammar.

canon2pgf :: Options -> SourceGrammar -> SourceGrammar -> IO D.PGF
canon2pgf opts gr cgr@(M.MGrammar (am:cms)) = do
  if dump opts DumpCanon
    then putStrLn (render (vcat (map (ppModule Qualified) (M.modules cgr))))
    else return ()
  (an,abs) <- mkAbstr am
  cncs     <- mapM (mkConcr am) cms
  return $ updateProductionIndices (D.PGF Map.empty an abs (Map.fromList cncs))
  where
    mkAbstr (a,abm) = return (i2i a, D.Abstr flags funs cats)
      where
        flags = Map.fromList [(mkCId f,C.LStr x) | (f,x) <- optionsPGF (M.flags abm)]
        
        funs = Map.fromAscList [(i2i f, (mkType [] ty, mkArrity ma, mkDef pty)) | 
                                   (f,AbsFun (Just (L _ ty)) ma pty) <- Map.toAscList (M.jments abm)]
                                   
        cats = Map.fromAscList [(i2i c, (snd (mkContext [] cont),catfuns c)) |
                                   (c,AbsCat (Just (L _ cont))) <- Map.toAscList (M.jments abm)]

        catfuns cat =
              (map snd . sortBy (compare `on` fst))
                 [(loc,i2i f) | (f,AbsFun (Just (L loc ty)) _ _) <- tree2list (M.jments abm), snd (GM.valCat ty) == cat]

    mkConcr am cm@(lang,mo) = do
      cnc <- convertConcrete opts gr am cm
      return (i2i lang, cnc)

i2i :: Ident -> CId
i2i = CId . ident2bs

b2b :: A.BindType -> C.BindType
b2b A.Explicit = C.Explicit
b2b A.Implicit = C.Implicit

mkType :: [Ident] -> A.Type -> C.Type
mkType scope t =
  case GM.typeForm t of
    (hyps,(_,cat),args) -> let (scope',hyps') = mkContext scope hyps
                           in C.DTyp hyps' (i2i cat) (map (mkExp scope') args)

mkExp :: [Ident] -> A.Term -> C.Expr
mkExp scope t = 
  case t of
    Q (_,c)  -> C.EFun (i2i c)
    QC (_,c) -> C.EFun (i2i c)
    Vr x     -> case lookup x (zip scope [0..]) of
                  Just i  -> C.EVar  i
                  Nothing -> C.EMeta 0
    Abs b x t-> C.EAbs (b2b b) (i2i x) (mkExp (x:scope) t)
    App t1 t2-> C.EApp (mkExp scope t1) (mkExp scope t2)
    EInt i   -> C.ELit (C.LInt (fromIntegral i))
    EFloat f -> C.ELit (C.LFlt f)
    K s      -> C.ELit (C.LStr s)
    Meta i   -> C.EMeta i
    _        -> C.EMeta 0

mkPatt scope p = 
  case p of
    A.PP (_,c) ps->let (scope',ps') = mapAccumL mkPatt scope ps
                   in (scope',C.PApp (i2i c) ps')
    A.PV x      -> (x:scope,C.PVar (i2i x))
    A.PAs x p   -> let (scope',p') = mkPatt scope p
                   in (x:scope',C.PAs (i2i x) p')
    A.PW        -> (  scope,C.PWild)
    A.PInt i    -> (  scope,C.PLit (C.LInt (fromIntegral i)))
    A.PFloat f  -> (  scope,C.PLit (C.LFlt f))
    A.PString s -> (  scope,C.PLit (C.LStr s))
    A.PImplArg p-> let (scope',p') = mkPatt scope p
                   in (scope',C.PImplArg p')
    A.PTilde t  -> (  scope,C.PTilde (mkExp scope t))

mkContext :: [Ident] -> A.Context -> ([Ident],[C.Hypo])
mkContext scope hyps = mapAccumL (\scope (bt,x,ty) -> let ty' = mkType scope ty
                                                      in if x == identW
                                                           then (  scope,(b2b bt,i2i x,ty'))
                                                           else (x:scope,(b2b bt,i2i x,ty'))) scope hyps 

mkDef (Just eqs) = Just [C.Equ ps' (mkExp scope' e) | L _ (ps,e) <- eqs, let (scope',ps') = mapAccumL mkPatt [] ps]
mkDef Nothing    = Nothing

mkArrity (Just a) = a
mkArrity Nothing  = 0

data PattTree
  = Ret  C.Expr
  | Case (Map.Map QIdent [PattTree]) [PattTree]

compilePatt :: [Equation] -> [PattTree]
compilePatt (([],t):_) = [Ret (mkExp [] t)]
compilePatt eqs        = whilePP eqs Map.empty
  where
    whilePP []                         cns     = [mkCase cns []]
    whilePP (((PP c ps' : ps), t):eqs) cns     = whilePP eqs (Map.insertWith (++) c [(ps'++ps,t)] cns)
    whilePP eqs                        cns     = whilePV eqs cns []

    whilePV []                         cns vrs = [mkCase cns (reverse vrs)]
    whilePV (((PV x     : ps), t):eqs) cns vrs = whilePV eqs cns ((ps,t) : vrs)
    whilePV eqs                        cns vrs = mkCase cns (reverse vrs) : compilePatt eqs

    mkCase cns vrs = Case (fmap compilePatt cns) (compilePatt vrs)


-- return just one module per language

reorder :: Ident -> SourceGrammar -> SourceGrammar
reorder abs cg =
  M.MGrammar $ 
       (abs, M.ModInfo M.MTAbstract       M.MSComplete aflags [] Nothing [] [] adefs):
      [(cnc, M.ModInfo (M.MTConcrete abs) M.MSComplete cflags [] Nothing [] [] cdefs)
            | cnc <- M.allConcretes cg abs, let (cflags,cdefs) = concr cnc]
  where
    aflags = 
      concatOptions [M.flags mo | (_,mo) <- M.modules cg, M.isModAbs mo]

    adefs = 
      Map.fromList (predefADefs ++ Look.allOrigInfos cg abs)
      where
        predefADefs = 
           [(c, AbsCat (Just (L (0,0) []))) | c <- [cFloat,cInt,cString]]

    concr la = (flags, Map.fromList (predefCDefs ++ jments))
      where 
        flags  = concatOptions [M.flags mo | (i,mo) <- M.modules cg, M.isModCnc mo, 
                                                Just r <- [lookup i (M.allExtendSpecs cg la)]]
        jments = Look.allOrigInfos cg la
        predefCDefs = 
           [(c, CncCat (Just (L (0,0) GM.defLinType)) Nothing Nothing) | c <- [cInt,cFloat,cString]]
