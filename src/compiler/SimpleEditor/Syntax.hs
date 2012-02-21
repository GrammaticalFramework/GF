{-
Abstract syntax for the small subset of GF grammars supported
in gfse, the JavaScript-based simple grammar editor.
-}
module SimpleEditor.Syntax where

type Id    = String -- all sorts of identifiers
type ModId = Id -- module name
type Cat   = Id -- category name
type FunId = Id -- function name
type Type  = [Cat] -- [Cat_1,...,Cat_n] means Cat_1 -> ... -> Cat_n

data Grammar  = Grammar { basename :: ModId,
                          extends  :: [ModId],
                          abstract :: Abstract,
                          concretes:: [Concrete] }
                deriving Show

data Abstract = Abstract { startcat:: Cat, cats:: [Cat], funs:: [Fun] }
                deriving Show
data Fun      = Fun      { fname:: FunId, ftype:: Type }
                deriving Show

data Concrete = Concrete { langcode:: Id,
                           opens:: [ModId],
		           params:: [Param],
		           lincats:: [Lincat],
		           opers:: [Oper],
		           lins:: [Lin] }
                deriving Show

data Param  = Param  {pname:: Id, prhs:: String}              deriving Show
data Lincat = Lincat {cat  :: Cat, lintype:: Term}            deriving Show
data Oper   = Oper   {oname:: Lhs, orhs:: Term}               deriving Show
data Lin    = Lin    {fun  :: FunId, args:: [Id], lin:: Term} deriving Show

type Lhs = String -- name and type of oper,
                  -- e.g "regN : Str -> { s:Str,g:Gender} ="
type Term = String -- arbitrary GF term (not parsed by the editor)
