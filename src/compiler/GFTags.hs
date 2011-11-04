module GFTags where

import GF.Infra.Option
import GF.Infra.UseIO
import GF.Grammar
import GF.Compile

import Data.List
import qualified Data.Map as Map
import qualified Data.Set as Set
import Control.Monad
import Text.PrettyPrint

mainTags opts files = do
  gr <- batchCompile opts files
  let tags = foldl getTags [] (modules gr)
  ioeIO (writeFile "tags" (unlines ((Set.toList . Set.fromList) tags)))

getTags x (m,mi) = 
  [showIdent m ++ "." ++ showIdent i ++ "\t" ++ k ++ "\t" ++ l ++ "\t" ++ t 
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
    getLocations (CncCat mb_type mb_def mb_prn) = maybe (loc "lincat")       mb_type ++ 
                                                  maybe (loc "lindef")       mb_def  ++ 
                                                  maybe (loc "printname")    mb_prn
    getLocations (CncFun _ mb_lin mb_prn)       = maybe (loc "lin")          mb_lin ++
                                                  maybe (loc "printname")    mb_prn
    getLocations _                              = []

    loc kind (L loc _) = [(kind,render (ppLocation (msrc mi) loc),"")]

    ltype kind (L loc ty) = [(kind,render (ppLocation (msrc mi) loc),render (ppTerm Unqualified 0 ty))]

    maybe f (Just x) = f x
    maybe f Nothing  = []

    list f xs = concatMap f xs
    
    render = renderStyle style{mode=OneLineMode}
