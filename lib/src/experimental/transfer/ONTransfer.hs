module Main where

import qualified PGF
import Old2New

main = interact (unlines . map trans . lines)

trans = maybe "" (PGF.showExpr [] . transfer) . PGF.readExpr