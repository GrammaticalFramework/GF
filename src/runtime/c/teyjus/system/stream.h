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
/****************************************************************************
 *                                                                          *
 * system/stream.h{c} implements stream support for the C part  of the LP   *
 * system.                                                                  *
 ****************************************************************************/
#ifndef STREAM_H
#define STREAM_H

#include <stdarg.h>
#include <stdio.h>
#include "../simulator/mctypes.h" //to be modified

/*****************************************************************************
 *                                CONSTANTS                                  *
 *****************************************************************************/

#define STREAM_ILLEGAL    0

#define STREAM_READ       "r"
#define STREAM_WRITE      "w"
#define STREAM_APPEND     "a"

/*****************************************************************************
 *                             EXPORTED VARIABLES                            *
 *****************************************************************************/
/* STREAMs corresponding to the three standard streams */
extern WordPtr STREAM_stdin, STREAM_stdout, STREAM_stderr;

/****************************************************************************
 *                      BASIC FUNCTIONS                                     *
 ****************************************************************************/

/* STREAM_open returns STREAM_ILLEGAL if the stream can't be opened;
   if inDoCountLines is false, the line numbering calls below will not
   work. */
WordPtr  STREAM_open(char *inFilename, char *inMode, int inDoUsePaths);
/* open strings as streams.  Note that the STREAM system does not
   distinguish to_string and from_string streams after they are
   opened.  Results are undefined for a write to a from_string or read
   from a to_string. */
WordPtr  STREAM_fromString(char *inString, int inDoCopyString);
WordPtr  STREAM_toString();

/* will not close the standard			    streams */
void     STREAM_close(WordPtr inStream); 


/***************************************************************************
 *                    RAW I/O SUPPORT ROUTINES                             *
 *      each routine returns -1 to indicate an error                       * 
 ***************************************************************************/
int STREAM_readCharacters(WordPtr inStream, int inMaxCount, char* outString, 
                          int inDoStopOnNewline);
/* STREAM_printf and STREAM_sans_printf return the number of characters 
   written, -1 in case of error. STREAM_printf takes a format 
   STREAM_sans_printf interprets the input as a string to be printed */
int     STREAM_printf(WordPtr inStream, char *format, ...);
int     STREAM_sans_printf(WordPtr inStream, char *str);
/* STREAM_printf returns the number of characters written, -1 in case of error*/
int     STREAM_lookahead(WordPtr inStream, char *outChar);
Boolean STREAM_eof(WordPtr inStream); 
int     STREAM_flush(WordPtr inStream);

/***************************************************************************
 *                             ACCESSORS                                   *  
 ***************************************************************************/
char*   STREAM_getString(WordPtr inStream);
FILE*   STREAM_getFile(WordPtr inStream);
char*   STREAM_getName(WordPtr inStream);

#endif //STREAM_H
