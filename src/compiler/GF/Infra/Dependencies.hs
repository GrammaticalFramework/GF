module GF.Infra.Dependencies (
  depGraph
  ) where

import GF.Grammar.Grammar
--import GF.Infra.Ident(Ident)
import GF.Text.Pretty(render)

import Data.List (nub,isPrefixOf)

-- the list gives the only modules to show, e.g. to hide the library details
depGraph :: Maybe [String] -> Grammar -> String
depGraph only = prDepGraph . grammar2moddeps only

prDepGraph :: [(ModuleName,ModDeps)] -> String
prDepGraph deps = unlines $ [
  "digraph {"
  ] ++
  map mkNode deps ++
  concatMap mkArrows deps ++ [
  "}"
  ]
 where
   mkNode (i,dep) = unwords [render i, "[",nodeAttr (modtype dep),"]"]
   nodeAttr ty = case ty of
       MTAbstract   -> "style = \"solid\", shape = \"box\""
       MTConcrete _ -> "style = \"solid\", shape = \"ellipse\""
       _ -> "style = \"dashed\", shape = \"ellipse\""
   mkArrows (i,dep) = 
     [unwords [render i,"->",render j,"[",arrowAttr "of","]"] | j <- ofs dep] ++
     [unwords [render i,"->",render j,"[",arrowAttr "ex","]"] | j <- extendeds dep] ++
     [unwords [render i,"->",render j,"[",arrowAttr "op","]"] | j <- openeds dep] ++
     [unwords [render i,"->",render j,"[",arrowAttr "ed","]"] | j <- extrads dep]
   arrowAttr s = case s of
     "of" -> "style = \"solid\", arrowhead = \"empty\""
     "ex" -> "style = \"solid\""
     "op" -> "style = \"dashed\""
     "ed" -> "style = \"dotted\""

data ModDeps = ModDeps {
  modtype    :: ModuleType,
  ofs        :: [ModuleName],
  extendeds  :: [ModuleName],
  openeds    :: [ModuleName],
  extrads    :: [ModuleName],
  functors   :: [ModuleName],
  interfaces :: [ModuleName],
  instances  :: [ModuleName]
  }

noModDeps = ModDeps MTAbstract [] [] [] [] [] [] []

grammar2moddeps :: Maybe [String] -> Grammar -> [(ModuleName,ModDeps)]
grammar2moddeps monly gr = [(i,depMod i m) | (i,m) <- modules gr, yes i]
  where
    depMod i m = 
        noModDeps{
          modtype = mtype m,
          ofs     = case mtype m of 
                     MTConcrete i -> [i | yes i]
                     MTInstance (i,_) -> [i | yes i]
                     _ -> [],
          extendeds = nub $ filter yes $ map fst (mextend m),
          openeds = nub $ filter yes $ map openedModule (mopens m),
          extrads = nub $ filter yes $ mexdeps m
          }
    yes i = case monly of 
      Just only -> match (render i) only
      _ -> True
    match s os = any (\x -> doMatch x s) os
    doMatch x s = case last x of 
      '*' -> isPrefixOf (init x) s
      _   -> x == s

