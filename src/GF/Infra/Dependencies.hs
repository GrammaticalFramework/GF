module GF.Infra.Dependencies (
  depGraph
  ) where

import GF.Grammar.Grammar
import GF.Grammar.PrGrammar
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
   mkNode (i,dep) = unwords [prt i, "[",nodeAttr (modtype dep),"]"]
   nodeAttr ty = case ty of
       MTAbstract   -> "style = \"solid\", shape = \"box\""
       MTConcrete _ -> "style = \"solid\", shape = \"ellipse\""
       _ -> "style = \"dashed\", shape = \"ellipse\""
   mkArrows (i,dep) = 
     [unwords [prt i,"->",prt j,"[",arrowAttr "of","]"] | j <- ofs dep] ++
     [unwords [prt i,"->",prt j,"[",arrowAttr "ex","]"] | j <- extendeds dep] ++
     [unwords [prt i,"->",prt j,"[",arrowAttr "op","]"] | j <- openeds dep]
   arrowAttr s = case s of
     "of" -> "style = \"solid\", arrowhead = \"empty\""
     "ex" -> "style = \"solid\""
     "op" -> "style = \"dashed\""

data ModDeps = ModDeps {
  modtype    :: ModuleType Ident,
  ofs        :: [Ident],
  extendeds  :: [Ident], 
  openeds    :: [Ident],
  functors   :: [Ident],
  interfaces :: [Ident],
  instances  :: [Ident]
  }

noModDeps = ModDeps MTAbstract [] [] [] [] [] []

grammar2moddeps :: SourceGrammar -> [(Ident,ModDeps)]
grammar2moddeps gr = [(i,depMod m) | (i,m) <- modules gr] where
  depMod m = noModDeps{
    modtype = mtype m,
    ofs     = case mtype m of 
                MTConcrete i -> [i]
                MTInstance i -> [i]
                _ -> [],
    extendeds = map fst (extend m),
    openeds = map openedModule (opens m)
    }
