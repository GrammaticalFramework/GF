// GF Python bindings
// Jordi Saludes, upc.edu 2010
//

#include <Python.h>
#include <sys/stat.h>
#include "pygf.h"

/* utilities */

int
checkType(void* obj, PyTypeObject* tp)
{
  int isRight = PyObject_TypeCheck((PyObject*)obj, tp);
  if (!isRight)
    PyErr_Format(PyExc_TypeError, "Expecting a %s.", tp->tp_doc);
  return isRight;
}


/* new types and declarations */

NEWGF(CId,GF_CId,CIdType,"gf.cid","identifier")
NEWGF(Lang,GF_Language,LangType,"gf.lang","language")
NEWGF(gfType,GF_Type,gfTypeType,"gf.type","gf type")
NEWGF(PGF,GF_PGF,PGFType,"gf.pgf","PGF module")
NEWGF(Expr,GF_Expr,ExprType,"gf.expr","gf expression")	
NEWGF(Tree,GF_Tree,TreeType,"gf.tree","gf tree")


/* CId methods, constructor and destructor */

DEALLOCFN(CId_dealloc, CId, gf_freeCId, "freeCId")


/* PGF methods, constructor and destructor */

DEALLOCFN(PGF_dealloc, PGF, gf_freePGF, "freePGF")

static PyObject* 
pgf_repr(PGF *self) {
  Lang* lang = gf_abstractName(self);
  char* abs = gf_showLanguage(lang);
  Py_DECREF(lang);					     
  PyObject* str = PyString_FromFormat("<gf.pgf with abstract %s>", abs);
  free(abs);
return str;
}

static PyObject*
languageCode(PGF *self, PyObject *args)
{
  Lang *lang;
  if (!PyArg_ParseTuple(args, "O", &lang))
    return NULL;
  if (!checkType(lang, &LangType)) return NULL;
  char* scode = gf_languageCode(self, lang);
  if (scode) {
    PyObject* result = PyString_FromString(scode);
    free(scode);
    return result;
  } else {
    Py_INCREF(Py_None);
    return Py_None;
  }
}

static PyObject*
linearize(PGF *self, PyObject *args)
{
  Lang *lang;
  Tree *tree;
  if (!PyArg_ParseTuple(args, "OO", &lang, &tree))
    return NULL;
  if (!checkType(lang,&LangType)) return NULL;
  if (!checkType(tree,&TreeType)) return NULL;
  char* c_lin = gf_linearize(self, lang, tree);
  PyObject* lin = PyString_FromString(c_lin);
  free(c_lin);
  return lin;
}

static Lang*
abstractName(PGF *self)
{
  if (!checkType(self,&PGFType)) return NULL;
  return gf_abstractName(self);
}

static PyObject*
printName(PGF *self, PyObject *args)
{
	Lang* lang;
	CId* id;
	if (!PyArg_ParseTuple(args, "OO", &lang, &id))
		return NULL;
	if (!checkType(lang,&LangType)) return NULL;
	if (!checkType(id,&CIdType)) return NULL;
	char *pname = gf_showPrintName(self, lang, id);
	PyObject* result = PyString_FromString(pname);
	free(pname);
	return result;
}

static gfType*
functiontype(PGF *self, PyObject* args)
{
  CId* cid;
  gfType* gftp;
  if (!PyArg_ParseTuple(args, "O", &cid))
    return NULL;
  if (!checkType(cid,&CIdType)) {
    PyErr_Format(PyExc_TypeError, "Must be a gf identifier.");
    return NULL;
  }
  return gf_functiontype(self, cid);
}


static PyObject*
parse(PGF *self, PyObject *args, PyObject *kws)
{
	Lang *lang;
	gfType *cat = NULL;
	char *lexed;
	static char *kwlist[] = {"lexed", "lang", "cat", NULL};
	if (!PyArg_ParseTupleAndKeywords(args, kws, "sO|O", kwlist,
				       &lexed, &lang, &cat))
    	return NULL;
	if (!checkType(self, &PGFType)) return NULL;
	if (!checkType(lang, &LangType)) return NULL;
	if (cat) {
	  if (!checkType(cat, &gfTypeType)) return NULL;
	} else { 
	  cat = gf_startCat(self);		
	} 
	return gf_parse(self, lang, cat, lexed);
}

static PGF*
readPGF(PyObject *self, PyObject *args)
{
  char *path;
  struct stat info;
  if (!PyArg_ParseTuple(args, "s", &path))
    return NULL;
  if (stat(path, &info) == 0) {
    	PGF* pgf = gf_readPGF(path);
    	return pgf;
  } else {
		PyErr_Format(PyExc_IOError, "No such file: %s", path);
    	return NULL;
  }
}



static PyMethodDef pgf_methods[] = {
  {"parse", (PyCFunction)parse, METH_VARARGS|METH_KEYWORDS,"Parse a string."},
  {"lin", (PyCFunction)linearize, METH_VARARGS,"Linearize tree."},
  {"lang_code", (PyCFunction)languageCode, METH_VARARGS,"Get the language code."},
  {"print_name", (PyCFunction)printName, METH_VARARGS,"Get the print name for a id."},
  {"fun_type", (PyCFunction)functiontype, METH_VARARGS,"Get the type of a fun expression."},
  {"startcat", (PyCFunction)gf_startCat, METH_NOARGS,"Get the start category."},
  {"categories", (PyCFunction)gf_categories, METH_NOARGS,"Get all categories."},
  {"functions", (PyCFunction)gf_functions, METH_NOARGS,"Get all functions."},
  {"abstract", (PyCFunction)abstractName, METH_NOARGS,"Get the module abstract name."},
  {"languages", (PyCFunction)gf_languages, METH_NOARGS,"Get the module languages."},
  {NULL, NULL, 0, NULL}  /* Sentinel */
};

