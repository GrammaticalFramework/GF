#include <Python.h>
#include "structmember.h"

#include <gu/mem.h>
#include <gu/map.h>
#include <gu/file.h>
#include <pgf/pgf.h>
#include <pgf/lexer.h>
#include <pgf/linearizer.h>

static PyObject* PGFError;

static PyObject* ParseError;

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
    GuPool* pool;
    PgfPGF* pgf;
} PGFObject;

typedef struct {
	PyObject_HEAD
	PyObject* master;
	GuPool* pool;
    PgfExpr expr;
} ExprObject;

static ExprObject*
Expr_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
    ExprObject* self = (ExprObject *)type->tp_alloc(type, 0);
    if (self != NULL) {
		self->master = NULL;
		self->pool   = NULL;
		self->expr   = gu_null_variant;
    }

    return self;
}

static void
Expr_dealloc(ExprObject* self)
{
	if (self->master != NULL) {
		Py_DECREF(self->master);
	}
	if (self->pool != NULL) {
		gu_pool_free(self->pool);
	}

    self->ob_type->tp_free((PyObject*)self);
}

static PyObject*
Expr_getattro(ExprObject *self, PyObject *attr_name);

static int
Expr_initMeta(ExprObject *self);

static int
Expr_initLiteral(ExprObject *self, PyObject *lit);

static int
Expr_initApp(ExprObject *self, const char* fname, PyObject *args);

static PyObject*
Expr_unpack(ExprObject* self, PyObject *args);

static int
Expr_init(ExprObject *self, PyObject *args, PyObject *kwds)
{
	Py_ssize_t tuple_size = PyTuple_Size(args);

	if (tuple_size == 0) {
		return Expr_initMeta(self);
	} else if (tuple_size == 1) {
		PyObject* lit = NULL;
		if (!PyArg_ParseTuple(args, "O", &lit))
			return -1;
		return Expr_initLiteral(self, lit);
	} else if (tuple_size == 2) {
		const char* fname;
		PyObject* list = NULL;
		if (!PyArg_ParseTuple(args, "sO!", &fname, &PyList_Type, &list))
			return -1;
		return Expr_initApp(self, fname, list);
	} else {
		PyErr_Format(PyExc_TypeError, "function takes 0, 1 or 2 arguments (%d given)", tuple_size);
		return -1;
	}
	
	return 0;
}

static PyObject *
Expr_repr(ExprObject *self)
{
	GuPool* tmp_pool = gu_local_pool();

	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);
	GuStringBuf* sbuf = gu_string_buf(tmp_pool);
	GuWriter* wtr = gu_string_buf_writer(sbuf);

	pgf_print_expr(self->expr, 0, wtr, err);

	GuString str = gu_string_buf_freeze(sbuf, tmp_pool);
	PyObject* pystr = gu2py_string(str);
	
	gu_pool_free(tmp_pool);
	return pystr;
}

PyObject *
Expr_richcompare(ExprObject *e1, ExprObject *e2, int op)
{
	bool cmp = pgf_expr_eq(e1->expr,e2->expr);
	
	if (op == Py_EQ)
		return cmp ? Py_True : Py_False;
	else if (op == Py_NE)
		return cmp ? Py_False : Py_True;
	else {
		PyErr_SetString(PyExc_TypeError, "the operation is not supported");
		return NULL;
	}
}

static PyMethodDef Expr_methods[] = {
    {"unpack", (PyCFunction)Expr_unpack, METH_VARARGS,
     "Decomposes an expression into its components"
    },
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_ExprType = {
    PyObject_HEAD_INIT(NULL)
    0,                         /*ob_size*/
    "pgf.Expr",                /*tp_name*/
    sizeof(ExprObject),        /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)Expr_dealloc,  /*tp_dealloc*/
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
    (reprfunc) Expr_repr,      /*tp_str*/
    (getattrofunc) Expr_getattro,/*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "abstract syntax tree",    /*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    (richcmpfunc) Expr_richcompare, /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    0,		                   /*tp_iter */
    0,		                   /*tp_iternext */
    Expr_methods,              /*tp_methods */
    0,                         /*tp_members */
    0,                         /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    (initproc)Expr_init,       /*tp_init */
    0,                         /*tp_alloc */
    (newfunc) Expr_new,        /*tp_new */
};

static int
Expr_initMeta(ExprObject *self)
{
	self->master = NULL;
	self->pool = gu_new_pool();
	PgfExprMeta* e =
		gu_new_variant(PGF_EXPR_META,
					   PgfExprMeta,
					   &self->expr, self->pool);
	e->id = 0;
	return 0;
}

