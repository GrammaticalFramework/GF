{--
This module provide a function for indexing a pgf. 

It reads the pgf and add a global flag, called "index", containing a string 
with concrete names and size in bytes separated by a column.
ex : "DisambPhrasebookEng:18778 PhrasebookBul:49971 PhrasebookCat:32738..."
--}
module GF.Index (addIndex) where

import PGF
import PGF.Data
import PGF.Binary
import Data.Binary
import Data.ByteString.Lazy (readFile,length)
import qualified Data.Map as Map
import Data.Map (toAscList)
import Data.List (intercalate)
import qualified Data.ByteString.Lazy as BS

addIndex  :: PGF -> PGF
addIndex pgf = pgf {gflags = flags}  
  where flags = Map.insert (mkCId "index") (LStr $ showIndex index) (gflags pgf)
        index = getIndex pgf


showIndex :: [(String,Int)] -> String
showIndex = intercalate " " . map f
  where f (name,size) = name ++ ":" ++ show size

getsize :: Binary a => a -> Int
getsize x = let bs = encode x in fromIntegral $ Data.ByteString.Lazy.length bs

getIndex :: PGF -> [(String,Int)]
getIndex pgf = cncindex
  where cncindex = map f $ Data.Map.toAscList $ concretes pgf
        f (cncname,cnc) = (show cncname, getsize cnc)
