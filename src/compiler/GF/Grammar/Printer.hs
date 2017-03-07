----------------------------------------------------------------------
-- |
-- Module      : GF.Grammar.Printer
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-----------------------------------------------------------------------------

{-# LANGUAGE FlexibleContexts #-}
module GF.Grammar.Printer
           ( -- ** Pretty printing
             TermPrintQual(..)
           , ppModule
           , ppJudgement
           , ppParams
           , ppTerm
           , ppPatt
           , ppValue
           , ppConstrs
           , ppQIdent
           , ppMeta
           , getAbs
           ) where

import GF.Infra.Ident
import GF.Infra.Option
import GF.Grammar.Values
import GF.Grammar.Grammar

import PGF.Internal (ppMeta, ppLit, ppFId, ppFunId, ppSeqId, ppSeq)

import GF.Text.Pretty
import Data.Maybe (isNothing)
import Data.List  (intersperse)
import qualified Data.Map as Map
--import qualified Data.IntMap as IntMap
--import qualified Data.Set as Set
import qualified Data.Array.IArray as Array

data TermPrintQual 
  = Terse | Unqualified | Qualified | Internal
  deriving Eq                 

instance Pretty Grammar where
  pp = vcat . map (ppModule Qualified) . modules

ppModule :: TermPrintQual -> SourceModule -> Doc
ppModule q (mn, ModInfo mtype mstat opts exts with opens _ _ mseqs jments) =
    hdr $$ 
    nest 2 (ppOptions opts $$ 
            vcat (map (ppJudgement q) (Map.toList jments)) $$
            maybe empty (ppSequences q) mseqs) $$
    ftr
    where
      hdr = complModDoc <+> modTypeDoc <+> '=' <+> 
            hsep (intersperse (pp "**") $
                  filter (not . isEmpty)  $ [ commaPunct ppExtends exts
                                            , maybe empty ppWith with
                                            , if null opens
                                                then pp '{'
                                                else "open" <+> commaPunct ppOpenSpec opens <+> "in" <+> '{'
                                            ])

      ftr = '}'

      complModDoc =
        case mstat of
          MSComplete   -> empty
          MSIncomplete -> pp "incomplete"

      modTypeDoc =
        case mtype of
          MTAbstract         -> "abstract"  <+> mn
          MTResource         -> "resource"  <+> mn
          MTConcrete abs     -> "concrete"  <+> mn <+> "of" <+> abs
          MTInterface        -> "interface" <+> mn
          MTInstance ie      -> "instance"  <+> mn <+> "of" <+> ppExtends ie

      ppExtends (id,MIAll        ) = pp id
      ppExtends (id,MIOnly   incs) = id         <+> brackets (commaPunct pp incs)
      ppExtends (id,MIExcept incs) = id <+> '-' <+> brackets (commaPunct pp incs)
      
      ppWith (id,ext,opens) = ppExtends (id,ext) <+> "with" <+> commaPunct ppInstSpec opens

ppOptions opts = 
  "flags" $$
  nest 2 (vcat [option <+> '=' <+> ppLit value <+> ';' | (option,value) <- optionsGFO opts])

ppJudgement q (id, AbsCat pcont ) =
  "cat" <+> id <+>
  (case pcont of
     Just (L _ cont) -> hsep (map (ppDecl q) cont)
     Nothing         -> empty) <+> ';'
ppJudgement q (id, AbsFun ptype _ pexp poper) =
  let kind | isNothing pexp      = "data"
           | poper == Just False = "oper"
           | otherwise           = "fun"
  in
  (case ptype of
     Just (L _ typ) -> kind <+> id <+> ':' <+> ppTerm q 0 typ <+> ';'
     Nothing        -> empty) $$
  (case pexp of
     Just []  -> empty
     Just eqs -> "def" <+> vcat [id <+> hsep (map (ppPatt q 2) ps) <+> '=' <+> ppTerm q 0 e <+> ';' | L _ (ps,e) <- eqs]
     Nothing  -> empty)
ppJudgement q (id, ResParam pparams _) = 
  "param" <+> id <+>
  (case pparams of
     Just (L _ ps) -> '=' <+> ppParams q ps
     _             -> empty) <+> ';'
ppJudgement q (id, ResValue pvalue) = 
  "-- param constructor" <+> id <+> ':' <+> 
  (case pvalue of
     (L _ ty) -> ppTerm q 0 ty) <+> ';'
ppJudgement q (id, ResOper  ptype pexp) =
  "oper" <+> id <+>
  (case ptype of {Just (L _ t) -> ':'  <+> ppTerm q 0 t; Nothing -> empty} $$
   case pexp  of {Just (L _ e) -> '=' <+> ppTerm q 0 e; Nothing -> empty}) <+> ';'
ppJudgement q (id, ResOverload ids defs) =
  "oper" <+> id <+> '=' <+> 
  ("overload" <+> '{' $$
   nest 2 (vcat [id <+> (':' <+> ppTerm q 0 ty $$ '=' <+> ppTerm q 0 e <+> ';') | (L _ ty,L _ e) <- defs]) $$
   '}') <+> ';'
ppJudgement q (id, CncCat pcat pdef pref pprn mpmcfg) =
  (case pcat of
     Just (L _ typ) -> "lincat" <+> id <+> '=' <+> ppTerm q 0 typ <+> ';'
     Nothing        -> empty) $$
  (case pdef of
     Just (L _ exp) -> "lindef" <+> id <+> '=' <+> ppTerm q 0 exp <+> ';'
     Nothing        -> empty) $$
  (case pref of
     Just (L _ exp) -> "linref" <+> id <+> '=' <+> ppTerm q 0 exp <+> ';'
     Nothing        -> empty) $$
  (case pprn of
     Just (L _ prn) -> "printname" <+> id <+> '=' <+> ppTerm q 0 prn <+> ';'
     Nothing        -> empty) $$
  (case (mpmcfg,q) of
     (Just (PMCFG prods funs),Internal)
                    -> "pmcfg" <+> id <+> '=' <+> '{' $$
                       nest 2 (vcat (map ppProduction prods) $$
                               ' ' $$
                               vcat (map (\(funid,arr) -> ppFunId funid <+> ":=" <+> 
                                                          parens (hcat (punctuate ',' (map ppSeqId (Array.elems arr)))))
                                         (Array.assocs funs))) $$
                       '}'
     _              -> empty)
ppJudgement q (id, CncFun  ptype pdef pprn mpmcfg) =
  (case pdef of
     Just (L _ e) -> let (xs,e') = getAbs e
                     in "lin" <+> id <+> hsep (map ppBind xs) <+> '=' <+> ppTerm q 0 e' <+> ';'
     Nothing      -> empty) $$
  (case pprn of
     Just (L _ prn) -> "printname" <+> id <+> '=' <+> ppTerm q 0 prn <+> ';'
     Nothing        -> empty) $$
  (case (mpmcfg,q) of
     (Just (PMCFG prods funs),Internal)
                    -> "pmcfg" <+> id <+> '=' <+> '{' $$
                       nest 2 (vcat (map ppProduction prods) $$
                               ' ' $$
                               vcat (map (\(funid,arr) -> ppFunId funid <+> ":=" <+> 
                                                          parens (hcat (punctuate ',' (map ppSeqId (Array.elems arr)))))
                                         (Array.assocs funs))) $$
                       '}'
     _              -> empty)
ppJudgement q (id, AnyInd cann mid) =
  case q of
    Internal -> "ind" <+> id <+> '=' <+> (if cann then pp "canonical" else empty) <+> mid <+> ';'
    _        -> empty

instance Pretty Term where pp = ppTerm Unqualified 0

ppTerm q d (Abs b v e)   = let (xs,e') = getAbs (Abs b v e)
                           in prec d 0 ('\\' <> commaPunct ppBind xs <+> "->" <+> ppTerm q 0 e')
ppTerm q d (T TRaw xs) = case getCTable (T TRaw xs) of
                           ([],_) -> "table" <+> '{' $$
	  		             nest 2 (vcat (punctuate ';' (map (ppCase q) xs))) $$
			             '}'
                           (vs,e) -> prec d 0 ("\\\\" <> commaPunct pp vs <+> "=>" <+> ppTerm q 0 e)
ppTerm q d (T (TTyped t) xs) = "table" <+> ppTerm q 0 t <+> '{' $$
			       nest 2 (vcat (punctuate ';' (map (ppCase q) xs))) $$
			       '}'
ppTerm q d (T (TComp  t) xs) = "table" <+> ppTerm q 0 t <+> '{' $$
		 	       nest 2 (vcat (punctuate ';' (map (ppCase q) xs))) $$
			       '}'
ppTerm q d (T (TWild  t) xs) = "table" <+> ppTerm q 0 t <+> '{' $$
			       nest 2 (vcat (punctuate ';' (map (ppCase q) xs))) $$
			       '}'
ppTerm q d (Prod bt x a b)= if x == identW && bt == Explicit
                              then prec d 0 (ppTerm q 4 a <+> "->" <+> ppTerm q 0 b)
                              else prec d 0 (parens (ppBind (bt,x) <+> ':' <+> ppTerm q 0 a) <+> "->" <+> ppTerm q 0 b)
ppTerm q d (Table kt vt)=prec d 0 (ppTerm q 3 kt <+> "=>" <+> ppTerm q 0 vt)
ppTerm q d (Let l e)    = let (ls,e') = getLet e
                          in prec d 0 ("let" <+> vcat (map (ppLocDef q) (l:ls)) $$ "in" <+> ppTerm q 0 e')
ppTerm q d (Example e s)=prec d 0 ("in" <+> ppTerm q 5 e <+> str s)
ppTerm q d (C e1 e2)    =prec d 1 (hang (ppTerm q 2 e1) 2 ("++" <+> ppTerm q 1 e2))
ppTerm q d (Glue e1 e2) =prec d 2 (ppTerm q 3 e1 <+> '+'  <+> ppTerm q 2 e2)
ppTerm q d (S x y)     = case x of
                           T annot xs -> let e = case annot of
			                           TRaw     -> y
			                           TTyped t -> Typed y t
			                           TComp  t -> Typed y t
			                           TWild  t -> Typed y t
			                 in "case" <+> ppTerm q 0 e <+>"of" <+> '{' $$
			                    nest 2 (vcat (punctuate ';' (map (ppCase q) xs))) $$
			                   '}'
			   _          -> prec d 3 (hang (ppTerm q 3 x) 2 ("!" <+> ppTerm q 4 y))
ppTerm q d (ExtR x y)  = prec d 3 (ppTerm q 3 x <+> "**" <+> ppTerm q 4 y)
ppTerm q d (App x y)   = prec d 4 (ppTerm q 4 x <+> ppTerm q 5 y)
ppTerm q d (V e es)    = hang "table" 2 (sep [ppTerm q 6 e,brackets (fsep (punctuate ';' (map (ppTerm q 0) es)))])
ppTerm q d (FV es)     = "variants" <+> braces (fsep (punctuate ';' (map (ppTerm q 0) es)))
ppTerm q d (AdHocOverload es)     = "overload" <+> braces (fsep (punctuate ';' (map (ppTerm q 0) es)))
ppTerm q d (Alts e xs) = prec d 4 ("pre" <+> braces (ppTerm q 0 e <> ';' <+> fsep (punctuate ';' (map (ppAltern q) xs))))
ppTerm q d (Strs es)   = "strs" <+> braces (fsep (punctuate ';' (map (ppTerm q 0) es)))
ppTerm q d (EPatt p)   = prec d 4 ('#' <+> ppPatt q 2 p)
ppTerm q d (EPattType t)=prec d 4 ("pattern" <+> ppTerm q 0 t)
ppTerm q d (P t l)     = prec d 5 (ppTerm q 5 t <> '.' <> l)
ppTerm q d (Cn id)     = pp id
ppTerm q d (Vr id)     = pp id
ppTerm q d (Q  id)     = ppQIdent q id
ppTerm q d (QC id)     = ppQIdent q id
ppTerm q d (Sort id)   = pp id
ppTerm q d (K s)       = str s
ppTerm q d (EInt n)    = pp n
ppTerm q d (EFloat f)  = pp f
ppTerm q d (Meta i)    = ppMeta i
ppTerm q d (Empty)     = pp "[]"
ppTerm q d (R [])      = pp "<>" -- to distinguish from {} empty RecType
ppTerm q d (R xs)      = braces (fsep (punctuate ';' [l <+> 
                                                       fsep [case mb_t of {Just t -> ':' <+> ppTerm q 0 t; Nothing -> empty},
                                                             '=' <+> ppTerm q 0 e] | (l,(mb_t,e)) <- xs]))
ppTerm q d (RecType xs)
  | q == Terse         = case [cat | (l,_) <- xs, let (p,cat) = splitAt 5 (showIdent (label2ident l)), p == "lock_"] of
                           [cat] -> pp cat
                           _     -> doc
  | otherwise          = doc
  where
    doc = braces (fsep (punctuate ';' [l <+> ':' <+> ppTerm q 0 t | (l,t) <- xs]))
ppTerm q d (Typed e t) = '<' <> ppTerm q 0 e <+> ':' <+> ppTerm q 0 t <> '>'
ppTerm q d (ImplArg e) = braces (ppTerm q 0 e)
ppTerm q d (ELincat cat t) = prec d 4 ("lincat" <+> cat <+> ppTerm q 5 t)
ppTerm q d (ELin cat t) = prec d 4 ("lin" <+> cat <+> ppTerm q 5 t)
ppTerm q d (Error s)   = prec d 4 ("Predef.error" <+> str s)

ppEquation q (ps,e) = hcat (map (ppPatt q 2) ps) <+> "->" <+> ppTerm q 0 e

ppCase q (p,e) = ppPatt q 0 p <+> "=>" <+> ppTerm q 0 e

instance Pretty Patt where pp = ppPatt Unqualified 0

ppPatt q d (PAlt p1 p2) = prec d 0 (ppPatt q 0 p1 <+> '|' <+> ppPatt q 1 p2)
ppPatt q d (PSeq p1 p2) = prec d 0 (ppPatt q 0 p1 <+> '+' <+> ppPatt q 1 p2)
ppPatt q d (PMSeq (_,p1) (_,p2)) = prec d 0 (ppPatt q 0 p1 <+> '+' <+> ppPatt q 1 p2)
ppPatt q d (PC f ps)    = if null ps
                            then pp f
                            else prec d 1 (f <+> hsep (map (ppPatt q 3) ps))
ppPatt q d (PP f ps)    = if null ps
                            then ppQIdent q f
                            else prec d 1 (ppQIdent q f <+> hsep (map (ppPatt q 3) ps))
ppPatt q d (PRep p)     = prec d 1 (ppPatt q 3 p <> '*')
ppPatt q d (PAs f p)    = prec d 2 (f <> '@' <> ppPatt q 3 p)
ppPatt q d (PNeg p)     = prec d 2 ('-' <> ppPatt q 3 p)
ppPatt q d (PChar)      = pp '?'
ppPatt q d (PChars s)   = brackets (str s)
ppPatt q d (PMacro id)  = '#' <> id
ppPatt q d (PM id)      = '#' <> ppQIdent q id
ppPatt q d PW           = pp '_'
ppPatt q d (PV id)      = pp id
ppPatt q d (PInt n)     = pp n
ppPatt q d (PFloat f)   = pp f
ppPatt q d (PString s)  = str s
ppPatt q d (PR xs)      = braces (hsep (punctuate ';' [l <+> '=' <+> ppPatt q 0 e | (l,e) <- xs]))
ppPatt q d (PImplArg p) = braces (ppPatt q 0 p)
ppPatt q d (PTilde t)   = prec d 2 ('~' <> ppTerm q 6 t)

ppValue :: TermPrintQual -> Int -> Val -> Doc
ppValue q d (VGen i x)    = x <> "{-" <> i <> "-}" ---- latter part for debugging
ppValue q d (VApp u v)    = prec d 4 (ppValue q 4 u <+> ppValue q 5 v)
ppValue q d (VCn (_,c))   = pp c
ppValue q d (VClos env e) = case e of
                              Meta _ -> ppTerm q d e <> ppEnv env
                              _      -> ppTerm q d e ---- ++ prEnv env ---- for debugging
ppValue q d (VRecType xs) = braces (hsep (punctuate ',' [l <> '=' <> ppValue q 0 v | (l,v) <- xs]))
ppValue q d VType         = pp "Type"

ppConstrs :: Constraints -> [Doc]
ppConstrs = map (\(v,w) -> braces (ppValue Unqualified 0 v <+> "<>" <+> ppValue Unqualified 0 w))

ppEnv :: Env -> Doc
ppEnv e = hcat (map (\(x,t) -> braces (x <> ":=" <> ppValue Unqualified 0 t)) e)

str s = doubleQuotes s

ppDecl q (_,id,typ)
  | id == identW = ppTerm q 3 typ
  | otherwise    = parens (id <+> ':' <+> ppTerm q 0 typ)

ppDDecl q (_,id,typ)
  | id == identW = ppTerm q 6 typ
  | otherwise    = parens (id <+> ':' <+> ppTerm q 0 typ)

ppQIdent :: TermPrintQual -> QIdent -> Doc
ppQIdent q (m,id) =
  case q of
    Terse       ->          pp id
    Unqualified ->          pp id
    Qualified   -> m <> '.' <> id
    Internal    -> m <> '.' <> id
    

instance Pretty Label where pp = pp . label2ident

ppOpenSpec (OSimple id)   = pp id
ppOpenSpec (OQualif id n) = parens (id <+> '=' <+> n)

ppInstSpec (id,n) = parens (id <+> '=' <+> n)

ppLocDef q (id, (mbt, e)) =
  id <+>
  (case mbt of {Just t -> ':' <+> ppTerm q 0 t; Nothing -> empty} <+> '=' <+> ppTerm q 0 e) <+> ';'

ppBind (Explicit,v) = pp v
ppBind (Implicit,v) = braces v

ppAltern q (x,y) = ppTerm q 0 x <+> '/' <+> ppTerm q 0 y

ppParams q ps = fsep (intersperse (pp '|') (map (ppParam q) ps))
ppParam q (id,cxt) = id <+> hsep (map (ppDDecl q) cxt)

ppProduction (Production fid funid args) =
  ppFId fid <+> "->" <+> ppFunId funid <> 
  brackets (hcat (punctuate "," (map (hsep . intersperse (pp '|') . map ppFId) args)))

ppSequences q seqsArr
  | null seqs || q /= Internal = empty
  | otherwise                  = "sequences" <+> '{' $$
                                 nest 2 (vcat (map ppSeq seqs)) $$
                                 '}'
  where
    seqs = Array.assocs seqsArr

commaPunct f ds = (hcat (punctuate "," (map f ds)))

prec d1 d2 doc
  | d1 > d2   = parens doc
  | otherwise = doc

getAbs :: Term -> ([(BindType,Ident)], Term)
getAbs (Abs bt v e) = let (xs,e') = getAbs e
                      in ((bt,v):xs,e')
getAbs e            = ([],e)

getCTable :: Term -> ([Ident], Term)
getCTable (T TRaw [(PV v,e)]) = let (vs,e') = getCTable e
                                in (v:vs,e')
getCTable (T TRaw [(PW,  e)]) = let (vs,e') = getCTable e
                                in (identW:vs,e')
getCTable e                   = ([],e)

getLet :: Term -> ([LocalDef], Term)
getLet (Let l e) = let (ls,e') = getLet e
                   in (l:ls,e')
getLet e         = ([],e)

