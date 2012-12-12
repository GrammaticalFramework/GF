#include <Python.h>
#include "structmember.h"

#include <gu/mem.h>
#include <gu/map.h>
#include <gu/file.h>
#include <pgf/pgf.h>

static PyObject* PGFError;

static PyObject*
gu2py_string(GuString s) {
	GuWord w = s.w_;
	uint8_t buf[sizeof(GuWord)];

	char* src;
	size_t len;
	if (w & 1) {
		len = (w & 0xff) >> 1;
		gu_assert(len <= sizeof(GuWord));
		size_t i = len;
		while (i > 0) {
			w >>= 8;
			buf[--i] = w & 0xff;
		}
		src = (char*) buf;
	} else {
		uint8_t* p = (void*) w;
		len = (p[0] == 0) ? ((size_t*) p)[-1] : p[0];
		src = (char*) &p[1];
	}

	return PyString_FromStringAndSize(src, len);
}

typedef struct {
    PyObject_HEAD
    PyObject* grammar;
    PgfConcr* concr;
} ConcrObject;

static PyObject *
Concr_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
    ConcrObject* self = (ConcrObject *)type->tp_alloc(type, 0);
    if (self != NULL) {
		self->grammar = NULL;
		self->concr   = NULL;
    }

    return (PyObject *)self;
}

static void
Concr_dealloc(ConcrObject* self)
{
	Py_XDECREF(self->grammar);
    self->ob_type->tp_free((PyObject*)self);
}

static int
Concr_init(ConcrObject *self, PyObject *args, PyObject *kwds)
{
    return -1;
}

static PyObject*
Concr_printName(ConcrObject* self, PyObject *args)
{
	const char *name_s;
    if (!PyArg_ParseTuple(args, "s", &name_s))
        return NULL;

	GuPool *tmp_pool = gu_local_pool();
    GuString name = gu_str_string(name_s, tmp_pool);

	return gu2py_string(pgf_print_name(self->concr, name));
}

static PyMethodDef Concr_methods[] = {
    {"printName", (PyCFunction)Concr_printName, METH_VARARGS,
     "Return the print name of a function or category"
    },
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_ConcrType = {
    PyObject_HEAD_INIT(NULL)
    0,                         /*ob_size*/
    "pgf.Concr",               /*tp_name*/
    sizeof(ConcrObject),       /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)Concr_dealloc, /*tp_dealloc*/
    0,                         /*tp_print*/
    0,                         /*tp_getattr*/
    0,                         /*tp_setattr*/
    0,                         /*tp_compare*/
    0,                         /*tp_repr*/
    0,                         /*tp_as_number*/
    0,                         /*tp_as_sequence*/
    0,                         /*tp_as_mapping*/
    0,                         /*tp_hash */
    0,                         /*tp_call*/
    0,                         /*tp_str*/
    0,                         /*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "concrete syntax object",  /*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    0,		                   /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    0,		                   /*tp_iter */
    0,		                   /*tp_iternext */
    Concr_methods,             /*tp_methods */
    0,                         /*tp_members */
    0,                         /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    (initproc)Concr_init,      /*tp_init */
    0,                         /*tp_alloc */
    Concr_new,                 /*tp_new */
};

typedef struct {
    PyObject_HEAD
    GuPool* pool;
    PgfPGF* pgf;
} PGFObject;

static PyObject *
PGF_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
    PGFObject* self = (PGFObject *)type->tp_alloc(type, 0);
    if (self != NULL) {
		self->pool = NULL;
		self->pgf  = NULL;
    }

    return (PyObject *)self;
}

static void
PGF_dealloc(PGFObject* self)
{
	if (self->pool != NULL)
		gu_pool_free(self->pool);
    self->ob_type->tp_free((PyObject*)self);
}

static int
PGF_init(PGFObject *self, PyObject *args, PyObject *kwds)
{
    return -1;
}

static PyObject*
PGF_getAbstractName(PGFObject *self, void *closure)
{
    return gu2py_string(pgf_abstract_name(self->pgf));
}

