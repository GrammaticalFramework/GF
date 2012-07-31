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
/* File hnorm.h.                                                            */
/* This header file identifies routines defined in hnorm.c that are         */
/* exported from there.                                                     */
/****************************************************************************/
#ifndef HNORM_H
#define HNORM_H

#include "dataformats.h"

/* head normalization of the term in the argument */
void HN_hnorm(DF_TermPtr); 

/* head normalization of the term in the argument with occurs-check */
void HN_hnormOcc(DF_TermPtr);

/* full normalization of the term in the argument */
void HN_lnorm(DF_TermPtr);


#endif //HNORM_H
