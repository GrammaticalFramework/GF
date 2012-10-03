module SimpleEditor.JSON where

import Text.JSON

import SimpleEditor.Syntax


instance JSON Grammar where
  showJSON (Grammar name extends abstract concretes) =
    makeObj ["basename".=name, "extends".=extends,
             "abstract".=abstract, "concretes".=concretes]

instance JSON Abstract where
  showJSON (Abstract startcat cats funs) =
    makeObj ["startcat".=startcat, "cats".=cats, "funs".=funs]

instance JSON Fun   where showJSON (Fun   name typ) = signature  name typ
instance JSON Param where showJSON (Param name rhs) = definition name rhs
instance JSON Oper  where showJSON (Oper  name rhs) = definition name rhs

signature  name typ = makeObj ["name".=name,"type".=typ]
definition name rhs = makeObj ["name".=name,"rhs".=rhs]

instance JSON Concrete where
  showJSON (Concrete langcode opens params lincats opers lins) =
    makeObj ["langcode".=langcode, "opens".=opens,
              "params".=params, "opers".=opers,
             "lincats".=lincats, "lins".=lins]

instance JSON Lincat where
  showJSON (Lincat cat lintype) = makeObj ["cat".=cat, "type".=lintype]

instance JSON Lin where
  showJSON (Lin fun args lin) = makeObj ["fun".=fun, "args".=args, "lin".=lin]

infix 1 .=
name .= v = (name,showJSON v)