static int
Expr_initLiteral(ExprObject *self, PyObject *lit)
{
	self->master = NULL;
	self->pool   = gu_new_pool();
	PgfExprLit* e =
		gu_new_variant(PGF_EXPR_LIT,
					   PgfExprLit,
					   &self->expr, self->pool);
	e->lit = gu_null_variant;

	if (PyString_Check(lit)) {
		PgfLiteralStr* slit =
			gu_new_variant(PGF_LITERAL_STR,
			               PgfLiteralStr,
			               &e->lit, self->pool);
		slit->val = gu_str_string(PyString_AsString(lit), self->pool);
	} else if (PyInt_Check(lit)) {
		PgfLiteralInt* ilit =
			gu_new_variant(PGF_LITERAL_INT,
			               PgfLiteralInt,
			               &e->lit, self->pool);
		ilit->val = PyInt_AsLong(lit);
	} else if (PyFloat_Check(lit)) {
		PgfLiteralFlt* flit =
			gu_new_variant(PGF_LITERAL_FLT,
			               PgfLiteralFlt,
			               &e->lit, self->pool);
		flit->val = PyFloat_AsDouble(lit);
	} else {
		PyErr_SetString(PyExc_TypeError, "the literal must be a string, an integer, or a float");
		return -1;
	}
	return 0;
}

static int
Expr_initApp(ExprObject *self, const char* fname, PyObject *args)
{
	Py_ssize_t n_args = PyList_Size(args);

	self->master = PyTuple_New(n_args);
	if (self->master == NULL)
		return -1;

	self->pool = gu_new_pool();
	PgfExprFun* e =
		gu_new_variant(PGF_EXPR_FUN,
					   PgfExprFun,
					   &self->expr, self->pool);
	e->fun = gu_str_string(fname, self->pool);

	for (Py_ssize_t i = 0; i < n_args; i++) {
		PyObject* obj = PyList_GetItem(args, i);
		if (obj->ob_type != &pgf_ExprType) {
			PyErr_SetString(PyExc_TypeError, "the arguments in the list must be expressions");
			return -1;
		}

		PyTuple_SetItem(self->master, i, obj);
		Py_INCREF(obj);

		PgfExpr fun = self->expr;
		PgfExpr arg = ((ExprObject*) obj)->expr;

		PgfExprApp* e =
			gu_new_variant(PGF_EXPR_APP,
						   PgfExprApp,
						   &self->expr, self->pool);
		e->fun = fun;
		e->arg = arg;
	}
	
	return 0;
}

static PyObject*
Expr_unpack(ExprObject* self, PyObject *fargs)
{
	PgfExpr expr = self->expr;
	PyObject* args = PyList_New(0);

	for (;;) {
		GuVariantInfo i = gu_variant_open(expr);
		switch (i.tag) {
		case PGF_EXPR_APP: {
			PgfExprApp* eapp = i.data;
			
			ExprObject* pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
			if (pyexpr == NULL)
				return NULL;
			pyexpr->pool   = NULL;
			pyexpr->master = (self->master) ? self->master : (PyObject*) self;
			pyexpr->expr   = eapp->arg;
			Py_INCREF(pyexpr->master);

			if (PyList_Insert(args, 0, (PyObject*) pyexpr) == -1) {
				Py_DECREF(args);
				return NULL;
			}

			Py_DECREF((PyObject*) pyexpr);

			expr = eapp->fun;
			break;
		}
		case PGF_EXPR_LIT: {
			PgfExprLit* elit = i.data;

			Py_DECREF(args);
			
			GuVariantInfo i = gu_variant_open(elit->lit);
			switch (i.tag) {
			case PGF_LITERAL_STR: {
				PgfLiteralStr* lstr = i.data;
				return gu2py_string(lstr->val);
			}
			case PGF_LITERAL_INT: {
				PgfLiteralInt* lint = i.data;
				return PyInt_FromLong(lint->val);
			}
			case PGF_LITERAL_FLT: {
				PgfLiteralFlt* lflt = i.data;
				return PyFloat_FromDouble(lflt->val);
			}
			default:
				gu_impossible();
				return NULL;
			}
		}
		case PGF_EXPR_META: {
			PyObject* res = Py_BuildValue("OO", Py_None, args);
			Py_DECREF(args);
			return res;
		}
		case PGF_EXPR_FUN: {
			PgfExprFun* efun = i.data;
			PyObject* fun = gu2py_string(efun->fun);
			PyObject* res = Py_BuildValue("OO", fun, args);
			Py_DECREF(fun);
			Py_DECREF(args);
			return res;
		}
		default:
			gu_impossible();
			return NULL;
		}
	}
	return NULL;
}

