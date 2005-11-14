----------------------------------------------------------------------
-- |
-- Module      : NoParse
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/14 16:03:41 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.1 $
--
-- Probabilistic abstract syntax. AR 30\/10\/2005
--
-- (c) Aarne Ranta 2005 under GNU GPL
--
-- Contents: decide what lin rules no parser is generated.
-- Usually a list of noparse idents from 'i -boparse=file'.

-----------------------------------------------------------------------------

module GF.Compile.NoParse (
  NoParse             -- =  Ident -> Bool
 ,getNoparseFromFile  -- :: Opts -> IO NoParse
 ,doParseAll          -- :: NoParse
  ) where

import GF.Infra.Ident
import GF.Data.Operations
import GF.Infra.Option


type NoParse = (Ident -> Bool)

doParseAll :: NoParse
doParseAll = const False

getNoparseFromFile :: Options -> FilePath -> IO NoParse
getNoparseFromFile opts file = do 
  let f = maybe file id $ getOptVal opts noparseFile
  s <- readFile f
  return $ igns s
 where
   igns s i = isInBinTree i $ buildTree $ flip zip (repeat ()) $ concat $ map getIgnores $ lines s
-- where
getIgnores s = case dropWhile (/="--#") (words s) of
     _:"noparse":fs -> map identC fs
     _ -> []
