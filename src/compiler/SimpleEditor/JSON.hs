module SimpleEditor.JSON where

import Text.JSON

import SimpleEditor.Syntax


instance JSON Grammar where
  showJSON (Grammar name extends abstract concretes) =
    makeObj [prop "basename" name,
             prop "extends" extends,
             prop "abstract" abstract,
             prop "concretes" concretes]

instance JSON Abstract where
  showJSON (Abstract startcat cats funs) =
    makeObj [prop "startcat" startcat,
             prop "cats" cats,
             prop "funs" funs]

instance JSON Fun   where showJSON (Fun   name typ) = signature  name typ
instance JSON Param where showJSON (Param name rhs) = definition name rhs
instance JSON Oper  where showJSON (Oper  name rhs) = definition name rhs

signature  name typ = makeObj [prop "name" name,prop "type" typ]
definition name rhs = makeObj [prop "name" name,prop "rhs" rhs]

instance JSON Concrete where
  showJSON (Concrete langcode opens params lincats opers lins) =
    makeObj [prop "langcode" langcode,
             prop "opens" opens,
             prop "params" params,
             prop "lincats" lincats,
             prop "opers" opers,
             prop "lins" lins]

instance JSON Lincat where
  showJSON (Lincat cat lintype) =
    makeObj [prop "cat" cat,prop "type" lintype]

instance JSON Lin where
  showJSON (Lin fun args lin) =
    makeObj [prop "fun" fun,
             prop "args" args,
             prop "lin" lin]

prop name v = (name,showJSON v)