static PyObject*
Expr_getattro(ExprObject *self, PyObject *attr_name) {
	const char* name = PyString_AsString(attr_name);

    GuVariantInfo i = gu_variant_open(self->expr);
    switch (i.tag) {
	case PGF_EXPR_APP: {
		PgfExprApp* eapp = i.data;
		
		ExprObject* pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
		if (pyexpr == NULL)
			return NULL;
		pyexpr->pool   = NULL;
		pyexpr->master = (self->master) ? self->master : (PyObject*) self;
		pyexpr->expr   = gu_null_variant;
		Py_INCREF(pyexpr->master);

		if (strcmp(name, "fun") == 0) {
			pyexpr->expr = eapp->fun;
			return ((PyObject*) pyexpr);
		} else if (strcmp(name, "arg") == 0) {
			pyexpr->expr = eapp->arg;
			return ((PyObject*) pyexpr);
		} else {
			Py_DECREF(pyexpr);
		}
		break;
	}
	case PGF_EXPR_LIT: {
		PgfExprLit* elit = i.data;
		
		if (strcmp(name, "val") == 0) {
			GuVariantInfo i = gu_variant_open(elit->lit);
			switch (i.tag) {
			case PGF_LITERAL_INT: {
				PgfLiteralInt* lint = i.data;
				return PyInt_FromLong(lint->val);
			}
			case PGF_LITERAL_FLT: {
				PgfLiteralFlt* lflt = i.data;
				return PyFloat_FromDouble(lflt->val);
			}
			case PGF_LITERAL_STR: {
				PgfLiteralStr* lstr = i.data;
				return gu2py_string(lstr->val);
			}
			}
		}
		break;
	}
	case PGF_EXPR_META: {
		PgfExprMeta* emeta = i.data;
		if (strcmp(name, "id") == 0)
			return PyInt_FromLong(emeta->id);
		break;
	}
	case PGF_EXPR_FUN: {		
		PgfExprFun* efun = i.data;
		if (strcmp(name, "name") == 0) {
			return gu2py_string(efun->fun);
		}
		break;
	}
	default:
		gu_impossible();
	}

	return PyObject_GenericGetAttr((PyObject*)self, attr_name);
}

typedef struct IterObject {
    PyObject_HEAD
    PGFObject* grammar;
    PyObject* container;
    GuPool* pool;
    int max_count;
    int counter;
    GuEnum* res;
    PyObject* (*fetch)(struct IterObject* self);
} IterObject;

PyObject*
Iter_fetch_expr(IterObject* self)
{
	PgfExprProb* ep = gu_next(self->res, PgfExprProb*, self->pool);
	if (ep == NULL)
		return NULL;

	ExprObject* pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
	if (pyexpr == NULL)
		return NULL;
	pyexpr->pool   = NULL;
	pyexpr->expr   = ep->expr;
	pyexpr->master = self->container;
	Py_INCREF(self->container);

	PyObject* res = Py_BuildValue("(f,O)", ep->prob, pyexpr);
	Py_DECREF(pyexpr);

	return res;
}

PyObject*
Iter_fetch_token(IterObject* self)
{
	PgfTokenProb* tp = gu_next(self->res, PgfTokenProb*, self->pool);
	if (tp == NULL)
		return NULL;

	PyObject* ty_tok = gu2py_string(tp->tok);
	PyObject* res = Py_BuildValue("(f,O)", tp->prob, ty_tok);
	Py_DECREF(ty_tok);

	return res;
}

static IterObject*
Iter_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
    IterObject* self = (IterObject *)type->tp_alloc(type, 0);
    if (self != NULL) {
		self->grammar = NULL;
		self->container = NULL;
		self->pool = NULL;
		self->max_count = -1;
		self->counter   = 0;
		self->res  = NULL;
    }

    return self;
}

static void
Iter_dealloc(IterObject* self)
{
	if (self->pool != NULL)
		gu_pool_free(self->pool);

	Py_XDECREF(self->grammar);
	
	Py_XDECREF(self->container);

    self->ob_type->tp_free((PyObject*)self);
}

static int
Iter_init(IterObject *self, PyObject *args, PyObject *kwds)
{
    return -1;
}

static PyObject*
Iter_iter(IterObject *self)
{
	Py_INCREF(self);
	return (PyObject*) self;
}

static PyObject*
Iter_iternext(IterObject *self)
{
	if (self->max_count >= 0 && self->counter >= self->max_count) {
		return NULL;
	}
	self->counter++;

	return self->fetch(self);
}

static PyMethodDef Iter_methods[] = {
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_IterType = {
    PyObject_HEAD_INIT(NULL)
    0,                         /*ob_size*/
    "pgf.Iter",                /*tp_name*/
    sizeof(IterObject),        /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)Iter_dealloc,  /*tp_dealloc*/
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
    "an iterator over a sequence of expressions",/*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    0,		                   /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    (getiterfunc) Iter_iter,   /*tp_iter */
    (iternextfunc) Iter_iternext, /*tp_iternext */
    Iter_methods,              /*tp_methods */
    0,                         /*tp_members */
    0,                         /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    (initproc)Iter_init,       /*tp_init */
    0,                         /*tp_alloc */
    (newfunc) Iter_new,        /*tp_new */
};

typedef struct {
    PyObject_HEAD
    PGFObject* grammar;
    PgfConcr* concr;
} ConcrObject;

static ConcrObject*
Concr_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
    ConcrObject* self = (ConcrObject *)type->tp_alloc(type, 0);
    if (self != NULL) {
		self->grammar = NULL;
		self->concr   = NULL;
    }

    return self;
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
    PyObject* pyname = gu2py_string(pgf_print_name(self->concr, name));
	gu_pool_free(tmp_pool);

	return pyname;
}

typedef struct {
	PgfLexer base;
	PyObject* pylexer;
	GuPool* pool;
} PgfPythonLexer;

GU_DEFINE_TYPE(PyPgfLexerExn, abstract, _);

