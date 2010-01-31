module GF.Infra.Dependencies (
  depGraph
  ) where

import GF.Grammar.Grammar
import GF.Infra.Modules
import GF.Infra.Ident

depGraph :: SourceGrammar -> String
depGraph = prDepGraph . grammar2moddeps

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

grammar2moddeps :: SourceGrammar -> [(Ident,ModDeps)]
grammar2moddeps gr = [(i,depMod m) | (i,m) <- modules gr] where
  depMod m = noModDeps{
    modtype = mtype m,
    ofs     = case mtype m of 
                MTConcrete i -> [i]
                MTInstance i -> [i]
                _ -> [],
    extendeds = map fst (extend m),
    openeds = map openedModule (opens m),
    extrads = mexdeps m
    }
