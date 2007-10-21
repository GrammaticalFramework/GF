module GSyntax where

import GF.GFCC.DataGFCC
import GF.GFCC.AbsGFCC
----------------------------------------------------
-- automatic translation from GF to Haskell
----------------------------------------------------

class Gf a where gf :: a -> Exp
class Fg a where fg :: Exp -> a

newtype GString = GString String  deriving Show

instance Gf GString where
  gf (GString s) = DTr [] (AS s) []

instance Fg GString where
  fg t =
    case t of
      DTr [] (AS s) []  -> GString s
      _ -> error ("no GString " ++ show t)

newtype GInt = GInt Integer  deriving Show

instance Gf GInt where
  gf (GInt s) = DTr [] (AI s) []

instance Fg GInt where
  fg t =
    case t of
      DTr [] (AI s) []  -> GInt s
      _ -> error ("no GInt " ++ show t)

newtype GFloat = GFloat Double  deriving Show

instance Gf GFloat where
  gf (GFloat s) = DTr [] (AF s) []

instance Fg GFloat where
  fg t =
    case t of
      DTr [] (AF s) []  -> GFloat s
      _ -> error ("no GFloat " ++ show t)

----------------------------------------------------
-- below this line machine-generated
----------------------------------------------------

data GA2 =
   GDivisible 
 | GEqual 
 | GGreater 
 | GSmaller 
  deriving Show

data GAP =
   GComplA2 GA2 GNP 
 | GConjAP GConj GAP GAP 
 | GEven 
 | GOdd 
 | GPrime 
  deriving Show

data GAnswer =
   GNo 
 | GValue GNP 
 | GYes 
  deriving Show

data GCN =
   GModCN GAP GCN 
 | GNumber 
  deriving Show

data GConj =
   GAnd 
 | GOr 
  deriving Show

newtype GListPN = GListPN [GPN] deriving Show

data GNP =
   GConjNP GConj GNP GNP 
 | GEvery GCN 
 | GMany GListPN 
 | GNone 
 | GSome GCN 
 | GUsePN GPN 
  deriving Show

data GPN =
   GGCD GListPN 
 | GProduct GListPN 
 | GSum GListPN 
 | GUseInt GInt 
  deriving Show

data GQuestion =
   GQuestS GS 
 | GWhatIs GPN 
 | GWhichAre GCN GAP 
  deriving Show

data GS = GPredAP GNP GAP 
  deriving Show


instance Gf GA2 where
 gf GDivisible = DTr [] (AC (CId "Divisible")) []
 gf GEqual = DTr [] (AC (CId "Equal")) []
 gf GGreater = DTr [] (AC (CId "Greater")) []
 gf GSmaller = DTr [] (AC (CId "Smaller")) []

instance Gf GAP where
 gf (GComplA2 x1 x2) = DTr [] (AC (CId "ComplA2")) [gf x1, gf x2]
 gf (GConjAP x1 x2 x3) = DTr [] (AC (CId "ConjAP")) [gf x1, gf x2, gf x3]
 gf GEven = DTr [] (AC (CId "Even")) []
 gf GOdd = DTr [] (AC (CId "Odd")) []
 gf GPrime = DTr [] (AC (CId "Prime")) []

instance Gf GAnswer where
 gf GNo = DTr [] (AC (CId "No")) []
 gf (GValue x1) = DTr [] (AC (CId "Value")) [gf x1]
 gf GYes = DTr [] (AC (CId "Yes")) []

instance Gf GCN where
 gf (GModCN x1 x2) = DTr [] (AC (CId "ModCN")) [gf x1, gf x2]
 gf GNumber = DTr [] (AC (CId "Number")) []

instance Gf GConj where
 gf GAnd = DTr [] (AC (CId "And")) []
 gf GOr = DTr [] (AC (CId "Or")) []

instance Gf GListPN where
 gf (GListPN [x1,x2]) = DTr [] (AC (CId "BasePN")) [gf x1, gf x2]
 gf (GListPN (x:xs)) = DTr [] (AC (CId "ConsPN")) [gf x, gf (GListPN xs)]

instance Gf GNP where
 gf (GConjNP x1 x2 x3) = DTr [] (AC (CId "ConjNP")) [gf x1, gf x2, gf x3]
 gf (GEvery x1) = DTr [] (AC (CId "Every")) [gf x1]
 gf (GMany x1) = DTr [] (AC (CId "Many")) [gf x1]
 gf GNone = DTr [] (AC (CId "None")) []
 gf (GSome x1) = DTr [] (AC (CId "Some")) [gf x1]
 gf (GUsePN x1) = DTr [] (AC (CId "UsePN")) [gf x1]