typedef struct {
	GuMapItor fn;
	PyObject* grammar;
	PyObject* object;
} PyPGFClosure;

static void
pgf_collect_langs(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCId name = *((PgfCId*) key);
    PgfConcr* concr = *((PgfConcr**) value);
    PyPGFClosure* clo = (PyPGFClosure*) fn;
    
    PyObject* py_name = NULL;
    PyObject* py_lang = NULL;
    
	py_name = gu2py_string(name);
	if (py_name == NULL) {
		gu_raise(err, PgfExn);
		goto end;
	}

	py_lang = pgf_ConcrType.tp_alloc(&pgf_ConcrType, 0);
	if (py_lang == NULL) {
		gu_raise(err, PgfExn);
		goto end;
	}

	((ConcrObject *) py_lang)->concr = concr;
	((ConcrObject *) py_lang)->grammar = clo->grammar;
	Py_INCREF(clo->grammar);

    if (PyDict_SetItem(clo->object, py_name, py_lang) != 0) {
		gu_raise(err, PgfExn);
		goto end;
	}

end:
    Py_XDECREF(py_lang);
    Py_XDECREF(py_name);
}

static PyObject*
PGF_getLanguages(PGFObject *self, void *closure)
{
	PyObject* languages = PyDict_New();
	if (languages == NULL)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	PyPGFClosure clo = { { pgf_collect_langs }, (PyObject*) self, languages };
	pgf_iter_languages(self->pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(languages);
		return NULL;
	}

	PyObject* proxy = PyDictProxy_New(languages);
	
	Py_DECREF(languages);

    return proxy;
}

static void
pgf_collect_cats(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCId name = *((PgfCId*) key);
    PyPGFClosure* clo = (PyPGFClosure*) fn;
    
    PyObject* py_name = NULL;
    
	py_name = gu2py_string(name);
	if (py_name == NULL) {
		gu_raise(err, PgfExn);
		goto end;
	}

    if (PyList_Append(clo->object, py_name) != 0) {
		gu_raise(err, PgfExn);
		goto end;
	}

end:
    Py_XDECREF(py_name);
}

static PyObject*
PGF_getCategories(PGFObject *self, void *closure)
{
	PyObject* categories = PyList_New(0);
	if (categories == NULL)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	PyPGFClosure clo = { { pgf_collect_cats }, (PyObject*) self, categories };
	pgf_iter_categories(self->pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(categories);
		return NULL;
	}

    return categories;
}

static PyObject*
PGF_getStartCat(PGFObject *self, void *closure)
{
	GuPool* tmp_pool = gu_local_pool();
    return gu2py_string(pgf_start_cat(self->pgf, tmp_pool));
}

static void
pgf_collect_funs(GuMapItor* fn, const void* key, void* value, GuExn* err)
{
	PgfCId name = *((PgfCId*) key);
    PyPGFClosure* clo = (PyPGFClosure*) fn;
    
    PyObject* py_name = NULL;
    
	py_name = gu2py_string(name);
	if (py_name == NULL) {
		gu_raise(err, PgfExn);
		goto end;
	}

    if (PyList_Append(clo->object, py_name) != 0) {
		gu_raise(err, PgfExn);
		goto end;
	}

end:
    Py_XDECREF(py_name);
}

static PyObject*
PGF_getFunctions(PGFObject *self, void *closure)
{
	PyObject* functions = PyList_New(0);
	if (functions == NULL)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	PyPGFClosure clo = { { pgf_collect_funs }, (PyObject*) self, functions };
	pgf_iter_functions(self->pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(functions);
		return NULL;
	}

    return functions;
}

static PyObject*
PGF_functionsByCat(PGFObject* self, PyObject *args)
{
	const char *catname_s;
    if (!PyArg_ParseTuple(args, "s", &catname_s))
        return NULL;

	GuPool *tmp_pool = gu_local_pool();
    GuString catname = gu_str_string(catname_s, tmp_pool);

	PyObject* functions = PyList_New(0);
	if (functions == NULL)
		return NULL;

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	PyPGFClosure clo = { { pgf_collect_funs }, (PyObject*) self, functions };
	pgf_iter_functions_by_cat(self->pgf, catname, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(functions);
		return NULL;
	}

    return functions;
}

