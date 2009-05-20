----------------------------------------------------------------------
-- |
-- Module      : GF.Grammar.Printer
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-----------------------------------------------------------------------------

module GF.Grammar.Printer
           ( TermPrintQual(..)
           , ppIdent
           , ppLabel
           , ppModule
           , ppJudgement
           , ppTerm
           , ppTermTabular
           , ppPatt
           ) where

import GF.Infra.Ident
import GF.Infra.Modules
import GF.Infra.Option
import GF.Grammar.Grammar
import GF.Data.Operations
import Text.PrettyPrint

import Data.Maybe (maybe)
import Data.List  (intersperse)

data TermPrintQual = Qualified | Unqualified

ppModule :: TermPrintQual -> SourceModule -> Doc
ppModule q (mn, ModInfo mtype mstat opts exts with opens _ jments _) =
    hdr $$ nest 2 (ppOptions opts $$ vcat (map (ppJudgement q) defs)) $$ ftr
    where
      defs = tree2list jments

      hdr = complModDoc <+> modTypeDoc <+> equals <+> 
            hsep (intersperse (text "**") $
                  filter (not . isEmpty)  $ [ commaPunct ppExtends exts
                                            , maybe empty ppWith with
                                            , if null opens
                                                then lbrace
                                                else text "open" <+> commaPunct ppOpenSpec opens <+> text "in" <+> lbrace
                                            ])

      ftr = rbrace

      complModDoc =
        case mstat of
          MSComplete   -> empty
          MSIncomplete -> text "incomplete"

      modTypeDoc =
        case mtype of
          MTAbstract         -> text "abstract"  <+> ppIdent mn
          MTTransfer src dst -> text "transfer"  <+> ppIdent mn <+> colon <+> ppOpenSpec src <+> text "->" <+> ppOpenSpec dst
          MTResource         -> text "resource"  <+> ppIdent mn
          MTConcrete abs     -> text "concrete"  <+> ppIdent mn <+> text "of" <+> ppIdent abs
          MTInterface        -> text "interface" <+> ppIdent mn
          MTInstance int     -> text "instance"  <+> ppIdent mn <+> text "of" <+> ppIdent int

      ppExtends (id,MIAll        ) = ppIdent id
      ppExtends (id,MIOnly   incs) = ppIdent id              <+> brackets (commaPunct ppIdent incs)
      ppExtends (id,MIExcept incs) = ppIdent id <+> char '-' <+> brackets (commaPunct ppIdent incs)
      
      ppWith (id,ext,opens) = ppExtends (id,ext) <+> text "with" <+> commaPunct ppInstSpec opens

ppOptions opts = 
  text "flags" $$
  nest 2 (vcat [text option <+> equals <+> text (show value) <+> semi | (option,value) <- optionsGFO opts])

ppJudgement q (id, AbsCat pcont pconstrs) =
  text "cat" <+> ppIdent id <+>
  (case pcont of
     Just cont -> hsep (map (ppDecl q) cont)
     Nothing   -> empty) <+> semi $$
  case pconstrs of
    Just costrs -> text "data" <+> ppIdent id <+> equals <+> fsep (intersperse (char '|') (map (ppTerm q 0) costrs)) <+> semi
    Nothing     -> empty
ppJudgement q (id, AbsFun ptype pexp) =
  (case ptype of
     Just typ   -> text "fun" <+> ppIdent id <+> colon <+> ppTerm q 0 typ <+> semi
     Nothing    -> empty) $$
  (case pexp of
     Just eqs -> text "def" <+> vcat [ppIdent id <+> hsep (map (ppPatt q 2) ps) <+> equals <+> ppTerm q 0 e <+> semi | (ps,e) <- eqs]
     Nothing  -> empty)
ppJudgement q (id, ResParam pparams) = 
  text "param" <+> ppIdent id <+>
  (case pparams of
     Just (ps,_) -> equals <+> fsep (intersperse (char '|') (map (ppParam q) ps))
     _           -> empty) <+> semi
