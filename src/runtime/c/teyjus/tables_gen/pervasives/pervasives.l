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

#include "../util/util.h" 
#include "op.h" 
#include "types.h"
#include "y.tab.h"
#include <stdlib.h>
#include <string.h> 

static int commentLev = 0;
%}

LETTER [A-Za-z]
DIGIT  [0-9]
SYMBOL "_"|"+"|"-"|"*"|"/"|"!"|"~"|"@"|"$"|"%"|"^"|"&"|"*"|"<"|">"|"="|"'"|";"|":"|","

ID     ({LETTER}|{SYMBOL})({LETTER}|{DIGIT}|{SYMBOL})*
NUM    {DIGIT}+
WSPACE [ \t]+
STRING [^*/]+

%x COMMENT C_COMMENT

/* Some versions of lex require an explicit positions argument */
%p 10000

%% 
<INITIAL,COMMENT>"\n"      {continue;                                      }
<INITIAL>"KIND"            {return KIND;                                   }
<INITIAL>"CONST"           {return CONST;                                  }
<INITIAL>"TYPE SKEL"       {return TYSKEL;                                 }
<INITIAL>"TYPE"            {return TYPE;                                   }
<INITIAL>"->"              {return TYARROW;                                }
<INITIAL>"@"               {return TYAPP;                                  }
<INITIAL>"["               {return LBRACKET;                               }
<INITIAL>"]"               {return RBRACKET;                               }
<INITIAL>"("               {return LPAREN;                                 }
<INITIAL>")"               {return RPAREN;                                 }
<INITIAL>"t,"              {return COMMA;                                  }
<INITIAL>"#"               {return POUND;                                  }
<INITIAL>";;"              {return SEMICOLON;                              }
<INITIAL>"INFIX"           {return INFIX;                                  }
<INITIAL>"INFIXL"          {return INFIXL;                                 }
<INITIAL>"INFIXR"          {return INFIXR;                                 }
<INITIAL>"PREFIX"          {return PREFIX;                                 }
<INITIAL>"PREFIXR"         {return PREFIXR;                                }
<INITIAL>"POSTFIX"         {return POSTFIX;                                }
<INITIAL>"POSTFIXL"        {return POSTFIXL;                               }
<INITIAL>"NOFIXITY"        {return NOFIXITY;                               }
<INITIAL>"MIN1"            {return MIN1;                                   }
<INITIAL>"MIN2"            {return MIN2;                                   }
<INITIAL>"MAX"             {return MAX;                                    }
<INITIAL>"NOCODE"          {return NOCODE;                                 }
<INITIAL>"LOGIC SYMBOL"    {return LSSYMB;                                 }
<INITIAL>"LS_START"        {return LSSTART;                                }
<INITIAL>"LS_END"          {return LSEND;                                  }
<INITIAL>"PRED SYMBOL"     {return PREDSYMB;                               }
<INITIAL>"PRED_START"      {return PREDSTART;                              }
<INITIAL>"PRED_END"        {return PREDEND;                                }
<INITIAL>"REGCL"           {return REGCL;                                  }
<INITIAL>"BACKTRACK"       {return BACKTRACK;                              }
<INITIAL>"TRUE"            {return TRUE;                                   }
<INITIAL>"FALSE"           {return FALSE;                                  }
<INITIAL>{WSPACE}          {continue;                                      }
<INITIAL>"/%"              {commentLev = 1; BEGIN(COMMENT); continue;      }
<INITIAL>"/*"              {BEGIN(C_COMMENT); continue;                    }
<INITIAL>{ID}              {yylval.name = strdup(yytext); return ID;       }
<INITIAL>{NUM}             {yylval.isval.ival = atoi(yytext); 
                            yylval.isval.sval = strdup(yytext); 
                            return NUM;                                    }

<C_COMMENT>"*/"            {BEGIN(INITIAL); continue;                      }
<C_COMMENT>{STRING}        {yylval.text = strdup(yytext); return STRING;   }

<COMMENT>[^%/\n]+          {continue;                                      }
<COMMENT>"/%"              {commentLev++; continue;                        }
<COMMENT>"%/"              {commentLev--;
                            if (!commentLev) BEGIN(INITIAL); continue;     }

.                          {return ERROR;                                  }