static PyGetSetDef PGF_getseters[] = {
    {"abstractName", 
     (getter)PGF_getAbstractName, NULL,
     "the abstract syntax name",
     NULL},
    {"languages", 
     (getter)PGF_getLanguages, NULL,
     "a map containing all concrete languages in the grammar",
     NULL},
    {"categories", 
     (getter)PGF_getCategories, NULL,
     "a list containing all categories in the grammar",
     NULL},
    {"startCat", 
     (getter)PGF_getStartCat, NULL,
     "the start category for the grammar",
     NULL},
    {"functions", 
     (getter)PGF_getFunctions, NULL,
     "a list containing all functions in the grammar",
     NULL},
    {NULL}  /* Sentinel */
};

static PyMemberDef PGF_members[] = {
    {NULL}  /* Sentinel */
};

static PyMethodDef PGF_methods[] = {
    {"functionsByCat", (PyCFunction)PGF_functionsByCat, METH_VARARGS,
     "Return the list of functions for a given category"
    },
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_PGFType = {
    PyObject_HEAD_INIT(NULL)
    0,                         /*ob_size*/
    "pgf.PGF",                 /*tp_name*/
    sizeof(PGFObject),         /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)PGF_dealloc,   /*tp_dealloc*/
    0,                         /*tp_print*/
    0,                         /*tp_getattr*/
    0,                         /*tp_setattr*/
    0,                         /*tp_compare*/
    0,                         /*tp_repr*/
    0,                         /*tp_as_number*/
    0,                         /*tp_as_sequence*/
    0,                         /*tp_as_mapping*/
    0,                         /*tp_hash */
    0,                         /*tp_call*/
    0,                         /*tp_str*/
    0,                         /*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "PGF object",              /*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    0,		                   /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    0,		                   /*tp_iter */
    0,		                   /*tp_iternext */
    PGF_methods,               /*tp_methods */
    PGF_members,               /*tp_members */
    PGF_getseters,             /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    (initproc)PGF_init,        /*tp_init */
    0,                         /*tp_alloc */
    PGF_new,                   /*tp_new */
};

static PyObject *
pgf_readPGF(PyObject *self, PyObject *args)
{
    const char *fpath;
    if (!PyArg_ParseTuple(args, "s", &fpath))
        return NULL;

	PGFObject* py_pgf = (PGFObject*) pgf_PGFType.tp_alloc(&pgf_PGFType, 0);
	py_pgf->pool = gu_new_pool();

	GuPool* tmp_pool = gu_local_pool();

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	// Read the PGF grammar.
	py_pgf->pgf = pgf_read(fpath, py_pgf->pool, err);
	if (!gu_ok(err)) {
		PyErr_SetString(PGFError, "The grammar cannot be loaded");
		Py_DECREF(py_pgf);
		return NULL;
	}

	return ((PyObject*) py_pgf);
}

static PyMethodDef module_methods[] = {
    {"readPGF",  pgf_readPGF, METH_VARARGS,
     "Reads a PGF file in the memory"},
    {NULL, NULL, 0, NULL}        /* Sentinel */
};

PyMODINIT_FUNC
initpgf(void)
{
    PyObject *m;

    if (PyType_Ready(&pgf_PGFType) < 0)
        return;

    if (PyType_Ready(&pgf_ConcrType) < 0)
        return;

    m = Py_InitModule("pgf", module_methods);
    if (m == NULL)
        return;
        
    PGFError = PyErr_NewException("pgf.error", NULL, NULL);
    Py_INCREF(PGFError);
    PyModule_AddObject(m, "error", PGFError);
    
    Py_INCREF(&pgf_PGFType);    
    Py_INCREF(&pgf_ConcrType);
}
