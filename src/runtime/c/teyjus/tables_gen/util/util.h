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

/**************************************************************************/
/* util.h{c}.                                                             */
/* Auxiliary functions needed for generating source files.                */
/**************************************************************************/
#ifndef UTIL_H
#define UTIL_H
#include <stdio.h>


/**************************************************************************/
/* Space allocation                                                       */
/**************************************************************************/
/* allocate space */
void* UTIL_malloc(size_t size);

/* allocate space for a string of given size */
char* UTIL_mallocStr(size_t size);

/**************************************************************************/
/* string operation                                                       */
/**************************************************************************/
/* append two strings */
char* UTIL_appendStr(char* str1, char* str2);
/* capitalizing       */
char* UTIL_upperCase(char* str);
/* to lower cases     */
char* UTIL_lowerCase(char* str);
/* covert a non-negative integer to string */
char* UTIL_itoa(int num);

/**************************************************************************/
/* file operation                                                         */
/**************************************************************************/
/* open file in read mode */
FILE* UTIL_fopenR(char* filename);

/* open file in write mode */
FILE* UTIL_fopenW(char* filename);

/* close file */
void UTIL_fclose(FILE* file);


/* bool type */
typedef enum {
    UTIL_FALSE, UTIL_TRUE
} UTIL_Bool;

#endif


