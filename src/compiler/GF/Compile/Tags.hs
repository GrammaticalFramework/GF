module GF.Compile.Tags
         ( writeTags
         , gf2gftags
         ) where

import GF.Infra.Option
import GF.Infra.UseIO
import GF.Data.Operations
import GF.Grammar

import Data.List
import qualified Data.Map as Map
import qualified Data.Set as Set
import Control.Monad
import Text.PrettyPrint
import System.FilePath

writeTags opts gr file mo = do
  let imports = getImports opts gr mo
      locals  = getLocalTags [] mo
      txt     = unlines ((Set.toList . Set.fromList) (imports++locals))
  putPointE Normal opts ("  write file" +++ file) $ ioeIO $ writeFile file txt

getLocalTags x (m,mi) = 
  [showIdent i ++ "\t" ++ k ++ "\t" ++ l ++ "\t" ++ t 
       | (i,jment) <- Map.toList (jments mi),
         (k,l,t)   <- getLocations jment] ++ x
  where
    getLocations :: Info -> [(String,String,String)]
    getLocations (AbsCat mb_ctxt)               = maybe (loc "cat")          mb_ctxt
    getLocations (AbsFun mb_type _ mb_eqs _)    = maybe (ltype "fun")        mb_type ++
                                                  maybe (list (loc "def"))   mb_eqs  
    getLocations (ResParam mb_params _)         = maybe (loc "param")        mb_params
    getLocations (ResValue mb_type)             = ltype "param-value"          mb_type
    getLocations (ResOper  mb_type mb_def)      = maybe (ltype "oper-type")  mb_type ++
                                                  maybe (loc "oper-def")     mb_def
    getLocations (ResOverload _ defs)           = list (\(x,y) -> ltype "overload-type" x ++ 
                                                                  loc   "overload-def"  y) defs
    getLocations (CncCat mty mdef mprn _)       = maybe (loc "lincat")       mty ++ 
                                                  maybe (loc "lindef")       mdef  ++ 
                                                  maybe (loc "printname")    mprn
    getLocations (CncFun _ mlin mprn _)         = maybe (loc "lin")          mlin ++
                                                  maybe (loc "printname")    mprn
    getLocations _                              = []

    loc kind (L loc _) = [(kind,render (ppLocation (msrc mi) loc),"")]

    ltype kind (L loc ty) = [(kind,render (ppLocation (msrc mi) loc),render (ppTerm Unqualified 0 ty))]

    maybe f (Just x) = f x
    maybe f Nothing  = []

    list f xs = concatMap f xs
    
    render = renderStyle style{mode=OneLineMode}


getImports opts gr mo@(m,mi) = concatMap toDep allOpens
  where
    allOpens = [(OSimple m,incl) | (m,incl) <- mextend mi] ++ 
               [(o,MIAll) | o <- mopens mi]

    toDep (OSimple m,incl)     =
      let Ok mi = lookupModule gr m
      in [showIdent id ++ "\t" ++ "indir" ++ "\t" ++ showIdent m ++ "\t\t" ++ gf2gftags opts (orig mi info)
            | (id,info) <- Map.toList (jments mi), filter incl id]
    toDep (OQualif m1 m2,incl) =
      let Ok mi = lookupModule gr m2
      in [showIdent id ++ "\t" ++ "indir" ++ "\t" ++ showIdent m2 ++ "\t" ++ showIdent m1 ++ "\t" ++ gf2gftags opts (orig mi info) 
            | (id,info) <- Map.toList (jments mi), filter incl id]

    filter MIAll          id = True
    filter (MIOnly   ids) id = elem id ids
    filter (MIExcept ids) id = not (elem id ids)

    orig mi info =
      case info of
        AnyInd _ m0 -> let Ok mi0 = lookupModule gr m0
                       in msrc mi0
        _           ->    msrc mi 

gftagsFile :: FilePath -> FilePath
gftagsFile f = addExtension f "gf-tags"

gf2gftags :: Options -> FilePath -> FilePath
gf2gftags opts file = maybe (gftagsFile (dropExtension file))
                            (\dir -> dir </> gftagsFile (dropExtension (takeFileName file)))
                            (flag optOutputDir opts)
