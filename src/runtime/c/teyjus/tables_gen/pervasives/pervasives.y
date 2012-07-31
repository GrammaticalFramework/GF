%{
//////////////////////////////////////////////////////////////////////////////
// This file is part of Teyjus.                                             //
//                                                                          //
// Teyjus is free software: you can redistribute it and/or modify           //
// it under the terms of the GNU General Public License as published by     //
// the Free Software Foundation, either version 3 of the License, or        //
// (at your option) any later version.                                      //
//                                                                          //
// Teyjus is distributed in the hope that it will be useful,                //
// but WITHOUT ANY WARRANTY; without even the implied warranty of           //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            //
// GNU General Public License for more details.                             //
//                                                                          //
// You should have received a copy of the GNU General Public License        //
// along with Teyjus.  If not, see <http://www.gnu.org/licenses/>.          //
//////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>
#include "../util/util.h" 
#include "op.h" 
#include "types.h"
#include "pervgen-c.h"
#include "pervgen-ocaml.h"
//#include "ops.h"

extern int yylex();

int yywrap() {return 1;}

void yyerror(const char* str)
{
    printf("Error: Unable to parse input: %s\n", str);
}

static int tySkelInd = 0;
 
%}

%union
{
    char*            name;  
    char*            text;
    OP_Fixity        fixityType;
    OP_Prec          precType;
    OP_Code          codeType;
    UTIL_Bool        boolType;
    struct 
    {
        int   ival;
        char* sval;
    }                isval;
    Type             tyval;
    TypeList         tylistval;
}

%token             LBRACKET RBRACKET LPAREN RPAREN COMMA POUND SEMICOLON TRUE 
                   FALSE
                   TYARROW TYAPP
                   INFIX INFIXL INFIXR PREFIX PREFIXR POSTFIX POSTFIXL NOFIXITY
                   MIN1 MIN2 MAX
                   NOCODE
                   LSSYMB LSSTART LSEND PREDSYMB PREDSTART PREDEND REGCL
                   BACKTRACK
                   KIND CONST EMPTY TYSKEL TYPE EMPTYTYPE ERROR

%token <name>      ID
%token <isval>     NUM
%token <text>      STRING


%start              pervasives
%type  <text>       comments
%type  <tyval>      arrow_tyskel app_tyskel atomic_tyskel
%type  <tylistval>  tyskel_list
%type  <isval>      ty_index tesize neededness
%type  <name>       const_name const_ind_name 
%type  <fixityType> fixity
%type  <precType>   prec
%type  <codeType>   code_info
%type  <boolType>   redef typrev
%% 

pervasives  : kind const_tyskel
            ;

kind        : kind_header kind_decls
              { cgenKindH(); cgenKindC(); ocamlGenKinds(); }
            ;

kind_header : KIND NUM
              { cgenKindInit($2.ival); cgenNumKinds($2.sval); 
                ocamlGenNumKinds($2.sval);
              }
            ;

kind_decls  : kind_decl SEMICOLON kind_decls
            | kind_decl
            ;

kind_decl   : NUM ID ID NUM
              { cgenKindIndex($1.ival, $3, $1.sval, NULL);
                cgenKindData($1.ival, $2, $4.sval, NULL);
                ocamlGenKind($2, $3, $4.sval, $1.sval); }            
            | comments NUM ID ID NUM
              { cgenKindIndex($2.ival, $4, $2.sval, $1);
                cgenKindData($2.ival, $3, $5.sval, $1);
                ocamlGenKind($3, $4, $5.sval, $2.sval); }
            ;

comments    : STRING { $$ = $1;};
            ;

const_tyskel : const_tyskel_header const_tyskel_decls  const_property
               {  cgenTySkelsH(); cgenTySkelsC(); cgenConstProperty();
                  cgenConstH();   cgenConstC();
                  ocamlGenConsts(); 
               }
             ;