static PgfToken
pypgf_python_lexer_read_token(PgfLexer *base, GuExn* err)
{
	PgfPythonLexer* lexer = (PgfPythonLexer*) base;
	lexer->base.tok = gu_empty_string;

	PyObject* item = PyIter_Next(lexer->pylexer);
	if (item == NULL)
		if (PyErr_Occurred() != NULL)
			gu_raise(err, PyPgfLexerExn);
		else
			gu_raise(err, GuEOF);
	else {
		const char* str = PyString_AsString(item);
		if (str == NULL)
			gu_raise(err, PyPgfLexerExn);
		else
			lexer->base.tok = gu_str_string(str, lexer->pool);
	}

	return lexer->base.tok;
}

static PgfLexer*
pypgf_new_python_lexer(PyObject* pylexer, GuPool* pool)
{
	PgfPythonLexer* lexer = gu_new(PgfPythonLexer, pool);
	lexer->base.read_token = pypgf_python_lexer_read_token;
	lexer->base.tok = gu_empty_string;
	lexer->pylexer = pylexer;
	lexer->pool = pool;
	return ((PgfLexer*) lexer);
}

#define PGF_CONTAINER_NAME "pgf.Container"

void pypgf_container_descructor(PyObject *capsule)
{
	GuPool* pool = PyCapsule_GetPointer(capsule, PGF_CONTAINER_NAME);
	gu_pool_free(pool);
}

static IterObject*
Concr_parse(ConcrObject* self, PyObject *args, PyObject *keywds)
{
	static char *kwlist[] = {"sentence", "tokens", "cat", "n", NULL};

	size_t len;
	const uint8_t *buf = NULL;
	PyObject* py_lexer = NULL;
	const char *catname_s = NULL;
	int max_count = -1;
    if (!PyArg_ParseTupleAndKeywords(args, keywds, "|s#Osi", kwlist,
                                     &buf, &len, &py_lexer, &catname_s, &max_count))
        return NULL;

    if ((buf == NULL && py_lexer == NULL) || 
        (buf != NULL && py_lexer != NULL)) {
		PyErr_SetString(PyExc_TypeError, "either the sentence or the tokens argument must be provided");
		return NULL;
	}

	if (py_lexer != NULL) {
		// get an iterator out of the iterable object
		py_lexer = PyObject_GetIter(py_lexer);
		if (py_lexer == NULL)
			return NULL;
	}

	IterObject* pyres = (IterObject*) 
		pgf_IterType.tp_alloc(&pgf_IterType, 0);
	if (pyres == NULL) {
		Py_XDECREF(py_lexer);
		return NULL;
	}

	pyres->grammar = self->grammar;
	Py_XINCREF(pyres->grammar);

	GuPool* out_pool = gu_new_pool();
	
	PyObject* py_pool =
		PyCapsule_New(out_pool, PGF_CONTAINER_NAME, 
		              pypgf_container_descructor);
	pyres->container = PyTuple_Pack(2, pyres->grammar, py_pool);
	Py_DECREF(py_pool);

	pyres->pool      = gu_new_pool();
	pyres->max_count = max_count;
	pyres->counter   = 0;
	pyres->fetch     = Iter_fetch_expr;

    GuString catname =
		(catname_s == NULL) ? pgf_start_cat(self->grammar->pgf, pyres->pool)
		                    : gu_str_string(catname_s, pyres->pool);

	PgfLexer *lexer = NULL;
	if (buf != NULL) {
		GuIn* in = gu_data_in(buf, len, pyres->pool);
		GuReader* rdr = gu_new_utf8_reader(in, pyres->pool);
		lexer = pgf_new_simple_lexer(rdr, pyres->pool);
	} 
	if (py_lexer != NULL) {
		lexer = pypgf_new_python_lexer(py_lexer, pyres->pool);
	}

	pyres->res =
		pgf_parse(self->concr, catname, lexer, pyres->pool, out_pool);

	if (pyres->res == NULL) {
		Py_DECREF(pyres);
		pyres = NULL;

		PgfToken tok =
			pgf_lexer_current_token(lexer);

		if (gu_string_eq(tok, gu_empty_string))
			PyErr_SetString(PGFError, "The sentence cannot be parsed");
		else {
			PyObject* py_tok = gu2py_string(tok);
			PyObject_SetAttrString(ParseError, "token", py_tok);
			PyErr_Format(ParseError, "Unexpected token: \"%s\"", 
										PyString_AsString(py_tok));
			Py_DECREF(py_tok);
		}
	}

	Py_XDECREF(py_lexer);

	return pyres;
}

