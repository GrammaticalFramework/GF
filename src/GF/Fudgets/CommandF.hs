----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module CommandF where

import Operations

import Session
import Commands

import Fudgets
import FudgetOps

import EventF

-- a graphical shell for any kind of GF with Zipper editing. AR 20/8/2001

fudlogueEditF :: CEnv -> IO ()
fudlogueEditF env = 
  fudlogue $ gfSizeP $ shellF ("GF 2.0- Fudget Editor") (gfF env)

gfF env = nameLayoutF gfLayout $ (gfOutputF env >==< gfCommandF env) >+< quitButF

( quitN : menusN : newN : transformN : filterN : displayN :
  navigateN : viewN : outputN : saveN : _) = map show [1..]

gfLayout = placeNL verticalP [generics,output,navigate,menus,transform]
  where
    generics  = placeNL horizontalP (map leafNL 
                           [newN,saveN,viewN,displayN,filterN,quitN])
    output    = leafNL outputN
    navigate  = leafNL navigateN
    menus     = leafNL menusN
    transform = leafNL transformN
 
gfSizeP = spacerF (sizeS (Point 720 640))

gfOutputF env = 
  ((nameF outputN $ (writeFileF >+< textWindowF)) 
     >==< 
   (absF (saveSP "EMPTY") 
                        >==< 
    (nameF saveN (popupStringInputF "Save" "foo.tmp" "Save to file:")
         >+<  
      mapF (displayJustStateIn env))))
   >==< 
  mapF Right 

gfCommandF :: CEnv -> F () SState
gfCommandF env = loopCommandsF env >==< getCommandsF env >==< mapF (\_ -> Click)

loopCommandsF :: CEnv -> F Command SState
loopCommandsF env = loopThroughRightF (mapGfStateF env) (mkMenusF env)

mapGfStateF :: CEnv -> F (Either Command Command) (Either SState SState)
mapGfStateF env = mapstateF execFC (initSState) where
  execFC e0 (Left  c) = (e,[Right e,Left e]) where e = execECommand env c e0
  execFC e0 (Right c) = (e,[Left e,Right e]) where e = execECommand env c e0

mkMenusF :: CEnv -> F SState Command
mkMenusF env = 
  nameF menusN $
  labAboveF "Select Action on Subterm" 
            (mapF fst >==< smallPickListF snd >==< mapF (mkRefineMenu env))

getCommandsF env = 
    newF env     >*<
    viewF        >*<
    menuDisplayF env >*<
    filterF      >*<
    navigateF    >*<
    transformF

key2command ((key,_),_) = case key of
     "Up"    -> CBack 1
     "Down"  -> CAhead 1
     "Left"  -> CPrevMeta
     "Right" -> CNextMeta
     "space" -> CTop

     "d"     -> CDelete
     "u"     -> CUndo
     "v"     -> CView

     _ -> CVoid

transformF =
  nameF transformN $
  mapF (either key2command id) >==< (keyboardF $
  placerF horizontalP $
  cPopupStringInputF CRefineParse    "Parse" "" "Parse in concrete syntax" >*< 
  --- to enable Unicode: ("Refine by parsing" `labLeftOfF` writeInputF)
  cPopupStringInputF CRefineWithTree "Term" "" "Parse term"                >*<
  cMenuF "Modify" termCommandMenu                                 	   >*<
  cPopupStringInputF CAlphaConvert "Alpha" "x_0 x" "Alpha convert"         >*<  
  cButtonF CRefineRandom "Random"                                          >*<
  cButtonF CUndo "Undo"
  )

quitButF = nameF quitN $ quitF >==< buttonF "Quit"

newF env = nameF newN     $ cMenuF "New"    (newCatMenu env)
menuDisplayF env = nameF displayN $ cMenuF "Menus" $ displayCommandMenu env
filterF  = nameF filterN  $ cMenuF "Filter" stringCommandMenu

viewF = nameF viewN $ cButtonF CView "View"

navigateF =
  nameF navigateN $
  placerF horizontalP $
  cButtonF CPrevMeta  "?<"    >*<
  cButtonF (CBack 1)  "<"     >*<
  cButtonF CTop       "Top"   >*<
  cButtonF CLast      "Last"  >*<
  cButtonF (CAhead 1) ">"     >*<
  cButtonF CNextMeta  ">?"

cButtonF c s = mapF (const c) >==< buttonF s
cMenuF s css = menuF s css >==< mapF (\_ -> CVoid)

cPopupStringInputF comm lab def msg = 
  mapF comm >==< popupStringInputF lab def msg >==< mapF (const [])

