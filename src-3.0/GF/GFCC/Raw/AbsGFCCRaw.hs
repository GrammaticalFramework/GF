module GF.GFCC.Raw.AbsGFCCRaw where

data Grammar =
   Grm [RExp]
  deriving (Eq,Ord,Show)

data RExp =
   App String [RExp]
 | AInt Integer
 | AStr String
 | AFlt Double
 | AMet
  deriving (Eq,Ord,Show)

