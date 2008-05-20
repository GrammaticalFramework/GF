module Flatten where

import Data.List
-- import GF.Data.Operations

-- (AR 15/3/2006)
--
-- A method for flattening grammars: create many flat rules instead of
-- a few deep ones. This is generally better for parsins.
-- The rules are obtained as follows:
-- 1. write a config file tellinq which constants are variables: format 'c : C'
-- 2. generate a list of trees with their types: format 't : T'
-- 3. for each such tree, form a fun rule 'fun fui : X -> Y -> T' and a lin
--    rule 'lin fui x y = t' where x:X,y:Y is the list of variables in t, as
--    found in the config file.
-- 4. You can go on and produce def or transfer rules similar to the lin rules
--    except for the keyword.
--
-- So far this module is used outside gf. You can e.g. generate a list of
-- trees by 'gt', write it in a file, and then in ghci call
-- flattenGrammar <Config> <Trees> <OutFile>

type Ident = String ---
type Term  = String ---
type Rule  = String ---

type Config = [(Ident,Ident)]

flattenGrammar :: FilePath -> FilePath -> FilePath -> IO ()
flattenGrammar conff tf out = do
  conf <- readFile conff >>= return . lines
  ts   <- readFile tf    >>= return . lines
  writeFile out $ mkFlatten conf ts

mkFlatten :: [String] -> [String] -> String
mkFlatten conff = unlines . concatMap getOne . zip [1..] where
  getOne (k,t) = let (x,y) = mkRules conf ("fu" ++ show k) t in [x,y] 
  conf = getConfig conff

mkRules :: Config -> Ident -> Term -> (Rule,Rule)
mkRules conf f t = (fun f ty, lin f (takeWhile (/=':') t)) where
  args = mkArgs conf ts
  ty   = concat [a ++ " -> " | a <- map snd args] ++ val
  (ts,val) = let tt = lexTerm t in (init tt,last tt)
---  f  = mkIdent t
  fun c a = unwords   ["  fun", c, ":",a,";"] 
  lin c a = unwords $ ["  lin", c] ++ map fst args ++ ["=",a,";"] 

mkArgs :: Config -> [Ident] -> [(Ident,Ident)]
mkArgs conf ids = [(x,ty) | x <- ids, Just ty <- [lookup x conf]]

mkIdent :: Term -> Ident
mkIdent = map mkChar where
  mkChar c = case c of
   '(' -> '6'
   ')' -> '9'
   ' ' -> '_'
   _   -> c

-- to get just the identifiers
lexTerm :: String -> [String]
lexTerm ss = case lex ss of
  [([c],ws)] | isSpec c ->     lexTerm ws
  [(w@(_:_),ws)]        -> w : lexTerm ws
  _ -> []
 where
   isSpec = flip elem "();:"


getConfig :: [String] -> Config
getConfig = map getOne . filter (not . null) where
  getOne line = case lexTerm line of
    v:c:_ -> (v,c)

ex = putStrLn fs where
  fs = 
    mkFlatten
      ["man_N : N", 
       "sleep_V : V"
      ] 
      ["PredVP (DefSg man_N) (UseV sleep_V) : Cl",
       "PredVP (DefPl man_N) (UseV sleep_V) : Cl"
      ]

{-
-- result of ex
  
  fun fu1 : N -> V -> Cl ;
  lin fu1 man_N sleep_V = PredVP (DefSg man_N) (UseV sleep_V)  ;
  fun fu2 : N -> V -> Cl ;
  lin fu2 man_N sleep_V = PredVP (DefPl man_N) (UseV sleep_V)  ;
-}