static IterObject*
Concr_getCompletions(ConcrObject* self, PyObject *args, PyObject *keywds)
{
	static char *kwlist[] = {"sentence", "tokens", "cat", 
	                         "prefix", "n", NULL};

	size_t len;
	const uint8_t *buf = NULL;
	PyObject* py_lexer = NULL;
	const char *catname_s = NULL;
	const char *prefix_s = NULL;
	int max_count = -1;
    if (!PyArg_ParseTupleAndKeywords(args, keywds, "|s#Ossi", kwlist,
                                     &buf, &len, &py_lexer, &catname_s,
                                     &prefix_s, &max_count))
        return NULL;

    if ((buf == NULL && py_lexer == NULL) || 
        (buf != NULL && py_lexer != NULL)) {
		PyErr_SetString(PyExc_TypeError, "either the sentence or the tokens argument must be provided");
		return NULL;
	}

	if (py_lexer != NULL) {
		// get an iterator out of the iterable object
		py_lexer = PyObject_GetIter(py_lexer);
		if (py_lexer == NULL)
			return NULL;
	}

	IterObject* pyres = (IterObject*) 
		pgf_IterType.tp_alloc(&pgf_IterType, 0);
	if (pyres == NULL) {
		Py_XDECREF(py_lexer);
		return NULL;
	}

	pyres->grammar = self->grammar;
	Py_XINCREF(pyres->grammar);
	
	pyres->container = NULL;

	pyres->pool = gu_new_pool();
	pyres->max_count = max_count;
	pyres->counter   = 0;
	pyres->fetch     = Iter_fetch_token;

	GuPool *tmp_pool = gu_local_pool();

    GuString catname =
		(catname_s == NULL) ? pgf_start_cat(self->grammar->pgf, tmp_pool)
		                    : gu_str_string(catname_s, tmp_pool);

    GuString prefix =
		(prefix_s == NULL) ? gu_empty_string
		                   : gu_str_string(prefix_s, pyres->pool);

	PgfLexer *lexer = NULL;
	if (buf != NULL) {
		GuIn* in = gu_data_in(buf, len, tmp_pool);
		GuReader* rdr = gu_new_utf8_reader(in, tmp_pool);
		lexer = pgf_new_simple_lexer(rdr, tmp_pool);
	} 
	if (py_lexer != NULL) {
		lexer = pypgf_new_python_lexer(py_lexer, tmp_pool);
	}

	pyres->res =
		pgf_get_completions(self->concr, catname, lexer, prefix, pyres->pool);

	if (pyres->res == NULL) {
		Py_DECREF(pyres);
		pyres = NULL;

		PgfToken tok =
			pgf_lexer_current_token(lexer);

		if (gu_string_eq(tok, gu_empty_string))
			PyErr_SetString(PGFError, "The sentence cannot be parsed");
		else {
			PyObject* py_tok = gu2py_string(tok);
			PyObject_SetAttrString(ParseError, "token", py_tok);
			PyErr_Format(ParseError, "Unexpected token: \"%s\"", 
										PyString_AsString(py_tok));
			Py_DECREF(py_tok);
		}
	}

	Py_XDECREF(py_lexer);
	gu_pool_free(tmp_pool);

	return pyres;
}

static PyObject*
Concr_parseval(ConcrObject* self, PyObject *args) {
	ExprObject* pyexpr = NULL;
	const char* s_cat = NULL;
	if (!PyArg_ParseTuple(args, "O!s", &pgf_ExprType, &pyexpr, &s_cat))
        return NULL;
        
    GuPool* tmp_pool = gu_local_pool();

    PgfCId cat = gu_str_string(s_cat, tmp_pool);

	double precision = 0;
	double recall = 0;
	double exact = 0;
	
    if (!pgf_parseval(self->concr, pyexpr->expr, cat, 
                      &precision, &recall, &exact))
		return NULL;

    gu_pool_free(tmp_pool);
    
    return Py_BuildValue("ddd", precision, recall, exact);
}

static PyObject*
Concr_addLiteral(ConcrObject* self, PyObject *args) {
	ExprObject* pyexpr = NULL;
	const char* s_cat = NULL;
	if (!PyArg_ParseTuple(args, "sO!", &s_cat, &pgf_ExprType, &pyexpr))
        return NULL;
/*
	PgfLiteralCallback* callback = NULL;

    GuPool* tmp_pool = gu_local_pool();

    PgfCId cat = gu_str_string(s_cat, tmp_pool);
    
	pgf_parser_add_literal(self->concr, cat, callback);

	gu_pool_free(tmp_pool);
*/
	Py_RETURN_NONE;
}

static PyObject*
Concr_linearize(ConcrObject* self, PyObject *args)
{
	ExprObject* pyexpr;
	if (!PyArg_ParseTuple(args, "O!", &pgf_ExprType, &pyexpr))
        return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);
	GuStringBuf* sbuf = gu_string_buf(tmp_pool);
	GuWriter* wtr = gu_string_buf_writer(sbuf);
	
	pgf_linearize(self->concr, pyexpr->expr, wtr, err);
	if (!gu_ok(err)) {
		PyErr_SetString(PGFError, "The abstract tree cannot be linearized");
		return NULL;
	}

	GuString str = gu_string_buf_freeze(sbuf, tmp_pool);
	PyObject* pystr = gu2py_string(str);
	
	gu_pool_free(tmp_pool);
	return pystr;
}

typedef struct {
	PyObject_HEAD
	PyObject* cat;
	int fid;
	int lindex;
	PyObject* fun;
	PyObject* children;
} BracketObject;

static void
Bracket_dealloc(BracketObject* self)
{
	Py_XDECREF(self->cat);
	Py_XDECREF(self->fun);
	Py_XDECREF(self->children);
    self->ob_type->tp_free((PyObject*)self);
}

