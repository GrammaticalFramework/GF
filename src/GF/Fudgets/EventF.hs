----------------------------------------------------------------------
-- |
-- Module      : EventF
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:14 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module EventF where
import AllFudgets

-- | The first string is the name of the key (e.g., "Down" for the down arrow key)
--
-- The modifiers list shift, control and alt keys that were active while the
-- key was pressed.
--
-- The last string is the text produced by the key (for keys that produce
-- printable characters, empty for control keys).
type KeyPress = ((String,[Modifiers]),String)

keyboardF :: F i o -> F i (Either KeyPress o)
keyboardF fud = idRightSP (concatMapSP post) >^^=< oeventF mask fud
  where
    post (KeyEvent {type'=Pressed,keySym=sym,state=mods,keyLookup=s}) =
       [((sym,mods),s)]
    post _ = []

    mask = [KeyPressMask,
            EnterWindowMask, LeaveWindowMask -- because of CTT implementation
	   ]

-- | Output events:
oeventF em fud =  eventF em (idLeftF fud)

-- | Feed events to argument fudget:
eventF eventmask = serCompLeftToRightF . groupF startcmds eventK
  where
    startcmds = [XCmd $ ChangeWindowAttributes [CWEventMask eventmask],
	         XCmd $ ConfigureWindow [CWBorderWidth 0]]
    eventK = K $ mapFilterSP route
      where route = message low high
            low (XEvt event) = Just (High (Left event))
	    low _ = Nothing
	    high h = Just (High (Right h))

