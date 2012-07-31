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
/* File mcstring.h. The virtual machine encoding of string literals is      */
/* contained in this module. Any change of such encoding format should be   */
/* isolated here.                                                           */
/****************************************************************************/

#ifndef MCSTRING_H
#define MCSTRING_H

#include "mctypes.h"

/****************************************************************************/
/* Currently the string is encoded as one word being the length of the      */
/* string followed by a list of characters in C string encoding (which is a */
/* sequence of chars ended with '\0'.                                       */
/****************************************************************************/
typedef  char        MCSTR_Char;
typedef  WordPtr     MCSTR_Str;

//length of a given string; the string pointer is assumed to not be NULL
int     MCSTR_strLength(MCSTR_Str str);
//number of words needed for a string with n characters
int     MCSTR_numWords(int n);
//from machine string to c string
char*   MCSTR_toCString(MCSTR_Str str);
//to string
void    MCSTR_toString(MCSTR_Str loc, char* buf, int length);

//compare whether two string literals are the same
Boolean MCSTR_sameStrs(MCSTR_Str str1, MCSTR_Str str2);
//compare strings
int     MCSTR_compareStrs(MCSTR_Str str1, MCSTR_Str str2);
//string concatenate (the new string is created at address started from loc)
void    MCSTR_concat(MCSTR_Str loc, MCSTR_Str str1, MCSTR_Str str2);
//substring (the new string is created at address started from loc)
void    MCSTR_subString(MCSTR_Str loc, MCSTR_Str str, int startPos, int length);
//chr
void    MCSTR_chr(MCSTR_Str loc, int integer);
//ord 
int     MCSTR_ord(MCSTR_Str str);


//display on standard IO
void    MCSTR_printStr(MCSTR_Str str);

#endif  //MCSTRING_H  
