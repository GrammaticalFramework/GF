module Dependencies where

import PGF
import qualified Data.Map as Map
import Data.Maybe as Maybe

type HeadTable = Map.Map CId [CId]

readHeadTable :: FilePath -> IO HeadTable
readHeadTable fpath = do
  ls <- fmap lines $ readFile fpath
  return (Map.fromList [(head ws, tail ws) | l <- ls, let ws = map mkCId (words l), not (null ws)])

getDependencies :: HeadTable -> Expr -> (CId,[(CId,CId)])
getDependencies tbl e = 
  case unApp e of
    Just (f,es)
      | null es   -> (f,[])
      | f == mkCId "MkSymb" -> (f,[])
      | otherwise -> case Map.lookup f tbl of
                       Just cs -> let xs       = zipWith (\c e -> (c,getDependencies tbl e)) cs es
                                      hes      = [he | (c,he) <- xs, c == c_head]
                                      (h,deps) = head hes
                                  in if length hes /= 1
                                       then error ("there must be exactly one head in "++showExpr [] e)
                                       else (h,concat (deps:[(h,m):deps | (c,(m,deps)) <- xs, c == c_mod]))
                       Nothing -> error ("there is no head defined for function "++showCId f)
    Nothing       -> error ("this is not a function application: "++showExpr [] e)

c_head = mkCId "head"
c_mod  = mkCId "mod"

test = do
  t <- readHeadTable "ParseEngAbs.heads" 
  es <- fmap (concatMap (maybeToList . readExpr) . lines) $ readFile "wsj.full"
  let deps = Map.fromListWith (+) [(d,1) | e <- es, d <- snd (getDependencies t e)]
  writeFile "deps" (unlines (map show (Map.toList deps)))
