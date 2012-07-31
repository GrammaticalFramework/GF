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
 *   File message.h -- code to present messages to the user in Teyjus.      *
 * supports dynamically adding "%x"-style formatting switches, as well as   *
 * complete support for simply making separate builds.                      *
 *                                                                          *
 ****************************************************************************/

#ifndef MESSAGE_H
#define MESSAGE_H

#include <stdarg.h>
#include "../simulator/mctypes.h"

/****************************************************************************
 * Type of a function to handle a particular formatting switch.             *
 ****************************************************************************/
/* these functions should increment ioArgument as necessary. */
typedef void (*MSG_SwitchFunction)(char *inSwitch, WordPtr inStream, 
                                   va_list *ioArgument);


/****************************************************************************
 * Type of a block of messages, with associated constants.                  *
 ****************************************************************************/
typedef struct MSG_Msg
{
    int mIndex;			/* Index of this error message */
    int mPreChain;		/* Index of message to print before this one */
    char *mMessage;		/* The message itself */
    int mPostChain;		/* Index of message to print after this one */
    
    int mExnType;		/* if MSG_NO_EXN, MSG_Error() will return */
    unsigned int mExitStatus;	/* value to return with abort() */
} MSG_Msg;

typedef struct MSG_MessageBlock
{
    int mCount;			            /* No. of messages in this block */
    int mMinIndex, mMaxIndex;	    /* mMinIndex <= every index <= mMaxIndex */
    struct MSG_MessageBlock *mNext; /* Next block of messages in linked list */
    MSG_Msg *mMessages;		        /* Array of messages */
} MSG_MessageBlock;

/****************************************************************************
 * Initialization functions                                                 *
 ****************************************************************************/
void MSG_addSwitch(char inSwitch, MSG_SwitchFunction inFunction);
void MSG_addMessages(int inCount, MSG_Msg *inMessages);

/****************************************************************************
 * The routine that gets called to print a message, returning the exception *
 * type for the error message (mExnType)                                    *
 ****************************************************************************/
int MSG_vMessage(int inIndex, va_list *ap);

#endif /* MESSAGE_H */