static PyObject *
Bracket_repr(BracketObject *self)
{
	PyObject *repr =
		PyString_FromFormat("(%s:%d", PyString_AsString(self->cat), self->fid);
	if (repr == NULL) {
		return NULL;
	}

	PyObject *space = PyString_FromString(" ");

	size_t len = PyList_Size(self->children);
	for (size_t i = 0; i < len; i++) {
		PyObject *child = PyList_GetItem(self->children, i);

		PyString_Concat(&repr, space);
		if (repr == NULL) {
			Py_DECREF(space);
			return NULL;
		}

		PyObject *child_str = child->ob_type->tp_str(child);
		if (child_str == NULL) {
			Py_DECREF(repr);
			Py_DECREF(space);
			return NULL;
		}

		PyString_Concat(&repr, child_str);
		if (repr == NULL) {
			Py_DECREF(space);
			return NULL;
		}
	}
	
	Py_DECREF(space);

	PyObject *str = PyString_FromString(")");
	PyString_Concat(&repr, str);
	if (repr == NULL) {
		Py_DECREF(str);
		return NULL;
	}
	Py_DECREF(str);

	return repr;
}

static PyMemberDef Bracket_members[] = {
    {"cat", T_OBJECT_EX, offsetof(BracketObject, cat), READONLY,
     "the syntactic category for this bracket"},
    {"fun", T_OBJECT_EX, offsetof(BracketObject, fun), READONLY,
     "the abstract function for this bracket"},
    {"fid", T_INT, offsetof(BracketObject, fid), READONLY,
     "an unique id which identifies this bracket in the whole bracketed string"},
    {"lindex", T_INT, offsetof(BracketObject, lindex), READONLY,
     "the constituent index"},
    {"children", T_OBJECT_EX, offsetof(BracketObject, children), READONLY,
     "a list with the children of this bracket"},
    {NULL}  /* Sentinel */
};

static PyTypeObject pgf_BracketType = {
    PyObject_HEAD_INIT(NULL)
    0,                         /*ob_size*/
    "pgf.Bracket",             /*tp_name*/
    sizeof(BracketObject),     /*tp_basicsize*/
    0,                         /*tp_itemsize*/
    (destructor)Bracket_dealloc,/*tp_dealloc*/
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
    (reprfunc) Bracket_repr,   /*tp_str*/
    0,                         /*tp_getattro*/
    0,                         /*tp_setattro*/
    0,                         /*tp_as_buffer*/
    Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
    "a linearization bracket", /*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    0,		                   /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    0,		                   /*tp_iter */
    0,		                   /*tp_iternext */
    0,                         /*tp_methods */
    Bracket_members,           /*tp_members */
    0,                         /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    0,                         /*tp_init */
    0,                         /*tp_alloc */
    0,                         /*tp_new */
};

typedef struct {
	PgfLinFuncs* funcs;
	GuBuf* stack;
	PyObject* list;
} PgfBracketLznState;

static void
pgf_bracket_lzn_symbol_tokens(PgfLinFuncs** funcs, PgfTokens toks)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);

	size_t len = gu_seq_length(toks);
	for (size_t i = 0; i < len; i++) {
		PgfToken tok = gu_seq_get(toks, PgfToken, i);
		PyObject* str = gu2py_string(tok);
		PyList_Append(state->list, str);
		Py_DECREF(str);
	}
}

static void
pgf_bracket_lzn_expr_literal(PgfLinFuncs** funcs, PgfLiteral lit)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);

	GuVariantInfo i = gu_variant_open(lit);
    switch (i.tag) {
    case PGF_LITERAL_STR: {
        PgfLiteralStr* lstr = i.data;
        PyObject* str = gu2py_string(lstr->val);
		PyList_Append(state->list, str);
		Py_DECREF(str);
		break;
	}
    case PGF_LITERAL_INT: {
        PgfLiteralInt* lint = i.data;
        PyObject* str = PyString_FromFormat("%d", lint->val);
        PyList_Append(state->list, str);
        Py_DECREF(str);
		break;
	}
    case PGF_LITERAL_FLT: {
        PgfLiteralFlt* lflt = i.data;
        PyObject* str = PyString_FromFormat("%f", lflt->val);
        PyList_Append(state->list, str);
        Py_DECREF(str);
		break;
	}
	default:
		gu_impossible();
	}
}

static void
pgf_bracket_lzn_begin_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);
	
	gu_buf_push(state->stack, PyObject*, state->list);
	state->list = PyList_New(0);
}

static void
pgf_bracket_lzn_end_phrase(PgfLinFuncs** funcs, PgfCId cat, int fid, int lindex, PgfCId fun)
{
	PgfBracketLznState* state = gu_container(funcs, PgfBracketLznState, funcs);

	PyObject* parent = gu_buf_pop(state->stack, PyObject*);

	if (PyList_Size(state->list) > 0) {
		BracketObject* bracket = (BracketObject *)
			pgf_BracketType.tp_alloc(&pgf_BracketType, 0);
		if (bracket != NULL) {
			bracket->cat = gu2py_string(cat);
			bracket->fid = fid;
			bracket->lindex = lindex;
			bracket->fun = gu2py_string(fun);
			bracket->children = state->list;
			PyList_Append(parent, (PyObject*) bracket);
			Py_DECREF(bracket);
		}
	} else {
		Py_DECREF(state->list);
	}

	state->list = parent;
}

