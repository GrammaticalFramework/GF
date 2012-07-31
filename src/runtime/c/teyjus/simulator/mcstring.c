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
/****************************************************************************/
/*                                                                          */
/* File mcstring.c.                                                         */
/****************************************************************************/
#include <string.h>
#include <stdio.h>
#include <math.h>
#include "mcstring.h"
#include "mctypes.h"

//length of a given string; the string pointer is assumed to not be NULL
int MCSTR_strLength(MCSTR_Str str) 
{ 
    return *((int *)str);      
}

//number of words needed for a string with n characters
int MCSTR_numWords(int n) 
{  
    return ((int)ceil(((double)(n+1))/WORD_SIZE)) + 1; //with '\0' terminator
}

//from machine string to c string
char* MCSTR_toCString(MCSTR_Str str)
{
    return (char*)(str + 1);
}

//to string
void MCSTR_toString(MCSTR_Str loc, char* buf, int length)
{
    char* chloc = (char*)(loc + 1);
    *((int *)loc) = length;
    strcpy(chloc, buf);
}

//compare whether two string literals are the same
Boolean MCSTR_sameStrs(MCSTR_Str str1, MCSTR_Str str2)
{
    if (strcmp((char*)(str1+1), (char*)(str2+1)) == 0) return TRUE;
    else return FALSE;
}

/* compare strings: return <  0 if str1 <  str2
                    return == 0 if str1 == str2
                    return >  0 if str1 >  str2 
*/
int MCSTR_compareStrs(MCSTR_Str str1, MCSTR_Str str2)
{
    return strcmp((char*)(str1+1), (char*)(str2+1));
}

//string concatenate (the new string is created at address started from loc)
void MCSTR_concat(MCSTR_Str loc, MCSTR_Str str1, MCSTR_Str str2)
{
    char* chloc = (char*)(loc + 1);
    *((int *)loc) = MCSTR_strLength(str1) + MCSTR_strLength(str2);
    strcpy(chloc, (char*)(str1+1));
    strcat(chloc, (char*)(str2+1));
}

//substring (the new string is created at address started from loc)
void MCSTR_subString(MCSTR_Str loc, MCSTR_Str str, int startPos, int length)
{
    int i;
    char* fromPtr = ((char*)(str + 1))+startPos;
    char* toPtr   = (char*)(loc + 1);
    
    *((int *)loc) = (length + 1);
    while (length > 0) {
      *toPtr++ = *fromPtr++;
      length--;
    }
    *toPtr = '\0';    
}

//chr
void MCSTR_chr(MCSTR_Str loc, int integer)
{
    char* chloc = (char*)(loc + 1);
    *((int *)loc) = 1;
    *chloc++ = (char)integer;
    *chloc   = '\0';
}

//ord 
int MCSTR_ord(MCSTR_Str str)
{
    return (int)(*((char*)(str + 1)));
}

//display on standard IO
void    MCSTR_printStr(MCSTR_Str str)
{
    printf("%s", (char*)(str+1));
}

