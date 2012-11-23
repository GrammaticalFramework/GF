{-# LANGUAGE NoMonomorphismRestriction #-}
module SimpleEditor.Convert where

import Control.Monad(unless,foldM,ap,mplus)
import Data.List(sortBy)
import Data.Function(on)
import qualified Data.Map as Map
import Text.JSON(encode,makeObj)
import Text.PrettyPrint(render,text,(<+>))

-- 4 extra imports just to deal with the ByteString mess...
import qualified Data.ByteString.Char8 as BS(pack)
import Codec.Binary.UTF8.String(encodeString)
import GF.Compile.Coding(decodeStringsInModule)
import System.IO(utf8)

--import GF.Compile.GetGrammar (getSourceModule)
import GF.Infra.Option(optionsGFO)
import GF.Infra.Ident(showIdent)
--import GF.Infra.UseIO(appIOE)
import GF.Grammar.Grammar
import GF.Grammar.Printer(ppParams,ppTerm,getAbs,TermPrintQual(..))
import GF.Grammar.Parser(runP,pModDef)
import GF.Grammar.Lexer(Posn(..))
import GF.Data.ErrM

import SimpleEditor.Syntax as S
import SimpleEditor.JSON


parseModule (path,source) =
   (path.=) $
   case runP pModDef (BS.pack (encodeString source)) of
     Left (Pn l c,msg) ->
         makeObj ["error".=msg, "location".= show l++":"++show c]
     Right mod -> case convModule (decodeStringsInModule utf8 mod) of
                    Ok g -> makeObj ["converted".=g]
                    Bad msg -> makeObj ["parsed".=msg]

{-
convAbstractFile path =
    appIOE (fmap encode . convAbstract =<< getSourceModule noOptions path)
-}

convModule m@(modid,src) =
  if isModAbs src
  then convAbstract m
  else if isModCnc src
       then convConcrete m
       else fail "An abstract or concrete syntax module was expected"

convAbstract (modid,src) =
  do unless (isModAbs src) $ fail "Abstract syntax expected"
     unless (isCompleteModule src) $ fail "A complete abstract syntax expected"
     extends <- convExtends (mextend src)
     (cats0,funs0) <- convAbsJments (jments src)
     let cats = reverse cats0
         funs = reverse funs0
         flags = optionsGFO (mflags src)
         startcat = maybe "-" id $ lookup "startcat" flags
     return $ Grammar (convId modid) extends (Abstract startcat cats funs) []

convExtends = mapM convExtend
convExtend (modid,MIAll) = return (convId modid)
convExtend _ = fail "unsupported module extension"

convAbsJments jments = foldM convAbsJment ([],[]) (jmentList jments)

convAbsJment (cats,funs) (name,jment) =
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

convConcrete (modid,src) =
  do unless (isModCnc src) $ fail "Concrete syntax expected"
     unless (isCompleteModule src) $ fail "A complete concrete syntax expected"
     extends <- convExtends (mextend src)
     opens <- convOpens (mopens src)
     js <- convCncJments (jments src)
     let ps  = [p  | Pa p <-js]
         lcs = [lc | LC lc<-js]
         os  = [o  | Op o <-js]
         ls  = [l  | Li l <-js]
         langcode = "" -- !!!
         conc = Concrete langcode opens ps lcs os ls
         abs = Abstract "-" [] [] -- dummy
     return $ Grammar (convId modid) extends abs [conc]

convOpens = mapM convOpen

convOpen o =
  case o of
    OSimple id -> return (convId id)
    _ -> fail "unsupported module open"


data CncJment = Pa S.Param | LC Lincat | Op Oper | Li Lin | Ignored

convCncJments = mapM convCncJment . jmentList

convCncJment (name,jment) =
  case jment of
    ResParam ops _ ->
      return $ Pa $ Param i (maybe "" (render . ppParams q . unLoc) ops)
    ResValue _ -> return Ignored
    CncCat (Just (L _ typ)) Nothing pprn _ -> -- ignores printname !!
      return $ LC $ Lincat i (render $ ppTerm q 0 typ)
    ResOper oltyp (Just lterm) -> return $ Op $ Oper lhs rhs
      where
        lhs = i++maybe "" ((" : "++) . render . ppTerm q 0 . unLoc) oltyp
        rhs = render (text " ="<+>ppTerm q 0 (unLoc lterm))
    ResOverload [] defs -> return $ Op $ Oper lhs rhs
      where
        lhs = i
        rhs = render $ text " = overload"<+>ppTerm q 0 r
        r =  R [(lab,(Just ty,fu)) | (L _ ty,L _ fu) <-defs]
        lab = ident2label name
    CncFun _ (Just ldef) pprn _ -> -- ignores printname !!
      do let (xs,e') = getAbs (unLoc ldef)
             lin = render $ ppTerm q 0 e'
         args <- mapM convBind xs
         return $ Li $ Lin i args lin
    _ -> fail $ "unsupported judgement form: "++show jment
  where
    i = convId name
    q = Unqualified

convBind (Explicit,v) = return $ convId v
convBind (Implicit,v) = fail "implicit binding not supported"

jmentList = sortBy (compare `on` (jmentLocation.snd)) . Map.toList

jmentLocation jment =
  case jment of
    AbsCat ctxt      -> fmap loc ctxt
    AbsFun ty _ _ _  -> fmap loc ty
    ResParam ops _   -> fmap loc ops
    CncCat ty _ _ _  -> fmap loc ty
    ResOper ty rhs   -> fmap loc rhs `mplus` fmap loc ty
    CncFun _ rhs _ _ -> fmap loc rhs
    _ -> Nothing


loc (L l _) = l