static PgfLinFuncs pgf_bracket_lin_funcs = {
	.symbol_tokens = pgf_bracket_lzn_symbol_tokens,
	.expr_literal  = pgf_bracket_lzn_expr_literal,
	.begin_phrase  = pgf_bracket_lzn_begin_phrase,
	.end_phrase    = pgf_bracket_lzn_end_phrase
};

static PyObject*
Concr_bracketedLinearize(ConcrObject* self, PyObject *args)
{
	ExprObject* pyexpr;
	if (!PyArg_ParseTuple(args, "O!", &pgf_ExprType, &pyexpr))
        return NULL;

	GuPool* tmp_pool = gu_local_pool();
	
	GuEnum* cts = 
		pgf_lzr_concretize(self->concr, pyexpr->expr, tmp_pool);
	PgfCncTree ctree = gu_next(cts, PgfCncTree, tmp_pool);
	if (gu_variant_is_null(ctree)) {
		PyErr_SetString(PGFError, "The abstract tree cannot be concretized");
		gu_pool_free(tmp_pool);
		return NULL;
	}
	
	PyObject* list = PyList_New(0);

	PgfBracketLznState state;
	state.funcs = &pgf_bracket_lin_funcs;
	state.stack = gu_new_buf(PyObject*, tmp_pool);
	state.list  = list;
	pgf_lzr_linearize(self->concr, ctree, 0, &state.funcs);

	gu_pool_free(tmp_pool);
	
	PyObject* bracket = NULL;
	if (PyList_Size(list) == 1) {
		bracket = PyList_GetItem(list, 0);
		Py_INCREF(bracket);
	} else {
		PyErr_SetString(PGFError, "The abstract tree cannot be linearized");
	}

	Py_DECREF(list);

	return bracket;
}

static PyObject*
Concr_getName(ConcrObject *self, void *closure)
{
    return gu2py_string(pgf_concrete_name(self->concr));
}

static PyGetSetDef Concr_getseters[] = {
    {"name", 
     (getter)Concr_getName, NULL,
     "the name of the concrete syntax",
    },
    {NULL}  /* Sentinel */
};

