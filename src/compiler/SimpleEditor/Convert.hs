{-# LANGUAGE NoMonomorphismRestriction #-}
module SimpleEditor.Convert where

import Control.Monad(unless,foldM,ap)
import qualified Data.Map as Map
import qualified Data.ByteString.Char8 as BS(pack)
import Text.JSON(encode,makeObj)

--import GF.Compile.GetGrammar (getSourceModule)
--import GF.Infra.Option(noOptions)
import GF.Infra.Ident(showIdent)
--import GF.Infra.UseIO(appIOE)
import GF.Grammar.Grammar
import GF.Grammar.Parser(runP,pModDef)
import GF.Grammar.Lexer(Posn(..))
import GF.Data.ErrM

import SimpleEditor.Syntax
import SimpleEditor.JSON


parseModule (path,source) =
   prop path $ 
   case runP pModDef (BS.pack source) of
     Left (Pn l c,msg) ->
         makeObj [prop "error" msg,
                  prop "location" (show l++":"++show c)]
     Right mod -> case convAbstract mod of
                    Ok g -> makeObj [prop "converted" g]
                    Bad msg -> makeObj [prop "parsed" msg]

{-
convAbstractFile path =
    appIOE (fmap encode . convAbstract =<< getSourceModule noOptions path)
-}
convAbstract (modid,src) =
  do unless (isModAbs src) $ fail "Abstract syntax expected"
     unless (isCompleteModule src) $ fail "A complete abstract syntax expected"
     extends <- convExtends (mextend src)
     (cats,funs) <- convJments (jments src)
     let startcat = head (cats++["-"]) -- !!!
     return $ Grammar (convId modid) extends (Abstract startcat cats funs) []

convExtends = mapM convExtend
convExtend (modid,MIAll) = return (convId modid)
convExtend _ = fail "unsupported module extension"

convJments jments = foldM convJment ([],[]) (Map.toList jments)

convJment (cats,funs) (name,jment) =
  case jment of
    AbsCat octx -> do unless (null (maybe [] unLoc octx)) $
                             fail "category with context"
                      let cat = convId name
                      return (cat:cats,funs)
    AbsFun (Just lt) _ oeqns _ -> do unless (null (maybe [] id oeqns)) $
                                            fail "function with equations"
                                     let f = convId name
                                     typ <- convType (unLoc lt)
                                     let fun = Fun f typ
                                     return (cats,fun:funs)
    _ -> fail $ "unsupported judgement form: "++show jment

convType (Prod _ _ t1 t2) = (:) `fmap` convSimpleType t1 `ap` convType t2
convType t = (:[]) `fmap` convSimpleType t


convSimpleType (Vr id) = return (convId id)
convSimpleType t = fail "unsupported type"

convId = showIdent
