{
{-# OPTIONS -fno-warn-overlapping-patterns #-}
module GF.Grammar.Parser
         ( P, runP
         , pModDef
         , pModHeader
         , pExp
         ) where

import GF.Infra.Ident
import GF.Infra.Modules
import GF.Infra.Option
import GF.Data.Operations
import GF.Grammar.Predef
import GF.Grammar.Grammar
import GF.Grammar.Macros
import GF.Grammar.Lexer
import qualified Data.ByteString.Char8 as BS
import GF.Compile.Update (buildAnyTree)
}

%name pModDef ModDef
%partial pModHeader ModHeader
%name pExp Exp

-- no lexer declaration
%monad { P } { >>= } { return }
%lexer { lexer } { T_EOF }
%tokentype { Token }


%token 
 '!'          { T_exclmark  }
 '#'          { T_patt      }
 '$'          { T_int_label }
 '('          { T_oparen    }
 ')'          { T_cparen    }
 '*'          { T_star      }
 '**'         { T_starstar  }
 '+'          { T_plus      }
 '++'         { T_plusplus  }
 ','          { T_comma     }
 '-'          { T_minus     }
 '->'         { T_rarrow    }
 '.'          { T_dot       }
 '/'          { T_alt       }
 ':'          { T_colon     }
 ';'          { T_semicolon }
 '<'          { T_less      }
 '='          { T_equal     }
 '=>'         { T_big_rarrow}
 '>'          { T_great     }
 '?'          { T_questmark }
 '@'          { T_at        }
 '['          { T_obrack    }
 ']'          { T_cbrack    }
 '{'          { T_ocurly    }
 '}'          { T_ccurly    }
 '\\'         { T_lam       }
 '\\\\'       { T_lamlam    }
 '_'          { T_underscore}
 '|'          { T_bar       }
 'PType'      { T_PType     }
 'Str'        { T_Str       }
 'Strs'       { T_Strs      }
 'Tok'        { T_Tok       }
 'Type'       { T_Type      }
 'abstract'   { T_abstract  }
 'case'       { T_case      }
 'cat'        { T_cat       }
 'concrete'   { T_concrete  }
 'data'       { T_data      }
 'def'        { T_def       }
 'flags'      { T_flags     }
 'fun'        { T_fun       }
 'in'         { T_in        }
 'incomplete' { T_incomplete}
 'instance'   { T_instance  }
 'interface'  { T_interface }
 'let'        { T_let       }
 'lin'        { T_lin       }
 'lincat'     { T_lincat    }
 'lindef'     { T_lindef    }
 'of'         { T_of        }
 'open'       { T_open      }
 'oper'       { T_oper      }
 'param'      { T_param     }
 'pattern'    { T_pattern   }
 'pre'        { T_pre       }
 'printname'  { T_printname }
 'resource'   { T_resource  }
 'strs'       { T_strs      }
 'table'      { T_table     }
 'transfer'   { T_transfer  }
 'variants'   { T_variants  }
 'where'      { T_where     }
 'with'       { T_with      }

Integer       { (T_Integer $$) }
Double        { (T_Double  $$) }
String        { (T_String  $$) }
LString       { (T_LString $$) }
Ident         { (T_Ident   $$) }


%%

ModDef :: { SourceModule }
ModDef
  : ComplMod ModType '=' ModBody {%
                                   do let mstat = $1
                                          (mtype,id) = $2
                                          (extends,with,content) = $4
                                          (opens,jments,opts) = case content of { Just c -> c; Nothing -> ([],[],noOptions) }
                                      mapM_ (checkInfoType mtype) jments
                                      defs <- case buildAnyTree id [(i,d) | (i,_,d) <- jments] of
                                                Ok x    -> return x
                                                Bad msg -> fail msg
                                      let poss  = buildTree [(i,(fname,mkSrcSpan p)) | (i,p,_) <- jments]
                                          fname = prIdent id ++ ".gf"
                                          
                                          mkSrcSpan :: (Posn, Posn) -> (Int,Int)
					  mkSrcSpan (Pn l1 _, Pn l2 _) = (l1,l2)

                                      return (id, ModInfo mtype mstat opts extends with opens [] defs poss)  }

ModHeader :: { SourceModule }
ModHeader
  : ComplMod ModType '=' ModHeaderBody { let { mstat = $1 ;
                                               (mtype,id) = $2 ;
                                               (extends,with,opens) = $4 }
                                         in (id, ModInfo mtype mstat noOptions extends with opens [] emptyBinTree emptyBinTree) }

ComplMod :: { ModuleStatus }
ComplMod 
  : {- empty -}  { MSComplete   } 
  | 'incomplete' { MSIncomplete }

ModType :: { (ModuleType Ident,Ident) }
ModType
  : 'abstract'  Ident                    { (MTAbstract,      $2) } 
  | 'resource'  Ident                    { (MTResource,      $2) }
  | 'interface' Ident                    { (MTInterface,     $2) }
  | 'concrete'  Ident 'of' Ident         { (MTConcrete $4,   $2) }
  | 'instance'  Ident 'of' Ident         { (MTInstance $4,   $2) }
  | 'transfer'  Ident ':' Open '->' Open { (MTTransfer $4 $6,$2) }

ModHeaderBody :: { ( [(Ident,MInclude Ident)]
                   , Maybe (Ident,MInclude Ident,[(Ident,Ident)])
                   , [OpenSpec Ident]
                   ) }
ModHeaderBody
  : ListIncluded '**' Included 'with' ListInst '**' ModOpen { ($1, Just (fst $3,snd $3,$5), $7) }
  | ListIncluded '**' Included 'with' ListInst              { ($1, Just (fst $3,snd $3,$5), []) }
  | ListIncluded                               '**' ModOpen { ($1, Nothing,                 $3) }
  | ListIncluded                                            { ($1, Nothing,                 []) }
  |                   Included 'with' ListInst '**' ModOpen { ([], Just (fst $1,snd $1,$3), $5) }
  |                   Included 'with' ListInst              { ([], Just (fst $1,snd $1,$3), []) }
  |                                                 ModOpen { ([], Nothing,                 $1) }

ModOpen :: { [OpenSpec Ident] }
ModOpen
  :                 { [] }
  | 'open' ListOpen { $2 }

ModBody :: { ( [(Ident,MInclude Ident)]
             , Maybe (Ident,MInclude Ident,[(Ident,Ident)])
             , Maybe ([OpenSpec Ident],[(Ident,SrcSpan,Info)],Options)
             ) }
ModBody
  : ListIncluded '**' Included 'with' ListInst '**' ModContent  { ($1, Just (fst $3,snd $3,$5), Just $7) }
  | ListIncluded '**' Included 'with' ListInst                  { ($1, Just (fst $3,snd $3,$5), Nothing) }
  | ListIncluded                               '**' ModContent  { ($1, Nothing,                 Just $3) }
  | ListIncluded                                                { ($1, Nothing,                 Nothing) }
  |                   Included 'with' ListInst '**' ModContent  { ([], Just (fst $1,snd $1,$3), Just $5) }
  |                   Included 'with' ListInst                  { ([], Just (fst $1,snd $1,$3), Nothing) }
  |                                                 ModContent  { ([], Nothing,                 Just $1) }
  | ModBody ';'                                                 { $1                                     }

ModContent :: { ([OpenSpec Ident],[(Ident,SrcSpan,Info)],Options) }
ModContent
  :                      '{' ListTopDef '}' { ([],[d | Left ds <- $2, d <- ds],concatOptions [o | Right o <- $2]) }
  | 'open' ListOpen 'in' '{' ListTopDef '}' { ($2,[d | Left ds <- $5, d <- ds],concatOptions [o | Right o <- $5]) }

ListTopDef :: { [Either [(Ident,SrcSpan,Info)] Options] }
ListTopDef
  : {- empty -}       { []      } 
  | TopDef ListTopDef { $1 : $2 }

ListOpen :: { [OpenSpec Ident] }
ListOpen
  : Open              { [$1]    }
  | Open ',' ListOpen { $1 : $3 }

Open :: { OpenSpec Ident }
Open
  : Ident                   { OSimple $1    }
  | '(' Ident '=' Ident ')' { OQualif $2 $4 }

ListInst :: { [(Ident,Ident)] }
ListInst
  : Inst              { [$1]    }
  | Inst ',' ListInst { $1 : $3 }

Inst :: { (Ident,Ident) }
Inst
  : '(' Ident '=' Ident ')' { ($2,$4) }

ListIncluded :: { [(Ident,MInclude Ident)] }
ListIncluded
  : Included                  { [$1]    }
  | Included ',' ListIncluded { $1 : $3 }

Included :: { (Ident,MInclude Ident) }
Included 
  : Ident                       { ($1,MIAll      ) } 
  | Ident     '[' ListIdent ']' { ($1,MIOnly   $3) }
  | Ident '-' '[' ListIdent ']' { ($1,MIExcept $4) }

TopDef :: { Either [(Ident,SrcSpan,Info)] Options }
TopDef
  : 'cat'             ListCatDef      { Left  $2 }
  | 'fun'             ListFunDef      { Left  $2 }
  | 'def'             ListDefDef      { Left  $2 }
  | 'data'            ListDataDef     { Left  $2 }
  | 'param'           ListParamDef    { Left  $2 }
  | 'oper'            ListOperDef     { Left  $2 }
  | 'lincat'          ListTermDef     { Left  [(f, pos, CncCat (Just e) Nothing    Nothing   ) | (f,pos,e) <- $2] }
  | 'lindef'          ListTermDef     { Left  [(f, pos, CncCat Nothing    (Just e) Nothing   ) | (f,pos,e) <- $2] }
  | 'lin'             ListLinDef      { Left  $2 }
  | 'printname' 'cat' ListTermDef     { Left  [(f, pos, CncCat Nothing    Nothing (Just e)) | (f,pos,e) <- $3] }
  | 'printname' 'fun' ListTermDef     { Left  [(f, pos, CncFun Nothing Nothing (Just e)) | (f,pos,e) <- $3] }
  | 'flags'           ListFlagDef     { Right $2 }

CatDef :: { [(Ident,SrcSpan,Info)] }
CatDef
  : Posn Ident ListDDecl                         Posn { [($2, ($1,$4), AbsCat (Just $3) Nothing)]        }
  | Posn '[' Ident ListDDecl ']'                 Posn { listCatDef $3 ($1,$6) $4 0                 }
  | Posn '[' Ident ListDDecl ']' '{' Integer '}' Posn { listCatDef $3 ($1,$9) $4 (fromIntegral $7) }

FunDef :: { [(Ident,SrcSpan,Info)] }
FunDef
  : Posn ListIdent ':' Exp Posn { [(fun, ($1,$5), AbsFun (Just $4) Nothing (Just [])) | fun <- $2] } 

DefDef :: { [(Ident,SrcSpan,Info)] }
DefDef
  : Posn ListName '=' Exp         Posn { [(f, ($1,$5),AbsFun Nothing (Just 0) (Just [([],$4)])) | f <- $2] }
  | Posn Name ListPatt '=' Exp    Posn { [($2,($1,$6),AbsFun Nothing (Just (length $3)) (Just [($3,$5)]))] }

DataDef :: { [(Ident,SrcSpan,Info)] }
DataDef
  : Posn Ident '=' ListDataConstr Posn { ($2,   ($1,$5), AbsCat Nothing   (Just (map Cn $4))) :
                                         [(fun, ($1,$5), AbsFun Nothing   Nothing Nothing) | fun <- $4] }
  | Posn ListIdent ':' Exp Posn        { [(cat, ($1,$5), AbsCat Nothing   (Just (map Cn $2))) | Ok (_,cat) <- [valCat $4]] ++
                                         [(fun, ($1,$5), AbsFun (Just $4) Nothing Nothing) | fun <- $2] }                                         

ParamDef :: { [(Ident,SrcSpan,Info)] }
ParamDef
  : Posn Ident '=' ListParConstr Posn {  ($2, ($1,$5), ResParam (Just ($4,Nothing))) :
                                        [(f,  ($1,$5), ResValue (Just (mkProdSimple co (Cn $2),Nothing))) | (f,co) <- $4] }
  | Posn Ident                   Posn { [($2, ($1,$3), ResParam Nothing)] }

OperDef :: { [(Ident,SrcSpan,Info)] }
OperDef
  : Posn ListName ':' Exp         Posn { [(i, ($1,$5), info) | i <- $2,   info <- mkOverload (Just $4) Nothing  ] } 
  | Posn ListName '=' Exp         Posn { [(i, ($1,$5), info) | i <- $2,   info <- mkOverload Nothing   (Just $4)] }
  | Posn Name ListArg '=' Exp     Posn { [(i, ($1,$6), info) | i <- [$2], info <- mkOverload Nothing   (Just (mkAbs $3 $5))] }
  | Posn ListName ':' Exp '=' Exp Posn { [(i, ($1,$7), info) | i <- $2,   info <- mkOverload (Just $4) (Just $6)] }

LinDef :: { [(Ident,SrcSpan,Info)] }
LinDef
  : Posn ListName '=' Exp         Posn { [(f,  ($1,$5), CncFun Nothing (Just $4) Nothing) | f <- $2] }
  | Posn Name ListArg '=' Exp     Posn { [($2, ($1,$6), CncFun Nothing (Just (mkAbs $3 $5)) Nothing)] }

TermDef :: { [(Ident,SrcSpan,Term)] }
TermDef
  : Posn ListName '=' Exp Posn { [(i,($1,$5),$4) | i <- $2] } 

FlagDef :: { Options }
FlagDef
  : Posn Ident '=' Ident Posn  {% case parseModuleOptions ["--" ++ prIdent $2 ++ "=" ++ prIdent $4] of
                                    Ok  x   -> return x
                                    Bad msg -> failLoc $1 msg                                           } 

ListDataConstr :: { [Ident] }
ListDataConstr
  : Ident                    { [$1]    }
  | Ident '|' ListDataConstr { $1 : $3 }

ParConstr :: { Param }
ParConstr
  : Ident ListDDecl { ($1,$2) } 

ListLinDef :: { [(Ident,SrcSpan,Info)] }
ListLinDef
  : LinDef ';'            { $1       } 
  | LinDef ';' ListLinDef { $1 ++ $3 }

ListDefDef :: { [(Ident,SrcSpan,Info)] }
ListDefDef
  : DefDef ';'            { $1       } 
  | DefDef ';' ListDefDef { $1 ++ $3 }

ListOperDef :: { [(Ident,SrcSpan,Info)] }
ListOperDef
  : OperDef ';'             { $1       } 
  | OperDef ';' ListOperDef { $1 ++ $3 }

ListCatDef :: { [(Ident,SrcSpan,Info)] }
ListCatDef
  : CatDef ';'            { $1       } 
  | CatDef ';' ListCatDef { $1 ++ $3 }

ListFunDef :: { [(Ident,SrcSpan,Info)] }
ListFunDef
  : FunDef ';'            { $1       }
  | FunDef ';' ListFunDef { $1 ++ $3 }

ListDataDef :: { [(Ident,SrcSpan,Info)] }
ListDataDef
  : DataDef ';'             { $1       } 
  | DataDef ';' ListDataDef { $1 ++ $3 }

ListParamDef :: { [(Ident,SrcSpan,Info)] }
ListParamDef
  : ParamDef ';'              { $1       } 
  | ParamDef ';' ListParamDef { $1 ++ $3 }

ListTermDef :: { [(Ident,SrcSpan,Term)] }
ListTermDef
  : TermDef ';'             { $1       } 
  | TermDef ';' ListTermDef { $1 ++ $3 }

ListFlagDef :: { Options }
ListFlagDef
  : FlagDef ';'               { $1               } 
  | FlagDef ';' ListFlagDef   { addOptions $1 $3 }

ListParConstr :: { [Param] }
ListParConstr
  : ParConstr                   { [$1]    }
  | ParConstr '|' ListParConstr { $1 : $3 }

ListIdent :: { [Ident] }
ListIdent
  : Ident               { [$1]    } 
  | Ident ',' ListIdent { $1 : $3 }

Name :: { Ident }
Name
  : Ident         { $1          } 
  | '[' Ident ']' { mkListId $2 }

ListName :: { [Ident] }
ListName
  : Name              { [$1]    }
  | Name ',' ListName { $1 : $3 }

LocDef :: { [(Ident, Maybe Type, Maybe Term)] }
LocDef
  : ListIdent ':' Exp         { [(lab,Just $3,Nothing) | lab <- $1] } 
  | ListIdent '=' Exp         { [(lab,Nothing,Just $3) | lab <- $1] }
  | ListIdent ':' Exp '=' Exp { [(lab,Just $3,Just $5) | lab <- $1] }

ListLocDef :: { [(Ident, Maybe Type, Maybe Term)] }
ListLocDef
  : {- empty -}           { []       } 
  | LocDef                { $1       }
  | LocDef ';' ListLocDef { $1 ++ $3 }

Exp :: { Term }
Exp
  : Exp1 '|' Exp                      { FV [$1,$3] } 
  | '\\'   ListBind '->' Exp          { mkAbs $2 $4 }
  | '\\\\' ListBind '=>' Exp          { mkCTable $2 $4 }
  | Decl '->' Exp                     { mkProdSimple $1 $3 }
  | Exp3 '=>' Exp                     { Table $1 $3 }
  | 'let' '{' ListLocDef '}' 'in' Exp {%
                                        do defs <- mapM tryLoc $3
                                           return $ mkLet defs $6 }
  | 'let' ListLocDef 'in' Exp         {%
                                        do defs <- mapM tryLoc $2
                                           return $ mkLet defs $4 }
  | Exp3 'where' '{' ListLocDef '}'   {%
                                        do defs <- mapM tryLoc $4
                                           return $ mkLet defs $1 }
  | 'in' Exp5 String                  { Example $2 $3 }
  | Exp1                              { $1 }

Exp1 :: { Term }
Exp1
  : Exp2 '++' Exp1 { C $1 $3 } 
  | Exp2           { $1      }

Exp2 :: { Term }
Exp2
  : Exp3 '+' Exp2 { Glue $1 $3 } 
  | Exp3          { $1         }

Exp3 :: { Term }
Exp3
  : Exp3 '!' Exp4                    { S $1 $3       } 
  | 'table' '{' ListCase '}'         { T TRaw $3     }
  | 'table' Exp6 '{' ListCase '}'    { T (TTyped $2) $4 }
  | 'table' Exp6 '[' ListExp ']'     { V $2 $4       }
  | Exp3 '*'  Exp4                   { case $1 of
                                         RecType xs -> RecType (xs ++ [(tupleLabel (length xs+1),$3)])
                                         t          -> RecType [(tupleLabel 1,$1), (tupleLabel 2,$3)]  }
  | Exp3 '**' Exp4                   { ExtR $1 $3    }
  | Exp4                             { $1            }

Exp4 :: { Term }
Exp4
  : Exp4 Exp5                        { App $1 $2     } 
  | 'case' Exp 'of' '{' ListCase '}' { let annot = case $2 of
                                             Typed _ t -> TTyped t
                                             _         -> TRaw
                                       in S (T annot $5) $2         }
  | 'variants' '{' ListExp '}'       { FV $3         }
  | 'pre' '{' ListCase '}'           {% mkAlts $3     }
  | 'pre' '{' String ';' ListAltern '}' { Alts (K $3, $5) }
  | 'pre' '{' Ident ';' ListAltern '}' { Alts (Vr $3, $5) }
  | 'strs' '{' ListExp '}'           { Strs $3       }
  | '#' Patt2                        { EPatt $2      }
  | 'pattern' Exp5                   { EPattType $2  }
  | 'lincat' Ident Exp5              { ELincat $2 $3 }
  | 'lin' Ident Exp5                 { ELin $2 $3 }
  | Exp5                             { $1            }

Exp5 :: { Term }
Exp5
  : Exp5 '.' Label            { P  $1 $3 } 
  | Exp6                      { $1       }

Exp6 :: { Term }
Exp6 
  : Ident                 { Vr $1 } 
  | Sort                  { Sort $1 }
  | String                { K $1 }
  | Integer               { EInt $1 }
  | Double                { EFloat $1 }
  | '?'                   { Meta (int2meta 0) }
  | '[' ']'               { Empty }
  | '[' Ident Exps ']'    { foldl App (Vr (mkListId $2)) $3 }
  | '[' String ']'        { case $2 of
                              []   -> Empty
                              str  -> foldr1 C (map K (words str)) }
  | '{' ListLocDef '}'    {% mkR $2 }
  | '<' ListTupleComp '>' { R (tuple2record $2) }
  | '<' Exp ':' Exp '>'   { Typed $2 $4      }
  | LString               { K $1 }
  | '(' Exp ')'           { $2 }

ListExp :: { [Term] }
ListExp
  : {- empty -}     { []      } 
  | Exp             { [$1]    }
  | Exp ';' ListExp { $1 : $3 }

Exps :: { [Term] }
Exps
  : {- empty -}     { []      } 
  | Exp6 Exps       { $1 : $2 }

Patt :: { Patt }
Patt
  : Patt '|' Patt1            { PAlt $1 $3 } 
  | Patt '+' Patt1            { PSeq $1 $3 }
  | Patt1                     { $1         }

Patt1 :: { Patt }
Patt1
  : Ident ListPatt            { PC $1 $2 } 
  | Ident '.' Ident ListPatt  { PP $1 $3 $4 }
  | Patt2 '*'                 { PRep $1 }
  | Ident '@' Patt2           { PAs $1 $3 }
  | '-' Patt2                 { PNeg $2 }
  | Patt2                     { $1 }

Patt2 :: { Patt }
Patt2
  : '?'                       { PChar } 
  | '[' String ']'            { PChars $2 }
  | '#' Ident                 { PMacro $2 }
  | '#' Ident '.' Ident       { PM $2 $4 }
  | '_'                       { PW }
  | Ident                     { PV $1 }
  | '{' Ident '}'             { PC $2 [] }
  | Ident '.' Ident           { PP $1 $3 [] }
  | Integer                   { PInt $1 }
  | Double                    { PFloat  $1 }
  | String                    { PString $1 }
  | '{' ListPattAss '}'       { PR $2 }
  | '<' ListPattTupleComp '>' { (PR . tuple2recordPatt) $2 }
  | '(' Patt ')'              { $2 }

Arg :: { Ident }
Arg 
  : '_'                       { identW }
  | Ident                     { $1     }

PattAss :: { [(Label,Patt)] }
PattAss
  : ListIdent '=' Patt { [(LIdent (ident2bs i),$3) | i <- $1] } 

Label :: { Label }
Label
  : Ident       { LIdent (ident2bs $1)   } 
  | '$' Integer { LVar (fromIntegral $2) }

Sort :: { Ident }
Sort
  : 'Type'  { cType  } 
  | 'PType' { cPType }
  | 'Tok'   { cTok   }
  | 'Str'   { cStr   }
  | 'Strs'  { cStrs  }

ListPattAss :: { [(Label,Patt)] }
ListPattAss
  : {- empty -}             { []       }
  | PattAss                 { $1       }
  | PattAss ';' ListPattAss { $1 ++ $3 }

ListPatt :: { [Patt] }
ListPatt
  : Patt2          { [$1]    } 
  | Patt2 ListPatt { $1 : $2 }

ListArg :: { [Ident] }
ListArg
  : Arg         { [$1]    } 
  | Arg ListArg { $1 : $2 }

Bind :: { Ident }
Bind
  : Ident  { $1     } 
  | '_'    { identW }

ListBind :: { [Ident] }
ListBind
  : Bind              { [$1]    }
  | Bind ',' ListBind { $1 : $3 }

Decl :: { [Decl] }
Decl
  : '(' ListBind ':' Exp ')' { [(x,$4) | x <- $2] } 
  | Exp4                     { [mkDecl $1]        }

ListTupleComp :: { [Term] }
ListTupleComp
  : {- empty -}           { []      } 
  | Exp                   { [$1]    }
  | Exp ',' ListTupleComp { $1 : $3 }

ListPattTupleComp :: { [Patt] }
ListPattTupleComp
  : {- empty -}                { []      } 
  | Patt                       { [$1]    }
  | Patt ',' ListPattTupleComp { $1 : $3 }

Case :: { Case }
Case
  : Patt '=>' Exp { ($1,$3) } 

ListCase :: { [Case] }
ListCase
  : Case              { [$1]    } 
  | Case ';' ListCase { $1 : $3 }

Altern :: { (Term,Term) }
Altern
  : Exp '/' Exp { ($1,$3) } 

ListAltern :: { [(Term,Term)] }
ListAltern
  : Altern                { [$1]    }
  | Altern ';' ListAltern { $1 : $3 }

DDecl :: { [Decl] }
DDecl
  : '(' ListBind ':' Exp ')' { [(x,$4) | x <- $2] } 
  | Exp6                     { [mkDecl $1]        }

ListDDecl :: { [Decl] }
ListDDecl
  : {- empty -}     { []       } 
  | DDecl ListDDecl { $1 ++ $2 }

Posn :: { Posn }
Posn
  : {- empty -}     {% getPosn } 


{

happyError :: P a
happyError = fail "parse error"

mkListId,mkConsId,mkBaseId  :: Ident -> Ident
mkListId = prefixId (BS.pack "List")
mkConsId = prefixId (BS.pack "Cons")
mkBaseId = prefixId (BS.pack "Base")

prefixId :: BS.ByteString -> Ident -> Ident
prefixId pref id = identC (BS.append pref (ident2bs id))

listCatDef id pos cont size = [catd,nilfund,consfund]
  where
    listId = mkListId id
    baseId = mkBaseId id
    consId = mkConsId id

    catd     = (listId, pos, AbsCat (Just cont')   (Just [Cn baseId,Cn consId]))
    nilfund  = (baseId, pos, AbsFun (Just niltyp)  Nothing Nothing)
    consfund = (consId, pos, AbsFun (Just constyp) Nothing Nothing)

    cont' = [(mkId x i,ty) | (i,(x,ty)) <- zip [0..] cont]
    xs = map (Vr . fst) cont'
    cd = mkDecl (mkApp (Vr id) xs)
    lc = mkApp (Vr listId) xs

    niltyp  = mkProdSimple (cont' ++ replicate size cd) lc
    constyp = mkProdSimple (cont' ++ [cd, mkDecl lc]) lc

    mkId x i = if isWildIdent x then (varX i) else x

tryLoc (c,mty,Just e) = return (c,(mty,e))
tryLoc (c,_  ,_     ) = fail ("local definition of" +++ prIdent c +++ "without value")

mkR []       = return $ RecType [] --- empty record always interpreted as record type
mkR fs@(f:_) =
  case f of
    (lab,Just ty,Nothing) -> mapM tryRT fs >>= return . RecType
    _                     -> mapM tryR  fs >>= return . R
  where
    tryRT (lab,Just ty,Nothing) = return (ident2label lab,ty)
    tryRT (lab,_      ,_      ) = fail $ "illegal record type field" +++ prIdent lab --- manifest fields ?!

    tryR (lab,mty,Just t) = return (ident2label lab,(mty,t))
    tryR (lab,_  ,_     ) = fail $ "illegal record field" +++ prIdent lab

mkOverload pdt pdf@(Just df) =
  case appForm df of
    (keyw, ts@(_:_)) | isOverloading keyw -> 
       case last ts of
         R fs -> [ResOverload [m | Vr m <- ts] [(ty,fu) | (_,(Just ty,fu)) <- fs]]
         _    -> [ResOper pdt pdf]
    _         -> [ResOper pdt pdf]

     -- to enable separare type signature --- not type-checked
mkOverload pdt@(Just df) pdf =
  case appForm df of
    (keyw, ts@(_:_)) | isOverloading keyw ->
       case last ts of
         RecType _ -> [] 
         _         -> [ResOper pdt pdf]
    _              -> [ResOper pdt pdf]
mkOverload pdt pdf = [ResOper pdt pdf]

isOverloading t =
  case t of
    Vr keyw | prIdent keyw == "overload" -> True      -- overload is a "soft keyword"
    _                                    -> False


type SrcSpan = (Posn,Posn)


checkInfoType MTAbstract       (id,pos,info) =
  case info of
    AbsCat _ _   -> return ()
    AbsFun _ _ _ -> return ()
    _            -> failLoc (fst pos) "illegal definition in abstract module" 
checkInfoType MTResource       (id,pos,info) =
  case info of
    ResParam _   -> return ()
    ResValue _   -> return ()
    ResOper  _ _ -> return ()
    ResOverload _ _ -> return ()
    _            -> failLoc (fst pos) "illegal definition in resource module" 
checkInfoType MTInterface      (id,pos,info) =
  case info of
    ResParam _   -> return ()
    ResValue _   -> return ()
    ResOper  _ _ -> return ()
    ResOverload _ _ -> return ()
    _            -> failLoc (fst pos) "illegal definition in interface module" 
checkInfoType (MTConcrete _)   (id,pos,info) =
  case info of
    CncCat _ _ _ -> return ()
    CncFun _ _ _ -> return ()
    ResParam _   -> return ()
    ResValue _   -> return ()
    ResOper  _ _ -> return ()
    ResOverload _ _ -> return ()
    _            -> failLoc (fst pos) "illegal definition in concrete module" 
checkInfoType (MTInstance _)   (id,pos,info) =
  case info of
    ResParam _   -> return ()
    ResValue _   -> return ()
    ResOper  _ _ -> return ()
    _            -> failLoc (fst pos) "illegal definition in instance module" 
checkInfoType (MTTransfer _ _) (id,pos,info) =
  case info of
    AbsCat _ _   -> return ()
    AbsFun _ _ _ -> return ()
    _            -> failLoc (fst pos) "illegal definition in transfer module" 


mkAlts cs = case cs of
  _:_ -> do
    def  <- mkDef (last cs)
    alts <- mapM mkAlt (init cs)
    return (Alts (def,alts))
  _ -> fail "empty alts"
 where
   mkDef (_,t) = return t
   mkAlt (p,t) = do
     ss <- mkStrs p
     return (t,ss)
   mkStrs p = case p of
     PAlt a b -> do
       Strs as <- mkStrs a
       Strs bs <- mkStrs b
       return $ Strs $ as ++ bs
     PString s -> return $ Strs [K s]
     PV x -> return (Vr x) --- for macros; not yet complete
     PMacro x -> return (Vr x) --- for macros; not yet complete
     PM m c -> return (Q m c) --- for macros; not yet complete
     _ -> fail "no strs from pattern"

}

