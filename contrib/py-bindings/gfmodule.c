#include <Python.h>
#include "pgf.h"

#define NEWOBJECT(OBJ, GFTYPE) typedef struct {\
  PyObject_HEAD \
  GFTYPE obj; \
} OBJ;
#define NEWTYPE(TYPE,NAME,OBJECT,DOC) static PyTypeObject TYPE = {\
  PyObject_HEAD_INIT(NULL)\
  0,                         /*ob_size*/\
  NAME,             /*tp_name*/\
  sizeof(OBJECT), /*tp_basicsize*/\
  0,                         /*tp_itemsize*/\
  0,                         /*tp_dealloc*/\
  0,                         /*tp_print*/\
  0,                         /*tp_getattr*/\
  0,                         /*tp_setattr*/\
  0,                         /*tp_compare*/\
  0,                         /*tp_repr*/\
  0,                         /*tp_as_number*/\
  0,                         /*tp_as_sequence*/\
  0,                         /*tp_as_mapping*/\
  0,                         /*tp_hash */\
  0,                         /*tp_call*/\
  0,                         /*tp_str*/\
  0,                         /*tp_getattro*/\
  0,                         /*tp_setattro*/\
  0,                         /*tp_as_buffer*/\
  Py_TPFLAGS_DEFAULT,        /*tp_flags*/\
  DOC,           /* tp_doc */\
};
#define NEWGF(OBJ,GFTYPE,TYPE,NAME,DOC) NEWOBJECT(OBJ,GFTYPE)	\
NEWTYPE(TYPE,NAME,OBJ,DOC)


NEWGF(PGFModule,GF_PGF,PGFType,"gf.pgf","PGF module")
NEWGF(Lang,GF_Language,LangType,"gf.lang","language")
NEWGF(gfType,GF_Type,gfTypeType,"gf.type","gf type")
NEWGF(Expr,GF_Expr,ExprType,"gf.expr","gf expression")


static PyObject*
PGF_repr(PGFModule* obj)
{
  return PyString_FromFormat("this is a PGF module");
}

static PGFModule*
readPGF(PyObject *self, PyObject *args)
{
  char *path;
  PGFModule *pgf;
  if (!PyArg_ParseTuple(args, "s", &path))
    return NULL;
  pgf = (PGFModule*)PGFType.tp_new(&PGFType,NULL,NULL);
  if (!pgf) return NULL;
  pgf->obj = gf_readPGF(path);
  return pgf;
}

static Lang*
readLang(PyObject *self, PyObject *args)
{
  char *langName;
  Lang *l;
  if (!PyArg_ParseTuple(args,"s",&langName))
    return NULL;
  l = (Lang*)LangType.tp_new(&LangType,NULL,NULL);
  if(!l) return NULL;
  l->obj = gf_readLanguage(langName);
  return l;
}

int
checkType(PyObject* obj, PyTypeObject* tp)
{
	int isRight = PyObject_TypeCheck(obj, tp);
	if (!isRight)
		PyErr_Format(PyExc_TypeError, "Expected a %s", tp->tp_doc);
	return isRight;
}

static gfType*
startCategory(PyObject *self, PyObject *args)
{
  gfType *cat;
  PyObject *pgf_obj;
  if (!PyArg_ParseTuple(args,"O",&pgf_obj))
    return NULL;	
  if (!checkType(pgf_obj, &PGFType)) return NULL;
  cat = (gfType*)gfTypeType.tp_new(&gfTypeType,NULL,NULL);
  GF_PGF pgf = ((PGFModule*)pgf_obj)->obj;
  cat->obj = gf_startCat(pgf);
  return cat;
}

    

static PyObject*
parse(PyObject *self, PyObject *args)
{
	PyObject *pgf_pyob, *lang_pyob, *cat_pyob;
	GF_PGF pgf;
	GF_Language lang;
	GF_Type cat;
	char *lexed;
	if (!PyArg_ParseTuple(args, "OOOs", &pgf_pyob, &lang_pyob, &cat_pyob, &lexed))
    	return NULL;
	if (!checkType(pgf_pyob, &PGFType)) return NULL;	
	if (!checkType(lang_pyob, &LangType)) return NULL;
	if (!checkType(cat_pyob, &gfTypeType)) return NULL;
	pgf = ((PGFModule*)pgf_pyob)->obj;
	lang = ((Lang*)lang_pyob)->obj;
	cat = ((gfType*)cat_pyob)->obj;
	GF_Tree *result = gf_parse(pgf, lang, cat, lexed);
	GF_Tree *p = result;
	PyObject *parsed = PyList_New(0);
	if (*p) {
    	do {
			Expr* expr;
			expr = (Expr*)ExprType.tp_new(&ExprType,NULL,NULL);
			expr->obj = *(p++);
      		PyList_Append(parsed, (PyObject*)expr);
      /*      char *str = gf_showExpr(exp);
      puts(str);
      free(str); */
    	} while (*p);
  	}
  return parsed;
}

static PyObject*
expr_repr(Expr *self)
{
	const char *str = gf_showExpr(self->obj);
 	return PyString_FromString(str);
}


    
    
      


static PyMethodDef gf_methods[] = {
  {"read_pgf", (PyCFunction)readPGF, METH_VARARGS,"Read pgf file."},
  {"read_language", (PyCFunction)readLang, METH_VARARGS,"Get the language."},
  {"startcat", (PyCFunction)startCategory, METH_VARARGS,"Get the start category of a pgf module."},
  {"parse", (PyCFunction)parse, METH_VARARGS,"parse a string."},
  {NULL, NULL, 0, NULL}  /* Sentinel */
};

#ifndef PyMODINIT_FUNC/* declarations for DLL import/export */
#define PyMODINIT_FUNC void
#endif

PyMODINIT_FUNC
initgf(void) 
{
  PyObject* m;
#define READYTYPE(t) t.tp_new = PyType_GenericNew;\
	if (PyType_Ready(&t) < 0) return;

	PGFType.tp_repr = (reprfunc)PGF_repr;
	READYTYPE(PGFType)
	READYTYPE(LangType)
	READYTYPE(gfTypeType)
  	ExprType.tp_repr = (reprfunc)expr_repr;
	READYTYPE(ExprType)

  m = Py_InitModule3("gf", gf_methods,
		     "Grammatical Framework.");
  static char *argv[] = {"gf.so", 0}, **argv_ = argv;
  static int argc = 1;
  gf_init (&argc, &argv_);
  hs_add_root (__stginit_PGFFFI);

#define ADDTYPE(t) Py_INCREF(&t);\
PyModule_AddObject(m, "gf", (PyObject *)&t);

	ADDTYPE(PGFType)
	ADDTYPE(LangType)
	ADDTYPE(gfTypeType)
	ADDTYPE(ExprType)
}
