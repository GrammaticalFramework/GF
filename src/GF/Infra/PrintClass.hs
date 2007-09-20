module GF.Infra.PrintClass where

import Data.List (intersperse)
import GF.Data.Operations (Err(..))

class Print a where
    prt :: a -> String
    prtList :: [a] -> String
    prtList as = "[" ++ prtSep "," as ++ "]"

prtSep :: Print a => String -> [a] -> String
prtSep sep = concat . intersperse sep . map prt

prtBefore :: Print a => String -> [a] -> String
prtBefore before = prtBeforeAfter before ""

prtAfter :: Print a => String -> [a] -> String
prtAfter after = prtBeforeAfter "" after

prtBeforeAfter :: Print a => String -> String -> [a] -> String
prtBeforeAfter before after as = concat [ before ++ prt a ++ after | a <- as ]

prtPairList :: (Print a, Print b) => String -> String -> [(a,b)] -> String
prtPairList comma sep xys = prtSep sep [ prt x ++ comma ++ prt y | (x,y) <- xys ]
prIO :: Print a => a -> IO ()
prIO = putStr . prt

instance Print a => Print [a] where
    prt = prtList

instance (Print a, Print b) => Print (a, b) where
    prt (a, b) = "(" ++ prt a ++ "," ++ prt b ++ ")"

instance (Print a, Print b, Print c) => Print (a, b, c) where
    prt (a, b, c) = "(" ++ prt a ++ "," ++ prt b ++ "," ++ prt c ++ ")"

instance (Print a, Print b, Print c, Print d) => Print (a, b, c, d) where
    prt (a, b, c, d) = "(" ++ prt a ++ "," ++ prt b ++ "," ++ prt c ++ "," ++ prt d ++ ")"

instance Print Char where
    prt = return
    prtList = id

instance Print Int where
    prt = show

instance Print Integer where
    prt = show

instance Print a => Print (Maybe a) where
    prt (Just a) = prt a
    prt Nothing  = "Nothing"

instance Print a => Print (Err a) where
    prt (Ok a) = prt a
    prt (Bad str) = str
