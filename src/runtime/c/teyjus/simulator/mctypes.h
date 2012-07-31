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
/*                                                                          */
/*   File  mctypes.h.                                                       */
/*   This file contains the definitions of the low-level                    */
/*   data types that are used in constructing the more complex objects that */
/*   are used in data representation and in instruction formats. This file  */
/*   will likely be included by most others defining the overall system.    */
/*                                                                          */
/****************************************************************************/
#ifndef MCTYPES_H
#define MCTYPES_H

typedef unsigned char  Byte;                       /* 8 bits              */
typedef unsigned short TwoBytes;                   /* 16 bits             */


typedef unsigned char  Boolean;                    /* 8 bits: FALSE/TRUE  */
#define TRUE           1  
#define FALSE          0


typedef unsigned long  Word;      
typedef Word           *WordPtr;

#define WORD_SIZE      sizeof(Word)               /* 4: 32-bits machine  */   
                                                  /* 8  64-bits machine  */

typedef Word           Mem;                       /* generic memory type */
typedef Mem            *MemPtr;                   /* pointer to memory   */
typedef Byte           *CSpacePtr;                /* code space pointer  */
typedef Byte           *BytePtr;                  

#endif //MCTYPES_H
