%{
//////////////////////////////////////////////////////////////////////////////
//Copyright 2008
//  Andrew Gacek, Steven Holte, Gopalan Nadathur, Xiaochu Qi, Zach Snow
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
#include "instrgen-c.h"
#include "instrgen-ocaml.h"
#include "../util/util.h"

extern int yylex();

int yywrap() {return 1;}

void yyerror(const char* str)
{
    printf("%s\n", str);
}
 
%}

%union{
    char*    name;
    char*    text;
    struct
    {
        int    ival;
        char*  sval;
    }        isval;
}

%token          OPTYPES INSTRCAT INSTRUCTIONS OPCODE MAXOPERAND  
                CALL_I1_LEN SEMICOLON ERROR LBRACKET RBRACKET
%token <name>   ID
%token <isval>  NUM
%token <text>   STRING STRING2

%start          instr_format
%type  <name>   operand_name operand_tname operand_type instr_name instr_cat 
                instr_head instr_length operand_comp_type
%type  <text>   comments compiler_include        
%type  <isval>  max_operand opcode operand_size
%%
    
instr_format   : compiler_include operands instrcats instructions

compiler_include : STRING2 { ocgenInclude($1);}


operands       : OPTYPES operand_decs opcode_type 
                 { cgenOpsH(); ocgenOps();}
               ;

operand_decs   : operand_dec operand_decs
               | operand_dec_last
               ;

operand_dec    : operand_name operand_tname operand_type operand_size operand_comp_type comments
                 { cgenOpTypes($1, $2, $3, $6, 0); 
                   ocgenOpType($1, $4.ival, $5);
                 }
               | operand_name comments
                 { cgenOpTypes($1, NULL, NULL, $2, 0); }       
               ;

operand_dec_last :  operand_name operand_tname operand_type operand_size operand_comp_type comments
                    { cgenOpTypes($1, $2, $3, $6, 1); 
                      ocgenOpType($1, $4.ival, $5);
                    }   
                 |  operand_name comments
                    { cgenOpTypes($1, NULL, NULL, $2, 1); } 
                 ;


operand_name   : ID { $$ = $1; }
               ;

operand_tname  : ID { $$ = $1; }
               ;

operand_type   : ID { $$ = $1; }
               ;

operand_comp_type : ID { $$ = $1; }
                  ;

comments       : STRING {$$ = $1; }
               ;

operand_size   : NUM { $$ = $1; }
               ;

opcode_type    : OPCODE ID operand_size 
                 { cgenOpCodeType($2); 
                   ocgenOpCodeType($3.ival);}
               ;

instrcats      : INSTRCAT max_operand instrcat_decs CALL_I1_LEN NUM
                 { cgenInstrCatH($5.sval); cgenInstrCatC($2.sval);
                   ocgenInstrCat();
                 }
               ;

max_operand    : MAXOPERAND NUM   { $$ = $2; }
               ;

instrcat_decs  : instrcat_dec instrcat_decs 
               | instrcat_dec_last
               ;

instrcat_dec   : ID LBRACKET instr_format RBRACKET instr_lengths
                 { cgenOneInstrCatH($1, 0); cgenOneInstrCatC($1, 0);
                   ocgenOneInstrCat($1);
                 } 
               ;

instrcat_dec_last : ID LBRACKET instr_format RBRACKET instr_lengths
                    { cgenOneInstrCatH($1, 1); cgenOneInstrCatC($1, 1);
		      ocgenOneInstrCat($1);
		    } 
               ;

instr_format  : oneOp instr_format
              | lastOp
              ;  

oneOp         : ID { cgenInstrFormat($1, 0); ocgenInstrFormat($1); }
              ;

lastOp        : ID { cgenInstrFormat($1, 1); ocgenInstrFormat($1); }
              ;
              

instr_lengths : instr_len_first SEMICOLON instr_lengths_rest
              | instr_len_first
              ;

instr_lengths_rest : instr_len SEMICOLON instr_lengths_rest
                   | instr_len
                   ;

instr_len_first : ID NUM 
                  {cgenInstrLength($1, $2.sval); 
                   ocgenInstrLength($1, $2.sval);}
                ;

instr_len     : ID NUM  { cgenInstrLength($1, $2.sval);}
              ;


instructions  : instr_head instrs
                { cgenInstrH($1); cgenInstrC(); cgenSimDispatch();
                  ocgenInstr();
                }
              ;

instr_head    : INSTRUCTIONS NUM  
                { cinitInstrC($2.ival); 
                  cinitSimDispatch($2.ival); 
                  $$ = $2.sval; 
                }
              ;


instrs        : instr SEMICOLON instrs
              | last_instr
              ;

instr         : comments opcode instr_name instr_cat instr_length
                { cgenOneInstrH($1, $2.sval , $3);
                  cgenOneInstrC($2.ival, $3, $4, $5, 0);
                  cgenOneSimDispatch($2.ival, $3, 0);
                  ocgenOneInstr($2.sval, $3, $4, $5, 0);
                }
              | opcode instr_name instr_cat instr_length
                { cgenOneInstrH(NULL, $1.sval , $2);
                  cgenOneInstrC($1.ival, $2, $3, $4, 0);
                  cgenOneSimDispatch($1.ival, $2, 0);
                  ocgenOneInstr($1.sval, $2, $3, $4, 0);
                }
              ;

last_instr    : comments opcode instr_name instr_cat instr_length
                { cgenOneInstrH($1, $2.sval , $3);
                  cgenOneInstrC($2.ival, $3, $4, $5, 1);
                  cgenOneSimDispatch($2.ival, $3, 1); 
                  ocgenOneInstr($2.sval, $3, $4, $5, 1);
                }
              |  opcode instr_name instr_cat instr_length
                { cgenOneInstrH(NULL, $1.sval , $2);
                  cgenOneInstrC($1.ival, $2, $3, $4, 1);
                  cgenOneSimDispatch($1.ival, $2, 1);
                  ocgenOneInstr($1.sval, $2, $3, $4, 1);
                }
              ;
 
opcode        : NUM { $$ = $1; }
              ;

instr_name    : ID { $$ = $1; }
              ;

instr_cat     : ID { $$ = $1; }
              ;

instr_length  : ID { $$ = $1; }
              ; 


%%

extern FILE* yyin;

int main(argc, argv)
    int argc;
    char * argv[];
{
    char * root = NULL;
    int ret = 0;
    
    if(argc <= 1)
    {
      if (sizeof(void*) == 8)
      {
        //printf("No input file specified; using 'instrformats_64.in'.\n");
        yyin = UTIL_fopenR("instrformats_64.in");
      }
      else
      {
        //printf("No input file specified; using 'instrformats_32.in'.\n");
        yyin = UTIL_fopenR("instrformats_32.in");
      }
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
    
    //printf("Generating instruction files...\n");

    ret = yyparse();
    UTIL_fclose(yyin);
    
    if(ret != 0)
    {
      printf("Generation failed.\n");
      return -1;
    }
    cspitCInstructionsH(root);
    cspitCInstructionsC(root);
    cspitSimDispatch(root);
    //ocSpitInstructionMLI(root);
    //ocSpitInstructionML(root);
    //printf("Done.\n");

    return 0;
}