const_tyskel_header : CONST NUM TYSKEL NUM 
                      { cgenNumTySkels($4.sval); cgenTySkelInit($4.ival);
                        cgenNumConsts($2.sval);  cgenConstInit($2.ival);
                        ocamlGenNumConsts($2.sval);
                      }
                    ;

const_tyskel_decls  : const_tyskel_decl SEMICOLON const_tyskel_decls 
                    | const_tyskel_decl
                    ;

const_tyskel_decl   : tyskel_decl const_decls
                    ;

tyskel_decl         : TYPE NUM arrow_tyskel
                      {tySkelInd = $2.ival;
                       ocamlGenTySkel($2.sval, $3);
                       cgenTySkelTab($2.ival, $3, NULL);
                      }
                    | comments TYPE NUM arrow_tyskel
                      {tySkelInd = $3.ival; 
                       ocamlGenTySkel($3.sval, $4);
                       cgenTySkelTab($3.ival, $4, $1);
                      } 
                    ;


arrow_tyskel        : app_tyskel TYARROW arrow_tyskel
                      { $$ = mkArrowType($1, $3); }
                    | app_tyskel
                      { $$ = $1; }                   
                    ; 

app_tyskel          : LPAREN TYAPP ID NUM LBRACKET tyskel_list 
                      RBRACKET RPAREN
                      {$$ = mkStrType(mkStrFuncType($3,$4.sval), $4.ival, $6);}
                    | atomic_tyskel
                      {$$ = $1; }
                    ;          

atomic_tyskel       : ID
                      { $$ = mkSortType($1); }
                    | ty_index 
                      { $$ = mkSkVarType($1.sval); }
                    | LPAREN arrow_tyskel RPAREN
                      { $$ = $2; }
                    ;

tyskel_list         : arrow_tyskel COMMA tyskel_list
                      { $$ = addItem($1, $3); }
                    | arrow_tyskel 
                      { $$ = addItem($1, NULL); }

ty_index            : POUND NUM  {$$ = $2;}    
                    ;

const_decls         : const_decl const_decls
                    | const_decl
                    ;

const_decl          : NUM const_name const_ind_name tesize tesize neededness
                      typrev redef prec fixity code_info
                      { cgenConstIndex($1.ival, $3, $1.sval, NULL);
                        cgenConstData($1.ival, $2, $4.sval, $9, $10, tySkelInd,
                                      $5.sval, NULL);
                        ocamlGenConst($1.sval, $2, $3, $10, $9, $7, $8, 
                                      $4.ival, tySkelInd, $6.ival, $11,
                                      $1.sval, $2);
                      }
                    | NUM const_name const_ind_name tesize tesize neededness
                      typrev redef prec fixity code_info const_name
                      { cgenConstIndex($1.ival, $3, $1.sval, NULL);
                        cgenConstData($1.ival, $12, $4.sval, $9, $10, tySkelInd,
                                      $5.sval, NULL);
                        ocamlGenConst($1.sval, $2, $3, $10, $9, $7, $8, 
                                      $4.ival, tySkelInd, $6.ival, $11,
                                      $1.sval, $12);
                      }
                    | comments NUM const_name const_ind_name tesize tesize
                      neededness typrev redef prec fixity code_info
                      { cgenConstIndex($2.ival, $4, $2.sval, $1);
                        cgenConstData($2.ival, $3, $5.sval, $10, $11, 
                                      tySkelInd, $7.sval, $1);
                        ocamlGenConst($2.sval, $3, $4, $11, $10, $8, $9, 
                                      $5.ival, tySkelInd, $7.ival, $12, 
                                      $2.sval, $3);
                      }
                    | comments NUM const_name const_ind_name tesize tesize
                      neededness typrev redef prec fixity code_info const_name
                      { cgenConstIndex($2.ival, $4, $2.sval, $1);
                        cgenConstData($2.ival, $13, $5.sval, $10, $11, 
                                      tySkelInd, $7.sval, $1);
                        ocamlGenConst($2.sval, $3, $4, $11, $10, $8, $9, 
                                      $5.ival, tySkelInd, $7.ival, $12, 
                                      $2.sval, $13);
                      }
                    ;

