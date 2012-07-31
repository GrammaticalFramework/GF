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

#include "y.tab.h"
#include <string.h>
#include <stdlib.h>

static int commentLev = 0;
%}

LETTER [A-Za-z]
DIGIT  [0-9]
SYMBOL "_"|"+"|"-"|"*"|"/"|"!"|"~"|"@"|"$"|"%"|"^"|"&"|"*"|"<"|">"|"="|"'"|":"|","

ID     ({LETTER}|{SYMBOL})({LETTER}|{DIGIT}|{SYMBOL})*
NUM    {DIGIT}+
WSPACE [ \t]+
STRING [^*/]+
STRING2 [^}]+

%x COMMENT COMMENT2 INCLUDE

%%
<INITIAL,COMMENT>"\n"      {continue;                                      }
<INITIAL>";"               {return SEMICOLON;                              }
<INITIAL>"["               {return LBRACKET;                               }
<INITIAL>"]"               {return RBRACKET;                               }
<INITIAL>"OPERAND TYPES"   {return OPTYPES;                                }
<INITIAL>"OPCODE"          {return OPCODE;                                 }
<INITIAL>"INSTR CATEGORY"  {return INSTRCAT;                               }
<INITIAL>"MAX OPERAND"     {return MAXOPERAND;                             }
<INITIAL>"CALL_I1_LEN"     {return CALL_I1_LEN;                            }
<INITIAL>"INSTRUCTIONS"    {return INSTRUCTIONS;                           }
<INITIAL>{WSPACE}          {continue;                                      }  
<INITIAL>"/%"              {commentLev = 1; BEGIN(COMMENT); continue;      }
<INITIAL>"/*"              {BEGIN(COMMENT2); continue;                     }
<INITIAL>"{"               {BEGIN(INCLUDE); continue;                      }
<INITIAL>{ID}              {yylval.name = strdup(yytext); return ID;       }
<INITIAL>{NUM}             {yylval.isval.ival = atoi(yytext); 
                            yylval.isval.sval = strdup(yytext); 
                            return NUM;                                    }
<COMMENT2>"*/"             {BEGIN(INITIAL); continue;                      }
<COMMENT2>{STRING}         {yylval.text = strdup(yytext); return STRING;   }

<COMMENT>[^%/\n]+          {continue;                                      }
<COMMENT>"/%"              {commentLev++; continue;                        }
<COMMENT>"%/"              {commentLev--;
                            if (!commentLev) BEGIN(INITIAL); continue;     }
<INCLUDE>"}"               {BEGIN(INITIAL); continue;                      }
<INCLUDE>{STRING2}         {yylval.text = strdup(yytext); return STRING2;  }
.                          {return ERROR;                                  }