REPRCB(CId_repr, CId, gf_showCId)


/* Language methods, constructor and destructor */

REPRCB(lang_repr, Lang, gf_showLanguage)
DEALLOCFN(Lang_dealloc, Lang, gf_freeLanguage, "freeLanguage")

static Lang*
readLang(PyObject *self, PyObject *args)
{
  char *langName;
  Lang *l;
  if (!PyArg_ParseTuple(args,"s",&langName))
    return NULL;
  l = (Lang*)LangType.tp_new(&LangType,NULL,NULL);
  if(!l) return NULL;
  gf_readLanguage(l,langName);
  return l;
}



/* gf types: methods, constructor and destructor */

DEALLOCFN(gfType_dealloc, gfType, gf_freeType, "freeType")
REPRCB(gfType_repr, gfType, gf_showType)


/* expression type: methods, destructor */

DEALLOCFN(expr_dealloc, Expr, gf_freeExpr, "freeExpr")
REPRCB(expr_repr, Expr, gf_showExpr)


static PyObject*
unapp(Expr *self) {
  PyObject* obj = gf_unapp(self);
  if (!obj) {
    char* s = gf_unstr(self);
    if (s) {
      obj = PyString_FromString(s);
      free(s);
    } else {
      long n = gf_unint(self);
      if (n != -9) {
	obj = PyInt_FromLong(n);
      } else {
	PyErr_Format(PyExc_TypeError, "Cannot unapply expr.");
      }
    }
  }
  return obj;
}

static PyObject*
infer_expr(Expr *self, PyObject* args) {
  PGF* pgf;
  if (!PyArg_ParseTuple(args, "O", &pgf))
    return NULL;
  if (!checkType(pgf, &PGFType)) {
    PyErr_Format(PyExc_ValueError, "Must be a pgf module.");
    return NULL;
  }
  return gf_inferexpr(pgf, self);
}



/* todo: Is Tree == Expr ? */

static PyMethodDef expr_methods[] = {
  {"unapply", (PyCFunction)unapp, METH_NOARGS, "Unapply an expression."},
  {"infer", (PyCFunction)infer_expr, METH_VARARGS, "Infer the type of an expression."},
  {NULL, NULL, 0, NULL}  /* Sentinel */
};



/* tree typr: methods, constructor and destructor */
//  Are Expr and Tree equivalent ? 

REPRCB(tree_repr, Tree, gf_showExpr)
DEALLOCFN(Tree_dealloc, Tree, gf_freeTree, "freeTree")





/* gf module methods */

static PyMethodDef gf_methods[] = {
  {"read_pgf", (PyCFunction)readPGF, METH_VARARGS,"Read pgf file."},
  {"read_language", (PyCFunction)readLang, METH_VARARGS,"Get the language."},
  {NULL, NULL, 0, NULL}  /* Sentinel */
};


#ifndef PyMODINIT_FUNC/* declarations for DLL import/export */
#define PyMODINIT_FUNC void
#endif

PyMODINIT_FUNC
initgf(void) 
{
  PyObject* m;
#define READYTYPE(t,trepr,tdealloc) t.tp_new = PyType_GenericNew; \
    t.tp_repr = (reprfunc)trepr; \
	t.tp_dealloc = (destructor)tdealloc; \
	if (PyType_Ready(&t) < 0) return;
	
        READYTYPE(CIdType, CId_repr, CId_dealloc)
	PGFType.tp_methods = pgf_methods;
	READYTYPE(PGFType, pgf_repr, PGF_dealloc)
	READYTYPE(LangType, lang_repr, Lang_dealloc)
	READYTYPE(gfTypeType, gfType_repr, gfType_dealloc)
        ExprType.tp_methods = expr_methods;
	READYTYPE(ExprType, expr_repr, expr_dealloc)
	TreeType.tp_methods = expr_methods; // Tree == Expr ?
	READYTYPE(TreeType, tree_repr, Tree_dealloc)	

  m = Py_InitModule3("gf", gf_methods,
		     "Grammatical Framework.");
  static char *argv[] = {"gf.so", 0}, **argv_ = argv;
  static int argc = 1;
  gf_init (&argc, &argv_);
  hs_add_root (__stginit_PyGF);

#define ADDTYPE(t) Py_INCREF(&t);\
PyModule_AddObject(m, "gf", (PyObject *)&t);

	ADDTYPE(PGFType)
	ADDTYPE(LangType)
	ADDTYPE(gfTypeType)
	ADDTYPE(TreeType)
	ADDTYPE(ExprType)
}


/* List utilities to be imported by FFI */

inline PyObject* newList() { return  PyList_New(0); }
inline void append(PyObject* l, PyObject* ob) { PyList_Append(l, ob); }