ppJudgement q (id, ResValue pvalue) = empty
ppJudgement q (id, ResOper  ptype pexp) =
  text "oper" <+> ppIdent id <+>
  (case ptype of {Just t -> colon  <+> ppTerm q 0 t; Nothing -> empty} $$
   case pexp  of {Just e -> equals <+> ppTerm q 0 e; Nothing -> empty}) <+> semi
ppJudgement q (id, ResOverload ids defs) =
  text "oper" <+> ppIdent id <+> equals <+> 
  (text "overload" <+> lbrace $$
   nest 2 (vcat [ppIdent id <+> (colon <+> ppTerm q 0 ty $$ equals <+> ppTerm q 0 e) | (ty,e) <- defs]) $$
   rbrace) <+> semi
ppJudgement q (id, CncCat  ptype pexp pprn) =
  (case ptype of
     Just typ -> text "lincat" <+> ppIdent id <+> equals <+> ppTerm q 0 typ <+> semi
     Nothing  -> empty) $$
  (case pexp of
     Just exp -> text "lindef" <+> ppIdent id <+> equals <+> ppTerm q 0 exp <+> semi
     Nothing  -> empty) $$
  (case pprn of
     Just prn -> text "printname" <+> text "cat" <+> ppIdent id <+> equals <+> ppTerm q 0 prn <+> semi
     Nothing  -> empty)
