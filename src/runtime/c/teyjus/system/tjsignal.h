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
 *   File signal.h -- code to implement signals and signal handlers for     *
 *   Teyjus. (TEMP)                                                         *
 *                                                                          *
 ****************************************************************************/
#ifndef SIGNAL_H
#define SIGNAL_H

#include <setjmp.h>


/****************************************************************************
 * Different sigsetjmp/siglongjmp depending on support..                    *
 ****************************************************************************/

#define SIGNAL_jmp_buf jmp_buf
#define SIGNAL_setjmp(env) setjmp(env)
#define SIGNAL_longjmp(env, val) longjmp(env, val)


#endif /* SIGNAL_H */
