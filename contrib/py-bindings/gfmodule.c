#define CAT(a,b) XCAT(a,b)
#define XCAT(a,b) a ## b

#include <stdio.h>
#include <stdlib.h>
#include "pgf.h" 
#include <Python.h>

static PyObject*
readPGF(PyObject *self, PyObject *args)
{
  char *path;
  if (!PyArg_ParseTuple(args, "s", &path))
    return NULL;
  GF_PGF pgf = gf_readPGF(path);
  return PyCObject_FromVoidPtr(pgf, gf_freePGF);
}

static PyObject*
readLanguage(PyObject *self, PyObject *args)
{
  char *module_name;
    if (!PyArg_ParseTuple(args, "s", &module_name))
    return NULL;
  GF_Language lang = gf_readLanguage(module_name);
  return PyCObject_FromVoidPtr(lang, gf_freeLanguage);
}

static PyObject*
showExpr(PyObject *self, PyObject *args)
{
  PyObject *co_exp;
  GF_Expr exp;
  if (!PyArg_ParseTuple(args, "O", &co_exp))
    return NULL;
  if (!PyCObject_Check(co_exp)) {
    PyErr_SetString(PyExc_TypeError, "Expected an expression.");
    return NULL;
  }
  exp = (GF_Expr)PyCObject_AsVoidPtr(co_exp);
  char *str = gf_showExpr(exp);
  return Py_BuildValue("s",str);
}


static PyObject*
startCat(PyObject *self, PyObject *args)
{
  PyObject *cobj;
  GF_PGF pgf;
    if (!PyArg_ParseTuple(args, "O", &cobj))
    return NULL;
    if (!PyCObject_Check(cobj)) {
      PyErr_SetString(PyExc_TypeError, "Expected a pgf object");
      return NULL;
    }
   pgf = (GF_PGF)PyCObject_AsVoidPtr(cobj);
   GF_Type cat = gf_startCat(pgf);
  return PyCObject_FromVoidPtr(cat, gf_freeType);
}

static PyObject*
parse(PyObject *self, PyObject *args)
{
  PyObject *co_pgf, *co_lang, *co_cat;
  GF_PGF pgf;
  GF_Language lang;
  GF_Type cat;
  char *lexed;
  if (!PyArg_ParseTuple(args, "OOOs", &co_pgf, &co_lang, &co_cat, &lexed))
    return NULL;
  if (!PyCObject_Check(co_pgf)) {
      PyErr_SetString(PyExc_TypeError, "Expected a PGF object");
      return NULL;
  }
  if (!PyCObject_Check(co_lang)) {
      PyErr_SetString(PyExc_TypeError, "Expected a Language object");
      return NULL;
  }
  if (!PyCObject_Check(co_cat)) {
      PyErr_SetString(PyExc_TypeError, "Expected a Type object");
      return NULL;
  }
  pgf = (GF_PGF)PyCObject_AsVoidPtr(co_pgf);
  lang = (GF_Language)PyCObject_AsVoidPtr(co_lang);
  cat = (GF_Type)PyCObject_AsVoidPtr(co_cat);
  GF_Tree *result = gf_parse(pgf, lang, cat, lexed);
  GF_Tree *p = result;
  PyObject *parsed = PyList_New(0);
  if (*p) {
    do {
      GF_Expr exp = *(p++);
      PyObject *co_exp = PyCObject_FromVoidPtr(exp,gf_freeExpr);
      PyList_Append(parsed, co_exp);
      /*      char *str = gf_showExpr(exp);
      puts(str);
      free(str); */
    } while (*p);
  }
  return parsed;
}





static PyMethodDef GfMethods[] = {
  {"read_pgf", readPGF, METH_VARARGS,
   "Read pgf file"},
  {"read_lang", readLanguage, METH_VARARGS,
   "Get language from pgf."},
  {"startcat", startCat, METH_VARARGS,
   "Get start category from pgf."},
  {"parse", parse, METH_VARARGS,
   "Parse string for language and given start category."},
  {"show_expr", showExpr, METH_VARARGS,
   "show an expression."},
  {NULL, NULL, 0, NULL}
} ;

PyMODINIT_FUNC
initgf(void)
{
  PyObject *m = Py_InitModule("gf", GfMethods);
  static char *argv[] = { "gf.so", 0 }, **argv_ = argv;
  static int argc = 1;

  gf_init (&argc, &argv_);
  hs_add_root (CAT (__stginit_, MODULE));
  printf("Started gf\n");
  if (m == NULL) return;

  /* gfError = PyErr_NewException("gf.error", NULL, NULL);
  Py_INCREF(gfError);
  PyModule_AddObject(m, "error", gfError);
  */
}