ppJudgement q (id, CncFun  ptype pdef pprn) =
  (case pdef of
     Just e  -> let (vs,e') = getAbs e
              in text "lin" <+> ppIdent id <+> hsep (map ppIdent vs) <+> equals <+> ppTerm q 0 e' <+> semi
     Nothing -> empty) $$
  (case pprn of
     Just prn -> text "printname" <+> text "fun" <+> ppIdent id <+> equals <+> ppTerm q 0 prn <+> semi
     Nothing  -> empty)
ppJudgement q (id, AnyInd cann mid) = text "ind" <+> ppIdent id <+> equals <+> (if cann then text "canonical" else empty) <+> ppIdent mid <+> semi

ppTerm q d (Abs v e)   = let (vs,e') = getAbs e
                         in prec d 0 (char '\\' <> commaPunct ppIdent (v:vs) <+> text "->" <+> ppTerm q 0 e')
ppTerm q d (T TRaw xs) = case getCTable (T TRaw xs) of
                           ([],_) -> text "table" <+> lbrace $$
	  		             nest 2 (vcat (punctuate semi (map (ppCase q) xs))) $$
			             rbrace
                           (vs,e) -> prec d 0 (text "\\\\" <> commaPunct ppIdent vs <+> text "=>" <+> ppTerm q 0 e)
ppTerm q d (T (TTyped t) xs) = text "table" <+> ppTerm q 0 t <+> lbrace $$
			       nest 2 (vcat (punctuate semi (map (ppCase q) xs))) $$
			       rbrace
ppTerm q d (T (TComp  t) xs) = text "table" <+> ppTerm q 0 t <+> lbrace $$
		 	       nest 2 (vcat (punctuate semi (map (ppCase q) xs))) $$
			       rbrace
ppTerm q d (T (TWild  t) xs) = text "table" <+> ppTerm q 0 t <+> lbrace $$
			       nest 2 (vcat (punctuate semi (map (ppCase q) xs))) $$
			       rbrace
ppTerm q d (Prod x a b)= if x == identW
                           then prec d 0 (ppTerm q 4 a <+> text "->" <+> ppTerm q 0 b)
                           else prec d 0 (parens (ppIdent x <+> colon <+> ppTerm q 0 a) <+> text "->" <+> ppTerm q 0 b)
ppTerm q d (Table kt vt)=prec d 0 (ppTerm q 3 kt <+> text "=>" <+> ppTerm q 0 vt)
ppTerm q d (Let l e)    = let (ls,e') = getLet e
                          in prec d 0 (text "let" <+> vcat (map (ppLocDef q) (l:ls)) $$ text "in" <+> ppTerm q 0 e')
ppTerm q d (Example e s)=prec d 0 (text "in" <+> ppTerm q 5 e <+> text (show s))
ppTerm q d (C e1 e2)    =prec d 1 (ppTerm q 2 e1 <+> text "++" <+> ppTerm q 1 e2)
ppTerm q d (Glue e1 e2) =prec d 2 (ppTerm q 3 e1 <+> char '+'  <+> ppTerm q 2 e2)
ppTerm q d (S x y)     = case x of
                           T annot xs -> let e = case annot of
			                           TRaw     -> y
			                           TTyped t -> Typed y t
			                           TComp  t -> Typed y t
			                           TWild  t -> Typed y t
			                 in text "case" <+> ppTerm q 0 e <+> text "of" <+> lbrace $$
			                    nest 2 (vcat (punctuate semi (map (ppCase q) xs))) $$
			                   rbrace
			   _          -> prec d 3 (ppTerm q 3 x <+> text "!" <+> ppTerm q 4 y)
ppTerm q d (ExtR x y)  = prec d 3 (ppTerm q 3 x <+> text "**" <+> ppTerm q 4 y)
ppTerm q d (App x y)   = prec d 4 (ppTerm q 4 x <+> ppTerm q 5 y)
ppTerm q d (V e es)    = text "table" <+> ppTerm q 6 e <+> lbrace $$
                         nest 2 (fsep (punctuate semi (map (ppTerm q 0) es))) $$
                         rbrace
ppTerm q d (FV es)     = text "variants" <+> braces (fsep (punctuate semi (map (ppTerm q 0) es)))
ppTerm q d (Alts (e,xs))=text "pre" <+> braces (ppTerm q 0 e <> semi <+> fsep (punctuate semi (map (ppAltern q) xs)))
ppTerm q d (Strs es)   = text "strs" <+> braces (fsep (punctuate semi (map (ppTerm q 0) es)))
ppTerm q d (EPatt p)   = prec d 4 (char '#' <+> ppPatt q 2 p)
ppTerm q d (EPattType t)=prec d 4 (text "pattern" <+> ppTerm q 0 t)
ppTerm q d (P t l)     = prec d 5 (ppTerm q 5 t <> char '.' <> ppLabel l)
ppTerm q d (Cn id)     = ppIdent id
ppTerm q d (Vr id)     = ppIdent id
ppTerm q d (Q  m id)   = ppQIdent q m id
ppTerm q d (QC m id)   = ppQIdent q m id
ppTerm q d (Sort id)   = ppIdent id
ppTerm q d (K s)       = text (show s)
ppTerm q d (EInt n)    = integer n
ppTerm q d (EFloat f)  = double f
ppTerm q d (Meta _)    = char '?'
ppTerm q d (Empty)     = text "[]"
ppTerm q d (R xs)      = braces (fsep (punctuate semi [ppLabel l <+> 
                                                       fsep [case mb_t of {Just t -> colon <+> ppTerm q 0 t; Nothing -> empty},
                                                             equals <+> ppTerm q 0 e] | (l,(mb_t,e)) <- xs]))
ppTerm q d (RecType xs)= braces (fsep (punctuate semi [ppLabel l <+> colon <+> ppTerm q 0 t | (l,t) <- xs]))
ppTerm q d (Typed e t) = char '<' <> ppTerm q 0 e <+> colon <+> ppTerm q 0 t <> char '>'

ppTermTabular :: TermPrintQual -> Term -> [(Doc,Doc)]
ppTermTabular q = pr where
  pr t = case t of
    R rs   -> 
      [(ppLabel lab       <+> char '.'  <+> path, str) | (lab,(_,val)) <- rs, (path,str) <- pr val]
    T _ cs -> 
      [(ppPatt q 0 patt     <+> text "=>" <+> path, str) | (patt,  val ) <- cs, (path,str) <- pr val]
    V _ cs -> 
      [(char '#' <> int i <+> text "=>" <+> path, str) | (i,     val ) <- zip [0..] cs, (path,str) <- pr val]
    _      -> [(empty,ps t)]
  ps t = case t of
    K s   -> text s
    C s u -> ps s <+> ps u
    FV ts -> hsep (intersperse (char '/') (map ps ts))
    _     -> ppTerm q 0 t

ppEquation q (ps,e) = hcat (map (ppPatt q 2) ps) <+> text "->" <+> ppTerm q 0 e

ppCase q (p,e) = ppPatt q 0 p <+> text "=>" <+> ppTerm q 0 e

ppPatt q d (PAlt p1 p2) = prec d 0 (ppPatt q 0 p1 <+> char '|' <+> ppPatt q 1 p2)
ppPatt q d (PSeq p1 p2) = prec d 0 (ppPatt q 0 p1 <+> char '+' <+> ppPatt q 1 p2)
ppPatt q d (PC f ps)    = if null ps
                            then ppIdent f
                            else prec d 1 (ppIdent f <+> hsep (map (ppPatt q 2) ps))
ppPatt q d (PP f g ps)  = if null ps
                            then ppQIdent q f g
                            else prec d 1 (ppQIdent q f g <+> hsep (map (ppPatt q 2) ps))
ppPatt q d (PRep p)     = prec d 1 (ppPatt q 2 p <> char '*')
ppPatt q d (PAs f p)    = prec d 1 (ppIdent f <> char '@' <> ppPatt q 2 p)
ppPatt q d (PNeg p)     = prec d 1 (char '-' <> ppPatt q 2 p)
ppPatt q d (PChar)      = char '?'
ppPatt q d (PChars s)   = brackets (text (show s))
ppPatt q d (PMacro id)  = char '#' <> ppIdent id
ppPatt q d (PM m id)    = char '#' <> ppIdent m <> char '.' <> ppIdent id
ppPatt q d (PV id)      = ppIdent id
ppPatt q d (PInt n)     = integer n
ppPatt q d (PFloat f)   = double f
ppPatt q d (PString s)  = text (show s)
ppPatt q d (PR xs)      = braces (hsep (punctuate semi [ppLabel l <+> equals <+> ppPatt q 0 e | (l,e) <- xs]))

ppDecl q (id,typ)
  | id == identW = ppTerm q 4 typ
  | otherwise    = parens (ppIdent id <+> colon <+> ppTerm q 0 typ)

ppDDecl q (id,typ)
  | id == identW = ppTerm q 6 typ
  | otherwise    = parens (ppIdent id <+> colon <+> ppTerm q 0 typ)

ppIdent = text . prIdent

ppQIdent q m id =
  case q of
    Qualified   -> ppIdent m <> char '.' <> ppIdent id
    Unqualified ->                          ppIdent id

ppLabel = ppIdent . label2ident

ppOpenSpec (OSimple id)   = ppIdent id
ppOpenSpec (OQualif id n) = parens (ppIdent id <+> equals <+> ppIdent n)

ppInstSpec (id,n) = parens (ppIdent id <+> equals <+> ppIdent n)

ppLocDef q (id, (mbt, e)) =
  ppIdent id <+>
  (case mbt of {Just t -> colon  <+> ppTerm q 0 t; Nothing -> empty} <+> equals <+> ppTerm q 0 e) <+> semi


ppAltern q (x,y) = ppTerm q 0 x <+> char '/' <+> ppTerm q 0 y

ppParam q (id,cxt) = ppIdent id <+> hsep (map (ppDDecl q) cxt)

commaPunct f ds = (hcat (punctuate comma (map f ds)))

prec d1 d2 doc
  | d1 > d2   = parens doc
  | otherwise = doc

getAbs :: Term -> ([Ident], Term)
getAbs (Abs v e) = let (vs,e') = getAbs e
                   in (v:vs,e')
getAbs e         = ([],e)

getCTable :: Term -> ([Ident], Term)
getCTable (T TRaw [(PV v,e)]) = let (vs,e') = getCTable e
                                in (v:vs,e')
getCTable e                   = ([],e)

getLet :: Term -> ([LocalDef], Term)
getLet (Let l e) = let (ls,e') = getLet e
                   in (l:ls,e')
getLet e         = ([],e)
