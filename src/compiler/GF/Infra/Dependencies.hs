module GF.Infra.Dependencies (
  depGraph
  ) where

import GF.Grammar.Grammar
import GF.Infra.Modules
import GF.Infra.Ident

import Data.List (nub,isPrefixOf)

-- the list gives the only modules to show, e.g. to hide the library details
depGraph :: Maybe [String] -> SourceGrammar -> String
depGraph only = prDepGraph . grammar2moddeps only

prDepGraph :: [(Ident,ModDeps)] -> String
prDepGraph deps = unlines $ [
  "digraph {"
  ] ++
  map mkNode deps ++
  concatMap mkArrows deps ++ [
  "}"
  ]
 where
   mkNode (i,dep) = unwords [showIdent i, "[",nodeAttr (modtype dep),"]"]
   nodeAttr ty = case ty of
       MTAbstract   -> "style = \"solid\", shape = \"box\""
       MTConcrete _ -> "style = \"solid\", shape = \"ellipse\""
       _ -> "style = \"dashed\", shape = \"ellipse\""
   mkArrows (i,dep) = 
     [unwords [showIdent i,"->",showIdent j,"[",arrowAttr "of","]"] | j <- ofs dep] ++
     [unwords [showIdent i,"->",showIdent j,"[",arrowAttr "ex","]"] | j <- extendeds dep] ++
     [unwords [showIdent i,"->",showIdent j,"[",arrowAttr "op","]"] | j <- openeds dep] ++
     [unwords [showIdent i,"->",showIdent j,"[",arrowAttr "ed","]"] | j <- extrads dep]
   arrowAttr s = case s of
     "of" -> "style = \"solid\", arrowhead = \"empty\""
     "ex" -> "style = \"solid\""
     "op" -> "style = \"dashed\""
     "ed" -> "style = \"dotted\""

data ModDeps = ModDeps {
  modtype    :: ModuleType,
  ofs        :: [Ident],
  extendeds  :: [Ident], 
  openeds    :: [Ident],
  extrads    :: [Ident],
  functors   :: [Ident],
  interfaces :: [Ident],
  instances  :: [Ident]
  }

noModDeps = ModDeps MTAbstract [] [] [] [] [] [] []

grammar2moddeps :: Maybe [String] -> SourceGrammar -> [(Ident,ModDeps)]
grammar2moddeps monly gr = [(i,depMod i m) | (i,m) <- modules gr, yes i]
  where
    depMod i m = 
        noModDeps{
          modtype = mtype m,
          ofs     = case mtype m of 
                     MTConcrete i -> [i | yes i]
                     MTInstance i -> [i | yes i]
                     _ -> [],
          extendeds = nub $ filter yes $ map fst (extend m),
          openeds = nub $ filter yes $ map openedModule (opens m),
          extrads = nub $ filter yes $ mexdeps m
          }
    yes i = case monly of 
      Just only -> match (showIdent i) only
      _ -> True
    match s os = any (\x -> doMatch x s) os
    doMatch x s = case last x of 
      '*' -> isPrefixOf (init x) s
      _   -> x == s

