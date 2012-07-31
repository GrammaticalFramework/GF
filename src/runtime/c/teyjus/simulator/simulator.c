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
 *   File simulator.c. This file contains the procedure that emulates the   *
 *   lambda Prolog abstract machine.                                        *
 ****************************************************************************/

#ifndef SIMULATOR_C
#define SIMULATOR_C

#include "simdispatch.h"
#include "abstmachine.h"
#include "trail.h"
#include "../system/error.h" //to be modified
#include "../tables/instructions.h" //to be modified

#include <stdio.h> //temp

void SIM_simulate()
{
  restart_loop:
    EM_TRY {       
        while(1) {
            /*fprintf(stderr, "AM_preg %u opcode: %d\n", AM_preg, 
             *((INSTR_OpCode *)AM_preg)); */
            SDP_dispatchTable[*((INSTR_OpCode *)AM_preg)]();
        }
        /* it's expected that this statement not be reached: the only
           way out of this while loop is by an exception */        
    } EM_CATCH {
        if (EM_CurrentExnType == EM_FAIL) {
            if (AM_botCP()) EM_RETHROW();
            else {
                TR_unwindTrail(AM_cpTR());
                AM_initPDL();
                AM_bndFlag = OFF;
                AM_preg = AM_cpNCL();
                goto restart_loop;
            }
        } else  EM_RETHROW();
    }
}

#endif /* SIMULATOR_C */
