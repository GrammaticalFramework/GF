GF C Bindings
Copyright (C) 2008-2009 Kevin Kofler

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, see <http://www.gnu.org/licenses/>.


This library provides access to the GF embedded grammars (PGF) API to C/C++
applications. To use it:
1. #include "pgf.h"
2. call gf_init(&argc, &argv); at the beginning of main()
3. call gf_exit(); before exiting the program
4. build with: ghc --make -fglasgow-exts -O2 -no-hs-main $* x.c PGFFFI.hs -o x


Currently, the following functions from PGF are wrapped:
readPGF  :: FilePath -> IO PGF
mkCId :: String -> CId
wildCId :: CId
showCId :: CId -> String
readCId :: String -> Maybe CId
showLanguage :: Language -> String
readLanguage :: String -> Maybe Language
languages :: PGF -> [Language]
abstractName :: PGF -> Language
languageCode :: PGF -> Language -> Maybe String
showType :: Type -> [CId] -> String (*)
readType :: String -> Maybe Type
categories :: PGF -> [CId]
startCat :: PGF -> Type
showExpr :: Expr -> [CId] -> String (*)
readExpr :: String -> Maybe Expr
linearize :: PGF -> Language -> Tree -> String
showPrintName :: PGF -> Language -> CId -> String
parse :: PGF -> Language -> Type -> String -> [Tree]
(*) The [CId] parameter is currently not mapped; instead, [] is always passed.


Some notes about the wrapping:
* "gf_" is prepended to the wrapped functions as a form of namespacing.
* Object types T are mapped to opaque C types GF_T which are handles to the
  object. Whenever returned by a function, they get marked as used (so the
  Haskell garbage collection won't delete them), so when you are done using
  them, you should free them (assuming they're non-NULL) with the corresponding
  gf_freeT function (i.e. one of: gf_freePGF, gf_freeLanguage, gf_freeType,
  gf_freeCId, gf_freeTree, gf_freeExpr). (Internally, they are all Haskell
  StablePtr handles, but this is subject to change.)
* Strings are mapped to char *. Strings returned by functions, when not NULL,
  are allocated with malloc and should thus be freed with free when no longer
  needed.
* A FilePath is a string.
* A type Maybe T is mapped the same way as just T, except that the returned
  handle or char * can be NULL, so you should test them with a test like if (p).
  Otherwise functions can be expected to always return non-NULL
  handles/pointers. Conversely, arguments to functions are always assumed to be
  non-NULL.
* Lists [T] are mapped to null-terminated arrays GF_T[], passed/returned as
  pointers GF_T *. All objects in the array should be freed with the correct
  gf_freeT function when no longer needed, the array itself with free. For your
  convenience, the C header defines inline functions gf_freeLanguages,
  gf_freeTypes and gf_freeTrees which free an entire array.
* Bool is wrapped to int using the usual C convention of 1 = True, 0 = False.
* A constant like wildCId is mapped to a function with no arguments, e.g.
  GF_CId wildCId(void). The returned handle has to be freed as for any other
  function.


Thus, the C prototypes for the wrapped functions are:
GF_PGF *gf_readPGF(char *path);
GF_CId gf_mkCId(char *str);
GF_CId wildCId(void);
char *gf_showCId(GF_CID cid);
GF_CId gf_readCId(char *str); /* may return NULL */
char *gf_showLanguage(GF_Language lang);
GF_Language gf_readLanguage(char *str); /* may return NULL */
GF_Language *gf_languages(GF_PGF pgf);
GF_Language gf_abstractName(GF_PGF pgf);
char *gf_languageCode(GF_PGF pgf, GF_Language lang); /* may return NULL */
char *gf_showType(GF_Type tp);
GF_Type gf_readType(char *str); /* may return NULL */
GF_CId *gf_categories(GF_PGF pgf);
GF_Type gf_startCat(GF_PGF pgf);
char *gf_showExpr(GF_Expr expr);
GF_Expr gf_readExpr(char *str); /* may return NULL */
char *gf_linearize(GF_PGF pgf, GF_Language lang, GF_Tree tree);
char *gf_showPrintName(GF_PGF pgf, GF_Language lang, GF_CId cid);
GF_Tree *gf_parse(GF_PGF pgf, GF_Language lang, GF_Type cat, char *input);

The C prototypes for the freeing functions are:
void gf_freePGF(GF_PGF pgf);
void gf_freeCId(GF_CId cid);
void gf_freeLanguage(GF_Language lang);
void gf_freeType(GF_Type tp);
void gf_freeTree(GF_Tree tree);
void gf_freeExpr(GF_Expr expr);
void gf_freeCIds(GF_Type *p);
void gf_freeLanguages(GF_Language *p);
void gf_freeTrees(GF_Tree *p);



In addition, the following function from GF.Text.Lexing:
stringOp :: String -> Maybe (String -> String)
is wrapped as:
char *gf_stringOp(char *op, char *str)
which returns NULL if op is not a valid operation name, otherwise applies the
function corresponding to op to the string str. The resulting string must be
freed with free if non-NULL.
