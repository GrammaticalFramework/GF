----------------------------------------------------------------------
-- |
-- Module      : GF.Grammar.Printer
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-----------------------------------------------------------------------------

module GF.Grammar.Printer
           ( ppModule
           , ppJudgement
           , ppTerm
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

ppModule :: SourceModule -> Doc
ppModule (mn, ModInfo mtype mstat opts exts with opens jments _) =
    (let defs = tree2list jments
     in if null defs
          then hdr
          else hdr <+> lbrace $$ nest 2 (ppOptions opts $$ vcat (map ppJudgement defs)) $$ rbrace)
    where
      hdr = complModDoc <+> modTypeDoc <+> equals <+> 
            hsep (intersperse (text "**") $
                  filter (not . isEmpty)  $ [ commaPunct ppExtends exts
                                            , maybe empty ppWith with
                                            , if null opens
                                                then empty
                                                else text "open" <+> commaPunct ppOpenSpec opens <+> text "in"
                                            ])

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
      
      ppWith (id,ext,opens) = ppExtends (id,ext) <+> text "with" <+> commaPunct ppOpenSpec opens

ppOptions opts = 
  text "flags" $$
  nest 2 (vcat [text option <+> equals <+> text (show value) <+> semi | (option,value) <- optionsGFO opts])

ppJudgement (id, AbsCat pcont pconstrs) =
  text "cat" <+> ppIdent id <+>
  (case pcont of
     Yes cont -> hsep (map ppDecl cont)
     _        -> empty) <+> semi $$
  case pconstrs of
    Yes costrs -> text "data" <+> ppIdent id <+> equals <+> fsep (intersperse (char '|') (map (ppTerm 0) costrs)) <+> semi
    _          -> empty
ppJudgement (id, AbsFun ptype pexp) =
  (case ptype of
     Yes typ   -> text "fun" <+> ppIdent id <+> colon <+> ppTerm 0 typ <+> semi
     _         -> empty) $$
  (case pexp of
     Yes EData -> empty
     Yes (Eqs [(ps,e)]) -> text "def" <+> ppIdent id <+> hcat (map (ppPatt 2) ps) <+> equals <+> ppTerm 0 e <+> semi
     Yes exp   -> text "def" <+> ppIdent id <+> equals <+> ppTerm 0 exp <+> semi
     _         -> empty)
ppJudgement (id, ResParam pparams) = 
  text "param" <+> ppIdent id <+>
  (case pparams of
     Yes (ps,_) -> equals <+> fsep (intersperse (char '|') (map ppParam ps))
     _          -> empty) <+> semi
ppJudgement (id, ResValue pvalue) = empty
ppJudgement (id, ResOper  ptype pexp) =
  text "oper" <+> ppIdent id <+>
  (case ptype of {Yes t -> colon  <+> ppTerm 0 t; _ -> empty} $$
   case pexp  of {Yes e -> equals <+> ppTerm 0 e; _ -> empty}) <+> semi
ppJudgement (id, ResOverload ids pdefs) = text "oper over" <+> ppIdent id
ppJudgement (id, CncCat  ptype pexp pprn) =
  (case ptype of
     Yes typ -> text "lincat" <+> ppIdent id <+> equals <+> ppTerm 0 typ <+> semi
     _       -> empty) $$
  (case pexp of
     Yes exp -> text "lindef" <+> ppIdent id <+> equals <+> ppTerm 0 exp <+> semi
     _       -> empty) $$
  (case pprn of
     Yes prn -> text "printname" <+> text "cat" <+> ppIdent id <+> equals <+> ppTerm 0 prn <+> semi
     _       -> empty)
ppJudgement (id, CncFun  ptype pdef pprn) =
  (case pdef of
     Yes e -> let (vs,e') = getAbs e
              in text "lin" <+> ppIdent id <+> hsep (map ppIdent vs) <+> equals <+> ppTerm 0 e' <+> semi
     _     -> empty) $$
  (case pprn of
     Yes prn -> text "printname" <+> text "fun" <+> ppIdent id <+> equals <+> ppTerm 0 prn <+> semi
     _       -> empty)
ppJudgement (id, AnyInd cann mid) = text "ind" <+> ppIdent id <+> equals <+> (if cann then text "canonical" else empty) <+> ppIdent mid

ppTerm d (Abs v e)   = let (vs,e') = getAbs e
                       in prec d 0 (char '\\' <> commaPunct ppIdent (v:vs) <+> text "->" <+> ppTerm 0 e')
ppTerm d (T TRaw xs) = case getCTable (T TRaw xs) of
                         ([],_) -> text "table" <+> lbrace <> fsep (map (\x -> ppCase x <> semi) xs) <> rbrace
                         (vs,e) -> prec d 0 (text "\\\\" <> commaPunct ppIdent vs <+> text "=>" <+> ppTerm 0 e)
ppTerm d (T (TTyped t) xs) = text "table" <+> ppTerm 0 t <+> lbrace <> fsep (map (\x -> ppCase x <> semi) xs) <> rbrace
ppTerm d (Prod x a b)= if x == identW
                         then prec d 0 (ppTerm 4 a <+> text "->" <+> ppTerm 0 b)
                         else prec d 0 (parens (ppIdent x <+> colon <+> ppTerm 0 a) <+> text "->" <+> ppTerm 0 b)
ppTerm d (Table kt vt)=prec d 0 (ppTerm 3 kt <+> text "=>" <+> ppTerm 0 vt)
ppTerm d (Let l e)   = let (ls,e') = getLet e
                       in prec d 0 (text "let" <+> vcat (map ppLocDef (l:ls)) $$ text "in" <+> ppTerm 0 e')
ppTerm d (Eqs es)    = text "fn" <+> lbrace $$
                       nest 2 (vcat (map (\e -> ppEquation e <+> semi) es)) $$
                       rbrace
ppTerm d (Example e s)=prec d 0 (text "in" <+> ppTerm 5 e <+> text (show s))
ppTerm d (C e1 e2)   = prec d 1 (ppTerm 2 e1 <+> text "++" <+> ppTerm 1 e2)
ppTerm d (Glue e1 e2)= prec d 2 (ppTerm 3 e1 <+> char '+'  <+> ppTerm 2 e2)
ppTerm d (S x y)     = case x of
                         T annot xs -> let e = case annot of
			                         TTyped t -> Typed y t
			                         TRaw     -> y
			               in text "case" <+> ppTerm 0 e <+> text "of" <+> lbrace $$
			                  nest 2 (fsep (punctuate semi (map ppCase xs))) $$
			                  rbrace
			 _          -> prec d 3 (ppTerm 3 x <+> text "!" <+> ppTerm 4 y)
ppTerm d (ExtR x y)  = prec d 3 (ppTerm 3 x <+> text "**" <+> ppTerm 4 y)
ppTerm d (App x y)   = prec d 4 (ppTerm 4 x <+> ppTerm 5 y)
ppTerm d (V e es)    = text "table" <+> ppTerm 6 e <+> brackets (fsep (punctuate semi (map (ppTerm 0) es)))
ppTerm d (FV es)     = text "variants" <+> braces (fsep (punctuate semi (map (ppTerm 0) es)))
ppTerm d (Alts (e,xs))=text "pre" <+> braces (ppTerm 0 e <> semi <+> fsep (punctuate semi (map ppAltern xs)))
ppTerm d (Strs es)   = text "strs" <+> braces (fsep (punctuate semi (map (ppTerm 0) es)))
ppTerm d (EPatt p)   = prec d 4 (char '#' <+> ppPatt 2 p)
ppTerm d (EPattType t)=prec d 4 (text "pattern" <+> ppTerm 0 t)
ppTerm d (LiT id)    = text "Lin" <+> ppIdent id
ppTerm d (P t l)     = prec d 5 (ppTerm 5 t <> char '.' <> ppLabel l)
ppTerm d (Cn id)     = ppIdent id
ppTerm d (Vr id)     = ppIdent id
ppTerm d (Sort id)   = ppIdent id
ppTerm d (K s)       = text (show s)
ppTerm d (EInt n)    = integer n
ppTerm d (EFloat f)  = double f
ppTerm d (Meta _)    = char '?'
ppTerm d (Empty)     = text "[]"
ppTerm d (EData)     = text "data"
ppTerm d (R xs)      = braces (fsep (punctuate semi [ppLabel l <+> 
                                                     case mb_t of {Just t -> colon <+> ppTerm 0 t; Nothing -> empty} <+>
                                                     equals <+> ppTerm 0 e | (l,(mb_t,e)) <- xs]))
ppTerm d (RecType xs)= braces (fsep (punctuate semi [ppLabel l <+> colon <+> ppTerm 0 t | (l,t) <- xs]))
ppTerm d (Typed e t) = char '<' <> ppTerm 0 e <+> colon <+> ppTerm 0 t <> char '>'

ppEquation (ps,e) = hcat (map (ppPatt 2) ps) <+> text "->" <+> ppTerm 0 e

ppCase (p,e) = ppPatt 0 p <+> text "=>" <+> ppTerm 0 e

ppPatt d (PAlt p1 p2) = prec d 0 (ppPatt 0 p1 <+> char '|' <+> ppPatt 1 p2)
ppPatt d (PSeq p1 p2) = prec d 0 (ppPatt 0 p1 <+> char '+' <+> ppPatt 1 p2)
ppPatt d (PC f ps)    = prec d 1 (ppIdent f <+> hsep (map (ppPatt 2) ps))
ppPatt d (PP f g ps)  = prec d 1 (ppIdent f <> char '.' <> ppIdent g <+> hsep (map (ppPatt 2) ps))
ppPatt d (PRep p)     = prec d 1 (ppPatt 2 p <> char '*')
ppPatt d (PAs f p)    = prec d 1 (ppIdent f <> char '@' <> ppPatt 2 p)
ppPatt d (PNeg p)     = prec d 1 (char '-' <> ppPatt 2 p)
ppPatt d (PChar)      = char '?'
ppPatt d (PChars s)   = brackets (text (show s))
ppPatt d (PMacro id)  = char '#' <> ppIdent id
ppPatt d (PM m id)    = char '#' <> ppIdent m <> char '.' <> ppIdent id
ppPatt d (PV id)      = ppIdent id
ppPatt d (PInt n)     = integer n
ppPatt d (PFloat f)   = double f
ppPatt d (PString s)  = text (show s)
ppPatt d (PR xs)      = braces (hsep (punctuate semi [ppLabel l <+> equals <+> ppPatt 0 e | (l,e) <- xs]))

ppDecl (id,typ)
  | id == identW = ppTerm 4 typ
  | otherwise    = parens (ppIdent id <+> colon <+> ppTerm 0 typ)

ppDDecl (id,typ)
  | id == identW = ppTerm 6 typ
  | otherwise    = parens (ppIdent id <+> colon <+> ppTerm 0 typ)

ppIdent = text . prIdent

ppLabel = ppIdent . label2ident

ppOpenSpec (OSimple id)   = ppIdent id
ppOpenSpec (OQualif id n) = parens (ppIdent id <+> equals <+> ppIdent n)

ppLocDef (id, (mbt, e)) =
  ppIdent id <+>
  (case mbt of {Just t -> colon  <+> ppTerm 0 t; Nothing -> empty} <+> equals <+> ppTerm 0 e) <+> semi


ppAltern (x,y) = ppTerm 0 x <+> char '/' <+> ppTerm 0 y

ppParam (id,cxt) = ppIdent id <+> hsep (map ppDDecl cxt)

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