instance Gf GPN where
 gf (GGCD x1) = DTr [] (AC (CId "GCD")) [gf x1]
 gf (GProduct x1) = DTr [] (AC (CId "Product")) [gf x1]
 gf (GSum x1) = DTr [] (AC (CId "Sum")) [gf x1]
 gf (GUseInt x1) = DTr [] (AC (CId "UseInt")) [gf x1]

instance Gf GQuestion where
 gf (GQuestS x1) = DTr [] (AC (CId "QuestS")) [gf x1]
 gf (GWhatIs x1) = DTr [] (AC (CId "WhatIs")) [gf x1]
 gf (GWhichAre x1 x2) = DTr [] (AC (CId "WhichAre")) [gf x1, gf x2]

instance Gf GS where gf (GPredAP x1 x2) = DTr [] (AC (CId "PredAP")) [gf x1, gf x2]


instance Fg GA2 where
 fg t =
  case t of
    DTr [] (AC (CId "Divisible")) [] -> GDivisible 
    DTr [] (AC (CId "Equal")) [] -> GEqual 
    DTr [] (AC (CId "Greater")) [] -> GGreater 
    DTr [] (AC (CId "Smaller")) [] -> GSmaller 
    _ -> error ("no A2 " ++ show t)

instance Fg GAP where
 fg t =
  case t of
    DTr [] (AC (CId "ComplA2")) [x1,x2] -> GComplA2 (fg x1) (fg x2)
    DTr [] (AC (CId "ConjAP")) [x1,x2,x3] -> GConjAP (fg x1) (fg x2) (fg x3)
    DTr [] (AC (CId "Even")) [] -> GEven 
    DTr [] (AC (CId "Odd")) [] -> GOdd 
    DTr [] (AC (CId "Prime")) [] -> GPrime 
    _ -> error ("no AP " ++ show t)

instance Fg GAnswer where
 fg t =
  case t of
    DTr [] (AC (CId "No")) [] -> GNo 
    DTr [] (AC (CId "Value")) [x1] -> GValue (fg x1)
    DTr [] (AC (CId "Yes")) [] -> GYes 
    _ -> error ("no Answer " ++ show t)

instance Fg GCN where
 fg t =
  case t of
    DTr [] (AC (CId "ModCN")) [x1,x2] -> GModCN (fg x1) (fg x2)
    DTr [] (AC (CId "Number")) [] -> GNumber 
    _ -> error ("no CN " ++ show t)

instance Fg GConj where
 fg t =
  case t of
    DTr [] (AC (CId "And")) [] -> GAnd 
    DTr [] (AC (CId "Or")) [] -> GOr 
    _ -> error ("no Conj " ++ show t)

instance Fg GListPN where
 fg t =
  case t of
    DTr [] (AC (CId "BasePN")) [x1,x2] -> GListPN [fg x1, fg x2]
    DTr [] (AC (CId "ConsPN")) [x1,x2] -> let GListPN xs = fg x2 in GListPN (fg x1:xs)
    _ -> error ("no ListPN " ++ show t)

instance Fg GNP where
 fg t =
  case t of
    DTr [] (AC (CId "ConjNP")) [x1,x2,x3] -> GConjNP (fg x1) (fg x2) (fg x3)
    DTr [] (AC (CId "Every")) [x1] -> GEvery (fg x1)
    DTr [] (AC (CId "Many")) [x1] -> GMany (fg x1)
    DTr [] (AC (CId "None")) [] -> GNone 
    DTr [] (AC (CId "Some")) [x1] -> GSome (fg x1)
    DTr [] (AC (CId "UsePN")) [x1] -> GUsePN (fg x1)
    _ -> error ("no NP " ++ show t)

instance Fg GPN where
 fg t =
  case t of
    DTr [] (AC (CId "GCD")) [x1] -> GGCD (fg x1)
    DTr [] (AC (CId "Product")) [x1] -> GProduct (fg x1)
    DTr [] (AC (CId "Sum")) [x1] -> GSum (fg x1)
    DTr [] (AC (CId "UseInt")) [x1] -> GUseInt (fg x1)
    _ -> error ("no PN " ++ show t)

instance Fg GQuestion where
 fg t =
  case t of
    DTr [] (AC (CId "QuestS")) [x1] -> GQuestS (fg x1)
    DTr [] (AC (CId "WhatIs")) [x1] -> GWhatIs (fg x1)
    DTr [] (AC (CId "WhichAre")) [x1,x2] -> GWhichAre (fg x1) (fg x2)
    _ -> error ("no Question " ++ show t)

instance Fg GS where
 fg t =
  case t of
    DTr [] (AC (CId "PredAP")) [x1,x2] -> GPredAP (fg x1) (fg x2)
    _ -> error ("no S " ++ show t)