const_name          : ID  {$$ = $1;}
                    ;
const_ind_name      : ID  {$$ = $1;}
                    ;

tesize              : NUM {$$ = $1;}
                    ;
neededness          : NUM {$$ = $1;}
                    ;

typrev              : TRUE  {$$ = UTIL_TRUE;}
                    | FALSE {$$ = UTIL_FALSE;}
                    ;

redef               : TRUE  {$$ = UTIL_TRUE;}
                    | FALSE {$$ = UTIL_FALSE;}
                    ;

fixity              : INFIX      {$$ = OP_INFIX;}
                    | INFIXL     {$$ = OP_INFIXL;}
                    | INFIXR     {$$ = OP_INFIXR;}
                    | PREFIX     {$$ = OP_PREFIX;}
                    | PREFIXR    {$$ = OP_PREFIXR;}
                    | POSTFIX    {$$ = OP_POSTFIX;}
                    | POSTFIXL   {$$ = OP_POSTFIXL;}
                    | NOFIXITY   {$$ = OP_NONE;}
                    ;

prec                : MIN1       {$$ = OP_mkPrecMin1();}
                    | MIN2       {$$ = OP_mkPrecMin2();}
                    | NUM        {$$ = OP_mkPrec($1.ival);}
                    | MAX        {$$ = OP_mkPrecMax();} 
                    ;

code_info           : NOCODE     {$$ = OP_mkCodeInfoNone();}
                    | NUM        {$$ = OP_mkCodeInfo($1.ival);} 
                    ;

const_property      : logic_symbol pred_symbol regclobber backtrackable
                    ;

logic_symbol        : ls_header ls_range ls_types
                    ;

ls_header           : LSSYMB NUM { cgenLogicSymbolInit($2.ival); }
                    ;

ls_range            : LSSTART const_ind_name LSEND const_ind_name 
                      { cgenLSRange($2, $4);} 
                    ;

ls_types            : ls_type ls_types
                    | ls_type
                    ;

ls_type             : NUM ID  {cgenLogicSymbType($1.ival, $2, $1.sval);}
                    ;

pred_symbol         : pred_header pred_range 
                    ;

pred_header         : PREDSYMB NUM      
                      {if ($2.ival == 0) {
                       fprintf(stderr,
                          "The number of predicate symbols cannot be 0\n");
                       exit(1);
                       } 
                      }
                    ;

pred_range          : PREDSTART const_ind_name PREDEND const_ind_name
                      { cgenPREDRange($2, $4); }
                    ;

regclobber          : REGCL const_list  { ocamlGenRC(); }
                    ;

backtrackable       : BACKTRACK const_list  { ocamlGenBC(); }
                    ;

const_list          : ID const_list { ocamlCollectConsts($1, 0); }
                    | ID            { ocamlCollectConsts($1, 1); }
                    ;

%%

extern FILE* yyin;

int main(argc, argv)
    int argc;
    char * argv[];
{
    int ret = 0;
    char * root = NULL;
    if(argc == 1)
    {
      //printf("No input file specified; using 'Pervasives.in'.\n");
      yyin = UTIL_fopenR("pervasives.in");
    }
    else
    {
      yyin = UTIL_fopenR(argv[1]);
    }
    
    if(argc > 2)
    {
      root = argv[2];
    }
    else
    {
      //printf("Teyjus source root directory not specified; using '../../'.\n");
      root = "../../";
    }
    
    //printf("Generating pervasive files...\n");

    ret = yyparse();
    UTIL_fclose(yyin);

    if(ret != 0)
    {
      printf("Generation failed.\n");
      return -1;
    }
    spitCPervasivesH(root);
    spitCPervasivesC(root); 
    //spitOCPervasiveMLI(root);
    //spitOCPervasiveML(root); 
    //printf("Done.\n");
    return 0;
}