static PyMethodDef Concr_methods[] = {
    {"printName", (PyCFunction)Concr_printName, METH_VARARGS,
     "Returns the print name of a function or category"
    },
    {"parse", (PyCFunction)Concr_parse, METH_VARARGS | METH_KEYWORDS,
     "Parses a string and returns an iterator over the abstract trees for this sentence"
    },
    {"getCompletions", (PyCFunction)Concr_getCompletions, METH_VARARGS | METH_KEYWORDS,
     "Parses a partial string and returns a list with the top n possible next tokens"
    },
    {"parseval", (PyCFunction)Concr_parseval, METH_VARARGS,
     "Computes precision, recall and exact match for the parser on a given abstract tree"
    },
    {"addLiteral", (PyCFunction)Concr_addLiteral, METH_VARARGS,
     "adds callbacks for custom literals in the grammar"
    },
    {"linearize", (PyCFunction)Concr_linearize, METH_VARARGS,
     "Takes an abstract tree and linearizes it to a string"
    },
    {"bracketedLinearize", (PyCFunction)Concr_bracketedLinearize, METH_VARARGS,
     "Takes an abstract tree and linearizes it to a bracketed string"
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
    "concrete syntax",         /*tp_doc*/
    0,		                   /*tp_traverse */
    0,		                   /*tp_clear */
    0,		                   /*tp_richcompare */
    0,		                   /*tp_weaklistoffset */
    0,		                   /*tp_iter */
    0,		                   /*tp_iternext */
    Concr_methods,             /*tp_methods */
    0,                         /*tp_members */
    Concr_getseters,           /*tp_getset */
    0,                         /*tp_base */
    0,                         /*tp_dict */
    0,                         /*tp_descr_get */
    0,                         /*tp_descr_set */
    0,                         /*tp_dictoffset */
    (initproc)Concr_init,      /*tp_init */
    0,                         /*tp_alloc */
    (newfunc)Concr_new,        /*tp_new */
};

static void
PGF_dealloc(PGFObject* self)
{
	if (self->pool != NULL)
		gu_pool_free(self->pool);
    self->ob_type->tp_free((PyObject*)self);
}

static PyObject*
PGF_getAbstractName(PGFObject *self, void *closure)
{
    return gu2py_string(pgf_abstract_name(self->pgf));
}

typedef struct {
	GuMapItor fn;
	PGFObject* grammar;
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

	PyPGFClosure clo = { { pgf_collect_langs }, self, languages };
	pgf_iter_languages(self->pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(languages);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	PyObject* proxy = PyDictProxy_New(languages);
	
	Py_DECREF(languages);
	gu_pool_free(tmp_pool);

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

	PyPGFClosure clo = { { pgf_collect_cats }, self, categories };
	pgf_iter_categories(self->pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(categories);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
    return categories;
}

static PyObject*
PGF_getStartCat(PGFObject *self, void *closure)
{
	GuPool* tmp_pool = gu_local_pool();
	PyObject* pyname = gu2py_string(pgf_start_cat(self->pgf, tmp_pool));
	gu_pool_free(tmp_pool);
    return pyname;
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

	PyPGFClosure clo = { { pgf_collect_funs }, self, functions };
	pgf_iter_functions(self->pgf, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(functions);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
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
	if (functions == NULL) {
		gu_pool_free(tmp_pool);
		return NULL;
	}

	// Create an exception frame that catches all errors.
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	PyPGFClosure clo = { { pgf_collect_funs }, self, functions };
	pgf_iter_functions_by_cat(self->pgf, catname, &clo.fn, err);
	if (!gu_ok(err)) {
		Py_DECREF(functions);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
    return functions;
}

static IterObject*
PGF_generate(PGFObject* self, PyObject *args, PyObject *keywds)
{
	static char *kwlist[] = {"cat", "n", NULL};

	const char *catname_s;
	int max_count = -1;
    if (!PyArg_ParseTupleAndKeywords(args, keywds, "s|i", kwlist,
                                     &catname_s, &max_count))
        return NULL;

	IterObject* pyres = (IterObject*)
		pgf_IterType.tp_alloc(&pgf_IterType, 0);
	if (pyres == NULL) {
		return NULL;
	}

	pyres->grammar = self;
	Py_INCREF(self);

	pyres->pool = gu_new_pool();
	pyres->max_count = max_count;
	pyres->counter   = 0;
	pyres->fetch     = Iter_fetch_expr;

	GuPool *tmp_pool = gu_local_pool();
    GuString catname = gu_str_string(catname_s, tmp_pool);

	pyres->res =
		pgf_generate(self->pgf, catname, pyres->pool);
	if (pyres->res == NULL) {
		Py_DECREF(pyres);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);

	return pyres;
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
     "Returns the list of functions for a given category"
    },
    {"generate", (PyCFunction)PGF_generate, METH_VARARGS | METH_KEYWORDS,
     "Generates abstract syntax trees of given category in decreasing probability order"
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
    0,                         /*tp_init */
    0,                         /*tp_alloc */
    0,                         /*tp_new */
};

static PGFObject*
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
		if (gu_exn_caught(err) == gu_type(GuErrno)) {
			errno = *((GuErrno*) gu_exn_caught_data(err));
			PyErr_SetFromErrnoWithFilename(PyExc_IOError, fpath);
		} else {
			PyErr_SetString(PGFError, "The grammar cannot be loaded");
		}
		Py_DECREF(py_pgf);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
	return py_pgf;
}

static ExprObject*
pgf_readExpr(PyObject *self, PyObject *args) {
	size_t len;
    const uint8_t *buf;
    if (!PyArg_ParseTuple(args, "s#", &buf, &len))
        return NULL;

	ExprObject* pyexpr = (ExprObject*) pgf_ExprType.tp_alloc(&pgf_ExprType, 0);
	if (pyexpr == NULL)
		return NULL;

	GuPool* tmp_pool = gu_local_pool();
	GuIn* in = gu_data_in(buf, len, tmp_pool);
	GuExn* err = gu_new_exn(NULL, gu_kind(type), tmp_pool);

	pyexpr->pool = gu_new_pool();
	pyexpr->expr = pgf_read_expr(in, pyexpr->pool, err);
	pyexpr->master = NULL;
	
	if (!gu_ok(err) || gu_variant_is_null(pyexpr->expr)) {
		PyErr_SetString(PGFError, "The expression cannot be parsed");
		Py_DECREF(pyexpr);
		gu_pool_free(tmp_pool);
		return NULL;
	}

	gu_pool_free(tmp_pool);
    return pyexpr;
}

static PyMethodDef module_methods[] = {
    {"readPGF",  (void*)pgf_readPGF,  METH_VARARGS,
     "Reads a PGF file in the memory"},
    {"readExpr", (void*)pgf_readExpr, METH_VARARGS,
     "Parses a string as an abstract tree"},
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

    if (PyType_Ready(&pgf_BracketType) < 0)
        return;

    if (PyType_Ready(&pgf_ExprType) < 0)
        return;

	if (PyType_Ready(&pgf_IterType) < 0)
		return;

    m = Py_InitModule("pgf", module_methods);
    if (m == NULL)
        return;
        
    PGFError = PyErr_NewException("pgf.PGFError", NULL, NULL);
    PyModule_AddObject(m, "PGFError", PGFError);
    Py_INCREF(PGFError);
    
    PyObject *dict = PyDict_New();
    PyDict_SetItemString(dict, "token", PyString_FromString("")); 
    ParseError = PyErr_NewException("pgf.ParseError", NULL, dict);
    PyModule_AddObject(m, "ParseError", ParseError);
    Py_INCREF(ParseError);

    PyModule_AddObject(m, "Expr", (PyObject *) &pgf_ExprType);
    Py_INCREF(&pgf_ExprType);

    Py_INCREF(&pgf_PGFType);
    Py_INCREF(&pgf_ConcrType);
    Py_INCREF(&pgf_IterType);
    Py_INCREF(&pgf_BracketType);
}
